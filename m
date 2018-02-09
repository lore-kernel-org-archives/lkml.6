Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2049716-1518206645-2-13980103523483433001
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='ISO-8859-15'
X-Attached: 0002-tracing-Fix-parsing-of-globs-with-a-wildcard-at-the-.patch
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518206644; b=gONIMYpEeoyV8TFgo19nBzY9lO1saCC9Wx6LnImJtD7YUu0
    Rkx6sVvUCnatdo9bI8Jh4pKU9k1j4PbL/+hSl1FXUZmhfgulCJRGuexUtW0Rl0tK
    ArF7PhWpNHmLkrTJ4KG6Zu/Lx9TaDsi8+c/e16d6Wd5y8Rd5yxXKbwMcOtqotyRZ
    VqFfrtWikTFkV8PcXsAvCZ1tjO1PaOyJrWwUubzBMUfgg4CBJG0DufeLwjHyA91J
    2Zzse3JJPjuFQzfZRX5zZufevNCkuy27G1gqr7lkRwYRP98p4VbCsv0QNBVKhowA
    E7kCe2Rd/qp+VLozjSMXAejqV8Jtv/luhAxl3iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:date:from:to:cc:subject
    :references:mime-version:content-type:sender:list-id; s=arctest;
    t=1518206644; bh=xcWkYwuDlO/jUY0orU7m6lyXP32FTIF4BMXoJqfaDOg=; b=
    BBeXK/XNRmlgzIbPNChCabgO+ZXSNNAM0JQA4ZvTrmyjMnQLS7nb6ntFz8Ff/jd7
    GTq2xI6uQh9AppwuFr6G0JQuISqqeHA/04flJ03fksDqoIX+RhH3ckJ0ctJ8hShJ
    5Qa3HwNcX7YSPOCkiDa8mVcKVPIhp5zhRXl/M+uyUB/QmRxORlAQ+nj+21lft7ab
    9Lp7hvsDNA+Srntgxk5BuSwZMWlIRmxOJsKkr39QSKUbFJWv83fsLkAocvZqd+E+
    E4cB7SsJuqXIOh001IiJBQEPWtr6tRtJrseTlVCWUb1NZkvzyOanYuUl+VfU9aCv
    jeHmoL8+jzAC2/0ZDCEnGA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=goodmis.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=goodmis.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=goodmis.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=goodmis.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752604AbeBIUEB (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 15:04:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:52552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752190AbeBIUEB (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 9 Feb 2018 15:04:01 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55EA2217AA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180209200359.343519342@goodmis.org>
User-Agent: quilt/0.63-1
Date: Fri, 09 Feb 2018 15:03:06 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>, stable@vger.kernel.org
Subject: [PATCH 2/6] tracing: Fix parsing of globs with a wildcard at the beginning
References: <20180209200304.703130163@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0002-tracing-Fix-parsing-of-globs-with-a-wildcard-at-the-.patch
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Al Viro reported:

    For substring - sure, but what about something like "*a*b" and "a*b"?
    AFAICS, filter_parse_regex() ends up with identical results in both
    cases - MATCH_GLOB and *search = "a*b".  And no way for the caller
    to tell one from another.

Testing this with the following:

 # cd /sys/kernel/tracing
 # echo '*raw*lock' > set_ftrace_filter
 bash: echo: write error: Invalid argument

With this patch:

 # echo '*raw*lock' > set_ftrace_filter
 # cat set_ftrace_filter
_raw_read_trylock
_raw_write_trylock
_raw_read_unlock
_raw_spin_unlock
_raw_write_unlock
_raw_spin_trylock
_raw_spin_lock
_raw_write_lock
_raw_read_lock

Al recommended not setting the search buffer to skip the first '*' unless we
know we are not using MATCH_GLOB. This implements his suggested logic.

Link: http://lkml.kernel.org/r/20180127170748.GF13338@ZenIV.linux.org.uk

Cc: stable@vger.kernel.org
Fixes: 60f1d5e3bac44 ("ftrace: Support full glob matching")
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Reported-by: Al Viro <viro@ZenIV.linux.org.uk>
Suggsted-by: Al Viro <viro@ZenIV.linux.org.uk>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_filter.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 61e7f0678d33..a764aec3c9a1 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -400,7 +400,6 @@ enum regex_type filter_parse_regex(char *buff, int len, char **search, int *not)
 	for (i = 0; i < len; i++) {
 		if (buff[i] == '*') {
 			if (!i) {
-				*search = buff + 1;
 				type = MATCH_END_ONLY;
 			} else if (i == len - 1) {
 				if (type == MATCH_END_ONLY)
@@ -410,14 +409,14 @@ enum regex_type filter_parse_regex(char *buff, int len, char **search, int *not)
 				buff[i] = 0;
 				break;
 			} else {	/* pattern continues, use full glob */
-				type = MATCH_GLOB;
-				break;
+				return MATCH_GLOB;
 			}
 		} else if (strchr("[?\\", buff[i])) {
-			type = MATCH_GLOB;
-			break;
+			return MATCH_GLOB;
 		}
 	}
+	if (buff[0] == '*')
+		*search = buff + 1;
 
 	return type;
 }
-- 
2.15.1
