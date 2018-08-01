Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6CB5C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 07:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D5C020844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 07:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eYMwe0nz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D5C020844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387685AbeHAJmP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 05:42:15 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:37091 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732300AbeHAJmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 05:42:15 -0400
Received: by mail-pl0-f68.google.com with SMTP id d5-v6so2868133pll.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 00:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=tviqsjnYm6JkTD8v8bbf5gM3ouCSX3rUG3lP/f5N5go=;
        b=eYMwe0nzcZ7WpLcKE9rgjpcaFRJLj9sY2LcVA2yZUorAABiK3HOJy20/PQl5F9+NpO
         xQfOrKmoAfpjKJSNibuw4HW0Kobe8vH79/UXyCkwFWfgAXcxcih7/AahHPjqbIFISZDA
         ERx1R109UYQkCp02WyYm9X8BOMaOhts1F2K68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=tviqsjnYm6JkTD8v8bbf5gM3ouCSX3rUG3lP/f5N5go=;
        b=tjpGK3ocWVMErma4/LzIWsMV6iOxjjVST3XRZY0imQOC+39j4DH0PIq33o0VahJYWN
         Wc+/qW/LH0QPF9NqRlVAvsln9fRGsQfrOi3drNRjBR0drzKCseNS1DOWoisSWNQIEXuT
         koBW8Ij2qMGvVpuHuA47+6axPs5ZsXBmzIQzK8B4idfHIb2wO0/lFyxJjsQsPz+ctV95
         Z/6C9X+rCC7hrUN4KCaQdFI0IBIJk6/t+mAsc6HmkiaixOVXZYWqiVw+5zXrBVVJ/c6z
         kONoadTnDgUvdhaXWWK47ov3asMExRslYOBz7r7kmbR2YXSvVxH95TmlH+zIw1draQin
         kz+w==
X-Gm-Message-State: AOUpUlE/cNuE3WvaINNg3z+2NXFKIIv8f7+2bYoQLVWWQfXx6BnsK4U+
        DeE9o6kKWX/r4sW9eu6E6TOBlw==
X-Google-Smtp-Source: AAOMgpftsyoeqTZLNtPwS7Nkuc0aao6dJw1DULHnnQZr4BHK3nWr/d2WdA9Uw6zrh5iCLctz9magNA==
X-Received: by 2002:a17:902:b28c:: with SMTP id u12-v6mr23178323plr.16.1533110269530;
        Wed, 01 Aug 2018 00:57:49 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id k64-v6sm32130864pfg.141.2018.08.01.00.57.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 00:57:48 -0700 (PDT)
Date:   Wed, 1 Aug 2018 16:57:21 +0900
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     James Morse <james.morse@arm.com>
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        ard.biesheuvel@linaro.org, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 16/16] arm64: kexec_file: add kaslr support
Message-ID: <20180801075720.GM11258@linaro.org>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        James Morse <james.morse@arm.com>, catalin.marinas@arm.com,
        will.deacon@arm.com, dhowells@redhat.com, vgoyal@redhat.com,
        herbert@gondor.apana.org.au, davem@davemloft.net, dyoung@redhat.com,
        bhe@redhat.com, arnd@arndb.de, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, ard.biesheuvel@linaro.org,
        bhsharma@redhat.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180724065759.19186-1-takahiro.akashi@linaro.org>
 <20180724065759.19186-17-takahiro.akashi@linaro.org>
 <50b31f17-fc85-aa72-06f5-d3b62060a91f@arm.com>
 <20180727083104.GI11258@linaro.org>
 <405b6708-4518-d81e-3938-39032c2b487e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <405b6708-4518-d81e-3938-39032c2b487e@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

James,

All the changes mentioned below were applied to my coming v13.

