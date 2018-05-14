Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqn0E2HzQOaUdfRXko94y/5oRR3FaD4NlO3dfhJImY9pOG9fR5CDvvbEK6T/CNfAKPQvz9F
ARC-Seal: i=1; a=rsa-sha256; t=1526280990; cv=none;
        d=google.com; s=arc-20160816;
        b=LwSPIzVofM3i8vQJ9fPsorwQ75eHMB/pv//kn0me5Ufoy5hKaH8VYPNjfOFRh3uf+s
         IYrovkoDr25UMSUmofzLQDL/geRbX7HICrk8uOvDoXBYKQdyavnoRgTUXGK/2m7UiSbF
         bWVPf7Fj6ihhR94t7xum3tOoRyJ0h9hA8Y1DBSRGmFm8QYgxYVROxKzpeQ+Xe+CvRdR/
         tfjqD1HbAt6uCsA4pD3JmDP0PS4wHIop0nNzAXpe9DPa6+ZU83XiXqBUMPc7cmhS4gtO
         Df10nGFCTsS6yTg3hZESOcg8pbYAqlOLWalmoFsFwSBK8JG0t5pM4hUDau8Wkneh567e
         5pGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=AJ/NlBD7BrhH8vX2W41BB1PeQEnyZZhFlCgozazL8so=;
        b=b85oVNmn9aUD2Xu7pbPOp0mGgSzwH2sMYbtZzzQVq9aHnZ8lYAD5Y63Wr1qdOtEbds
         Rl+uMtN/NqdgsWFnnqk6FlTnBnPEYCNEoivoTL7zo4f+/rzvXKBWhPxp5wWoz3ifay1F
         FybloqmfrJCc4opT152NQ4El4jiZTViJcwWGnqmMYCbGk/nWXZYi9IOTMQtgGkWm0Cb7
         /lFeozTlPSfPc8Q4q9FxoTIjyqwlAuYc99SrCBR/GK5P8Y76Ti2gjbiir/QVBeNLxoOX
         Pcdhgs+wVff5pYE2Qw6Fw1crJ/jZ44cvct37cZy4uJbcVtfRIZd7s6T887ga3d+NQF69
         3ruQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=uK6JCPro;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=uK6JCPro;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Lyude Paul <lyude@redhat.com>,
	Karol Herbst <kherbst@redhat.com>,
	Ben Skeggs <bskeggs@redhat.com>
Subject: [PATCH 4.14 39/62] drm/nouveau: Fix deadlock in nv50_mstm_register_connector()
Date: Mon, 14 May 2018 08:48:55 +0200
Message-Id: <20180514064818.546191706@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064816.436958006@linuxfoundation.org>
References: <20180514064816.436958006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421616584396678?=
X-GMAIL-MSGID: =?utf-8?q?1600421616584396678?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lyude Paul <lyude@redhat.com>

commit 352672db857290ab5b0e2b6a99c414f92bee024c upstream.

Currently; we're grabbing all of the modesetting locks before adding MST
connectors to fbdev. This isn't actually necessary, and causes a
deadlock as well:

======================================================
WARNING: possible circular locking dependency detected
4.17.0-rc3Lyude-Test+ #1 Tainted: G           O
------------------------------------------------------
kworker/1:0/18 is trying to acquire lock:
00000000c832f62d (&helper->lock){+.+.}, at: drm_fb_helper_add_one_connector+0x2a/0x60 [drm_kms_helper]

