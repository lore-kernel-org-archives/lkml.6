Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E882C7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4BEA20645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:46:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4BEA20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729284AbeJNX2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:28:19 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37241 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728125AbeJNX2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:28:19 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLx-0004cj-Ef; Sun, 14 Oct 2018 16:30:49 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLU-0000Oo-Gp; Sun, 14 Oct 2018 16:30:20 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Sebastian Ott" <sebott@linux.ibm.com>,
        "Martin Schwidefsky" <schwidefsky@de.ibm.com>,
        "Peter Oberparleiter" <oberpar@linux.ibm.com>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.870782359@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 191/366] s390/cio: update chpid descriptor after
 resource accessibility event
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Sebastian Ott <sebott@linux.ibm.com>

commit af2e460ade0b0180d0f3812ca4f4f59cc9597f3e upstream.

Channel path descriptors have been seen as something stable (as
long as the chpid is configured). Recent tests have shown that the
descriptor can also be altered when the link state of a channel path
changes. Thus it is necessary to update the descriptor during
handling of resource accessibility events.

Signed-off-by: Sebastian Ott <sebott@linux.ibm.com>
Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/s390/cio/chsc.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

--- a/drivers/s390/cio/chsc.c
+++ b/drivers/s390/cio/chsc.c
@@ -362,6 +362,7 @@ static void chsc_process_sei_link_incide
 
 static void chsc_process_sei_res_acc(struct chsc_sei_nt0_area *sei_area)
 {
+	struct channel_path *chp;
 	struct chp_link link;
 	struct chp_id chpid;
 	int status;
@@ -374,10 +375,17 @@ static void chsc_process_sei_res_acc(str
 	chpid.id = sei_area->rsid;
 	/* allocate a new channel path structure, if needed */
 	status = chp_get_status(chpid);
-	if (status < 0)
-		chp_new(chpid);
-	else if (!status)
+	if (!status)
 		return;
+
+	if (status < 0) {
+		chp_new(chpid);
+	} else {
+		chp = chpid_to_chp(chpid);
+		mutex_lock(&chp->lock);
+		chp_update_desc(chp);
+		mutex_unlock(&chp->lock);
+	}
 	memset(&link, 0, sizeof(struct chp_link));
 	link.chpid = chpid;
 	if ((sei_area->vf & 0xc0) != 0) {

