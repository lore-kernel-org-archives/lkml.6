Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D2CC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB45120817
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jM0W5kml"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB45120817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389475AbeKLIVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:21:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:47942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389457AbeKLIVP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:21:15 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1E0421582;
        Sun, 11 Nov 2018 22:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975478;
        bh=o22BkkdQWNRQ5PCXgJ1YhR/XNBb3NMXgs488BD8h+9A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jM0W5kmlTnJ12SZVt2QjvMFDJwbQ1GiVmIgAHxdiJL8mAk1uFttKs1l6vb1IbBYlz
         CGoQJe6tTyDjjfZSF5mqgf7nhQtzrRu37zkmScqtXM+w0u4qwGHqbjJfzAS4/R0G2a
         Gi4la/DYu1Ka2Ohw+KU2xAKQrXQLK2Xc7pAvDhLw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Franck Lenormand <franck.lenormand@nxp.com>,
        =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.18 238/350] crypto: tcrypt - fix ghash-generic speed test
Date:   Sun, 11 Nov 2018 14:21:42 -0800
Message-Id: <20181111221717.990826707@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
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

From: Horia Geantă <horia.geanta@nxp.com>

commit 331351f89c36bf7d03561a28b6f64fa10a9f6f3a upstream.

ghash is a keyed hash algorithm, thus setkey needs to be called.
Otherwise the following error occurs:
$ modprobe tcrypt mode=318 sec=1
testing speed of async ghash-generic (ghash-generic)
tcrypt: test  0 (   16 byte blocks,   16 bytes per update,   1 updates):
tcrypt: hashing failed ret=-126

Cc: <stable@vger.kernel.org> # 4.6+
Fixes: 0660511c0bee ("crypto: tcrypt - Use ahash")
Tested-by: Franck Lenormand <franck.lenormand@nxp.com>
Signed-off-by: Horia Geantă <horia.geanta@nxp.com>
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 crypto/tcrypt.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/crypto/tcrypt.c
+++ b/crypto/tcrypt.c
@@ -1097,6 +1097,9 @@ static void test_ahash_speed_common(cons
 			break;
 		}
 
+		if (speed[i].klen)
+			crypto_ahash_setkey(tfm, tvmem[0], speed[i].klen);
+
 		pr_info("test%3u "
 			"(%5u byte blocks,%5u bytes per update,%4u updates): ",
 			i, speed[i].blen, speed[i].plen, speed[i].blen / speed[i].plen);


