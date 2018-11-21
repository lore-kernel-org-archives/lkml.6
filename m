Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86CB8C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48E98214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="qy0j8aaj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48E98214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732986AbeKVEkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 23:40:22 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:56175 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729828AbeKVEkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 23:40:22 -0500
Received: by mail-it1-f195.google.com with SMTP id o19so10198081itg.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 10:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QFnVnYy/Mse61VfrIFMPnLmotD0iNr+SjQTZRsMZItk=;
        b=qy0j8aajKNnHac+ZI5sNLjBZRxxPXPcSGB40bhAFbj9fMsO1Vi7MXG4dOLMBHEwGXQ
         4W/qNdNv7v0I3g8BnmZsIbTIOytKU0OlNg4aWKFt8gDyu71SITQENBEO7hponLJQImAY
         drHCJervpnpHp4XlK7SMs9ImhdmaN3hvKN3kE0B8qAWNVPLp+4VIuiX/6B4oaJP7rRiW
         gh/iq1W0ksw51NcG8bT2siOsFrylfp0TB/c63OWCl82Mljv1lmr7Ig++n/pE2H4pViYj
         z4xlfpdRg1E5D0WNY6NiAIAwKJjTrfxhq/eIYHHV8xZVd4nxz6rtCzy6HhxnIaxAikA1
         MgJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QFnVnYy/Mse61VfrIFMPnLmotD0iNr+SjQTZRsMZItk=;
        b=CpDcnJWkv5keWKiowjdDAOBFTo+AZVlMcunvq3eLiLWn2Ht49ycvffskIpTu3HqqZF
         78ywWoT9wO8HIbDgMV6xAPvK+tBwNdWzOzf3VwlI52kmerGIGvQ9azihomii/yYlg3F0
         INbtvQ50g15CurzG9qD07iqTd3HDMW1Phuslq/FAOLI+o/X0kw5iyJKqa8qjUlACT4Vc
         hUn3yf4qyowkqf4FXSIPbOZucvytj4OqJG6D6BfMjruM0cJyf4DkxmhiWvnYIInODVkd
         M7G7q/IwMk7FpaT83IREcYYSgz1aVqAIfaJbSh1BB1o1cns5RYMdx38eojcwXO4V3JX0
         AsVQ==
X-Gm-Message-State: AGRZ1gJ1n/MaHx5rviB37JJsWUujsK/K+NExFNRrxjDIT/BDOCoT/1cG
        Gds6DivUsNWKuman+jMGd0ePkOBXeLE=
X-Google-Smtp-Source: AFSGD/Xh5wIgbExwGWLiWRgpIddBzknIGmAdwdx5AUz1fYfEoXTeM0g+ii1dzdVCTnYIolAN8fatfw==
X-Received: by 2002:a24:7c81:: with SMTP id a123-v6mr7021956itd.29.1542823497870;
        Wed, 21 Nov 2018 10:04:57 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id j17-v6sm635981itj.0.2018.11.21.10.04.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 10:04:56 -0800 (PST)
Subject: Re: [PATCH] x86: only use ERMS for user copies for larger sizes
To:     Linus Torvalds <torvalds@linux-foundation.org>, pabeni@redhat.com
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, bp@alien8.de,
        Peter Anvin <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>, dvlasenk@redhat.com,
        brgerst@gmail.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
References: <02bfc577-32a5-66be-64bf-d476b7d447d2@kernel.dk>
 <20181121063609.GA109082@gmail.com>
 <48e27a3a-2bb2-ff41-3512-8aeb3fd59e57@kernel.dk>
 <1c22125bb5d22c2dcd686d0d3b390f115894f746.camel@redhat.com>
 <CAHk-=wgnjB+=o0771=J_YkQzabU5aadh6pN3x9Vk4HPs3MHL3g@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <658cdb28-e3e5-c0af-368f-c26daf9986ac@kernel.dk>
Date:   Wed, 21 Nov 2018 11:04:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgnjB+=o0771=J_YkQzabU5aadh6pN3x9Vk4HPs3MHL3g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/21/18 10:27 AM, Linus Torvalds wrote:
> On Wed, Nov 21, 2018 at 5:45 AM Paolo Abeni <pabeni@redhat.com> wrote:
>>
>> In my experiments 64 bytes was the break even point for all the CPUs I
>> had handy, but I guess that may change with other models.
> 
> Note that experiments with memcpy speed are almost invariably broken.
> microbenchmarks don't show the impact of I$, but they also don't show
> the impact of _behavior_.
> 
> For example, there might be things like "repeat strings do cacheline
> optimizations" that end up meaning that cachelines stay in L2, for
> example, and are never brought into L1. That can be a really good
> thing, but it can also mean that now the result isn't as close to the
> CPU, and the subsequent use of the cacheline can be costlier.

Totally agree, which is why all my testing was NOT microbenchmarking.

> I say "go for upping the limit to 128 bytes".

See below...

> That said, if the aio user copy is _so_ critical that it's this
> noticeable, there may be other issues. Sometimes _real_ cost of small
> user copies is often the STAC/CLAC, more so than the "rep movs".
> 
> It would be interesting to know exactly which copy it is that matters
> so much...  *inlining* the erms case might show that nicely in
> profiles.

Oh I totally agree, which is why I since went a different route. The
copy that matters is the copy_from_user() of the iocb, which is 64
bytes. Even for 4k IOs, copying 64b per IO is somewhat counter
productive for O_DIRECT.

Playing around with this:

http://git.kernel.dk/cgit/linux-block/commit/?h=aio-poll&id=ed0a0a445c0af4cfd18b0682511981eaf352d483

since we're doing a new sys_io_setup2() for polled aio anyway. This
completely avoids the iocb copy, but that's just for my initial
particular gripe.


diff --git a/arch/x86/lib/copy_user_64.S b/arch/x86/lib/copy_user_64.S
index db4e5aa0858b..21c4d68c5fac 100644
--- a/arch/x86/lib/copy_user_64.S
+++ b/arch/x86/lib/copy_user_64.S
@@ -175,8 +175,8 @@ EXPORT_SYMBOL(copy_user_generic_string)
  */
 ENTRY(copy_user_enhanced_fast_string)
 	ASM_STAC
-	cmpl $64,%edx
-	jb .L_copy_short_string	/* less then 64 bytes, avoid the costly 'rep' */
+	cmpl $128,%edx
+	jb .L_copy_short_string	/* less then 128 bytes, avoid costly 'rep' */
 	movl %edx,%ecx
 1:	rep
 	movsb

-- 
Jens Axboe

