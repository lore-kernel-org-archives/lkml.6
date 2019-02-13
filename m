Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B18A9C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D3CC20835
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550083849;
	bh=UroE3V9aw2KQMUVGiwkqHsyvoOPGrnNEPJ5OPltkrbM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LT3c8SrbORq1ltomHdzyRZbUVTencLakbqin3bR0TGZfv2NPMRqDX6bY+1OxKCMpO
	 lM+qGI/ZMl7F79Wn1Fs7xeBcLoTbW9Ca2zIiJoXfYX1gy8pBjsxfmzlYDr2FQXLnoI
	 +Vxy4IeEf+cBL9M1zrJwUw6FQruEI2RiY5qUJidM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731398AbfBMSus (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:50:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:42634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406007AbfBMSoC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:44:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8929220675;
        Wed, 13 Feb 2019 18:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550083441;
        bh=UroE3V9aw2KQMUVGiwkqHsyvoOPGrnNEPJ5OPltkrbM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Khg7uGr9how4aMIY/IUpKL0S9qhKWArbN8V6MXFAq4oc3lPbc7qaIJEViRwUot0WU
         ypcIaKlPvPI2BlFLsPkAxgQAVro9NnEOdqgf49wq8Pnu0aMLRYMK9+7/83puSVcRG2
         4SSJSruuhzlVabv5vfWTkLWN9dyBDANqmeV2MWHc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Benedict Wong <benedictwong@google.com>,
        Steffen Klassert <steffen.klassert@secunet.com>
Subject: [PATCH 4.19 37/44] xfrm: Make set-mark default behavior backward compatible
Date:   Wed, 13 Feb 2019 19:38:38 +0100
Message-Id: <20190213183654.904785611@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213183651.648060257@linuxfoundation.org>
References: <20190213183651.648060257@linuxfoundation.org>
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

From: Benedict Wong <benedictwong@google.com>

commit e2612cd496e7b465711d219ea6118893d7253f52 upstream.

Fixes 9b42c1f179a6, which changed the default route lookup behavior for
tunnel mode SAs in the outbound direction to use the skb mark, whereas
previously mark=0 was used if the output mark was unspecified. In
mark-based routing schemes such as Android’s, this change in default
behavior causes routing loops or lookup failures.

This patch restores the default behavior of using a 0 mark while still
incorporating the skb mark if the SET_MARK (and SET_MARK_MASK) is
specified.

Tested with additions to Android's kernel unit test suite:
https://android-review.googlesource.com/c/kernel/tests/+/860150

Fixes: 9b42c1f179a6 ("xfrm: Extend the output_mark to support input direction and masking")
Signed-off-by: Benedict Wong <benedictwong@google.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/xfrm/xfrm_policy.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -1628,7 +1628,10 @@ static struct dst_entry *xfrm_bundle_cre
 		dst_copy_metrics(dst1, dst);
 
 		if (xfrm[i]->props.mode != XFRM_MODE_TRANSPORT) {
-			__u32 mark = xfrm_smark_get(fl->flowi_mark, xfrm[i]);
+			__u32 mark = 0;
+
+			if (xfrm[i]->props.smark.v || xfrm[i]->props.smark.m)
+				mark = xfrm_smark_get(fl->flowi_mark, xfrm[i]);
 
 			family = xfrm[i]->props.family;
 			dst = xfrm_dst_lookup(xfrm[i], tos, fl->flowi_oif,


