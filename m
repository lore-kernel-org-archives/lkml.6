Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2115C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 18:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5959D21570
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 18:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KB5HpleQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5959D21570
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbeHTVfa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 17:35:30 -0400
Received: from mail-pg1-f172.google.com ([209.85.215.172]:44384 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbeHTVfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 17:35:30 -0400
Received: by mail-pg1-f172.google.com with SMTP id r1-v6so7168235pgp.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 11:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=UIvGdfkJASDQGOLB5J9k9je0aTMk2YmIKQZKVH4qvkU=;
        b=KB5HpleQjLarj5CiW6kJcYc85tvqg3TIC2E4KcjfopzSWYLYQtLYPIrZ144NEI+dD2
         SWsLorSy5yreCE/sGGhhYEpfVjxerW/ZSnPkk27ua7uSABI37jTRkkg7wKlWMMXrPJEO
         GWaWk1G5feNPN9hTCj2Ywx+lyUCPjYxryegN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=UIvGdfkJASDQGOLB5J9k9je0aTMk2YmIKQZKVH4qvkU=;
        b=uDDhrhkLpx3D4vWwzE31c7Qa/FEdPHzyGjwBpvkZ8mk42XAxB5k/4z+qGRf5XlFvWf
         ThdAknFyQlwV7a6RyNXqWpGUTCinuK54xDFjCkgHjexI0KnGXalJoAgN8+LNkXB171HL
         Zx4+mjfgT7ujVgi0NDlYIR8UKASZ97oDWsEqU0rgAW/ypHPAQm/t/wMNAh5EUT5Vvjn0
         u6hjIatCbwMKygLfqxISYSbMnI8xqOlvMuhGkVVV46FzRokyCZF2roseKZCdpUypoXpN
         cU0mYB8t3ygOL2M8pIfeVhn+7ebBI4VeyyPv6QyO75AHghavcK5qssQ9ZYFiCMxD2zer
         7/zQ==
X-Gm-Message-State: AOUpUlEQAPXkMV9R2blrqOEr78LdWTJdfILMYWELaOedY8pJsNlfhdFC
        QOLLbokWjfU3epTWHnzewA16BQ==
X-Google-Smtp-Source: AA+uWPyIu0amXJ212BikuyXQFQbjfstDEPJodI18XzkbGnV1euPTRgeSpkrhsFjW0z/ogPFbT4LV8w==
X-Received: by 2002:a62:2c95:: with SMTP id s143-v6mr49277173pfs.3.1534789128580;
        Mon, 20 Aug 2018 11:18:48 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id x87-v6sm16863736pfa.143.2018.08.20.11.18.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Aug 2018 11:18:48 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Andy Gross <andy.gross@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20180810215150.82490-3-dianders@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>, tfiga@chromium.org,
        Manu Gautam <mgautam@codeaurora.org>,
        David Collins <collinsd@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
References: <20180810215150.82490-1-dianders@chromium.org>
 <20180810215150.82490-3-dianders@chromium.org>
Message-ID: <153478912722.28926.1278085207557745493@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 2/3] arm64: dts: qcom: sdm845-mtp: Add RPMh VRM/XOB regulators
Date:   Mon, 20 Aug 2018 11:18:47 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2018-08-10 14:51:49)
> @@ -20,6 +21,450 @@
>         chosen {
>                 stdout-path =3D "serial0:115200n8";
>         };
> +
> +       vph_pwr: vph-pwr-regulator {
> +               compatible =3D "regulator-fixed";
> +               regulator-name =3D "vph_pwr";
> +               regulator-min-microvolt =3D <3700000>;
> +               regulator-max-microvolt =3D <3700000>;
> +       };
> +
> +       /*
> +        * Apparently RPMh does not provide support for PM8998 S4 because=
 it
> +        * is always-on; model it as a fixed regulator.
> +        */
> +       vreg_s4a_1p8: pm8998-smps4 {
> +               compatible =3D "regulator-fixed";
> +               regulator-name =3D "vreg_s4a_1p8";
> +
> +               regulator-min-microvolt =3D <1800000>;
> +               regulator-max-microvolt =3D <1800000>;
> +
> +               regulator-always-on;
> +               regulator-boot-on;

Can vin be vph_pwr? That would properly model this.

> +       };
> +};
