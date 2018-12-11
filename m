Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14438C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD3602081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544538477;
	bh=xrgY7C0MMv5zPaByTxrMxL7lI/DnfAozW0KFZXghPeA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CPkyDpTZi/7XdWdpgA2MLdJQDJ4JkYtwJJvGeNeetLypfB1bSD1wcfYPLKJcK9rp6
	 oaoMK3NDCDB0zZ4VdsOiW3IrqHq3l9TRoyvzFKxlO86J7rF0ymcCf4n0yW0DSWlvhy
	 BLoyaGKEGMa2agMCrXz+7oblUc5NYh2fwR1fthXY=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD3602081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbeLKO14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 09:27:56 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45516 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbeLKO1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 09:27:54 -0500
Received: by mail-ed1-f68.google.com with SMTP id d39so12639312edb.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 06:27:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Iw/C/mJloVWnnEeI9hr/rFUfYtnu/dchJcsf1iUtKds=;
        b=JF+eQD8DgFl54saMVW+1nBv8TjlxCQE0bVkgviugDVwhasCaEnKdcqLKs1+kfW8Rku
         LQuRkyDNlThSc9wLEONTYEIbnj9JYt44rsc2qy9TdRgb7Kc2YZuaoF7CyTlELLAARe/d
         yu7YZhwuaesX4eq45kWScwhCCi8+ZYCklp/sg5mjQGP+enjfEcmmkBs1yB0iLXhLGdaU
         v6O+MJbUYegth1ZQisV5dlpoYbEMfj2zH/pY+nmpH+8W6iYy507v3e4xkIVXPaJSPMj/
         zYPkUoKXCqaTnV5vZhRiqFiLG0loiRlYp07itCSlXe4G32V1aV+Swp+cDULUTeRIv5kr
         OaGg==
X-Gm-Message-State: AA+aEWZRE2ZjQpbUhTMpyXKCLXQ9dnbU5D+oIgeHsSc5d+tgogY9NwR4
        S+CuI50TDXtIkUhMPZj4pPI=
X-Google-Smtp-Source: AFSGD/XXN9QZ5mxhdmzoODH6Q4JaQhc6thIwufE8ejAEFt0+2ubdCDlKdqiYc8LyAOjtVAPtFl91Kg==
X-Received: by 2002:a17:906:22ca:: with SMTP id q10-v6mr12699179eja.66.1544538472657;
        Tue, 11 Dec 2018 06:27:52 -0800 (PST)
Received: from tiehlicka.suse.cz (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id g31sm4073975eda.96.2018.12.11.06.27.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 06:27:52 -0800 (PST)
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH 3/3] mm, fault_around: do not take a reference to a locked page
Date:   Tue, 11 Dec 2018 15:27:41 +0100
Message-Id: <20181211142741.2607-4-mhocko@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181211142741.2607-1-mhocko@kernel.org>
References: <20181211142741.2607-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

filemap_map_pages takes a speculative reference to each page in the
range before it tries to lock that page. While this is correct it
also can influence page migration which will bail out when seeing
an elevated reference count. The faultaround code would bail on
seeing a locked page so we can pro-actively check the PageLocked
bit before page_cache_get_speculative and prevent from pointless
reference count churn.

Suggested-by: Jan Kara <jack@suse.cz>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Acked-by: Hugh Dickins <hughd@google.com>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 mm/filemap.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/filemap.c b/mm/filemap.c
index 81adec8ee02c..a87f71fff879 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2553,6 +2553,13 @@ void filemap_map_pages(struct vm_fault *vmf,
 			goto next;
 
 		head = compound_head(page);
+
+		/*
+		 * Check for a locked page first, as a speculative
+		 * reference may adversely influence page migration.
+		 */
+		if (PageLocked(head))
+			goto next;
 		if (!page_cache_get_speculative(head))
 			goto next;
 
-- 
2.19.2

