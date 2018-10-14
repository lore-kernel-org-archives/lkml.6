Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 578CEC71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27CAD20876
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:30:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27CAD20876
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbeJNXMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:12:15 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36485 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728373AbeJNXMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:12:14 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiM1-0004io-TR; Sun, 14 Oct 2018 16:30:54 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLT-0000Mt-Cw; Sun, 14 Oct 2018 16:30:19 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Eric Biggers" <ebiggers@google.com>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "David S. Miller" <davem@davemloft.net>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.188282517@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 168/366] KEYS: DNS: limit the length of option strings
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

commit 9c438d7a3a52dcc2b9ed095cb87d3a5e83cf7e60 upstream.

Adding a dns_resolver key whose payload contains a very long option name
resulted in that string being printed in full.  This hit the WARN_ONCE()
in set_precision() during the printk(), because printk() only supports a
precision of up to 32767 bytes:

    precision 1000000 too large
    WARNING: CPU: 0 PID: 752 at lib/vsprintf.c:2189 vsnprintf+0x4bc/0x5b0

Fix it by limiting option strings (combined name + value) to a much more
reasonable 128 bytes.  The exact limit is arbitrary, but currently the
only recognized option is formatted as "dnserror=%lu" which fits well
within this limit.

Also ratelimit the printks.

Reproducer:

    perl -e 'print "#", "A" x 1000000, "\x00"' | keyctl padd dns_resolver desc @s

This bug was found using syzkaller.

Reported-by: Mark Rutland <mark.rutland@arm.com>
Fixes: 4a2d789267e0 ("DNS: If the DNS server returns an error, allow that to be cached [ver #2]")
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 3.16:
 - Also stop logging the key serial number
 - Include <linux/ratelimit.h> directly]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/net/dns_resolver/dns_key.c
+++ b/net/dns_resolver/dns_key.c
@@ -29,6 +29,7 @@
 #include <linux/keyctl.h>
 #include <linux/err.h>
 #include <linux/seq_file.h>
+#include <linux/ratelimit.h>
 #include <keys/dns_resolver-type.h>
 #include <keys/user-type.h>
 #include "internal.h"
@@ -93,10 +94,9 @@ dns_resolver_instantiate(struct key *key
 
 			next_opt = memchr(opt, '#', end - opt) ?: end;
 			opt_len = next_opt - opt;
-			if (!opt_len) {
-				printk(KERN_WARNING
-				       "Empty option to dns_resolver key %d\n",
-				       key->serial);
+			if (opt_len <= 0 || opt_len > 128) {
+				pr_warn_ratelimited("Invalid option length (%d) for dns_resolver key\n",
+						    opt_len);
 				return -EINVAL;
 			}
 
@@ -130,10 +130,8 @@ dns_resolver_instantiate(struct key *key
 			}
 
 		bad_option_value:
-			printk(KERN_WARNING
-			       "Option '%*.*s' to dns_resolver key %d:"
-			       " bad/missing value\n",
-			       opt_nlen, opt_nlen, opt, key->serial);
+			pr_warn_ratelimited("Option '%*.*s' to dns_resolver key: bad/missing value\n",
+					    opt_nlen, opt_nlen, opt);
 			return -EINVAL;
 		} while (opt = next_opt + 1, opt < end);
 	}

