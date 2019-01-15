Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C9CEC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C655220645
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547571369;
	bh=wCLXGd6So6wiLogV9GO1R3GGPah253IQI5W0fHspxyY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Fg9+ZW1jHiRXS+qQoxUhvGF2InI+tH4Qmm84BMm1At4o/3iG1WV2r+H4wvhetvqDt
	 5/60ByQwR964nXcmtjM4MWsmjFOWsEafh81lcoTKkgQHi9IJFi3/PxjwR3LBytIhjM
	 zDLB5/LrSth9OHUgdw1Mb8JyPkQSUyRtFc6nyAgU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732889AbfAOQlw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:41:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:58618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732863AbfAOQlr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:41:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4816A20868;
        Tue, 15 Jan 2019 16:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570506;
        bh=wCLXGd6So6wiLogV9GO1R3GGPah253IQI5W0fHspxyY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l5i9xUV/q4QrDZ+5DGIs6xHYY+3CDmv0vUxp5otoj+UzkELNgUihZAICwB/d8DJV1
         fhMlhz6qcRJi+jPa7WzQ6R2nXJ66rMdev4L9XG/R10e2hDkrUjjLvszYZ4WazBzjl3
         YyRWCmoEzpwMn+7ywdAiKFj5Mxp3OZ777tez4IZ4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ivan Safonov <insafonov@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4.19 02/50] staging: rtl8188eu: Fix module loading from tasklet for CCMP encryption
Date:   Tue, 15 Jan 2019 17:35:38 +0100
Message-Id: <20190115154910.121316175@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115154909.933241945@linuxfoundation.org>
References: <20190115154909.933241945@linuxfoundation.org>
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
@@ -1292,7 +1292,7 @@ u32 rtw_aes_decrypt(struct adapter *pada
 			struct sk_buff *skb = ((struct recv_frame *)precvframe)->pkt;
 			void *crypto_private = NULL;
 			u8 *key, *pframe = skb->data;
-			struct lib80211_crypto_ops *crypto_ops = try_then_request_module(lib80211_get_crypto_ops("CCMP"), "lib80211_crypt_ccmp");
+			struct lib80211_crypto_ops *crypto_ops = lib80211_get_crypto_ops("CCMP");
 			struct security_priv *psecuritypriv = &padapter->securitypriv;
 			char iv[8], icv[8];
 


