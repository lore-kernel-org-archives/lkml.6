Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B03DC3279B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D97F4208EB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aT553H2g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D97F4208EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732445AbeGKCuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 22:50:14 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:45743 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732316AbeGKCuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 22:50:14 -0400
Received: by mail-pl0-f67.google.com with SMTP id a17-v6so2635007plm.12
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 19:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nkshVgHxyUT7FSIr8JS1F+lpBD0YA4ATLY1u4uUTpfM=;
        b=aT553H2gRqSIZJMd6KKz3jUJ5RlYPJylqoTCV54JBwzlfeGqY2VuLzoSQlu/r8vDoX
         cxj9OrF5EeIms/lHfqpEnehGBKFYEe1rn1F1ysGpOOGDEz1XWQwh3+DSK+NzjU56xSVi
         +o4WzXwgqWJbrrbp+Bxb5P5/NeKKoELY+4hkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=nkshVgHxyUT7FSIr8JS1F+lpBD0YA4ATLY1u4uUTpfM=;
        b=RR/lauFAnO1JDrFCGW0aAccNNaf3xFfI4qJxjeIGtZw3WkApfFgGip45ldUp10bQP0
         wxg4dzaW3ZkL0G15Zm2kY9QRJ3yumIdcsFmlDwcx4Fdp/VbeKVS5q84vmWZXlOCm5ml4
         2lrIf51UclZGLV52YCSJ3ewvhjU4v3vHGwviEV/k1zxebf4Ien/KqeixKL2nP2EoZsxa
         pxn0WIR87C6SXFdXC7gLpHNTF2diSSusZdErTkKNECzH6SwWUkhUERMnZKhoUX6C0+rS
         NnZftN8S3gsgeSJv+/FkrJontndIKJF7xXr/dbCWpE6XnClgYk+G6EebEJWzQe2fhd9f
         fNbQ==
X-Gm-Message-State: APt69E3NMtHRYvYSL8n7ctLyKzqaELPZwpb1Nr9zmXayF5bgNVdjmZOR
        O5NWwI3DglJFKmuDcGnAT55TGw==
X-Google-Smtp-Source: AAOMgpfZBrPoBz3/wZ5Xp4pNLpmZZdBjDzAwwyUoUi3nnyQaldgvox2Zn0rvT3BAhnAFJZGyW2ZJ9w==
X-Received: by 2002:a17:902:48c8:: with SMTP id u8-v6mr27088392plh.152.1531277291770;
        Tue, 10 Jul 2018 19:48:11 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id l85-v6sm39575004pfk.79.2018.07.10.19.48.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 19:48:11 -0700 (PDT)
Date:   Wed, 11 Jul 2018 11:49:33 +0900
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     James Morse <james.morse@arm.com>
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de, ard.biesheuvel@linaro.org, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 08/14] arm64: kexec_file: load initrd and device-tree
Message-ID: <20180711024932.GX28220@linaro.org>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        James Morse <james.morse@arm.com>, catalin.marinas@arm.com,
        will.deacon@arm.com, dhowells@redhat.com, vgoyal@redhat.com,
        herbert@gondor.apana.org.au, davem@davemloft.net, dyoung@redhat.com,
        bhe@redhat.com, arnd@arndb.de, ard.biesheuvel@linaro.org,
        bhsharma@redhat.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180623022058.10935-1-takahiro.akashi@linaro.org>
 <20180623022058.10935-9-takahiro.akashi@linaro.org>
 <1e401f4e-6176-990d-476c-31ae3f28f26c@arm.com>
 <20180710073719.GW28220@linaro.org>
 <27eda5b7-f9ad-2918-c302-3669d4b72fd0@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27eda5b7-f9ad-2918-c302-3669d4b72fd0@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 04:25:03PM +0100, James Morse wrote:
