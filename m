Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A148FC67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63A7C2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RT0NBp9b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63A7C2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbeLKV2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 16:28:25 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40486 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbeLKV2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 16:28:24 -0500
Received: by mail-pl1-f194.google.com with SMTP id u18so7510037plq.7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 13:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:message-id:to
         :subject:from:user-agent:references:cc:date;
        bh=YmFFaEwmr2laf5nkE1g+Y8Ng0DLsvEPIMUh8XUsBtpw=;
        b=RT0NBp9btJsS9ISXN5YXNayPFrsYwaAJxmvRItiglHcydfpa5wQV1IUcPzHfRX3hik
         5otOc6Di3s4VSc9eblLqpke/VwFWZSKcub89YbG/0M1p6/c2qVPYtKZkbCkeWozJmHtw
         J6Kj9isJu5lfMGGVhMCIIYv5Djjz8Y0qTtzo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:message-id:to:subject:from:user-agent:references:cc
         :date;
        bh=YmFFaEwmr2laf5nkE1g+Y8Ng0DLsvEPIMUh8XUsBtpw=;
        b=hqm5/ueSmy+tuEjOBbXcNo5gX16PYOZxXAvYR+XtIkTKAy5NZsIo9mqwVAxVNWF761
         c8ee7NI+pZLylozXqgmmfv889VW+rXQjdfjM1uzv9qI4pWIAOBKIwxJAWu67SwxTIHIM
         KzyKqC2mDQlSSK3kPbSvLYDsS1FDVAlv9e50BMfS5RN0DyrPxl0rNRkJOl7j7Nn1KHle
         ELKEnIILvq5hfk9rJU3YGJxfuuMrWLzhuAWcA90CNzp49lTvn0DaKlPTEpR/d5Mso8gs
         HC3NMbll+albj2+1ScqtY8jONN1Oec4wo+0BNN2GzkqFZhHhEUnSrmR/nQ/6y0yCl2LW
         IX0A==
X-Gm-Message-State: AA+aEWbWIUgRH/jPp7zYDhBt4JqpbF4WP9FQfu1Ti5cGGutd8IFe5vcZ
        gtdci/EPe8Y+qxIYyRxhqRRPDGIZH0MGZw==
X-Google-Smtp-Source: AFSGD/XLuGhP1e2b4llJUZPz6KZe8hs9iv3U4dGoGDU5tGYwMJAtVcAN6DDcDMDuG63uSC1K0elu/g==
X-Received: by 2002:a17:902:7044:: with SMTP id h4mr17336461plt.35.1544563704251;
        Tue, 11 Dec 2018 13:28:24 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id f32sm17435876pgf.80.2018.12.11.13.28.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 13:28:23 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20181211094938.25086-3-rnayak@codeaurora.org>
Message-ID: <154456370272.17204.6645828270509587215@swboyd.mtv.corp.google.com>
To:     Rajendra Nayak <rnayak@codeaurora.org>, andy.gross@linaro.org,
        collinsd@codeaurora.org, mka@chromium.org, robh@kernel.org,
        ulf.hansson@linaro.org, viresh.kumar@linaro.org
Subject: Re: [PATCH v6 02/10] dt-bindings: power: Add qcom rpm power domain driver bindings
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.7
References: <20181211094938.25086-1-rnayak@codeaurora.org> <20181211094938.25086-3-rnayak@codeaurora.org>
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>
Date:   Tue, 11 Dec 2018 13:28:22 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajendra Nayak (2018-12-11 01:49:30)
> Add DT bindings to describe the rpm/rpmh power domains found on Qualcomm
> Technologies, Inc. SoCs. These power domains communicate a performance
> state to RPM/RPMh, which then translates it into corresponding voltage on=
 a
> PMIC rail.
>=20
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

