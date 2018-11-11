Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB22C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6824E20871
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:59:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6824E20871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730951AbeKLFtG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:49:06 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51412 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730861AbeKLFsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:40 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvt1-0000tu-L5; Sun, 11 Nov 2018 19:59:11 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsS-0001Xg-1O; Sun, 11 Nov 2018 19:58:36 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Silvio Cesare" <silvio.cesare@gmail.com>,
        "Kees Cook" <keescook@chromium.org>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.578061426@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 134/366] UBIFS: Fix potential integer overflow in
 allocation
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Silvio Cesare <silvio.cesare@gmail.com>

commit 353748a359f1821ee934afc579cf04572406b420 upstream.

There is potential for the size and len fields in ubifs_data_node to be
too large causing either a negative value for the length fields or an
integer overflow leading to an incorrect memory allocation. Likewise,
when the len field is small, an integer underflow may occur.

Signed-off-by: Silvio Cesare <silvio.cesare@gmail.com>
Fixes: 1e51764a3c2ac ("UBIFS: add new flash file system")
Signed-off-by: Kees Cook <keescook@chromium.org>
[bwh: Backported to 3.16: We have a different set of length variables in
 recomp_data_node()]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/ubifs/journal.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/fs/ubifs/journal.c
+++ b/fs/ubifs/journal.c
@@ -1099,10 +1099,11 @@ out_free:
 static int recomp_data_node(struct ubifs_data_node *dn, int *new_len)
 {
 	void *buf;
-	int err, len, compr_type, out_len;
+	int err, compr_type;
+	u32 len, out_len;
 
 	out_len = le32_to_cpu(dn->size);
-	buf = kmalloc(out_len * WORST_COMPR_FACTOR, GFP_NOFS);
+	buf = kmalloc_array(out_len, WORST_COMPR_FACTOR, GFP_NOFS);
 	if (!buf)
 		return -ENOMEM;
 

