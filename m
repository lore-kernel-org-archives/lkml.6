Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C31AC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C07C0208E7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:21:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C07C0208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934236AbeGJPV5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 11:21:57 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:40773 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934064AbeGJPVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 11:21:55 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue002 [212.227.15.129]) with ESMTPA (Nemesis) id
 0LibhV-1gDKbe2WGz-00cyuN; Tue, 10 Jul 2018 17:21:47 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <jbacik@fb.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] block: iolatency: avoid 64-bit division
Date:   Tue, 10 Jul 2018 17:21:34 +0200
Message-Id: <20180710152146.2371336-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:XyocjbQFefAhj3c/bBIEQ15lCKAaGoxSg9237vfr9dEN8XZkfbU
 WWAZf6Waok7o8dp+g/lNtmVlOs7p+HurBsmWWBfKrH2zZR49JuCxrovK7Bg5Ac7cFDsPkEY
 o0XbBwSKrybbDNcjo9oUolaIrUvNZwUxYoBSStaS9oM8DuB6mB7ySZObAm4tuezVgHVZVtI
 ell4rX/Idyevjig3J3qQQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+9NDxLDRql0=:f1V6LWvmkqTjc91JNmh/X9
 950MUw3uL5eSP/jsn+IJqmlkALQ1DEfwvLdENF9Gsf2dm0oSeXPDJ0x22K8dA+oPz3GaPtKxT
 KDYc97/lfqN+66RzZJICZf5xJ89v8+h9gc9pTlntxLc5d7cD6Z2fhmXGfLJ+Z2bLYOXEN8+6i
 fsZuOmupy8vQkqHduUqKyZRZ+4SGhW+gyMEm272mU8vWaIiWk1XMDI4qTlDg1lq+R18G749De
 PizaabuzHdHiF5t/nPtnEMAK2RUuR9ssP4Xk6iaUSw1uHJSNC0Dqm5w3WZACbPsq85dczmOyo
 Ttat7HWuQtgrbTSiRzmnugMSCI7V1bJ+freExm82theUsJixhUw5HsXLawJl7RtuUtSli53t9
 cms1XY/IcV7RMn8MyrwtcW3KWLLdEYKLksPvqEAusQZ0IzmMGRBpY3+ghORaGBTOJNpJaPFfY
 yky9Q8bfuPMt3pB+3rMjFluZrSXU4wtNZS7nudsIcybgW6S3LezQOJXsZXySGXWIrqmXkHOnQ
 lToVDyKCy1ptxoBG5MrCtmksgfkpr8fyaE7Xmuq60Vhii+wZoszWS8LL22+T5rK8p7VEmquAn
 UZmeFwrwssQDmJjlTeqfKSLM19aZmynKIwvBLevv7+TvuntA+/m6T28R4tjvT6rZh+LDTHQqB
 BHJ6FDpe+2sjI2MR1XNDdMWsncDEYtKreVWviEoc40p6LJ05ZeQBxnOzi6+3w0HttiMY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 32-bit architectures, dividing a 64-bit number needs to use the
do_div() function or something like it to avoid a link failure:

block/blk-iolatency.o: In function `iolatency_prfill_limit':
blk-iolatency.c:(.text+0x8cc): undefined reference to `__aeabi_uldivmod'

Using div_u64() gives us the best output and avoids the need for an
explicit cast.

Fixes: d70675121546 ("block: introduce blk-iolatency io controller")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 block/blk-iolatency.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index a35a1f580337..56ddb2c68752 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -798,8 +798,7 @@ static u64 iolatency_prfill_limit(struct seq_file *sf,
 	if (!dname || !iolat->min_lat_nsec)
 		return 0;
 	seq_printf(sf, "%s target=%llu\n",
-		   dname,
-		   (unsigned long long)iolat->min_lat_nsec / NSEC_PER_USEC);
+		   dname, div_u64(iolat->min_lat_nsec, NSEC_PER_USEC));
 	return 0;
 }
 
-- 
2.9.0

