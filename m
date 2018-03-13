Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvqN3dol3DeRulFKJ+DBX7+aVcUPS45SYDXRmGUvKmXsM+3GFyH+6YXWqq8bIR0AlKNhOYP
ARC-Seal: i=1; a=rsa-sha256; t=1520955471; cv=none;
        d=google.com; s=arc-20160816;
        b=r2LjN6atee9CyFUxBwmoUJx1VGPE1YyPPOPym46nIYmb0G5AgHXUT3WE1W5jBAdX+U
         4sIChWkHLmjHKuiK4Ik48aG4eUlQHsYOWmAjLCSzqbYxjZnNEbktdCXBvRdJpvjbxvN+
         SUKJO96Hs3ildXAp03Dh/8nQpmNCpwO/4g0/b21YxzqgpjBa5xwROxHs2as0l5VL27wa
         AiG25kjDRqna9/iE3PYEO9/qmLNKjgwJJUuMDwKawB6IeXfFoJUim7W5AsSxYgmObVSB
         WseML/yn/cGUN32HkhhI8IOid6DMqabqofFiXbOslhxmrxeqyImwlXPmePe9oAxaSPXt
         cbHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=bM3GaZ7VSa/FzsUZHn0BZJF0lyaWluLvvFw3hLthyoA=;
        b=cffDuSSk2M6RbIx3cBjAOlH5TipSflGXvQck73OI22GxO8fqyyrgi1jF9bvgyh/53P
         8G1P3+Q0SR9xSaunP7OJqgd8XbONoWTfNRtqrAcmv+IfH9GFk8120Un5Bd1EcI+0VJLZ
         3d+LR+siklnt4cCjL2/0RcqSA612GR53WjnPJ0dOPubEOqXYgESZuah4HBb6D0qZTFvy
         kJ3ezuXrpUacHDfIxy8sMobSmwSUWaYtr9LbcxlCj7HzRM/FJQBaaY/4OUsLi/F+Enpw
         8xdOPRBApdWa4Yi1jiN9F3bCIv4caqECssjZzuG6qi1Tye15w8PB0UHLmaM1CQmpQhLp
         PbNg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
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
Subject: [PATCH 4.14 061/140] workqueue: Allow retrieval of current tasks work struct
Date: Tue, 13 Mar 2018 16:24:24 +0100
Message-Id: <20180313152502.336736048@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836888072547754?=
X-GMAIL-MSGID: =?utf-8?q?1594837404337342477?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -467,6 +467,7 @@ extern bool cancel_delayed_work_sync(str
 
 extern void workqueue_set_max_active(struct workqueue_struct *wq,
 				     int max_active);
+extern struct work_struct *current_work(void);
 extern bool current_is_workqueue_rescuer(void);
 extern bool workqueue_congested(int cpu, struct workqueue_struct *wq);
 extern unsigned int work_busy(struct work_struct *work);
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4185,6 +4185,22 @@ void workqueue_set_max_active(struct wor
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
