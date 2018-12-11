Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B83C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99A282081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="M9QBGGUr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99A282081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbeLKKSd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 05:18:33 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35620 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbeLKKSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 05:18:33 -0500
Received: by mail-wm1-f67.google.com with SMTP id c126so1617115wmh.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 02:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=97r2G8bSncO2WHzihT0LLl2E1BQ1gFxcBMzcoWPxSy4=;
        b=M9QBGGUrbWjUDVyiNvmfiTUTuFtNAXeQAzDrNlNRCf+gVg1BfMwP7pykh4hPQnmvby
         6zL/ZUN12D+s+A6AgNh96KY8fc2a8P+WRdwWOoSRA2bi6VLXeMmMDSp9GEUjiC49/czA
         nmgL82ofeeUgu3g1exTvJ5pnjotGbuRmNPWJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=97r2G8bSncO2WHzihT0LLl2E1BQ1gFxcBMzcoWPxSy4=;
        b=YNxQtbZzvJiMYJIEHY/ujD2egZ+21JbTlt/KQmAPsJOFd6cm9WPhJ0uvY6U4GwxDmT
         cj5Euszv7vQnSmuIVCTAUKz59yJ+DvsqhxgGa4HTbK4M7bq7QbgLmzTohl4bE3PlkzFB
         t2a/rr18z8EMWAi14RwnmYIB1IAz7AMD5cB+DRRL5X8oFYed9tqa/V0IidP3Uv45QXTW
         m98HPQsYL2qdXElRAECQQ8vXA1e4h3LijAPRuBkzkbc55GupZF3x9T4ReRIBynNy0T64
         KdfDqvCFh7I8lGNZMOQDJrDIWWLB4slyyyQJrP8b3m4U7/30j39wPaptvnW/bkhjvWCH
         cKQQ==
X-Gm-Message-State: AA+aEWa39NFT6tLjmf+59vp8wfUTyDfsX05sG/rFJ+W0c+LfeXfRM7+c
        zWxpIkn4ceKrD9tom69j/a14HQ==
X-Google-Smtp-Source: AFSGD/X+0EIHF3wfbpRJYbgcOdtgUDOsnpeEhcjDIdy7vWvSRpQu9fpD8lkR8onWa6auyUq1kDkRCw==
X-Received: by 2002:a1c:b515:: with SMTP id e21mr1764656wmf.82.1544523510322;
        Tue, 11 Dec 2018 02:18:30 -0800 (PST)
Received: from dell (host109-155-202-221.range109-155.btcentralplus.com. [109.155.202.221])
        by smtp.gmail.com with ESMTPSA id d4sm13384022wrp.89.2018.12.11.02.18.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 02:18:29 -0800 (PST)
Date:   Tue, 11 Dec 2018 10:18:28 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     groeck@chromium.org, gwendal@chromium.org, kernel@collabora.com,
        bleung@chromium.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] mfd: cros_ec_dev: Add missing mfd_remove_devices() call
 in remove
Message-ID: <20181211101828.GG4497@dell>
References: <20181210180002.4440-1-enric.balletbo@collabora.com>
 <20181211061207.GE4497@dell>
 <188dacba-9b4e-3884-d4b3-588b865a1f65@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <188dacba-9b4e-3884-d4b3-588b865a1f65@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Dec 2018, Enric Balletbo i Serra wrote:

> Hi Lee,
> 
> On 11/12/18 7:12, Lee Jones wrote:
> > On Mon, 10 Dec 2018, Enric Balletbo i Serra wrote:
> > 
> >> The driver adds different MFD child devices via mfd_add_devices() and
> >> hence it is required to call mfd_remove_devices() to remove MFD child
> >> devices.
> >>
> >> Fixes: 5e0115581bbc ("cros_ec: Move cros_ec_dev module to drivers/mfd")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> >> ---
> >> Hi Lee,
> >>
> >> I saw that you send a mfd-fixes pull request this morning, so sorry in
> >> advance for sending this too late. This was broken since the driver
> >> moved from platform/chrome to mfd (and probably before that), so
> >> it's an old problem. Note that I plan to send a patch series that depends
> >> on this to apply cleanly. If the patch is fine with you and there is any
> >> possibility to go in this version that will be good, if not, let me know
> >> if you prefer queue this in your for-next branch or if you prefer I
> >> include the patch on the series I plan to send on top of it to not mess
> >> things.
> > 
> > It wouldn't have made the v4.20-rcs anyway.  Even if you did send it
> > earlier.  I only send fixes to that -rcs which fix issues introduced
> > during the current release cycle.
> > 
> 
> Ok.
> 
> > If memory serves, doesn't this driver now (or will in the very near
> > future) use devm_* for device creation?  That would make this patch
> > either incorrect (should be devm_mfd_remove_devices() if really
> > required) or moot?
> > 
> 
> I think you have in mind this patch [1], right? Note that in this patch we're
> using devm_* for cros_ec driver, _not_ cros_ec_dev driver which is different.

Ah yes, that was it.

> For the cros_ec_dev driver we need to take care with device managed allocations
> as explained in the last fix merged [2]. For the cros_ec_dev I was trying to no
> mix device managed allocations with non-device managed allocations, and as we
> can't use devm_kzalloc in this case, I thought that was worth use the
> mfd_add/mfd_remove functions like is now. Makes sense? What are your thoughts here?

The patch is fine then.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
