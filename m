Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C11D1C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91CFB20657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547570685;
	bh=+/Embhg53V3P2wECBH+95bT3RRFzeo22MC2TnFB0dQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HzVaiVlQjNFEvyumtxHsToyqZI+FDg2NqdJ8LmvNXjP0sp0XUnyUSXe2yooP4eUnw
	 AUlLOzAUwt8lqrDlcg6O4INyxiFXCYSvt6XpLBKPNPrhvHx5lxXmEcKH6IKWddU8St
	 Jt41Hl+3USe8MOHO/CtvNP1G1NQ+FcGa8A1zRje8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387610AbfAOQon (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:44:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:34210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387561AbfAOQoj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:44:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C87F2054F;
        Tue, 15 Jan 2019 16:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570679;
        bh=+/Embhg53V3P2wECBH+95bT3RRFzeo22MC2TnFB0dQY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uRZtxWJBMfGmNauPC++4bLGsUQa64fE4wGueF3V1KFKp+q6+VZvs+GvMPUXG3/qZk
         F7oYBwGzKbuNvwEok0zDWdxJvrN1TocIg5cK5+fLizJlwxbg88x17VWGP2uJc80dB1
         rwLovx4VW1cRt/ds/NMoRXLcl3M4/rVxgP0p+MS0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ivan Safonov <insafonov@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4.20 04/57] staging: rtl8188eu: Fix module loading from tasklet for CCMP encryption
Date:   Tue, 15 Jan 2019 17:35:45 +0100
Message-Id: <20190115154910.964003727@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115154910.734892368@linuxfoundation.org>
References: <20190115154910.734892368@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Larry Finger <Larry.Finger@lwfinger.net>

commit 84cad97a717f5749a0236abd5ce68da582ea074f upstream.

Commit 6bd082af7e36 ("staging:r8188eu: use lib80211 CCMP decrypt")
causes scheduling while atomic bugs followed by a hard freeze whenever
the driver tries to connect to a CCMP-encrypted network. Experimentation
showed that the freezes were eliminated when module lib80211 was
preloaded, which can be forced by calling lib80211_get_crypto_ops()
directly rather than indirectly through try_then_request_module().
With this change, no BUG messages are logged.

Fixes: 6bd082af7e36 ("staging:r8188eu: use lib80211 CCMP decrypt")
Cc: Stable <stable@vger.kernel.org> # v4.17+
Reported-and-tested-by: Michael Straube <straube.linux@gmail.com>
Cc: Ivan Safonov <insafonov@gmail.com>
Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/rtl8188eu/core/rtw_security.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/staging/rtl8188eu/core/rtw_security.c
+++ b/drivers/staging/rtl8188eu/core/rtw_security.c
@@ -1291,7 +1291,7 @@ u32 rtw_aes_decrypt(struct adapter *pada
 			struct sk_buff *skb = ((struct recv_frame *)precvframe)->pkt;
 			void *crypto_private = NULL;
 			u8 *key, *pframe = skb->data;
-			struct lib80211_crypto_ops *crypto_ops = try_then_request_module(lib80211_get_crypto_ops("CCMP"), "lib80211_crypt_ccmp");
+			struct lib80211_crypto_ops *crypto_ops = lib80211_get_crypto_ops("CCMP");
 			struct security_priv *psecuritypriv = &padapter->securitypriv;
 			char iv[8], icv[8];
 


