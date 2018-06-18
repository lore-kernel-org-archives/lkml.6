Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A0F6C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AA7020852
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:35:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AA7020852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933730AbeFRPe6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 11:34:58 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:59135 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933182AbeFRPe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 11:34:56 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue102 [212.227.15.145]) with ESMTPA (Nemesis) id
 0LheU5-1fzN6O2RQ9-00mulX; Mon, 18 Jun 2018 17:29:05 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: lpfc: use monotonic timestamps for statistics
Date:   Mon, 18 Jun 2018 17:28:23 +0200
Message-Id: <20180618152903.1756535-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:sOAHvqvEiOcZJEaHx8bevgvBvesCUPcgHr3jXbxBeawoWzbMcii
 CHXaCNZGU12mOz72din3exeXhc6eyL71fOq5OGEqyp7yhYus5iefsRLs4WPNURnM7ScEMaf
 NYZqbWS6z50NITypcD6ldQmi4LrRVh04DlfhWg3O34f3+aNVFMpZB/2H2gG+Ry4C2csRGAS
 swejuZj+9K6P8hKz3PThw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nhJAGbqAfxg=:IKOFyy9NuZaQkoFZh9wiF0
 LAQtE8u9D6x8Uw7DWuHaEiSciebVJ79HtkFaRf+fgRSi/oh3c1FPafkTmoSLPMLLQcbhAXlUY
 LuywPGOFaFwjjI0Qw48G4Y3k6Dq3rDIxjoyw47sT9j5/aoEV3s4bGgKzB56GgaKud7BFVbSwr
 8WNBibcqJKEMTiecEOF1g0u6jAp/dvdpq+XJXDO9/J64WyvLDkK53Y7jYfabAIsY/Wsv9qki0
 QPZ93v7UoPN5RdqLR9eqnKjz7KbcKdqI4/ceVPcV0Mw+e8T+cncN7V2iL1S5ygbRYe4xJj2fA
 fK6FiLUpih9VQEyhFtifBreDz3tt1L/21vm56daXBeBpZJSJPCdOj7FbwUioQoNW0H5eE28H7
 eaxJpHZgwrga8G9cFzJE0EakaUL8yeZURRsUwSZy+rfWpbSni49vSbRI2OQvh4nJar5zFXZOZ
 cZlONvhVJz3oQVCVAMipF9HLTkABV/qwy2psAvlI5lCe6fyJCMaJkVs4xSJyoYn8/Wt+czHCD
 Kb4IUzvSlrnceVfFiYTqogWE6O6gltZLk5ME8zTXh+kepWx8pLlfh0IANwDxuuSxv/2946bGr
 FhyfmG9R0vuqtsR864+cfuA+H7cxfzo33w7+XhziJgKCm7vW7NnQ3NYmLoF4kqxB6YUVsz38W
 DsgjVO91ZFNuf6ADamOwoJfBUT+b5i3E07RdtYvXObPEqmOTe35Jr/dd3U6rR3XVcLBU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The get_seconds() function suffers from a possible overflow in 2038
or 2106, as well as jitter due to settimeofday or leap second updates,
and is deprecated.

As we are interested in elapsed time only, using ktime_get_seconds()
to read the CLOCK_MONOTONIC timebase is ideal here. This also lets us
remove the hack that tries to deal with get_seconds() going slightly
backwards, which cannot happen with montonic timestamps.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/scsi/lpfc/lpfc_attr.c | 10 ++--------
 drivers/scsi/lpfc/lpfc_sli.c  |  4 ++--
 drivers/scsi/lpfc/lpfc_sli.h  |  2 +-
 3 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_attr.c b/drivers/scsi/lpfc/lpfc_attr.c
index 729d343861f4..15c07481fe23 100644
--- a/drivers/scsi/lpfc/lpfc_attr.c
+++ b/drivers/scsi/lpfc/lpfc_attr.c
@@ -5891,7 +5891,6 @@ lpfc_get_stats(struct Scsi_Host *shost)
 	struct lpfc_lnk_stat * lso = &psli->lnk_stat_offsets;
 	LPFC_MBOXQ_t *pmboxq;
 	MAILBOX_t *pmb;
-	unsigned long seconds;
 	int rc = 0;
 
 	/*
@@ -5992,12 +5991,7 @@ lpfc_get_stats(struct Scsi_Host *shost)
 
 	hs->dumped_frames = -1;
 
-	seconds = get_seconds();
-	if (seconds < psli->stats_start)
-		hs->seconds_since_last_reset = seconds +
-				((unsigned long)-1 - psli->stats_start);
-	else
-		hs->seconds_since_last_reset = seconds - psli->stats_start;
+	hs->seconds_since_last_reset = ktime_get_seconds() - psli->stats_start;
 
 	mempool_free(pmboxq, phba->mbox_mem_pool);
 
@@ -6076,7 +6070,7 @@ lpfc_reset_stats(struct Scsi_Host *shost)
 	else
 		lso->link_events = (phba->fc_eventTag >> 1);
 
-	psli->stats_start = get_seconds();
+	psli->stats_start = ktime_get_seconds();
 
 	mempool_free(pmboxq, phba->mbox_mem_pool);
 
diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index 6f3c00a233ec..e6786a5db502 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -4591,7 +4591,7 @@ lpfc_sli_brdrestart_s3(struct lpfc_hba *phba)
 	spin_unlock_irq(&phba->hbalock);
 
 	memset(&psli->lnk_stat_offsets, 0, sizeof(psli->lnk_stat_offsets));
-	psli->stats_start = get_seconds();
+	psli->stats_start = ktime_get_seconds();
 
 	/* Give the INITFF and Post time to settle. */
 	mdelay(100);
@@ -4638,7 +4638,7 @@ lpfc_sli_brdrestart_s4(struct lpfc_hba *phba)
 	spin_unlock_irq(&phba->hbalock);
 
 	memset(&psli->lnk_stat_offsets, 0, sizeof(psli->lnk_stat_offsets));
-	psli->stats_start = get_seconds();
+	psli->stats_start = ktime_get_seconds();
 
 	/* Reset HBA AER if it was enabled, note hba_flag was reset above */
 	if (hba_aer_enabled)
diff --git a/drivers/scsi/lpfc/lpfc_sli.h b/drivers/scsi/lpfc/lpfc_sli.h
index 431754195505..80b191d73190 100644
--- a/drivers/scsi/lpfc/lpfc_sli.h
+++ b/drivers/scsi/lpfc/lpfc_sli.h
@@ -339,7 +339,7 @@ struct lpfc_sli {
 	struct lpfc_iocbq ** iocbq_lookup; /* array to lookup IOCB by IOTAG */
 	size_t iocbq_lookup_len;           /* current lengs of the array */
 	uint16_t  last_iotag;              /* last allocated IOTAG */
-	unsigned long  stats_start;        /* in seconds */
+	time64_t  stats_start;		   /* in seconds */
 	struct lpfc_lnk_stat lnk_stat_offsets;
 };
 
-- 
2.9.0

