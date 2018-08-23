Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F31F3C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEBA0208D6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="fv/dVVzD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEBA0208D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730169AbeHWLyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:54:54 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44922 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729063AbeHWLyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:54:53 -0400
Received: by mail-ed1-f68.google.com with SMTP id s10-v6so3032307edb.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 01:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=eX3VcLJSyMNVO36A8iV3wSIN/IJRV3VmVMmeJ/tVKoY=;
        b=fv/dVVzDM2rH6aj+38gYLaTZobD+D5AflFYQiHknnFZJN+UgUF5lpOjR9VGXqUkF+q
         q2xZJF6dollWouZv1zJ5qE77gAHRCuuhom5a5YktAEbKVsr9P/NrbGse5Pt06jdaAeQm
         HR6vEQVOPHytYACyMRSpay3s7LYSDoMpW0+ZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=eX3VcLJSyMNVO36A8iV3wSIN/IJRV3VmVMmeJ/tVKoY=;
        b=IXBSlbPJGhtK09G+Ixb8tTmqkl3eh/I1tcSW2srI9+KTmOKQj8a1l4GVGyMj0ouE33
         CBLoSF9NWABl2Tsg4u24XnId4sEXb0Rxj+sIof7LMSAxQT1q5uW0B74jxWQufa1ticKn
         nD3ca7mcDqHTsvY1TKdlpCVEVGo3Ik8pD5s8CjifNrAXZEG2obT8JBBc8TH6pgM5BBSR
         1LjyT0qQLaHxpnfdSXt5Ojs5CJZq+5FX2IOU0BMx4d2JAVgUaLzxF2QPwcA/bsMVVqzw
         cFcwnH9V1euTdDWmPrBT9nEzOGXyzsUX34bOXtQJnSdQfZsLFATjOjHFyGMq+c/FscvI
         4zUQ==
X-Gm-Message-State: APzg51DbfdADDtgN2TTvJYd4UucuBzsr6ZlLQDHmIk+RHn+hPfMn64ye
        BvkJg8LdpzQYeu9oZ/P9IZG1kg==
X-Google-Smtp-Source: ANB0VdaMKiVikpBdZknwsPDj6hp4rsnYRXEZm/B1JQGyTY7GlqeqaG39ASJ5VdO//mfhpxkR+Z42cQ==
X-Received: by 2002:aa7:c990:: with SMTP id c16-v6mr1621971edt.165.1535012781681;
        Thu, 23 Aug 2018 01:26:21 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-109.fiber7.init7.net. [212.51.149.109])
        by smtp.gmail.com with ESMTPSA id a9-v6sm1773004edi.26.2018.08.23.01.26.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Aug 2018 01:26:20 -0700 (PDT)
Date:   Thu, 23 Aug 2018 10:26:19 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     gustavo@padovan.org, maarten.lankhorst@linux.intel.com,
        sean@poorly.run, airlied@linux.ie, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/edid: Add 6 bpc quirk for SDC panel in Lenovo B50-80
Message-ID: <20180823082618.GZ21634@phenom.ffwll.local>
Mail-Followup-To: Kai-Heng Feng <kai.heng.feng@canonical.com>,
        gustavo@padovan.org, maarten.lankhorst@linux.intel.com,
        sean@poorly.run, airlied@linux.ie, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20180823055332.7723-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180823055332.7723-1-kai.heng.feng@canonical.com>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 05:53:32AM +0000, Kai-Heng Feng wrote:
> Another panel that reports "DFP 1.x compliant TMDS" but it supports 6bpc
> instead of 8 bpc.
> 
> Apply 6 bpc quirk for the panel to fix it.
> 
> BugLink: https://bugs.launchpad.net/bugs/1788308
> Cc: <stable@vger.kernel.org> # v4.8+
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Applied, thanks.
-Daniel

> ---
>  drivers/gpu/drm/drm_edid.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index 5dc742b27ca0..3c9fc99648b7 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
> @@ -116,6 +116,9 @@ static const struct edid_quirk {
>  	/* CPT panel of Asus UX303LA reports 8 bpc, but is a 6 bpc panel */
>  	{ "CPT", 0x17df, EDID_QUIRK_FORCE_6BPC },
>  
> +	/* SDC panel of Lenovo B50-80 reports 8 bpc, but is a 6 bpc panel */
> +	{ "SDC", 0x3652, EDID_QUIRK_FORCE_6BPC },
> +
>  	/* Belinea 10 15 55 */
>  	{ "MAX", 1516, EDID_QUIRK_PREFER_LARGE_60 },
>  	{ "MAX", 0x77e, EDID_QUIRK_PREFER_LARGE_60 },
> -- 
> 2.17.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
