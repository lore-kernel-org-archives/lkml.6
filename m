Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A9ECC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 14:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA63222427
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 14:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="psD8pb0s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA63222427
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753551AbeGCOV5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 10:21:57 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35998 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753194AbeGCOVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 10:21:55 -0400
Received: by mail-pf0-f196.google.com with SMTP id u16-v6so1104417pfh.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 07:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uRAL2HQz2koF7SwMUN+hWGE9rY7opahaDtowIcmdEcU=;
        b=psD8pb0sb2L6bnQ7cPjdLeuCOP1MWVvcoalAPBaY6hknUINtNeS0YYldedeXDvlLrE
         YrkHllvOHH2PTZS7AU3BAFeD4COmtd2OUph628SPXXjF3lIF9L4/zRtmLOMpm6edWGGj
         hjJvMncr81v5eBVYVKuq6jPwjHYrK3Pj4LJ23UR75iFKA/XptpPZTsf7z7OSjXqYgo+/
         inJZISxaKxVr/JXBc7Vkxp21LKn76m7jK319MR7/KLeXMIxUF711N+ejaDXjO8guDHzu
         M5sIMN/a73IrHy2y+6XDAfz4KzmaHo1h9EOGPY7YJJIOSImPyfEip6i3nqmOtIud3rAL
         qNzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uRAL2HQz2koF7SwMUN+hWGE9rY7opahaDtowIcmdEcU=;
        b=dfpNCVmp9wngy7vav3czOQq5miQGIq7lfc8VoHFkWGd4KqppUlqPUmoZ8i+IrMk6tU
         SLNluiRPA9Npo9cMuuvUvXiuNC5r2NvPx+Ozgd8pouhLzYD+PjL/x0tJdEf++hX/RXh4
         FMi+XaSN4WO/u0L9vIbb4V1LoxmPvEgXfJ37U/idTi2mtJ8zDmjjWO94T6CMLdhnGQ5u
         37W/aBGAcCsrBSGiB5ZWfWA7iViL0lvSgSHsAO82nQJPY9JRA7jAezUmurjzb8tu0RlH
         Y8qHQ409h7Voz1PDgaY4XIrwmktrpz7snI+dazJC6HhoAhIn6vEeqKl6FQ4cdM7V/vtT
         tAyg==
X-Gm-Message-State: APt69E3VjXhDlXjzd+WjG6CapPay++Hp3+x+zG2cwQT+RoALOMJbiSZW
        QSrOGrjjJmxwGA0vD31l5irtTw==
X-Google-Smtp-Source: ADUXVKJ7HnpwUHEkzOFo/2m1oZxPNJ2i1G1BGWOLf8kUOU1AZI0sn40uwOa9oi7qSu0d3JRURoKfbA==
X-Received: by 2002:a65:64d7:: with SMTP id t23-v6mr26498518pgv.207.1530627715380;
        Tue, 03 Jul 2018 07:21:55 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([134.134.139.83])
        by smtp.gmail.com with ESMTPSA id g10-v6sm3355723pgs.17.2018.07.03.07.21.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 07:21:54 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id C6D4930003D; Tue,  3 Jul 2018 17:21:50 +0300 (+03)
Date:   Tue, 3 Jul 2018 17:21:50 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Gabriel C <nix.or.die@gmail.com>
Cc:     Benjamin Gilbert <bgilbert@redhat.com>,
        linux-x86_64@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        bero@lindev.ch, Andi Kleen <ak@linux.intel.com>
Subject: Re: 4.17.x won't boot due to "x86/boot/compressed/64: Handle 5-level
 paging boot if kernel is above 4G"
Message-ID: <20180703142150.tqckl7miou3wf33q@kshutemo-mobl1>
References: <CAF=P+=5c-baQp-CK1ViG8h=mMRv6d3EgEsN_U4rbBx-Pwv_Krw@mail.gmail.com>
 <20180701213243.GA20180@trogon.sfo.coreos.systems>
 <CAEJqkghSELJRq7r_OrKvixxnT-rUncV==Ej1+jfYZvkMHz=o_w@mail.gmail.com>
 <20180703124403.veiak4vnbxtmwhv2@kshutemo-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703124403.veiak4vnbxtmwhv2@kshutemo-mobl1>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 03:44:03PM +0300, Kirill A. Shutemov wrote:
> On Tue, Jul 03, 2018 at 01:24:49PM +0200, Gabriel C wrote:
> > 2018-07-01 23:32 GMT+02:00 Benjamin Gilbert <bgilbert@redhat.com>:
> > > On Sun, Jul 01, 2018 at 05:15:59PM -0400, Benjamin Gilbert wrote:
> > >> 4.17 kernels built with the CoreOS Container Linux toolchain and kconfig,
> > >> up to and including 4.17.3, fail to boot on AMD64 running in (at least)
> > >> QEMU/KVM.  No messages are shown post-GRUB; the VM instantly reboots.
> > >> Reverting commit 194a9749c73d ("x86/boot/compressed/64: Handle 5-level
> > >> paging boot if kernel is above 4G") fixes it.  I've attached our kernel
> > >> config for reference, and am happy to test patches, provide sample QCOW
> > >> images, etc.
> > >
> > 
> > Also see https://bugzilla.kernel.org/show_bug.cgi?id=200385 ,
> > 
> > 0a1756bd2897951c03c1cb671bdfd40729ac2177 is acting up
> > too with the same symptoms
> 
> I tracked it down to -flto in LDFLAGS. I'll look more into this.

-flto in LDFLAGS screws up this part of paging_prepare():

	/* Copy trampoline code in place */
	memcpy(trampoline_32bit + TRAMPOLINE_32BIT_CODE_OFFSET / sizeof(unsigned long),
			&trampoline_32bit_src, TRAMPOLINE_32BIT_CODE_SIZE);

In particular, relocation for trampoline_32bit_src solved in the wrong
way. Without -flto, we have rip-realtive address load:

  982d30:	48 8d 35 09 cc ff ff 	lea    -0x33f7(%rip),%rsi        # 97f940 <trampoline_32bit_src>

With -flto we have immediate load:

  982cf0:	48 c7 c6 f0 f8 97 00 	mov    $0x97f8f0,%rsi

It only would be okay if bootloader loads kernel at the address we compile
it for. But it's not usually the case.

As result we copy garbage into trampoline and crash when trying to execute
it.

I don't know how to solve it. As far as I know we don't support compiling
kernel with LTO in mainline.

Any suggestions?

Benjamin, do you change LDFLAGS or CFLAGS when compiling the kernel?

-- 
 Kirill A. Shutemov