On Fri, Jul 27, 2018 at 10:22:31AM +0100, James Morse wrote:
> Hi Akashi,
> 
> 
> On 07/27/2018 09:31 AM, AKASHI Takahiro wrote:
> >On Thu, Jul 26, 2018 at 02:40:49PM +0100, James Morse wrote:
> >>On 24/07/18 07:57, AKASHI Takahiro wrote:
> >>>Adding "kaslr-seed" to dtb enables triggering kaslr, or kernel virtual
> >>>address randomization, at secondary kernel boot.
> >>Hmm, there are three things that get moved by CONFIG_RANDOMIZE_BASE. The kernel
> >>physical placement when booted via the EFIstub, the kernel-text VAs and the
> >>location of memory in the linear-map region. Adding the kaslr-seed only does the
> >>last two.
> >Yes, but I think that I and Mark has agreed that "kaslr" meant
> >"virtual" randomisation, not including "physical" randomisation.
> Okay, I'll update my terminology!
> 
> 
> >>This means the physical placement of the new kernel is predictable from
> >>/proc/iomem ... but this also tells you the physical placement of the current
> >>kernel, so I don't think this is a problem.
> >>
> >>
> >>>We always do this as it will have no harm on kaslr-incapable kernel.
> >>>We don't have any "switch" to turn off this feature directly, but still
> >>>can suppress it by passing "nokaslr" as a kernel boot argument.
> >>
> >>>diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
> >>>index 7356da5a53d5..47a4fbd0dc34 100644
> >>>--- a/arch/arm64/kernel/machine_kexec_file.c
> >>>+++ b/arch/arm64/kernel/machine_kexec_file.c
> >>>@@ -158,6 +160,12 @@ static int setup_dtb(struct kimage *image,
> >>Don't you need to reserve some space in the area you vmalloc()d for the DT?
> >No, I don't think so.
> >All the data to be loaded are temporarily saved in kexec buffers,
> >which will eventually be copied to target locations in machine_kexec
> >(arm64_relocate_new_kernel, which, unlike its name, will handle
> >not only kernel but also other data as well).
> 
> I think we're speaking at cross purposes. Don't you need:
> 
> | buf_size += fdt_prop_len("kaslr―seed", sizeof(u64));
> 
> 
> You can't assume the existing DTB had a kaslr-seed property, and the
> difference may take us over a PAGE_SIZE boundary.

I see, I will add that.

> 
> >
> >>
> >>>+	/* add kaslr-seed */
> >>>+	get_random_bytes(&value, sizeof(value));
> >>What happens if the crng isn't ready?
> >>
> >>It looks like this will print a warning that these random-bytes aren't really up
> >>to standard, but the new kernel doesn't know this happened.
> >>
> >>crng_ready() isn't exposed, all we could do now is
> >>wait_for_random_bytes(), but that may wait forever because we do this
> >>unconditionally.
> >>
> >>I'd prefer to leave this feature until we can check crng_ready(), and skip
> >>adding a dodgy-seed if its not-ready. This avoids polluting the next-kernel's
> >>entropy pool.
> >OK. I would try to follow the same way as Bhupesh's userspace patch
> >does for kaslr-seed:
> >http://lists.infradead.org/pipermail/kexec/2018-April/020564.html
> 
> (I really don't understand this 'copying code from user-space' that happens
> with kexec_file_load)
> 
> 
> >   if (not found kaslr-seed in 1st kernel's dtb)
> >      don't care; go ahead
> 
> Don' t bother. As you say in the commit-message its harmless if the new
> kernel doesn't support it.
> Always having this would let you use kexec_file_load as a bootloader that
> can get the crng to
> provide decent entropy even if the platform bootloader can't.

OK, but anyway previous "kaslr-seed" will be dropped first.

> 
> >   else
> >      if (current kaslr-seed != 0)
> >         error
> 
> Don't bother. If this happens its a bug in another part of the kernel that
> doesn't affect this one. We aren't second-guessing the file-system when we
> read the kernel-fd, lets keep this simple.

OK

> >      if (crng_ready()) ; FIXME, it's a local macro
> >         get_random_bytes(non-blocking)
> >         set new kaslr-seed
> >      else
> >         error
> error? Something like pr_warn_once().

It was changed to pr_notice() since there is nothing wrong.

Thanks,
-Takahiro AKASHI

> I thought the kaslr-seed was added to the entropy pool, but now I look again
> I see its a separate EFI table. So the new kernel will add the same entropy
> ... that doesn't sound clever. (I can't see where its zero'd or
> re-initialised)
> 
> 
> 
> Thanks,
> 
> James
