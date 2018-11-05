Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A194ECDE44
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 06:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51E4F2081D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 06:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iaGBk5FJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51E4F2081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729397AbeKEPzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 10:55:17 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41438 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728955AbeKEPzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 10:55:17 -0500
Received: by mail-pf1-f193.google.com with SMTP id e22-v6so3912607pfn.8
        for <linux-kernel@vger.kernel.org>; Sun, 04 Nov 2018 22:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LQ/X2djNrbiIHn07t8baiw4Km3mReqIl8q8AgofJG+E=;
        b=iaGBk5FJOt9he+e8iCataIfHpPyu/xL3CNVsZZ40tSz2rxk0Ei9OAU+9jTsGylVv0h
         26EAz98/a70sTe1kxsh8kvYFppVsTkG1CXCKuR+wbpyjltXbm3ZPYR2Z9O0h+qmq3QY/
         kQvNJjZ/M2vZfhFbJfRyr9lxiM6SaTzzBI1HA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LQ/X2djNrbiIHn07t8baiw4Km3mReqIl8q8AgofJG+E=;
        b=lmfTTrBdo6Y4TLXfawhalBuLclqtiptaZQRAkCrneQOMKTPqXUWHvI2jyBLJhHgisZ
         UzVgmqf5PCIx72IYZz4O5t+tMbekDRrWU9VMhvYFWy2gisAp8JiGQDZxiLR0fJnolyXY
         cv+EwBCP/8tEcQ2drNrUnXd9x3yDHmC3hJTkDiA9hupHqNFzxfbYtiFL32TnLlqxEJK1
         gwz0r23Kdf/dLFDaEXtoWkb9oy7w3KNieiiLbXqpV0Cnq7sfi+X19jLCxoHGZrzPZ9aX
         XiTMk0bixyvUtWIpLMhAkl8Irv5WBMQF9YZGR8Hp0BF5kGr/u9LnS0EX7xpN1g15fodK
         2fTw==
X-Gm-Message-State: AGRZ1gLM8JP+/VPG8qtkmX2q+TLhdBShqNc0Pz/hEkc4vK0KeyEsaF52
        PzMzhtYeYfFLzLzsXVTc26ye3A==
X-Google-Smtp-Source: AJdET5etYWbAq9ZgYnN09jbM6rG6RTM+Yn5S1B6PKYCLSih4CxyxZT9bxaxNflkVnbma5m+Qfn1YaA==
X-Received: by 2002:a63:b16:: with SMTP id 22mr18973859pgl.306.1541399830072;
        Sun, 04 Nov 2018 22:37:10 -0800 (PST)
Received: from localhost ([171.61.116.174])
        by smtp.gmail.com with ESMTPSA id s4-v6sm25493592pfh.168.2018.11.04.22.37.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Nov 2018 22:37:08 -0800 (PST)
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
Subject: [PATCH 0/4] PM / Domains: Allow performance state propagation
Date:   Mon,  5 Nov 2018 12:06:42 +0530
Message-Id: <cover.1541399301.git.viresh.kumar@linaro.org>
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

@Rajendra: Will it be possible for you to run some tests and tell me if
some stuff is still missing as per Qcom requirements ?

Based on opp/linux-next branch (which is 4.20-rc1 +
multiple-power-domain-support-in-opp-core).

--
viresh

Viresh Kumar (4):
  OPP: Add dev_pm_opp_xlate_performance_state() helper
  PM / Domains: Save OPP table pointer in genpd
  PM / Domains: Factorize dev_pm_genpd_set_performance_state()
  PM / Domains: Propagate performance state updates

 drivers/base/power/domain.c | 204 +++++++++++++++++++++++++++---------
 drivers/opp/core.c          |  49 +++++++++
 include/linux/pm_domain.h   |   6 ++
 include/linux/pm_opp.h      |   7 ++
 4 files changed, 217 insertions(+), 49 deletions(-)

-- 
2.19.1.568.g152ad8e3369a

