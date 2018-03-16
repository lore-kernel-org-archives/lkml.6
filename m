Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELv5e4RYqnnwiDkZPw1oJLcspTenRxgy07F22MyUPrCako9RSlLaUdUPhHjL4CxHJAmWLtU1
ARC-Seal: i=1; a=rsa-sha256; t=1521215088; cv=none;
        d=google.com; s=arc-20160816;
        b=tYT0CiZzZoF2i6ljpbhFxD2RuAfo5QE+bj8suYh+r9YuEy+BbHJZBovAI184kDvYM3
         OnlEqoRoG+I3CUnQX+r/ioTKv+PnnrNPsub+/vUHF2MYt312WC8sz58aW8tYs/gCQWwf
         19AS+QFKtpxFuDjZSLJ+iT+3hwzGodotirsijW+O05iyl0gc/JRvdIymGjmJjReFsSIP
         q0kHRc7q3iPGEhIIAYmIKjnY6Pzos2aTOZQsTZlGFrtuQNSJGIdnUDjZ/Jon0ztUYbuN
         7SA3Puyh4r87zYK8sxzjhbqwjijnOEaIs7dHSFnRwhjj/EHD0NyByIYQPOikFCkKQ0gF
         UhCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=hcZnsrdDq3dWrDVr44dYCMwrN68nTXny5lmf2v5dudA=;
        b=WXr0Hee5BaaGKOXeEYaAJcUECwc0mh1EG3JzDx8jVd8boCHH7Y6mG4CkGtA094dG2Y
         lsek5x8/TfBpTc1j5TgC+zdTVJTmKdJ6VMzsVSmqW+xislunU3as6BUi3FcfIQR2fUGi
         NiVYfDKV5yTzE3ZpcTaUBNfvO4JGIjKyx0LuBvz/RH48U9X+n3GgxM9Xej14qGCSMjOw
         pvqmecQDS8/uEiQLiWF7GakJlhYdxRqHosbcu8AonMnGDfjEJHrz4hF1813morSa1PEz
         aN7wV/r73nAZCv4sCSYQNUq4TgmuupoDHBIVGlpXw28WH/aHKVEbZW86uQPjze6PLnzM
         zJ+g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jeremy Linton <jeremy.linton@arm.com>,
	Davidlohr Bueso <dbueso@suse.de>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 124/128] locking/locktorture: Fix num reader/writer corner cases
Date: Fri, 16 Mar 2018 16:24:25 +0100
Message-Id: <20180316152342.593559836@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109267893386747?=
X-GMAIL-MSGID: =?utf-8?q?1595109632669964203?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Davidlohr Bueso <dave@stgolabs.net>


[ Upstream commit 2ce77d16db4240dd2e422fc0a5c26d3e2ec03446 ]

Things can explode for locktorture if the user does combinations
of nwriters_stress=0 nreaders_stress=0. Fix this by not assuming
we always want to torture writer threads.

Reported-by: Jeremy Linton <jeremy.linton@arm.com>
Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Reviewed-by: Jeremy Linton <jeremy.linton@arm.com>
Tested-by: Jeremy Linton <jeremy.linton@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/locking/locktorture.c |   76 ++++++++++++++++++++++++-------------------
 1 file changed, 44 insertions(+), 32 deletions(-)

