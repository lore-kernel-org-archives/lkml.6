Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F24EDC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B63062145D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lhGsdTBR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B63062145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbeLCWh7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 17:37:59 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44475 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbeLCWh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 17:37:58 -0500
Received: by mail-pl1-f193.google.com with SMTP id k8so7184621pls.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 14:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=6VVxs18S4oUCIOwDqzTd6DdWb6oO14nazZ1YUdkXrUk=;
        b=lhGsdTBR1kYT5yGlQrnIRj8X410fCp40QmIQpajFqiivd9ym2Nr3vvizjRjZWvtc0Z
         J+aV10jnvbdYouAK4d1BBOZc1EndPDFj1AYxcmpRXAdPYSH9Rb294KUT8qbMMzyBxBAm
         wB1yyL8fCefJa/cHDIh9BISPDRn6prdj45oQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=6VVxs18S4oUCIOwDqzTd6DdWb6oO14nazZ1YUdkXrUk=;
        b=fqLBfCk+5nWYSXDXSLcL/fs7o5fh2xowDQYVsr8KA2A3pdeEkn2O9REsCKwNbsHGie
         uZKI4Hx0w/oi10upe/2TdXfRjjzXZTz1SCPdMEbJUUVRr1k8JcDOsO/1EGPD4hpw2ZVM
         h/Wcsh5r607M9UEwuOj8b2TTGBUd7NI5dUZyonG0ZWP4GEjYLjCBp24Z7mVsIFFChDfe
         NXkS6Pnv9IVQQjucfce5yeMEiKxJdnrJyoM3gvJTiRfgCF6c4lE+L+i3ewHMRG4hzMcr
         1FE/f/J4MIF/smycuChxHqRZPKlnOq1Icy63nbm7M4V9pwzyjL54E3L/1vzRS/AP+/9B
         C5xQ==
X-Gm-Message-State: AA+aEWYJwA1CFwUqhNodYk1x3v4Wxrs25kq5BYdeYjC49BNfsu8T38PI
        /p38CUl2hT9zGI/xX/NDEXY/Jw==
X-Google-Smtp-Source: AFSGD/WlvFPC7qHY9ggApYyVHp+SuZyBHjCiKZvgLt+2p+/qP/rseH/pFaCt3JKcNFydxDKP55dsnw==
X-Received: by 2002:a17:902:a40f:: with SMTP id p15mr18099829plq.286.1543876677478;
        Mon, 03 Dec 2018 14:37:57 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fed3:9637:a13a:6c15])
        by smtp.gmail.com with ESMTPSA id 79sm15922712pge.66.2018.12.03.14.37.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 14:37:56 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Andy Gross <andy.gross@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20181129221357.67417-4-evgreen@chromium.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Evan Green <evgreen@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org
References: <20181129221357.67417-1-evgreen@chromium.org>
 <20181129221357.67417-4-evgreen@chromium.org>
Message-ID: <154387667618.88331.14674785921714656321@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v1 3/4] arm64: dts: qcom: sdm845: Fix QMP PHY #clock-cells
Date:   Mon, 03 Dec 2018 14:37:56 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Evan Green (2018-11-29 14:13:56)
> Move #clock-cells into the child node for instances of the qcom-qmp-phy
> nodes, and set it to zero, in accordance with the proper bindings. PHYs
> that don't provide clocks don't have #clock-cells, and so are left alone.
> =

> Signed-off-by: Evan Green <evgreen@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

