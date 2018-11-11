Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 705E9C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BB1020818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:24:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BB1020818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731089AbeKLGOH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:14:07 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51090 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730695AbeKLFsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:30 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsq-0000oF-Ld; Sun, 11 Nov 2018 19:59:00 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsW-0001k1-VY; Sun, 11 Nov 2018 19:58:40 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "David S. Miller" <davem@davemloft.net>,
        "syzbot" <syzkaller@googlegroups.com>,
        "Eric Biggers" <ebiggers@google.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.484128702@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 263/366] KEYS: DNS: fix parsing multiple options
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

commit c604cb767049b78b3075497b80ebb8fd530ea2cc upstream.

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

A similar problem also applied to option values, as the kstrtoul() when
parsing the "dnserror" option will read past the end of the current
option and into the next option.

Fix these bugs by correctly computing the length of the option name and
by copying the option value, null-terminated, into a temporary buffer.

Reproducer for the WARN_ONCE() that syzbot hit:

    perl -e 'print "#A#", "\0" x 50000' | keyctl padd dns_resolver desc @s

Reproducer for "dnserror" option being parsed incorrectly (expected
behavior is to fail when seeing the unknown option "foo", actual
behavior was to read the dnserror value as "1#foo" and fail there):

    perl -e 'print "#dnserror=1#foo\0"' | keyctl padd dns_resolver desc @s

Reported-by: syzbot <syzkaller@googlegroups.com>
Fixes: 4a2d789267e0 ("DNS: If the DNS server returns an error, allow that to be cached [ver #2]")
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/dns_resolver/dns_key.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

--- a/net/dns_resolver/dns_key.c
+++ b/net/dns_resolver/dns_key.c
@@ -89,35 +89,39 @@ dns_resolver_instantiate(struct key *key
 		opt++;
 		kdebug("options: '%s'", opt);
 		do {
+			int opt_len, opt_nlen;
 			const char *eq;
-			int opt_len, opt_nlen, opt_vlen, tmp;
+			char optval[128];
 
 			next_opt = memchr(opt, '#', end - opt) ?: end;
 			opt_len = next_opt - opt;
-			if (opt_len <= 0 || opt_len > 128) {
+			if (opt_len <= 0 || opt_len > sizeof(optval)) {
 				pr_warn_ratelimited("Invalid option length (%d) for dns_resolver key\n",
 						    opt_len);
 				return -EINVAL;
 			}
 
-			eq = memchr(opt, '=', opt_len) ?: end;
-			opt_nlen = eq - opt;
-			eq++;
-			opt_vlen = next_opt - eq; /* will be -1 if no value */
-
-			tmp = opt_vlen >= 0 ? opt_vlen : 0;
-			kdebug("option '%*.*s' val '%*.*s'",
-			       opt_nlen, opt_nlen, opt, tmp, tmp, eq);
+			eq = memchr(opt, '=', opt_len);
+			if (eq) {
+				opt_nlen = eq - opt;
+				eq++;
+				memcpy(optval, eq, next_opt - eq);
+				optval[next_opt - eq] = '\0';
+			} else {
+				opt_nlen = opt_len;
+				optval[0] = '\0';
+			}
+
+			kdebug("option '%*.*s' val '%s'",
+			       opt_nlen, opt_nlen, opt, optval);
 
 			/* see if it's an error number representing a DNS error
 			 * that's to be recorded as the result in this key */
 			if (opt_nlen == sizeof(DNS_ERRORNO_OPTION) - 1 &&
 			    memcmp(opt, DNS_ERRORNO_OPTION, opt_nlen) == 0) {
 				kdebug("dns error number option");
-				if (opt_vlen <= 0)
-					goto bad_option_value;
 
-				ret = kstrtoul(eq, 10, &derrno);
+				ret = kstrtoul(optval, 10, &derrno);
 				if (ret < 0)
 					goto bad_option_value;
 

