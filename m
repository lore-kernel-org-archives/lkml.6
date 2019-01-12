Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FED4C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 06:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D17272084E
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 06:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdn/gP8c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725847AbfALGGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 01:06:36 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34125 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbfALGGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 01:06:36 -0500
Received: by mail-wm1-f68.google.com with SMTP id y185so3399552wmd.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 22:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Ph5VQzcBaXXcFDFqNVP4LDnol5rr4vmen0hpu+zRBA0=;
        b=gdn/gP8c8sG7bcuGvMsyozfWV10kDBCqC73fm0RApTgfCS8PKo4qpDyrLAIXhP7rO6
         HJrrz8TiSLd4+qPCVynra/X5357bIsSOfcEpCqpCCpxH7QJ2LE51EAZ7EtVRpJ+C5JOM
         U7iqaUzuyQmJF9REvEQocojlJx1kRclRBaaBRAUpN1FUWCpIZVRFLptr7QSDJ/rYw7cF
         5oPugpkcRcD644rSpJeS2CkbacFsUHRz4mmdTP9QiFRD0rSQaYeSTO3JO5sZ7CL12CBK
         +bb3Srs7AlOQXqIAeapsuy+F4ab9wfBhLUHm1uNCeNFCfdsyRAl9syEjyfBPchOgeldL
         Cc5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ph5VQzcBaXXcFDFqNVP4LDnol5rr4vmen0hpu+zRBA0=;
        b=fJ2r3sPt9gUArtiBdyGpqzojrdeAKY+SwPLrM8MkZC6Sa1bG4vFnI3jMMkLMSHT4bo
         liq7uUvQvSD9y6J5u6eQ+K9wyD5hapcaM0x69/NSy+F6H9Fwn3lkURnzlQ9KY1KHMC8r
         LysZWNCq0vY39Nj9P8ta2FOycYSGlhwKSR8koHPwbTAexDE+YUTZtwxcJai5Tvt354GK
         HClRlTlvaY1ybyuteixi0CCAuN7+uXRqkXOLXCG/2NAxWYNhwFp3bzafea1dyE4p4bQ6
         Vb/K1Mm28KyX4pAh4eO8W6XyQ90Zep0S54QmCNLSeBJz3Pe7Cw8CC/61CIPrP44GivYe
         OruA==
X-Gm-Message-State: AJcUukcNi+o/+u+KYT1gW9OmQe/OrIB8qI70cL93bOp52XdWhJUFLQyL
        iuOQ0OLGow3gf3MMtZpjqmM=
X-Google-Smtp-Source: ALg8bN54eHT/UDid/W8g/OaYI8nG82OVSdyb/V1LuTHGQZOpL+O6khDfEunDQ2bPJoyhTQPMJnM+xw==
X-Received: by 2002:a1c:6607:: with SMTP id a7mr4491179wmc.129.1547273194237;
        Fri, 11 Jan 2019 22:06:34 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2d3c:9f00:9d02:40cb:9892:49cb])
        by smtp.gmail.com with ESMTPSA id f130sm20096766wme.41.2019.01.11.22.06.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 22:06:33 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Robert Love <robert.w.love@intel.com>,
        Robert Love <rlove@rlove.org>, Robert Love <rml@tech9.net>,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: drop PREEMPTIBLE KERNEL section entry
Date:   Sat, 12 Jan 2019 07:06:13 +0100
Message-Id: <20190112060613.7115-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PREEMPTIBLE KERNEL section entry seems quite outdated:

Robert Love is not actively maintaining the file anymore, nor a recorded
contributor to the files in the PREEMPTIBLE KERNEL section for the last
few years.

The mailing list kpreempt-tech@lists.sourceforge.net does not exist
anymore; the website just points to some very old patches for v2.4/v2.5.

So, let's delete the PREEMPTIBLE KERNEL section entry and clean this up:

- Documentation/preempt-locking.txt is not modified much anyway, and the
  changes in that file are generally maintained by Jonathan Corbet. So,
  we do not need to explicitly mention Documentation/preempt-locking.txt
  in MAINTAINERS.

- include/linux/preempt.h is maintained by Peter and Ingo, so we simply
  add that file to the SCHEDULER section entry.

I got directed to this issue, as I could not subscribe to the outdated
mailing list address and decided to investigate and then cleaned this up.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4b7967af08a4..14b991ebf2c1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12219,30 +12219,22 @@ F:	Documentation/ABI/testing/sysfs-pps
 F:	drivers/pps/
 F:	include/linux/pps*.h
 F:	include/uapi/linux/pps.h
 
 PPTP DRIVER
 M:	Dmitry Kozlov <xeb@mail.ru>
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/ppp/pptp.c
 W:	http://sourceforge.net/projects/accel-pptp
 
-PREEMPTIBLE KERNEL
-M:	Robert Love <rml@tech9.net>
-L:	kpreempt-tech@lists.sourceforge.net
-W:	https://www.kernel.org/pub/linux/kernel/people/rml/preempt-kernel
-S:	Supported
-F:	Documentation/preempt-locking.txt
-F:	include/linux/preempt.h
-
 PRINTK
 M:	Petr Mladek <pmladek@suse.com>
 M:	Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
 R:	Steven Rostedt <rostedt@goodmis.org>
 S:	Maintained
 F:	kernel/printk/
 F:	include/linux/printk.h
 
 PRISM54 WIRELESS DRIVER
 M:	Luis Chamberlain <mcgrof@kernel.org>
 L:	linux-wireless@vger.kernel.org
@@ -13449,22 +13441,23 @@ F:	drivers/watchdog/sc1200wdt.c
 
 SCHEDULER
 M:	Ingo Molnar <mingo@redhat.com>
 M:	Peter Zijlstra <peterz@infradead.org>
 L:	linux-kernel@vger.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
 S:	Maintained
 F:	kernel/sched/
 F:	include/linux/sched.h
 F:	include/uapi/linux/sched.h
 F:	include/linux/wait.h
+F:	include/linux/preempt.h
 
 SCR24X CHIP CARD INTERFACE DRIVER
 M:	Lubomir Rintel <lkundrak@v3.sk>
 S:	Supported
 F:	drivers/char/pcmcia/scr24x_cs.c
 
 SCSI CDROM DRIVER
 M:	Jens Axboe <axboe@kernel.dk>
 L:	linux-scsi@vger.kernel.org
 W:	http://www.kernel.dk
 S:	Maintained
-- 
2.17.1

