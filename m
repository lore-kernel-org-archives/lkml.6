Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94056C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 581B32145D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544788992;
	bh=x05QPOkeMbWI+8929MlJ3Qao7/3b6Y/SCZb7YJ9pjSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kSgIprDJnldPSsAfMe5WiWCHbcMLIfPEmfkLn/aWF1gKh2u5HSHwQWI/FurPCwpnH
	 WECN01iRMQsmGOAnxzsQKozxatqImUKVJHsiurT6xBGUK04cTO4ajgC/b7ihC1qcb0
	 PXZrS5rHVUXXn0NZvklC1S57128gyo7YXVPlPsWs=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 581B32145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730256AbeLNMDL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:03:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:46308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730225AbeLNMDE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:03:04 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7EB3E2147C;
        Fri, 14 Dec 2018 12:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544788984;
        bh=x05QPOkeMbWI+8929MlJ3Qao7/3b6Y/SCZb7YJ9pjSs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ht3ONO2ikSbAPsjxv9sJrZ9Dz6hycgPUV3ySk+DgFaTUcNWc4jPz8jvVB2la/ftQX
         jR7pXVWasokf5FbuNlamjCm/L9ep/UXSQVqh1zalQw9MiBNUk89Ncs4VPS6guriem1
         ybYHFM+DlVmHfTCHPzxyhR2NF5iJRzwaYqWSnlMU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 026/142] staging: rtl8723bs: Fix the return value in case of error in rtw_wx_read32()
Date:   Fri, 14 Dec 2018 12:58:31 +0100
Message-Id: <20181214115748.101167160@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115747.053633987@linuxfoundation.org>
References: <20181214115747.053633987@linuxfoundation.org>
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

[ Upstream commit c3e43d8b958bd6849817393483e805d8638a8ab7 ]

We return 0 unconditionally in 'rtw_wx_read32()'.
However, 'ret' is set to some error codes in several error handling paths.

Return 'ret' instead to propagate the error code.

Fixes: 554c0a3abf216 ("staging: Add rtl8723bs sdio wifi driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index c38298d960ff..4f120e72c7d2 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -2289,7 +2289,7 @@ static int rtw_wx_read32(struct net_device *dev,
 exit:
 	kfree(ptmp);
 
-	return 0;
+	return ret;
 }
 
 static int rtw_wx_write32(struct net_device *dev,
-- 
2.19.1



