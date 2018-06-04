Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752167AbeFDJwY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 05:52:24 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:58955 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751715AbeFDJwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 05:52:22 -0400
Date: Mon, 4 Jun 2018 10:52:12 +0100
From: Justin Skists <justin.skists@juzza.co.uk>
To: devel@driverdev.osuosl.org
Cc: gregkh@linuxfoundation.org, speakup@linux-speakup.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: speakup: refactor synths array to use a list
Message-ID: <20180604095212.GA18381@tanglefoot>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Provags-ID: V03:K1:aYvLbEKcnRDYTubYgDezJi4GpfbUsMN36D+Hl+eS9km3lI36Zv/
 p5NRkm4iVtxoW2QBo0a6gb58/ZGFutd83R8qYDPvVR8dGT2PULE8xVRiEQ987S8cw2bg6aa
 gCwKJDxzcuEOGx1h108sZd8b+MRI1C1qAMDhIw4Rh+G1hPMxP1NJHPB5zaSg9Gp/HxvQrrn
 5/FiXVThV+QQPur5crsuA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dJlcnyXmRxo=:tUALAA7mWMSAhRfPfWmP5C
 mIdwtIzv7GluNpWb6vZK5yjfvi8T6ZjBgnuc1k44JjD5c6K/FJslI93hNJtgpUCcorOdUKTdr
 96josTSgvpUbu8uD+dUATfSPH3wPYnD8JTDkphrSmbb91UxEr2ZZKxjn73jj1JWDpJPZhNUPS
 YBtmNum2xtDFLOPDp/epqulj2muxd54EUBB6Vcw0jLKjEcP1he2G0IVD+MTexNONH806OimjH
 QwtW1dQopk/f5w/P5BeMl64a01LswJ70zC02jOMQ8UrhMndDKFw20DtmERtYGFChOT0qpFEGG
 eTX23JNe9r9M4uqAMPziPhIC36IQfrNeR3w8xx8SkOlxa49xG14s1WvAfuoI8lICmj6WDMPNo
 Hivypy/H5B14E3UBH/ejm4olvneTV5eo06w0ySD6tD9T21ks2YTHNUMTEHv22Xlu5hG0HDnMP
 ATOIUCWYqnhXqHfR9WMlCLXzykrpmnWxY2ulM2m1TDohF0q2OVZ3d2zScqBALJ8JPNsVuTLBU
 J1iLgtkbSciYRbJT02x0PGI5V1nEqTf7HwLaQtcHKDIvQ8W2rDSIDEDlbx7n4uOuInUuVvxD5
 CazYjiSuJWzSr9ILAAT7uOpJ7Z8bOJ805Z9gRMhGlX+Do4eKT+rOGhAtt4Zce2UGWy4gSQlWS
 7sr4oXJ4X/dl3ku+kkoljKVKb3rju2EaoAgj9dXBI+g+HE7YGP2TIg53bx3Y6mWOroc8=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The synths[] array is a collection of synths acting like a list.
There is no need for synths to be an array, so refactor synths[] to use
standard kernel list_head API, instead, and modify the usages to suit.
As a side-effect, the maximum number of synths has also become redundant.

Signed-off-by: Justin Skists <justin.skists@juzza.co.uk>
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
