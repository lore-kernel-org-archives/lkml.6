Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C09C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 19:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C66D92192D
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 19:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHNcVOuE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732651AbfBPT0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 14:26:53 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39321 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728542AbfBPT0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 14:26:53 -0500
Received: by mail-pl1-f196.google.com with SMTP id 101so6646264pld.6;
        Sat, 16 Feb 2019 11:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Hby5Y8oP0iz5i2BX7pLH1MgRKgkNkisDr/+ZSdJCx+o=;
        b=PHNcVOuEjifHC2WY+RdZMQ+K5nuYaZQrSa+WV1egJIoUzmHCEH2aG9NnSi/NRWi9Yk
         VxnJYnWjJ6yaaCSnPOCOg2hnLxdgkugpuj5b76pY8xP2DOxY4UGs/zMFZtCoFJE0u9rv
         ZXpnC4mDp4WDvQPnrDamLH4QvHunxshfYBf6//rnyt2A3bNkds+QJQZAnmmoQhqEEu0X
         O5D7FIOcEmt9PPBqzCOM+eUL/stU7afi4Bn3Uio95gmCwUznpOXChyhUbNN+XKyABzDy
         jbDSsyrZp2FIJd1kHUicZLJohl4C59+MTVepp9g+26bjVn7laRI6DnEBrgdaXpZt8RRP
         6oaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Hby5Y8oP0iz5i2BX7pLH1MgRKgkNkisDr/+ZSdJCx+o=;
        b=dFdCSrhx4lNVYD69CXeDPikOXib0kkkJOJXsSzlSsI/1GydAmeFDM0GNuMoTxjgRcL
         wqV+CtpMElOqQAoT6EFyAUGupbkfVb6XCJ8VxgMEfg4WvMAjaex2iIXCANF12cP3xGTW
         Hu4SnJPdddWjnaxvcJjb77sWGNC1hR65VXoqbNiJuWvO80uOnvQ/Vc6VD2OGdbfntnNP
         wpM0TznRtH6TVdM4MrrxWGH+bl5gfGD+e7QiLPSh6odM81bqEuntamRnq37D4Z8Yvi9n
         9PdY8ZwqvJtZnfMsPlBMK/m4HgdtA1wBkeixKRGli/5s1hkUuDta8EAgWyNNasBRzE3J
         Vwfw==
X-Gm-Message-State: AHQUAuasBpJaQvX9ROi+7wwO/9RfN9BXGM7RORXuNTKRkChol3fPXyK/
        2I7QKU0DqOmFrRms4ofN9r14h+hbIz0=
X-Google-Smtp-Source: AHgI3IaMmK2kQc2UOWVCIq2WvB+ChrnYyQPn73B9t20UAwOQ4aYK6NFUBlh6440d2A0EZrmAp04/PA==
X-Received: by 2002:a17:902:9a04:: with SMTP id v4mr17034079plp.34.1550345212326;
        Sat, 16 Feb 2019 11:26:52 -0800 (PST)
Received: from localhost.localdomain ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id n75sm13472398pfb.39.2019.02.16.11.26.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 16 Feb 2019 11:26:51 -0800 (PST)
From:   Xiang Xiao <xiaoxiang781216@gmail.com>
X-Google-Original-From: Xiang Xiao <xiaoxiang@xiaomi.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        alexander.shishkin@linux.intel.com,
        Ohad Ben Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        wendy.liang@xilinx.com, Arnaud POULIQUEN <arnaud.pouliquen@st.com>,
        Kumar Gala <kumar.gala@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Xiang Xiao <xiaoxiang@xiaomi.com>
Subject: [PATCH V3] Add syslog redirection driver
Date:   Sun, 17 Feb 2019 03:26:42 +0800
Message-Id: <1550345203-25460-1-git-send-email-xiaoxiang@xiaomi.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes vs. V2:

 - Remove memrchr function
 - Output message line by line

Guiding Li (1):
  rpmsg: add syslog redirection driver

 drivers/rpmsg/Kconfig        |  12 ++++
 drivers/rpmsg/Makefile       |   1 +
 drivers/rpmsg/rpmsg_syslog.c | 163 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 176 insertions(+)
 create mode 100644 drivers/rpmsg/rpmsg_syslog.c

-- 
2.7.4

