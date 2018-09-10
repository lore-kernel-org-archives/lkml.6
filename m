Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B82DC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 11:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBDB72087E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 11:14:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBDB72087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbeIJQHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 12:07:34 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42696 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727269AbeIJQHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 12:07:34 -0400
Received: by mail-wr1-f66.google.com with SMTP id v17-v6so21453466wrr.9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 04:14:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EYAQdtxHzyQ1fOCC4d4SQvvWfhFo4NZ+BMXE6b0Dk0s=;
        b=uDM8u6wRYW0JSan1eXIEAtYHulCg25ssb3OoEzkmsRKScOdTZ71DpYLIeAQpnYHcPM
         544gwCIpKEoZG4oOIBXC634d3oUIFhvlbBZdDD2xA7hk4H/7dvIbaDiy6HGobSWjco0a
         DfMOr9KNPhjRtCKTRJWEtp4UAS+K+DpaXl4h6Cw1D/FJEm4K9Tt6GIA1nWGwkjinJ3zG
         CGXQllu1TSTBjE7y9BYRA3+GHFGVAYtqVgrkTk7dDTne5KxOzNuvT3EjSWAQ4/drEaQe
         TZP8RGUB3WcSmu+tJ4qj3ejOQ/CLjLGvY1Y/I0XTnzITKtUOTRYAmoOZ65I3eIvU5G63
         u/KA==
X-Gm-Message-State: APzg51DTQ2IN2/2nZgXmfa5joDavDn1IV8at/4NNoZuBurD8IJTpKiWD
        EllO0hA1z9SLY/AVJlla7QXJ
X-Google-Smtp-Source: ANB0VdbIDHlqGhafSFyBwUsu0SZs5tEyZbr0586+CAMr1DxvIkY+ezf9IJa00voIR6ZN9NguHdmk5A==
X-Received: by 2002:adf:b456:: with SMTP id v22-v6mr13790478wrd.187.1536578040478;
        Mon, 10 Sep 2018 04:14:00 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust844.9-3.cable.virginm.net. [82.17.115.77])
        by smtp.gmail.com with ESMTPSA id 142-v6sm14861071wme.35.2018.09.10.04.13.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 04:13:59 -0700 (PDT)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        atomlin@redhat.com
Subject: [PATCH] slub: extend slub debug to handle multiple slabs
Date:   Mon, 10 Sep 2018 12:13:58 +0100
Message-Id: <20180910111358.10539-1-atomlin@redhat.com>
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
index 8da34a8af53d..27281867cbe0 100644
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
+			cmplen = max(len, end - n);
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

