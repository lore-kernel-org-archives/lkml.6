Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1A3C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B081E208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:19:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B081E208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754989AbeFRPTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 11:19:22 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:51469 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752765AbeFRPTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 11:19:20 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue103 [212.227.15.145]) with ESMTPA (Nemesis) id
 0Mecsy-1ft4Uf0xtQ-00ODYn; Mon, 18 Jun 2018 17:19:09 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Karan Tilak Kumar <kartilak@cisco.com>,
        Sesidhar Baddela <sebaddel@cisco.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] snic: fix printing time intervals
Date:   Mon, 18 Jun 2018 17:18:41 +0200
Message-Id: <20180618151907.1453733-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:gPPt4IKuuoCYM7qjB85xXgyNhcEVi0mEJ75+NE2X/A5ZxEIgUo9
 cmB4f+qHqU7xW7f2aS5JaaozLy/YvrfT/hPCWwQa1CZUTsUzBlSQCDb0TcwPLjfm1cWE7uM
 LBct/ugz5o+p1Vu/g4zoFuu6DhB41W4SK1wpqTDx8osj6ZwNLj6pmrHVycBZFe8+csVaUIB
 uVe6E6hFsINzFvv1HPR2w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zFOWDC0Pkmw=:rbs4s/zJgP2qRZFK7pQqn6
 K0xy0npsmzvLBdrYepGKA/3T8nlH35lydOau3HnrupcudtBRLwuxQ7GdC61HI7LZ0bIW/qMur
 a/2Pz7SUubCHTmo3TqYrLGOsT9psJ+LLSmws0YCCdXX89wtO/NF8A9fri/iTyp8VQcH7IXS0H
 hKugmxlMUjQAFlSRwsTx+m0Prmkla/K/QhDFhX9PAW6GSna1gJKNhRWTK7lE1lj2ax7vLh2iL
 GUsyR8/J8nLIZ51r7zakkLrygnuTqApaxmLIuWQzch7l3xUO8O48cQvZS6+5RyD5OtzGN+PWI
 vyOezwTVl+CJTrWrlVtXf2byzIeBC8VZysZWYi1+hPUfA7lPMaYXzexA4SsTth/lB5XykJTSg
 v2dbnQhdAKY+WlTIYObaOuE1Giu+DIa86O7OrJaK0DhcOBPkK/9lgngeR+ytCEqsELjfSpXPu
 Qt2lqOqt+2a9rqBgQ5B9fLVfjbeJCPLjShIaDjI3niyRHFO/wJ2E4dHTi/8TPkViKzxpsbJ6y
 PmC1XIefH1cL3P0a3JadHxLcnpT/YKMeQGZ3pHwSM5NlclkLw7mb/kZbGXYAZjfsHE3I3HdHN
 LSyNL9im/mzRDV7v5J4trOibJNFyliFkzefwvDPrA4m+12Vkb14G47bxr7UfjPSMvlcKlgEJe
 QVY6Ma4N75dYjCt46IMCfrXKTBzJ5xWJhsxkTX82i1MHX3Xh5qPDPWTuJWPvUD98ms4k=
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

