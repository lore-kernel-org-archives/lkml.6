Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C1AEC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C0A02081B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895990;
	bh=r7hq8YLO3uLy4sLP+LuIaK7SelewLFXKORJqJZPeP40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dM9Xbm1Cn24ZUyAUeoUevubed67AXT+QlEfLV0DOkQ7tpaSlwdzKCYnzoMl+l7yfo
	 b4/D4O2EGHd1bUX7pDFWhdyqkT+5JjX2pcVJt62L0/vrrJvI5AIpnIydZOeFtyDgek
	 3DciazG5KpneaCX5NaBZoaGRlsOSUt6uuMbOxPTE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731941AbfBKOjs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:39:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:50204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731224AbfBKOjn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:39:43 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A39C620700;
        Mon, 11 Feb 2019 14:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895983;
        bh=r7hq8YLO3uLy4sLP+LuIaK7SelewLFXKORJqJZPeP40=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZClEreqt8jgkbm+C3Xv2sjDsCPmZUiETHYdqwsk80CEnQRntk/StD/UyneJan3JTR
         OAtFynt1xte82R569nIJbkyfyO5eazW+RE+YKukQMuEKpIqTrsgVU8P1Rjl+bQuxnm
         LWGw9H1rhetMElXiFBFgggl/FL6s2udE5hV6lSM8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 035/313] vbox: fix link error with gcc -Og
Date:   Mon, 11 Feb 2019 15:15:15 +0100
Message-Id: <20190211141855.813270203@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit b8ae30a7020d61e0504529adf45abb08fa5c59f5 ]

With the new CONFIG_CC_OPTIMIZE_FOR_DEBUGGING option, we get a link
error in the vboxguest driver, when that fails to optimize out the
call to the compat handler:

drivers/virt/vboxguest/vboxguest_core.o: In function `vbg_ioctl_hgcm_call':
vboxguest_core.c:(.text+0x1f6e): undefined reference to `vbg_hgcm_call32'

Another compile-time check documents better what we want and avoids
the error.

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/virt/vboxguest/vboxguest_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virt/vboxguest/vboxguest_core.c b/drivers/virt/vboxguest/vboxguest_core.c
index 3093655c7b92..1475ed5ffcde 100644
--- a/drivers/virt/vboxguest/vboxguest_core.c
+++ b/drivers/virt/vboxguest/vboxguest_core.c
@@ -1312,7 +1312,7 @@ static int vbg_ioctl_hgcm_call(struct vbg_dev *gdev,
 		return -EINVAL;
 	}
 
-	if (f32bit)
+	if (IS_ENABLED(CONFIG_COMPAT) && f32bit)
 		ret = vbg_hgcm_call32(gdev, client_id,
 				      call->function, call->timeout_ms,
 				      VBG_IOCTL_HGCM_CALL_PARMS32(call),
-- 
2.19.1



