Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16CD5C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFAF5208E5
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:14:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFAF5208E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388922AbeGKPSs convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 11:18:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48350 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388906AbeGKPSr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 11:18:47 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 461854070489;
        Wed, 11 Jul 2018 15:13:59 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-175.bos.redhat.com [10.18.17.175])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 80C2D2166BA2;
        Wed, 11 Jul 2018 15:13:58 +0000 (UTC)
Subject: Re: [PATCH v6 0/7] fs/dcache: Track & limit # of negative dentries
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Kara <jack@suse.cz>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Larry Woodman <lwoodman@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        "Wangkai (Kevin C)" <wangkai86@huawei.com>
References: <1530905572-817-1-git-send-email-longman@redhat.com>
 <20180709081920.GD22049@dhcp22.suse.cz>
 <62275711-e01d-7dbe-06f1-bf094b618195@redhat.com>
 <20180710142740.GQ14284@dhcp22.suse.cz>
 <a2794bcc-9193-cbca-3a54-47420a2ab52c@redhat.com>
 <20180711102139.GG20050@dhcp22.suse.cz>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <9f24c043-1fca-ee86-d609-873a7a8f7a64@redhat.com>
Date:   Wed, 11 Jul 2018 11:13:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180711102139.GG20050@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 11 Jul 2018 15:13:59 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 11 Jul 2018 15:13:59 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'longman@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11/2018 06:21 AM, Michal Hocko wrote:
> On Tue 10-07-18 12:09:17, Waiman Long wrote:
>> On 07/10/2018 10:27 AM, Michal Hocko wrote:
>>> On Mon 09-07-18 12:01:04, Waiman Long wrote:
>>>> On 07/09/2018 04:19 AM, Michal Hocko wrote:
> [...]
>>>>> percentage has turned out to be a really wrong unit for many tunables
>>>>> over time. Even 1% can be just too much on really large machines.
>>>> Yes, that is true. Do you have any suggestion of what kind of unit
>>>> should be used? I can scale down the unit to 0.1% of the system memory.
>>>> Alternatively, one unit can be 10k/cpu thread, so a 20-thread system
>>>> corresponds to 200k, etc.
>>> I simply think this is a strange user interface. How much is a
>>> reasonable number? How can any admin figure that out?
>> Without the optional enforcement, the limit is essentially just a
>> notification mechanism where the system signals that there is something
>> wrong going on and the system administrator need to take a look. So it
>> is perfectly OK if the limit is sufficiently high that normally we won't
>> need to use that many negative dentries. The goal is to prevent negative
>> dentries from consuming a significant portion of the system memory.
> So again. How do you tell the right number?

I guess it will be more a trial and error kind of adjustment as the
right figure will depend on the kind of workloads being run on the
system. So unless the enforcement option is turned on, setting a limit
that is too small won't have too much impact over than a slight
performance drop because of the invocation of the slowpaths and the
warning messages in the console. Whenever a non-zero value is written
into "neg-dentry-limit", an informational message will be printed about
what the actual negative dentry limits
will be. It can be compared against the current negative dentry number
(5th number) from "dentry-state" to see if there is enough safe margin
to avoid false positive warning.

>
>> I am going to reduce the granularity of each unit to 1/1000 of the total
>> system memory so that for large system with TB of memory, a smaller
>> amount of memory can be specified.
> It is just a matter of time for this to be too coarse as well.

The goal is to not have too much memory being consumed by negative
dentries and also the limit won't be reached by regular daily
activities. So a limit of 1/1000 of the total system memory will be good
enough on large memory system even if the absolute number is really big.

Cheers,
Longman


