Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C700C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF4902145D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tFKejJKz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF4902145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388374AbeK3Bes (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:34:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:36262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388359AbeK3Ber (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:34:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1B722147D;
        Thu, 29 Nov 2018 14:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501755;
        bh=cF/oUZ+Jv84CMP+AcHiaA2HWHZozeefzKuHRP3+lC8k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tFKejJKz8zc062i7KDXkqXedCXoW+okTmvVdltu/kUT9pI8ab9QD1q3vxAxcI2fWJ
         Ih9AT/3VsWC8+d2vFAaclM/B74ewZFqL1Yo2bJvg6m1nffBNpVshi/QB5R1cCJYj+F
         pxuNxtTMSLSMtgx0YutA7KsnSQRru0Sod6FDAaT8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Keerthy <j-keerthy@ti.com>,
        Dave Gerlach <d-gerlach@ti.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 4.19 028/110] opp: ti-opp-supply: Correct the supply in _get_optimal_vdd_voltage call
Date:   Thu, 29 Nov 2018 15:11:59 +0100
Message-Id: <20181129135922.399592981@linuxfoundation.org>
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

commit 622fecbccfe86a8052dea6b512d3821dcce29994 upstream.

_get_optimal_vdd_voltage call provides new_supply_vbb->u_volt
as the reference voltage while it should be really new_supply_vdd->u_volt.

Cc: 4.16+ <stable@vger.kernel.org> # v4.16+
Fixes: 9a835fa6e47 ("PM / OPP: Add ti-opp-supply driver")
Signed-off-by: Keerthy <j-keerthy@ti.com>
Acked-by: Dave Gerlach <d-gerlach@ti.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/opp/ti-opp-supply.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/opp/ti-opp-supply.c
+++ b/drivers/opp/ti-opp-supply.c
@@ -288,7 +288,7 @@ static int ti_opp_supply_set_opp(struct
 	int ret;
 
 	vdd_uv = _get_optimal_vdd_voltage(dev, &opp_data,
-					  new_supply_vbb->u_volt);
+					  new_supply_vdd->u_volt);
 
 	if (new_supply_vdd->u_volt_min < vdd_uv)
 		new_supply_vdd->u_volt_min = vdd_uv;


