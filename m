Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E56C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 18:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AB8920671
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 18:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AywQ36Ve"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AB8920671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388985AbeG0T42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 15:56:28 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35141 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730636AbeG0T41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 15:56:27 -0400
Received: by mail-pg1-f196.google.com with SMTP id e6-v6so3706213pgv.2;
        Fri, 27 Jul 2018 11:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cuBNh4wciydK7NgV02n0M6cKF727oIKfqf0BawY+U5g=;
        b=AywQ36VetWLro4eB/BhN3S+Wz8wJbUjZMYdjEG0S0D+wNGu/IAGCcOL2wT9DhmpfyA
         9coXZePw6ME5P9Ycap62L6PrxgW+aRJNipwTD0Hh3ghhjAM77V2jmnOvZRM66Gbwaj/3
         BtB/fAzf04IWuYhlHWeqKTAdqrUeAyfc5C94Q1GHS/viTC7jLXjAR285BY8XjRmr8dZ3
         2wiTAqDzemfHR2PqHH3ukPS/A2w0/gmqjQ3XAoLRsUIPHtniujQeHaPxFnUnGdFa6wgp
         JZIsCXuUErL5uP0qleLEsN2Qncl1080UArc/pdhx+z/iZCpwLYAmmtWZvioerH65ok67
         6ZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cuBNh4wciydK7NgV02n0M6cKF727oIKfqf0BawY+U5g=;
        b=CPP+BuJ25X2aGN8KdcNRmvJDfi+0kS+IOL2HxUdk2lsf0UDFpd/8qhEmWqUtkJI3jk
         noVqsuV4D9Vu4ZiazynDxUgvHZ9NbbzpCflvj9ekwV2LneOnHxPdsDgnCGt2kfTaDmcF
         Tb8mQWeKTAS0uT474BPmSsmZrL/0bmQgGiJRV25oELbHiFUvlNRv/VUzPFh+bOr8tjM1
         LqRGre/Sxx+Tr/TdghlOFNQjdXj+mQCr0+HjsDzQhkPIpkv0lmPIra7TYzt6okcfWzsh
         GiCcK3Vpe3239iISHJJQRP/Dbcsb30rBiB9mij1nPG0wn6liyXEHcRaLwStVzAvaqlTK
         7R0Q==
X-Gm-Message-State: AOUpUlHLtHw7iJwZrX+4oP/ABEKWUdD2+CeKnXAPZac+aFpTlOggpyAo
        eyNxTJPQD24Z/dcyR3H1GR0pDiUx
X-Google-Smtp-Source: AAOMgpe1SXvsOQtXwNDykfnsUTRkhGsPtLk5XRN6MPt5aP3ydPH3QT5hD//+QzBTMJkTJMZ1rg6C0w==
X-Received: by 2002:a62:3b89:: with SMTP id w9-v6mr7793617pfj.80.1532716400845;
        Fri, 27 Jul 2018 11:33:20 -0700 (PDT)
Received: from dtor-ws ([2620:0:1000:1511:8de6:27a8:ed13:2ef5])
        by smtp.gmail.com with ESMTPSA id d19-v6sm14236671pgi.50.2018.07.27.11.33.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Jul 2018 11:33:19 -0700 (PDT)
Date:   Fri, 27 Jul 2018 11:33:17 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     arvind.yadav.cs@gmail.com, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] input: misc: keyspan_remote: Replace GFP_ATOMIC with
 GFP_KERNEL in keyspan_probe()
Message-ID: <20180727183317.GB72640@dtor-ws>
References: <20180727021258.29675-1-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180727021258.29675-1-baijiaju1990@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 10:12:58AM +0800, Jia-Ju Bai wrote:
> keyspan_probe() is never called in atomic context.
> It calls usb_alloc_coherent() with GFP_ATOMIC, which is not necessary.
> GFP_ATOMIC can be replace with GFP_KERNEL.
> 
> This is found by a static analysis tool named DCNS written by myself.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>

Applied, thank you.

> ---
>  drivers/input/misc/keyspan_remote.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/misc/keyspan_remote.c b/drivers/input/misc/keyspan_remote.c
> index 67482b248b2d..a8937ceac66a 100644
> --- a/drivers/input/misc/keyspan_remote.c
> +++ b/drivers/input/misc/keyspan_remote.c
> @@ -466,7 +466,7 @@ static int keyspan_probe(struct usb_interface *interface, const struct usb_devic
>  	remote->in_endpoint = endpoint;
>  	remote->toggle = -1;	/* Set to -1 so we will always not match the toggle from the first remote message. */
>  
> -	remote->in_buffer = usb_alloc_coherent(udev, RECV_SIZE, GFP_ATOMIC, &remote->in_dma);
> +	remote->in_buffer = usb_alloc_coherent(udev, RECV_SIZE, GFP_KERNEL, &remote->in_dma);
>  	if (!remote->in_buffer) {
>  		error = -ENOMEM;
>  		goto fail1;
> -- 
> 2.17.0
> 

-- 
Dmitry