--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -715,8 +715,7 @@ static void __torture_print_stats(char *
 {
 	bool fail = 0;
 	int i, n_stress;
-	long max = 0;
-	long min = statp[0].n_lock_acquired;
+	long max = 0, min = statp ? statp[0].n_lock_acquired : 0;
 	long long sum = 0;
 
 	n_stress = write ? cxt.nrealwriters_stress : cxt.nrealreaders_stress;
@@ -823,7 +822,7 @@ static void lock_torture_cleanup(void)
 	 * such, only perform the underlying torture-specific cleanups,
 	 * and avoid anything related to locktorture.
 	 */
-	if (!cxt.lwsa)
+	if (!cxt.lwsa && !cxt.lrsa)
 		goto end;
 
 	if (writer_tasks) {
@@ -898,6 +897,13 @@ static int __init lock_torture_init(void
 		firsterr = -EINVAL;
 		goto unwind;
 	}
+
+	if (nwriters_stress == 0 && nreaders_stress == 0) {
+		pr_alert("lock-torture: must run at least one locking thread\n");
+		firsterr = -EINVAL;
+		goto unwind;
+	}
+
 	if (cxt.cur_ops->init)
 		cxt.cur_ops->init();
 
@@ -921,17 +927,19 @@ static int __init lock_torture_init(void
 #endif
 
 	/* Initialize the statistics so that each run gets its own numbers. */
+	if (nwriters_stress) {
+		lock_is_write_held = 0;
+		cxt.lwsa = kmalloc(sizeof(*cxt.lwsa) * cxt.nrealwriters_stress, GFP_KERNEL);
+		if (cxt.lwsa == NULL) {
+			VERBOSE_TOROUT_STRING("cxt.lwsa: Out of memory");
+			firsterr = -ENOMEM;
+			goto unwind;
+		}
 
-	lock_is_write_held = 0;
-	cxt.lwsa = kmalloc(sizeof(*cxt.lwsa) * cxt.nrealwriters_stress, GFP_KERNEL);
-	if (cxt.lwsa == NULL) {
-		VERBOSE_TOROUT_STRING("cxt.lwsa: Out of memory");
-		firsterr = -ENOMEM;
-		goto unwind;
-	}
-	for (i = 0; i < cxt.nrealwriters_stress; i++) {
-		cxt.lwsa[i].n_lock_fail = 0;
-		cxt.lwsa[i].n_lock_acquired = 0;
+		for (i = 0; i < cxt.nrealwriters_stress; i++) {
+			cxt.lwsa[i].n_lock_fail = 0;
+			cxt.lwsa[i].n_lock_acquired = 0;
+		}
 	}
 
 	if (cxt.cur_ops->readlock) {
@@ -948,19 +956,21 @@ static int __init lock_torture_init(void
 			cxt.nrealreaders_stress = cxt.nrealwriters_stress;
 		}
 
-		lock_is_read_held = 0;
-		cxt.lrsa = kmalloc(sizeof(*cxt.lrsa) * cxt.nrealreaders_stress, GFP_KERNEL);
-		if (cxt.lrsa == NULL) {
-			VERBOSE_TOROUT_STRING("cxt.lrsa: Out of memory");
-			firsterr = -ENOMEM;
-			kfree(cxt.lwsa);
-			cxt.lwsa = NULL;
-			goto unwind;
-		}
-
-		for (i = 0; i < cxt.nrealreaders_stress; i++) {
-			cxt.lrsa[i].n_lock_fail = 0;
-			cxt.lrsa[i].n_lock_acquired = 0;
+		if (nreaders_stress) {
+			lock_is_read_held = 0;
+			cxt.lrsa = kmalloc(sizeof(*cxt.lrsa) * cxt.nrealreaders_stress, GFP_KERNEL);
+			if (cxt.lrsa == NULL) {
+				VERBOSE_TOROUT_STRING("cxt.lrsa: Out of memory");
+				firsterr = -ENOMEM;
+				kfree(cxt.lwsa);
+				cxt.lwsa = NULL;
+				goto unwind;
+			}
+
+			for (i = 0; i < cxt.nrealreaders_stress; i++) {
+				cxt.lrsa[i].n_lock_fail = 0;
+				cxt.lrsa[i].n_lock_acquired = 0;
+			}
 		}
 	}
 
@@ -990,12 +1000,14 @@ static int __init lock_torture_init(void
 			goto unwind;
 	}
 
-	writer_tasks = kzalloc(cxt.nrealwriters_stress * sizeof(writer_tasks[0]),
-			       GFP_KERNEL);
-	if (writer_tasks == NULL) {
-		VERBOSE_TOROUT_ERRSTRING("writer_tasks: Out of memory");
-		firsterr = -ENOMEM;
-		goto unwind;
+	if (nwriters_stress) {
+		writer_tasks = kzalloc(cxt.nrealwriters_stress * sizeof(writer_tasks[0]),
+				       GFP_KERNEL);
+		if (writer_tasks == NULL) {
+			VERBOSE_TOROUT_ERRSTRING("writer_tasks: Out of memory");
+			firsterr = -ENOMEM;
+			goto unwind;
+		}
 	}
 
 	if (cxt.cur_ops->readlock) {
