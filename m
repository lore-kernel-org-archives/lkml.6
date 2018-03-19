Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELu5j1hjTMaad0aVZLYJ5qfYL85Lw6t/HMtidbge6AF/X7szUQY7h+GVcaLBTVQlkACZCoEL
ARC-Seal: i=1; a=rsa-sha256; t=1521484039; cv=none;
        d=google.com; s=arc-20160816;
        b=zgyXBf/hSx3IknLiIkZ6K8iCEwTcz5+XTfatEYDxgZtqcsa7DWCKlGm1RJ4SFyq9m1
         cUBcZ5ymixi0VKAaHvg34oUHRMPy5hQHXFnokDk5dTG1neXrlMbfagZP7cjpCv9kqRZ3
         f9KWDTO8MqFqChoA4TQOUU5LvGig/xSaLA2GX1Dp/WmGeTZd+hT+6XVAn9oQq+CLmHM6
         lXeOUGim5zaiDnQOZZ+k744yScd8h0/qfMjQ9UZcMl+oB0/MuepJpsFoqQllNJxX2+LN
         6v0Ip/uNroVQt9FMf3WBZ9lrkn5q4PvEUEzMGnVxjAmGuBTFpepsI/wIelSQ4EsqS4/F
         I2jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=UkllVlj4W2rNJTkJ3Fyz/4uKq1nhxfnd8G4xtOaPo6I=;
        b=rZtip5pZ1txHnAAMyLZ6Y5D2eFyj+Qq0j5teU92vnahUG7jBObJUAhFRwouD1a90St
         Tw5DFP6CpG5Lwor6e3UtZsReRe7h0kOyiMQddVHRBciLFwX9HbeEdukDChfdjVlD84S1
         FZOWgL3KKxpdYjBjvNJOlCUFUqYhmvUNIDE2r2E6JIYPI6KJRFB0772W7Hx5+t0G2RKe
         aecPcyCuEHxg0ajRYOMCoPD06Zq+a1L8xzaY7iCLxSHzULdjPH28q5CajbbphAq5gu/G
         o5TjvV9hWvbTDfkn/nn0wwzm8e8NFzYZvVNHievhl0H1eUJ/6zBzaZmbNK34z92iUzCV
         F0wg==
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
Subject: [PATCH 4.9 208/241] locking/locktorture: Fix num reader/writer corner cases
Date: Mon, 19 Mar 2018 19:07:53 +0100
Message-Id: <20180319180759.791828630@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391647974872494?=
X-GMAIL-MSGID: =?utf-8?q?1595391647974872494?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -641,8 +641,7 @@ static void __torture_print_stats(char *
 {
 	bool fail = 0;
 	int i, n_stress;
-	long max = 0;
-	long min = statp[0].n_lock_acquired;
+	long max = 0, min = statp ? statp[0].n_lock_acquired : 0;
 	long long sum = 0;
 
 	n_stress = write ? cxt.nrealwriters_stress : cxt.nrealreaders_stress;
@@ -749,7 +748,7 @@ static void lock_torture_cleanup(void)
 	 * such, only perform the underlying torture-specific cleanups,
 	 * and avoid anything related to locktorture.
 	 */
-	if (!cxt.lwsa)
+	if (!cxt.lwsa && !cxt.lrsa)
 		goto end;
 
 	if (writer_tasks) {
@@ -823,6 +822,13 @@ static int __init lock_torture_init(void
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
 
@@ -846,17 +852,19 @@ static int __init lock_torture_init(void
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
@@ -873,19 +881,21 @@ static int __init lock_torture_init(void
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
 
@@ -915,12 +925,14 @@ static int __init lock_torture_init(void
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
