Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8316C65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 14:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FABE213A2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 14:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="bP0No+jG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FABE213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbeJEV1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 17:27:31 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43957 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728833AbeJEV1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 17:27:30 -0400
Received: by mail-lf1-f66.google.com with SMTP id p34-v6so9494658lfg.10
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 07:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nbRSiuLMibAF6HSYonKPs8GWUSZ1N/Bmm+T9AyZXkys=;
        b=bP0No+jG+ShgAYtvvjCSKrHyeT3M77mzzDKWIQ2s6NPPmwUZBrZp6dIxM6TMV2jRtq
         AmyECT5lTUDaLAcj4N1ouln0grxpBVeE2aHB6wYLec9L23c/nbqU1rPdK9PQw7+ejbC8
         uqnmPheMROPVjKU+ij7q25HKaOw8Lz8m80GBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nbRSiuLMibAF6HSYonKPs8GWUSZ1N/Bmm+T9AyZXkys=;
        b=Gk7nf7zAPS7nQiX16FABS0ZPItSkDVA4TfBY5Abu4waK06Y2k8LROH63rXyHyAupW3
         rIS2DbRXgrH6I+Xx9F1aT30G9tef1Fj3ZGc94Qba0/iGnIi1a6OtUlonNFuPkunuN8lx
         AoQgAlnBPuBe6jyF1vcs8giHeMjDq/2gC1j24gRWtc9aPpXUGsF2x7D3zqkkPUSEGVLK
         ItfpYNK665KA0mud5XIO87UD/bn8AzhzFWh9CIL5brN3aoLmvD35PU7Fo6Bi7vLalED5
         z9XJy6YWYXqyk93b6GY0CGnNs1xo2kAZLOr/U6VI9DZ2h4runeRIOPWQX8iASGHOMy06
         +dPQ==
X-Gm-Message-State: ABuFfoi+AVl/J2AkFPOTFHDRBSOUe+lW2kz6vMtE6hFXP0ugSNympK0G
        LGeMfPhg96OtsBBV6ofZ2bUEPg==
X-Google-Smtp-Source: ACcGV60mb7pecqqFA+m6jPRJ/x1Uos0BKuUcXYOPjV/64EyPjPNNc2Jr6tuxBKzLHL1NqGb3KWZJMw==
X-Received: by 2002:a19:d7d6:: with SMTP id q83-v6mr6703897lfi.27.1538749711343;
        Fri, 05 Oct 2018 07:28:31 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id g68-v6sm1888287lje.44.2018.10.05.07.28.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 Oct 2018 07:28:30 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     "Bryan O'Donoghue" <pure.logic@nexus-software.ie>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] staging: greybus: loopback.c: do insertion in O(n) instead of O(n lg n)
Date:   Fri,  5 Oct 2018 16:28:25 +0200
Message-Id: <20181005142826.26108-2-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181005142826.26108-1-linux@rasmusvillemoes.dk>
References: <20181005142826.26108-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Append to the list and do a merge sort" is not really an insertion
sort. While a few more lines of code, we can keep the list sorted doing
at most n comparisons by iterating until we find the first element
strictly greater than gb.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
I have no idea if the performance matters (it probably doesn't). Feel
free to ignore this and the followup cleanup.

 drivers/staging/greybus/loopback.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/greybus/loopback.c b/drivers/staging/greybus/loopback.c
index 7080294f705c..89c3f6fd8ddf 100644
--- a/drivers/staging/greybus/loopback.c
+++ b/drivers/staging/greybus/loopback.c
@@ -1013,9 +1013,19 @@ static int gb_loopback_bus_id_compare(void *priv, struct list_head *lha,
 
 static void gb_loopback_insert_id(struct gb_loopback *gb)
 {
-	/* perform an insertion sort */
-	list_add_tail(&gb->entry, &gb_dev.list);
-	list_sort(NULL, &gb_dev.list, gb_loopback_bus_id_compare);
+	struct gb_loopback *gb_list;
+
+	/*
+	 * Keep the list sorted. Insert gb before the first element it
+	 * compares strictly less than. If no such element exists, the
+	 * loop terminates with &gb_list->entry being &gb_dev.list,
+	 * and we thus insert at the end.
+	 */
+	list_for_each_entry(gb_list, &gb_dev.list, entry) {
+		if (gb_loopback_bus_id_compare(NULL, &gb->entry, &gb_list->entry) < 0)
+			break;
+	}
+	list_add_tail(&gb->entry, &gb_list->entry);
 }
 
 #define DEBUGFS_NAMELEN 32
-- 
2.19.0

