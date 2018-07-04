Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0913CC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 06:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B80612468D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 06:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BIC3yytW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B80612468D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933314AbeGDGIU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 02:08:20 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:42714 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933206AbeGDGIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 02:08:18 -0400
Received: by mail-wr0-f195.google.com with SMTP id p1-v6so4024913wrs.9
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 23:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=2p8r88yW5K3RDEuDwut683tcLSZ8p0pvoyfq2MN4rlA=;
        b=BIC3yytWOWDxC9irPCjGvM2bJkV0hIsHe3cFs6yUEELoJfS8nG7Toxi30g19IkebEC
         F6iYVqsZmHfCIsavveLJNY0/l/YBh65SUugRjwwFV0dwLmqtWSWxN+/5u+fBYAzWkyAg
         fAJ6sb77BNXKzNmmcem+Au/LvYORO+eU0bcYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=2p8r88yW5K3RDEuDwut683tcLSZ8p0pvoyfq2MN4rlA=;
        b=OAV4Lz702qWPyQUZPuFhtpN0U9RsNeiAtQ0glkan3ZwjmPqFaSWLGeE0mTK0lJUYrB
         pnnGzf+RHcnC7LzArx/L/eNKefq1jfifRt+wfKk+JzAwUaac9PwESAvWDKWlbonyJqx1
         PxQmtFCwO5oWJnc0CMDjaDzTG7h/bvd5aME1SduVKwjwvXzXR/8xVX4B2vbCNbIjejLI
         KeQXQOcUaBQUilQP+w0mS+cuFLSWkDfsmZeaW/sistBpkSvf6VtkpeRS3YQTiE6XSLDs
         /w5A+Ahu3d/SrpeqYHMRjac6dxE97GFuKKS+qsr0EjaZe66wBXtrM8VLLE/X8buRNIem
         2+IA==
X-Gm-Message-State: APt69E2l0yknj1dEToRkNuVoOLQ364MtKFuv2h+01267Tyd97h+us5t7
        6nWUe6KOr+Bpw71H5ImVfVZGiw==
X-Google-Smtp-Source: AAOMgpcU+ZMBjAZX+Q+0nO1SajKfM8Qe80tWu532x4xbYYHHOw6BeUgST9rI30/MILr34OYR/ciNJg==
X-Received: by 2002:adf:a64d:: with SMTP id k71-v6mr481857wrc.78.1530684497819;
        Tue, 03 Jul 2018 23:08:17 -0700 (PDT)
Received: from dell ([2.27.167.87])
        by smtp.gmail.com with ESMTPSA id w2-v6sm5848270wme.45.2018.07.03.23.08.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 23:08:16 -0700 (PDT)
Date:   Wed, 4 Jul 2018 07:08:15 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Sameer Nanda <snanda@chromium.org>, linux-pm@vger.kernel.org,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        miguel.ojeda.sandonis@gmail.com, kernel@collabora.com
Subject: Re: [PATCH v4 1/3] mfd: cros_ec: Add USBPD charger commands and
 struct definitions.
Message-ID: <20180704060815.GT20176@dell>
References: <20180502154418.2153-1-enric.balletbo@collabora.com>
 <20180502154418.2153-2-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180502154418.2153-2-enric.balletbo@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 May 2018, Enric Balletbo i Serra wrote:

> From: Sameer Nanda <snanda@chromium.org>
> 
> The USBPD charger driver gets information from the ChromeOS EC, this
> patch adds the USBPD charger definitions needed by this driver.
> 
> Signed-off-by: Sameer Nanda <snanda@chromium.org>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
> Changes in v4: None
> Changes in v3:
> - [1/3] Use the BIT macro.
> 
> Changes in v2: None
> 
>  include/linux/mfd/cros_ec_commands.h | 132 ++++++++++++++++++++++++++-
>  1 file changed, 128 insertions(+), 4 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
