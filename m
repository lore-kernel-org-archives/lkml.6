Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03820C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 04:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD92220685
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 04:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="esUvsJxx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD92220685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728995AbeKEOAE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 09:00:04 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43299 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728165AbeKEOAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 09:00:04 -0500
Received: by mail-pg1-f194.google.com with SMTP id n10-v6so3610615pgv.10
        for <linux-kernel@vger.kernel.org>; Sun, 04 Nov 2018 20:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y/NU5bpes/QTNMPNFTW9uCANbiOdORAMoaGMWgZTrQs=;
        b=esUvsJxxnEnnLbsoUT/Ar+WTzzcUg2TOlYvEZ8rsaSHVxFXd8GT0PCwJyaMjQCtoj6
         /gHkx/wQQlm1lMZBqVx0h0vz+DcmBoP9Tt03hZ6WPfYRalJ4iDCjff836GxfaCZCXiLJ
         Uu8ya5xSF9OBCnjxJPwsnYCOJlSyoG/0FdnvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=y/NU5bpes/QTNMPNFTW9uCANbiOdORAMoaGMWgZTrQs=;
        b=mIQOuHhoJbdYan+XQOD9fbEjz4wviUoyuqkOiDn3SMq+7z/8Lv6yeG8PXSU6EdecEL
         Qv3PQXWmzYr4aWfky89wqwcAUgGkkGkLJufdp6oFD8zu862ybUH++O8dYL4h7VzodRvx
         p7thvqGjcsJMyLjTVIiPmh0ir7ehy97HdmRjD268yC0Lyf4Samx45iLNuiig2Fyw+uGr
         3m0tO8NZkRBRFGhyEM832Vv9edtkkU3H5ga63oR5xxOR7SVxmEZfMMSdmMzqq5wPYxi6
         JjQaNL8/Ieb6gn7sZxU0U3YZ4HRd6eJyAvwTpx6XiYkblA9r5dQyOtquplU0MiFjCLhh
         LSQw==
X-Gm-Message-State: AGRZ1gK56xku7U8Jq/Dj+qjLvxyq5+R9o/HmQGGcDQ08SOio5Yx/t8W5
        f8Y0iI7aCySFVqkuCkJiwX3cqA==
X-Google-Smtp-Source: AJdET5dWLWDOD9XbioIY7J5SpMAbWacX1qP7k4xZSEcN9aShkqf31lkXemhRuZANwKdbFwifqYXVhw==
X-Received: by 2002:a63:9dca:: with SMTP id i193-v6mr17515663pgd.98.1541392940579;
        Sun, 04 Nov 2018 20:42:20 -0800 (PST)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id s80-v6sm47030900pfa.114.2018.11.04.20.42.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 04 Nov 2018 20:42:18 -0800 (PST)
Date:   Sun, 4 Nov 2018 20:42:17 -0800
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH 8/8] pstore/ram: Correctly calculate usable PRZ bytes
Message-ID: <20181105044217.GB56850@google.com>
References: <20181101235200.28584-1-keescook@chromium.org>
 <20181101235200.28584-9-keescook@chromium.org>
 <20181102180111.GA14942@google.com>
 <CAGXu5jLcawCKQL9i6poyJu3v3Ru6VcAXqwa5dxKWQL1Bp+Ai_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jLcawCKQL9i6poyJu3v3Ru6VcAXqwa5dxKWQL1Bp+Ai_w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

On Fri, Nov 02, 2018 at 01:00:08PM -0700, Kees Cook wrote:
[..] 
> >> This corruption was visible with "ramoops.mem_size=204800 ramoops.ecc=1".
> >> Any stored crashes would not be uncompressable (producing a pstorefs
> >> "dmesg-*.enc.z" file), and triggering errors at boot:
> >>
> >>   [    2.790759] pstore: crypto_comp_decompress failed, ret = -22!
> >>
> >> Reported-by: Joel Fernandes <joel@joelfernandes.org>
> >> Fixes: b0aad7a99c1d ("pstore: Add compression support to pstore")
> >> Signed-off-by: Kees Cook <keescook@chromium.org>
> >
> > Thanks!
> > Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> Thanks!
> 
> > Also should this be fixed for other backends or are those good? AFAIR, I saw
> > this for EFI too.
> 
> It seemed like the other backends were doing it correctly (e.g. erst
> removes the header from calculation, etc). I did see that EFI
> allocates more memory than needed?
> 
>         efi_pstore_info.buf = kmalloc(4096, GFP_KERNEL);
>         if (!efi_pstore_info.buf)
>                 return -ENOMEM;
> 
>         efi_pstore_info.bufsize = 1024;
> 
> efi_pstore_write() does:
> 
>         ret = efivar_entry_set_safe(efi_name, vendor, PSTORE_EFI_ATTRIBUTES,
>                               !pstore_cannot_block_path(record->reason),
>                               record->size, record->psi->buf);
> 
> and efivar_entry_set_safe() says:
> 
>  * Returns 0 on success, -ENOSPC if the firmware does not have enough
>  * space for set_variable() to succeed, or a converted EFI status code
>  * if set_variable() fails.
> 
> So I don't see how this could get truncated. (I'm not saying it
> didn't... just that I can't see it in an obvious place.)


So I *think* the issue is that the pstore had old compressed dmesg dumps in
EFI on my laptop, after the crypto layer in the kernel probably changed
enough to make the data non-decompressable, if that makes any sense. So older
code did compression in certain way, and newer code is doing the decompress,
or something like that.

I did some sysrq crashes on my laptop and the deflate decompress is working
fine with pstore+EFI. Its interesting I see some .enc.z files which fail to
decompress (which are older ones), and others which are decompressed fine
(the newer ones) ;-)

Dumping the magic bytes of the non decompressable .enc.z files, I get this
which shows a valid zlib compressed header:

Something like:
48 89 85 54 4d 6f 1a 31

The 0b1000 in the first byte means it is "deflate". The file tool indeed
successfully shows "zlib compressed data" and I did the math for the header
and it is indeed valid. So I don't think the data is insane. The buffer has
enough room because even the very small dumps are not decompressable.

At this point we can park this issue I guess, but a scenario that is still
broken is:
Say someone crashes the system on compress algo X and then recompiles with
compress algo Y, then the decompress would fail no?

One way to fix that is to store the comrpession method in buffer as well,
then initialize all algorithms at boot and choose the right one in the
buffer ideally. Otherwise atleast we should print a message saying "buffer is
encoded with algo X but compression selected is Y" or something. But I agree
its a very low priority "doctor it hurts if I do this" kind of issue :)

Anyway, let me know what you think :)

thanks,

- Joel

