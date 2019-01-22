Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E88EEC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B666621019
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uBoJaR1Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728504AbfAVNZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 08:25:00 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:46030 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728354AbfAVNY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 08:24:59 -0500
Received: by mail-yw1-f66.google.com with SMTP id d190so9347983ywd.12;
        Tue, 22 Jan 2019 05:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=RdIJ6TN6RQjyee0EPj8EQ0qkbwpPQH+q7CWrQNKOLRQ=;
        b=uBoJaR1YCt5paHLFcOQmDRasEzkiZiaLXJWT3FtYXSP4HOuEAVwZnWHcA3SofSrQQQ
         7gQ6I5PdaKAUmmwdmZ20Brx74zSda4TouGtJKyW9spQAfoSTWREVzVy1SYrDYQ/383YQ
         pTDAt0QpX6aWKNsShlICLtJQM15K6N36mrJoFQMvu0SCfYl6cuQmRrloiCpcxgsWfdYx
         O0ckuE53EcJb5W39ec1pRFrYbI5MJFza6Sw9EsjIax5IYIIafLH0ofaauuZ4OMBTQiH8
         ngXB0UGuVgx+ui/QHnRy05YFER81nLftenk3a3L/C3IpBfXaoGh6mRxZahYdXmjaC1El
         zaqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=RdIJ6TN6RQjyee0EPj8EQ0qkbwpPQH+q7CWrQNKOLRQ=;
        b=cxSSBeyrf2JypzmZH4gfK99SthGW13crzx8r1idvjs51DS7KY72LJ7aoPv6OIr6ISv
         tv16R1p/pY1mPUH2QKCj2joJS9NwIgLqHSAdi81reCB0Rtzo8Al7/gvfZId5NhokxQXJ
         IRqdo7byXnAX//gt+ZqExAMWfCs7/RHbuU5RKbdTytoE4oW7CQVfJrRLtd88BaJttEcI
         OUK6JbWTRd1IOuf+S+c3JOVNADkNEZHePVm2SC0ohQVBgQIDTuJZKo8Nm8lNz4W8dRN3
         NC5J2xb1dlGHifCH47xKpPr+sCXyItnPcdElYDSbe9OfYhir4VBGOrb8xJFK8EPf+i9N
         +00Q==
X-Gm-Message-State: AJcUukdRyh3FWG+gRx6l1PGLkYGz4nLCec+dPqq5w/dNTL+wadGyECv/
        G8u4Gi6ciLM5J/brDy7/Qm02GgyUm8uLsED6nxDmk/ha
X-Google-Smtp-Source: ALg8bN6+B+hkgpx6qAN8b6JsKTZkqJw3x+8Dg23tsBzhtCKqZEx3j4zjp+nYIOrhqr4a16i4CY78npKbsflTx1Qt/Nw=
X-Received: by 2002:a0d:db97:: with SMTP id d145mr32269454ywe.487.1548163498220;
 Tue, 22 Jan 2019 05:24:58 -0800 (PST)
MIME-Version: 1.0
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Date:   Tue, 22 Jan 2019 21:25:33 +0800
Message-ID: <CABXRUiRP8fHvGkO3T9AOFV=prVUACiCm2frbAEnG2v6UhrTw0A@mail.gmail.com>
Subject: Potential info leak: Kernel pointer leak?
To:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, recently I came across some code and it seems to be able to leak
kernel address?
Is the following code cause info leak in the Linux kernel?
The callback function address is printed to debugfs.
The local user could know the kernel object address, and is able to
bypass kASLR.
linux-4.14.90
drivers/dma/qcom/hidma_dbg.c:46
function - hidma_ll_chstats

The hidma_ll_chstats function in drivers/dma/qcom/hidma_dbg.c in the
Linux kernel 4.14.90 allows local users to obtain sensitive address
information by reading "callback=" lines in a debugfs file.

Similar to CVE-2018-7754
