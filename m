Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CAF5C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18B5A20894
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:01:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18B5A20894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388838AbeG0LW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:22:58 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34200 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730120AbeG0LW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:22:57 -0400
Received: from localhost (unknown [89.188.5.116])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 70A3ACB8;
        Fri, 27 Jul 2018 10:01:47 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lyude Paul <lyude@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>
Subject: [PATCH 4.14 06/48] drm/nouveau/drm/nouveau: Fix runtime PM leak in nv50_disp_atomic_commit()
Date:   Fri, 27 Jul 2018 11:59:51 +0200
Message-Id: <20180727095919.177276521@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727095918.503549522@linuxfoundation.org>
References: <20180727095918.503549522@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lyude Paul <lyude@redhat.com>

commit e5d54f1935722f83df7619f3978f774c2b802cd8 upstream.

A CRTC being enabled doesn't mean it's on! It doesn't even necessarily
mean it's being used. This fixes runtime PM leaks on the P50 I've got
next to me.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 drivers/gpu/drm/nouveau/nv50_display.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/nouveau/nv50_display.c
+++ b/drivers/gpu/drm/nouveau/nv50_display.c
@@ -4150,7 +4150,7 @@ nv50_disp_atomic_commit(struct drm_devic
 		nv50_disp_atomic_commit_tail(state);
 
 	drm_for_each_crtc(crtc, dev) {
-		if (crtc->state->enable) {
+		if (crtc->state->active) {
 			if (!drm->have_disp_power_ref) {
 				drm->have_disp_power_ref = true;
 				return 0;


