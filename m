Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FFEEECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B1CD20856
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:30:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B1CD20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388233AbeGTNS0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:18:26 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38200 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727518AbeGTNSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:18:25 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 57BB1BCF;
        Fri, 20 Jul 2018 12:29:42 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, syzbot <syzkaller@googlegroups.com>,
        Eric Biggers <ebiggers@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 39/66] KEYS: DNS: fix parsing multiple options
Date:   Fri, 20 Jul 2018 14:13:56 +0200
Message-Id: <20180720121409.498446443@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720121407.228772286@linuxfoundation.org>
References: <20180720121407.228772286@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/dns_resolver/dns_key.c |   30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

--- a/net/dns_resolver/dns_key.c
+++ b/net/dns_resolver/dns_key.c
@@ -87,35 +87,39 @@ dns_resolver_preparse(struct key_prepars
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
 


