Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CFDBC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 610CC20820
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbfBDIsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 03:48:22 -0500
Received: from terminus.zytor.com ([198.137.202.136]:50909 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfBDIsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 03:48:21 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x148m7Mx356879
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 4 Feb 2019 00:48:07 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x148m7mP356876;
        Mon, 4 Feb 2019 00:48:07 -0800
Date:   Mon, 4 Feb 2019 00:48:07 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-9e63a7894fd302082cf3627fe90844421a6cbe7f@git.kernel.org>
Cc:     peterz@infradead.org, torvalds@linux-foundation.org,
        alexander.shishkin@linux.intel.com, mingo@kernel.org,
        jolsa@redhat.com, songliubraving@fb.com, hpa@zytor.com,
        acme@redhat.com, tglx@linutronix.de, kan.liang@linux.intel.com,
        linux-kernel@vger.kernel.org
Reply-To: jolsa@redhat.com, alexander.shishkin@linux.intel.com,
          mingo@kernel.org, torvalds@linux-foundation.org,
          peterz@infradead.org, linux-kernel@vger.kernel.org,
          kan.liang@linux.intel.com, acme@redhat.com, tglx@linutronix.de,
          hpa@zytor.com, songliubraving@fb.com
In-Reply-To: <1548600794-33162-1-git-send-email-kan.liang@linux.intel.com>
References: <1548600794-33162-1-git-send-email-kan.liang@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/x86/intel/uncore: Add Node ID mask
Git-Commit-ID: 9e63a7894fd302082cf3627fe90844421a6cbe7f
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  9e63a7894fd302082cf3627fe90844421a6cbe7f
Gitweb:     https://git.kernel.org/tip/9e63a7894fd302082cf3627fe90844421a6cbe7f
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Sun, 27 Jan 2019 06:53:14 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 4 Feb 2019 08:44:43 +0100

perf/x86/intel/uncore: Add Node ID mask

Some PCI uncore PMUs cannot be registered on an 8-socket system (HPE
Superdome Flex).

To understand which Socket the PCI uncore PMUs belongs to, perf retrieves
the local Node ID of the uncore device from CPUNODEID(0xC0) of the PCI
configuration space, and the mapping between Socket ID and Node ID from
GIDNIDMAP(0xD4). The Socket ID can be calculated accordingly.

The local Node ID is only available at bit 2:0, but current code doesn't
mask it. If a BIOS doesn't clear the rest of the bits, an incorrect Node ID
will be fetched.

Filter the Node ID by adding a mask.

Reported-by: Song Liu <songliubraving@fb.com>
Tested-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: <stable@vger.kernel.org> # v3.7+
Fixes: 7c94ee2e0917 ("perf/x86: Add Intel Nehalem and Sandy Bridge-EP uncore support")
Link: https://lkml.kernel.org/r/1548600794-33162-1-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/intel/uncore_snbep.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index c07bee31abe8..b10e04387f38 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -1222,6 +1222,8 @@ static struct pci_driver snbep_uncore_pci_driver = {
 	.id_table	= snbep_uncore_pci_ids,
 };
 
+#define NODE_ID_MASK	0x7
+
 /*
  * build pci bus to socket mapping
  */
@@ -1243,7 +1245,7 @@ static int snbep_pci2phy_map_init(int devid, int nodeid_loc, int idmap_loc, bool
 		err = pci_read_config_dword(ubox_dev, nodeid_loc, &config);
 		if (err)
 			break;
-		nodeid = config;
+		nodeid = config & NODE_ID_MASK;
 		/* get the Node ID mapping */
 		err = pci_read_config_dword(ubox_dev, idmap_loc, &config);
 		if (err)
