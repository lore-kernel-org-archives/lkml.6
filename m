Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A45AC1B0E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0879920C0B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:16:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0879920C0B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390245AbeGKUWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 16:22:35 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:42218 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732602AbeGKUWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 16:22:34 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue005 [212.227.15.129]) with ESMTPA (Nemesis) id
 0MdZVI-1fRCT11PX2-00PKRV; Wed, 11 Jul 2018 22:16:19 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Johannes Thumshirn <jth@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Hannes Reinecke <hare@suse.de>,
        Satish Kharat <satishkh@cisco.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: libfc: drop an incorrect assertion
Date:   Wed, 11 Jul 2018 22:15:24 +0200
Message-Id: <20180711201617.898598-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:iCPiuFXe6hCCFWf5oGJmv+09PhfD9nT3BiqkcR8HBBF9Y8f/qMP
 6FQDTg8pw5oMuextRkUSTk0y2lY/3AH5NF1vRiNTxd8QuJn6yc0kwefULpSohWtllcMTo8F
 wrhbYvoS0BM3TWSNDlnHS9LEcEJmHdleVjkGGo4UjfhdG6eP+Ky7cg47Cb3Lx3O3AWWxtfv
 1cEWzbUJYM0FAY7Y/hqXw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:g2aRhjjCs2o=:u1S0T5hVH9NtPEjMWxb1UG
 bN1VZYQtri9GbDkdXVYnI4VIoF4suzU0ayFKAM6Kau4EZLGfFftwMu1J2t0tjYupTXarvNDhG
 ZH/OJTSI+ymacPExewZ/dlTE/isUd7Io9NNqKW9/IRK9ZQ+s3qoTEbe4yNM5UAoSgmeE14dty
 snrmREZaCZ7yE1sWop/Ht3izLqeveZBiF7haoGPBTMkZp3PYYlcQsPyQoy1HYQpzl9TUJIuzs
 yWkTJeltRoeiTtS5uJra7t8iW7eRrPSA0zW8r9tFfju4AZgWHeb6YJuh3KC+pWPLv8MejVp+Q
 QnZCiPzLhe1GnJ2io2/IOIg1s5g3Q1bgMt1K5BMJI39LAmLadPthKuJ4D+5tCf4tlei9c7qY5
 Bj64xezgu57ImGhK0M/Yo+yhXWToWPbouMIor+pRgcKqdt9HJZ1WMbhirNhvSGqILKk7Mr52U
 xeuuiBsmkkK+/vrxWfEyzfGBr2rC94FfsL9Qez+hYEKQaklyUuSrD2pZD1JciQC8eDFBTJQwh
 QvILunxxmsO3uki35okkXHFvxdSKsMEfoc0jNPImzSVSPlZgY6YqEbqwECOgtzJcU5SXLoDtW
 Q5gRFbtYGQm5Y4VXJYaYuSgBV7xEltVVS1QtlZ4hkDrhco4qu1Pw9v8HSe8JExKG6iXGFGVS+
 v9qvQ8vFzCGrwcgVkWLpMsf1mFURyGAITo9nM7cizNXsWdvRv9XqJG+az4alXTi5w4yE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc points out one case in which the added lockdep_assert_held()
is wrong:

In file included from include/linux/spinlock_types.h:18,
                 from include/linux/spinlock.h:82,
                 from drivers/scsi/libfc/fc_rport.c:61:
drivers/scsi/libfc/fc_rport.c: In function 'fc_rport_recv_plogi_req':
include/linux/lockdep.h:347:45: error: 'rdata' may be used uninitialized in this function [-Werror=maybe-uninitialized]
 #define lockdep_is_held(lock)  lock_is_held(&(lock)->dep_map)
                                             ^
drivers/scsi/libfc/fc_rport.c:1832:24: note: 'rdata' was declared here
  struct fc_rport_priv *rdata;

The pointer to the lock is not initialized here, so besides the
compile-time warning, this will likely lead to an immediate
crash when dereferencing that pointer.

Fixes: ee35624e1e4e ("scsi: libfc: Add lockdep annotations")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/scsi/libfc/fc_rport.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/scsi/libfc/fc_rport.c b/drivers/scsi/libfc/fc_rport.c
index 6aff9303251a..be640ad2b7b6 100644
--- a/drivers/scsi/libfc/fc_rport.c
+++ b/drivers/scsi/libfc/fc_rport.c
@@ -1835,8 +1835,6 @@ static void fc_rport_recv_plogi_req(struct fc_lport *lport,
 	struct fc_seq_els_data rjt_data;
 	u32 sid;
 
-	lockdep_assert_held(&rdata->rp_mutex);
-
 	sid = fc_frame_sid(fp);
 
 	FC_RPORT_ID_DBG(lport, sid, "Received PLOGI request\n");
-- 
2.9.0

