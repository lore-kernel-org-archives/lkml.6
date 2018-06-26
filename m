Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F98AC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 16:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 025CB26A4D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 16:20:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 025CB26A4D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752035AbeFZQUj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 12:20:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52736 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750977AbeFZQUi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 12:20:38 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AC7C34023444;
        Tue, 26 Jun 2018 16:20:37 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-238.rdu2.redhat.com [10.10.120.238])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2AF7D2026D6A;
        Tue, 26 Jun 2018 16:20:37 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net] KEYS: DNS: fix parsing multiple options
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 26 Jun 2018 17:20:36 +0100
Message-ID: <153003003654.32444.11061325096248904389.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Tue, 26 Jun 2018 16:20:37 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Tue, 26 Jun 2018 16:20:37 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

My recent fix for dns_resolver_preparse() printing very long strings was
incomplete, as shown by syzbot which still managed to hit the
WARN_ONCE() in set_precision() by adding a crafted "dns_resolver" key:

    precision 50001 too large
    WARNING: CPU: 7 PID: 864 at lib/vsprintf.c:2164 vsnprintf+0x48a/0x5a0

The bug this time isn't just a printing bug, but also a logical error
when multiple options ("#"-separated strings) are given in the key
payload.  Specifically, when separating an option string into name and
value, if there is no value then the name is incorrectly considered to
end at the end of the key payload, rather than the end of the current
option.  This bypasses validation of the option length, and also means
that specifying multiple options is broken -- which presumably has gone
unnoticed as there is currently only one valid option anyway.

Fix it by correctly calculating the length of the option name.

Reproducer:

    perl -e 'print "#A#", "\x00" x 50000' | keyctl padd dns_resolver desc @s

Fixes: 4a2d789267e0 ("DNS: If the DNS server returns an error, allow that to be cached [ver #2]")
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 net/dns_resolver/dns_key.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/dns_resolver/dns_key.c b/net/dns_resolver/dns_key.c
index 40c851693f77..d448823d4d2e 100644
--- a/net/dns_resolver/dns_key.c
+++ b/net/dns_resolver/dns_key.c
@@ -97,7 +97,7 @@ dns_resolver_preparse(struct key_preparsed_payload *prep)
 				return -EINVAL;
 			}
 
-			eq = memchr(opt, '=', opt_len) ?: end;
+			eq = memchr(opt, '=', opt_len) ?: next_opt;
 			opt_nlen = eq - opt;
 			eq++;
 			opt_vlen = next_opt - eq; /* will be -1 if no value */