but task is already holding lock:
00000000942e28e2 (crtc_ww_class_mutex){+.+.}, at: drm_modeset_backoff+0x8e/0x1c0 [drm]

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #3 (crtc_ww_class_mutex){+.+.}:
       ww_mutex_lock+0x43/0x80
       drm_modeset_lock+0x71/0x130 [drm]
       drm_helper_probe_single_connector_modes+0x7d/0x6b0 [drm_kms_helper]
       drm_setup_crtcs+0x15e/0xc90 [drm_kms_helper]
       __drm_fb_helper_initial_config_and_unlock+0x29/0x480 [drm_kms_helper]
       nouveau_fbcon_init+0x138/0x1a0 [nouveau]
       nouveau_drm_load+0x173/0x7e0 [nouveau]
       drm_dev_register+0x134/0x1c0 [drm]
       drm_get_pci_dev+0x8e/0x160 [drm]
       nouveau_drm_probe+0x1a9/0x230 [nouveau]
       pci_device_probe+0xcd/0x150
       driver_probe_device+0x30b/0x480
       __driver_attach+0xbc/0xe0
       bus_for_each_dev+0x67/0x90
       bus_add_driver+0x164/0x260
       driver_register+0x57/0xc0
       do_one_initcall+0x4d/0x323
       do_init_module+0x5b/0x1f8
       load_module+0x20e5/0x2ac0
       __do_sys_finit_module+0xb7/0xd0
       do_syscall_64+0x60/0x1b0
       entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #2 (crtc_ww_class_acquire){+.+.}:
       drm_helper_probe_single_connector_modes+0x58/0x6b0 [drm_kms_helper]
       drm_setup_crtcs+0x15e/0xc90 [drm_kms_helper]
       __drm_fb_helper_initial_config_and_unlock+0x29/0x480 [drm_kms_helper]
       nouveau_fbcon_init+0x138/0x1a0 [nouveau]
       nouveau_drm_load+0x173/0x7e0 [nouveau]
       drm_dev_register+0x134/0x1c0 [drm]
       drm_get_pci_dev+0x8e/0x160 [drm]
       nouveau_drm_probe+0x1a9/0x230 [nouveau]
       pci_device_probe+0xcd/0x150
       driver_probe_device+0x30b/0x480
       __driver_attach+0xbc/0xe0
       bus_for_each_dev+0x67/0x90
       bus_add_driver+0x164/0x260
       driver_register+0x57/0xc0
       do_one_initcall+0x4d/0x323
       do_init_module+0x5b/0x1f8
       load_module+0x20e5/0x2ac0
       __do_sys_finit_module+0xb7/0xd0
       do_syscall_64+0x60/0x1b0
       entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #1 (&dev->mode_config.mutex){+.+.}:
       drm_setup_crtcs+0x10c/0xc90 [drm_kms_helper]
       __drm_fb_helper_initial_config_and_unlock+0x29/0x480 [drm_kms_helper]
       nouveau_fbcon_init+0x138/0x1a0 [nouveau]
       nouveau_drm_load+0x173/0x7e0 [nouveau]
       drm_dev_register+0x134/0x1c0 [drm]
       drm_get_pci_dev+0x8e/0x160 [drm]
       nouveau_drm_probe+0x1a9/0x230 [nouveau]
       pci_device_probe+0xcd/0x150
       driver_probe_device+0x30b/0x480
       __driver_attach+0xbc/0xe0
       bus_for_each_dev+0x67/0x90
       bus_add_driver+0x164/0x260
       driver_register+0x57/0xc0
       do_one_initcall+0x4d/0x323
       do_init_module+0x5b/0x1f8
       load_module+0x20e5/0x2ac0
       __do_sys_finit_module+0xb7/0xd0
       do_syscall_64+0x60/0x1b0
       entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #0 (&helper->lock){+.+.}:
       __mutex_lock+0x70/0x9d0
       drm_fb_helper_add_one_connector+0x2a/0x60 [drm_kms_helper]
       nv50_mstm_register_connector+0x2c/0x50 [nouveau]
       drm_dp_add_port+0x2f5/0x420 [drm_kms_helper]
       drm_dp_send_link_address+0x155/0x1e0 [drm_kms_helper]
       drm_dp_add_port+0x33f/0x420 [drm_kms_helper]
       drm_dp_send_link_address+0x155/0x1e0 [drm_kms_helper]
       drm_dp_check_and_send_link_address+0x87/0xd0 [drm_kms_helper]
       drm_dp_mst_link_probe_work+0x4d/0x80 [drm_kms_helper]
       process_one_work+0x20d/0x650
       worker_thread+0x3a/0x390
       kthread+0x11e/0x140
       ret_from_fork+0x3a/0x50

other info that might help us debug this:
Chain exists of:
  &helper->lock --> crtc_ww_class_acquire --> crtc_ww_class_mutex
 Possible unsafe locking scenario:
       CPU0                    CPU1
       ----                    ----
  lock(crtc_ww_class_mutex);
                               lock(crtc_ww_class_acquire);
                               lock(crtc_ww_class_mutex);
  lock(&helper->lock);

 *** DEADLOCK ***
5 locks held by kworker/1:0/18:
 #0: 000000004a05cd50 ((wq_completion)"events_long"){+.+.}, at: process_one_work+0x187/0x650
 #1: 00000000601c11d1 ((work_completion)(&mgr->work)){+.+.}, at: process_one_work+0x187/0x650
 #2: 00000000586ca0df (&dev->mode_config.mutex){+.+.}, at: drm_modeset_lock_all+0x3a/0x1b0 [drm]
 #3: 00000000d3ca0ffa (crtc_ww_class_acquire){+.+.}, at: drm_modeset_lock_all+0x44/0x1b0 [drm]
 #4: 00000000942e28e2 (crtc_ww_class_mutex){+.+.}, at: drm_modeset_backoff+0x8e/0x1c0 [drm]

