Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F505C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 532A62054F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544539034;
	bh=TotJtOPiOQiIU/x9E2IVMm3S8TyoOxNZOvPMLam/Aok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PDbj4lGRTK4OPPc4ZVT2G0GHw/fL+i2nRFOo8swg4xoutn/tMMuPS3AWmQtAqlnts
	 olRve9r0FSjy57o8pme2irqGzSnSMOTK9yMaeklX4ljrl6iwfjs372GP498rpyfaad
	 h2UGCjNnFvtD70isReucD+NdI/e255VESHopjrT0=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 532A62054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbeLKOhN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 09:37:13 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42760 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbeLKOgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 09:36:52 -0500
Received: by mail-ed1-f66.google.com with SMTP id j6so12678087edp.9;
        Tue, 11 Dec 2018 06:36:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SxgSQ41vevm4qZepZDpPxwHugsA+vDQMi7Sz6pwcLHk=;
        b=oZBH4MzVdGwc6sXGnp9QWJFzScpu2o8BhpGtM2MpO8TDHArX9bOhN/uLDVgsnt01sp
         y7/nY7YK/KaL+3eseCYcDikUeo5cGc65CIE5bX47bP5GudhwKUBemLXbl3+7xowSTzbO
         EU7tK6vhqCfIHxSW22V1dCVTMCcHbJKSRs5vjc7o6h2MdEykGEAN0k8Sn22/XJuVkAwb
         n4aFtWkTeYpYbvWTySbhs/Bpm6VVGHssuZtQEIDpK3Pne6ZKqU1wx30kmj4pmGWF9zYI
         kPjYy1tfG7AXF2Cjk6FYICzRIV4NpFBVSS9PSs7w3eTkpGPPtQeqSLJwviXHzinlAxCA
         Pj+w==
X-Gm-Message-State: AA+aEWab62hJ8AYdVfr8lK4vl9em9hHxtGhyVEiRwa3unhd48vY5phXa
        hLLpjy29j2p+y1OE/c7S1Dc=
X-Google-Smtp-Source: AFSGD/UXuasc79hjCYZNspt5DG9q6e3pITQ4jJGUN6Ma0PV9YCqzlzLjEoj1c/VpHKI6ndPYtPTHqA==
X-Received: by 2002:a17:906:5c9:: with SMTP id t9-v6mr12876002ejt.111.1544539010079;
        Tue, 11 Dec 2018 06:36:50 -0800 (PST)
Received: from tiehlicka.suse.cz (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id z40sm4017084edz.86.2018.12.11.06.36.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 06:36:49 -0800 (PST)
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-api@vger.kernel.org, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Rientjes <rientjes@google.com>, Jan Kara <jack@suse.cz>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 1/3] mm, proc: be more verbose about unstable VMA flags in /proc/<pid>/smaps
Date:   Tue, 11 Dec 2018 15:36:39 +0100
Message-Id: <20181211143641.3503-2-mhocko@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181211143641.3503-1-mhocko@kernel.org>
References: <20181211143641.3503-1-mhocko@kernel.org>
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

Cc: Dan Williams <dan.j.williams@intel.com>
Cc: David Rientjes <rientjes@google.com>
Acked-by: Jan Kara <jack@suse.cz>
Acked-by: Dan Williams <dan.j.williams@intel.com>
Acked-by: David Rientjes <rientjes@google.com>
Acked-by: Mike Rapoport <rppt@linux.ibm.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 Documentation/filesystems/proc.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/proc.txt b/Documentation/filesystems/proc.txt
index 12a5e6e693b6..2a4e63f5122c 100644
--- a/Documentation/filesystems/proc.txt
+++ b/Documentation/filesystems/proc.txt
@@ -496,7 +496,9 @@ flags associated with the particular virtual memory area in two letter encoded
 
 Note that there is no guarantee that every flag and associated mnemonic will
 be present in all further kernel releases. Things get changed, the flags may
-be vanished or the reverse -- new added.
+be vanished or the reverse -- new added. Interpretation of their meaning
+might change in future as well. So each consumer of these flags has to
+follow each specific kernel version for the exact semantic.
 
 This file is only present if the CONFIG_MMU kernel configuration option is
 enabled.
-- 
2.19.2

