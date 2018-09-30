Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D0B2C004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 18:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64189208E4
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 18:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="g5czRD+o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64189208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbeJABMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 21:12:19 -0400
Received: from mail-yb1-f173.google.com ([209.85.219.173]:38991 "EHLO
        mail-yb1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728594AbeJABMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 21:12:15 -0400
Received: by mail-yb1-f173.google.com with SMTP id c4-v6so4724828ybl.6
        for <linux-kernel@vger.kernel.org>; Sun, 30 Sep 2018 11:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=y6mBg9xC9pK5BBZBSHZq2PlOGqXltNWUuKh74b+IDlI=;
        b=g5czRD+oXdcAp9F+YlQV0VbwuH38DL05zNEzRmHOjpqorjVPYdIgz6DTT817dMJKW3
         JJFOzYM0Led4InTKvhB+W2r35+Lf6HIQ5ZtuL3w8NOACNK+VI9fYuT+QXsBD0lnnjhxW
         yrVn748fD6MkB3aVZPZiFV0kOa6paAMd9XmbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=y6mBg9xC9pK5BBZBSHZq2PlOGqXltNWUuKh74b+IDlI=;
        b=HcvsfztAOT5Y25KMn7r6+7B8n02zxAgL74c9G75n6aKmEerJQf1dD1T/IG852Ll8kX
         SFrLH7UldVZO21gbhVk0XvbDF0T3m+8S3gPL6MYDTdEUbDQYlAbo127w192b6pxWVdgL
         4dZFrm+VXKud02oioWLeiLGoNMxEJ8YdD2xpYc3GmHiCfPVHGUWHeuTN1pLLBqh++xGR
         wt7H7kcGtjrVuLNUBhywDZfpe5GDp8qbNcv5AVcGW6Aci/NVfa+Nz4H1v8Fo4s6p0OE9
         nI2u8Mnm8OotvyilgMGFEwGD6J4VWj1lUu/0a1sDpL16QFGIfqDSiaiWENYB3f3xEJBP
         OJFw==
X-Gm-Message-State: ABuFfoiu6nVhQ7JKSFpu+U+dJProZnDfP/ECDQxOewk8X3b5x77atxmA
        IXLjOplun1wCapJCzfkRp1G5iw==
X-Google-Smtp-Source: ACcGV60iyj9kPNheaKcfIgtbHdyld8+fRQlGYBbjer+p71XU2pMWNL8BYseB8wcDEFj5lbsi3zr8rQ==
X-Received: by 2002:a25:a504:: with SMTP id h4-v6mr4369475ybi.444.1538332687807;
        Sun, 30 Sep 2018 11:38:07 -0700 (PDT)
Received: from localhost ([2600:1700:141:4960:b19b:8662:2992:bdd8])
        by smtp.gmail.com with ESMTPSA id l21-v6sm2347421ywk.2.2018.09.30.11.38.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 11:38:07 -0700 (PDT)
From:   Andy Gross <andy.gross@linaro.org>
To:     arm@kernel.org
Cc:     Kevin Hilman <khilman@baylibre.com>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [GIT PULL] Qualcomm Defconfig updates for 4.20
Date:   Sun, 30 Sep 2018 13:38:00 -0500
Message-Id: <1538332682-12018-3-git-send-email-andy.gross@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538332682-12018-1-git-send-email-andy.gross@linaro.org>
References: <1538332682-12018-1-git-send-email-andy.gross@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-defconfig-for-4.20

for you to fetch changes up to 54c2678cd198f61555796bbda5e1727e6e1858f1:

  ARM: qcom_defconfig: Enable MAILBOX (2018-09-13 15:39:19 -0500)

----------------------------------------------------------------
Qualcomm ARM Based defconfig Updates for v4.20

* Enable MAILBOX

----------------------------------------------------------------
Frank Rowand (1):
      ARM: qcom_defconfig: Enable MAILBOX

 arch/arm/configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)
