Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B408AC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 11:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75BE521754
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 11:11:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75BE521754
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729404AbeI1Re7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 13:34:59 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43532 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729089AbeI1Re6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 13:34:58 -0400
Received: by mail-wr1-f66.google.com with SMTP id z14-v6so5924231wrs.10
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 04:11:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DdMrOd1vGJXpR1H0Nxrj5UIVTrQm0seXiPTs+tYZ0+4=;
        b=aOljlyFSb+1i/R3OxCkSB6W5IXVabQt/wAxW9VHXKN3GRB/UKRcTTvkuejGB6u9eSu
         N0nm+pcjs4a0p/4whswCsLlJ14pQkVd3ii4lFIACRsgSe01P2lGevvu41oIDdNmS1BNo
         3jZMSdwXrq7JHYONUOZipF1JaUv4LwHHGO4n0VNhjc6mzcKinRCRLY8Ev3Xmn3Xs//jY
         W4pAvi7qXgkKfk4d9iGjIdBEHVOmt8SZMnBpGU9WUH8iuvWf5bSJpAoeFk+54LvWoEFO
         3FhWtmnQ7xaGkXxESh2W0vUrvVqDc7Q0bMPGdRethPLSl70IfJW13VsHrGZOz6WBr+Nq
         ZuNQ==
X-Gm-Message-State: ABuFfohlzg2+nADxymunMEtTW4ziy97u2EXv0KzBqZymUE+eVUzl/zYh
        CqgS604A43h4z1aJK6KVPnia
X-Google-Smtp-Source: ACcGV62KGLScxRNlK/MigV8hYuMKL0E90A3soBuFbXrsOXMCzWcJ/eUPmMe+KproZlOm4ziPVSEqOg==
X-Received: by 2002:adf:e882:: with SMTP id d2-v6mr11549768wrm.43.1538133101468;
        Fri, 28 Sep 2018 04:11:41 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust844.9-3.cable.virginm.net. [82.17.115.77])
        by smtp.gmail.com with ESMTPSA id u185-v6sm1667615wmf.9.2018.09.28.04.11.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Sep 2018 04:11:40 -0700 (PDT)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        atomlin@redhat.com, malchev@google.com
Subject: [PATCH v3] slub: extend slub debug to handle multiple slabs
Date:   Fri, 28 Sep 2018 12:11:39 +0100
Message-Id: <20180928111139.27962-1-atomlin@redhat.com>
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
Changes from v2 [2]:

 - Add a function and kernel-doc comment
 - Refactor code
 - Use the appropriate helper function max_t()

Changes from v1 [1]:

 - Add appropriate cast to address compiler warning

[1]: https://marc.info/?l=linux-kernel&m=153657804506284&w=2
[2]: https://marc.info/?l=linux-kernel&m=153747362316965&w=2
---
 Documentation/vm/slub.rst | 12 +++++++++---
 mm/slub.c                 | 50 +++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 53 insertions(+), 9 deletions(-)

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
index 8da34a8af53d..7927f971df0d 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1276,16 +1276,54 @@ static int __init setup_slub_debug(char *str)
 
 __setup("slub_debug", setup_slub_debug);
 
+/*
+ * kmem_cache_flags - apply debugging options to the cache
+ * @object_size:	the size of an object without meta data
+ * @flags:		flags to set
+ * @name:		name of the cache
+ * @ctor:		constructor function
+ *
+ * Debug option(s) are applied to @flags. In addition to the debug
+ * option(s), if a slab name (or multiple) is specified i.e.
+ * slub_debug=<Debug-Options>,<slab name1>,<slab name2> ...
+ * then only the select slabs will receive the debug option(s).
+ */
 slab_flags_t kmem_cache_flags(unsigned int object_size,
 	slab_flags_t flags, const char *name,
 	void (*ctor)(void *))
 {
-	/*
-	 * Enable debugging if selected on the kernel commandline.
-	 */
-	if (slub_debug && (!slub_debug_slabs || (name &&
-		!strncmp(slub_debug_slabs, name, strlen(slub_debug_slabs)))))
-		flags |= slub_debug;
+	char *iter;
+	size_t len;
+
+	/* If slub_debug = 0, it folds into the if conditional. */
+	if (!slub_debug_slabs)
+		return flags | slub_debug;
+
+	len = strlen(name);
+	iter = slub_debug_slabs;
+	while (*iter) {
+		char *end, *glob;
+		size_t cmplen;
+
+		end = strchr(iter, ',');
+		if (!end)
+			end = iter + strlen(iter);
+
+		glob = strnchr(iter, end - iter, '*');
+		if (glob)
+			cmplen = glob - iter;
+		else
+			cmplen = max_t(size_t, len, (end - iter));
+
+		if (!strncmp(name, iter, cmplen)) {
+			flags |= slub_debug;
+			break;
+		}
+
+		if (!*end)
+			break;
+		iter = end + 1;
+	}
 
 	return flags;
 }
-- 
2.14.4

