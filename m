Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 758E5C04EBA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 09:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31A3E2146F
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 09:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PRCdZlCs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31A3E2146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbeKUTd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 14:33:58 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33353 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727566AbeKUTd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 14:33:58 -0500
Received: by mail-pl1-f195.google.com with SMTP id z23so4575837plo.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 01:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=SFGUiStujf5wvh3nJrKTmjksqfmzQg7H3bcVPePRWB8=;
        b=PRCdZlCsWgOntbiwsIrsZ5SuZxHJUqJG3broeVWWXrGtMO6F+ohKVyjGNFpi8438SC
         MAgiKy6EJkBExCL9HPjb28zfxzjGc85OB9YxyAXKhTBbKho4B9DTVKDWED4F4Uw5cc0E
         Hr7G2/y/GuMXoNToHMhk9I2dBWIJ+HrfGs3uc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=SFGUiStujf5wvh3nJrKTmjksqfmzQg7H3bcVPePRWB8=;
        b=VswOwfprSgNvRln7epae90PQQJ3JD7ZFDu7YHoahD2e8Mauw763jIAUNlugeVQE0qv
         B5Kd/gMD7HEbIVlPqSRO4GzGggUZgz4rKh4cFJ4s9VQiBfTDnc5v+mAaQnxOA66Uvou5
         kcttDSOhDfXDFEf8Sn1ejxT0MzJyOU7hPlKXnQNx3ml791DZED+MeEmw5nxgz+sMTQdH
         sroZvJJQ64RCKT25xxP39/FVrx+VLhgn4IiFzIzFUDuUcZ781W8CxQNVf3SMt+3+Stfz
         vYeEBD00g/Bn0lOp+LV+XtsQe2stBL0m1Go7P89wlzctZxgHxFwOXWQl+X/RyB3mQ5zD
         nWWQ==
X-Gm-Message-State: AA+aEWbKDu1KDAEdzezUETUQm0VBnvnZk7/r405SMn5xTwQHWUc7bgZL
        f34WyRhz4h3/zboy+P8WxBjXoeLF8nY=
X-Google-Smtp-Source: AFSGD/VXSVCvDj2tGNjf7T1ga+6FrUwE8lfMKU4DFskE/hDAMgSJZKuWxUNPqJ2A09r7MBi2fFoh9g==
X-Received: by 2002:a63:151f:: with SMTP id v31mr5120336pgl.34.1542790819181;
        Wed, 21 Nov 2018 01:00:19 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fed3:9637:a13a:6c15])
        by smtp.gmail.com with ESMTPSA id x7sm46370014pga.68.2018.11.21.01.00.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 01:00:18 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20181105194011.43770-2-swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Taniya Das <tdas@codeaurora.org>
References: <20181105194011.43770-1-swboyd@chromium.org>
 <20181105194011.43770-2-swboyd@chromium.org>
Message-ID: <154279081676.88331.1516496381312386439@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 1/2] dt-bindings: clk: Introduce 'protected-clocks' property
Date:   Wed, 21 Nov 2018 01:00:16 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2018-11-05 11:40:10)
> Add a generic clk property for clks which are not intended to be used by
> the OS due to security restrictions put in place by firmware. For
> example, on some Qualcomm firmwares reading or writing certain clk
> registers causes the entire system to reboot, but on other firmwares
> reading and writing those same registers is required to make devices
> like QSPI work. Rather than adding one-off properties each time a new
> set of clks appears to be protected, let's add a generic clk property to
> describe any set of clks that shouldn't be touched by the OS. This way
> we never need to register the clks or use them in certain firmware
> configurations.
> =

> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Taniya Das <tdas@codeaurora.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---

Applied to clk-next

