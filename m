Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E99C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED9A620652
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:04:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730726AbfBRNEc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:04:32 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:56610 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728873AbfBRNEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:04:32 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gviam-0004sB-Jh; Mon, 18 Feb 2019 14:04:16 +0100
Date:   Mon, 18 Feb 2019 14:04:16 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
cc:     Arthur Gautier <baloo@gandi.net>,
        Andy Lutomirski <luto@amacapital.net>,
        Jann Horn <jannh@google.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        kernel list <linux-kernel@vger.kernel.org>,
        Pascal Bouchareine <pascal@gandi.net>
Subject: Re: [PATCH] x86: uaccess: fix regression in unsafe_get_user
In-Reply-To: <20190217042201.GU2217@ZenIV.linux.org.uk>
Message-ID: <alpine.DEB.2.21.1902181347500.1549@nanos.tec.linutronix.de>
References: <20190215235901.23541-1-baloo@gandi.net> <CAG48ez2tYizTKncevLF=AMQ2nm3D=SqGHH5bM5f-U0fhQ1nL9Q@mail.gmail.com> <alpine.DEB.2.21.1902161358160.1683@nanos.tec.linutronix.de> <4F2693EA-1553-4F09-9475-781305540DBC@amacapital.net>
 <20190216234702.GP2217@ZenIV.linux.org.uk> <20190217034121.bs3q3sgevexmdt3d@khany> <20190217042201.GU2217@ZenIV.linux.org.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Feb 2019, Al Viro wrote:
> On Sun, Feb 17, 2019 at 03:41:21AM +0000, Arthur Gautier wrote:
> Who says anything about changing the format of the file?  At least
> one trivial way to handle that would be this:
> 
> diff --git a/init/initramfs.c b/init/initramfs.c
> index 7cea802d00ef..edbddfb73106 100644
> --- a/init/initramfs.c
> +++ b/init/initramfs.c
> @@ -265,8 +265,12 @@ static int __init do_header(void)
>  		state = Collect;
>  		return 0;
>  	}
> -	if (S_ISREG(mode) || !body_len)
> -		read_into(name_buf, N_ALIGN(name_len), GotName);
> +	if (S_ISREG(mode) || !body_len) {
> +		collect = collected = name_buf;
> +		remains = N_ALIGN(name_len);
> +		next_state = GotName;
> +		state = Collect;
> +	}
>  	return 0;
>  }

That does not help much because that is exactly at the end of the
decompressed image and the decompressor is done. So nothing would collect
the remainder anymore.

> Another would be to have the buffer passed to flush_buffer() (i.e.
> the callback of decompress_fn) allocated with 4 bytes of padding
> past the part where the unpacked piece of data is placed for the
> callback to find.  As in,
> 
> diff --git a/lib/decompress_inflate.c b/lib/decompress_inflate.c
> index 63b4b7eee138..ca3f7ecc9b35 100644
> --- a/lib/decompress_inflate.c
> +++ b/lib/decompress_inflate.c
> @@ -48,7 +48,7 @@ STATIC int INIT __gunzip(unsigned char *buf, long len,
>  	rc = -1;
>  	if (flush) {
>  		out_len = 0x8000; /* 32 K */
> -		out_buf = malloc(out_len);
> +		out_buf = malloc(out_len + 4);

  +8 actually.

>  	} else {
>  		if (!out_len)
>  			out_len = ((size_t)~0) - (size_t)out_buf; /* no limit */
> 
> for gunzip/decompress and similar ones for bzip2, etc.  The contents
> layout doesn't have anything to do with that...

Right. That works nicely.

Thanks,

	tglx

