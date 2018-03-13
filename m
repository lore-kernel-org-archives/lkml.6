Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtnCa+g1M6QY7Pl2RL1QBij50EGRoMFdBKlrb8Q1uHOGPLzY3IiEcsflHQVWdOKBvbcb150
ARC-Seal: i=1; a=rsa-sha256; t=1520954901; cv=none;
        d=google.com; s=arc-20160816;
        b=WHUZ///HP0kWEtp30wHpIwgA538+5kciQHJVTfASUF9bSiEOjy3GOixXfRnOC8xlGb
         hyJDbrxNLHTlblTjovKZxPWdYuMWiG4mRnoU6vGQFa8VFFtRGih0s6Kn9vAdZNWwByWh
         1rD2tCsRf8y/S2taducgk91xL0sTpA/0vevUjC9hvPHnVvPJQ6xSgX61dUS6DGnzz5Rh
         We9TFhyZt4E7SZ3IimpBr222CtQRQy40g2WBsd2fyTT6sYRMe7I+EVRPFi2H6lUlHUwK
         g9w6/xjP96fVHDq6LhDsyu1ryLZPKiGKigBPL6JVMnC1WdGC341CQwjvxFp2fa/Tm17F
         tjyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ka1a3G0iiWPntO9vqldZTs8vlOumgcDMig3q6ogtLLQ=;
        b=gLeWgEg9IojGG3JqXFL0xZJFdTa3K50hGj3PUM6bCCT0rpbU0cA7n0ZQk7P+5ojRuL
         Nppv4usLqNYVDB1cSRL1rKsWw7YlDDp87Ags31DCLYTIBnbDijB8xjbHk3elSftDByNC
         T3+bdSv2Sdwx4lyW/gvU42h8T2P+PWiV2ZRLAur5R5pNUUBlugzgHWYermBjghWvFDPl
         b4cueNPy40xqESXtgxpHHepQ9zjBh4HgPBzeaud7gIig7v0MjwQ6NulweydaHwT4W3Bi
         i4YsI8CrpcXnppILO4Y+/QPGrGooLsQuel1RNT1ZAhShuU+SZq49t1hce7LUR2MqtwWR
         K6rA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ben Skeggs <bskeggs@redhat.com>,
	Dave Airlie <airlied@redhat.com>,
	Lyude Paul <lyude@redhat.com>,
	Lukas Wunner <lukas@wunner.de>
Subject: [PATCH 4.15 022/146] drm/nouveau: Fix deadlock on runtime suspend
Date: Tue, 13 Mar 2018 16:23:09 +0100
Message-Id: <20180313152322.199943463@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836807146444009?=
X-GMAIL-MSGID: =?utf-8?q?1594836807146444009?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lukas Wunner <lukas@wunner.de>

commit d61a5c1063515e855bedb1b81e20e50b0ac3541e upstream.

nouveau's ->runtime_suspend hook calls drm_kms_helper_poll_disable(),
which waits for the output poll worker to finish if it's running.

The output poll worker meanwhile calls pm_runtime_get_sync() in
nouveau_connector_detect() which waits for the ongoing suspend to finish,
causing a deadlock.

Fix by not acquiring a runtime PM ref if nouveau_connector_detect() is
called in the output poll worker's context.  This is safe because
the poll worker is only enabled while runtime active and we know that
->runtime_suspend waits for it to finish.

Other contexts calling nouveau_connector_detect() do require a runtime
PM ref, these comprise:

  status_store() drm sysfs interface
  ->fill_modes drm callback
  drm_fb_helper_probe_connector_modes()
  drm_mode_getconnector()
  nouveau_connector_hotplug()
  nouveau_display_hpd_work()
  nv17_tv_set_property()

Stack trace for posterity:

  INFO: task kworker/0:1:58 blocked for more than 120 seconds.
  Workqueue: events output_poll_execute [drm_kms_helper]
  Call Trace:
   schedule+0x28/0x80
   rpm_resume+0x107/0x6e0
   __pm_runtime_resume+0x47/0x70
   nouveau_connector_detect+0x7e/0x4a0 [nouveau]
   nouveau_connector_detect_lvds+0x132/0x180 [nouveau]
   drm_helper_probe_detect_ctx+0x85/0xd0 [drm_kms_helper]
   output_poll_execute+0x11e/0x1c0 [drm_kms_helper]
   process_one_work+0x184/0x380
   worker_thread+0x2e/0x390

  INFO: task kworker/0:2:252 blocked for more than 120 seconds.
  Workqueue: pm pm_runtime_work
  Call Trace:
   schedule+0x28/0x80
   schedule_timeout+0x1e3/0x370
   wait_for_completion+0x123/0x190
   flush_work+0x142/0x1c0
   nouveau_pmops_runtime_suspend+0x7e/0xd0 [nouveau]
   pci_pm_runtime_suspend+0x5c/0x180
   vga_switcheroo_runtime_suspend+0x1e/0xa0
   __rpm_callback+0xc1/0x200
   rpm_callback+0x1f/0x70
   rpm_suspend+0x13c/0x640
   pm_runtime_work+0x6e/0x90
   process_one_work+0x184/0x380
   worker_thread+0x2e/0x390

Bugzilla: https://bugs.archlinux.org/task/53497
Bugzilla: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=870523
Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=70388#c33
Fixes: 5addcf0a5f0f ("nouveau: add runtime PM support (v0.9)")
Cc: stable@vger.kernel.org # v3.12+: 27d4ee03078a: workqueue: Allow retrieval of current task's work struct
Cc: stable@vger.kernel.org # v3.12+: 25c058ccaf2e: drm: Allow determining if current task is output poll worker
Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: Dave Airlie <airlied@redhat.com>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Link: https://patchwork.freedesktop.org/patch/msgid/b7d2cbb609a80f59ccabfdf479b9d5907c603ea1.1518338789.git.lukas@wunner.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/nouveau/nouveau_connector.c |   18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -570,9 +570,15 @@ nouveau_connector_detect(struct drm_conn
 		nv_connector->edid = NULL;
 	}
 
-	ret = pm_runtime_get_sync(connector->dev->dev);
-	if (ret < 0 && ret != -EACCES)
-		return conn_status;
+	/* Outputs are only polled while runtime active, so acquiring a
+	 * runtime PM ref here is unnecessary (and would deadlock upon
+	 * runtime suspend because it waits for polling to finish).
+	 */
+	if (!drm_kms_helper_is_poll_worker()) {
+		ret = pm_runtime_get_sync(connector->dev->dev);
+		if (ret < 0 && ret != -EACCES)
+			return conn_status;
+	}
 
 	nv_encoder = nouveau_connector_ddc_detect(connector);
 	if (nv_encoder && (i2c = nv_encoder->i2c) != NULL) {
@@ -647,8 +653,10 @@ detect_analog:
 
  out:
 
-	pm_runtime_mark_last_busy(connector->dev->dev);
-	pm_runtime_put_autosuspend(connector->dev->dev);
+	if (!drm_kms_helper_is_poll_worker()) {
+		pm_runtime_mark_last_busy(connector->dev->dev);
+		pm_runtime_put_autosuspend(connector->dev->dev);
+	}
 
 	return conn_status;
 }
