Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B29F5ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 23:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C7692085B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 23:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nnw4Lyhx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C7692085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728592AbeJ0HrY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 03:47:24 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45979 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727792AbeJ0HrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 03:47:24 -0400
Received: by mail-lj1-f194.google.com with SMTP id j4-v6so2586431ljc.12;
        Fri, 26 Oct 2018 16:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=L8dmqs8+JcguFonuxCU/KeaANM+gcIcSgVIgiIq4Kjc=;
        b=nnw4LyhxnL9ufVB2+IAFVemJ/Q9m89RLf7xv6SY/A7CiS2sD0TWZJq8nwxqYUTunqX
         k2Qtw0uBXmjU9q1hQYNcSIkkUtGLwSWg8qpy7e5HW6ANNjq5phZR5IF7TovaLcAvTwcg
         YCXlW0txdS1V8f5oEbW14FiPOGLtDQwyL/lOP24WtBbUsPcOGuflPfUImqc2RGyJaYVf
         b/7BGZCDH/MwMhFJs3myB1l0i5//yG6Yvj8s6BzqvHRubr/P43kgZRLBrTUW9blJIy1S
         zOhC5x2VFtaI2lqcOVy/oMGBPfzcYD1YD+Do12kNVYh8Pmylx/rRL168t4d4HI/ESYBE
         Zrew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=L8dmqs8+JcguFonuxCU/KeaANM+gcIcSgVIgiIq4Kjc=;
        b=ZAkj6Z07zyNbmsIeNFXA4/VKKr97ZiAowdcehjPdEoYp3wvf7W9Aje8bAr+8bvJpDI
         HbcWTzifSXWh57iixHeXPU5nMhpMgzoMbA7dph+Ipyoe265f28kOrPxfGaQKXw2Vrp1l
         ZvMTk78qeXFOo+MWVVBYDmm6SBCJTBD/2Xbf71Fa5CCL927ZxUxkGewstb2UCnGSwc8F
         j3G2CojKgxk6GVftfxKmPAfhjV2zOWjwl+pqvcvRT0lYQSvh5xr0savX0ZxpZm8tRL2D
         myJJrY9SwQEZbe09oKNXc1yAz66v+FkRKJHtBXmgfReWt6O0I3flFIYqrodr/gYv/mnF
         2hCA==
X-Gm-Message-State: AGRZ1gKVpcxcooy+YhbCfkeAFE1ETgYZj5T1/809NUL6O1Jqu0MOtzbz
        zAhXRVArnOXD+fNYtXfEq153rY3D9/SpzUOK
X-Google-Smtp-Source: AJdET5dQzAgmeCEPEAJHA/ek9SNcAXQcpRZtyPZ7RxbIDn4EIO7MIqf3bvr/ztUAtMDCBN+9cnI3XA==
X-Received: by 2002:a2e:6e08:: with SMTP id j8-v6mr3956822ljc.61.1540595306462;
        Fri, 26 Oct 2018 16:08:26 -0700 (PDT)
Received: from gilgamesh.tlms.ru ([195.34.41.43])
        by smtp.gmail.com with ESMTPSA id z67-v6sm1959511lfa.14.2018.10.26.16.08.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Oct 2018 16:08:25 -0700 (PDT)
From:   Misha Komarovskiy <zombah@gmail.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     zombah@gmail.com, Ike Panhc <ike.pan@canonical.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: ideapad: Add Y530-15ICH to no_hw_rfkill
Date:   Sat, 27 Oct 2018 02:07:23 +0300
Message-Id: <20181026230723.12215-1-zombah@gmail.com>
X-Mailer: git-send-email 2.13.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lenovo Legion Y530-15ICH is another model without
hardware radio switch. Add it to no_hw_rfkill to
enable wireless.

Signed-off-by: Misha Komarovskiy <zombah@gmail.com>
---
 drivers/platform/x86/ideapad-laptop.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index f856d59361f2..b6489cba2985 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -1147,6 +1147,13 @@ static const struct dmi_system_id no_hw_rfkill_list[] = {
 		},
 	},
 	{
+		.ident = "Lenovo Legion Y530-15ICH",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo Legion Y530-15ICH"),
+		},
+	},
+	{
 		.ident = "Lenovo Legion Y720-15IKB",
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-- 
2.13.7

