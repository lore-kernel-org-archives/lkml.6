Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5764DC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1856320851
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J3giom00"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1856320851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbeLLSZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 13:25:06 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38566 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727910AbeLLSZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 13:25:05 -0500
Received: by mail-pf1-f195.google.com with SMTP id q1so9256455pfi.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 10:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:message-id:to
         :subject:from:user-agent:references:cc:date;
        bh=KklImKhCIOZTpjxLQ96DhMUFVIH5cBYodmkuymMMMx0=;
        b=J3giom00/z4ZZVmg7+7cvm56/6DUO/YOqAYy/ZU74TxsITfQhIH4mqSHgkKK81n3Sa
         e2i0hXzEU2b1078KaMEw8BaIsnZSYqO0sjIoekWaO3/ZuxT4htQJMtHBZEJz4xvui1zn
         yGTcSUrrHoccixlTOyo03enJTlJzB4Ar6eiyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:message-id:to:subject:from:user-agent:references:cc
         :date;
        bh=KklImKhCIOZTpjxLQ96DhMUFVIH5cBYodmkuymMMMx0=;
        b=CiTtdYeb+p6+Ok4VtDGLYZ+mnWO/WQgf/rhXJyq4hbJIuZGE7zij+8ffusw9YPI3e5
         YlMXLf8mzGSEWUgsAlOWRDO9hfC+IbRC6AOYpU9y9gUEWe74k/wmqdAexssNj9rUjfRR
         FWTuIIFQHuR7s2s7Hp2VBSDAWYYJpUwI6eVtc5fI64lTpT7FtoOmDCeZNjNNfGEEvtLP
         IFf/uIl4lDo2uCWd46LDa42SUSaX8EKE65Kd2dQPDSRhZFLIn+fOk55mQRVjxlvjWGqJ
         Nntmr7Mez9lMIpQB3GYnG33ed5EKYCvBShCDkX7WpYdxTCXq/mVEuKntHkcv12vLx5Oe
         mLcg==
X-Gm-Message-State: AA+aEWYZ0vslXJakwaT+8hDCNi4YWmZCIGEpOayTIUdvjG9keB+S6Juh
        ++hf5Myc46Ii2nc3GRYq0oQDTQ==
X-Google-Smtp-Source: AFSGD/UXnxuCxiJ9YFSEviFicydcURW3EIf7RD7HMa/tGI+k5IcIkVnAoxJMtqqjRLnzZXKIwq/FdA==
X-Received: by 2002:a62:b15:: with SMTP id t21mr22045052pfi.136.1544639104934;
        Wed, 12 Dec 2018 10:25:04 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id v89sm28075923pfk.12.2018.12.12.10.25.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 10:25:04 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20181212092131.13046-7-rnayak@codeaurora.org>
Message-ID: <154463910365.17204.887912933771153560@swboyd.mtv.corp.google.com>
To:     Rajendra Nayak <rnayak@codeaurora.org>, andy.gross@linaro.org,
        collinsd@codeaurora.org, mka@chromium.org, robh@kernel.org,
        ulf.hansson@linaro.org, viresh.kumar@linaro.org
Subject: Re: [PATCH v7 06/10] soc: qcom: rpmhpd: Add RPMh power domain driver
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.7
References: <20181212092131.13046-1-rnayak@codeaurora.org> <20181212092131.13046-7-rnayak@codeaurora.org>
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>
Date:   Wed, 12 Dec 2018 10:25:03 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajendra Nayak (2018-12-12 01:21:27)
> The RPMh power domain driver aggregates the corner votes from various
> consumers for the ARC resources and communicates it to RPMh.
>=20
> With RPMh we use 2 different numbering space for corners, one used
> by the clients to express their performance needs, and another used
> to communicate to RPMh hardware.
>=20
> The clients express their performance requirements using a sparse
> numbering space which are mapped to meaningful levels like RET, SVS,
> NOMINAL, TURBO etc which then get mapped to another number space
> between 0 and 15 which is communicated to RPMh. The sparse number space,
> also referred to as vlvl is mapped to the continuous number space of 0
> to 15, also referred to as hlvl, using command DB.
>=20
> Some power domain clients could request a performance state only while
> the CPU is active, while some others could request for a certain
> performance state all the time regardless of the state of the CPU.
> We handle this by internally aggregating the votes from both type of
> clients and then send the aggregated votes to RPMh.
>=20
> There are also 3 different types of votes that are comunicated to RPMh
> for every resource.
> 1. ACTIVE_ONLY:
>         This specifies the requirement for the resource when the CPU is
>         active
> 2. SLEEP:
>         This specifies the requirement for the resource when the CPU is
>         going to sleep
> 3. WAKE_ONLY:
>         This specifies the requirement for the resource when the CPU is
>         coming out of sleep to active state
>=20
> We add data for all power domains on sdm845 SoC as part of the patch.
> The driver can be extended to support other SoCs which support RPMh
>=20
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

