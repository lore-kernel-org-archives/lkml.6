Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66320ECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 222CD20836
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:14:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 222CD20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbeI0PcM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:32:12 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55556 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728669AbeI0PcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:32:11 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D9AAC111D;
        Thu, 27 Sep 2018 09:14:54 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lyude Paul <lyude@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Lukas Wunner <lukas@wunner.de>, Ben Skeggs <bskeggs@redhat.com>
Subject: [PATCH 4.18 64/88] drm/nouveau: Remove duplicate poll_enable() in pmops_runtime_suspend()
Date:   Thu, 27 Sep 2018 11:03:45 +0200
Message-Id: <20180927090308.501518597@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180927090300.631426620@linuxfoundation.org>
References: <20180927090300.631426620@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lyude Paul <lyude@redhat.com>

commit 611ce855420a6e8b9ff47af5f47431d52c7709f8 upstream.

Since actual hotplug notifications don't get disabled until
nouveau_display_fini() is called, all this will do is cause any hotplugs
that happen between this drm_kms_helper_poll_disable() call and the
actual hotplug disablement to potentially be dropped if ACPI isn't
around to help us.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Acked-by: Karol Herbst <kherbst@redhat.com>
Acked-by: Daniel Vetter <daniel@ffwll.ch>
Cc: stable@vger.kernel.org
Cc: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/nouveau/nouveau_drm.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -835,7 +835,6 @@ nouveau_pmops_runtime_suspend(struct dev
 		return -EBUSY;
 	}
 
-	drm_kms_helper_poll_disable(drm_dev);
 	nouveau_switcheroo_optimus_dsm();
 	ret = nouveau_do_suspend(drm_dev, true);
 	pci_save_state(pdev);


