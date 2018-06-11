Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id DA481C004E4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 22:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87F57208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 22:57:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87F57208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754271AbeFKW5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 18:57:08 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:40850 "EHLO
        hera.aquilenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751234AbeFKW5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 18:57:07 -0400
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id BDA8AE4D;
        Tue, 12 Jun 2018 00:57:04 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HG29ISmkqy8T; Tue, 12 Jun 2018 00:57:04 +0200 (CEST)
Received: from var.youpi.perso.aquilenet.fr (static-176-158-111-12.ftth.abo.bbox.fr [176.158.111.12])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id E126EE4C;
        Tue, 12 Jun 2018 00:57:03 +0200 (CEST)
Received: from samy by var.youpi.perso.aquilenet.fr with local (Exim 4.91)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1fSVkF-0004Lb-5g; Tue, 12 Jun 2018 00:57:03 +0200
Date:   Tue, 12 Jun 2018 00:57:03 +0200
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     "Speakup is a screen review system for Linux." 
        <speakup@linux-speakup.org>, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: speakup: refactor synths array to use a list
Message-ID: <20180611225703.csi47cdafhy6rxcf@var.youpi.perso.aquilenet.fr>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        "Speakup is a screen review system for Linux." <speakup@linux-speakup.org>,
        devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
References: <20180604095212.GA18381@tanglefoot>
 <20180606132628.fxykchbznrwzgwqt@var.youpi.perso.aquilenet.fr>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="55pr6ffpo36jsalk"
Content-Disposition: inline
In-Reply-To: <20180606132628.fxykchbznrwzgwqt@var.youpi.perso.aquilenet.fr>
Organization: I am not organized
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--55pr6ffpo36jsalk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

Samuel Thibault, le mer. 06 juin 2018 15:26:28 +0200, a ecrit:
> I'd also rather see it tested in the real wild before committing. Could
> somebody on the speakup mailing list test the patch? (which I have
> re-attached as a file for conveniency).

Anybody up for testing please?

If people want to see speakup get mainlined instead of staging, please
help.

Samuel

--55pr6ffpo36jsalk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch

---
 drivers/staging/speakup/spk_types.h |  2 ++
 drivers/staging/speakup/synth.c     | 40 ++++++++++-------------------
 2 files changed, 15 insertions(+), 27 deletions(-)

diff --git a/drivers/staging/speakup/spk_types.h b/drivers/staging/speakup/spk_types.h
index 3e082dc3d45c..a2fc72c29894 100644
--- a/drivers/staging/speakup/spk_types.h
+++ b/drivers/staging/speakup/spk_types.h
@@ -160,6 +160,8 @@ struct spk_io_ops {
 };
 
 struct spk_synth {
+	struct list_head node;
+
 	const char *name;
 	const char *version;
 	const char *long_name;
diff --git a/drivers/staging/speakup/synth.c b/drivers/staging/speakup/synth.c
index 7deeb7061018..25f259ee4ffc 100644
--- a/drivers/staging/speakup/synth.c
+++ b/drivers/staging/speakup/synth.c
@@ -18,8 +18,7 @@
 #include "speakup.h"
 #include "serialio.h"
 
-#define MAXSYNTHS       16      /* Max number of synths in array. */
-static struct spk_synth *synths[MAXSYNTHS + 1];
+static LIST_HEAD(synths);
 struct spk_synth *synth;
 char spk_pitch_buff[32] = "";
 static int module_status;
@@ -355,9 +354,8 @@ struct var_t synth_time_vars[] = {
 /* called by: speakup_init() */
 int synth_init(char *synth_name)
 {
-	int i;
 	int ret = 0;
-	struct spk_synth *synth = NULL;
+	struct spk_synth *tmp, *synth = NULL;
 
 	if (!synth_name)
 		return 0;
@@ -371,9 +369,10 @@ int synth_init(char *synth_name)
 
 	mutex_lock(&spk_mutex);
 	/* First, check if we already have it loaded. */
-	for (i = 0; i < MAXSYNTHS && synths[i]; i++)
-		if (strcmp(synths[i]->name, synth_name) == 0)
-			synth = synths[i];
+	list_for_each_entry(tmp, &synths, node) {
+		if (strcmp(tmp->name, synth_name) == 0)
+			synth = tmp;
+	}
 
 	/* If we got one, initialize it now. */
 	if (synth)
@@ -448,29 +447,23 @@ void synth_release(void)
 /* called by: all_driver_init() */
 int synth_add(struct spk_synth *in_synth)
 {
-	int i;
 	int status = 0;
+	struct spk_synth *tmp;
 
 	mutex_lock(&spk_mutex);
-	for (i = 0; i < MAXSYNTHS && synths[i]; i++)
-		/* synth_remove() is responsible for rotating the array down */
-		if (in_synth == synths[i]) {
+
+	list_for_each_entry(tmp, &synths, node) {
+		if (tmp == in_synth) {
 			mutex_unlock(&spk_mutex);
 			return 0;
 		}
-	if (i == MAXSYNTHS) {
-		pr_warn("Error: attempting to add a synth past end of array\n");
-		mutex_unlock(&spk_mutex);
-		return -1;
 	}
 
 	if (in_synth->startup)
 		status = do_synth_init(in_synth);
 
-	if (!status) {
-		synths[i++] = in_synth;
-		synths[i] = NULL;
-	}
+	if (!status)
+		list_add_tail(&in_synth->node, &synths);
 
 	mutex_unlock(&spk_mutex);
 	return status;
@@ -479,17 +472,10 @@ EXPORT_SYMBOL_GPL(synth_add);
 
 void synth_remove(struct spk_synth *in_synth)
 {
-	int i;
-
 	mutex_lock(&spk_mutex);
 	if (synth == in_synth)
 		synth_release();
-	for (i = 0; synths[i]; i++) {
-		if (in_synth == synths[i])
-			break;
-	}
-	for ( ; synths[i]; i++) /* compress table */
-		synths[i] = synths[i + 1];
+	list_del(&in_synth->node);
 	module_status = 0;
 	mutex_unlock(&spk_mutex);
 }
-- 
2.17.1

--55pr6ffpo36jsalk--
