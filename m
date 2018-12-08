Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBCC7C65BAF
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 05:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A04CB2083D
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 05:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y3tqsUp9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A04CB2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbeLHFNT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 00:13:19 -0500
Received: from mail-oi1-f170.google.com ([209.85.167.170]:34742 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbeLHFNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 00:13:18 -0500
Received: by mail-oi1-f170.google.com with SMTP id h25so5144171oig.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 21:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d9EM6OLmL5jq+R/me+WDLFLeNaotPlwD/W2/1haHTk4=;
        b=Y3tqsUp9IqgExw2BNgMp9G9Nz+xzvHIwTY4vPuuHt2VJtCZn3WOv7kL7Osdd2aBOeQ
         DgXYjLKlINA5yX8sqBj5IQsyGij9yrQePoa/LHWnvq0wcA9xFCIs8NqcMlycKUl/MSSV
         hrTksLtf079rvK1jfIQfdEUPrMEci0e11gHI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d9EM6OLmL5jq+R/me+WDLFLeNaotPlwD/W2/1haHTk4=;
        b=e/at9oqGeluqnr/AjAyP+asJmF06n1kEVcisYvDPDh5r/fuu1bD7d6iIQ69HAi01w/
         pSrcqgGxWM2HWkVQanuXdKluR3MC6AZSXfRnYHhCfLsdJsol/muo59PaVJzPfvdzk2Hq
         Tvym0SQSax3m+NGELiex3dIeD6htAwqCMy7SNw6mzbBkFP8Eap+qGxRpfZWMJ+okPonQ
         qugKFqU2SRUnqKLSCV6S2fY1oggZD05T6dIuY1hRmiamO/7i60W56/T74Oy+IviCVUIb
         Lf/TIR3uwChhcHib9Siz4yIZ8fA/bfDRpBz0ur2IxmC1ibUTwFHodgjqK2QYIM71hk2b
         kB7g==
X-Gm-Message-State: AA+aEWbK/lMyhUaR21pyPjDRJPSrBJR06a/x2v1VOxrAnH4j3oKBkpj2
        fl0TOAaThOK5ywHRLijFbp+5sA==
X-Google-Smtp-Source: AFSGD/Um6iO0gmu6JUsaZiaW32lwo+7nBbhWygxpQpuki5m1YKYSohdMs+30rXp/7IuAmrXmVMTJsg==
X-Received: by 2002:aca:b707:: with SMTP id h7mr2654690oif.89.1544245997730;
        Fri, 07 Dec 2018 21:13:17 -0800 (PST)
Received: from localhost ([2600:1700:141:4960:1524:ebd:d530:a61b])
        by smtp.gmail.com with ESMTPSA id y2sm2194556oto.49.2018.12.07.21.13.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 21:13:17 -0800 (PST)
From:   Andy Gross <andy.gross@linaro.org>
To:     arm@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kevin Hilman <khilman@baylibre.com>,
        Olof Johansson <olof@lixom.net>
Subject: [GIT PULL] Qualcomm Driver updates for 4.21 - Part 2
Date:   Fri,  7 Dec 2018 23:13:14 -0600
Message-Id: <1544245994-4228-2-git-send-email-andy.gross@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544245994-4228-1-git-send-email-andy.gross@linaro.org>
References: <1544245994-4228-1-git-send-email-andy.gross@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit b601f73130a375c912d9f2ec93c5f3cea5d6a3da:

  drm: msm: Check cmd_db_read_aux_data() for failure (2018-11-29 17:41:53 -0600)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-drivers-for-4.21-2

for you to fetch changes up to 92def04bd7b46f5b186f985d5c9d3804858c3c2f:

  MAINTAINERS: Change Todor Tomov's email address (2018-12-05 16:45:34 -0600)

----------------------------------------------------------------
Qualcomm ARM Based Driver Updates for v4.21 Part 2

* Fix MAINTAINERS email address for Todor
* Fix SCM compilation error

----------------------------------------------------------------
Jonathan Marek (1):
      firmware: qcom: scm: fix compilation error when disabled

Todor Tomov (1):
      MAINTAINERS: Change Todor Tomov's email address

 MAINTAINERS              | 2 +-
 include/linux/qcom_scm.h | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)
