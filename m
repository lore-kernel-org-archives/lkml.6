Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24859ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 09:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCFE620821
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 09:31:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="U5IymNAl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCFE620821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbeJaS2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 14:28:19 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38876 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728223AbeJaS2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 14:28:17 -0400
Received: by mail-wr1-f68.google.com with SMTP id d10-v6so15647816wrs.5
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 02:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yyRbW79BND4C408UyY/nhuusJ4qXhHx099cfs+zi2aw=;
        b=U5IymNAlVU/1CSK7CG52MQsYlUiiiPA8uI8HRUj1dHQqWRGsOqUumdMI7ftoYNr+19
         XGs6zEbQ6BZ+BTmXu9ptiuNM6ckgaPw/t4ST5bi9g2TmcOONZRI1rg21WfpkP5K/yvQw
         SUrFhlNtrZFY9lTCBCxk6fNaTpP+oaPStEOfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yyRbW79BND4C408UyY/nhuusJ4qXhHx099cfs+zi2aw=;
        b=bbAQHemW1EDQ/NuuRKlifjUXDpEOXe/5nJfDJvHu6cyjmwrh7AUn3StyIpnfJjMQae
         soTguw7yXCh9mtyzfssU4avjibkFMMPgPlevc0ulRyL0J8VZS47PEyohUvW0mp0kuDBo
         sfa6N2Ckg79mDycNMktf5QVdqT3yqZg4VeFfuAPoQ+GLMQglqkUh61JHCYpoUQpFZssh
         Q4jqVChj2fVGUu56xQiDIRC8ldapE/xDXVpDvDo5NmnCf5T2WHo1RDfB1cwxLQtr/1ne
         Mdi/Tst0SvEyV+7EoRn6fz/TeMaxohvZWHZtf2gktcu42T4RxXr4MiPUShSBjwKIZVyY
         b8+A==
X-Gm-Message-State: AGRZ1gKs+8Nlh0l72KjdAuFm4/IZked/Ly263wTzJuROzCH2rsUZKyGk
        Hi667vK/ipTTR+dR6mhy5j1yCg==
X-Google-Smtp-Source: AJdET5erSSSmVSXvhBZi7XFgOEfgHcibX1jxkevUGUm9LD9cQ0Bm5dtW9d2Zy1dR8e94tQx1DeTJZA==
X-Received: by 2002:adf:ff05:: with SMTP id k5-v6mr1959110wrr.73.1540978256559;
        Wed, 31 Oct 2018 02:30:56 -0700 (PDT)
Received: from lmecxl0911.lme.st.com ([2a04:cec0:1086:999:fd1b:8629:a7fc:68b])
        by smtp.gmail.com with ESMTPSA id w14-v6sm10737377wrt.73.2018.10.31.02.30.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 31 Oct 2018 02:30:56 -0700 (PDT)
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
X-Google-Original-From: Benjamin Gaignard <benjamin.gaignard@st.com>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, alexandre.torgue@st.com
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH 4/5] ARM: dts: stm32: enable hwspinlock on stm32mp157c-ed1
Date:   Wed, 31 Oct 2018 10:30:31 +0100
Message-Id: <20181031093032.20386-5-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20181031093032.20386-1-benjamin.gaignard@st.com>
References: <20181031093032.20386-1-benjamin.gaignard@st.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable hwspinlock on stm32mp157c-ed1

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 arch/arm/boot/dts/stm32mp157c-ed1.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157c-ed1.dts b/arch/arm/boot/dts/stm32mp157c-ed1.dts
index f77bea49c079..158a337b3129 100644
--- a/arch/arm/boot/dts/stm32mp157c-ed1.dts
+++ b/arch/arm/boot/dts/stm32mp157c-ed1.dts
@@ -94,3 +94,7 @@
 	vdda1v1-supply = <&reg11>;
 	vdda1v8-supply = <&reg18>;
 };
+
+&hsem {
+	status = "okay";
+};
-- 
2.15.0

