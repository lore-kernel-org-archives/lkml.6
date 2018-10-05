Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E5BC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 14:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 410312087D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 14:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="aY68IE/t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 410312087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728996AbeJEV1c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 17:27:32 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39522 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728619AbeJEV1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 17:27:32 -0400
Received: by mail-lj1-f193.google.com with SMTP id p1-v6so7930920ljg.6
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 07:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7OhOQ0BJr6/wxLqmkOt/gvB4oHxM8aG4AcnNV/6M1/o=;
        b=aY68IE/tTEgMjRn6kMnSZV7VxHxg7T2SfbmFOivduQYZnqJtn8YbTtBvxwT7MMk64x
         wqylQuwuEDVw4GnLV9jenUGD0L4EQtxtTcfrSkmAKf+q/2LsbELHKVJhveQjQE2afOq/
         cUwwJCnJjr5GWR9Ipw6t4jlg2NQ5XNvEFHlt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7OhOQ0BJr6/wxLqmkOt/gvB4oHxM8aG4AcnNV/6M1/o=;
        b=fbd7FELmClNEHbD47cB074aSVmWAYn8TKywKbBisWQZdTB7lFV+jB15hN+MrQTYRqy
         ilPFSp8kF27bBQgVFGpXL4Y+gfqetOgH7yS5uNcUv3WwQaxY+IsHHCZSwZ6rJK4uoAFK
         IUeKsufDcYJZEKbBx7uP+SkwhaSaGw+VUHNr8pk3xXUFux8nXPvcZERGcM4DKVaG4wBC
         mL0vXQxOKneXJuugvDxpZl9nWpRrPA7+bByG3JTglixpz+Kcx+5rkvTzXQZ16BEkmtDq
         +6xiMQOEKy6FyHaFurZZheBHUghr6+rCbN3dn2AovFRvHvUkfIxo9rOks8Fv8Nl/noM+
         RXxw==
X-Gm-Message-State: ABuFfog5fsiFHJUMdWDGrpau/aLXR0D4iunzAf35tlEd/I3rLbFx4bFX
        Ax3R9HOCdN0GEOmQ7S6kO96lOg==
X-Google-Smtp-Source: ACcGV62OxsCoa37ppZcx8aH+AJjNa9Zm7t5pmIeW/9nvOKgq8fKB/1HNRUWppcMsozjG04NYFwMwPw==
X-Received: by 2002:a2e:5109:: with SMTP id f9-v6mr7487097ljb.155.1538749712530;
        Fri, 05 Oct 2018 07:28:32 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id g68-v6sm1888287lje.44.2018.10.05.07.28.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 Oct 2018 07:28:32 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     "Bryan O'Donoghue" <pure.logic@nexus-software.ie>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] staging: greybus: loopback.c: simplify prototype of gb_loopback_bus_id_compare
Date:   Fri,  5 Oct 2018 16:28:26 +0200
Message-Id: <20181005142826.26108-3-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181005142826.26108-1-linux@rasmusvillemoes.dk>
References: <20181005142826.26108-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gb_loopback_bus_id_compare only has a single caller, and it no longer
needs to have a prototype compatible with being a callback for
list_sort.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/staging/greybus/loopback.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/greybus/loopback.c b/drivers/staging/greybus/loopback.c
index 89c3f6fd8ddf..2c7bad66bb31 100644
--- a/drivers/staging/greybus/loopback.c
+++ b/drivers/staging/greybus/loopback.c
@@ -987,11 +987,8 @@ static const struct file_operations gb_loopback_debugfs_latency_ops = {
 	.release	= single_release,
 };
 
-static int gb_loopback_bus_id_compare(void *priv, struct list_head *lha,
-				      struct list_head *lhb)
+static int gb_loopback_bus_id_compare(struct gb_loopback *a, struct gb_loopback *b)
 {
-	struct gb_loopback *a = list_entry(lha, struct gb_loopback, entry);
-	struct gb_loopback *b = list_entry(lhb, struct gb_loopback, entry);
 	struct gb_connection *ca = a->connection;
 	struct gb_connection *cb = b->connection;
 
@@ -1022,7 +1019,7 @@ static void gb_loopback_insert_id(struct gb_loopback *gb)
 	 * and we thus insert at the end.
 	 */
 	list_for_each_entry(gb_list, &gb_dev.list, entry) {
-		if (gb_loopback_bus_id_compare(NULL, &gb->entry, &gb_list->entry) < 0)
+		if (gb_loopback_bus_id_compare(gb, gb_list) < 0)
 			break;
 	}
 	list_add_tail(&gb->entry, &gb_list->entry);
-- 
2.19.0

