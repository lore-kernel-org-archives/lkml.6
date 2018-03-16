Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3555996-1521221655-2-12113369374670199785
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521221655; b=gGcdsN2P554fRFWzk2yt2nJiJl68OOg5cVghbDvRWGS1AnZ
    LSlZzKcdZ353Twh37XuJg0ATKYGfNxx8qDlGz83DlaFhfFvrtv8v7X5o+R2iGtJ3
    MT1eokfg0vm8vdwUaGyN9W3cp3I8IBzC19avvpaFIsMyrcuVj4mbSxK80z9sK7Lj
    75G07ojF9rsYrEBQn/gwEkh8HHNnDZQ4v6XHAbUF3/RYPuTTuVp2DSgtaDm6OnFi
    OoN/vn6Se5x9YFK/2gk3R96CYHztkSKSiX0W/u8CzD1fAESKTVF9vdBHKCTqLi85
    YbquIY38sp2iN0t0afvOYQ55YIVNfcUYZlSX2/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521221655; bh=9BRRftUBwGohHRVitxJOMlfZvG
    9FuMs5UazMTI9W0fk=; b=JU5dru5Nun3zvLIF8elynVnKTCHxAC2TR7F6T6pIpe
    7qcSWWNwa3itBxYMNAMuorDwcdj1+uO5TkIqhvEfBjpKeZNTMP42LXC5j4gSQEDT
    LqyTeFHecArFvC9okeZP6B1cicPLOcL0GDbPjoWkxqRxFL3OOYSgIpOyFQqvljwe
    oMZF/jj6mj/qpFON+MUIlusZXCPfulhKDvR5APbRk/eVm982qOnYs4CdHUxaT4on
    5fP/TFTSBYg7Pkjj5AZzXeNec0n3YFAzKh0/f/Z+edvH+zJhUceI/mZuOxNjvu7C
    xfTt5SsQINe+BexrgeERyqMW70tT3ASRLIvjBv99o5LQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754074AbeCPP1J (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 11:27:09 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34058 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754171AbeCPP1F (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 11:27:05 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        Dave Airlie <airlied@redhat.com>,
        Lyude Paul <lyude@redhat.com>, Lukas Wunner <lukas@wunner.de>
Subject: [PATCH 4.4 07/63] drm/nouveau: Fix deadlock on runtime suspend
Date: Fri, 16 Mar 2018 16:22:39 +0100
Message-Id: <20180316152300.834950626@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152259.964532775@linuxfoundation.org>
References: <20180316152259.964532775@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -253,9 +253,15 @@ nouveau_connector_detect(struct drm_conn
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
@@ -323,8 +329,10 @@ detect_analog:
 
  out:
 
-	pm_runtime_mark_last_busy(connector->dev->dev);
-	pm_runtime_put_autosuspend(connector->dev->dev);
+	if (!drm_kms_helper_is_poll_worker()) {
+		pm_runtime_mark_last_busy(connector->dev->dev);
+		pm_runtime_put_autosuspend(connector->dev->dev);
+	}
 
 	return conn_status;
 }
