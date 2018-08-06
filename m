Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2872C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6419C21A04
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:29:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6419C21A04
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731275AbeHFPiR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 11:38:17 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:26291 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727510AbeHFPiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 11:38:17 -0400
Received: from fsav301.sakura.ne.jp (fsav301.sakura.ne.jp [153.120.85.132])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w76DT8Sv049317;
        Mon, 6 Aug 2018 22:29:08 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav301.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav301.sakura.ne.jp);
 Mon, 06 Aug 2018 22:29:08 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav301.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w76DT2ju049280
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Mon, 6 Aug 2018 22:29:08 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v3 2/2] virtio_balloon: replace oom notifier with shrinker
To:     "Wang, Wei W" <wei.w.wang@intel.com>
Cc:     "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "mst@redhat.com" <mst@redhat.com>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
References: <1533285146-25212-1-git-send-email-wei.w.wang@intel.com>
 <1533285146-25212-3-git-send-email-wei.w.wang@intel.com>
 <16c56ee5-eef7-dd5f-f2b6-e3c11df2765c@i-love.sakura.ne.jp>
 <5B681B41.6070205@intel.com>
 <c8d25019-1990-f0dd-c83d-e4def5b5f7fe@i-love.sakura.ne.jp>
 <286AC319A985734F985F78AFA26841F7397222E8@SHSMSX101.ccr.corp.intel.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <109ff5ec-692d-67fe-4c5a-2de8b48e8300@i-love.sakura.ne.jp>
Date:   Mon, 6 Aug 2018 22:28:59 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <286AC319A985734F985F78AFA26841F7397222E8@SHSMSX101.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/08/06 21:44, Wang, Wei W wrote:
> On Monday, August 6, 2018 6:29 PM, Tetsuo Handa wrote:
>> On 2018/08/06 18:56, Wei Wang wrote:
>>> On 08/03/2018 08:11 PM, Tetsuo Handa wrote:
>>>> On 2018/08/03 17:32, Wei Wang wrote:
>>>>> +static int virtio_balloon_register_shrinker(struct virtio_balloon
>>>>> +*vb) {
>>>>> +    vb->shrinker.scan_objects = virtio_balloon_shrinker_scan;
>>>>> +    vb->shrinker.count_objects = virtio_balloon_shrinker_count;
>>>>> +    vb->shrinker.batch = 0;
>>>>> +    vb->shrinker.seeks = DEFAULT_SEEKS;
>>>> Why flags field is not set? If vb is allocated by kmalloc(GFP_KERNEL)
>>>> and is nowhere zero-cleared, KASAN would complain it.
>>>
>>> Could you point where in the code that would complain it?
>>> I only see two shrinker flags (NUMA_AWARE and MEMCG_AWARE), and
>> they seem not related to that.
>>
>> Where is vb->shrinker.flags initialized?
> 
> Is that mandatory to be initialized?

Of course. ;-)

> I find it's not initialized in most shrinkers (e.g. zs_register_shrinker, huge_zero_page_shrinker).

Because most shrinkers are "statically initialized (which means that unspecified fields are
implicitly zero-cleared)" or "dynamically allocated with __GFP_ZERO or zero-cleared using
memset() (which means that all fields are once zero-cleared)".

And if you once zero-clear vb at allocation time, you will get a bonus that
calling unregister_shrinker() without corresponding register_shrinker() is safe
(which will simplify initialization failure path).
