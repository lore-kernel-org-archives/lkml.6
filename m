Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB5BECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 16:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E07421473
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 16:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r60tJHTA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E07421473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbeIWWbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 18:31:39 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40992 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbeIWWbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 18:31:38 -0400
Received: by mail-pg1-f194.google.com with SMTP id z3-v6so3151672pgv.8;
        Sun, 23 Sep 2018 09:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=zPkK1bfV40IkD5P4uGcAa8dNbOFSTAmN+IYRbebQqnU=;
        b=r60tJHTA/30twb4wilx+/A/pOQZ9G1TEH9XybtGK6bYvM0V8h0qxPa9pW8Zbm7Qe2I
         nUVIa3QUU4REVv73UierddYI28RsBEtZpgJwtUiMTyHEHlifJ70MVR7rd2cc0BMya9BW
         l2o0+Mpqf1RojpwxS/+e1ok8/EtrLy0B43Y5K/C0vrlZr8aJdQmAg9y6vOctAAGxwEVV
         2zQPO/Er8xsoj0zUM03uVyhaIYiSBDYiRqzByOFTXI5NwuZffc24Gsftf6Bt/RFoe+yo
         KwZz6glAx/+3BItxfxT9D9XMIpkrb8N9exZS1Y8avop8T1MsOSsjgGg7TxJ7gbJPBh7J
         GiKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=zPkK1bfV40IkD5P4uGcAa8dNbOFSTAmN+IYRbebQqnU=;
        b=fgpj4aEmnTPIQCB8SX4sYMTpu5Gr1xHTypCRJZvbosFr35AWo6gsZpnQ6xNeitRPwI
         8a3iD1nF/RA5XJwMjdfI+9zXo26X/DC2Ai2h7N2NOyarLc0AOzg5k2Li0R2fpaUJUVEe
         0PGmliqA7abIt9IDkSS1Q7baUonq2h14djUw6yQ6fIN8/E8N5Rb9XCdHazxbjI2Oy2cP
         aYs2H9u3LJ6xwYqN5nokgByolrwQ9FVgX5VB6PB6GcrFp1amzs8xRpi4vFkxpgrc60ud
         BYqNyXyiRqTENXv1AtBA5aShI71wc9jP74sdHd00FqpeYMpk2XBrZoVmmbPEejZExtUf
         799A==
X-Gm-Message-State: ABuFfojcT/q+4INf+AzfHDY/HXFNog4oL/buhy0ng/RWDLWkpePFarzu
        Oyzb5JeeFzQBrya6aN6kGTc=
X-Google-Smtp-Source: ACcGV632+KUVIXmGUWWxLkaOktlNPHSTWiYosG1JxG6nzh9E+ZMj7aMMDEA+vSEOiB3XLRBiyejFHQ==
X-Received: by 2002:a63:e756:: with SMTP id j22-v6mr6455848pgk.185.1537720416435;
        Sun, 23 Sep 2018 09:33:36 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id t84-v6sm5435100pfj.7.2018.09.23.09.33.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Sep 2018 09:33:35 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] of: unittest: Don't dereference args.np after test errors
Date:   Sun, 23 Sep 2018 09:33:32 -0700
Message-Id: <1537720412-29919-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a devicetree parse function fails, it is quite likely that args.np
is invalid. Trying to dereference it will then cause the system to crash.

This was seen when trying to run devicetree unittests on a g3beige
qemu system. This system has the OF_IMAP_OLDWORLD_MAC flag set in
of_irq_workarounds and expects an 'old style' structure of irq
nodes. Trying to parse the test nodes fails and results in the
following crash.

