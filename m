Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B920BC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 15:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6458521526
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 15:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Qz4RvL02"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6458521526
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387666AbeHBRVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 13:21:38 -0400
Received: from mail-pl0-f43.google.com ([209.85.160.43]:39536 "EHLO
        mail-pl0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387579AbeHBRVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 13:21:37 -0400
Received: by mail-pl0-f43.google.com with SMTP id m1-v6so1191281plt.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 08:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=q5PD7HSby0seK+k6ExMq+JG69qB3cBtIQvcloSWWDSI=;
        b=Qz4RvL02B/iC1S3TBqiRU4/7YzgXjbXUdu++PP/1VHv1nU19celKl9IsrfE7IkEgGP
         InZstdgR80E4IOlHEwnfKACq4bLua+hZ+7OvfNo0mI45NpppIFX9iy3tFT0nVRnoSxnq
         Hiq5NxDc1XTk4MnKuvJ8AYeAzW9lwEKDm60wM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=q5PD7HSby0seK+k6ExMq+JG69qB3cBtIQvcloSWWDSI=;
        b=rMIji+d4qtbWcawteLaHH9zcZeB1c+cmobqNJOqi7EzHidQDhPWmvZWMX3UK6EHwkE
         trwgIvh0wKEGRUTGuGcPBLLyo1QztZgUZNNAvPPtccz8JZiv6Mzs1GyCxurmzUIAmAeg
         qtTZwcIcdRcpiOsAmwX9rRfieGYCCektDRIseI3H6OoHzp6q6jaOk8c0IkIfm2W+gVt6
         dQ/LM2RLGQI4ZVGnzFumFxPsnozyYT3jbIKxuuwAkdU8UQPAMjmvI2hD7CIM1oPY1xXM
         fMS29S/wOkdtYdJQcAex6eneGPa3K82TXVH5UjPIAEADnBHG1ddTPxJhPFbGJcua71Y3
         QiJA==
X-Gm-Message-State: AOUpUlFFbCrsVK7qB34WljNJbmVM3Zt9orVe+Is4BlBGZ5dGc8c4/b3m
        pkxfzvgQoe/+qmFNFiH/jFAVLg==
X-Google-Smtp-Source: AAOMgpdUkmLAwE1U4E10nfVvbYW6JgqMpPHhZo44mX+xKvUp1rWMCF5loThGUqr5XWFhtKjCURti2A==
X-Received: by 2002:a17:902:8697:: with SMTP id g23-v6mr2814660plo.292.1533223797383;
        Thu, 02 Aug 2018 08:29:57 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id l27-v6sm5244796pfi.180.2018.08.02.08.29.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Aug 2018 08:29:56 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        johan.hedberg@gmail.com, marcel@holtmann.org, mka@chromium.org
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20180802132518.8680-2-bgodavar@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, thierry.escande@linaro.org,
        rtatiya@codeaurora.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
References: <20180802132518.8680-1-bgodavar@codeaurora.org>
 <20180802132518.8680-2-bgodavar@codeaurora.org>
Message-ID: <153322379586.17365.15809720177631480146@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v12 1/7] dt-bindings: net: bluetooth: Add device tree bindings
 for QTI chip wcn3990
Date:   Thu, 02 Aug 2018 08:29:55 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Balakrishna Godavarthi (2018-08-02 06:25:12)
> This patch enables regulators for the Qualcomm Bluetooth wcn3990
> controller.
> =

> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

