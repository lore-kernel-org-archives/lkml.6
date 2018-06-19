Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E086C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C96B20652
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TojAlovl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C96B20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030224AbeFSRCh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 13:02:37 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:41719 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966646AbeFSRCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 13:02:35 -0400
Received: by mail-pl0-f68.google.com with SMTP id w8-v6so167291ply.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 10:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=z4HkEpFfLQDBCBA9bGSgAGxLAfLQcwR2KZECUlJUKfk=;
        b=TojAlovlcxTy3nKmuhTmVEiDTkMbkzHoqBaKqoFslYOhRGA3jdi2gaTLp7WntLzS66
         oPnl7TH9Gxgc9gA4a5EsVeJobX1LUvQZMAlMYep0xzV9kN0mdOCsVn8TMggFxJ744b2a
         s4KCA5LA9r+/9W8lqGoKyh7OSWxdaFOJDWfuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=z4HkEpFfLQDBCBA9bGSgAGxLAfLQcwR2KZECUlJUKfk=;
        b=bjpKdwn+SMGe5COC8c3oIE4/wsouYIuToXjzH2jYNoJ5W04XDInQUy690nbgt3rYc7
         eh5MUvcZ/8x7lDHkV5ZCOUyeyVS02sHhdL2bjfNMi5Vq1l+ldfX0RmK1u09D/pE7afNt
         aXvL1bJJ+nKAt57+1tHpOpcElr+B8o31APqp9f0tub774Cv8Yy7D9Q1pqsIzDrScVGqb
         5VL7f4bWwD24l4oPrjdIHLChveLqJjE77hv7IzLQfUeph+4OijnKaH9H2FQXLT7vp8vK
         V23SKG5XMkLN1sfCIARoSuN5XcZpenTvyZmLWb/uU9+hIwOv6ANdrb6mQG5ltiLOOwWc
         BHEg==
X-Gm-Message-State: APt69E1E5fCLkU3QVHUMvSOZAKIN7UWBPB+NCTS6k1pIBavqBy5Hmb1i
        b7eg8uISkh+s5xgPNQWsQdUjGA==
X-Google-Smtp-Source: ADUXVKJxOGazESnlH1oE1ISL2pFiMFdYZNMNYo6/v+5k0i9V0mGs5morqMvhW/zj7Rw2LtrwPjChJw==
X-Received: by 2002:a17:902:7604:: with SMTP id k4-v6mr19321729pll.13.1529427755502;
        Tue, 19 Jun 2018 10:02:35 -0700 (PDT)
Received: from ban.mtv.corp.google.com ([2620:0:1000:1501:bc2f:3082:9938:5d41])
        by smtp.gmail.com with ESMTPSA id v13-v6sm285511pfa.131.2018.06.19.10.02.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 10:02:33 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org,
        devel@acpica.org, Matthias Kaehlcke <mka@chromium.org>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH] ACPI / processor: Finish making acpi_processor_ppc_has_changed() void
Date:   Tue, 19 Jun 2018 10:02:01 -0700
Message-Id: <20180619170201.36531-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit bca5f557dcea ("ACPI / processor: Make
acpi_processor_ppc_has_changed() void") changed one of the declarations
of acpi_processor_ppc_has_changed() to return void, but the !CPU_FREQ
version still return int. Let's return void to be consistent.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 include/acpi/processor.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index 40a916efd7c0..1194a4c78d55 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -309,7 +309,7 @@ static inline void acpi_processor_ppc_exit(void)
 {
 	return;
 }
-static inline int acpi_processor_ppc_has_changed(struct acpi_processor *pr,
+static inline void acpi_processor_ppc_has_changed(struct acpi_processor *pr,
 								int event_flag)
 {
 	static unsigned int printout = 1;
@@ -320,7 +320,6 @@ static inline int acpi_processor_ppc_has_changed(struct acpi_processor *pr,
 		       "Consider compiling CPUfreq support into your kernel.\n");
 		printout = 0;
 	}
-	return 0;
 }
 static inline int acpi_processor_get_bios_limit(int cpu, unsigned int *limit)
 {
-- 
2.18.0.rc1.244.gcf134e6275-goog

