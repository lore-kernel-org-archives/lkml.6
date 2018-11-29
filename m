Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E94C43610
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DCF2214C4
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ed4exNI8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DCF2214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732040AbeK3Beq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:34:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:36180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387426AbeK3Bep (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:34:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92E4F2147C;
        Thu, 29 Nov 2018 14:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501753;
        bh=ntKb6vJB37wP9tnimWLC3pOUhQD7Fjsk3JydZehm1Zo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ed4exNI8aadyoJMBXHZdjQl9rlVO7gpBf07Wa2AHhB/qlfvD16jLKQuFubF+fPdrq
         FQstGQYvutSPAluY519W8FRrRvnD+lbkqhOllkyStXl0ydDiLbnracVTh0FMc7OA0w
         2o0W4TTMtaHh2anRPNj6r2JSkafXMS3GY19d4T/k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Keerthy <j-keerthy@ti.com>,
        Dave Gerlach <d-gerlach@ti.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 4.19 027/110] opp: ti-opp-supply: Dynamically update u_volt_min
Date:   Thu, 29 Nov 2018 15:11:58 +0100
Message-Id: <20181129135922.358073617@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129135921.231283053@linuxfoundation.org>
References: <20181129135921.231283053@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Keerthy <j-keerthy@ti.com>

commit ba038546ff9e15d54d1134b5c5d2355648c00dec upstream.

The voltage range (min, max) provided in the device tree is from
the data manual and is pretty big, catering to a wide range of devices.
On a i2c read/write failure the regulator_set_voltage_triplet function
falls back to set voltage between min and max. The min value from Device
Tree can be lesser than the optimal value and in that case that can lead
to a hang or crash. Hence set the u_volt_min dynamically to the optimal
voltage value.

Cc: 4.16+ <stable@vger.kernel.org> # v4.16+
Fixes: 9a835fa6e47 ("PM / OPP: Add ti-opp-supply driver")
Signed-off-by: Keerthy <j-keerthy@ti.com>
Acked-by: Dave Gerlach <d-gerlach@ti.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/opp/ti-opp-supply.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/opp/ti-opp-supply.c
+++ b/drivers/opp/ti-opp-supply.c
@@ -290,6 +290,9 @@ static int ti_opp_supply_set_opp(struct
 	vdd_uv = _get_optimal_vdd_voltage(dev, &opp_data,
 					  new_supply_vbb->u_volt);
 
+	if (new_supply_vdd->u_volt_min < vdd_uv)
+		new_supply_vdd->u_volt_min = vdd_uv;
+
 	/* Scaling up? Scale voltage before frequency */
 	if (freq > old_freq) {
 		ret = _opp_set_voltage(dev, new_supply_vdd, vdd_uv, vdd_reg,


