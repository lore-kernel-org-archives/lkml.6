Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F8C7C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBD8B2087D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rd6HsR+T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBD8B2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730826AbeJIB5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:57:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:45774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730395AbeJIB5s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:57:48 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B02302087D;
        Mon,  8 Oct 2018 18:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024283;
        bh=eukrHeBe1uDZldLvUvT7ON+xLdaRzzOMsdtjNRAipoY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rd6HsR+TYKNSlVut+HeD4HktJfAJzm5pIYF1+h7T/Tb0BInbDOFL89C91C0RUMYHl
         gzxqcWdJp/SMztvWtPywz6+i4Cls8ERHZNCKSniDUJj1ITDhAX2BcztkzEE7TAZqiQ
         g9w5qRWtlJ9EMQuMIAj5QPNcjWv17doYgQgO2HHk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 59/94] drm/nouveau/TBDdevinit: dont fail when PMU/PRE_OS is missing from VBIOS
Date:   Mon,  8 Oct 2018 20:31:40 +0200
Message-Id: <20181008175608.946839273@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175605.067676667@linuxfoundation.org>
References: <20181008175605.067676667@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ben Skeggs <bskeggs@redhat.com>

[ Upstream commit 0a6986c6595e9afd20ff7280dab36431c1e467f8 ]

This Falcon application doesn't appear to be present on some newer
systems, so let's not fail init if we can't find it.

TBD: is there a way to determine whether it *should* be there?

Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gm200.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gm200.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gm200.c
@@ -158,7 +158,8 @@ gm200_devinit_post(struct nvkm_devinit *
 	}
 
 	/* load and execute some other ucode image (bios therm?) */
-	return pmu_load(init, 0x01, post, NULL, NULL);
+	pmu_load(init, 0x01, post, NULL, NULL);
+	return 0;
 }
 
 static const struct nvkm_devinit_func


