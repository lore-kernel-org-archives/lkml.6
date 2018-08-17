Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7DCC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 16:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8101B21A2E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 16:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kepstin.ca header.i=@kepstin.ca header.b="PE67LQCX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8101B21A2E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kepstin.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbeHQTjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 15:39:06 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:33155 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727445AbeHQTjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 15:39:06 -0400
Received: by mail-it0-f67.google.com with SMTP id d16-v6so2003509itj.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 09:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kepstin.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=u1TrFWHy02RZ2+FgmBn2A1MObXh+m/iSNWFN4bbBlXw=;
        b=PE67LQCXGL4IZ06VI91G+g/0Lelh/CEpcUYQ/bnXDiU0DaPueS1ME9sxfGQF99qM67
         W292JU9FCbZJcCqD/pO6lP1mBIZNLR9fXmxmxffda4ZUelQatNAJ8uEPgNzaikAUJe3X
         eGkr1Aa/reIsrIt9VTVxGc9EiIK0Q+9IH/NeM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=u1TrFWHy02RZ2+FgmBn2A1MObXh+m/iSNWFN4bbBlXw=;
        b=hZqiZ9hBdC9ZpEK08BnFJhoKtH61+MDSxY3WcOmufgZMhWADqAt6ax2Y4xo/VrKFfN
         T+xbI+oX5fm4aWIluvA3HRo92G2YNDHBN7ZrlAKOmYhKww5dBQbpjurNSfSSiMjt3+k7
         zIajpoV6RzCWkvnLdXh1TM02RKDVyMFUpV9Swgn8YJOFx1mumRVdxOcoK8EFwOr+OISO
         F5YxXdS68kGN0hjZkCvmwqEggpvAJHbK7N+8HGfRTuThr4QC7GoTTqx1aycOJ0BQI5j3
         iimLdS/1qP+K99pSn9lPu35KUgkiOJOWiJIsEL5vvfADTOYtYYhvkhlSLNFpjtFI9b0n
         MXPg==
X-Gm-Message-State: AOUpUlH1Rb+rG+cbDQtroyAtbTSG5cTjait7SLomaxtAw4q7AtN/uL+l
        R7mbsXPeI/o5rXuhDVLhoOj8YfWnCxSoEQ==
X-Google-Smtp-Source: AA+uWPxPk2XeW2Sd4tY5oTpYS4chdb0TazMACLPHqYl1Rq4Uegio1mOA5SvHn/eI+lfgMhiPY+jFFA==
X-Received: by 2002:a24:b54b:: with SMTP id j11-v6mr25988301iti.79.1534523703029;
        Fri, 17 Aug 2018 09:35:03 -0700 (PDT)
Received: from fuko.kepstin.ca ([2001:470:b3f4::561])
        by smtp.gmail.com with ESMTPSA id e140-v6sm1947974itc.24.2018.08.17.09.35.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Aug 2018 09:35:02 -0700 (PDT)
From:   Calvin Walton <calvin.walton@kepstin.ca>
To:     Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Calvin Walton <calvin.walton@kepstin.ca>
Subject: [PATCH v3 2/2] [WIP] tools/power turbostat: Also read package power on AMD F17h (Zen)
Date:   Fri, 17 Aug 2018 12:34:42 -0400
Message-Id: <20180817163442.10065-3-calvin.walton@kepstin.ca>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180817163442.10065-1-calvin.walton@kepstin.ca>
References: <20180817163442.10065-1-calvin.walton@kepstin.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The package power can also be read from an MSR. It's not clear exactly
what is included, and whether it's aggregated over all nodes or
reported separately.

It does look like this is reported separately per CCX (I get a single
value on the Ryzen R7 1700), but it might be reported separately per-
die (node?) on larger processors. If that's the case, it would have to
be recorded per node and aggregated for the socket.

Note that although Zen has these MSRs reporting power, it looks like
the actual RAPL configuration (power limits, configured TDP) is done
through PCI configuration space. I have not yet found any public
documentation for this.

Signed-off-by: Calvin Walton <calvin.walton@kepstin.ca>
---
 tools/power/x86/turbostat/turbostat.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 89d4e2e75774..675c894b8595 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1973,6 +1973,11 @@ int get_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 			return -16;
 		p->rapl_dram_perf_status = msr & 0xFFFFFFFF;
 	}
+	if (do_rapl & RAPL_AMD_F17H) {
+		if (get_msr(cpu, MSR_PKG_ENERGY_STAT, &msr))
+			return -13;
+		p->energy_pkg = msr & 0xFFFFFFFF;
+	}
 	if (DO_BIC(BIC_PkgTmp)) {
 		if (get_msr(cpu, MSR_IA32_PACKAGE_THERM_STATUS, &msr))
 			return -17;
@@ -3986,10 +3991,13 @@ void rapl_probe_amd(unsigned int family, unsigned int model)
 	switch (family) {
 	case 0x17: /* Zen, Zen+ */
 		do_rapl = RAPL_AMD_F17H | RAPL_PER_CORE_ENERGY;
-		if (rapl_joules)
+		if (rapl_joules) {
+			BIC_PRESENT(BIC_Pkg_J);
 			BIC_PRESENT(BIC_Cor_J);
-		else
+		} else {
+			BIC_PRESENT(BIC_PkgWatt);
 			BIC_PRESENT(BIC_CorWatt);
+		}
 		break;
 	default:
 		return;
-- 
2.18.0

