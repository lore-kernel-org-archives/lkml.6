Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE184C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D48920675
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547570543;
	bh=n39piaDXU/7nqsCbSFW1w//zTsli6kPChGyIXh0065Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uNTjeuytnrzeLpmhNFvNJ9EDvrndC2cgfYPkv0PuHmXGBRuQORySUiTIFxIkgcUl4
	 kvBu4nX0f+8ASlHCubxCGXVJ/gRbyxH+YniPRuHhOrG5HcxxhyrM+SshSsyH5htvP1
	 qBtWqt+T5E7I9RCudY8mnbDCvVzSlCyrp9Qabzvo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732968AbfAOQmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:42:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:59146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732947AbfAOQmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:42:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FA1F20645;
        Tue, 15 Jan 2019 16:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570537;
        bh=n39piaDXU/7nqsCbSFW1w//zTsli6kPChGyIXh0065Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H49lbl9HLAvEQwlTqq6rUA2weCHDM7QMAbraDcly9YIe1J5qcm00cW2IlcqQMFZNx
         Mq4xS0gro8eoizSfI2uofNPDH/0px/7KfnHgNAQUzo2bvbEQ+GlbSgjgd9vSHEpALx
         Js6HshiMbOctP8FNnRBcNfIf/tH15GS680ztI0jI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Straube <straube.linux@gmail.com>,
        Ivan Safonov <insafonov@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 4.19 03/50] staging: rtl8188eu: Fix module loading from tasklet for WEP encryption
Date:   Tue, 15 Jan 2019 17:35:39 +0100
Message-Id: <20190115154910.180329243@linuxfoundation.org>
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

commit 7775665aadc48a562051834a73519129bf717d73 upstream.

Commit 2b2ea09e74a5 ("staging:r8188eu: Use lib80211 to decrypt WEP-frames")
causes scheduling while atomic bugs followed by a hard freeze whenever
the driver tries to connect to a WEP-encrypted network. Experimentation
showed that the freezes were eliminated when module lib80211 was
preloaded, which can be forced by calling lib80211_get_crypto_ops()
directly rather than indirectly through try_then_request_module().
With this change, no BUG messages are logged.

Fixes: 2b2ea09e74a5 ("staging:r8188eu: Use lib80211 to decrypt WEP-frames")
Cc: Stable <stable@vger.kernel.org> # v4.17+
Cc: Michael Straube <straube.linux@gmail.com>
Cc: Ivan Safonov <insafonov@gmail.com>
Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/rtl8188eu/core/rtw_security.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/staging/rtl8188eu/core/rtw_security.c
+++ b/drivers/staging/rtl8188eu/core/rtw_security.c
@@ -154,7 +154,7 @@ void rtw_wep_encrypt(struct adapter *pad
 
 	pframe = ((struct xmit_frame *)pxmitframe)->buf_addr + hw_hdr_offset;
 
-	crypto_ops = try_then_request_module(lib80211_get_crypto_ops("WEP"), "lib80211_crypt_wep");
+	crypto_ops = lib80211_get_crypto_ops("WEP");
 
 	if (!crypto_ops)
 		return;
@@ -210,7 +210,7 @@ int rtw_wep_decrypt(struct adapter  *pad
 		void *crypto_private = NULL;
 		int status = _SUCCESS;
 		const int keyindex = prxattrib->key_index;
-		struct lib80211_crypto_ops *crypto_ops = try_then_request_module(lib80211_get_crypto_ops("WEP"), "lib80211_crypt_wep");
+		struct lib80211_crypto_ops *crypto_ops = lib80211_get_crypto_ops("WEP");
 		char iv[4], icv[4];
 
 		if (!crypto_ops) {


