Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2178418-1518719656-2-10624862901706378152
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518719656; b=mAZXaSWl6NzmHie84nYuKpbwXyP1+xqCwVO6pAHa3KAdfsT
    eCf3qfyL90tjxIGIXyUXJ/RAItbYs0vFJ8Bl/dTq+RA42KOHOn32ePxhdYjOoxwy
    ZUY+IwKEXB4SqWH5X3TYoMqyP4qRCWo6oMmuHLo5TQ8onybM/2FR0B7ERmIKg0we
    WLHfuykFOnKJRHzokGqHlTmf30zeSnNAnjdTDsNGLtQc/PWutMNa/jefrcfiZLJX
    mzGJFFALg9BxHk97BMAFdcX5HLr9Gz8LiAXgt6/9BxZk9w+HLcfxzzSHQQVEC4w7
    Ml25JbyrbYbPge31XFkLELfMQE/RfGRoWARc+kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518719656; bh=DhHR/QjxOXMPVnScBhCV7KJVNI
    +ebpEBCEytCPfrcOo=; b=HrtfyI09bBOrj0F4DY8U81V6mvEotwWjCy4aMb/fH6
    vfFYkEzQuvEVDH/uWULwpdKa2jn2e3qkMpKAr9SuRQdIwKhdE7oLm6nPUuhq0MPL
    wjDuMoc9cWglTcMcCmDfX/ke6dqYcZm+Yzb90TrqfhZ4hiLcTyi/ziaHXffeI437
    UG03ieulGXZOXJ7JOy/ytsdKaMwcTuYCjFR6mWVIP0B45joh3og+cyE3N7N2svNi
    95vXjUNDpaucKY7B2V/wZQM/1OlyHL8LLAcDxGTZQPwUOLFGkNAnx2Slv9KLyzKX
    YK4cuBmlJbi33SsYbRKQIp931hvi44jdAYWh7EoOTbOg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162929AbeBOPYk (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:24:40 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:51936 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162920AbeBOPYh (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:24:37 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Miquel Raynal <miquel.raynal@free-electrons.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH 4.4 056/108] mtd: nand: Fix nand_do_read_oob() return value
Date: Thu, 15 Feb 2018 16:16:53 +0100
Message-Id: <20180215151230.229083357@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.267507937@linuxfoundation.org>
References: <20180215151222.267507937@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miquel Raynal <miquel.raynal@free-electrons.com>

commit 87e89ce8d0d14f573c068c61bec2117751fb5103 upstream.

Starting from commit 041e4575f034 ("mtd: nand: handle ECC errors in
OOB"), nand_do_read_oob() (from the NAND core) did return 0 or a
negative error, and the MTD layer expected it.

However, the trend for the NAND layer is now to return an error or a
positive number of bitflips. Deciding which status to return to the user
belongs to the MTD layer.

Commit e47f68587b82 ("mtd: check for max_bitflips in mtd_read_oob()")
brought this logic to the mtd_read_oob() function while the return value
coming from nand_do_read_oob() (called by the ->_read_oob() hook) was
left unchanged.

Fixes: e47f68587b82 ("mtd: check for max_bitflips in mtd_read_oob()")
Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/nand/nand_base.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/mtd/nand/nand_base.c
+++ b/drivers/mtd/nand/nand_base.c
@@ -2023,6 +2023,7 @@ static int nand_write_oob_syndrome(struc
 static int nand_do_read_oob(struct mtd_info *mtd, loff_t from,
 			    struct mtd_oob_ops *ops)
 {
+	unsigned int max_bitflips = 0;
 	int page, realpage, chipnr;
 	struct nand_chip *chip = mtd->priv;
 	struct mtd_ecc_stats stats;
@@ -2083,6 +2084,8 @@ static int nand_do_read_oob(struct mtd_i
 				nand_wait_ready(mtd);
 		}
 
+		max_bitflips = max_t(unsigned int, max_bitflips, ret);
+
 		readlen -= len;
 		if (!readlen)
 			break;
@@ -2108,7 +2111,7 @@ static int nand_do_read_oob(struct mtd_i
 	if (mtd->ecc_stats.failed - stats.failed)
 		return -EBADMSG;
 
-	return  mtd->ecc_stats.corrected - stats.corrected ? -EUCLEAN : 0;
+	return max_bitflips;
 }
 
 /**
