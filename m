Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6129C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6340F2152F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=globallogic.com header.i=@globallogic.com header.b="eZF3rdt9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6340F2152F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=globallogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbeI0XOp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 19:14:45 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38693 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727621AbeI0XOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 19:14:44 -0400
Received: by mail-lf1-f65.google.com with SMTP id g89-v6so2737759lfl.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 09:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=globallogic.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=jIQCx/pZEBHGO0iRLLbR8qjBss0/jgBaBqZvoVB58Rk=;
        b=eZF3rdt9TzMJKFMzx2gYgQzaSX93alAwGDPSyLWBgVEGOvC6v3r0LICFrlbPy7KIxX
         fCzpCPenxkGLuUc3I0R62jagvW7X1xj14NPS8VjqoMKq+14mRdupRFBKZo5nwNN+kOVx
         KxEDxvfFBjuf4pYH+bp91YvupVxJZR1cXhnas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jIQCx/pZEBHGO0iRLLbR8qjBss0/jgBaBqZvoVB58Rk=;
        b=PFd9g5B7RLHbyhgt5dip+4/k1FECOTGkOxaNmluj2NgISx573Xa6XwtRhlf74ciVpm
         fRg6gwTQreS2okpkQMtf5hLRsgJkLgWku+F1tW6B48QyXWadxaoFFv4xx84LTGLlbjIP
         /54oUBMatQF0sqGjTTunzDjsf0puc3liIGoIwhiwa4z2R02//+RvS8aBBqvzsEIDhtIP
         Nc2Qpn4N6XLHPkQEf4McozUU87xaOewAvh9bCDlJmRfmhH8fd9qJSC+CIud/ScHGlVIU
         tabnifFvrta0d2g+v4DEyQn2t35aK/iV4TpJEAD3Vlq7RldJqEVlyEWH4I8h9QlnlQmI
         XGVg==
X-Gm-Message-State: ABuFfoguXYcI+x4sXAjEuvOFjhgRwl59aSBuqLzAajdBUb60ivkPVzU3
        Dhu5UtKQ40bmqpVuJFqJy3b4qQ==
X-Google-Smtp-Source: ACcGV63XySk+RAQOdV73uAiYRcvDnr/Cy2IIJfvUdj/BQ0fHvpnoFwqulxl2lIewYR+eIpraRpVfsg==
X-Received: by 2002:a19:18e3:: with SMTP id 96-v6mr8385155lfy.133.1538067332961;
        Thu, 27 Sep 2018 09:55:32 -0700 (PDT)
Received: from kbp1-lhp-f55466.synapse.com ([195.238.92.77])
        by smtp.gmail.com with ESMTPSA id l3-v6sm507508lja.25.2018.09.27.09.55.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 27 Sep 2018 09:55:32 -0700 (PDT)
From:   Maksym Kokhan <maksym.kokhan@globallogic.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Daniel Walker <dwalker@fifo99.com>,
        Daniel Walker <danielwa@cisco.com>,
        Andrii Bordunov <aborduno@cisco.com>,
        Ruslan Bilovol <rbilovol@cisco.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] drivers: of: ifdef out cmdline section
Date:   Thu, 27 Sep 2018 19:55:27 +0300
Message-Id: <1538067327-5785-1-git-send-email-maksym.kokhan@globallogic.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Walker <danielwa@cisco.com>

It looks like there's some seepage of cmdline stuff into
the generic device tree code. This conflicts with the
generic cmdline implementation so I remove it in the case
when that's enabled.

Cc: Daniel Walker <dwalker@fifo99.com>
Cc: Daniel Walker <danielwa@cisco.com>
Signed-off-by: Daniel Walker <danielwa@cisco.com>
Signed-off-by: Maksym Kokhan <maksym.kokhan@globallogic.com>
---
 drivers/of/fdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 800ad25..74b85ad 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -1096,7 +1096,7 @@ int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
 	 * managed to set the command line, unless CONFIG_CMDLINE_FORCE
 	 * is set in which case we override whatever was found earlier.
 	 */
-#ifdef CONFIG_CMDLINE
+#if defined(CONFIG_CMDLINE) && !defined(CONFIG_GENERIC_CMDLINE)
 #if defined(CONFIG_CMDLINE_EXTEND)
 	strlcat(data, " ", COMMAND_LINE_SIZE);
 	strlcat(data, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
-- 
2.7.4

