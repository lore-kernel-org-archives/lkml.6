Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E6EC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 07:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD6EB208E1
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 07:36:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JBm1Es4J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD6EB208E1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751242AbeGJHgF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 03:36:05 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:32826 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751103AbeGJHgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 03:36:03 -0400
Received: by mail-pl0-f67.google.com with SMTP id 6-v6so7235250plb.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 00:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qTsmWKcyvq7J+UVFrFcLuBhSnmNjJqzl9Mrq2IFXPZw=;
        b=JBm1Es4J6Etbbmkcnh+dYxs7+M4Iqcq8DtlHpsbKOBfRGQ9TXc24Z6p1u4e20y9PF8
         a5+TQiVlFmvqmHw9lnE1AtZWAkmbKE46StD6bvnvMJeQsZAPTw6lxrM7hATJDWVqYm4k
         LypwaY+f5zD1EPMqiEHpqzNHd5FFtQ/LEqNzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=qTsmWKcyvq7J+UVFrFcLuBhSnmNjJqzl9Mrq2IFXPZw=;
        b=RGpeL4qVokGIuf6y8ZRdsHFlhxWZkoKQR6/SqmIYNK/r8AGpWzSEH+ojq+OV6VFgwj
         KFFm5YJ3LZEulxfNhzLK+T5NoGZCNDLIbpCceF6IFk+oFvax6dgBIySTqWxyXDieqD4Y
         y6SRv2AwsGVcgkewFGwgUo1n8LIZSkZ94jl+GEZLHZ4BUjd/HQQ9QW8ADzCqZPU7pX+x
         1N9jFJGRvry7ZDXeSU3B/Ab+IClDogP4aI9KORGoY0WIR3G6Il+7iPyzedLnkoFk9GlB
         FMTjgHOgk1evN/6XSPu0tKPJWroOSITS7J1y8vc2LWP7fxFxd5B1PAAX/rc5HrAfiSqU
         a+Kw==
X-Gm-Message-State: APt69E2iTculDad7Bjt+o+lBztY735/zrVnzlrg6xmylVthByHxnwXHp
        FuchmIOcLL+3D4iiNV8ogSLGmA==
X-Google-Smtp-Source: AAOMgpfFUQCBNjCoG+wcW5i7f1zT75jiU0x94DyKI3WYHfzgFFMGgtvjlX8q4YeL8GsmgqU4VRwv4Q==
X-Received: by 2002:a17:902:8a95:: with SMTP id p21-v6mr23613176plo.91.1531208162889;
        Tue, 10 Jul 2018 00:36:02 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id 10-v6sm24376652pfr.129.2018.07.10.00.35.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 00:36:02 -0700 (PDT)
Date:   Tue, 10 Jul 2018 16:37:22 +0900
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     James Morse <james.morse@arm.com>
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de, ard.biesheuvel@linaro.org, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 08/14] arm64: kexec_file: load initrd and device-tree
Message-ID: <20180710073719.GW28220@linaro.org>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e401f4e-6176-990d-476c-31ae3f28f26c@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

James,

