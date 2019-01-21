Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25022C2F3BE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE69A2089F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548078444;
	bh=FFm7xtvmsCrVcXzb5ClCbPNYc6MVAfovDBaz5vggd3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qrIhKlzMpaCME+2+5o9ncnUIReoexDpNmZGAT5UhX63btFbYCaf7WpwWUttdUSYZY
	 xYGDyEwbzc34J8TQvD2ZU2wkfq0UPFXH/wAM6ktxa0y618Wvln8q5bm+hOotClNf0r
	 0nxYFLRjMXv77SIK1TEvcY31U4MeqCGw/pGpqI+8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729584AbfAUNrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:47:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:56624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729028AbfAUNrV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:47:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8E2C20870;
        Mon, 21 Jan 2019 13:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078440;
        bh=FFm7xtvmsCrVcXzb5ClCbPNYc6MVAfovDBaz5vggd3c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QpQ0O47EkUFAOluO8mx6pfiOdKJFE1b57DXboZLk1ptgSEtHMa6Xg/BjHDcsL0SKB
         XVmxyHisF2YX1GiYjvDarhDJnFWdoXKIKzAcYJRoM1V+wWqZ/qMBkMJK2SuJbcjEBv
         gecgmBciIhSfTtZq7xOKQU2U+UnlOJEoR7S4lxEE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gilad Ben-Yossef <gilad@benyossef.com>,
        Eric Biggers <ebiggers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.20 032/111] crypto: sm3 - fix undefined shift by >= width of value
Date:   Mon, 21 Jan 2019 14:42:26 +0100
Message-Id: <20190121122459.361209799@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121122455.819406896@linuxfoundation.org>
References: <20190121122455.819406896@linuxfoundation.org>
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

From: Eric Biggers <ebiggers@google.com>

commit d45a90cb5d061fa7d411b974b950fe0b8bc5f265 upstream.

sm3_compress() calls rol32() with shift >= 32, which causes undefined
behavior.  This is easily detected by enabling CONFIG_UBSAN.

Explicitly AND with 31 to make the behavior well defined.

Fixes: 4f0fc1600edb ("crypto: sm3 - add OSCCA SM3 secure hash")
Cc: <stable@vger.kernel.org> # v4.15+
Cc: Gilad Ben-Yossef <gilad@benyossef.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 crypto/sm3_generic.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/crypto/sm3_generic.c
+++ b/crypto/sm3_generic.c
@@ -100,7 +100,7 @@ static void sm3_compress(u32 *w, u32 *wt
 
 	for (i = 0; i <= 63; i++) {
 
-		ss1 = rol32((rol32(a, 12) + e + rol32(t(i), i)), 7);
+		ss1 = rol32((rol32(a, 12) + e + rol32(t(i), i & 31)), 7);
 
 		ss2 = ss1 ^ rol32(a, 12);
 


