Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF74C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 07:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E14D72243E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 07:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AfdZ9kb6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E14D72243E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731216AbeKMRyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 12:54:13 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55728 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728379AbeKMRyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 12:54:13 -0500
Received: by mail-wm1-f68.google.com with SMTP id i73-v6so5551130wmd.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 23:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=kF4k6mB5s3YEbDvG1rzcFegqnlbkBTeSfzzPsTM2jBU=;
        b=AfdZ9kb6MMLYCkIkhrdvQc3pITlG7gBpS60hYZKs++lXil2Yn6Rm6s2tVcWTcaEVDV
         SaZSptO4JK40/8ZTh62lmrW5ndDWJ4KlGk9ZFHoYFdroPUVZzaMJp0SFj515aye8sH+A
         eVth39Obk6gY0XQzbH0HC5jqZLpR8boYKS3yE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=kF4k6mB5s3YEbDvG1rzcFegqnlbkBTeSfzzPsTM2jBU=;
        b=mRNdqunqQshAVChn4YDnVdqGf7NDRz7V2ZNxwjroDGHm+wvWfxehSnEiOpRtOoV/CU
         wVWsEk4Rz3Bi9RYiI17/FhKeF7RnAliii1cpeg4hDEy397XlEELYp9gc18lRi4cjrYPe
         nsvi1bkH5jkAGw4u2YheYDFtfYQOzffGOLYQBqhlv1o1dJ+R5bgAT96sSZodWAQxTii7
         93kpAUo36les4r5HsgnZnozELEsjatkm5C/r0/gnS+786XiSzetlgp8Cp3POwxfpkgFm
         Xozdzjqdpx+ER0LhT6X96fDx0EyMOrFaUyZBLjbAs/tTiN1LULTv1GNCFfmNESTYpAVI
         HXKQ==
X-Gm-Message-State: AGRZ1gI6XbhUhD54ZPtoYTTDp61GGnq06zLhDurEkmlaXZo1rHZEy1kG
        iT9ag1giIz7/XPpzgrRAR/PkMg==
X-Google-Smtp-Source: AJdET5dqOIssP+v3kD/tnxhrU8lZ1YalTun9usyM/23A3/+bhRPvEVChNs8+Me6YRh/tVhtUw4ziCQ==
X-Received: by 2002:a1c:adc2:: with SMTP id w185-v6mr2224693wme.103.1542095837004;
        Mon, 12 Nov 2018 23:57:17 -0800 (PST)
Received: from dell ([2.31.167.205])
        by smtp.gmail.com with ESMTPSA id x194-v6sm39358770wmd.41.2018.11.12.23.57.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Nov 2018 23:57:16 -0800 (PST)
Date:   Tue, 13 Nov 2018 07:57:14 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>, linux-kernel@vger.kernel.org,
        Olof Johansson <olof@lixom.net>,
        Shawn Nematbakhsh <shawnn@chromium.org>,
        Alexandru Stan <amstan@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        RaviChandra Sadineni <ravisadineni@chromium.org>
Subject: Re: [PATCH v2 1/2] platform/chrome: straighten out
 cros_ec_get_{next,host}_event() error codes
Message-ID: <20181113075714.GF29388@dell>
References: <20181108024939.174321-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181108024939.174321-1-briannorris@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Nov 2018, Brian Norris wrote:

> cros_ec_get_next_event() is documented to return 0 for success and
> negative for errors. It currently returns negative for some errors, and
> non-negative (number of bytes received) for success (including some "no
> data available" responses as zero). This mostly works out OK, because the
> callers were more or less ignoring the documentation, and only treating
> positive values as success (and indepdently checking the modification of
> 'wakeup').
> 
> Let's button this up by avoiding pretending to handle event/wakeup
> distinctions when no event info was retrieved (i.e., returned 0 bytes).
> And fix the documentation of cros_ec_get_host_event() and
> cros_ec_get_next_event() to accurately describe their behavior.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
> v1 -> v2:
>  * don't make as many changes to the API -- just fix the documentation
>    and a few corner cases instead
> ---
>  drivers/platform/chrome/cros_ec_proto.c | 4 ++--
>  include/linux/mfd/cros_ec.h             | 6 ++++--
>  2 files changed, 6 insertions(+), 4 deletions(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