On Tue, Jul 03, 2018 at 05:32:09PM +0100, James Morse wrote:
> Hi Akashi,
> 
> On 23/06/18 03:20, AKASHI Takahiro wrote:
> > load_other_segments() is expected to allocate and place all the necessary
> > memory segments other than kernel, including initrd and device-tree
> > blob (and elf core header for crash).
> > While most of the code was borrowed from kexec-tools' counterpart,
> > users may not be allowed to specify dtb explicitly, instead, the dtb
> > presented by the original boot loader is reused.
> > 
> > arch_kimage_kernel_post_load_cleanup() is responsible for freeing arm64-
> > specific data allocated in load_other_segments().
> 
> 
> > diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
> > index c38a8048ed00..7115c4f915dc 100644
> > --- a/arch/arm64/kernel/machine_kexec_file.c
> > +++ b/arch/arm64/kernel/machine_kexec_file.c
> 
> > +static int setup_dtb(struct kimage *image,
> > +		unsigned long initrd_load_addr, unsigned long initrd_len,
> > +		char *cmdline, unsigned long cmdline_len,
> > +		char **dtb_buf, size_t *dtb_buf_len)
> > +{
> > +	char *buf = NULL;
> > +	size_t buf_size;
> > +	int nodeoffset;
> > +	u64 value;
> > +	int ret;
> > +
> > +	/* duplicate dt blob */
> > +	buf_size = fdt_totalsize(initial_boot_params);
> > +
> > +	if (initrd_load_addr) {
> > +		buf_size += fdt_prop_len("linux,initrd-start", sizeof(u64));
> > +		buf_size += fdt_prop_len("linux,initrd-end", sizeof(u64));
> > +	}
> > +
> > +	if (cmdline)
> > +		buf_size += fdt_prop_len("bootargs", cmdline_len + 1);
> 
> (a comment here about the possibility of an embedded NULL may avoid surprises later)
> 
> 
> > +	buf = vmalloc(buf_size);
> > +	if (!buf) {
> > +		ret = -ENOMEM;
> > +		goto out_err;
> > +	}
> > +
> > +	ret = fdt_open_into(initial_boot_params, buf, buf_size);
> > +	if (ret)
> > +		goto out_err;
> > +
> > +	nodeoffset = fdt_path_offset(buf, "/chosen");
> > +	if (nodeoffset < 0)
> > +		goto out_err;
> 
> This doesn't update 'ret', so we return the 0/success from above...

OK. Will fix it.

> 
> > +
> > +	/* add bootargs */
> > +	if (cmdline) {
> > +		ret = fdt_setprop(buf, nodeoffset, "bootargs",
> > +						cmdline, cmdline_len + 1);
> > +		if (ret)
> > +			goto out_err;
> > +	}
> 
> So (cmdline_len == 0) from user-space means keep the old cmdline. Sounds
> sensible. Is this documented anywhere?

Very good catch, James.
To be a bit surprise, --append (and --cmdline) option belongs to arch-
specific options in terms of implementation. Apparently, a standard man page
of kexec(8) say little about it, in particular, for device-tree-based system.

As far as arm64 is concerned, the fact is a bit complicated.
User space kexec accepts --append as well as --reuse-cmdline, and
along with yet another --dtb option, a resulting command line for new
kernel (or bootargs in new dtb) would look to be:

	--append=A | --reuse-cmdline |     --dtb
		   |                 |   n    |    y(bootargs=B)

	    n            n               S(*1)      B(*2)
	    n            y               S          S(*3)
	    y            n               A          A
	    y            y              S+A        S+A(*4)

      where S: the cmdline parameters of the running system
		 (equal to bootargs in system's dtb)

You are talking about case(1) above.

Given that we can have an explicit option, --reuse-cmdline, the cmdline
in (1) should be NULL. Meanwhile, we specify --dtb here, which means
that we want to re-use system's dtb, implying that we also want to
reuse a cmdline parameter. (This can be arguable, though)

So I would say that we have both reasons to go for and go against.

# Likewise,
# I wonder why the cmdnline would not be B or A+B, respectively,
in case of (3) and (4). But it's a different issue.

> powerpc does the opposite, it deletes the bootargs in this case. Are we happy
> making his a per-arch thing?

My compromise solution is:
a.to maintain compatibility with powerpc at system call level, that is,
  replacing bootargs in new dtb if user explicitly specifies cmdline
  argument, otherwise nullifying bootargs,
b.yet maintain compatibility with arm64's kexec behavior at command line
  interface level. If neither --append nor --dtb is not specified,
  user space kexec will reuse the system's command line whether or not
  --reuse-cmdline is used.

(Do you follow me?)

So kexec and kexec_file on arm64 will still behave in exactly the same way,
but differently from ppc at command level for now.
The point is that, if we might want or need to change this behavior
(at any time in the future), we would only have to modify user space kexec.
Kernel semantics will never break.

(b) requires additional small modification on kexec-tools, but kexec_file
support is yet to be upstreamed anyway.

> 
> > +	/* add initrd-* */
> > +	if (initrd_load_addr) {
> > +		value = cpu_to_fdt64(initrd_load_addr);
> > +		ret = fdt_setprop_u64(buf, nodeoffset, "linux,initrd-start",
> > +							value);
> > +		if (ret)
> > +			goto out_err;
> > +
> > +		value = cpu_to_fdt64(initrd_load_addr + initrd_len);
> > +		ret = fdt_setprop_u64(buf, nodeoffset, "linux,initrd-end",
> > +							value);
> > +		if (ret)
> > +			goto out_err;
> > +	}
> 
> Won't this do the same with the initrd? Re-use the old values if no new one was
> provided? I can't find anything that deletes the property by the time we come to
> kexec, and the old physical addresses may have been re-used by who-knows-what.
> 
> (powerpc has some code to: /* If there's no new initrd, delete the old initrd's
> info. */)

Yeah, I think that deleting properties would be a right way to go.
Will fix.

Thanks,
-Takahiro AKASHI

> 
> 
> Thanks,
> 
> James
