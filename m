Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA11BC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 19:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AFED218EA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 19:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gaYeCb1v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729651AbfABTgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 14:36:13 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34445 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727608AbfABTgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 14:36:12 -0500
Received: by mail-ed1-f65.google.com with SMTP id b3so27205609ede.1;
        Wed, 02 Jan 2019 11:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=r9AosAxJcFz5w/zKJPIe7Lr7elemtBB7jYeNGbWlqAU=;
        b=gaYeCb1vHD2WfKSEpklqyfZ/P7Rx+UI6xe/s2O6ImbVbQAXF/vYKTelSoCmzJ2A3Jf
         lRID6SfqSaxSXkE3mgHiyU4yaPQZ/tL8STK2YbMcl+yN8tfcxjvvQHlGpmYfwzPAcB10
         5WdWeBYSDONhxli5dlzoalGJFg6uy+bjpzubMNCrxW2KH8uX4M/KKYgLLMG3PjFqINDm
         2I0YXA/KhbkW69WPW4yzzA1q3P30CxMJFSdYudDZsq57nd+v/DuN9iKPtPqLyw7sI0gB
         HO4OakO14AlYJp54C+NFydy/FWXfi9aG0riJb4J6Vu1OAtp0BkXDfBrKiWKiRuPXCtdn
         +/eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=r9AosAxJcFz5w/zKJPIe7Lr7elemtBB7jYeNGbWlqAU=;
        b=ke0k8wonFbaAKVwQdbf1M6XzT+qtp0MRvyAqQRh9TPE5qL/WWuQqV+r2r5cfyqGWNS
         anh7/3vCK8ccFrG3H2S3stEsbzWIH9GvukLhPcvTbzlInKY2RNofqGGHDcauVFWfp+xn
         USB9p9QFK4Pfx4loHWlbjhcqgmZmCeUfoVO6u2nyhv8lnHsfegDah4tJtpgd1W/YsJ7a
         r6fLQtSGhbk+jLHos2xc7eZtIacx2EeZ+JRxmVPBGFL/NbN4dnhT390IiMhC763O+0R/
         xYitfRR0P3ApJS9eiS9/vFLaiAPhanvSot/u0wUNKYtfMAbyomykBmj7QfLU24cA0Now
         HRmQ==
X-Gm-Message-State: AA+aEWaOmhppKcIhR7mbe2X/XjVzPPZaVKIGoR2yrOaqFNwyuBEovv4c
        oNt8Bfuga9hugQf8HFISzyU=
X-Google-Smtp-Source: AFSGD/XFqFi/xtOVtYUN3w97hiQDH4uQg1uXbJOXvvl/VYxobqvzPZyCf+DN8KTxWhYXjhmhOHTuvA==
X-Received: by 2002:a50:cdd0:: with SMTP id h16mr41116215edj.151.1546457771048;
        Wed, 02 Jan 2019 11:36:11 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id v20sm22326532edm.29.2019.01.02.11.36.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Jan 2019 11:36:10 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: rockchip: rk3188: remove qos_cif1
Date:   Wed,  2 Jan 2019 20:35:52 +0100
Message-Id: <20190102193552.5853-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the rk3066 does have 2 camera interfaces, the rk3188 does not, so
there also isn't a QoS block for that non-existing interface, so remove it.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3188.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk3188.dtsi b/arch/arm/boot/dts/rk3188.dtsi
index 4acb501dd..3ed49898f 100644
--- a/arch/arm/boot/dts/rk3188.dtsi
+++ b/arch/arm/boot/dts/rk3188.dtsi
@@ -719,7 +719,6 @@
 			pm_qos = <&qos_lcdc0>,
 				 <&qos_lcdc1>,
 				 <&qos_cif0>,
-				 <&qos_cif1>,
 				 <&qos_ipp>,
 				 <&qos_rga>;
 		};
-- 
2.11.0

