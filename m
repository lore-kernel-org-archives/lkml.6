Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60C6C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C61C21534
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:00:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C61C21534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388212AbeIUBp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 21:45:28 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50597 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388109AbeIUBp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 21:45:27 -0400
Received: by mail-wm1-f68.google.com with SMTP id s12-v6so771480wmc.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 13:00:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Oup3WLppHI0eOzNCo9VZSilX4reqkH4apDwoiJWA2Ak=;
        b=qye7/QQVJSczPnocqKERWCXXWQje6lRg6KtSivTo+chSn23zC0I/91ZLbZXIf34MWL
         Kqc58jC65BLafAgCq/D2LCTDXA8aQ8WS4nFzuWV6j9dCM7xeyzZ74f9faXxfqcirLz8l
         TOFNtmEfSbvhKqGpqNdr/P5CC/o6g7wisb+Qs4E033udBfLvplaF339vw57ZgdwPea1J
         E5QexFSZisrY9vN8pV5Qro+NWzSK0EErnYeWA+ng8IOj8fKlQshbveW6wGPudu4Jn6wB
         WbGiWd39anWoj60lOS934atPW7WgZKS0rlqm8oRAC7yV3yJNpkF59j5gAc8aOAjT90l4
         AZAQ==
X-Gm-Message-State: APzg51Bc4QNbzosZXdNpEzIPzaopv6fYbZHjxCfp17Pvks813NRxC+gG
        57M2f54t8BBoVLY5pVxZgg2s
X-Google-Smtp-Source: ANB0Vdal4uNfMSK2xBnn1P8botOOkiHSv3xQHGCUzT5EQyaPpfPYcUUjFNlvBhErDMrRte79592TpA==
X-Received: by 2002:a1c:8f50:: with SMTP id r77-v6mr4304116wmd.44.1537473618107;
        Thu, 20 Sep 2018 13:00:18 -0700 (PDT)
Received: from localhost ([83.240.27.185])
        by smtp.gmail.com with ESMTPSA id k63-v6sm5804471wmd.46.2018.09.20.13.00.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Sep 2018 13:00:17 -0700 (PDT)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        atomlin@redhat.com
Subject: [PATCH v2] slub: extend slub debug to handle multiple slabs
Date:   Thu, 20 Sep 2018 21:00:16 +0100
Message-Id: <20180920200016.11003-1-atomlin@redhat.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend the slub_debug syntax to "slub_debug=<flags>[,<slub>]*", where <slub>
may contain an asterisk at the end.  For example, the following would poison
all kmalloc slabs:

	slub_debug=P,kmalloc*

and the following would apply the default flags to all kmalloc and all block IO
slabs:

	slub_debug=,bio*,kmalloc*

Please note that a similar patch was posted by Iliyan Malchev some time ago but
was never merged:

	https://marc.info/?l=linux-mm&m=131283905330474&w=2

Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
Changes from v1 [1]:

 - Add appropriate cast to address compiler warning

[1]: https://lore.kernel.org/lkml/20180910111358.10539-1-atomlin@redhat.com/
---
 Documentation/vm/slub.rst | 12 +++++++++---
 mm/slub.c                 | 34 +++++++++++++++++++++++++++++++---
 2 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/Documentation/vm/slub.rst b/Documentation/vm/slub.rst
index 3a775fd64e2d..195928808bac 100644
--- a/Documentation/vm/slub.rst
+++ b/Documentation/vm/slub.rst
@@ -36,9 +36,10 @@ debugging is enabled. Format:
 
 slub_debug=<Debug-Options>
 	Enable options for all slabs
-slub_debug=<Debug-Options>,<slab name>
-	Enable options only for select slabs
 
+slub_debug=<Debug-Options>,<slab name1>,<slab name2>,...
+	Enable options only for select slabs (no spaces
+	after a comma)
 
 Possible debug options are::
 
@@ -62,7 +63,12 @@ Trying to find an issue in the dentry cache? Try::
 
 	slub_debug=,dentry
 
-to only enable debugging on the dentry cache.
+to only enable debugging on the dentry cache.  You may use an asterisk at the
+end of the slab name, in order to cover all slabs with the same prefix.  For
+example, here's how you can poison the dentry cache as well as all kmalloc
+slabs:
+
+	slub_debug=P,kmalloc-*,dentry
 
 Red zoning and tracking may realign the slab.  We can just apply sanity checks
 to the dentry cache with::
diff --git a/mm/slub.c b/mm/slub.c
index 8da34a8af53d..d20901514075 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1283,9 +1283,37 @@ slab_flags_t kmem_cache_flags(unsigned int object_size,
 	/*
 	 * Enable debugging if selected on the kernel commandline.
 	 */
-	if (slub_debug && (!slub_debug_slabs || (name &&
-		!strncmp(slub_debug_slabs, name, strlen(slub_debug_slabs)))))
-		flags |= slub_debug;
+
+	char *end, *n, *glob;
+	int len = strlen(name);
+
+	/* If slub_debug = 0, it folds into the if conditional. */
+	if (!slub_debug_slabs)
+		return flags | slub_debug;
+
+	n = slub_debug_slabs;
+	while (*n) {
+		int cmplen;
+
+		end = strchr(n, ',');
+		if (!end)
+			end = n + strlen(n);
+
+		glob = strnchr(n, end - n, '*');
+		if (glob)
+			cmplen = glob - n;
+		else
+			cmplen = max(len, (int)(end - n));
+
+		if (!strncmp(name, n, cmplen)) {
+			flags |= slub_debug;
+			break;
+		}
+
+		if (!*end)
+			break;
+		n = end + 1;
+	}
 
 	return flags;
 }
-- 
2.14.4

