Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB93C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7133D21486
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:33:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7133D21486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388295AbeIXSfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:35:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58356 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733238AbeIXSfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:35:16 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 95DA31018;
        Mon, 24 Sep 2018 12:33:20 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ingo Franzki <ifranzki@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.18 103/235] s390/crypto: Fix return code checking in cbc_paes_crypt()
Date:   Mon, 24 Sep 2018 13:51:29 +0200
Message-Id: <20180924113115.814888179@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.999624566@linuxfoundation.org>
References: <20180924113103.999624566@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ingo Franzki <ifranzki@linux.ibm.com>

commit b81126e01a8c6048249955feea46c8217ebefa91 upstream.

The return code of cpacf_kmc() is less than the number of
bytes to process in case of an error, not greater.
The crypt routines for the other cipher modes already have
this correctly.

Cc: stable@vger.kernel.org # v4.11+
Fixes: 279378430768 ("s390/crypt: Add protected key AES module")
Signed-off-by: Ingo Franzki <ifranzki@linux.ibm.com>
Acked-by: Harald Freudenberger <freude@linux.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/s390/crypto/paes_s390.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/s390/crypto/paes_s390.c
+++ b/arch/s390/crypto/paes_s390.c
@@ -208,7 +208,7 @@ static int cbc_paes_crypt(struct blkciph
 			      walk->dst.virt.addr, walk->src.virt.addr, n);
 		if (k)
 			ret = blkcipher_walk_done(desc, walk, nbytes - k);
-		if (n < k) {
+		if (k < n) {
 			if (__cbc_paes_set_key(ctx) != 0)
 				return blkcipher_walk_done(desc, walk, -EIO);
 			memcpy(param.key, ctx->pk.protkey, MAXPROTKEYSIZE);


