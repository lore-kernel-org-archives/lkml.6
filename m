Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3555996-1521221718-2-1626063551768623138
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
    t=1521221717; b=G0EA4ya51Ei7GdpfFT5erQHko312TUZu765NsqGlJLBoaNH
    JB/e446NjX8KppSrCV5USbJNpvX5qz+0b9X/Loodx/jyH13MU/FhtnweDZwoFnYI
    gaa7oULWLpIrmDqftZmAU6ROwE+ZRRPSAEfjtdtSt5qVpcYZSKI4T1R0Jx0pB8q1
    1cZt0GDfiiQBftJurOtAhdySV3cAp5CXZSxRnCudEOfhpWNRjjsBkhr2VMS9o0Y2
    FKUCfPVfM6AGFCButXsWcy1anW3oVCMp9BOn1jfr4qWrm8oQh1ORg2SjENHb8XcP
    i4Gr+C68Jr49NgqQyHerjkxZ6t7QS/UGIlikkvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521221717; bh=kkVYLl3ybmgwHvzrGsYeGhrKAJ
    /7oQXiTCVgMLYtNtk=; b=o2DNN7tryAKUpmAwlsPDplEKJ0pITGEhPUglPKU28u
    IICuZtlAlEId8avzTiPAWjc7jG8w1w4JnIq6Y9rnw/swXE4Caa+Pf71wV42xJGC2
    8zT97y9fNXRGqhLYkPf234a22CzVmDhbjy2MUxZudPwon+tMpJbOsjxQG69vjEXd
    zU+ptsfZToyMFU4fSRa85pTox17GIn6DjH0ksAJ75y5FaSmi0pjro5I22EP6HST8
    6LvpdBSBq5d7avvK4N02DEi7yJq9ShBjwQbxwn6I6RBQRrPTBnuvij5xVsGq88Ss
    7RCNM8JaDnM/RgQZbKV08eIPYv18W+xF419Z+1Lgfn5A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
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
        id S1753033AbeCPRej (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 13:34:39 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34050 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754188AbeCPP1C (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 11:27:02 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dave Airlie <airlied@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Lyude Paul <lyude@redhat.com>, Lukas Wunner <lukas@wunner.de>
Subject: [PATCH 4.4 06/63] drm: Allow determining if current task is output poll worker
Date: Fri, 16 Mar 2018 16:22:38 +0100
Message-Id: <20180316152300.761879094@linuxfoundation.org>
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
@@ -412,6 +412,26 @@ out:
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
@@ -241,5 +241,6 @@ extern void drm_kms_helper_hotplug_event
 extern void drm_kms_helper_poll_disable(struct drm_device *dev);
 extern void drm_kms_helper_poll_enable(struct drm_device *dev);
 extern void drm_kms_helper_poll_enable_locked(struct drm_device *dev);
+extern bool drm_kms_helper_is_poll_worker(void);
 
 #endif
