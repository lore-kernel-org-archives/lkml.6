Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7117C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 18:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99E46256AB
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 18:09:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99E46256AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030243AbeGASJh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 14:09:37 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34260 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965630AbeGAQ2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:28:08 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3143B92B;
        Sun,  1 Jul 2018 16:28:06 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH 4.9 086/101] NFSv4: Revert commit 5f83d86cf531d ("NFSv4.x: Fix wraparound issues..")
Date:   Sun,  1 Jul 2018 18:22:12 +0200
Message-Id: <20180701160800.600914361@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160757.138608453@linuxfoundation.org>
References: <20180701160757.138608453@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Trond Myklebust <trond.myklebust@hammerspace.com>

commit fc40724fc6731d90cc7fb6d62d66135f85a33dd2 upstream.

The correct behaviour for NFSv4 sequence IDs is to wrap around
to the value 0 after 0xffffffff.
See https://tools.ietf.org/html/rfc5661#section-2.10.6.1

Fixes: 5f83d86cf531d ("NFSv4.x: Fix wraparound issues when validing...")
Cc: stable@vger.kernel.org # 4.6+
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/nfs/callback_proc.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

--- a/fs/nfs/callback_proc.c
+++ b/fs/nfs/callback_proc.c
@@ -402,11 +402,8 @@ validate_seqid(const struct nfs4_slot_ta
 		return htonl(NFS4ERR_SEQ_FALSE_RETRY);
 	}
 
-	/* Wraparound */
-	if (unlikely(slot->seq_nr == 0xFFFFFFFFU)) {
-		if (args->csa_sequenceid == 1)
-			return htonl(NFS4_OK);
-	} else if (likely(args->csa_sequenceid == slot->seq_nr + 1))
+	/* Note: wraparound relies on seq_nr being of type u32 */
+	if (likely(args->csa_sequenceid == slot->seq_nr + 1))
 		return htonl(NFS4_OK);
 
 	/* Misordered request */


