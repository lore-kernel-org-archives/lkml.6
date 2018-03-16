Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELttaEBgq16wvtnelHADWz76De0yD5eQyb0CAacABb/siPentjTKPXS7lKvV9b9aufSUgIoz
ARC-Seal: i=1; a=rsa-sha256; t=1521214740; cv=none;
        d=google.com; s=arc-20160816;
        b=DIcs2vr/hxye8XTwdi5d2tx5RkiO1Fh16gYnZ9eP3ID5omPpA4VFwreFOhJLx3BhoJ
         UXQP1EPjXheyi6cjhM34Rus88UpVI3/kVu7zcHObrEI/ieF6Ki4KSNbYJyVssA+D7yo5
         wvr7twzSE3r2+AyJ+uqc+w6ackdptnnqLUDdWbTRTv7J2Gz4HBt7AXb/zHfyfNvp/d5c
         gXovBvCAaVh0+aDuIWWOfvhZ9Fa0wBCVGcSU6P0eTLUh4rT8CBKflfAEvW4bJcNSiPR/
         REiyNrmPWBKAe8voV5jB3kooVOlLjs4uSCE46243DJGfaCqA4AaOL73IH54GqeHamhYO
         0Ttg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=RK1/+JV5WbrWjAMqluuNZw1tGCsnxK2GH5hFCZslYfQ=;
        b=Na01WN1HqyILyW1ito9bWaOkzQzX2ZBjhS3hqD+uJoC1U/lMPcHJCcXsoM/UT9FcXL
         nvIfx19dEAKLosrxoi3ugPl9+6X9+XgynViMEZpymAbGXw40F9m2hj58HLzJQ9n/iQOy
         0goPt50PxEYW4dj1SN6VkN7vg6X9rcoBzZ+ARQgJBjA+20kuhZdhQY5YqXNQpMThUtnu
         uMTEyO/hSRE1pWBX5D13t3pbU2T9aaok9gPJaKW2c8o2oMsOmgc/PMfFroSXYQhoChcE
         eLml5m8DJlLeeuLx2T6kL31bBvpWEqrjZMyBHY3GfhPq2++splGcfveQChfI7lxqtFGH
         CM8w==
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
Subject: [PATCH 4.14 105/109] locking/locktorture: Fix num reader/writer corner cases
Date: Fri, 16 Mar 2018 16:24:14 +0100
Message-Id: <20180316152335.544518276@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109267893386747?=
X-GMAIL-MSGID: =?utf-8?q?1595109267893386747?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
