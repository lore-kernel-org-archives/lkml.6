Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C91E2C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 05:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FBC6208E7
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 05:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dBDJWbdI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FBC6208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbeLNFgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 00:36:22 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37627 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbeLNFgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 00:36:22 -0500
Received: by mail-pl1-f193.google.com with SMTP id b5so2193937plr.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 21:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:subject:to
         :references:message-id:from:user-agent:cc:date;
        bh=lF2oRRwLLKL5KN/PXRblmH3VY3fkQ6GpnFDnIRukYAA=;
        b=dBDJWbdIXQKIIDcfM4QLe1mpUvakzubvXMPgSMz7z3k3TKz28aMEMsYyJBu4O5Zcd5
         ouo7v15hD0zZ2aQ5qOnunI8PYPI2ehfQfn5w/a/GwZczKhCoCsps4t3WpeQ3EP6eXME/
         ELwNRq6Fh6eq10MSm1S+BjQPQPcoAr+mLNdTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:subject:to:references:message-id:from:user-agent:cc
         :date;
        bh=lF2oRRwLLKL5KN/PXRblmH3VY3fkQ6GpnFDnIRukYAA=;
        b=H7IKEsY/Ip7AMZgLjR95zvuAquJgz7BW5SZpSJRXgwcOYoZQTZRxpJBsP/VSgsXP6M
         byKS8sh/6EHhHWuMy0Q5SnZHdJEqhl7PU5G1DV4YOpS7xkqsYP8/R8lbSCj8PjcBnSeX
         c2MCjSsS4LE8KRM02nJ8zXhplWdBjbtm+hUCv0DEPio7K+DH9+z4hrhhIi4FvCVMcgNI
         TGOtjahRX5PckuI4ISDoGQsOkMg95CWA8nwt1pOogd6JA/UoidaY61enaVFZLwyn7ASD
         O1pr7uFiIpLoMG50huNGTxwPX+aTLanMn4Hxr50kZTluJDpWFOqWgrotcg5VaW1Tghd2
         f1YQ==
X-Gm-Message-State: AA+aEWbusvgevGg/i/XEBxGavr+8vn6h4OBxmRnsGuB+jQgi56USQRyr
        dcsXHrd6V/wtdcWcqMOpdX5Uag==
X-Google-Smtp-Source: AFSGD/XR8mtL8pCuM3j6UTvRCyru3XBmpZtAXwYCuFQlnYZeBHpsszr7W92X4JXsEGheHIjrTVs4eA==
X-Received: by 2002:a17:902:aa8c:: with SMTP id d12mr1670079plr.25.1544765781478;
        Thu, 13 Dec 2018 21:36:21 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id g190sm4224846pgc.28.2018.12.13.21.36.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Dec 2018 21:36:20 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1544760624-12874-3-git-send-email-tdas@codeaurora.org>
Subject: Re: [PATCH v13 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq HW driver
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Taniya Das <tdas@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <1544760624-12874-1-git-send-email-tdas@codeaurora.org> <1544760624-12874-3-git-send-email-tdas@codeaurora.org>
Message-ID: <154476578010.19322.1755200407546472686@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8
Cc:     Rajendra Nayak <rnayak@codeaurora.org>, devicetree@vger.kernel.org,
        robh@kernel.org, skannan@codeaurora.org,
        linux-arm-msm@vger.kernel.org, evgreen@google.com,
        Matthias Kaehlcke <mka@chromium.org>,
        Taniya Das <tdas@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>
Date:   Thu, 13 Dec 2018 21:36:20 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2018-12-13 20:10:24)
> The CPUfreq HW present in some QCOM chipsets offloads the steps necessary
> for changing the frequency of CPUs. The driver implements the cpufreq
> driver interface for this hardware engine.
>=20
> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Tested-by: Stephen Boyd <swboyd@chromium.org>

