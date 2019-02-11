Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63EF0C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20057218A3
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896801;
	bh=+mPBa1efM5wWThvmfh3bwa9QAcXu/4J8qDB2T/cS3F8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Tn1C/2xIVrJlER+vDTszxO2ww1MYgS5799e+lPC21UIEDOTLl0fvjJiFmCFbaLDDN
	 lC2h204TVRXRhqjJ7IPHeAxe9EsZqUWAj6U2apFL8JD02NFaTIJfS2F79sI10SuClc
	 6yJGZLks7vCAxk32W3yS0VDKM7BYivpMKaBlilZc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388220AbfBKOxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:53:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:39654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388593AbfBKOxQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:53:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD26520855;
        Mon, 11 Feb 2019 14:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896795;
        bh=+mPBa1efM5wWThvmfh3bwa9QAcXu/4J8qDB2T/cS3F8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E2p0epaaBfCAsIoR5LUItw0+43iswqpxFYv4FgQXP8QqvfIGH+IIiYBBia8Ph0cDq
         E8CYJBjiL39yL9e9nvpSKCYx5LXE54PCHuS7cdqitdELXzsdWoKn5fPUe1rI8mL4xd
         PGnqrKQ4n6YmC6TptsydAunXsH62jFLq9RsnwVS8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.19 304/313] perf/x86/intel/uncore: Add Node ID mask
Date:   Mon, 11 Feb 2019 15:19:44 +0100
Message-Id: <20190211141913.148484547@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kan Liang <kan.liang@linux.intel.com>

commit 9e63a7894fd302082cf3627fe90844421a6cbe7f upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/events/intel/uncore_snbep.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -1222,6 +1222,8 @@ static struct pci_driver snbep_uncore_pc
 	.id_table	= snbep_uncore_pci_ids,
 };
 
+#define NODE_ID_MASK	0x7
+
 /*
  * build pci bus to socket mapping
  */
@@ -1243,7 +1245,7 @@ static int snbep_pci2phy_map_init(int de
 		err = pci_read_config_dword(ubox_dev, nodeid_loc, &config);
 		if (err)
 			break;
-		nodeid = config;
+		nodeid = config & NODE_ID_MASK;
 		/* get the Node ID mapping */
 		err = pci_read_config_dword(ubox_dev, idmap_loc, &config);
 		if (err)


