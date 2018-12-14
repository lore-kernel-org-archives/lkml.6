Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A79DFC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C42F208E7
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rg0/1vtX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C42F208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732348AbeLNMWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:22:02 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38707 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730581AbeLNMWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:22:00 -0500
Received: by mail-wm1-f65.google.com with SMTP id m22so5618289wml.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 04:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=aGgzHIwiwKkt4N+xEL5JlvBhLY0zXKQ7L6knI4mh1iY=;
        b=Rg0/1vtXJG7vueTT5pvMTD4h6NMDkrYaWbIVYLbMOyy1YoZtk9lURwXY4/v4PF1i6Z
         BALc07PZqsGSzZAR8fwYLVizF+SwVPaL+bCMIcPHXdOC2cyh/WMsxRjA3Im+Xww41VP0
         qMjBw1jMtmq0GCbajNVQ9Jd8OHIGiCIgFBSUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=aGgzHIwiwKkt4N+xEL5JlvBhLY0zXKQ7L6knI4mh1iY=;
        b=T55InQSH0Lt1XwAehq+aYsHpfU87u83YtRp1ehuxlKGHb7ECx/CduJsHx2wuXfpmOy
         0lPE3HuzpwOvJfHsWDKhoPJDySUIF73m23aclcEkT+3t/pCOKn/GujeY0vTSvv+Hy35r
         W7C3/EYPv0d++YTR2M/qXOxb3OwKF2LnzVu585HN2eJkNk9VRCnuGZSUO1G2WKRASx3j
         rJQ2ZB4W8rrBmwJ6tVN0b26jNmRsK2ZCmy6Ra1xxuT0JQvOKHvEFXUF/iMUIrZ0afYig
         0ABypDZ/UQW0k1OFyOxH7NRhbYuxN5yBNBsKbtvmAuyoKggsPAYK8sOcFGns77cvhL3+
         UCrQ==
X-Gm-Message-State: AA+aEWb9ODZU4e50GjJYQtR9T2GgeouUVrjBdWnQXbXc60LtpLa4MMpY
        drUFtxaH/v01OtlIMfpwRMcqBw==
X-Google-Smtp-Source: AFSGD/VwREKKEh0C/kk+7F0oE6BiVIujo6VXb+RAZ6rySMn1Dh4srUDEONU2KAVPGqgdoCP9xwlJug==
X-Received: by 2002:a1c:dd06:: with SMTP id u6mr2959934wmg.81.1544790118910;
        Fri, 14 Dec 2018 04:21:58 -0800 (PST)
Received: from dell (host109-155-202-221.range109-155.btcentralplus.com. [109.155.202.221])
        by smtp.gmail.com with ESMTPSA id t4sm5200331wrm.6.2018.12.14.04.21.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Dec 2018 04:21:58 -0800 (PST)
Date:   Fri, 14 Dec 2018 12:21:56 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Cheng-Yi Chiang <cychiang@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org, dgreid@chromium.org,
        tzungbi@chromium.org, Rohit kumar <rohitkr@codeaurora.org>
Subject: Re: [PATCH v2] mfd: cros_ec: Add commands to control codec
Message-ID: <20181214122156.GT4497@dell>
References: <20181206040540.84632-1-cychiang@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181206040540.84632-1-cychiang@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Dec 2018, Cheng-Yi Chiang wrote:

> Add EC host commands to control codec on EC.
> 
> Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> ---
>  V2 fixed the wrong ancestor issue so the patch can be applied cleanly on mfd tree.
>  Codec driver that uses these commands will be sent separately.
>  Thanks!
> 
>  include/linux/mfd/cros_ec_commands.h | 94 ++++++++++++++++++++++++++++
>  1 file changed, 94 insertions(+)

Would be good to have this reviewed by some more Chrome people.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
