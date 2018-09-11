Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 539BDC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 07:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F211920865
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 07:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="iJaNrg/z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F211920865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbeIKMgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 08:36:49 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44724 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbeIKMgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 08:36:48 -0400
Received: by mail-ed1-f66.google.com with SMTP id s10-v6so18422466edb.11
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 00:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=R3/6OO8EccSdX/D4uMsMvizp18CoxN+DpBAXdyILRAo=;
        b=iJaNrg/zP9jBLdCE4PR8fch9MQhfskAPAvqiRn1Vs8XHy+Hjsqw3e1B+xSwt/ReGP6
         NsdfYpbbR3VVITDjKmLsM/RKH42xCaGdn6SwaMHdQcM9hMjVEkMmo7M7BdTl4Dfm/Aof
         I+uh98i0wesOGFBU3us2nD+DZW4LGmp6k331U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=R3/6OO8EccSdX/D4uMsMvizp18CoxN+DpBAXdyILRAo=;
        b=uL95Om+VMUfMFwIk/vPnfgv9ce8PtIVpHDX/QsBjfvO/wis+qIs6V80ujXIwAfOvco
         bY9cP115tC7oCC8p30CoIE2SZnqmcgptGvrUZW1c5HWIUalvSo+5T/0JR0bPINWd0zNq
         j7DlTez0xV6g5UcjdAf9WGiHGu50bh/Zvd0Ue+aclZRiq6mu0EFgsth24+K67qW/bM21
         SaOjwmhHz1pVjzpIifU3aItGg8I1t1TWnHkRe1lF2efdsoNDHl2t6R5cIBh+qpyyimqX
         djOEwCysrrG4JH+YjjdoWCDxZA8cbqiUsZ+PHZWupy5oQ3+Yjfnd/KUelvX6sz5GrnqY
         WFsw==
X-Gm-Message-State: APzg51A+1di3eSFJnvxbLFDk9Y2tJrsUKwI34DQOcTcv3uJvCfN45MvG
        QwfTc6Xtg7WXsBQ+9epIB896ug==
X-Google-Smtp-Source: ANB0VdYPPnYO1YXVku671fl2MsQ8c8SLSQpP0lL+Z9XHgP3TFQdD131BxaCOT1afPWnXLf1zKHoGJA==
X-Received: by 2002:a50:96c4:: with SMTP id z4-v6mr27566478eda.14.1536651526903;
        Tue, 11 Sep 2018 00:38:46 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id 25-v6sm13866944edz.45.2018.09.11.00.38.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 00:38:45 -0700 (PDT)
Date:   Tue, 11 Sep 2018 09:38:44 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        laurent.pinchart@ideasonboard.com,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>
Subject: Re: [PATCH 03/10] udmabuf: use pgoff_t for pagecount
Message-ID: <20180911073844.GH19774@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
        laurent.pinchart@ideasonboard.com,
        "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>
References: <20180911065921.23818-1-kraxel@redhat.com>
 <20180911065921.23818-4-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180911065921.23818-4-kraxel@redhat.com>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 08:59:14AM +0200, Gerd Hoffmann wrote:
> Reported-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

TIL pgoff_t stands for page cache offset. I think we're pretty bad at
using that within i915 :-)

On the entire series Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

I did try to review in depth, but my brain is offline and coffee not
working :-) Hence just an ack.
-Daniel

> ---
>  drivers/dma-buf/udmabuf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
> index 19bd918209..ec22f203b5 100644
> --- a/drivers/dma-buf/udmabuf.c
> +++ b/drivers/dma-buf/udmabuf.c
> @@ -13,7 +13,7 @@
>  #include <linux/udmabuf.h>
>  
>  struct udmabuf {
> -	u32 pagecount;
> +	pgoff_t pagecount;
>  	struct page **pages;
>  };
>  
> -- 
> 2.9.3
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
