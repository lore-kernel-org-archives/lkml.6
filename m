Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B78C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 15:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50EDD20652
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 15:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="V4lAKO1z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50EDD20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbeJXALN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 20:11:13 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43941 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbeJXALM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 20:11:12 -0400
Received: by mail-qk1-f196.google.com with SMTP id m17-v6so1111499qkk.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 08:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=2bgG43hkfEXSDhFAuyoPhUl+ToVc6gvSH9j9/+1KLfA=;
        b=V4lAKO1zGLF1Mbxoi9H/SiF7W/SReJ3ajAR7q1BCf6L0zIFPVBDySW/gUk8fpk7QAm
         qzpIoeOXGVHIBPlQvSmxhl/6R5ffHNu4EJ9u/j9nwyDs/+YgoODjBReC+tSpz8DdIhwq
         L7zasPZ60RgTgoDPfA/Uj5chYGYJSgf+GLsRM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=2bgG43hkfEXSDhFAuyoPhUl+ToVc6gvSH9j9/+1KLfA=;
        b=sj/yirFyqwwRxT7aNi4HRWa2NZ3jQ0ZKZe9jwxoFbHpRSHKvsg6g0tRW8675JyPyNu
         AXQb8jIUHXGqF3ol6AsXJZeFzXNslBS1RZTKFIQkJKzyLFh20CaSn1k23UUELP3YYrac
         EJH1Ui7um2qrMuI7dUV69I+7F33ovMf2Ebc7cqNx7V77APCDzrkAM7HTKL2Gx/cn48SC
         w2SKUXsDP4R8dO7WQaevKeAiXuhFHDTMb7agj5/F+D6dQhLKH2jCtonLDmH5LrkiM3PY
         sOa8z78gJPorp13bd9ckUNoSc7rKszcvvOg/J2pMnGKYBzfRDy14Ve1f1VQh8+CPs20i
         UPhA==
X-Gm-Message-State: AGRZ1gK//dxCbrtqhmexHiO7JF7hwWFxGGFHRkZNX3qKm+4Jjint+LVj
        yibeo88Yww+TZ4dxjR3XnUSbyg==
X-Google-Smtp-Source: AJdET5dKa9FhrSnwTVDzJgD36HhcK5Rz747T7yN8a7TeAYZe09iXs9GlXWLFEVlJlHVgpxJUsozH5w==
X-Received: by 2002:ae9:de01:: with SMTP id s1-v6mr12377490qkf.258.1540309636361;
        Tue, 23 Oct 2018 08:47:16 -0700 (PDT)
Received: from xanadu.home (modemcable228.104-82-70.mc.videotron.ca. [70.82.104.228])
        by smtp.gmail.com with ESMTPSA id t35-v6sm1134574qtj.63.2018.10.23.08.47.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 08:47:15 -0700 (PDT)
Date:   Tue, 23 Oct 2018 11:47:14 -0400 (EDT)
From:   Nicolas Pitre <nicolas.pitre@linaro.org>
To:     Mikulas Patocka <mpatocka@redhat.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dave Mielke <Dave@mielke.cc>,
        Adam Borowski <kilobyte@angband.pl>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vt: fix broken display when running aptitude
In-Reply-To: <alpine.LRH.2.02.1810231126100.20699@file01.intranet.prod.int.rdu2.redhat.com>
Message-ID: <nycvar.YSQ.7.76.1810231139460.1498@knanqh.ubzr>
References: <alpine.LRH.2.02.1810231126100.20699@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Oct 2018, Mikulas Patocka wrote:

> If you run aptitude on framebuffer console, the display is corrupted. The 
> corruption is caused by the commit d8ae7242. The patch adds "offset" to 
> "start" when calling scr_memsetw, but it forgets to do the same addition 
> on a subsequent call to do_update_region.
> 
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> Fixes: d8ae72427187 ("vt: preserve unicode values corresponding to screen characters")
> Cc: stable@vger.kernel.org	# 4.19

Good catch.

Reviewed-by: Nicolas Pitre <nico@linaro.org>

> ---
>  drivers/tty/vt/vt.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-2.6/drivers/tty/vt/vt.c
> ===================================================================
> --- linux-2.6.orig/drivers/tty/vt/vt.c	2018-10-23 16:15:08.000000000 +0200
> +++ linux-2.6/drivers/tty/vt/vt.c	2018-10-23 16:29:20.000000000 +0200
> @@ -1551,7 +1551,7 @@ static void csi_K(struct vc_data *vc, in
>  	scr_memsetw(start + offset, vc->vc_video_erase_char, 2 * count);
>  	vc->vc_need_wrap = 0;
>  	if (con_should_update(vc))
> -		do_update_region(vc, (unsigned long) start, count);
> +		do_update_region(vc, (unsigned long)(start + offset), count);
>  }
>  
>  static void csi_X(struct vc_data *vc, int vpar) /* erase the following vpar positions */
> 
