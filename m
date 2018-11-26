Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5E1C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 686672082F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cuFqq0sb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 686672082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbeKZTDg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 14:03:36 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46329 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbeKZTDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 14:03:36 -0500
Received: by mail-pf1-f194.google.com with SMTP id c73so6171922pfe.13
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 00:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w/GMM1ff8p/gM+URgpq1+8fAO9Gjz+eWd4YbnE/xt2Q=;
        b=cuFqq0sbM4dbCfR1isEaD457wwgRo7duSKA7RMJdvxVuRpoUXU0WDE4d04dPjUNgSk
         VCUfmwrBAJmQnY4ZDjnLz9jQ6nuRXJL8zWv6zjYsFhleCS4XiQ9FEsGOz8MB+L/wI8WB
         5O1TaOdf4KFOmyKVkBK7reKsriky0KbRaAX0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w/GMM1ff8p/gM+URgpq1+8fAO9Gjz+eWd4YbnE/xt2Q=;
        b=bSuzuqedhxtbPyfcUOL5R+HUM0Q3yDgfInFk2oudvbrhanBDn4LzMxcUUYF9zLLi2c
         PwYVEFhylM3kxKwCp2Aoqb+qybL1K6m5dH4X769emr2HD9yXXbK6HQHflNkIbdT1bDs3
         bpmktcr3CN0JQowyBKIJ1G7ypfWyiZTrfUsehNOGAeiU9urswZj8z/6/m8XN75/Z5idt
         kNYVYDkeapaqMdVGbpiKYcAroArOeDPmg//FOySO6+UCFdCClRCgoYG1KVYuHnMeNIYi
         olVg6m9Y4PjNLcJwoxiNR2V2V5EASjqzDpeZlwCIaWHwUgcpC3/IUNDEIywsmNF8N2bA
         UO3g==
X-Gm-Message-State: AA+aEWZGM/mQRZ47exs0LOl73a//ko/vR3QIwOT9dPJHol2cbV/jvwgm
        Tjr6a1wiakCPqFDnJS5WgPmFrw==
X-Google-Smtp-Source: AFSGD/Wy7pTOwKlEbxX+86GJIT3b9YpEup09CIN0JS9rd/mCw2qLdnf6LFXHPMPwjnUuIc5d7XpJcg==
X-Received: by 2002:a63:588:: with SMTP id 130mr23447488pgf.273.1543219816695;
        Mon, 26 Nov 2018 00:10:16 -0800 (PST)
Received: from localhost ([122.172.88.116])
        by smtp.gmail.com with ESMTPSA id 12sm41463533pgd.35.2018.11.26.00.10.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 00:10:15 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     ulf.hansson@linaro.org, Rafael Wysocki <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Nishanth Menon <nm@ti.com>,
        Pavel Machek <pavel@ucw.cz>, Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        rnayak@codeaurora.org, niklas.cassel@linaro.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH V2 0/5] PM / Domains: Allow performance state propagation
Date:   Mon, 26 Nov 2018 13:39:59 +0530
Message-Id: <cover.1543219386.git.viresh.kumar@linaro.org>
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

Viresh Kumar (5):
  OPP: Improve _find_table_of_opp_np()
  OPP: Add dev_pm_opp_xlate_performance_state() helper
  PM / Domains: Save OPP table pointer in genpd
  PM / Domains: Factorize dev_pm_genpd_set_performance_state()
  PM / Domains: Propagate performance state updates

 drivers/base/power/domain.c | 211 +++++++++++++++++++++++++++---------
 drivers/opp/core.c          |  59 ++++++++++
 drivers/opp/of.c            |  14 ++-
 include/linux/pm_domain.h   |   6 +
 include/linux/pm_opp.h      |   7 ++
 5 files changed, 244 insertions(+), 53 deletions(-)

-- 
2.19.1.568.g152ad8e3369a

