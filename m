Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E39C1C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 23:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A539C20834
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 23:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Dd0iMJ/+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A539C20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbeLDXGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 18:06:48 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34319 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbeLDXGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 18:06:48 -0500
Received: by mail-pl1-f193.google.com with SMTP id w4so9054036plz.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 15:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=F6wS1Q6W2eebU9wDQ9lJ4fhen9+twfYO44wf9hXuL+0=;
        b=Dd0iMJ/+qpA55ZnmUcZfDad3DnaS6Qo2dU1IfzWqA6Ty41eNNnCZM7QkweMktkT1HT
         OMbc4T114afWPVns7WDaKCcPPGVdrvBVMObbfoab/l6QO5GMuGDRNYCNdHVEEzvKbyHH
         vDCowNhtgvEiHIYvAN+YWrHR0JNVsx9uxsXto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=F6wS1Q6W2eebU9wDQ9lJ4fhen9+twfYO44wf9hXuL+0=;
        b=A/wxRO07WzzVFzo0Bng73TF5+6jhQp5zu3IGhH1bMsc9n8XOCJxEzW+2exMw2oV4z4
         wgHoO1oppZ2TAxNVGuWTpEHx4g8RmV6sUGCEu3g96xC9jXwhQ4+07XfQNH/HOqgVdASt
         w4yLiIov6DiDXjM69tWCAhZPmoRWnzJIp6gHkHcX5WHSK6LtlS/35H85tkAivC5GyIf/
         DDPVdbqihn7btPZJU0m1WXXN/BkbAq8xGzK5yEfrIYUciAhr6/atrbu8IOiludCEGU9w
         7XVboMLOZz3IYd4v2tqR/IQW09iAKymk4MUqQAjyBv4ImJW/XC0kSrm4lykxhUVq5piD
         UJeQ==
X-Gm-Message-State: AA+aEWYyfonHEouUw2rLJ0g0YKI9VeRjVsppFJDG9jW6F8eykkzRdNrY
        N+1+/oVsNYSDvbGc0edvnsihcw==
X-Google-Smtp-Source: AFSGD/UQbjqMEePk289ZB/xIV4MS1a0T/dOLmVGogiVrfGOdbMhmUjnbQU4K/Vn8drVacGFSuOeAjw==
X-Received: by 2002:a17:902:6e0f:: with SMTP id u15mr723003plk.175.1543964807548;
        Tue, 04 Dec 2018 15:06:47 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fed3:9637:a13a:6c15])
        by smtp.gmail.com with ESMTPSA id g11sm22941025pfo.139.2018.12.04.15.06.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 15:06:46 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Rajendra Nayak <rnayak@codeaurora.org>, andy.gross@linaro.org,
        collinsd@codeaurora.org, mka@chromium.org, robh@kernel.org,
        ulf.hansson@linaro.org, viresh.kumar@linaro.org
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20181204052119.806-2-rnayak@codeaurora.org>
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>
References: <20181204052119.806-1-rnayak@codeaurora.org>
 <20181204052119.806-2-rnayak@codeaurora.org>
Message-ID: <154396480574.88331.6841986331162089237@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v5 1/8] dt-bindings: opp: Introduce qcom-opp bindings
Date:   Tue, 04 Dec 2018 15:06:45 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajendra Nayak (2018-12-03 21:21:12)
> On Qualcomm Technologies, Inc. platforms, an OPP node needs
> to describe an additional level/corner value that is then communicated
> to a remote microprocessor by the CPU, which then takes some
> actions (like adjusting voltage values across various rails)
> based on the value passed.
> =

> Describe these bindings in the qcom-opp bindings document.
> =

> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

