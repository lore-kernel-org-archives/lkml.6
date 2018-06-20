Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48AE5C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 12:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08DC120836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 12:21:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08DC120836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754313AbeFTMVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 08:21:38 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:31216 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754283AbeFTMVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 08:21:36 -0400
Received: from fsav302.sakura.ne.jp (fsav302.sakura.ne.jp [153.120.85.133])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w5KCLPCl088716;
        Wed, 20 Jun 2018 21:21:25 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav302.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav302.sakura.ne.jp);
 Wed, 20 Jun 2018 21:21:25 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav302.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w5KCLO6I088709
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 20 Jun 2018 21:21:25 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] mm,oom: Bring OOM notifier callbacks to outside of OOM
 killer.
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, rientjes@google.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <1529493638-6389-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20180620115531.GL13685@dhcp22.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <f6e65320-d8d3-f1ff-0346-13d1446c2675@i-love.sakura.ne.jp>
Date:   Wed, 20 Jun 2018 21:21:21 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180620115531.GL13685@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/06/20 20:55, Michal Hocko wrote:
> On Wed 20-06-18 20:20:38, Tetsuo Handa wrote:
>> Sleeping with oom_lock held can cause AB-BA lockup bug because
>> __alloc_pages_may_oom() does not wait for oom_lock. Since
>> blocking_notifier_call_chain() in out_of_memory() might sleep, sleeping
>> with oom_lock held is currently an unavoidable problem.
> 
> Could you be more specific about the potential deadlock? Sleeping while
> holding oom lock is certainly not nice but I do not see how that would
> result in a deadlock assuming that the sleeping context doesn't sleep on
> the memory allocation obviously.

"A" is "owns oom_lock" and "B" is "owns CPU resources". It was demonstrated
at "mm,oom: Don't call schedule_timeout_killable() with oom_lock held." proposal.

But since you don't accept preserving the short sleep which is a heuristic for
reducing the possibility of AB-BA lockup, the only way we would accept will be
wait for the owner of oom_lock (e.g. by s/mutex_trylock/mutex_lock/ or whatever)
which is free of heuristic and free of AB-BA lockup.

> 
>> As a preparation for not to sleep with oom_lock held, this patch brings
>> OOM notifier callbacks to outside of OOM killer, with two small behavior
>> changes explained below.
> 
> Can we just eliminate this ugliness and remove it altogether? We do not
> have that many notifiers. Is there anything fundamental that would
> prevent us from moving them to shrinkers instead?
> 

For long term, it would be possible. But not within this patch. For example,
I think that virtio_balloon wants to release memory only when we have no
choice but OOM kill. If virtio_balloon trivially releases memory, it will
increase the risk of killing the entire guest by OOM-killer from the host
side.

