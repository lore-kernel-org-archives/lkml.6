Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F77C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8401120851
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Et7i7PWm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8401120851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbeLLSYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 13:24:31 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36509 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727748AbeLLSYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 13:24:31 -0500
Received: by mail-pl1-f193.google.com with SMTP id g9so8977818plo.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 10:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:message-id:to
         :subject:from:user-agent:references:cc:date;
        bh=cDzhxRq46/oaKKpCrFkIBfVNUHpNfsOzKvD7Dttni0Y=;
        b=Et7i7PWmpQ+5jTQTpVyN+g4I1nZB3cC0v3R/ezd88ONDfHMtr2VSeHrE6704qBMgtZ
         tCX5f2Bhk6V5wFqOJ+4nLId7mwEovVwZZvQcK0ksuFBlRDGDl1zM1b8wE7tI7CsZGnc3
         R3SBtWVFNl+NC/XTQfhU8ooZQGSzDYbZQUxvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:message-id:to:subject:from:user-agent:references:cc
         :date;
        bh=cDzhxRq46/oaKKpCrFkIBfVNUHpNfsOzKvD7Dttni0Y=;
        b=JT39mi7i5C+tCCx2mPTsJHAZ3mE9QqczjdnHh15hckehqLLwm2UV/c7TsYsZtyZIz/
         t/+uEZU3vkyCFWMa1lWJz48SpO3RGBKRO+GqYlsJ0cLWDvc8A9fp+kUCbLShJPwm9ZdT
         36BNtM/1TS/YBP1ZpzRk4QFB92LplU/cRccHyt2a5yMGc99SCToU8bvdyLF83EGWchvW
         /XoM+fsZY7R2lywRbKULl2GBRVR/pH9abs5cgLy8rnMkZM3cfXhwwGdC2uZ/VXYKG/MX
         I5+pEFRaePCD6MghZeoPAYv1i6lHE/YbzWyBkeHo6t1zQZ6owdG/RsmcJbTbOI1VumAO
         286Q==
X-Gm-Message-State: AA+aEWalWbVZAroWOUU+RYYHM82nxEX8AomHgBwj5G/C0tOLn/ToeJ1z
        b6uzWrrU21ctseiW4Qn6nJmbyg==
X-Google-Smtp-Source: AFSGD/XvICYi4YQYdzIc6YpCm+siM/2XY8CI25GZUdinK6uX84WbnmIpNoo1iY/l2ERlLCTU/Hd/ag==
X-Received: by 2002:a17:902:8f83:: with SMTP id z3mr20177990plo.328.1544639070565;
        Wed, 12 Dec 2018 10:24:30 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id t5sm25097184pfb.60.2018.12.12.10.24.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 10:24:29 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20181212092131.13046-5-rnayak@codeaurora.org>
Message-ID: <154463906912.17204.17710484967045556798@swboyd.mtv.corp.google.com>
To:     Rajendra Nayak <rnayak@codeaurora.org>, andy.gross@linaro.org,
        collinsd@codeaurora.org, mka@chromium.org, robh@kernel.org,
        ulf.hansson@linaro.org, viresh.kumar@linaro.org
Subject: Re: [PATCH v7 04/10] soc: qcom: rpmpd: Add support for get/set performance state
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.7
References: <20181212092131.13046-1-rnayak@codeaurora.org> <20181212092131.13046-5-rnayak@codeaurora.org>
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>
Date:   Wed, 12 Dec 2018 10:24:29 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajendra Nayak (2018-12-12 01:21:25)
> Add support for the .set_performace_state() and .opp_to_performance_state=
()
> callbacks in the rpmpd driver.
>=20
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