OF: /testcase-data/phandle-tests/consumer-b: arguments longer than property
Unable to handle kernel paging request for data at address 0x00bc616e
Faulting instruction address: 0xc092437c
Oops: Kernel access of bad area, sig: 11 [#1]
BE PREEMPT PowerMac
Modules linked in:
CPU: 0 PID: 1 Comm: swapper Not tainted 4.19.0-rc4-yocto-standard+ #1
NIP:  c092437c LR: c0925098 CTR: c0925088
REGS: cf8dfb40 TRAP: 0300   Not tainted  (4.19.0-rc4-yocto-standard+)
MSR:  00001032 <ME,IR,DR,RI>  CR: 82004044  XER: 00000000
DAR: 00bc616e DSISR: 40000000
GPR00: c0925098 cf8dfbf0 cf8e0000 c14098c7 c14098c7 c1409c50 00000066 00000002
GPR08: 00000063 00bc614e c0b483e9 000affff 82004048 00000000 00000008 c0b36d80
GPR16: c0ac0000 c0b4233c c14098c7 c0b13c14 05ffffff 000affff c0b483e4 c0b00a30
GPR24: cecfe324 cecfe324 c0acc434 c0ac8420 c1409c50 05ffffff c1409c50 c14098c7
NIP [c092437c] device_node_gen_full_name+0x30/0x15c
LR [c0925098] device_node_string+0x190/0x3c8
Call Trace:
[cf8dfbf0] [c0733704] of_find_property+0x5c/0x74 (unreliable)
[cf8dfc30] [c0925098] device_node_string+0x190/0x3c8
[cf8dfca0] [c092690c] pointer+0x274/0x4d4
[cf8dfcd0] [c0926e20] vsnprintf+0x2b4/0x5ec
[cf8dfd30] [c0927170] vscnprintf+0x18/0x48
[cf8dfd40] [c008eb70] vprintk_store+0x4c/0x22c
[cf8dfd70] [c008f1c4] vprintk_emit+0x94/0x270
[cf8dfda0] [c008fb60] printk+0x5c/0x6c
[cf8dfde0] [c0bd1ec0] of_unittest+0x2670/0x2b48
[cf8dfe80] [c0004ba8] do_one_initcall+0xac/0x320
[cf8dfee0] [c0b8975c] kernel_init_freeable+0x328/0x3f0
[cf8dff30] [c00050c4] kernel_init+0x24/0x118
[cf8dff40] [c0014278] ret_from_kernel_thread+0x14/0x1c

To avoid this and similar problems, don't try to dereference args.np
after devicetree parse failures, and display the name of the parsed node
instead. With this, we get error messages such as

dt-test ### FAIL of_unittest_parse_interrupts():791 index 0 -
	data error on node /testcase-data/interrupts/interrupts0 rc=-22

This may not display the intended node name, but it is better than a crash.

Fixes: 53a42093d96ef ("of: Add device tree selftests")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/of/unittest.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 722537e14848..5942ddce1b9f 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -424,7 +424,7 @@ static void __init of_unittest_parse_phandle_with_args(void)
 		}
 
 		unittest(passed, "index %i - data error on node %pOF rc=%i\n",
-			 i, args.np, rc);
+			 i, np, rc);
 	}
 
 	/* Check for missing list property */
@@ -554,8 +554,8 @@ static void __init of_unittest_parse_phandle_with_args_map(void)
 			passed = false;
 		}
 
-		unittest(passed, "index %i - data error on node %s rc=%i\n",
-			 i, args.np->full_name, rc);
+		unittest(passed, "index %i - data error on node %pOF rc=%i\n",
+			 i, np, rc);
 	}
 
 	/* Check for missing list property */
@@ -788,7 +788,7 @@ static void __init of_unittest_parse_interrupts(void)
 		passed &= (args.args[0] == (i + 1));
 
 		unittest(passed, "index %i - data error on node %pOF rc=%i\n",
-			 i, args.np, rc);
+			 i, np, rc);
 	}
 	of_node_put(np);
 
@@ -834,7 +834,7 @@ static void __init of_unittest_parse_interrupts(void)
 			passed = false;
 		}
 		unittest(passed, "index %i - data error on node %pOF rc=%i\n",
-			 i, args.np, rc);
+			 i, np, rc);
 	}
 	of_node_put(np);
 }
@@ -904,7 +904,7 @@ static void __init of_unittest_parse_interrupts_extended(void)
 		}
 
 		unittest(passed, "index %i - data error on node %pOF rc=%i\n",
-			 i, args.np, rc);
+			 i, np, rc);
 	}
 	of_node_put(np);
 }
-- 
2.7.4

