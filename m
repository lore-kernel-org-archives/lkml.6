Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD8FC65BB3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 15:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E81820821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 15:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ggvm593w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E81820821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbeLJPsd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 10:48:33 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46371 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728050AbeLJPsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 10:48:32 -0500
Received: by mail-pg1-f194.google.com with SMTP id w7so5125414pgp.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 07:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:message-id:to
         :subject:from:user-agent:references:cc:date;
        bh=1WdapvGftWa4pFwAmHPDiEEP2JM0Q8a641hz+W76T5E=;
        b=Ggvm593wdvGY8LaiWA9LNSd3WlBYZagPFsGGAFlM3b9HmjNRRlXHFJjODQLa2+8xE4
         Dg5BUrPTHn3wXLT/LM5AG4cY2wLssaehcgtzFBhsJQ02rLnBPcnTIp9TlCO6lLpwDVVR
         Hib90gXBjCJVx+CWij1XY5tkf5AEhCdByBBt4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:message-id:to:subject:from:user-agent:references:cc
         :date;
        bh=1WdapvGftWa4pFwAmHPDiEEP2JM0Q8a641hz+W76T5E=;
        b=Q+l7N9C5s7oEpdN2mh3kErqe1j3PMu95c61arMUgtuMw7KW/JQy/hyDMpDft7s1DEa
         gTVi8+eFKsQ2k2U4i8LCB49QwneYnIW+gpTAYD1x4MXiM/ayVujXtK4yoO+Vz1V+z/KM
         CK3n2XA/drIwHyT0DieLy/5BcZT1HTkC/L6xFtgciWuHPpxw7aWIcdg2jL7lCVF0scxb
         gUtFSjUTdOh10Z6X+nMMD1+kEg1gB+Ta7BnR1vV1utlmmmmmNHlWVLwLYhFdNaEW6L4G
         VLCA4mqPVOZAhCFxG3bJvcXoPkZxVtqOEt/Fdq09/4C0IvkDL8ev7uJxcqO9z/FIzxAx
         iiIA==
X-Gm-Message-State: AA+aEWYOLa+Wm2wryLB40bWerGKUHNIUnz3HF2YtrXpy8l5x/ZfxicSC
        1+7Opi3dBr9bwK1ab2XKAOx4RA==
X-Google-Smtp-Source: AFSGD/VqlnBF8C5qFN/92Ks9FPfz3NE0b1qaouXFbpqr8F2k5LVLV4grDbh9OaiuZ0CnqKB/ei85gQ==
X-Received: by 2002:a62:6ec8:: with SMTP id j191mr12820701pfc.198.1544456911099;
        Mon, 10 Dec 2018 07:48:31 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id m67sm18465673pfm.73.2018.12.10.07.48.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 07:48:30 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20181204224234.62619-4-mka@chromium.org>
Message-ID: <154445690968.17204.295486606980854208@swboyd.mtv.corp.google.com>
To:     Andy Gross <andy.gross@linaro.org>,
        David Airlie <airlied@linux.ie>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v4 3/8] drm/msm/dsi: 28nm PHY: Get ref clock from the DT
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.7
References: <20181204224234.62619-1-mka@chromium.org> <20181204224234.62619-4-mka@chromium.org>
Cc:     Archit Taneja <architt@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        Rajesh Yadav <ryadav@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>
Date:   Mon, 10 Dec 2018 07:48:29 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matthias Kaehlcke (2018-12-04 14:42:29)
> Get the ref clock of the PHY from the device tree instead of
> hardcoding its name and rate.
>=20
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

