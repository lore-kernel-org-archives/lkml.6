Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F69C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 23:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C2BC214D9
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 23:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lPFMurT/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C2BC214D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729374AbeLJX5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 18:57:02 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:44476 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728354AbeLJX5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 18:57:02 -0500
Received: by mail-vs1-f66.google.com with SMTP id g68so7784952vsd.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 15:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=18HgzqjB95lswCxc+CSidlCSrRL9t3/txSxtrHW/+R4=;
        b=lPFMurT/2fJ3cI2K/88jl/Di9sZ6NZ3vFP6CnmPkdZYZmca0huh8azHQ1M5QyKhmSW
         iw1sZS25Jm5BBws9Rg05daoRoaMowaN4h0syTVaRFkoYPcJNvDHGHKvlxdtB+92hM7i9
         uLvLLCgPMaE9NIvFb1Ocam2c0aBjrjXVao7rw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=18HgzqjB95lswCxc+CSidlCSrRL9t3/txSxtrHW/+R4=;
        b=DuwwtJrr7fX+MEsDX4BsEDhmkIncjaXyZOH8H1FyyCC/u86fGNVxXdhwL49RWCHRk1
         f9i2KPNvs+DNSFgf0bT11QoH6ly88M3uj5Dg4U+aVGkdVgePbnKFjiGy8ZZxUk0Jgqfv
         W3EUpvhSaRxCfmje3SCXL4uX79wgJFl3Ky5aYLG99bBU5l6hDDwcZ5ZNLEH9C/5g+GJs
         KccsRMvvazBqitPWmNG9avJ7tMEbeofYlwVoy8aLGx5ZbxeeBSdqTpbKkV9CUb2JOCof
         uGX5Y89kcW7YQpLxK0tsQ0wMwoRO+dc4lLyPDLK9Qi2f7xbKeXbkBLCP6Mlh8OHXhH5F
         /Zkg==
X-Gm-Message-State: AA+aEWZyqQgN1xwH01V8f9NPpNxMDyfkAPcOJAXoMY/tbzATaplBO5Rq
        TXS5EfP2yP8i6rIo7ST+vaUW45Jxhb0=
X-Google-Smtp-Source: AFSGD/UdXQyXTGrTB8NyBd4pW/OOlOzxLgyGCAZ2JAfpERZx7/NZ4zi7XUb+YLg4OBrums9NZN49YQ==
X-Received: by 2002:a67:e002:: with SMTP id c2mr6476944vsl.34.1544486220861;
        Mon, 10 Dec 2018 15:57:00 -0800 (PST)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id o68sm4072626vka.48.2018.12.10.15.56.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 15:56:59 -0800 (PST)
Received: by mail-vs1-f50.google.com with SMTP id x1so7785676vsc.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 15:56:59 -0800 (PST)
X-Received: by 2002:a67:dd11:: with SMTP id y17mr6413272vsj.111.1544486219316;
 Mon, 10 Dec 2018 15:56:59 -0800 (PST)
MIME-Version: 1.0
References: <20181112080557.22698-1-bjorn.andersson@linaro.org> <20181112080557.22698-2-bjorn.andersson@linaro.org>
In-Reply-To: <20181112080557.22698-2-bjorn.andersson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 10 Dec 2018 15:56:48 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Ugz1PhLL6NqhYyjOsRc=JwZT-jJzfr=3LHxo6zT5zypA@mail.gmail.com>
Message-ID: <CAD=FV=Ugz1PhLL6NqhYyjOsRc=JwZT-jJzfr=3LHxo6zT5zypA@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: soc: qcom: Add AOSS QMP binding
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Nov 12, 2018 at 12:02 AM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
> +  aoss_qmp: qmp@c300000 {
> +          compatible = "qcom,sdm845-aoss-qmp";
> +          reg = <0x0c300000 0x100000>;

drive-by nit: s/0x0c300000/0xc300000

...another random suggestion is that I think Rob H. has been
requesting that examples have the #include in them...

-Doug
