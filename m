Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032556AbeE0BGw (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 21:06:52 -0400
Received: from mga09.intel.com ([134.134.136.24]:40536 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032537AbeE0BGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 21:06:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,446,1520924400";
   d="scan'208";a="61998705"
Subject: [PATCH 1/2] x86/numa_emulation: Fix emulated-to-physical node
 mapping
From: Dan Williams <dan.j.williams@intel.com>
To: mingo@kernel.org
Cc: Wei Yang <richard.weiyang@gmail.com>,
        David Rientjes <rientjes@google.com>,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, x86@kernel.org
Date: Sat, 26 May 2018 17:56:52 -0700
Message-ID: <152738261272.11641.17387529225149633595.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <152738260746.11641.13275998345345705617.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <152738260746.11641.13275998345345705617.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without this change the distance table calculation for emulated nodes
may use the wrong numa node and report an incorrect distance.

Cc: Wei Yang <richard.weiyang@gmail.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: <x86@kernel.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/x86/mm/numa_emulation.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/numa_emulation.c b/arch/x86/mm/numa_emulation.c
index 34a2a3bfde9c..22cbad56acab 100644
--- a/arch/x86/mm/numa_emulation.c
+++ b/arch/x86/mm/numa_emulation.c
@@ -61,7 +61,7 @@ static int __init emu_setup_memblk(struct numa_meminfo *ei,
 	eb->nid = nid;
 
 	if (emu_nid_to_phys[nid] == NUMA_NO_NODE)
-		emu_nid_to_phys[nid] = nid;
+		emu_nid_to_phys[nid] = pb->nid;
 
 	pb->start += size;
 	if (pb->start >= pb->end) {