stack backtrace:
CPU: 1 PID: 18 Comm: kworker/1:0 Tainted: G           O      4.17.0-rc3Lyude-Test+ #1
Hardware name: Gateway FX6840/FX6840, BIOS P01-A3         05/17/2010
Workqueue: events_long drm_dp_mst_link_probe_work [drm_kms_helper]
Call Trace:
 dump_stack+0x85/0xcb
 print_circular_bug.isra.38+0x1ce/0x1db
 __lock_acquire+0x128f/0x1350
 ? lock_acquire+0x9f/0x200
 ? lock_acquire+0x9f/0x200
 ? __ww_mutex_lock.constprop.13+0x8f/0x1000
 lock_acquire+0x9f/0x200
 ? drm_fb_helper_add_one_connector+0x2a/0x60 [drm_kms_helper]
 ? drm_fb_helper_add_one_connector+0x2a/0x60 [drm_kms_helper]
 __mutex_lock+0x70/0x9d0
 ? drm_fb_helper_add_one_connector+0x2a/0x60 [drm_kms_helper]
 ? ww_mutex_lock+0x43/0x80
 ? _cond_resched+0x15/0x30
 ? ww_mutex_lock+0x43/0x80
 ? drm_modeset_lock+0xb2/0x130 [drm]
 ? drm_fb_helper_add_one_connector+0x2a/0x60 [drm_kms_helper]
 drm_fb_helper_add_one_connector+0x2a/0x60 [drm_kms_helper]
 nv50_mstm_register_connector+0x2c/0x50 [nouveau]
 drm_dp_add_port+0x2f5/0x420 [drm_kms_helper]
 ? mark_held_locks+0x50/0x80
 ? kfree+0xcf/0x2a0
 ? drm_dp_check_mstb_guid+0xd6/0x120 [drm_kms_helper]
 ? trace_hardirqs_on_caller+0xed/0x180
 ? drm_dp_check_mstb_guid+0xd6/0x120 [drm_kms_helper]
 drm_dp_send_link_address+0x155/0x1e0 [drm_kms_helper]
 drm_dp_add_port+0x33f/0x420 [drm_kms_helper]
 ? nouveau_connector_aux_xfer+0x7c/0xb0 [nouveau]
 ? find_held_lock+0x2d/0x90
 ? drm_dp_dpcd_access+0xd9/0xf0 [drm_kms_helper]
 ? __mutex_unlock_slowpath+0x3b/0x280
 ? drm_dp_dpcd_access+0xd9/0xf0 [drm_kms_helper]
 drm_dp_send_link_address+0x155/0x1e0 [drm_kms_helper]
 drm_dp_check_and_send_link_address+0x87/0xd0 [drm_kms_helper]
 drm_dp_mst_link_probe_work+0x4d/0x80 [drm_kms_helper]
 process_one_work+0x20d/0x650
 worker_thread+0x3a/0x390
 ? process_one_work+0x650/0x650
 kthread+0x11e/0x140
 ? kthread_create_worker_on_cpu+0x50/0x50
 ret_from_fork+0x3a/0x50

Taking example from i915, the only time we need to hold any modesetting
locks is when changing the port on the mstc, and in that case we only
need to hold the connection mutex.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Karol Herbst <kherbst@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/nouveau/nv50_display.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- a/drivers/gpu/drm/nouveau/nv50_display.c
+++ b/drivers/gpu/drm/nouveau/nv50_display.c
@@ -3216,10 +3216,11 @@ nv50_mstm_destroy_connector(struct drm_d
 
 	drm_connector_unregister(&mstc->connector);
 
-	drm_modeset_lock_all(drm->dev);
 	drm_fb_helper_remove_one_connector(&drm->fbcon->helper, &mstc->connector);
+
+	drm_modeset_lock(&drm->dev->mode_config.connection_mutex, NULL);
 	mstc->port = NULL;
-	drm_modeset_unlock_all(drm->dev);
+	drm_modeset_unlock(&drm->dev->mode_config.connection_mutex);
 
 	drm_connector_unreference(&mstc->connector);
 }
@@ -3229,9 +3230,7 @@ nv50_mstm_register_connector(struct drm_
 {
 	struct nouveau_drm *drm = nouveau_drm(connector->dev);
 
-	drm_modeset_lock_all(drm->dev);
 	drm_fb_helper_add_one_connector(&drm->fbcon->helper, connector);
-	drm_modeset_unlock_all(drm->dev);
 
 	drm_connector_register(connector);
 }
