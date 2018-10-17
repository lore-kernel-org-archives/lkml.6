Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4EF3ECDE3C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 23:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AF6E21479
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 23:17:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R8JEZWWN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AF6E21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbeJRHPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 03:15:08 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40549 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726644AbeJRHPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 03:15:08 -0400
Received: by mail-pf1-f195.google.com with SMTP id g21-v6so6920150pfi.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 16:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=4Vph7K58I7mDaUIWZmOzAm5Xj4AP7uOvWjkvkfoUkTc=;
        b=R8JEZWWNEJP7CAJpYXDPxTM4fpJpKbvqdqNEgcI5+8eit2SAjcSsHoaYGrc5tg3yUX
         22Vi+WOXkrwv8C+JB7rjU1t8lpqO9uaG7W1iKwpgHHc7Ig7HBV9Mwxi+bb5342NyoR+c
         YqagS7HvTrDXrKhebJnM+qi3ufl6va4PSVo3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=4Vph7K58I7mDaUIWZmOzAm5Xj4AP7uOvWjkvkfoUkTc=;
        b=G3BDv7ZRIyIraXSk5+TqKgidy0FVrT0esPyOKPIZfkVUekoSgbNd7/XI0mgkySxx+P
         mK1V6S7yOJBFB/64Mt049Y7VpMSaB/5EaSHesm2J6KNLdI8Jpff44CCA6TzDid1CKVTd
         wDsO8D0zxbQ927OTDQjncNFBSF6X+J6Uj/SvnfhqiNPnPyuAXSqvpUitbFwnSFo8Xa2P
         151BIHlg+R6XeQCbnT3pGFWjKEW/fWeENI5yE3NUkDpGO2mfsi4C3/bd1Fn3rDEmsUc7
         nfaPbYPy6vBZbBW5BUeWyL82L8kK6BNWGzARJ1RemZzgNot4V/7wpjRn9VmZb+kd93m0
         NteA==
X-Gm-Message-State: ABuFfojxRc2+HYXXp4AJ+CngF7cbc18HdmvFlh7OXMViqgrl+k/jmyaq
        WCxoysDo2Tm9YzcQungdXLtfwA==
X-Google-Smtp-Source: ACcGV633b3ku9w3dAAg5ixxLwVu6JAoZxop0tZHgyYE7WH4fXUfNipImSreDFxD5oIlPa1v+anwspQ==
X-Received: by 2002:a63:65c7:: with SMTP id z190-v6mr26239581pgb.146.1539818228711;
        Wed, 17 Oct 2018 16:17:08 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:fed3:9637:a13a:6c15])
        by smtp.gmail.com with ESMTPSA id c79-v6sm23547726pfc.92.2018.10.17.16.17.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 16:17:07 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Taniya Das <tdas@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <1539257761-23023-2-git-send-email-tdas@codeaurora.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>, devicetree@vger.kernel.org,
        robh@kernel.org, skannan@codeaurora.org,
        linux-arm-msm@vger.kernel.org, amit.kucheria@linaro.org,
        evgreen@google.com, Taniya Das <tdas@codeaurora.org>
References: <1539257761-23023-1-git-send-email-tdas@codeaurora.org>
 <1539257761-23023-2-git-send-email-tdas@codeaurora.org>
Message-ID: <153981822634.5275.112469394181457779@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 1/2] dt-bindings: cpufreq: Introduce QCOM CPUFREQ Firmware
 bindings
Date:   Wed, 17 Oct 2018 16:17:06 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2018-10-11 04:36:00)
> Add QCOM cpufreq firmware device bindings for Qualcomm Technology Inc's
> SoCs. This is required for managing the cpu frequency transitions which a=
re
> controlled by the hardware engine.
> =

> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

