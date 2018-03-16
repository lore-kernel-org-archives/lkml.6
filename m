Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuK0dizP5pemIGtcDjAtAOrRC+JkmDHnFnU3lrTpbUf0oraL345r55HP3ow7AmjeD/qmF13
ARC-Seal: i=1; a=rsa-sha256; t=1521214211; cv=none;
        d=google.com; s=arc-20160816;
        b=ew0yRN47e6kIVKmEiISd+dGbpnCXZcuQESc9y2p77MHah3C1c/PC4FqeCQLKM6nVRT
         nnbbc4xnPnqeMNEWLWTShi7+GPvYx8xV8ATV1eH8mC+cjbvcRUb3wp4hXu2Cg0LQdGhR
         8aMpBpSYjmamRYalNfMjR0Z5nnvR2xnfv6KScUPiRjebx/jCTB1ZpADwhQaTOYQ4kLcK
         HCFOZVkPGpk0Sn7EdMnD1AuCI6RtVux4HlkZIFoKunwRDiFxZS8mMjKLCyTTS4z2PikX
         FLx14xnexJqDJZHgJPnR86+opRgR22qFG10C0RsgHUBCp0DFM4Aga7D5HpwCW0xKBXDd
         2tlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Ivwxt1zghRRMtPhuRilXfPxiXbcz1KSxY6p08Oe0DHs=;
        b=p5ITdgXeSNKXYhAO5GFcHzXMiUKmtNimrbvR2mRm4RA2s1G1IXp9Qi8C4NeRsHOoId
         e1bAT7woSXeqv8uCvmrmLVt4oRyd9p+bgh6MSoVq2RXaK53fK45lLCRJzCROwB148sod
         gj8pEZNGoTAuHE79BL/hXiiV+1yGYXoglLq7IZgeoILs80eoRGVxXtymKJI7/fv4oUVY
         FEiKWdCJby7LM2XiAFB2nvz6Fq1joydl2r4mf7iQUQyQTjgEcfUUJjCIoUvWBJymopac
         XaHqhInhabLpBhT4cH/ZHJkfiahHThh95pYbNm2cRdZQguIX3mAl/fML7Qjje2sLn0tu
         SRBQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Dave Airlie <airlied@redhat.com>,
	Ben Skeggs <bskeggs@redhat.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Tejun Heo <tj@kernel.org>,
	Lyude Paul <lyude@redhat.com>,
	Lukas Wunner <lukas@wunner.de>
Subject: [PATCH 4.9 07/86] workqueue: Allow retrieval of current tasks work struct
Date: Fri, 16 Mar 2018 16:22:30 +0100
Message-Id: <20180316152317.743198327@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152317.167709497@linuxfoundation.org>
References: <20180316152317.167709497@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108512007687466?=
X-GMAIL-MSGID: =?utf-8?q?1595108712296855348?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lukas Wunner <lukas@wunner.de>

commit 27d4ee03078aba88c5e07dcc4917e8d01d046f38 upstream.

Introduce a helper to retrieve the current task's work struct if it is
a workqueue worker.

This allows us to fix a long-standing deadlock in several DRM drivers
wherein the ->runtime_suspend callback waits for a specific worker to
finish and that worker in turn calls a function which waits for runtime
suspend to finish.  That function is invoked from multiple call sites
and waiting for runtime suspend to finish is the correct thing to do
except if it's executing in the context of the worker.

Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Acked-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Link: https://patchwork.freedesktop.org/patch/msgid/2d8f603074131eb87e588d2b803a71765bd3a2fd.1518338788.git.lukas@wunner.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/workqueue.h |    1 +
 kernel/workqueue.c        |   16 ++++++++++++++++
 2 files changed, 17 insertions(+)

--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -453,6 +453,7 @@ extern bool cancel_delayed_work_sync(str
 
 extern void workqueue_set_max_active(struct workqueue_struct *wq,
 				     int max_active);
+extern struct work_struct *current_work(void);
 extern bool current_is_workqueue_rescuer(void);
 extern bool workqueue_congested(int cpu, struct workqueue_struct *wq);
 extern unsigned int work_busy(struct work_struct *work);
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4130,6 +4130,22 @@ void workqueue_set_max_active(struct wor
 EXPORT_SYMBOL_GPL(workqueue_set_max_active);
 
 /**
+ * current_work - retrieve %current task's work struct
+ *
+ * Determine if %current task is a workqueue worker and what it's working on.
+ * Useful to find out the context that the %current task is running in.
+ *
+ * Return: work struct if %current task is a workqueue worker, %NULL otherwise.
+ */
+struct work_struct *current_work(void)
+{
+	struct worker *worker = current_wq_worker();
+
+	return worker ? worker->current_work : NULL;
+}
+EXPORT_SYMBOL(current_work);
+
+/**
  * current_is_workqueue_rescuer - is %current workqueue rescuer?
  *
  * Determine whether %current is a workqueue rescuer.  Can be used from
