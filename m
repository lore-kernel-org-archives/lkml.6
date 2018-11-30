Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FB9C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36E2621473
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:26:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36E2621473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bfs.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbeK3TfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 14:35:18 -0500
Received: from mx01-sz.bfs.de ([194.94.69.67]:7653 "EHLO mx01-sz.bfs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726843AbeK3TfR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 14:35:17 -0500
X-Greylist: delayed 475 seconds by postgrey-1.27 at vger.kernel.org; Fri, 30 Nov 2018 14:35:16 EST
Received: from localhost (localhost [127.0.0.1])
        by mx01-sz.bfs.de (Postfix) with ESMTP id 03EE4600BD;
        Fri, 30 Nov 2018 09:18:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at bfs.de
Received: from mx01-sz.bfs.de ([IPv6:::1])
        by localhost (mx01-sz.bfs.de [IPv6:::1]) (amavisd-new, port 10024)
        with ESMTP id XTjWmyZegRDT; Fri, 30 Nov 2018 09:18:50 +0100 (CET)
Received: from mail-sz.bfs.de (mail-sz.bfs.de [10.129.18.200])
        by mx01-sz.bfs.de (Postfix) with ESMTPS;
        Fri, 30 Nov 2018 09:18:50 +0100 (CET)
Received: from null (ox-groupware01-sz.bfs.de [10.129.18.42])
        by mail-sz.bfs.de (Postfix) with ESMTPS id 30A357F453;
        Fri, 30 Nov 2018 09:18:49 +0100 (CET)
Date:   Fri, 30 Nov 2018 09:18:48 +0100 (CET)
From:   Walter Harms <wharms@bfs.de>
To:     Colin King <colin.king@canonical.com>
Cc:     David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-ID: <862154684.73704.1543565929105@ox-groupware.bfs.de>
Subject: Re: [PATCH] drm/mgag200: make array m_div_val static, shrinks
 object size
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev44
X-Originating-Client: com.openexchange.ox.gui.dhtml
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Am 30.11.2018 00:40, schrieb Colin King:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Don't populate the const array m_div_val on the stack but instead
> make it static. Makes the object code smaller by 60 bytes:
> 
> Before:
>    text	   data	    bss	    dec	    hex	filename
>   32339	   1728	      0	  34067	   8513	mgag200/mgag200_mode.o
> 
> After:
>    text	   data	    bss	    dec	    hex	filename
>   32215	   1792	      0	  34007	   84d7	mgag200/mgag200_mode.o
> 
> (gcc version 8.2.0 x86_64)
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/gpu/drm/mgag200/mgag200_mode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/mgag200/mgag200_mode.c
> b/drivers/gpu/drm/mgag200/mgag200_mode.c
> index acf7bfe68454..9939f0174bf7 100644
> --- a/drivers/gpu/drm/mgag200/mgag200_mode.c
> +++ b/drivers/gpu/drm/mgag200/mgag200_mode.c
> @@ -629,7 +629,7 @@ static int mga_g200er_set_plls(struct mga_device *mdev,
> long clock)
>  	unsigned int p, m, n;
>  	unsigned int computed, vco;
>  	int tmp;
> -	const unsigned int m_div_val[] = { 1, 2, 4, 8 };
> +	static const unsigned int m_div_val[] = { 1, 2, 4, 8 };

hi,
is that array needed at all ? obvious it is 2^n
i found only one use:
 computed = vco / (m_div_val[testm] * (testo + 1));

just my 2 cents,

re,
 wh


>  
>  	m = n = p = 0;
>  	vcomax = 1488000;
