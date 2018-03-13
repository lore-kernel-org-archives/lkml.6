Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsGIh5h6IGqUWsafo7tBMlR8BIe1mAdfIxGjK9Lqq6hQCHKvRt5ICZTbMH3yxtDKNwNs2bF
ARC-Seal: i=1; a=rsa-sha256; t=1520954981; cv=none;
        d=google.com; s=arc-20160816;
        b=ErwlnvYF+UhAxHwemDTcsvZlXwalyhAThLGR6bpz2LzuGq4cVGX1XfD/TZLOzNl2Ki
         kQp9eProFPfqBWtRpMrI4fF6vivakHBR4ndxz+Eab1VjobxvUqs3fzhLpQGcizWVo1Zo
         +IyH92xBOsUOt6Dqa5VzBsjUr0OGpaVDuAgEjR+BPmTOt4GEJALGwMMUf9oHGKCchIN6
         aO8lbGdaXHwe3A74RnrH1ep7QAHSg/COrCp+2UfoQa2EYLLSYNh0BKaLVccAQ4MD/hFE
         KfwubQGZiMGvKWdmVbOZQTSPY+J2DdVVk2Vsekn4KVsOqlim4l4rQYaCBKRaarJS+tNg
         vnAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=J8xndn30T169Fw55rPaqi2ZFr29aC08rQrqHpqiuRGU=;
        b=hfUs4yq+H5XxdYF2IonaDvg553ZcRrW7cslNUQkISa7+w30BZuNQKAazMKy3uKB0ZD
         wNZOUCSlVkAilboZy9CCo45a7e0/3/q64N/lMzAVNeaRML8yebZTnxOSiA3lWPqFNrnw
         XYilySUtIxpNW4ntct6z3gkKudXTQ+w0t+y9qjZIgvWIOtx0u0GVgaYlLoThS6hXuhQL
         Km9FJqxi3mYNIFN80kRuqGyEqlHKZnh5CFlpdG4s7aBVmXMsBZj2pZ5xFej5HcOR69xg
         wNrFH/Rvb7903L6N4HOJj4usyrOmEaCYTEFA32sYRNqrrRTqIxlOusNZtbQArqK+QOsF
         eQ5Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dave Airlie <airlied@redhat.com>,
	Ben Skeggs <bskeggs@redhat.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Lyude Paul <lyude@redhat.com>,
	Lukas Wunner <lukas@wunner.de>
Subject: [PATCH 4.15 021/146] drm: Allow determining if current task is output poll worker
Date: Tue, 13 Mar 2018 16:23:08 +0100
Message-Id: <20180313152322.128669301@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836890653561030?=
X-GMAIL-MSGID: =?utf-8?q?1594836890653561030?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lukas Wunner <lukas@wunner.de>

commit 25c058ccaf2ebbc3e250ec1e199e161f91fe27d4 upstream.

Introduce a helper to determine if the current task is an output poll
worker.

This allows us to fix a long-standing deadlock in several DRM drivers
wherein the ->runtime_suspend callback waits for the output poll worker
to finish and the worker in turn calls a ->detect callback which waits
for runtime suspend to finish.  The ->detect callback is invoked from
multiple call sites and waiting for runtime suspend to finish is the
correct thing to do except if it's executing in the context of the
worker.

v2: Expand kerneldoc to specifically mention deadlock between
    output poll worker and autosuspend worker as use case. (Lyude)

Cc: Dave Airlie <airlied@redhat.com>
Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Link: https://patchwork.freedesktop.org/patch/msgid/3549ce32e7f1467102e70d3e9cbf70c46bfe108e.1518593424.git.lukas@wunner.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/drm_probe_helper.c |   20 ++++++++++++++++++++
 include/drm/drm_crtc_helper.h      |    1 +
 2 files changed, 21 insertions(+)

--- a/drivers/gpu/drm/drm_probe_helper.c
+++ b/drivers/gpu/drm/drm_probe_helper.c
@@ -655,6 +655,26 @@ out:
 }
 
 /**
+ * drm_kms_helper_is_poll_worker - is %current task an output poll worker?
+ *
+ * Determine if %current task is an output poll worker.  This can be used
+ * to select distinct code paths for output polling versus other contexts.
+ *
+ * One use case is to avoid a deadlock between the output poll worker and
+ * the autosuspend worker wherein the latter waits for polling to finish
+ * upon calling drm_kms_helper_poll_disable(), while the former waits for
+ * runtime suspend to finish upon calling pm_runtime_get_sync() in a
+ * connector ->detect hook.
+ */
+bool drm_kms_helper_is_poll_worker(void)
+{
+	struct work_struct *work = current_work();
+
+	return work && work->func == output_poll_execute;
+}
+EXPORT_SYMBOL(drm_kms_helper_is_poll_worker);
+
+/**
  * drm_kms_helper_poll_disable - disable output polling
  * @dev: drm_device
  *
--- a/include/drm/drm_crtc_helper.h
+++ b/include/drm/drm_crtc_helper.h
@@ -77,5 +77,6 @@ void drm_kms_helper_hotplug_event(struct
 
 void drm_kms_helper_poll_disable(struct drm_device *dev);
 void drm_kms_helper_poll_enable(struct drm_device *dev);
+bool drm_kms_helper_is_poll_worker(void);
 
 #endif
