Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A35C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 14:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABB5225AE5
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 14:02:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABB5225AE5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sony.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934164AbeFYOCX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 10:02:23 -0400
Received: from seldsegrel01.sonyericsson.com ([37.139.156.29]:17668 "EHLO
        SELDSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755531AbeFYOCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 10:02:22 -0400
Subject: Re: [PATCH] mm,oom: Bring OOM notifier callbacks to outside of OOM
 killer.
To:     Michal Hocko <mhocko@kernel.org>
CC:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        <linux-mm@kvack.org>, <rientjes@google.com>,
        <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>
References: <1529493638-6389-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20180620115531.GL13685@dhcp22.suse.cz>
 <3d27f26e-68ba-d3c0-9518-cebeb2689aec@sony.com>
 <20180625130756.GK28965@dhcp22.suse.cz>
From:   peter enderborg <peter.enderborg@sony.com>
Message-ID: <4c6f9bd5-e959-c0bd-53db-988e07644754@sony.com>
Date:   Mon, 25 Jun 2018 16:02:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180625130756.GK28965@dhcp22.suse.cz>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/25/2018 03:07 PM, Michal Hocko wrote:
> On Mon 25-06-18 15:03:40, peter enderborg wrote:
>> On 06/20/2018 01:55 PM, Michal Hocko wrote:
>>> On Wed 20-06-18 20:20:38, Tetsuo Handa wrote:
>>>> Sleeping with oom_lock held can cause AB-BA lockup bug because
>>>> __alloc_pages_may_oom() does not wait for oom_lock. Since
>>>> blocking_notifier_call_chain() in out_of_memory() might sleep, sleeping
>>>> with oom_lock held is currently an unavoidable problem.
>>> Could you be more specific about the potential deadlock? Sleeping while
>>> holding oom lock is certainly not nice but I do not see how that would
>>> result in a deadlock assuming that the sleeping context doesn't sleep on
>>> the memory allocation obviously.
>> It is a mutex you are supposed to be able to sleep.  It's even exported.
> What do you mean? oom_lock is certainly not exported for general use. It
> is not local to oom_killer.c just because it is needed in other _mm_
> code.
>  

It  is in the oom.h file include/linux/oom.h, if it that sensitive it should
be in mm/ and a documented note about the special rules. It is only used
in drivers/tty/sysrq.c and that be replaced by a help function in mm that
do the  oom stuff.


>>>> As a preparation for not to sleep with oom_lock held, this patch brings
>>>> OOM notifier callbacks to outside of OOM killer, with two small behavior
>>>> changes explained below.
>>> Can we just eliminate this ugliness and remove it altogether? We do not
>>> have that many notifiers. Is there anything fundamental that would
>>> prevent us from moving them to shrinkers instead?
>>
>> @Hocko Do you remember the lowmemorykiller from android? Some things
>> might not be the right thing for shrinkers.
> Just that lmk did it wrong doesn't mean others have to follow.
>
If all you have is a hammer, everything looks like a nail. (I don’t argument that it was right)
But if you don’t have a way to interact with the memory system we will get attempts like lmk. 
Oom notifiers and vmpressure is for this task better than shrinkers.

