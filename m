Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF26ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 06:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AB7720647
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 06:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UEn6kDHj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AB7720647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbeGTG7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 02:59:52 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34276 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727545AbeGTG7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 02:59:52 -0400
Received: by mail-pg1-f196.google.com with SMTP id y5-v6so5932703pgv.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 23:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=62RNlA/AXthYMrggsGhdb3vhBaClUjFY4s/voIRvkho=;
        b=UEn6kDHjq3tLdVd38q9B7lwrDDiTowfnwdUJVSPPS45lOs+dStqjRESP5JU+rUSXvy
         QlcQfUiwdGNnIf84QPct5+c89e0KRbrC0Lxa94XIH0WH0Ye2cMI0jRDyS3E8+P4a9U6S
         1WmxwCn/MeFH8iZgEYZJBQsIdVaZdDvnoA1K4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=62RNlA/AXthYMrggsGhdb3vhBaClUjFY4s/voIRvkho=;
        b=AxqL3w1vPoXnIYuFUiuEsTO6+vY0jv6jjYyxiL28gxdgEdLiEi6K41pBbvPWLJBSdT
         qx2VNFwG7No+yfXhA/vQZpzRD7H2zOOSL8y4HwRp6mzxp3ertX460zrIPl1sFXMvIwdC
         l5iP1DaNtll0BjLiNUPE7mWB5z5zAg9leXYi01dXKfZnxa7xV7ua+D+TL7IYORHZQGdV
         6ZBUTifhuL0DV/scXT4r5cd41GlPu1kFfgs8goRuysRsUlpghME/nIO7G0RNM9II7pMJ
         JPqIo7uBlD7ezzCDn0IqVsgXARvTWDfwFjSqyQuSNIBBJ1grvteskD8b5dCdeaN/JkdD
         j13Q==
X-Gm-Message-State: AOUpUlHRefR+deoGyCpKijKWuOxnxsu1KLvfj/Q5qsPmECvmY/G72lLZ
        uyIpLS4gI/W2yn98yYAHsf83QQ==
X-Google-Smtp-Source: AAOMgpc8l5OLvd38FS7j2I8paM9ZX8fKnZgLr41dYzxBT2ioXHmRyEY8z5LFSejapZkKeZrFSLK3gw==
X-Received: by 2002:a63:4811:: with SMTP id v17-v6mr738660pga.379.1532067196421;
        Thu, 19 Jul 2018 23:13:16 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id q140-v6sm1194936pgq.11.2018.07.19.23.13.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 23:13:15 -0700 (PDT)
Date:   Fri, 20 Jul 2018 15:14:36 +0900
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     James Morse <james.morse@arm.com>
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de, ard.biesheuvel@linaro.org, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 10/15] arm64: kexec_file: allow for loading
 Image-format kernel
Message-ID: <20180720061434.GK11258@linaro.org>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        James Morse <james.morse@arm.com>, catalin.marinas@arm.com,
        will.deacon@arm.com, dhowells@redhat.com, vgoyal@redhat.com,
        herbert@gondor.apana.org.au, davem@davemloft.net, dyoung@redhat.com,
        bhe@redhat.com, arnd@arndb.de, ard.biesheuvel@linaro.org,
        bhsharma@redhat.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180711074203.3019-1-takahiro.akashi@linaro.org>
 <20180711074203.3019-11-takahiro.akashi@linaro.org>
 <bfbb8d3f-6d7b-3ebb-d805-15b89c55aaeb@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfbb8d3f-6d7b-3ebb-d805-15b89c55aaeb@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 05:47:50PM +0100, James Morse wrote:
> Hi Akashi,
> 
> On 11/07/18 08:41, AKASHI Takahiro wrote:
> > This patch provides kexec_file_ops for "Image"-format kernel. In this
> > implementation, a binary is always loaded with a fixed offset identified
> > in text_offset field of its header.
> > 
> > Regarding signature verification for trusted boot, this patch doesn't
> > contains CONFIG_KEXEC_VERIFY_SIG support, which is to be added later
> > in this series, but file-attribute-based verification is still a viable
> > option by enabling IMA security subsystem.
> > 
> > You can sign(label) a to-be-kexec'ed kernel image on target file system
> > with:
> >     $ evmctl ima_sign --key /path/to/private_key.pem Image
> > 
> > On live system, you must have IMA enforced with, at least, the following
> > security policy:
> >     "appraise func=KEXEC_KERNEL_CHECK appraise_type=imasig"
> > 
> > See more details about IMA here:
> >     https://sourceforge.net/p/linux-ima/wiki/Home/
> 
> This looks useful to set a keys/signature/policy for a kernel that wasn't built
> to enforce signatures at compile time, so its a good thing to have from a
> single-image perspective.
> 
> I haven't managed to get IMA working to test this, but its all done by the kexec
> core code, so I don't think we're missing anything.
> 
> 
> > diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
> > new file mode 100644
> > index 000000000000..a47cf9bc699e
> > --- /dev/null
> > +++ b/arch/arm64/kernel/kexec_image.c
> 
> > +static int image_probe(const char *kernel_buf, unsigned long kernel_len)
> > +{
> > +	const struct arm64_image_header *h;
> > +
> > +	h = (const struct arm64_image_header *)(kernel_buf);
> > +
> > +	if (!h || (kernel_len < sizeof(*h)) ||
> 
> > +			!memcmp(&h->magic, ARM64_MAGIC, sizeof(ARM64_MAGIC)))
> 
> Doesn't memcmp() return 0 if the memory regions are the same?
> This would always match the correct magic, rejecting the image.
> 
> That's not whats happening, as kexec-file works, so this never matches anything.
> 
> sizeof(ARM64_MAGIC) includes the null terminator, but this sequence is output in
> head.S using '.ascii' which doesn't include the terminator, (otherwise it
> wouldn't fit in the 4byte magic field). The memcmp() here is also consuming the
> least significant bytes of the next field.
> 
> I think this line should be:
> | 			memcmp(&h->magic, ARM64_MAGIC, sizeof(h->magic)))

Absolutely you're right!

> 
> > +static void *image_load(struct kimage *image,
> > +				char *kernel, unsigned long kernel_len,
> > +				char *initrd, unsigned long initrd_len,
> > +				char *cmdline, unsigned long cmdline_len)
> 
> > +	kbuf.buffer = kernel;
> > +	kbuf.bufsz = kernel_len;
> > +	kbuf.memsz = le64_to_cpu(h->image_size);
> > +	text_offset = le64_to_cpu(h->text_offset);
> > +	kbuf.buf_align = SZ_2M;
> 
> Nit: MIN_KIMG_ALIGN ?

OK.

> 
> > +	/* Adjust kernel segment with TEXT_OFFSET */
> > +	kbuf.memsz += text_offset;
> > +
> > +	ret = kexec_add_buffer(&kbuf);
> > +	if (ret)
> > +		goto out;
> 
> You just return in the error cases above but here you goto ... the return
> statement at the end. Seems a bit odd.

Will fix it.

> 
> With the memcmp() thing fixed:
> Reviewed-by: James Morse <james.morse@arm.com>

Always appreciate you reviewing.

-Takahiro AKASHI


> 
> Thanks,
> 
> James
