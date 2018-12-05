Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31689C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E94D720850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KD/Uu5o6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E94D720850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbeLEJnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:43:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:46602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728284AbeLEJmC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:42:02 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D847320851;
        Wed,  5 Dec 2018 09:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544002922;
        bh=nVwXeZbd1KUhy8grK4kZZCDX8p0msN7Q7WJ0uFFB4es=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KD/Uu5o6kNmwbsCFWFgS9ylbwsjzgeulfWX32AoHaSzinIzjjGLpV+4ir4q+advlu
         nvRgB1hfZgWK6GbLUEGC6+9AneLXEMIr2gt6lxYQpK7Y5X2RYyw0kgUHrG4qUiVo+4
         qcLG63BoI6EkM2eFknE47haKAZeOUQTAdj4XzSxc=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 113/123] test_hexdump: use memcpy instead of strncpy
Date:   Wed,  5 Dec 2018 04:35:45 -0500
Message-Id: <20181205093555.5386-113-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205093555.5386-1-sashal@kernel.org>
References: <20181205093555.5386-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>

[ Upstream commit b1286ed7158e9b62787508066283ab0b8850b518 ]

New versions of gcc reasonably warn about the odd pattern of

	strncpy(p, q, strlen(q));

which really doesn't make sense: the strncpy() ends up being just a slow
and odd way to write memcpy() in this case.

Apparently there was a patch for this floating around earlier, but it
got lost.

Acked-again-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/test_hexdump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_hexdump.c b/lib/test_hexdump.c
index 626f580b4ff7..5144899d3c6b 100644
--- a/lib/test_hexdump.c
+++ b/lib/test_hexdump.c
@@ -99,7 +99,7 @@ static void __init test_hexdump_prepare_test(size_t len, int rowsize,
 		const char *q = *result++;
 		size_t amount = strlen(q);
 
-		strncpy(p, q, amount);
+		memcpy(p, q, amount);
 		p += amount;
 
 		*p++ = ' ';
-- 
2.17.1

