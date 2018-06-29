Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1BD4C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 06:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E5C027B0E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 06:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="V1BG4kY/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E5C027B0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754259AbeF2GT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 02:19:58 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33023 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753263AbeF2GT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 02:19:56 -0400
Received: by mail-pg0-f66.google.com with SMTP id e11-v6so3545045pgq.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 23:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=NNDon416OtIiKvYg/i1JeW0jt8Q5PbvuSKtWQPBLHSU=;
        b=V1BG4kY/ItLk59bgrICaqmsJS7mtBEbqvn0TqK+YB5SuklEM1ppF8F9TCcEufUg2fT
         7u3M2EKZQqFgnotAuEEn7lU46Mam/r+FbPAafY/ZVYM1fzfMgsEc+80chhnCTHpqRRpm
         VGOkeZ0mq1JAr995oNN3kLqlXN5/rBynwolDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NNDon416OtIiKvYg/i1JeW0jt8Q5PbvuSKtWQPBLHSU=;
        b=GqqZykGKC1ZL7SdlcB9uhs2Nl4Kg/rb/VQI4GjGwJaqSydeCTFLWZBnRk51ZvPntJJ
         ncqoHOy5qcIg6dKIz6Npd37IFGN3/20nVoNdkaQh47qhDMqJxD9WgGodYtK8r23hrI6H
         NyXKoMY8BTB31u28geKEKpv1m+ZjbZm9ZGt09UIlC6ezcxitX5E0UtjG88hIrpJeKVjT
         2OMzKs1yTtt2L7juG0GMeLkhZusGksQhL+PeYUDgJ9GRV5TkDIxwBdehtQC57lpurIN3
         SCh+eCIQzm/AOskEavH6RCCXWKs3KlTEzPdtVKeoqzAWxs6UG3AfaaUdySHGm11aATGy
         nhDg==
X-Gm-Message-State: APt69E3S9RTXnTmnT1WnGLmNXy57NM4zzB7Oi97MxaXn6xjuIagMozA4
        wqE6ge2VfAHKPIhx0theA3E0y7AnhX4=
X-Google-Smtp-Source: AAOMgpdl+29ez2J6qC4XILySKeycgKDvabc5tcYiEdQe1uEWL5n46IhpPjkuGSGYXQDUWdyGkjtt9A==
X-Received: by 2002:a62:190d:: with SMTP id 13-v6mr949715pfz.103.1530253196148;
        Thu, 28 Jun 2018 23:19:56 -0700 (PDT)
Received: from localhost ([122.172.117.17])
        by smtp.gmail.com with ESMTPSA id 74-v6sm18141596pfj.127.2018.06.28.23.19.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 23:19:54 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>, ulf.hansson@linaro.org,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Nishanth Menon <nm@ti.com>,
        Pavel Machek <pavel@ucw.cz>, Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 00/10] OPP: Support multiple power-domains per device
Date:   Fri, 29 Jun 2018 11:49:30 +0530
Message-Id: <cover.1530252803.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a2c
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series improves the OPP core (and a bit of genpd core as well) to
support multiple phandles in the "required-opps" property, which are
only used for multiple power-domains per device for now.

We still don't propagate the changes to master domains for the
sub-domains, but this patchset is an important stepping stone for that
to happen.

Tested on Hikey960 after faking some power domains for CPUs.

--
viresh

Viresh Kumar (10):
  OPP: Parse OPP table's DT properties from _of_init_opp_table()
  OPP: Identify and mark genpd OPP tables
  OPP: Separate out custom OPP handler specific code
  OPP: Populate required opp tables from "required-opps" property
  OPP: Populate OPPs from "required-opps" property
  OPP: Add dev_pm_opp_{set|put}_required_device() helper
  PM / Domains: Add genpd_opp_to_performance_state()
  OPP: Configure all required OPPs
  OPP: Rename and relocate of_genpd_opp_to_performance_state()
  OPP: Remove of_dev_pm_opp_find_required_opp()

 drivers/base/power/domain.c |  82 ++++----
 drivers/opp/core.c          | 228 ++++++++++++++-------
 drivers/opp/of.c            | 382 ++++++++++++++++++++++++++++++------
 drivers/opp/opp.h           |  18 ++
 include/linux/pm_domain.h   |   7 +-
 include/linux/pm_opp.h      |  16 +-
 6 files changed, 557 insertions(+), 176 deletions(-)

-- 
2.18.0.rc1.242.g61856ae69a2c

