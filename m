Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F9CC43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CECC1250B6
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:48:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CECC1250B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933874AbeFXPr7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 11:47:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33208 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932073AbeFXPr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 11:47:57 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C3F9B2C;
        Sun, 24 Jun 2018 15:47:55 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Richard W.M. Jones" <rjones@redhat.com>,
        Lorenzo Dalrio <lorenzo.dalrio@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 4.17 48/70] libata: Drop SanDisk SD7UB3Q*G1001 NOLPM quirk
Date:   Sun, 24 Jun 2018 23:22:40 +0800
Message-Id: <20180624142743.457901606@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180624142740.481662434@linuxfoundation.org>
References: <20180624142740.481662434@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit 2cfce3a86b64b53f0a70e92a6a659c720c319b45 upstream.

Commit 184add2ca23c ("libata: Apply NOLPM quirk for SanDisk
SD7UB3Q*G1001 SSDs") disabled LPM for SanDisk SD7UB3Q*G1001 SSDs.

This has lead to several reports of users of that SSD where LPM
was working fine and who know have a significantly increased idle
power consumption on their laptops.

Likely there is another problem on the T450s from the original
reporter which gets exposed by the uncore reaching deeper sleep
states (higher PC-states) due to LPM being enabled. The problem as
reported, a hardfreeze about once a day, already did not sound like
it would be caused by LPM and the reports of the SSD working fine
confirm this. The original reporter is ok with dropping the quirk.

A X250 user has reported the same hard freeze problem and for him
the problem went away after unrelated updates, I suspect some GPU
driver stack changes fixed things.

TL;DR: The original reporters problem were triggered by LPM but not
an LPM issue, so drop the quirk for the SSD in question.

BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1583207
Cc: stable@vger.kernel.org
Cc: Richard W.M. Jones <rjones@redhat.com>
Cc: Lorenzo Dalrio <lorenzo.dalrio@gmail.com>
Reported-by: Lorenzo Dalrio <lorenzo.dalrio@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Acked-by: "Richard W.M. Jones" <rjones@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/ata/libata-core.c |    3 ---
 1 file changed, 3 deletions(-)

--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4557,9 +4557,6 @@ static const struct ata_blacklist_entry
 	{ "SAMSUNG MZMPC128HBFU-000MV", "CXM14M1Q", ATA_HORKAGE_NOLPM, },
 	{ "SAMSUNG SSD PM830 mSATA *",  "CXM13D1Q", ATA_HORKAGE_NOLPM, },
 
-	/* Sandisk devices which are known to not handle LPM well */
-	{ "SanDisk SD7UB3Q*G1001",	NULL,	ATA_HORKAGE_NOLPM, },
-
 	/* devices that don't properly handle queued TRIM commands */
 	{ "Micron_M500IT_*",		"MU01",	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },


