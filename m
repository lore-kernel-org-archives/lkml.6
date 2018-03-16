Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELskrIejojSf8F59cwIn/XLmKA9GpW5rqjenuuJenICn0h87oUKgysNWxOeMWECH1jN3W8bn
ARC-Seal: i=1; a=rsa-sha256; t=1521214313; cv=none;
        d=google.com; s=arc-20160816;
        b=s+KBsgeM73yQJvckTDQYGgJIRUQ3iitT26qajkpt7NVI1PuioMJBT5Zvlt89GkMcLu
         /bf9AsfFGTWDm8okMQtzb8IGdtRZhfkc4Ih/AjHqQQMTyqzQkQnbSv9Rpvq2rXMK6Ckm
         6jj/449YO8ifFFYzCrM6Khak4tvjXYsb5GCHME0VEv64/EgwcJJDoqnk6xxcyhkI1akW
         MyOVmAc64t94TVOz9CgMV9ywv+ivu4letDqnQb4lByWfbs7wMqF71n0UzjKJ7MleNP1Y
         VOH23xU/IRLvZ6puiobRwhoyPLwojxFVbVn8VD4X4ZtspGupAGZ7noaeA10/rYoRiXAy
         c2IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=MKW3pRKmhzZ9moZYskI9+/i3AoPaYCtLau4CnF6x3Lo=;
        b=lNxIGxVVpoY590edgUsGUOyJkzpZpZYBnZHEX+hMqLKoGjt4fuoAX6ClaTYVY3jPNg
         fd9C9EqEWK4GFMJHeEqsDyR4jB4T99OEhq39qpMlcfrynQTOLtgprd5bEbnDr237yVtC
         LzYacwRNZVgj0nAxDK9vUKBaOHEeMLqxnW3eNp3GtpI9uo31bFAlkTIzr39bCu29hoEB
         dLfwuIzAWeO/rpC8ttV6XAu9QmPffITtE0d1L0tV4OUSXmm+vph12N5fs/U5MXmg+6xU
         TVGMl623AVJxp692X/ZSA5kp4BiCB1ihUFTdt9BglUUthCf/6214GpSfX0eyisMIalrx
         gs7Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dave Airlie <airlied@redhat.com>,
	Ben Skeggs <bskeggs@redhat.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Lyude Paul <lyude@redhat.com>,
	Lukas Wunner <lukas@wunner.de>
Subject: [PATCH 4.9 08/86] drm: Allow determining if current task is output poll worker
Date: Fri, 16 Mar 2018 16:22:31 +0100
Message-Id: <20180316152317.837266563@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152317.167709497@linuxfoundation.org>
References: <20180316152317.167709497@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108514671263314?=
X-GMAIL-MSGID: =?utf-8?q?1595108820506428293?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -461,6 +461,26 @@ out:
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
@@ -74,5 +74,6 @@ extern void drm_kms_helper_hotplug_event
 extern void drm_kms_helper_poll_disable(struct drm_device *dev);
 extern void drm_kms_helper_poll_enable(struct drm_device *dev);
 extern void drm_kms_helper_poll_enable_locked(struct drm_device *dev);
+extern bool drm_kms_helper_is_poll_worker(void);
 
 #endif
