Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF630ECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 10:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 786182150E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 10:08:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 786182150E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731260AbeISPpy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 11:45:54 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44914 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731157AbeISPpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 11:45:52 -0400
Received: by mail-wr1-f65.google.com with SMTP id v16-v6so5138616wro.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 03:08:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nPK6uXZN7cckrZujWIB4/aDojr48F0Bx+xBF9fcQrF4=;
        b=h/VzMhQVK1CGE5SJj0nYVEDOYesVY+XnZ9t9urklxIyjVy3uA1CVojFtZOEFbCLOxG
         4i7jYqGg+gISiu7FqAoBOTW33Htee/srcd69JduVnHNUH77gwC2SsDfoez3dh3trCf63
         hK6iHrNhrXXO1l7r9XRFUWhau4kRXnhFIZGSOEE2tGS6JRCQhWtXljdQpJ4ZiHdOW0yF
         ml96lL5Jbk0kknhhBsxLzP5Iq2LoSolTdahuCP0KJq7ypB4B/RZDhmP7e/bNgYPAh4af
         1AnJa73D5JN1/ZgW5ryMl1yp/WDNQexyu1fR027O7ytCMD9nN0hgaGQUWa20QOQBfUOu
         Jc/g==
X-Gm-Message-State: APzg51BE1OFrwXdZu69E2GWcdklVfOg+nIa4sEqOKC5HZXz2GDLJcja+
        fb/TyJlqI+X2hLt+Ylnxwwg=
X-Google-Smtp-Source: ANB0VdYALQtAORNJdn6aMvxSVqH7BWIqAeiJ5ZgblOChmk/IZbwXHg1zQie6pixLaKS/+9PJwHGCww==
X-Received: by 2002:a5d:68c9:: with SMTP id p9-v6mr27824256wrw.108.1537351720351;
        Wed, 19 Sep 2018 03:08:40 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id d18-v6sm2982148wmb.33.2018.09.19.03.08.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 03:08:39 -0700 (PDT)
Received: from d104.suse.de (charybdis-ext.suse.de [195.135.221.2])
        by techadventures.net (Postfix) with ESMTPA id 2ED381253C4;
        Wed, 19 Sep 2018 12:08:38 +0200 (CEST)
From:   Oscar Salvador <osalvador@techadventures.net>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, dan.j.williams@intel.com, david@redhat.com,
        Pavel.Tatashin@microsoft.com, Jonathan.Cameron@huawei.com,
        yasu.isimatu@gmail.com, malat@debian.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH 3/5] mm/memory_hotplug: Tidy up node_states_clear_node
Date:   Wed, 19 Sep 2018 12:08:17 +0200
Message-Id: <20180919100819.25518-4-osalvador@techadventures.net>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180919100819.25518-1-osalvador@techadventures.net>
References: <20180919100819.25518-1-osalvador@techadventures.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oscar Salvador <osalvador@suse.de>

node_states_clear has the following if statements:

if ((N_MEMORY != N_NORMAL_MEMORY) &&
    (arg->status_change_nid_high >= 0))
        ...

if ((N_MEMORY != N_HIGH_MEMORY) &&
    (arg->status_change_nid >= 0))
        ...

N_MEMORY can never be equal to neither N_NORMAL_MEMORY nor
N_HIGH_MEMORY.

Similar problem was found in [1].
Since this is wrong, let us get rid of it.

[1] https://patchwork.kernel.org/patch/10579155/

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/memory_hotplug.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index c2c7359bd0a7..131c08106d54 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1590,12 +1590,10 @@ static void node_states_clear_node(int node, struct memory_notify *arg)
 	if (arg->status_change_nid_normal >= 0)
 		node_clear_state(node, N_NORMAL_MEMORY);
 
-	if ((N_MEMORY != N_NORMAL_MEMORY) &&
-	    (arg->status_change_nid_high >= 0))
+	if (arg->status_change_nid_high >= 0)
 		node_clear_state(node, N_HIGH_MEMORY);
 
-	if ((N_MEMORY != N_HIGH_MEMORY) &&
-	    (arg->status_change_nid >= 0))
+	if (arg->status_change_nid >= 0)
 		node_clear_state(node, N_MEMORY);
 }
 
-- 
2.13.6

