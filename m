Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97267C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 11:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39525208A5
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 11:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kepstin.ca header.i=@kepstin.ca header.b="wVuG2DuJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39525208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kepstin.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730596AbeG0NMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 09:12:31 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:52235 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729493AbeG0NMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 09:12:31 -0400
Received: by mail-it0-f67.google.com with SMTP id d9-v6so6919341itf.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 04:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kepstin.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ppS0Z+0XQKpXI1g3ftBCHbTOfJriz5sRtIY97NEjC+k=;
        b=wVuG2DuJ+IjXzKLJKl5u1mVCuTYMhBk6urJMRhbnG3xRm3vNTBE3sp1H53Z8dJKWc2
         sGpeDdcfr1ewuejy6uv2vh4R6beSBUETW4by+lzdsamdwDeqCPalEYJT/h03kJGNwcOn
         JZ++LbctE3bP/BJ69MPW7dF6kpL4Lgf9x1jww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ppS0Z+0XQKpXI1g3ftBCHbTOfJriz5sRtIY97NEjC+k=;
        b=Nb2Y35i5IMQ7myIwocBTkbe12kVKjXsROQPEzFTt14fuKeQ+1nc90zaCDuONbuHoKD
         gpBtw3BdNs3fdAX1DwU/B9tKxqByPqNj2TOQyf0nusmdt8Oj0tFMQDqW3c1by/H/SH0k
         HKTZTBHchPpUg4VFwNac9Feozr0bNax+A2tQw6QBlSIXHaspDFcyfAvQRdhglRSPfaFw
         5CTYTV9C0iIdi4ZU6GcSca7Brpjq7Fb5VFaIQcA7CroGbPTIUh22YYLPmocQUuu4qMtO
         axqCjJFuhhzWjswr92Kmzb7SDo2Dk9t1edgfRjB0DheQUY6V6UXkVsqtWt1Y/tzaODvp
         /kog==
X-Gm-Message-State: AOUpUlEAYGsGcm/bLcznbHLGZEBX42Hy8Xxfmyyi98gnRKtIg7Q84mVb
        UfZJT75mOMj1EsCMMsXTaWChrQ==
X-Google-Smtp-Source: AAOMgpfW+O0yXgZNQqdeiu6abzpEF1oQ7FaE5HWkxTk00DjMXe1Nd7sOfh1iZiTMiK+K8L8OQdKing==
X-Received: by 2002:a02:b4a4:: with SMTP id k33-v6mr5433245jaj.53.1532692257092;
        Fri, 27 Jul 2018 04:50:57 -0700 (PDT)
Received: from fuko.kepstin.ca ([2001:470:b3f4::561])
        by smtp.gmail.com with ESMTPSA id n127-v6sm2333542itn.7.2018.07.27.04.50.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 04:50:56 -0700 (PDT)
From:   Calvin Walton <calvin.walton@kepstin.ca>
To:     Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Calvin Walton <calvin.walton@kepstin.ca>
Subject: [PATCH v3] turbostat: Read extended processor family from CPUID
Date:   Fri, 27 Jul 2018 07:50:53 -0400
Message-Id: <20180727115053.8965-1-calvin.walton@kepstin.ca>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727113809.8427-1-calvin.walton@kepstin.ca>
References: <20180727113809.8427-1-calvin.walton@kepstin.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the reported family on modern AMD processors (e.g. Ryzen,
which is family 0x17). Previously these processors all showed up as
family 0xf.

See the document
https://support.amd.com/TechDocs/56255_OSRR.pdf
section CPUID_Fn00000001_EAX for how to calculate the family
from the BaseFamily and ExtFamily values.

This matches the code in arch/x86/lib/cpu.c

Signed-off-by: Calvin Walton <calvin.walton@kepstin.ca>
---

v3: Having just looked at the arch/x86/lib/cpu.c code again, I realized
that it *didn't* actually match - the kernel code uses family >= 6 for
applying the extended model number, while I was applying it only to
 family == 6 or family >= 0xf. Change that to match for consistency.

v2: I'm still working on updating the RAPL patch on top of the changes for
v4.18, but this CPUID fix doesn't have to wait.

 tools/power/x86/turbostat/turbostat.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index bd9c6b31a504..ed024deed36f 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -4031,7 +4031,9 @@ void process_cpuid()
 	family = (fms >> 8) & 0xf;
 	model = (fms >> 4) & 0xf;
 	stepping = fms & 0xf;
-	if (family == 6 || family == 0xf)
+	if (family == 0xf)
+		family += (fms >> 20) & 0xff;
+	if (family >= 6)
 		model += ((fms >> 16) & 0xf) << 4;
 
 	if (!quiet) {
-- 
2.18.0

