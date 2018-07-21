Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71615ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 11:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C957206B7
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 11:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hHi6CIIY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C957206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbeGUMwE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 08:52:04 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34500 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727756AbeGUMwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 08:52:03 -0400
Received: by mail-lf1-f67.google.com with SMTP id n96-v6so3476709lfi.1
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 04:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7xFHfTlcMNT5Yw+vTSDeNN9RPAjbKc7TWlhRbw8hE4s=;
        b=hHi6CIIYgNQamZJchmy56Nh4dkiEk9kxkzCSquwpGi4TIBtzUYfTISLdmGDCzlVoQn
         ZmhNu+tQnJWrSTa6qgUwGmtP/oB7jsqWtelusJCQQ9soJr+nFY5fOuB8kscIK9szCOHp
         d5ezRAfeRKSMq8wEXLO3crpSZ1I4m3R9XEkNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7xFHfTlcMNT5Yw+vTSDeNN9RPAjbKc7TWlhRbw8hE4s=;
        b=YGm/Bwzo3h+RhSZLgvAsgJho/0Va9yiIRu/6dQirmW3udDjKzsOvHNDWADNvZzHzvW
         Z5/wtnJYamWq13hPsFF+lD8uMjAcom6O94piOrbMV6KLScC3QYw9uuCDYO9/Fl0X9R8n
         nEEwEOFz01nPHK4xx2jQ2cZRnn314jCNPaQ34i/y49Sy5vtuv4WgeDJKmHYR65vG+Po8
         2p0gbmSqU3Je4QSDiXiObLuUcj3MRm4cD5RXN4H92ZAMqwQq2ljvj+YCHyV2pWft3VFN
         nUWgRTtr4/6isYN+UKUPCJaF27V5okRSa9rKL8LkcMlScMhEt92JOolVS7BNDspsfKlm
         M+zw==
X-Gm-Message-State: AOUpUlGDhD/qGr/Woamne3gUu5xhYECej5qd0WFI5c9XTP8d2eqAaEuO
        gT7yztZUnp+X7POxva04Tg4kGQ==
X-Google-Smtp-Source: AAOMgpdoswSoGhqVpoxEkC4z7MJS8tyfT7OjiySXiif99rY6SH3r5/mVKpur/5dwPvAzgyySRmTZ5A==
X-Received: by 2002:a19:1863:: with SMTP id o96-v6mr3582504lfi.134.1532174372682;
        Sat, 21 Jul 2018 04:59:32 -0700 (PDT)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id 73-v6sm664260lfs.44.2018.07.21.04.59.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 04:59:31 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     davem@davemloft.net, grygorii.strashko@ti.com
Cc:     corbet@lwn.net, akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, vinicius.gomes@intel.com,
        henrik@austad.us, jesus.sanchez-palencia@intel.com,
        ilias.apalodimas@linaro.org, p-varis@ti.com, spatton@ti.com,
        francois.ozog@linaro.org, yogeshs@ti.com, nsekhar@ti.com,
        andrew@lunn.ch, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v4 net-next 0/6] net: ethernet: ti: cpsw: add MQPRIO and CBS Qdisc offload
Date:   Sat, 21 Jul 2018 14:59:17 +0300
Message-Id: <20180721115923.1389-1-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds MQPRIO and CBS Qdisc offload for TI cpsw driver.
It potentially can be used in audio video bridging (AVB) and time
sensitive networking (TSN).

Patchset was tested on AM572x EVM and BBB boards. Last patch from this
series adds detailed description of configuration with examples. For
consistency reasons, in role of talker and listener, tools from
patchset "TSN: Add qdisc based config interface for CBS" were used and
can be seen here: https://www.spinics.net/lists/netdev/msg460869.html

Based on net-next/master

v4..v3:
 - nothing, just rebase

v3..v2:
 - corrected typo of "shaper" word, any functional changes

v2..v1:
 - changed name cpsw.txt on ti-cpsw.txt
 - changed name cpsw_set_tc() on cpsw_set_mqprio()

Ivan Khoronzhuk (6):
  net: ethernet: ti: cpsw: use cpdma channels in backward order for txq
  net: ethernet: ti: cpdma: fit rated channels in backward order
  net: ethernet: ti: cpsw: add MQPRIO Qdisc offload
  net: ethernet: ti: cpsw: add CBS Qdisc offload
  net: ethernet: ti: cpsw: restore shaper configuration while down/up
  Documentation: networking: cpsw: add MQPRIO & CBS offload examples

 Documentation/networking/ti-cpsw.txt    | 540 ++++++++++++++++++++++++
 drivers/net/ethernet/ti/cpsw.c          | 364 +++++++++++++++-
 drivers/net/ethernet/ti/davinci_cpdma.c |  31 +-
 3 files changed, 913 insertions(+), 22 deletions(-)
 create mode 100644 Documentation/networking/ti-cpsw.txt

-- 
2.17.1

