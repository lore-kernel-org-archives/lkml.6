Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94471C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 12:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 590A02081C
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 12:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OTKtR29E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 590A02081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbeK3ACp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 19:02:45 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43282 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbeK3ACp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 19:02:45 -0500
Received: by mail-wr1-f68.google.com with SMTP id r10so1786247wrs.10;
        Thu, 29 Nov 2018 04:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sqfAvVGQXK4jlNOQ/1Qd1yvPT6TmcecriJz+3bFH3S8=;
        b=OTKtR29EzscppSjcoJ0KzgzWk1bIBfFDMEqDvnviIO3MQI7nCTAUnaJKcDHpzsycj1
         BVxlvoVNdyWtoQDopEGp8XEJTX24Tt3FbilW85QHvhyHri7RlQq/6jVUgFmgWtzEOSlu
         TNglUgQkFCAkZpx7qHU6m6j0fwJdtkRxMNlfwRlC8SouypSuV1wZPU+I5AZ49oB46F8H
         rwTwiX72k/ZC/YOGWS1KNn6oLpazr2L2a9T2/9myeQOmJi/nLPzZNTpoX5RT2abw1ufb
         hjqJEIOrb8bOzP0WEBLfPZ38auFij1Erw/S574XjL2waoucMHn8L1vOvUlNjR5/N7o4Z
         xh0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sqfAvVGQXK4jlNOQ/1Qd1yvPT6TmcecriJz+3bFH3S8=;
        b=mAYgasOoyNdoM+j5iSOexgSyMvGtHuwjVFTksYDOlu3+HywZjfLPnAErSJsK5M9faa
         GEoy6W6XLDYVY/49n+2jow+5LuBDCe60bwNP0fpk9i3VojEXF9kaaLl5kCDSld7c75lL
         xymtIXgIY2uD66Os+YBL1G86sn9of+3wSmKOMFtojmQj3OXhBdXuHmRCecZBkjODVVp4
         R7HUq0IGDzeYpMYFP1ftfsIVZMPY/ps55JOID9jA4CEPc3zLnLxvjPvUiysL+IywpQfG
         Vlv6U49SZLHjhEaZy5Ck3T4QP8SQB/3jDQqFwrlOL09dShsdkUzzCdZxeeUFud3nWRcO
         7b9A==
X-Gm-Message-State: AA+aEWYJdxnrqwUmPZBvE0L0yHu0LQY6a8SXvtlACT/vqPZaDPMvR174
        ltVw7aZmhyz3TZD63Y1264A=
X-Google-Smtp-Source: AFSGD/Wm0z9RMdb2jkjWQ/4+5D2SaqNK3uS8oC6zFSvYvPVuShS7Orkv3Yif2GLc1Jvd36OPMpjzIQ==
X-Received: by 2002:adf:8001:: with SMTP id 1mr1273881wrk.23.1543496246963;
        Thu, 29 Nov 2018 04:57:26 -0800 (PST)
Received: from cperon-Latitude-7490.lan (static-css-csd-151233.business.bouyguestelecom.com. [176.162.151.233])
        by smtp.gmail.com with ESMTPSA id q12sm1816318wrx.31.2018.11.29.04.57.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 04:57:26 -0800 (PST)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH] ARM: dts: socfpga: remove incorrect 0x leading
Date:   Thu, 29 Nov 2018 13:56:49 +0100
Message-Id: <20181129125649.4060-1-peron.clem@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

unit-address does not have a leading "0x" (the number is assumed to be hexadecimal).

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm/boot/dts/socfpga.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index b38f8c240558..715009b8a0a8 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -728,7 +728,7 @@
 			arm,prefetch-offset = <7>;
 		};
 
-		l3regs@0xff800000 {
+		l3regs@ff800000 {
 			compatible = "altr,l3regs", "syscon";
 			reg = <0xff800000 0x1000>;
 		};
-- 
2.19.1

