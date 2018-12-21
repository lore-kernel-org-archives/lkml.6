Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48AC9C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 03:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E56821905
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 03:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i8QDqZ2i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390925AbeLUDnt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 22:43:49 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41417 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388947AbeLUDnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 22:43:49 -0500
Received: by mail-pg1-f196.google.com with SMTP id m1so1843501pgq.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 19:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5GKZ4jHUWo09u0m2POrSvLjobjNnP0ZziBYsduXxF20=;
        b=i8QDqZ2iKgXoy/NRlsPVQT3mSJ3OcoEu0HvJb1ILchFv6ilCQ76FwacJRB6ymmW1oa
         tL7EA1YCBwjOn6l+lMzABvgXyjPzV47J+A1Bk5fd+ObqErxiWfD45hHHV5tUVQw8fqWK
         naLc3Fd3DjzbA93xeObEFqgRzGDFRlGyaTupcvRZDemv4gpzFCJxm+TaGGNOOYgtgM9N
         +pkrh35jTRfNf1/QbQDTSYBAGJgG5gjQfc1lviIeFwi0pjoQl1B3fmn5n0TYTIfLnSSF
         Gowq0+wd1WkNbN9k6KNq5wkSfsQm6XimAMDZLgHZEN9OJJW0pr2FB22lp3bx19oHJrCt
         2vYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5GKZ4jHUWo09u0m2POrSvLjobjNnP0ZziBYsduXxF20=;
        b=VasnvM4h+ax8qlTl+tY8raMHG/rzzTIgl4U/LwQ5Wb2eupDvABkj5swl8pFp/+DiSE
         Ci/ety1E7zcwS3XoP1dfzPW5lMWBsSP7SKc+KwrVBhbuAReTe/iiH80sQyxuD5HA3StU
         2Bjjly4O1GdA0UPSmqwmZNSUidDKGDywNbikWrGEOkFS2jLisKvoPgrJkpPnjEfhZTIE
         ycO2oxljuwMM9UfDftDFVyF0dxqQ3f2UCq/nQ9MJpSgBUUI+kNZgx/3GRj5B8ZCfOsXC
         GjgdsgclAKjSkN2QXVW+HMJ824H2F4xQE5cyKXHahsS/J1FR1XQZ1WhMFkndlPYXIWxD
         40DQ==
X-Gm-Message-State: AA+aEWY+QDK2U/GmVgC6joVfZ1KmdYKTw7exOpZvF88Ph1vpneZg+IwD
        Z2o9+Db5PPRHrnn02xS3i2BTRlPJ
X-Google-Smtp-Source: ALg8bN7ejH9Td/qLEUxyAxN64GtEPzUsgE340CdTVT+VftY6zmHPdXqNkbrZoiT+CKYtal74QqVMFw==
X-Received: by 2002:a62:9111:: with SMTP id l17mr877328pfe.200.1545363827972;
        Thu, 20 Dec 2018 19:43:47 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id q199sm39749695pfc.97.2018.12.20.19.43.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 19:43:47 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     cphealy@gmail.com, Florian Fainelli <f.fainelli@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kim Phillips <kim.phillips@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        rmk+kernel@armlinux.org.uk, l.stach@pengutronix.de
Subject: [PATCH v3 0/2] perf tests: Check for ARM [vectors] page
Date:   Thu, 20 Dec 2018 19:43:35 -0800
Message-Id: <20181221034337.26663-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I just painfully learned that perf would segfault when
CONFIG_KUSER_HELPERS is disabled because it unconditionally makes use of
it. This patch series adds an ARM test for that by leveraging the
existing find_vdso_map() function and making it more generic and capable
of location any map within /proc/self/maps.

Changes in v3:

- remove find_vdso_map() call find_map() with VDSO__MAP_NAME

Changes in v2:

- use strlen() instead of sizeof() -1 since we made the page name a
  parameter
- use TEST_OK/TEST_FAIL in lieu of 0/-1
- added an error message indicating CONFIG_KUSER_HELPERS might be
  disabled

Florian Fainelli (2):
  perf tools: Make find_vdso_map() more modular
  perf tests: Add a test for the ARM 32-bit [vectors] page

 tools/perf/Makefile.perf                      |  4 ++--
 tools/perf/arch/arm/tests/Build               |  1 +
 tools/perf/arch/arm/tests/arch-tests.c        |  4 ++++
 tools/perf/arch/arm/tests/vectors-page.c      | 24 +++++++++++++++++++
 tools/perf/perf-read-vdso.c                   |  6 ++---
 tools/perf/tests/tests.h                      |  5 ++++
 .../perf/util/{find-vdso-map.c => find-map.c} |  7 +++---
 tools/perf/util/vdso.c                        |  6 ++---
 8 files changed, 45 insertions(+), 12 deletions(-)
 create mode 100644 tools/perf/arch/arm/tests/vectors-page.c
 rename tools/perf/util/{find-vdso-map.c => find-map.c} (71%)

-- 
2.17.1