> Hi Akashi,
> 
> On 10/07/18 08:37, AKASHI Takahiro wrote:
> > On Tue, Jul 03, 2018 at 05:32:09PM +0100, James Morse wrote:
> >> On 23/06/18 03:20, AKASHI Takahiro wrote:
> >>> load_other_segments() is expected to allocate and place all the necessary
> >>> memory segments other than kernel, including initrd and device-tree
> >>> blob (and elf core header for crash).
> >>> While most of the code was borrowed from kexec-tools' counterpart,
> >>> users may not be allowed to specify dtb explicitly, instead, the dtb
> >>> presented by the original boot loader is reused.
> >>>
> >>> arch_kimage_kernel_post_load_cleanup() is responsible for freeing arm64-
> >>> specific data allocated in load_other_segments().
> 
> >>> diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
> >>> index c38a8048ed00..7115c4f915dc 100644
> >>> --- a/arch/arm64/kernel/machine_kexec_file.c
> >>> +++ b/arch/arm64/kernel/machine_kexec_file.c
> >>
> >>> +static int setup_dtb(struct kimage *image,
> >>> +		unsigned long initrd_load_addr, unsigned long initrd_len,
> >>> +		char *cmdline, unsigned long cmdline_len,
> >>> +		char **dtb_buf, size_t *dtb_buf_len)
> >>> +{
> 
> [..]
> 
> >>> +	/* add bootargs */
> >>> +	if (cmdline) {
> >>> +		ret = fdt_setprop(buf, nodeoffset, "bootargs",
> >>> +						cmdline, cmdline_len + 1);
> >>> +		if (ret)
> >>> +			goto out_err;
> >>> +	}
> >>
> >> So (cmdline_len == 0) from user-space means keep the old cmdline. Sounds
> >> sensible. Is this documented anywhere?
> 
> > To be a bit surprise, --append (and --cmdline) option belongs to arch-
> > specific options in terms of implementation. Apparently, a standard man page
> > of kexec(8) say little about it, in particular, for device-tree-based system.
> > 
> > As far as arm64 is concerned, the fact is a bit complicated.
> > User space kexec accepts --append as well as --reuse-cmdline, and
> > along with yet another --dtb option, a resulting command line for new
> > kernel (or bootargs in new dtb) would look to be:
> > 
> > 	--append=A | --reuse-cmdline |     --dtb
> > 		   |                 |   n    |    y(bootargs=B)
> > 
> > 	    n            n               S(*1)      B(*2)
> > 	    n            y               S          S(*3)
> > 	    y            n               A          A
> > 	    y            y              S+A        S+A(*4)
> > 
> >       where S: the cmdline parameters of the running system
> > 		 (equal to bootargs in system's dtb)
> 
> (I'm afraid I don't understand this table, but the text below helps...)

(Really? I believed that it was obvious.)

> 
> > You are talking about case(1) above.
> > 
> > Given that we can have an explicit option, --reuse-cmdline, the cmdline
> > in (1) should be NULL. Meanwhile, we specify --dtb here, which means
> > that we want to re-use system's dtb, implying that we also want to
> > reuse a cmdline parameter. (This can be arguable, though)
> 
> Sounds like this is all user-space's problem!

I dare not say it's a bug :)

> 
> > So I would say that we have both reasons to go for and go against.
> > 
> > # Likewise,
> > # I wonder why the cmdnline would not be B or A+B, respectively,
> > in case of (3) and (4). But it's a different issue.
> > 
> >> powerpc does the opposite, it deletes the bootargs in this case. Are we happy
> >> making his a per-arch thing?
> > 
> > My compromise solution is:
> > a.to maintain compatibility with powerpc at system call level, 
> 
> This sounds like the right thing to do.
> 
> 
> >   that is,
> >   replacing bootargs in new dtb if user explicitly specifies cmdline
> >   argument, otherwise nullifying bootargs,
> > b.yet maintain compatibility with arm64's kexec behavior at command line
> >   interface level. If neither --append nor --dtb is not specified,
> >   user space kexec will reuse the system's command line whether or not
> >   --reuse-cmdline is used.
> 
> (a and b aren't options this time: you're proposing to do a-and-b)

Yes.

> 
> > (Do you follow me?)
> 
> I think so:
> The syscall will behave the same as powerpc meaning the kernel will never re-use
> the existing cmdline in the dtb, even if that means (trying to) boot without one.
> 
> If user-space wants to re-use the command line, it should read /proc/cmdline and
> feed the string back into the kernel.

Thank you for rephrasing.

> 
> > So kexec and kexec_file on arm64 will still behave in exactly the same way,
> > but differently from ppc at command level for now.
> 
> > The point is that, if we might want or need to change this behavior
> > (at any time in the future), we would only have to modify user space kexec.
> > Kernel semantics will never break.
> > 
> > (b) requires additional small modification on kexec-tools, but kexec_file
> > support is yet to be upstreamed anyway.
> 
> Makes sense!

The next version will go with this approach.

-Takahiro AKASHI

> 
> Thanks,
> 
> James
