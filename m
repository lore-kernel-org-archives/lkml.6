Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97AAAC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F2F02086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bxEg+/uJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F2F02086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbeLLK5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 05:57:48 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36865 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbeLLK5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 05:57:47 -0500
Received: by mail-pl1-f196.google.com with SMTP id b5so8442499plr.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 02:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F2He1B6yRQHqXPfpJF/Ewa/VYdJpIJlq9/PIr81XRzc=;
        b=bxEg+/uJwaRxAKNbVfiNqZ8S70s5iQSZWgmDRca5Qq+7BEcO6m36IgPE37XoMhOs4W
         n5KXhK4Xw+okUJWxBJkOjPoJWAZTa+IMXjsKqeZl9j5PTjt69KHZRSc4zpd2Ie94zo2b
         oOQapQUBaTgEUQzZExHU5WigBfnwynVZ7RryM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F2He1B6yRQHqXPfpJF/Ewa/VYdJpIJlq9/PIr81XRzc=;
        b=poviVL4L6X4BHU6zJY7c0sTkoTEBWhe6p+/5zIF6CU1q8OSedJww6zmzNHMTBjPntA
         +LMMvxDio9k8Vs4GkZKxmm1e69FCEm3NePSfK5hy+83RkTLM8hQKNFu29gbu2WqcpqKk
         RTZssgbBfcDYxncFem8OD6iODaj2TI3JIpyZi86/T35++7UFHGIVMhpOvZNkZkOQ10qg
         92brb5LCiDovTqeUm745US/IiWIxR/u9GSL+NEXUh32rHoRr1ALRV1e+7yF8wGgd/7q0
         0wS2/FujBObZ0H1+fUbSwwW/+Uhy4ZVjoZy491eIulhP2D+m4c3U6LlqsNStYAXqgOHv
         +T7g==
X-Gm-Message-State: AA+aEWYSABq9lqzZvv3yEMlM1XB7F5LiDYqkqEjA1ptDoOm1UnOGyLcb
        Gzi9oSTV7gN35ni2iSlZ1bcJqw==
X-Google-Smtp-Source: AFSGD/V1ePew6MN2sudy5JnQyLNmZvJh1aiQB3HN9ko5Mz16kwHQR3Qmm16Ax87AiWf/JzCjEQ2FXA==
X-Received: by 2002:a17:902:ab84:: with SMTP id f4mr18963635plr.207.1544612266814;
        Wed, 12 Dec 2018 02:57:46 -0800 (PST)
Received: from localhost ([122.172.23.29])
        by smtp.gmail.com with ESMTPSA id 15sm25378406pfr.55.2018.12.12.02.57.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 02:57:46 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     ulf.hansson@linaro.org, Rafael Wysocki <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Nishanth Menon <nm@ti.com>,
        Pavel Machek <pavel@ucw.cz>, Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        rnayak@codeaurora.org, niklas.cassel@linaro.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 0/6] PM / Domains: Allow performance state propagation
Date:   Wed, 12 Dec 2018 16:27:23 +0530
Message-Id: <cover.1544611890.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e3369a
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series adds performance state propagation support in genpd core.
The propagation happens from the sub-domains to their masters. More
details can be found in the individual commit logs.

This is tested on hikey960 by faking power domains in such a way that
the CPU devices have two power domains and both of them have the same
master domain. The CPU device, as well as its power domains have
"required-opps" property set and the performance requirement from the
CPU eventually configures all the domains (2 sub-domains and 1 master).

Based on opp/linux-next branch (which is 4.20-rc1 +
multiple-power-domain-support-in-opp-core + some OPP fixes).

Rajendra has already tested the previous version of this series and so I
have included his Tested-by for all patches.

V2->V3:
- Include Ulf's patch (sent separately earlier) with this series.
- The performance state update code doesn't rely anymore on the power
  on/off state of the genpd, it sets and propagates rate in all cases.
- That simplified a lot of code from V2 in _genpd_power_on().
- commit logs improved for few commits.
- s/mstate/master_state/
- and few more minor changes.

v1->V2:
- First patch (1/5) is new and an improvement to earlier stuff.
- Move genpd_status_on() check to _genpd_reeval_performance_state() from
  _genpd_set_performance_state().
- Improve dev_pm_opp_xlate_performance_state() to handle 1:1 pstate
  mapping between genpd and its master and also to fix a problem while
  finding the dst_table.
- Handle pstate=0 case properly.

--
viresh

Ulf Hansson (1):
  PM / Domains: Make genpd performance states orthogonal to the
    idlestates

Viresh Kumar (5):
  OPP: Improve _find_table_of_opp_np()
  OPP: Add dev_pm_opp_xlate_performance_state() helper
  PM / Domains: Save OPP table pointer in genpd
  PM / Domains: Factorize dev_pm_genpd_set_performance_state()
  PM / Domains: Propagate performance state updates

 drivers/base/power/domain.c | 207 ++++++++++++++++++++++++++----------
 drivers/opp/core.c          |  59 ++++++++++
 drivers/opp/of.c            |  14 ++-
 include/linux/pm_domain.h   |   6 ++
 include/linux/pm_opp.h      |   7 ++
 5 files changed, 235 insertions(+), 58 deletions(-)

-- 
2.19.1.568.g152ad8e3369a

