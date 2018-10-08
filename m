Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E417C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6236120645
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:50:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJvAsbzr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6236120645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732209AbeJICEC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:04:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:53630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729987AbeJICEB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:04:01 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A075204FD;
        Mon,  8 Oct 2018 18:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024653;
        bh=EQLoizD/HN2YUSEr4TVAqA+iOv6CiQucWjwa9AuVda4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BJvAsbzrEExdhbzbLL4S2RKlVkBpl3ocJwJKhzEOY5jZJisg9EF8y+yVwcyIwz2/P
         BBNvQtFc5Gg5gM7kYQ354kgaK6+hdh0nc2s6fkW2tU1PSdeeOdp2XblFqX7ZQMaBCc
         wnpF6ApSHNWBVcvQxxfTAYXeHuDrTW46D/ff/yds=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 109/168] drm/nouveau/mmu: dont attempt to dereference vmm without valid instance pointer
Date:   Mon,  8 Oct 2018 20:31:29 +0200
Message-Id: <20181008175624.188615137@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175620.043587728@linuxfoundation.org>
References: <20181008175620.043587728@linuxfoundation.org>
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

From: Ben Skeggs <bskeggs@redhat.com>

[ Upstream commit 51ed833c881b9d96557c773f6a37018d79e29a46 ]

Fixes oopses in certain failure paths.

Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c
@@ -1423,7 +1423,7 @@ nvkm_vmm_get(struct nvkm_vmm *vmm, u8 pa
 void
 nvkm_vmm_part(struct nvkm_vmm *vmm, struct nvkm_memory *inst)
 {
-	if (vmm->func->part && inst) {
+	if (inst && vmm->func->part) {
 		mutex_lock(&vmm->mutex);
 		vmm->func->part(vmm, inst);
 		mutex_unlock(&vmm->mutex);


