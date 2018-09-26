Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02EBFC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 21:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E17D21537
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 21:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="leJHc37H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E17D21537
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbeI0EFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 00:05:35 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:47092 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725722AbeI0EFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 00:05:35 -0400
Received: by mail-oi1-f194.google.com with SMTP id k64-v6so407506oia.13;
        Wed, 26 Sep 2018 14:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QcaE+sJg36LyeUaRF6Y5nGGNtwgF6Dbq+LVd4yPn0Go=;
        b=leJHc37HPBJE8bYgLgHash6EK98+uT0JLm6rc7SCimpJm6TQKyaHRiWSrm4yTiTfQ1
         6i2NASgnTt95jmmTrEVUZfFR25uQIRvSQsQJfCYnIXzTInKDadPmEJyyYQiWdYeimOWD
         j2o+nLHasnVDAFcVJWh6Gex4TyXmG5ffQTJwUNWem8/vaOZtX0BrZI8R14zLiRgrt7AG
         K2EJ0Q4Nb2wOVeedr0ZBxmD6A7+uxXae2Ja8ZUlk8SJOFnzvPffV357wsXBjRscOsl4J
         xEv+FGVC+yLJBC8OSv3F2jNbAfCxTXr7XKsXffgi2GT6rNtiHdgp8kxAgQRlRrTyWLl0
         O1Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QcaE+sJg36LyeUaRF6Y5nGGNtwgF6Dbq+LVd4yPn0Go=;
        b=IsyulrfXk2JZvQJ3mMyFQA4GOX8AVlrfV7pjC60hFwABJBukn3MnIgAc2jHkrcj8HG
         4wop3qjYgCqajLajSRQLzmOTiFIQ35Tbd/owz+2b/k/0N0ZYX5mXPFEShCmR6tG9Ovsw
         Zs2lyg1xvIIP0Cdk+G5+YO+MxvjQ8fbUeicaBi1jgd3DLa0axGn+lNi0a6aJiTpVE4pn
         SknsDjtsmMYeawVbyjsT6Z23BjY+pByN6tCExVmgB5bsaD3BEVc7znrbvppZtG69Nfvm
         1iIyx76NhUU2OUXZz22eclGxtHkVnMIPkY6PQ3hy4PxJAi7K6iuXt2AVwWZk4Z2ZgDoz
         9czA==
X-Gm-Message-State: ABuFfohNe299ZesaQa9lre8xQztdvQp0M2zcWgw3QaakXs2uWp5kH+Bu
        7huIxtltamiEfXBST57CXH8=
X-Google-Smtp-Source: ACcGV63pyPsTjePIERacn2OnBeNiC2+NHdMH+U18wfWsMUx1CXBQX1K+XN7UDnhtsa1guiDGgqjEPQ==
X-Received: by 2002:aca:6898:: with SMTP id o24-v6mr1734423oik.44.1537998635590;
        Wed, 26 Sep 2018 14:50:35 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id b124-v6sm95121oii.14.2018.09.26.14.50.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 14:50:34 -0700 (PDT)
From:   Stuart Hayes <stuart.w.hayes@gmail.com>
To:     dvhart@infradead.org, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Mario Limonciello <mario.limonciello@dell.com>,
        LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Doug Warzecha <Douglas_Warzecha@dell.com>,
        Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: [PATCH v2 0/5] Update and move Dell drivers dell_rbu and dcdbas
Date:   Wed, 26 Sep 2018 16:50:16 -0500
Message-Id: <20180926215021.30471-1-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dell_rbu and dcdbas drivers need some changes, and should be moved to
drivers/platform/x86.  Additionally, dell_rbu needs a maintainer, and the
listed maintainer for dcdbas is inactive and needs to be changed.

v2 changes:
 - add commit messages to patches that move dcdbas and dell_rbu
 - remove extra whitespace in MAINTAINERS
 - add acked-by from (previous) maintainer of dcdbas

Stuart Hayes (5):
  firmware: dell_rbu: Make payload memory uncachable
  firmware: dcdbas: Add support for WSMT ACPI table
  firmware: dell_rbu: Move dell_rbu to drivers/platform/x86
  firmware: dcdbas: Move dcdbas to drivers/platform/x86
  MAINTAINERS: Update maintainer for dcdbas and dell_rbu

 MAINTAINERS                                   |  11 +-
 drivers/firmware/Kconfig                      |  28 ----
 drivers/firmware/Makefile                     |   2 -
 drivers/platform/x86/Kconfig                  |  28 ++++
 drivers/platform/x86/Makefile                 |   2 +
 drivers/{firmware => platform/x86}/dcdbas.c   | 123 +++++++++++++++++-
 drivers/{firmware => platform/x86}/dcdbas.h   |  10 ++
 drivers/platform/x86/dell-smbios-smm.c        |   2 +-
 drivers/{firmware => platform/x86}/dell_rbu.c |   8 ++
 9 files changed, 175 insertions(+), 39 deletions(-)
 rename drivers/{firmware => platform/x86}/dcdbas.c (82%)
 rename drivers/{firmware => platform/x86}/dcdbas.h (93%)
 rename drivers/{firmware => platform/x86}/dell_rbu.c (98%)

-- 
2.19.0.221.g150f307af

