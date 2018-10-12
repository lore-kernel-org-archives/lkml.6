Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3114C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 11:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 726222077C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 11:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VmnmrCxL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 726222077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbeJLSnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 14:43:37 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:32947 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbeJLSnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 14:43:37 -0400
Received: by mail-pg1-f196.google.com with SMTP id y18-v6so5720941pge.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 04:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=lC+8ZnXbEaknaWpQYGS8dSHNeFRKofdA00EXaBKsxz8=;
        b=VmnmrCxL/eQoplTJ59zWk0guAGacHTMND2LzCpJ/FT/gjXwx8S8BpCjy/L896FURNx
         R1qkTmCMdPraeopkIH3HlfQ+tZJJZa2NIh1Kg71uxRdXkoKKNPciBMHDMJh0AOU3PkMt
         c40Fqv/pYE38NV7TiMNOSqj784DyN6AN9+Z+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lC+8ZnXbEaknaWpQYGS8dSHNeFRKofdA00EXaBKsxz8=;
        b=dw8PaLTbBFxijCAkgobS8TdRDBVpIfroSwkHYT70/BUro7a67wPj32xvPvbRjuZeyH
         8VQJoyIg5PkTTTAVPb50XXcH0Vde2107yiMqXZC146IZjdI79uL8sxoPKDuo4jL3qIQK
         owIUkN6OcS5XXAOvFDyoh1FvAK6VZU2vHCsfcXitiWnYJsM1T6wddQpFS+Rnq5NzEMJh
         RXt4cFlk+iOyRfYWkyZ8bRGvIi3ZsZRRhj/eLhWVlxA+KGJJ4HnGDkYdf/DPzy+THvmI
         O5DdcvAF2x9vm44nkzH+kJkKN1fdrph/WKKP6u1O2xm1QfRoGLM8YkLUsgIpMXSTzqfy
         p8EQ==
X-Gm-Message-State: ABuFfoh2CpTLDFlkVgaSXJP+mCOhRuHCb+qvdIFwe9mBXy2cTsNiu8i0
        Ai+nZxBgOTWNvXXE1UfkstQ74A==
X-Google-Smtp-Source: ACcGV61glFsYMfY8CHckcfheKlaaHsA87t/hHenzPtv7ahSRcLRj8J17KAySyk53aQ5zhRlEqbcgvg==
X-Received: by 2002:a63:2503:: with SMTP id l3-v6mr5102928pgl.69.1539342700956;
        Fri, 12 Oct 2018 04:11:40 -0700 (PDT)
Received: from localhost ([122.171.67.41])
        by smtp.gmail.com with ESMTPSA id a2-v6sm1385179pgc.68.2018.10.12.04.11.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 04:11:40 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     ulf.hansson@linaro.org, Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Nishanth Menon <nm@ti.com>,
        Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        niklas.cassel@linaro.org, rnayak@codeaurora.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 0/9] OPP: Support multiple power-domains per device
Date:   Fri, 12 Oct 2018 16:41:08 +0530
Message-Id: <cover.1539341929.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a2c
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

We are already at 4.19-rc7 and there may not enough time to get this
reviewed/tested/ready for the upcoming merge window and so there is no
hurry in getting this merged. The purpose to send now is to get this
reviewed/tested, which would allow more more development to happen on
top of this.

This series improves the OPP core (and a bit of genpd core as well) to
support multiple phandles in the "required-opps" property, which are
only used for multiple power-domains per device for now.

We still don't propagate the changes to master domains for the
sub-domains, but this patchset is an important stepping stone for that
to happen.

Tested on Hikey960 after faking some power domains for CPUs.

V1->V2:
- Had a discussion at Linaro connect with Ulf regarding the changes V1
  did in the genpd core and what his objections are to them. Based on
  his suggestions many changes are made.
- The OPP core still needs the virtual device pointers to set the
  performance state for multiple domains, but the genpd core doesn't
  provide them automatically to the OPP core. One of the reasons behind
  this is to give more power to the consumer drivers which may not want
  to enable all the genpds at once.
- The consumer drivers would now need to call the APIs
  dev_pm_opp_{set|put}_genpd_device() in order to set/reset these
  virtual device pointers.
- More locking is put in place to protect the genpd device pointers in
  OPP core.
- Reorg of the code at many places to make code less redundant.

--
viresh
 
Viresh Kumar (9):
  OPP: Identify and mark genpd OPP tables
  OPP: Separate out custom OPP handler specific code
  OPP: Populate required opp tables from "required-opps" property
  OPP: Populate OPPs from "required-opps" property
  PM / Domains: Add genpd_opp_to_performance_state()
  OPP: Add dev_pm_opp_{set|put}_genpd_device() helper
  OPP: Configure all required OPPs
  OPP: Rename and relocate of_genpd_opp_to_performance_state()
  OPP: Remove of_dev_pm_opp_find_required_opp()

 drivers/base/power/domain.c |  51 +++---
 drivers/opp/core.c          | 261 ++++++++++++++++++++++--------
 drivers/opp/of.c            | 313 +++++++++++++++++++++++++++++++-----
 drivers/opp/opp.h           |  20 +++
 include/linux/pm_domain.h   |   7 +-
 include/linux/pm_opp.h      |  16 +-
 6 files changed, 519 insertions(+), 149 deletions(-)

-- 
2.18.0.rc1.242.g61856ae69a2c

