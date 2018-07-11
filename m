Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F5D3C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 353BF20878
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:38:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 353BF20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387495AbeGKMmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 08:42:10 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:60178 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732808AbeGKMmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 08:42:10 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue006 [212.227.15.129]) with ESMTPA (Nemesis) id
 0Mfeu7-1fSPZC1YvD-00P9ET; Wed, 11 Jul 2018 14:37:53 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Karan Tilak Kumar <kartilak@cisco.com>,
        Sesidhar Baddela <sebaddel@cisco.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] [RESEND] snic: fix printing time intervals
Date:   Wed, 11 Jul 2018 14:37:37 +0200
Message-Id: <20180711123752.773163-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:JSgCNGLfvgDpr2OsCk69pcJuIshvZXQVLajIE+MNcrN9z8/GTO7
 fCRF48xO5ExyBXVU32fNtlrJZGoah8oNG3JaWAh0UQ8NHOQUQ+ysAePAgkR4pDFBWexKv/S
 vLPH7uX9dV+9gbg9aN/qmrwIzJGoyyjXJrGTqThKp9dftoicZtWRMsnA6ji9oGDtX/4AUM4
 Vz13UP8Y8UrH8kuaxlzLQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TgHTIVHkI88=:EvNV1Dxh4gR6HWdlV+K/ug
 FXOBdgSF4XeJ2P7eTMAMgMqW+Rk9hSyg61Zqsov3/UZpYm4k3DMKnwRwBD9NIenlmHQeBU0PD
 rdgMTqq7m7aZnWBGzTdx91bHhgNIf1UhCferTYXLtzuTzjPIfrUYv0D9DFZtJCNkUO7vGzoGN
 ageBGZ65WPBqI+V/rsDUNE+DcTVNs8yEr5s9upG3shtotQQ7avgmo/ehuNyA0Kdskgm1GdTv0
 j1vHAbux1kLVimJ6ajwmqGvmr6dtDIa64PyYP5loIbk/XECCXDTCsVV3Y4nnlTrrPfdlBsbBG
 PweMXgXawmR6Fuk5ajtG6cYNoqUtZSle0WjZx5op7xPYbbLYkUmcfn6uVB9UO52fxsOzqBd6M
 Ov8oYUDW5pBhmxXri2thtu1FpTHsmEVXmWwCJsZyUIm6l4Ce+INt1pj7FeXY31m40HWDIrIaK
 b1dFnOvkIR+0AxSsRUis5Dzv67i6bvr3tE4FJ79v8twnwj1XiuxGMUbvWDZFh480w5v6GTPzQ
 0ZFwn+Bda+Z4L9+foKekU9YnhACYcpY6X3TAwSDYsoByGPjKUfKlWuYLOhJqaPjYhZa+G8/8u
 jIm/SPFmSXZx0s07RCL7qt5S+ZvRRK9tBSDAiLmN1tHWa4vNChoLiL3/jh508cQdEs4Ff/nc9
 PkKaJyibpyKfwRonr0zZOB2JwiqocPWA41RYQN70ZA6NacFHCtMCj/Q2uhZUHTcD7bok=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't want to use 'struct timespec' because of the y2038 overflow
problem. The overflow is not actually an issue here, but it's easy to
replace with 'timespec64' for consistency. However, it's worth pointing
out that nanosecond values have nine digits, not eight or ten, so I'm
fixing the format strings accordingly as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Originall sent on June 18, but got no reply, so resending now
without changes.

Please review and apply
---
 drivers/scsi/snic/snic_debugfs.c | 10 +++++-----
 drivers/scsi/snic/snic_trc.c     |  6 +++---
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/snic/snic_debugfs.c b/drivers/scsi/snic/snic_debugfs.c
index 269ddf791a73..0abe17c1a73b 100644
--- a/drivers/scsi/snic/snic_debugfs.c
+++ b/drivers/scsi/snic/snic_debugfs.c
@@ -200,7 +200,7 @@ snic_stats_show(struct seq_file *sfp, void *data)
 {
 	struct snic *snic = (struct snic *) sfp->private;
 	struct snic_stats *stats = &snic->s_stats;
-	struct timespec last_isr_tms, last_ack_tms;
+	struct timespec64 last_isr_tms, last_ack_tms;
 	u64 maxio_tm;
 	int i;
 
@@ -312,12 +312,12 @@ snic_stats_show(struct seq_file *sfp, void *data)
 		   "\t\t Other Statistics\n"
 		   "\n---------------------------------------------\n");
 
-	jiffies_to_timespec(stats->misc.last_isr_time, &last_isr_tms);
-	jiffies_to_timespec(stats->misc.last_ack_time, &last_ack_tms);
+	jiffies_to_timespec64(stats->misc.last_isr_time, &last_isr_tms);
+	jiffies_to_timespec64(stats->misc.last_ack_time, &last_ack_tms);
 
 	seq_printf(sfp,
-		   "Last ISR Time               : %llu (%8lu.%8lu)\n"
-		   "Last Ack Time               : %llu (%8lu.%8lu)\n"
+		   "Last ISR Time               : %llu (%8llu.%09lu)\n"
+		   "Last Ack Time               : %llu (%8llu.%09lu)\n"
 		   "Ack ISRs                    : %llu\n"
 		   "IO Cmpl ISRs                : %llu\n"
 		   "Err Notify ISRs             : %llu\n"
diff --git a/drivers/scsi/snic/snic_trc.c b/drivers/scsi/snic/snic_trc.c
index f00ebf4717e0..fc60c933d6c0 100644
--- a/drivers/scsi/snic/snic_trc.c
+++ b/drivers/scsi/snic/snic_trc.c
@@ -65,12 +65,12 @@ static int
 snic_fmt_trc_data(struct snic_trc_data *td, char *buf, int buf_sz)
 {
 	int len = 0;
-	struct timespec tmspec;
+	struct timespec64 tmspec;
 
-	jiffies_to_timespec(td->ts, &tmspec);
+	jiffies_to_timespec64(td->ts, &tmspec);
 
 	len += snprintf(buf, buf_sz,
-			"%lu.%10lu %-25s %3d %4x %16llx %16llx %16llx %16llx %16llx\n",
+			"%llu.%09lu %-25s %3d %4x %16llx %16llx %16llx %16llx %16llx\n",
 			tmspec.tv_sec,
 			tmspec.tv_nsec,
 			td->fn,
-- 
2.9.0

