Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57339C6783B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A96C20672
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="L5PI3YSo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A96C20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbeLKWBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:01:34 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33532 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbeLKWBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 17:01:33 -0500
Received: by mail-pg1-f196.google.com with SMTP id z11so7290383pgu.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 14:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:message-id:to
         :subject:from:user-agent:references:cc:date;
        bh=5YChTIQPPfqv835ud/qXiHMYmguAlXIBzbpIu//BHuY=;
        b=L5PI3YSoeSLcEEnq29mkaS7JYbntK3xpDGvHl8NklAfRK5sn2n7ltnscEqqgPsQoOu
         Maa/xnpPwjaXxiJ2j38nMZ+VWI8m4PFbSIurR8kXuOHOax3RXWSCWJ3tyMMqhhhL+jJd
         vOIIhw/n7o3iwcdNbD/T70kdqGV94ScJNgzuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:message-id:to:subject:from:user-agent:references:cc
         :date;
        bh=5YChTIQPPfqv835ud/qXiHMYmguAlXIBzbpIu//BHuY=;
        b=jn1xwntxqbRWiJ1SXFYtrC5jtaUkc3YcWHBiDm1Gs0lENeoOB7gnA9rriTzcOQbx8/
         NCY4nrDLd9mvWgFBCKpjmK7bACtZTmDvyrEXwmCRBf1VXjilX85k40iJjjwNAMUmslTh
         MaRd2lu54lWUuJb1IwY/X34g3twz7z9xeTnrOYhWNBiXwR1wDYThaQbLHlfbaczA85b6
         G/Qd5eNJSSmsIbl8gCkyXnByujUO3rAMloDHwoMi1+0gF437ZtQLLcg596Act8qwLOeO
         qQmYmn4jOF+7T/nPysuHopJggTwCarWQSmuiW2VFBTsF/4wLJ7Kx3od3d/dL43L4wdMx
         dUIw==
X-Gm-Message-State: AA+aEWYjCMShtYVlcUDJFKwxg2jwBO0qIlPRyivcsRxo7d11/E7y3dIh
        EMm5rX67oMpwktVe7BQBlnFTLg==
X-Google-Smtp-Source: AFSGD/XvyLR/0xQ2kdeNlHJk/Y7tfBPQfdtIgupBF5ck3E08iloXOJl54BrnsNhGbS20woZEoaMW8Q==
X-Received: by 2002:a63:a51b:: with SMTP id n27mr16462461pgf.17.1544565693160;
        Tue, 11 Dec 2018 14:01:33 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id e9sm19291745pff.5.2018.12.11.14.01.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 14:01:32 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20181211094938.25086-8-rnayak@codeaurora.org>
Message-ID: <154456569181.17204.93182422859848145@swboyd.mtv.corp.google.com>
To:     Rajendra Nayak <rnayak@codeaurora.org>, andy.gross@linaro.org,
        collinsd@codeaurora.org, mka@chromium.org, robh@kernel.org,
        ulf.hansson@linaro.org, viresh.kumar@linaro.org
Subject: Re: [PATCH v6 07/10] arm64: dts: sdm845: Add rpmh powercontroller node
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.7
References: <20181211094938.25086-1-rnayak@codeaurora.org> <20181211094938.25086-8-rnayak@codeaurora.org>
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>
Date:   Tue, 11 Dec 2018 14:01:31 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajendra Nayak (2018-12-11 01:49:35)
> Add the DT node for the rpmhpd powercontroller.
>=20
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

