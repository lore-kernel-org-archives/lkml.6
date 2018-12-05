Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B67EC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A85F208E7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544039503;
	bh=sKoFktAAzxuIYi7hs2T7fMQmIGYgXPVWp2CYJYqjf7A=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=dDKsiUQt/bWQY0BQgo5yKi+/IJg1a3izh4A9qfb52Jrrp1fLSbq29gwE/ZtHs6d78
	 8+kf81atU7UClwAddA4o62G62F84Biw8zoB/kVNFyYgUBvreyzYNhEJxKn4d98Phna
	 KA5l34MnK+k0N2e9Ed4tzgRzAGiFwDGI3Uh/hfjQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A85F208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbeLETvl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 14:51:41 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36365 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728871AbeLETva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 14:51:30 -0500
Received: by mail-ot1-f66.google.com with SMTP id k98so19828844otk.3;
        Wed, 05 Dec 2018 11:51:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qctK2c2J3l+tBzpOg1oUnoGeCH3cH1/L4PcrunO1KLU=;
        b=GT4oyBxAmZTehgkEiNV/7U1+glJe092cnQncOzxaCb1nQCrpdJSVlaBKVO/itHqzmV
         8J90f/F4M5eGkQDQyaEuy2aJfviMJ119aFyJ5CR6S7pufF9M6s2vJ1B6QhlNcc0XtTc1
         sBAUmVzCLTqs7fZYyS0/QGnQEewqBtTUildnlt4xxhKB3yQSj69QRWuflOZrBitShxtF
         t1YPNDaSh8PVeSbbK2gceg62Xvdzf+VKRYGenXlpLRCNh4Vlon/rn1R6X6A8DsJXZTbQ
         55VJ8LDFAv9R/pc9yazpRBFiX3YBjBAr+dKKJGV2JyH4DBWtrFWpVRqtKfO69i8nHZAh
         ihEw==
X-Gm-Message-State: AA+aEWbtcyGgS4jmkS6LuLs0tTv+iF55OCPnz7SqOJPnKKqygg6/GtWV
        5cYMu0brEiqNi8U39cj68OX14yNnOg==
X-Google-Smtp-Source: AFSGD/XEunTCNxwJ7ZaoCxnPQQsLCOY0gMVg7PKStnA23jdS3FZI8iGSRFUk95tHVp+E03CMk+WeSw==
X-Received: by 2002:a9d:77d4:: with SMTP id w20mr15762782otl.196.1544039489380;
        Wed, 05 Dec 2018 11:51:29 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id k13sm25759879otj.19.2018.12.05.11.51.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 11:51:28 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] coresight: Use of_node_name_eq for node name comparisons
Date:   Wed,  5 Dec 2018 13:50:50 -0600
Message-Id: <20181205195050.4759-34-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert string compares of DT node names to use of_node_name_eq helper
instead. This removes direct access to the node name pointer.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/hwtracing/coresight/of_coresight.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing/coresight/of_coresight.c
index 89092f83567e..7045930fc958 100644
--- a/drivers/hwtracing/coresight/of_coresight.c
+++ b/drivers/hwtracing/coresight/of_coresight.c
@@ -80,8 +80,8 @@ static struct device_node *of_coresight_get_port_parent(struct device_node *ep)
 	 * Skip one-level up to the real device node, if we
 	 * are using the new bindings.
 	 */
-	if (!of_node_cmp(parent->name, "in-ports") ||
-	    !of_node_cmp(parent->name, "out-ports"))
+	if (of_node_name_eq(parent, "in-ports") ||
+	    of_node_name_eq(parent, "out-ports"))
 		parent = of_get_next_parent(parent);
 
 	return parent;
-- 
2.19.1

