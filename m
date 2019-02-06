Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73ABFC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 07:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C02A2175B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 07:24:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbfBFHYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 02:24:48 -0500
Received: from mga01.intel.com ([192.55.52.88]:10519 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726822AbfBFHYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 02:24:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2019 23:24:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,339,1544515200"; 
   d="scan'208";a="141953069"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga004.fm.intel.com with ESMTP; 05 Feb 2019 23:24:47 -0800
Subject: [PATCH 1/2] mm/shuffle: Fix shuffle enable
From:   Dan Williams <dan.j.williams@intel.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 05 Feb 2019 23:12:10 -0800
Message-ID: <154943713038.3858443.4125180191382062871.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <154943712485.3858443.4491117952728936852.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <154943712485.3858443.4491117952728936852.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The removal of shuffle_store() in v10 of the patch series was prompted
by the review feedback to convert page_alloc_shuffle() to __memint. I
obviously booted a stale kernel build in my tests because
shuffle_store() is indeed required:

 BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
 #PF error: [INSTR]
 PGD 0 P4D 0
 Oops: 0010 [#1] SMP PTI
 CPU: 0 PID: 0 Comm: swapper Not tainted 5.0.0-rc1+ #2867
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20180531_142017-buildhw-08.phx2.fedoraproject.org-1.fc28 04/01/2014
 RIP: 0010:          (null)
 Code: Bad RIP value.
 RSP: 0000:ffffffff82603e78 EFLAGS: 00010046
 RAX: 0000000000000000 RBX: 0000000000000000 RCX: cccccccccccccccd
 RDX: ffffffff8261d7c0 RSI: ffffffff8244c010 RDI: ffff88843ffe1aaa
 RBP: ffff88843ffe1aac R08: ffffffff83486978 R09: 0000000000000000
 R10: ffffffff82603e80 R11: 0000000000000048 R12: ffff88843ffe1a97
 R13: ffff88843ffe1aaa R14: ffffffff8244c010 R15: 000000000000016d
 FS:  0000000000000000(0000) GS:ffff88811be00000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: ffffffffffffffd6 CR3: 0000000002614000 CR4: 00000000000606b0
 Call Trace:
  ? parse_args+0x170/0x360
  ? set_init_arg+0x55/0x55
  ? start_kernel+0x1d8/0x4c4
  ? set_init_arg+0x55/0x55
  ? secondary_startup_64+0xa4/0xb0

Reintroduce it and mark it __meminit. Given the sysfs attribute is not
writable it will never be called after init.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 mm/shuffle.c |   16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/mm/shuffle.c b/mm/shuffle.c
index 19bbf3e37fb6..3ce12481b1dc 100644
--- a/mm/shuffle.c
+++ b/mm/shuffle.c
@@ -38,7 +38,21 @@ extern int shuffle_show(char *buffer, const struct kernel_param *kp)
 	return sprintf(buffer, "%c\n", test_bit(SHUFFLE_ENABLE, &shuffle_state)
 			? 'Y' : 'N');
 }
-module_param_call(shuffle, NULL, shuffle_show, &shuffle_param, 0400);
+
+static __meminit int shuffle_store(const char *val,
+		const struct kernel_param *kp)
+{
+	int rc = param_set_bool(val, kp);
+
+	if (rc < 0)
+		return rc;
+	if (shuffle_param)
+		page_alloc_shuffle(SHUFFLE_ENABLE);
+	else
+		page_alloc_shuffle(SHUFFLE_FORCE_DISABLE);
+	return 0;
+}
+module_param_call(shuffle, shuffle_store, shuffle_show, &shuffle_param, 0400);
 
 /*
  * For two pages to be swapped in the shuffle, they must be free (on a

