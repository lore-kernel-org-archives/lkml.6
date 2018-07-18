Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA436ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 22:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 729DB20850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 22:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kepstin.ca header.i=@kepstin.ca header.b="vL/6A65+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 729DB20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kepstin.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730534AbeGRXHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 19:07:12 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:33159 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730053AbeGRXHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 19:07:12 -0400
Received: by mail-io0-f193.google.com with SMTP id z20-v6so5466856iol.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 15:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kepstin.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j0xFaJbwJ/MHER0BQC5OzaLd9qP1rA6+NEyBochapKU=;
        b=vL/6A65+FcfgWjhcrfJKUP4eBZ7xx2rPEn4hl4PfwbqKUDx3hTK4c7MEcisspkoMGi
         7bKLor19rW90a/CxlRIv9znGZhGlX1rur4hjAUGCYwyIBIi2GwNlWk5vUpu1+x552QVq
         /bz95OeEpMMRyFAYVM9jZ2h/8wshzIAYwYqFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=j0xFaJbwJ/MHER0BQC5OzaLd9qP1rA6+NEyBochapKU=;
        b=f9KT7+AF40xBktm4Eu2fB5RQmuarHllh8Z9DTGda5cAySDaTkO0X7Lxu/8FTt/8zYW
         VgrR7b4XnsPsFoMvLN2weGOr7FiWVaM/43wZHDMfK5NkPRpxQZdGcMNiZeTfZ9KXpW9q
         2d+4gz+sX37ny/q4MW4G0sYt7dCcSO3/+Hfiy4Dw1RtBelp2QYSQvR8/1RR8pS6wj9do
         iQ1+B0keNMFEE7el4OXsIbrPCXAoCATiHjechtlkKx0NbllyKcoC68XlfSjc029+0Sqg
         9lRgVFy0vXSvoGAS8Wkgri/plczsnZBEDxKYmenOnVYOj8pewANtIW2Ge4sgDEwi6D/f
         lyyg==
X-Gm-Message-State: AOUpUlGN/QwGifPn87jW2fW1LyU1IYqvNKzbEY1yFB1xOkTnRhMxsjoK
        gFOexRYyVOJ72+3/Ei3kQvPcg+PBkU9fJw==
X-Google-Smtp-Source: AAOMgpegyBvDy28yUE7FayUu/10goxtH1i5dxWhT6lYGo0Ux3xH3Q5Ksie7hCUr6r25A4jia2w0g6g==
X-Received: by 2002:a6b:8265:: with SMTP id e98-v6mr6491657iod.287.1531952831983;
        Wed, 18 Jul 2018 15:27:11 -0700 (PDT)
Received: from fuko.kepstin.ca ([2001:470:b3f4::561])
        by smtp.gmail.com with ESMTPSA id j11-v6sm2060803itj.6.2018.07.18.15.27.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 15:27:11 -0700 (PDT)
From:   Calvin Walton <calvin.walton@kepstin.ca>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <len.brown@intel.com>
Cc:     Calvin Walton <calvin.walton@kepstin.ca>
Subject: [PATCH 1/2] turbostat: Read extended processor family from CPUID
Date:   Wed, 18 Jul 2018 18:26:55 -0400
Message-Id: <20180718222656.11795-2-calvin.walton@kepstin.ca>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180718222656.11795-1-calvin.walton@kepstin.ca>
References: <20180718222656.11795-1-calvin.walton@kepstin.ca>
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
---
 tools/power/x86/turbostat/turbostat.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index bd9c6b31a504..f404d67fda92 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -4031,7 +4031,9 @@ void process_cpuid()
 	family = (fms >> 8) & 0xf;
 	model = (fms >> 4) & 0xf;
 	stepping = fms & 0xf;
-	if (family == 6 || family == 0xf)
+	if (family == 0xf)
+		family += ((fms >> 20) & 0xff);
+	if (family == 6 || family >= 0xf)
 		model += ((fms >> 16) & 0xf) << 4;
 
 	if (!quiet) {
-- 
2.18.0

