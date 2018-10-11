Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C84C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F7F42098A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="z4/TyzH6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F7F42098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731826AbeJKXPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:15:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:48586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726727AbeJKXPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:15:12 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3306A213A2;
        Thu, 11 Oct 2018 15:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272846;
        bh=JhfobuZ/SM57iSgp+kaxaF1yMsDDsBbo9GmhtlEbCVQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z4/TyzH6QbE6lxjicCFbHoMJ3MKwvnNGaSCRk0JhIHHHsGKX0hP1SjOZ7n4RzOBUE
         yoOGPhNy3/9qtnxamRaLiD4XKEcB2X/xARn1EqX/XvxMIrUn7uHvFoD/2n+Gs62ilA
         WVPzraKXX1w1t44XWllVOPuutjk4kYCGfsU5fZOI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Feifei Xu <Feifei.Xu@amd.com>, Rex Zhu <Rex.Zhu@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.18 15/44] drm/amdgpu: Fix vce work queue was not cancelled when suspend
Date:   Thu, 11 Oct 2018 17:39:53 +0200
Message-Id: <20181011152453.160416748@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152452.571669983@linuxfoundation.org>
References: <20181011152452.571669983@linuxfoundation.org>
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

From: Rex Zhu <Rex.Zhu@amd.com>

commit 61ea6f5831974ebd1a57baffd7cc30600a2e26fc upstream.

The vce cancel_delayed_work_sync never be called.
driver call the function in error path.

This caused the A+A suspend hang when runtime pm enebled.
As we will visit the smu in the idle queue. this will cause
smu hang because the dgpu has been suspend, and the dgpu also
will be waked up. As the smu has been hang, so the dgpu resume
will failed.

Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>
Signed-off-by: Rex Zhu <Rex.Zhu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c |    3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c |    4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -246,6 +246,8 @@ int amdgpu_vce_suspend(struct amdgpu_dev
 {
 	int i;
 
+	cancel_delayed_work_sync(&adev->vce.idle_work);
+
 	if (adev->vce.vcpu_bo == NULL)
 		return 0;
 
@@ -256,7 +258,6 @@ int amdgpu_vce_suspend(struct amdgpu_dev
 	if (i == AMDGPU_MAX_VCE_HANDLES)
 		return 0;
 
-	cancel_delayed_work_sync(&adev->vce.idle_work);
 	/* TODO: suspending running encoding sessions isn't supported */
 	return -EINVAL;
 }
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -151,11 +151,11 @@ int amdgpu_vcn_suspend(struct amdgpu_dev
 	unsigned size;
 	void *ptr;
 
+	cancel_delayed_work_sync(&adev->vcn.idle_work);
+
 	if (adev->vcn.vcpu_bo == NULL)
 		return 0;
 
-	cancel_delayed_work_sync(&adev->vcn.idle_work);
-
 	size = amdgpu_bo_size(adev->vcn.vcpu_bo);
 	ptr = adev->vcn.cpu_addr;
 


