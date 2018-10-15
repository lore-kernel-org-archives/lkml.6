Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F5D7C7112B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 00:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25D5D2087D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 00:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FoSppvLU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25D5D2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbeJOIJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 04:09:07 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35807 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbeJOIJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 04:09:05 -0400
Received: by mail-pf1-f195.google.com with SMTP id l17-v6so8768357pff.2;
        Sun, 14 Oct 2018 17:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PMEoU3Gz26JMyroIsJaDweM2uFKnZxU+TruAPOzAvDQ=;
        b=FoSppvLUNXKwT2xa/fbQw7RLd1Q/dfkrbveBbCpBA/i034kCFgJHV06NKyQIJv7VNo
         Jj9/VMVgt2aesbhYwPrzfr7e4cF2QT0I0j2AtCuoaSgLnAGq/NJoaqZ5wXg0XRZ4iKro
         sqbiQ52A2j11jcMMaYK593iSmBisDlHgNjKabMECdwD+VUsTmAG8CUNnCxDj5NfQZjoM
         guQ2u3I5hSh1eUhkanjBJ3uVByBvHLLtbkBAzCTaTfhURzJ9V2BXY8mbTaPq34dvK+gj
         zL0EpmCo7LR4D359gOqlWjIby1UMJNW+K4AZzob//b2I9FWlUIk5VfeT/n7mTxqUV6bV
         orug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PMEoU3Gz26JMyroIsJaDweM2uFKnZxU+TruAPOzAvDQ=;
        b=JfnN5yhavzXBYMLB9kyy7BCdS0uj7oDk8jdwNnJkyNTujpQscNUhT9NNTlbOQ5ig/X
         W5Ph5KRdL6z9+XU1FpKMDpmbDADDhA+u4qgdPIk+r6VZAKTqQyQsBtB1g7zBArrIT7fS
         38Helurx80yT9MF8PiH66n3x/1aqI4dldkB1lONP1h5uP5sTI03uBfNVInW0i0ChGmtL
         tHs1WBydqFrlDlmcjiDvFzKtRJsWEDtCgTXIWLm4kNk/O/NCdSl4GeNSJOLYX8bb3ZYo
         esCJxRlbkohORfBp4UD3tJfmX8pHfHuH6Ar652E0gM5U3qhmSHx74OpNdd22vYQLBCTi
         B0KQ==
X-Gm-Message-State: ABuFfoius/BiIKh0dciWxJ+PWla3CJqT++iZXw52gLU85jMRnzY4E+MG
        pQYX3FctgZs9HSQIDGWj9KQ=
X-Google-Smtp-Source: ACcGV61mcTj1VHj1Xm2Jp29axakqI/Ib5fkIEivegpv+3y4RdMrCOAZHVnbgSyEAufJoAyLnEzrWyQ==
X-Received: by 2002:a63:2066:: with SMTP id r38-v6mr13951559pgm.289.1539563177544;
        Sun, 14 Oct 2018 17:26:17 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id j14-v6sm11387110pgh.52.2018.10.14.17.26.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 14 Oct 2018 17:26:17 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH v3 14/18] of: unittest: remove unused of_unittest_apply_overlay() argument
Date:   Sun, 14 Oct 2018 17:24:26 -0700
Message-Id: <1539563070-12969-15-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539563070-12969-1-git-send-email-frowand.list@gmail.com>
References: <1539563070-12969-1-git-send-email-frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

Argument unittest_nr is not used in of_unittest_apply_overlay(),
remove it.

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 drivers/of/unittest.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index efd9c947f192..6d80f474c8f2 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -1419,8 +1419,7 @@ static void of_unittest_destroy_tracked_overlays(void)
 	} while (defers > 0);
 }
 
-static int __init of_unittest_apply_overlay(int overlay_nr, int unittest_nr,
-		int *overlay_id)
+static int __init of_unittest_apply_overlay(int overlay_nr, int *overlay_id)
 {
 	const char *overlay_name;
 
@@ -1453,7 +1452,7 @@ static int __init of_unittest_apply_overlay_check(int overlay_nr,
 	}
 
 	ovcs_id = 0;
-	ret = of_unittest_apply_overlay(overlay_nr, unittest_nr, &ovcs_id);
+	ret = of_unittest_apply_overlay(overlay_nr, &ovcs_id);
 	if (ret != 0) {
 		/* of_unittest_apply_overlay already called unittest() */
 		return ret;
@@ -1489,7 +1488,7 @@ static int __init of_unittest_apply_revert_overlay_check(int overlay_nr,
 
 	/* apply the overlay */
 	ovcs_id = 0;
-	ret = of_unittest_apply_overlay(overlay_nr, unittest_nr, &ovcs_id);
+	ret = of_unittest_apply_overlay(overlay_nr, &ovcs_id);
 	if (ret != 0) {
 		/* of_unittest_apply_overlay already called unittest() */
 		return ret;
-- 
Frank Rowand <frank.rowand@sony.com>

