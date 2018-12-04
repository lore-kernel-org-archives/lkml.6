Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D9EEC04EB9
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 02:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 554572087F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 02:53:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 554572087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbeLDCxs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 21:53:48 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:38707 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725971AbeLDCxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 21:53:47 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07417;MF=xlpang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0TEowmpW_1543892012;
Received: from xunleideMacBook-Pro.local(mailfrom:xlpang@linux.alibaba.com fp:SMTPD_---0TEowmpW_1543892012)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 04 Dec 2018 10:53:33 +0800
Reply-To: xlpang@linux.alibaba.com
Subject: Re: [PATCH 3/3] mm/memcg: Avoid reclaiming below hard protection
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20181203080119.18989-1-xlpang@linux.alibaba.com>
 <20181203080119.18989-3-xlpang@linux.alibaba.com>
 <20181203115736.GQ31738@dhcp22.suse.cz>
From:   Xunlei Pang <xlpang@linux.alibaba.com>
Message-ID: <8d8e860d-f9a4-6708-ccab-d47180f0ad0a@linux.alibaba.com>
Date:   Tue, 4 Dec 2018 10:53:32 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <20181203115736.GQ31738@dhcp22.suse.cz>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/12/3 PM 7:57, Michal Hocko wrote:
> On Mon 03-12-18 16:01:19, Xunlei Pang wrote:
>> When memcgs get reclaimed after its usage exceeds min, some
>> usages below the min may also be reclaimed in the current
>> implementation, the amount is considerably large during kswapd
>> reclaim according to my ftrace results.
> 
> And here again. Describe the setup and the behavior please?
> 

step 1
mkdir -p /sys/fs/cgroup/memory/online
cd /sys/fs/cgroup/memory/online
echo 512M > memory.max
echo 409600000 > memory.min
echo $$ > tasks
dd if=/dev/sda of=/dev/null


while true; do sleep 1; cat memory.current ; cat memory.min; done


step 2
create global memory pressure by allocating annoymous and cached
pages to constantly trigger kswap: dd if=/dev/sdb of=/dev/null

step 3
Then observe "online" groups, hundreds of kbytes a little over
memory.min can cause tens of MiB to be reclaimed by kswapd.

Here is one of test results I got:
cat memory.current; cat memory.min; echo;
409485312   // current
409600000   // min

385052672   // See current got over reclaimed for 23MB
409600000   // min

Its corresponding ftrace output I monitored:
kswapd_0-281   [000] ....   304.706632: shrink_node_memcg:
min_excess=24, nr_reclaimed=6013, sc->nr_to_reclaim=1499997, exceeds
5989pages
