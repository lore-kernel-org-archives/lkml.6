Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98741C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 22:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E70A21A56
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 22:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ydhk4lnZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E70A21A56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731454AbeHGApe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 20:45:34 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:35454 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728198AbeHGApe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 20:45:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1533594863; x=1565130863;
  h=from:to:cc:subject:date:message-id;
  bh=fyzK33IXSKgWzzp8bFB/JH3bHBJRlMlKtPv3BkHpd1M=;
  b=Ydhk4lnZQWihmHl/ar/9v9SyohbT8qWXy8YwP65b9TwsuQ9OEXYeUsdG
   qXy/NAbFicZeZ7gR0j4T0MkxJOyJN6ej/Uk+gHy/3rRF//eimo2v0YEBc
   dxEYL2fDk5iujOX3NsZSO5eOCsHlNnT2Cbnb2Ns3zzjgLFn0q00rjYwc4
   jBNSkPNO93NOdQqCcSTOO3gOGqGyerFWX+B1Ba2gQE6GcM1uCNJntLHXg
   B8abRtEutHwx9hqSDL9MnI0WhNDOnM/5Xphf3bC3jzp47kOdqs1mgk+DH
   2BqRXrr2xrWRDu5XtqOlSXJ3deF1s7dh4M53zVv5DrQTZSfUrUxAvmacU
   w==;
X-IronPort-AV: E=Sophos;i="5.51,452,1526313600"; 
   d="scan'208";a="88286490"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Aug 2018 06:34:22 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 06 Aug 2018 15:22:38 -0700
Received: from thinkpad-bart.sdcorp.global.sandisk.com ([10.111.67.248])
  by uls-op-cesaip02.wdc.com with ESMTP; 06 Aug 2018 15:34:22 -0700
From:   Bart Van Assche <bart.vanassche@wdc.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Joe Perches <joe@perches.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH] lib/vsprintf: Do not handle %pO[^F] as %px
Date:   Mon,  6 Aug 2018 15:34:21 -0700
Message-Id: <20180806223421.11995-1-bart.vanassche@wdc.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch avoids that gcc reports the following when building with W=1:

lib/vsprintf.c:1941:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
   switch (fmt[1]) {
   ^~~~~~

Fixes: ce4fecf1fe15 ("vsprintf: Add %p extension "%pOF" for device tree")
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Cc: Joe Perches <joe@perches.com>
Cc: Rob Herring <robh@kernel.org>
---
 lib/vsprintf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index a48aaa79d352..cda186230287 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1942,6 +1942,7 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 		case 'F':
 			return device_node_string(buf, end, ptr, spec, fmt + 1);
 		}
+		break;
 	case 'x':
 		return pointer_string(buf, end, ptr, spec);
 	}
-- 
2.18.0

