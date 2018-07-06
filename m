Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C3BC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 23:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9657822528
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 23:10:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9657822528
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932812AbeGFXKX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 19:10:23 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:15950 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753631AbeGFXKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 19:10:22 -0400
Received: from fsav403.sakura.ne.jp (fsav403.sakura.ne.jp [133.242.250.102])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w66NAFtT066264;
        Sat, 7 Jul 2018 08:10:15 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav403.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav403.sakura.ne.jp);
 Sat, 07 Jul 2018 08:10:15 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav403.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w66NA7go066232
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sat, 7 Jul 2018 08:10:15 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] uts: Don't randomize "struct uts_namespace".
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>,
        Masaki Tachibana <mas-tachibana@vf.jp.nec.com>,
        Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1530871650-3582-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <CA+55aFzK5z4VQEMQAOqVHXpm+o_gd_eg5Vecck07E=WmoO6BFA@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <271dcdcd-d622-552c-338a-5eeca5e2b4a0@i-love.sakura.ne.jp>
Date:   Sat, 7 Jul 2018 08:10:08 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <CA+55aFzK5z4VQEMQAOqVHXpm+o_gd_eg5Vecck07E=WmoO6BFA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ken'ichi,

I noticed that makedumpfile ( https://sourceforge.net/p/makedumpfile/code/ )
can no longer detect kernel version correctly because "struct uts_namespace"
(which is exposed to userspace via vmcoreinfo) is subjected to randomization
by GCC_PLUGIN_RANDSTRUCT kernel config option since 4.13.

The code was introduced by below commit.

  commit bfc8fe181c822ad0d8495ceda3c7109a407192f0
  Author: ken1_ohmichi <ken1_ohmichi>
  Date:   Fri Dec 22 07:41:14 2006 +0000

      linux-2.6.19 support.
      On linux-2.6.18 or former, the release information could be gotten from
      the symbol "system_utsname". But on linux-2.6.19, it can be done from the
      symbol "init_uts_ns". A new makedumpfile can get the release information
      from the existing symbol.

Can you detect kernel version without using "struct uts_namespace" ?

On 2018/07/07 1:11, Linus Torvalds wrote:
> On Fri, Jul 6, 2018 at 3:07 AM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>
>> I noticed that makedumpfile utility is failing to check kernel version, for
>> it depends on offset of "struct uts_namespace"->name being sizeof(int).
> 
> For something like this, we fix makedumpfile instead. This is not a
> "user program" using system calls etc, this is something that delves
> into the kernel dump and tries to make sense of it.
> 
> Where is the makedumpfile source code? What is it trying to do, and why?
> 
> One option is to just say "hey, you can't make much sense of a
> randomized kernel dump anyway, so don't even try".
> 
>                  Linus
> 

