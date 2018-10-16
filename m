Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32EDC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EBFF2098A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="S4zNnIl2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EBFF2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729793AbeJQBIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:08:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:52942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727486AbeJQBIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:08:18 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B578920866;
        Tue, 16 Oct 2018 17:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710215;
        bh=p/8XQO7UMb9MKoq12L8Y1D197cCXLGRHH1DD8TXQgbo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S4zNnIl2lcE+uifLnEjafe4XQaYC1lnrNC866C1rRK0DOfTRnV6gtNGtvOLjpkSi6
         RQNIsLiLnue2Kp/d5VvbCP76pt0esNF71mmDDTjOi+ys79wmS/w1KJqFLxS5+rulXq
         ckiJdI6x5eVzmzxCgco/zhpNooYo+jtp0ZaRb7BY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lyude Paul <lyude@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>
Subject: [PATCH 4.18 127/135] drm/nouveau/drm/nouveau: Grab runtime PM ref in nv50_mstc_detect()
Date:   Tue, 16 Oct 2018 19:05:57 +0200
Message-Id: <20181016170524.019141893@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170515.447235311@linuxfoundation.org>
References: <20181016170515.447235311@linuxfoundation.org>
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

commit e46368cf77f2cb6304c51d9ff5f147cfb7dc0074 upstream.

While we currently grab a runtime PM ref in nouveau's normal connector
detection code, we apparently don't do this for MST. This means if we're
in a scenario where the GPU is suspended and userspace attempts to do a
connector probe on an MSTC connector, the probe will fail entirely due
to the DP aux channel and GPU not being woken up:

[  316.633489] nouveau 0000:01:00.0: i2c: aux 000a: begin idle timeout ffffffff
[  316.635713] nouveau 0000:01:00.0: i2c: aux 000a: begin idle timeout ffffffff
[  316.637785] nouveau 0000:01:00.0: i2c: aux 000a: begin idle timeout ffffffff
...

So, grab a runtime PM ref here.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: stable@vger.kernel.org
Reviewed-by: Karol Herbst <kherbst@redhat.com>
Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/nouveau/dispnv50/disp.c |   15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -875,9 +875,22 @@ static enum drm_connector_status
 nv50_mstc_detect(struct drm_connector *connector, bool force)
 {
 	struct nv50_mstc *mstc = nv50_mstc(connector);
+	enum drm_connector_status conn_status;
+	int ret;
+
 	if (!mstc->port)
 		return connector_status_disconnected;
-	return drm_dp_mst_detect_port(connector, mstc->port->mgr, mstc->port);
+
+	ret = pm_runtime_get_sync(connector->dev->dev);
+	if (ret < 0 && ret != -EACCES)
+		return connector_status_disconnected;
+
+	conn_status = drm_dp_mst_detect_port(connector, mstc->port->mgr,
+					     mstc->port);
+
+	pm_runtime_mark_last_busy(connector->dev->dev);
+	pm_runtime_put_autosuspend(connector->dev->dev);
+	return conn_status;
 }
 
 static void


