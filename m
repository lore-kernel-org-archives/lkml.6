Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7476EC41536
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F782208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:35:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F782208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbeKTVEA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 16:04:00 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40582 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728336AbeKTVD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 16:03:59 -0500
Received: by mail-ed1-f67.google.com with SMTP id d3so1454224edx.7;
        Tue, 20 Nov 2018 02:35:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uxsJPkLcKckgPrN9D2d3v7GbIbgMcMizVEHoIL7/qsw=;
        b=FTuuJIrl9+EOwEH2yG4+qQBiEANCZFLgEXbO7OuMiRVTpTTnF8QMxCRTSzjs+XQgf3
         DhjzSrWJHiPeu7FGgL10RHZAStofsb/c9JXk7JrNXYinD4Kbq7QeXvJjnS+SC7pbv8Lm
         fLEPpqZa80DkxZViwDkk9E+M+/X3/QPnxQefbsmYsHwEF+hQnSRLcSBzeZwlO7HEhbGW
         RiiXxpp0s4iEFyhLacGPGZVjTOni+sK6Xw8BnkRBC+wQLyOXfnVCHe+4VZ8NhIvkyY5L
         dSGSYbih78A0uEGbAFlQN9Afa8TxHsguDMpFwlFY4DDiaraDlj/9AGEQuQvgPxJhOAgP
         edqA==
X-Gm-Message-State: AA+aEWaoMcMX4SSoDenLTyRW/wOrFjqlQjH6Q+T+XsTmBlKPn2Y9mWWA
        vdLcgpgxC85U2XYH6kdjkyOjMVHV
X-Google-Smtp-Source: AFSGD/XcnnedeezeTZmmFpCMjh4dc1ajw+LXBhUFZ7D3LPQ8LJxLKr4zWSjKw58X7+vbshNyIL2LJA==
X-Received: by 2002:a50:8799:: with SMTP id a25mr1831824eda.96.1542710130747;
        Tue, 20 Nov 2018 02:35:30 -0800 (PST)
Received: from tiehlicka.suse.cz (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id a15-v6sm5967233ejj.5.2018.11.20.02.35.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 02:35:29 -0800 (PST)
From:   Michal Hocko <mhocko@kernel.org>
To:     linux-api@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>, Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        David Rientjes <rientjes@google.com>
Subject: [RFC PATCH 1/3] mm, proc: be more verbose about unstable VMA flags in /proc/<pid>/smaps
Date:   Tue, 20 Nov 2018 11:35:13 +0100
Message-Id: <20181120103515.25280-2-mhocko@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181120103515.25280-1-mhocko@kernel.org>
References: <20181120103515.25280-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

Even though vma flags exported via /proc/<pid>/smaps are explicitly
documented to be not guaranteed for future compatibility the warning
doesn't go far enough because it doesn't mention semantic changes to
those flags. And they are important as well because these flags are
a deep implementation internal to the MM code and the semantic might
change at any time.

Let's consider two recent examples:
http://lkml.kernel.org/r/20181002100531.GC4135@quack2.suse.cz
: commit e1fb4a086495 "dax: remove VM_MIXEDMAP for fsdax and device dax" has
: removed VM_MIXEDMAP flag from DAX VMAs. Now our testing shows that in the
: mean time certain customer of ours started poking into /proc/<pid>/smaps
: and looks at VMA flags there and if VM_MIXEDMAP is missing among the VMA
: flags, the application just fails to start complaining that DAX support is
: missing in the kernel.

http://lkml.kernel.org/r/alpine.DEB.2.21.1809241054050.224429@chino.kir.corp.google.com
: Commit 1860033237d4 ("mm: make PR_SET_THP_DISABLE immediately active")
: introduced a regression in that userspace cannot always determine the set
: of vmas where thp is ineligible.
: Userspace relies on the "nh" flag being emitted as part of /proc/pid/smaps
: to determine if a vma is eligible to be backed by hugepages.
: Previous to this commit, prctl(PR_SET_THP_DISABLE, 1) would cause thp to
: be disabled and emit "nh" as a flag for the corresponding vmas as part of
: /proc/pid/smaps.  After the commit, thp is disabled by means of an mm
: flag and "nh" is not emitted.
: This causes smaps parsing libraries to assume a vma is eligible for thp
: and ends up puzzling the user on why its memory is not backed by thp.

In both cases userspace was relying on a semantic of a specific VMA
flag. The primary reason why that happened is a lack of a proper
internface. While this has been worked on and it will be fixed properly,
it seems that our wording could see some refinement and be more vocal
about semantic aspect of these flags as well.

Cc: Jan Kara <jack@suse.cz>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: David Rientjes <rientjes@google.com>
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 Documentation/filesystems/proc.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/proc.txt b/Documentation/filesystems/proc.txt
index 12a5e6e693b6..b1fda309f067 100644
--- a/Documentation/filesystems/proc.txt
+++ b/Documentation/filesystems/proc.txt
@@ -496,7 +496,9 @@ flags associated with the particular virtual memory area in two letter encoded
 
 Note that there is no guarantee that every flag and associated mnemonic will
 be present in all further kernel releases. Things get changed, the flags may
-be vanished or the reverse -- new added.
+be vanished or the reverse -- new added. Interpretatation of their meaning
+might change in future as well. So each consumnent of these flags have to
+follow each specific kernel version for the exact semantic.
 
 This file is only present if the CONFIG_MMU kernel configuration option is
 enabled.
-- 
2.19.1

