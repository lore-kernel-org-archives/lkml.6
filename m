Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8CBC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 906B5214C1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JdCwWhMZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 906B5214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbeLCQzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 11:55:21 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38283 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbeLCQzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 11:55:21 -0500
Received: by mail-pl1-f195.google.com with SMTP id e5so6759379plb.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 08:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=6JQgTsMny6xvvZZgxgilTf3orjeNoe4rFmbiXZVDU1g=;
        b=JdCwWhMZikpmUBhQ9SAP4FW6FaLohiLJkANAws4v/fRl5NEGOXw/VrbE9NT2DYhjCx
         ZEs/DFyUNJQJmCVveyWkzerQX2wYEGc7UryN9TWEQRZMaPQy/dxqdcDqd8Yvn8ygOJNW
         qC++gWPtU7OMyIU+6gBAMi1ZImYMjaORfHpy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=6JQgTsMny6xvvZZgxgilTf3orjeNoe4rFmbiXZVDU1g=;
        b=WyAwZsyCN65BINxMQoaDpyCauhEjXVmZ+lELyvfZ4pxlLkBdWmRbxRhyFFVdVFXpIc
         UpJNw2M0ndUA/BFDCg/yBcbspkasBhf9C8yjxqVp5k+j/9LX9jPQdwt/y1//478x2NZV
         FrDnrx4ATwNqJqClYva6ShDIh3R6N/nl8EFn4PT3WlrvsXAk2jw96xmqi3vjCUWb6AvO
         cLpLoumCNlyWh4mugTwdbbbw1AeLXyfZZOIztH+Wyojzv/+/BJ5+4xd4DhR3aVUgH/QC
         aDKLB6ChceiWHvr1GNLlGDVbyTlme77vTjYIPie+6nLXz62qFmplfybclfXFMvdEnJoD
         6Y9g==
X-Gm-Message-State: AA+aEWbQ4f9MRBOD+YT/NztQYQHBOWv6Oo9SAH4OzI//3ANc81pjXQWt
        LF9d893nslszej6dEU7Sa9kJLQ==
X-Google-Smtp-Source: AFSGD/UXo6mX0hg+eYaE8CE6Jgkbq2xl/oo61KB0U+9hlyU1b8XHfpN/2UfJGU08q2D1oDDv6ct6gA==
X-Received: by 2002:a17:902:d697:: with SMTP id v23mr16392931ply.261.1543856118665;
        Mon, 03 Dec 2018 08:55:18 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fed3:9637:a13a:6c15])
        by smtp.gmail.com with ESMTPSA id s9sm15670500pgl.88.2018.12.03.08.55.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 08:55:18 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Taniya Das <tdas@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <1543722903-10989-2-git-send-email-tdas@codeaurora.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>, devicetree@vger.kernel.org,
        robh@kernel.org, skannan@codeaurora.org,
        linux-arm-msm@vger.kernel.org, evgreen@google.com,
        Taniya Das <tdas@codeaurora.org>
References: <1543722903-10989-1-git-send-email-tdas@codeaurora.org>
 <1543722903-10989-2-git-send-email-tdas@codeaurora.org>
Message-ID: <154385611714.88331.8566017812494618071@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v11 1/2] dt-bindings: cpufreq: Introduce QCOM CPUFREQ Firmware
 bindings
Date:   Mon, 03 Dec 2018 08:55:17 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2018-12-01 19:55:02)
> Add QCOM cpufreq firmware device bindings for Qualcomm Technology Inc's
> SoCs. This is required for managing the cpu frequency transitions which a=
re
> controlled by the hardware engine.
> =

> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

