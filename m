Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99114C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 17:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51F0D208D7
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 17:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UUeydfWe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51F0D208D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756363AbeFORGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 13:06:20 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:44855 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756341AbeFORGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 13:06:18 -0400
Received: by mail-pl0-f66.google.com with SMTP id z9-v6so5656751plk.11;
        Fri, 15 Jun 2018 10:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2NJCOgSTmBo/S/26rP7nZe4v0Cv4TXskvLFwGiuPfq0=;
        b=UUeydfWeHA1Lyfk1iYd+gympQymtsWJssZ1J6p7R5wUJqSaZB9pqT6J3M//Hc7HvEX
         +EWldFYq3L62hxvrjtKSULdiIxly1yxnj1/ySkkLsOLM+IwQIxSqOFD8q++GQRkTEyNC
         58FBAx7cKYGomvQEGR0L6qHumviMj9SD8fON4ST8f6qvS003/mNUXXtDR58efuWP0Vqg
         KSGO7GIEDYTiQ8gw8E6g3FjdU+PTe85VcAX1I5TajTYP1sSq8ra2DjsnlrEuRRTjOrMJ
         R3Y0UaY/oTUmyM8A8tTrn8Deqn7nlCRr+EcxaMf0DhqFJuSkLIm29a4oJbYGfHALWpru
         RgaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2NJCOgSTmBo/S/26rP7nZe4v0Cv4TXskvLFwGiuPfq0=;
        b=KMNXSw8sIOw7wylUaXqL/ETQ1pFEP/qpJHEvLbf/rzwjjUUIlCo/c3l0McbzrkkysH
         NQRmDk/s5st0RUtXp7eDVVUDHF4uLZ/PiwtV4O23N2rLx57qi6IQ1HAi4FmvnGnTS5fs
         IEs8wEzM+fnwXHVW/0vgXHG5TUszFLEVn41xguuGvIiON4812ARbLXbkeFbyka9pv4rv
         066SIPeiX7KSZNC5+O1JrIbiyE06url4qpJMEtZG0FB7g45vz/md+KAKwPccOSwtQYqh
         PYCHq1AwFWIU7Db1jGoiogk0twGwPvBr3xBES3vik9v7fIE2CS0Wg9QxpKDiDiCEOQ+0
         06VQ==
X-Gm-Message-State: APt69E0oyDYI5XTBMpwZe8Nod98U4u5kBi9CTGv/vaKwlI61/pJ2/g39
        v0raDXGilNeQpEdfKCm6OXM=
X-Google-Smtp-Source: ADUXVKKc95FCCVcSD90RUM2mtyshWDZS766gfGr1KufIOvXlw72ppivYcpvOpxIy9or4o4vxGuo2lQ==
X-Received: by 2002:a17:902:1127:: with SMTP id d36-v6mr2997700pla.267.1529082378453;
        Fri, 15 Jun 2018 10:06:18 -0700 (PDT)
Received: from localhost ([103.88.46.82])
        by smtp.gmail.com with ESMTPSA id c191-v6sm13260182pfg.48.2018.06.15.10.06.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 10:06:17 -0700 (PDT)
From:   Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] xen/scsiback: add error handling for xenbus_printf
Date:   Sat, 16 Jun 2018 01:06:12 +0800
Message-Id: <1529082372-59097-1-git-send-email-jiazhouyang09@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528775185-39467-1-git-send-email-jiazhouyang09@gmail.com>
References: <1528775185-39467-1-git-send-email-jiazhouyang09@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When xenbus_printf fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling xenbus_printf.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
---
v1->v2:
- Use xenbus_dev_error to report errors.
---
 drivers/xen/xen-scsiback.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/xen/xen-scsiback.c b/drivers/xen/xen-scsiback.c
index 7bc88fd..cec2133 100644
--- a/drivers/xen/xen-scsiback.c
+++ b/drivers/xen/xen-scsiback.c
@@ -1027,8 +1027,10 @@ static void scsiback_do_add_lun(struct vscsibk_info *info, const char *state,
 			scsiback_del_translation_entry(info, vir);
 		}
 	} else if (!try) {
-		xenbus_printf(XBT_NIL, info->dev->nodename, state,
-			      "%d", XenbusStateClosed);
+		if (xenbus_printf(XBT_NIL, info->dev->nodename, state,
+			      "%d", XenbusStateClosed))
+			xenbus_dev_error(info->dev, err,
+				"%s: writing %s", __func__, state);
 	}
 }
 
@@ -1067,8 +1069,10 @@ static void scsiback_do_1lun_hotplug(struct vscsibk_info *info, int op,
 	snprintf(str, sizeof(str), "vscsi-devs/%s/p-dev", ent);
 	val = xenbus_read(XBT_NIL, dev->nodename, str, NULL);
 	if (IS_ERR(val)) {
-		xenbus_printf(XBT_NIL, dev->nodename, state,
-			      "%d", XenbusStateClosed);
+		if (xenbus_printf(XBT_NIL, dev->nodename, state,
+			      "%d", XenbusStateClosed))
+			xenbus_dev_error(info->dev, err,
+				"%s: writing %s", __func__, state);
 		return;
 	}
 	strlcpy(phy, val, VSCSI_NAMELEN);
@@ -1079,8 +1083,10 @@ static void scsiback_do_1lun_hotplug(struct vscsibk_info *info, int op,
 	err = xenbus_scanf(XBT_NIL, dev->nodename, str, "%u:%u:%u:%u",
 			   &vir.hst, &vir.chn, &vir.tgt, &vir.lun);
 	if (XENBUS_EXIST_ERR(err)) {
-		xenbus_printf(XBT_NIL, dev->nodename, state,
-			      "%d", XenbusStateClosed);
+		if (xenbus_printf(XBT_NIL, dev->nodename, state,
+			      "%d", XenbusStateClosed))
+			xenbus_dev_error(info->dev, err,
+				"%s: writing %s", __func__, state);
 		return;
 	}
 
-- 
2.7.4

