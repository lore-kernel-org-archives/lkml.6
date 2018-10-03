Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E47EC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 14:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF60F2089F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 14:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GS+6zAXv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF60F2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbeJCV1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 17:27:20 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34544 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbeJCV1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 17:27:20 -0400
Received: by mail-lf1-f65.google.com with SMTP id y10-v6so4333076lfj.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 07:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=BQQ4CUhUwLPSkziPcTmDrRncPt7krFlSgdVDh1XHwGE=;
        b=GS+6zAXv6Zke+euptEXU1eWKRdQ10l6bXpF+ryuEdLvxk5o24PG8sPEDXsRnUqsCeJ
         7icYp+5kNVwQqsgBF/P2Y3/Mi84RS+o8ohyt+kyMFL5QihyFl5Nii7p4JwvqTlpJ4NDp
         2/H2SbCgjVk0WP+7f0N69AR0L3VQsaQdIgicI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BQQ4CUhUwLPSkziPcTmDrRncPt7krFlSgdVDh1XHwGE=;
        b=uBSvMQW8hnNJl8PXqX3RMV5AfeaVHh7fpQ7LmEHPgyUzXIlFRUkWYD5cQ8WKquDiS2
         NJNgaQqKlpXjm4mVTmFmoEyClv/ZkrTB6Va3nh/yC9ei7MfzEm+eT0Clkqoudh9K+5n/
         92SMzKKQbj4cTnHuKxRsF6fQv4xi+dAz2gwgyIih9VwwWkJT79R8FgA1Zhe8nu+abVt4
         Zyk7C7zSPzJw1Npan+/XMwSUWAU8cfIVag9LS1FnrbPrQVbyS/7P+ITtB6bgsbYPeX+9
         FkerRwwtyxEOu6/Vh6zcXlcbsoCoZCVaeeWMExOv1elj0QUNSA8+5RwTEuoRw183p/rb
         Z+eQ==
X-Gm-Message-State: ABuFfogxyAoY8nKg8hIdH35M9emMhX1Jqgcj2+KK4Rp3FKkg97ocnjgx
        Zkv86C9eWcqjhdXXdyUVDqv1kg==
X-Google-Smtp-Source: ACcGV63hMhgSPpyjFbDUGSK9FDqWVLEMQzkgE7mzZqN8iAFxs3tJUrX7ol6sFfQbP9rOiwjWWRIekQ==
X-Received: by 2002:a19:f817:: with SMTP id a23-v6mr1195615lff.67.1538577517284;
        Wed, 03 Oct 2018 07:38:37 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id 18-v6sm380867ljo.74.2018.10.03.07.38.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 07:38:36 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Cc:     Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 00/11] PM / Domains: Support hierarchical CPU arrangement (PSCI/ARM) (a subset)
Date:   Wed,  3 Oct 2018 16:38:13 +0200
Message-Id: <20181003143824.13059-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have digested the review comments so far, including a recent offlist chat
with with Lorenzo Pieralisi around the debatable PSCI changes. More or less I
have a plan for how to move forward.

However, to avoid re-posting non-changed patches over and over again, I decided
to withhold the more debatable part from this v9, hence this is not the complete
series to make things play. In v9, I have just included the trivial changes,
which are either already acked/reviewed or hopefully can be rather soon/easily.

My hope is to get this queued for v4.20, to move things forward. I know it's
late, but there are more or less nothing new here since v8.

Kind regards
Ulf Hansson

Changes in v9:
 - Collect only a subset from the changes in v8.
 - Patch 3 is new, documenting existing genpd flags. Future wise, this means
when a new genpd flag is invented, we must also properly document it.
 - No changes have been made to the patches picked from v8.
 - Dropped the text from v8 cover-letter[1], to avoid confusion. When posting v10
(or whatever the next version containing the rest becomes), I am going re-write
the cover-letter to clarify, more exactly, the problems this series intends to
solve. The earlier text was simply too vague.

[1]
https://lwn.net/Articles/758091/

Changes in v8:
 - Added some tags for reviews and acks.
 - Cleanup timer patch (patch6) according to comments from Rafael.
 - Rebased series on top of v4.18rc1 - it applied cleanly, except for patch 5.
 - While adopting patch 5 to new genpd changes, I took the opportunity to
   improve the new function description a bit.
 - Corrected malformed SPDX-License-Identifier in patch20.

Changes in v7:
 - Addressed comments concerning the PSCI changes from Mark Rutland, which moves
   the psci firmware driver to a new firmware subdir and change to force PSCI PC
   mode during boot to cope with kexec'ed booted kernels.
 - Added some maintainers in cc for the timer/nohz patches.
 - Minor update to the new genpd governor, taking into account the state's
   poweroff latency while validating the sleep duration time.
 - Addressed a problem pointed out by Geert Uytterhoeven, around calling
   pm_runtime_get|put() for CPUs that has not been attached to a CPU PM domain.
 - Re-based on Linus' latest master.


Lina Iyer (3):
  dt: psci: Update DT bindings to support hierarchical PSCI states
  cpuidle: dt: Support hierarchical CPU idle states
  drivers: firmware: psci: Support hierarchical CPU idle states

Ulf Hansson (8):
  PM / Domains: Don't treat zero found compatible idle states as an
    error
  PM / Domains: Deal with multiple states but no governor in genpd
  PM / Domains: Document flags for genpd
  of: base: Add of_get_cpu_state_node() to get idle states for a CPU
    node
  drivers: firmware: psci: Move psci to separate directory
  MAINTAINERS: Update files for PSCI
  drivers: firmware: psci: Split psci_dt_cpu_init_idle()
  drivers: firmware: psci: Simplify error path of psci_dt_init()

 .../devicetree/bindings/arm/psci.txt          | 156 ++++++++++++++++++
 MAINTAINERS                                   |   2 +-
 drivers/base/power/domain.c                   |  20 ++-
 drivers/cpuidle/dt_idle_states.c              |   5 +-
 drivers/firmware/Kconfig                      |  15 +-
 drivers/firmware/Makefile                     |   3 +-
 drivers/firmware/psci/Kconfig                 |  13 ++
 drivers/firmware/psci/Makefile                |   4 +
 drivers/firmware/{ => psci}/psci.c            |  70 ++++----
 drivers/firmware/{ => psci}/psci_checker.c    |   0
 drivers/of/base.c                             |  35 ++++
 include/linux/of.h                            |   8 +
 include/linux/pm_domain.h                     |  35 +++-
 13 files changed, 302 insertions(+), 64 deletions(-)
 create mode 100644 drivers/firmware/psci/Kconfig
 create mode 100644 drivers/firmware/psci/Makefile
 rename drivers/firmware/{ => psci}/psci.c (95%)
 rename drivers/firmware/{ => psci}/psci_checker.c (100%)

-- 
2.17.1

