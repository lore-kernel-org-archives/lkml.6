Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C5FC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 371ED20842
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:46:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 371ED20842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389407AbeIXSsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:48:06 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59876 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730401AbeIXSsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:48:05 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 15BAF109E;
        Mon, 24 Sep 2018 12:46:05 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jth@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 214/235] scsi: libfc: fixup sleeping function called from invalid context
Date:   Mon, 24 Sep 2018 13:53:20 +0200
Message-Id: <20180924113125.046973604@linuxfoundation.org>
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

From: Hannes Reinecke <hare@suse.de>

[ Upstream commit fa519f701d27198a2858bb108fc18ea9d8c106a7 ]

fc_rport_login() will be calling mutex_lock() while running inside an
RCU-protected section, triggering the warning 'sleeping function called
from invalid context'.  To fix this we can drop the rcu functions here
altogether as the disc mutex protecting the list itself is already held,
preventing any list manipulation.

Fixes: a407c593398c ("scsi: libfc: Fixup disc_mutex handling")
Signed-off-by: Hannes Reinecke <hare@suse.com>
Acked-by: Johannes Thumshirn <jth@kernel.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/libfc/fc_disc.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/drivers/scsi/libfc/fc_disc.c
+++ b/drivers/scsi/libfc/fc_disc.c
@@ -294,9 +294,11 @@ static void fc_disc_done(struct fc_disc
 	 * discovery, reverify or log them in.	Otherwise, log them out.
 	 * Skip ports which were never discovered.  These are the dNS port
 	 * and ports which were created by PLOGI.
+	 *
+	 * We don't need to use the _rcu variant here as the rport list
+	 * is protected by the disc mutex which is already held on entry.
 	 */
-	rcu_read_lock();
-	list_for_each_entry_rcu(rdata, &disc->rports, peers) {
+	list_for_each_entry(rdata, &disc->rports, peers) {
 		if (!kref_get_unless_zero(&rdata->kref))
 			continue;
 		if (rdata->disc_id) {
@@ -307,7 +309,6 @@ static void fc_disc_done(struct fc_disc
 		}
 		kref_put(&rdata->kref, fc_rport_destroy);
 	}
-	rcu_read_unlock();
 	mutex_unlock(&disc->disc_mutex);
 	disc->disc_callback(lport, event);
 	mutex_lock(&disc->disc_mutex);


