Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14829C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 18:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBEFA2089A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 18:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e2uCJJMD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBEFA2089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbeJBB0I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 21:26:08 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36274 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbeJBB0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 21:26:08 -0400
Received: by mail-pf1-f195.google.com with SMTP id b7-v6so9889300pfo.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 11:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=sGddicY4XSvIV3upZAduLrWhB/02GIBqFedBFcu3U+s=;
        b=e2uCJJMDCUiUUrX1e9HFI4t2p+fi4NfCx1o8VgiUzrU4uJ+SVOkLO7FdXGHUMHJZJT
         zEmnzL6vz6+X0v6eOn/BJEL+S4hrYvDt9SYPUq11N0iryUW3ehMQPxQM8dBAGL+0s2TF
         SCPQyjhMJSMFBdUKh8y0O+OMSHRP3PzpXvXEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=sGddicY4XSvIV3upZAduLrWhB/02GIBqFedBFcu3U+s=;
        b=pDGB9QJX9z9zrwSXU2dbHgqEOMU0HV4jqdKle0eh0hTf//XuHqGumPXY9/94Uu4yoz
         FWuQ/w4WI0reO4pfwp++VL/ziijovGi1ZrIwQCAFfUG80+m1XBpj+1EGoFaQq634xJid
         JTB3KRqIR8y+SHINVXZ3kB7s8zR53IFr6wjbflViwu4l36MhNnpElhuM5Mq1ZtZiIs/2
         q+2zvv+r7tQcmd14FS8vnSuqrM+D8mo/pETEqbbR/xna1v4AmkuYZTCjwjToQ1PhfIVL
         uzVb6/+B+aWn15mKPjyOaAraETXl4ERUCWalVRht4zPfBGvV9RxrlgUPyZuWvHFj8kYN
         iajQ==
X-Gm-Message-State: ABuFfogKp08Cwu1Rs8cvQe0G3ZeHNxGQwHUXa0RjX7tpJFBDwGuYKoms
        lYC+1JScSZmxmA3ywJHigFARlw==
X-Google-Smtp-Source: ACcGV61TBXqrOqe6+1zIKPWq2nlxIIrgfHhpRzgZjVhTMa6lINKYrShAx+F7hW5kkeCNqVL7BUygrQ==
X-Received: by 2002:aa7:80cd:: with SMTP id a13-v6mr5541570pfn.86.1538419619878;
        Mon, 01 Oct 2018 11:46:59 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id i25-v6sm17654099pgi.31.2018.10.01.11.46.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Oct 2018 11:46:58 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Niklas Cassel <niklas.cassel@linaro.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20180912103431.GA27204@centauri.ideon.se>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Doug Anderson <dianders@chromium.org>
References: <20180816200648.90458-1-swboyd@chromium.org>
 <20180912103431.GA27204@centauri.ideon.se>
Message-ID: <153841961783.119890.13486677118739554119@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v3 0/3] pinctrl: msm interrupt and muxing fixes
Date:   Mon, 01 Oct 2018 11:46:57 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Niklas Cassel (2018-09-12 03:34:31)
> Hello Stephen,
> =

> I'm getting this warning on dragonboard 820c (msm8996) when booting linux=
-next:
> =

> [    3.211575] WARNING: CPU: 1 PID: 1 at drivers/pinctrl/qcom/pinctrl-msm=
.c:164 msm_pinmux_set_mux+0xc8/0x150
> [    3.212127] l28: ramp_delay not set

Thanks for testing. I think the problem is I messed up the function 0
and enum 0. Can you try this patch?

--8<---
diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinc=
trl-msm.c
index 1684b2da09d5..b925b8feac95 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -188,7 +188,7 @@ static int msm_pinmux_request_gpio(struct pinctrl_dev *=
pctldev,
 		return 0;
 =

 	/* For now assume function 0 is GPIO because it always is */
-	return msm_pinmux_set_mux(pctldev, 0, offset);
+	return msm_pinmux_set_mux(pctldev, g->funcs[0], offset);
 }
 =

 static const struct pinmux_ops msm_pinmux_ops =3D {
