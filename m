Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F64C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 18:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 723A92081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 18:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M6ovzj4S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 723A92081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729463AbeKHEUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 23:20:31 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44860 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbeKHEUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 23:20:30 -0500
Received: by mail-pf1-f195.google.com with SMTP id j13-v6so8068566pff.11;
        Wed, 07 Nov 2018 10:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=o0fBt/KLwKGA4Fg3JJAvI/o7Im4trUC9fE1dvpEip8Y=;
        b=M6ovzj4S1e3fkPeL0SEL0S5t0TMt/qSOMbQhRFOmaV0fjpgq9/lpfoha1ZM9Kq1Bpj
         5yF4vVcvVqTap/Mo1diMs82Hpp/YiQj7rg1GbHIxbcVcOzX8gnZhieXa9W79bXm2cJ6n
         94+e4FO7zAksNO1xK1lsYi+Mh23ufa7qQCF51LTwbbRhzJpdwE9Kh0ZgApAHwPPT4Yg2
         YaFC3DXeF2agzirL5Zq1wR6kcnxxM3fFUr34JyWILBPRTeHx47QW3k9Hqxn9LK+ivf1w
         ddwFp+hjXHDyajA3x/U2Sg2EZAtiervBi0+aQnhAaZqAtmrmdP2M+7shPOHs4a8L5mpc
         QSTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=o0fBt/KLwKGA4Fg3JJAvI/o7Im4trUC9fE1dvpEip8Y=;
        b=F5Hh6UdnZV15/wlI469fqkEi69k8LdRShh9oaL4M6fam1y66dhZ5ryZFUah9ph7fyc
         JJ9abkg338Z5cd5DqYQCufkygASnHWKW2C73L1C7Tlu0fE/AR3PD6s1ZaS9UcbItcVYA
         uWqWlR4LFpUiiJzig/tMxeLI2LPzIenp9eZLJ4LSK7BDEMSK719pOADSLadm4IDmJL0D
         Lzz9PBg0o/xbU/NTM1kSy2DQtVIpxngLHqK6TEOl+A+XT18BOdKm8GzdNpuS4JRVH0RF
         QYN3rY8wrAWqNDlpcE8GTqSUW9uevVAQ4AlJlQlx+wx1neaa1SNcC8nshF1rPGJ3JZkc
         i7LA==
X-Gm-Message-State: AGRZ1gJq/kLobtPKTHbruzQBVqJgBGVfZ7IyTxuzoP/iDNcwBjFUjtHh
        oa6UuOpHzH+tMi5JVtbeDhTZPQKq
X-Google-Smtp-Source: AJdET5dSdXMOdf55OlLC/5IK9rcIbYVC3guxS8iR4fWG4XjqN4Y4E8pFI5N0epR++6/ZKY77GN3LzQ==
X-Received: by 2002:a63:fc22:: with SMTP id j34-v6mr1172260pgi.434.1541616531300;
        Wed, 07 Nov 2018 10:48:51 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b185sm1361633pga.85.2018.11.07.10.48.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 10:48:50 -0800 (PST)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon fixes for v4.20-rc2
Date:   Wed,  7 Nov 2018 10:48:49 -0800
Message-Id: <1541616529-6076-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull hwmon fixes for Linux v4.20-rc2 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v4.20-rc2

Thanks,
Guenter
------

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v4.20-rc2

for you to fetch changes up to e3e61f01d755188cb6c2dcf5a244b9c0937c258e:

  hwmon: (ibmpowernv) Remove bogus __init annotations (2018-11-04 15:55:12 -0800)

----------------------------------------------------------------
hwmon fixes for v4.20-rc2

- Remove bogus __init annotations in ibmpowernv driver
- Fix double-free in error handling of __hwmon_device_register()

----------------------------------------------------------------
Dmitry Osipenko (1):
      hwmon: (core) Fix double-free in __hwmon_device_register()

Geert Uytterhoeven (1):
      hwmon: (ibmpowernv) Remove bogus __init annotations

 drivers/hwmon/hwmon.c      | 8 ++++----
 drivers/hwmon/ibmpowernv.c | 7 +++----
 2 files changed, 7 insertions(+), 8 deletions(-)
