Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F2AC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 11:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB4272089F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 11:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kepstin.ca header.i=@kepstin.ca header.b="GDKLmOax"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB4272089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kepstin.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730801AbeG0M74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 08:59:56 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:38540 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730568AbeG0M7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 08:59:55 -0400
Received: by mail-it0-f65.google.com with SMTP id v71-v6so6923746itb.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 04:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kepstin.ca; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=8X+pkn91M35ugopLay0L/cQmVmMlQKHVL/hCFSfYtvU=;
        b=GDKLmOaxb6UOaFpTjkIYxn96IDhRVCq+GuMBSgx95kIjHpi+P0lggXLSITww0gWyFP
         yYMQCsHyLD5iVeiInf5hDBgE6/alrtxsklxHKuUSL7e/oNQbyfuJaiqtC347R9C3iYDN
         ye/UDrr0vLB8LuQIju2SBveOxVhzYjEZM8dmw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8X+pkn91M35ugopLay0L/cQmVmMlQKHVL/hCFSfYtvU=;
        b=sD4YVhK6ARVZZETJ37tzykbEAR9tV2VJNcbgJvAeClmYmoJO2WZRSn5KCycCSnYnXi
         HAlxKeT0HY6PCcrG0ChzDu0T/u6sz9fC6ixbjZGyOaKceVhjrZEWxfL4KEa5zV9Ada0L
         nAMmuPZQCHF5H3bwuwnc5VKO9NSUN+57tnpylxwIRRYai4RF6/Q5W6rnbdgwN/nlUtgO
         de0m7p8PP7pSK8dcAhgh53WGx9ZJR6PqFV/iSzubOn2be1KbgkgMVVjEmBvOBkvTiQFM
         ASuuL/h5Mk/hCwFx+j7hxhWINE+zsSc4kUj0DwC/JfJhH6+abL+uZpCWbj9ABZHvTnyT
         TdAQ==
X-Gm-Message-State: AOUpUlHVR47QkWc5LDqFIZgd5fv2IWSMBEHTao4Q4VzZVpOAAD3a3sGH
        vfJGvm8S4+Bd/RMvVlfdhbHZfw==
X-Google-Smtp-Source: AAOMgpdwsGHHSC2dE6WfI9nNmTOgBWCgtulcEerCuHfJ/GeXnFgIPeA+tgiv1TgWnTSy0u04c7C4HQ==
X-Received: by 2002:a24:97cd:: with SMTP id k196-v6mr4831805ite.93.1532691503950;
        Fri, 27 Jul 2018 04:38:23 -0700 (PDT)
Received: from fuko.kepstin.ca ([2001:470:b3f4::561])
        by smtp.gmail.com with ESMTPSA id e2-v6sm1302869ioa.33.2018.07.27.04.38.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 04:38:23 -0700 (PDT)
From:   Calvin Walton <calvin.walton@kepstin.ca>
To:     Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Calvin Walton <calvin.walton@kepstin.ca>
Subject: [PATCH v2] turbostat: Read extended processor family from CPUID
Date:   Fri, 27 Jul 2018 07:38:09 -0400
Message-Id: <20180727113809.8427-1-calvin.walton@kepstin.ca>
X-Mailer: git-send-email 2.18.0
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

I'm still working on updating the RAPL patch on top of the changes for
v4.18, but this CPUID fix doesn't have to wait.

 tools/power/x86/turbostat/turbostat.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index bd9c6b31a504..8452ace384b3 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -4031,7 +4031,9 @@ void process_cpuid()
 	family = (fms >> 8) & 0xf;
 	model = (fms >> 4) & 0xf;
 	stepping = fms & 0xf;
-	if (family == 6 || family == 0xf)
+	if (family == 0xf)
+		family += (fms >> 20) & 0xff;
+	if (family == 6 || family >= 0xf)
 		model += ((fms >> 16) & 0xf) << 4;
 
 	if (!quiet) {
-- 
2.18.0

