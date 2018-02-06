Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2292549-1517957149-2-16862745098207792101
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
    t=1517957149; b=ru5A2HD7d14hDKCNoqwlg17phCglkiuwWH741Fz3cPikvMM
    UzfYFddAQSUT8lW/2FEGsQW2YFMV641qGZ6e7NKMxq7JG/0MeK+O4Cx3nVHGkx0d
    y8u4y1TH6ScI/+0nKOuazO3DqKJrEnB+HQfVZSGuKzzNwEiuS95lUr1TWEgccbzb
    odj9O7JHpYadOQMCtvK41zeSUDwogpziU6ZcE/Bq+j1CJuRMez2jRCT7AOl1Ox3m
    mSHFXtVXN+YLG3V8XFjpTZ350xqs30OM7B6g1mmGtyUc2XLdFpAqpAtbcWFjC0Cv
    KkTFqKegomaxqiBIb4N34U3Pg2uSEFJ67zXEhFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:date:from:to:cc:subject
    :references:mime-version:content-type:sender:list-id; s=arctest;
    t=1517957149; bh=FS84x35SfmHnYJgg3yVOvlQgdepOzsnDNcaawJy+TYc=; b=
    YcGAdf4aV55zqYPvB3INW/rI+bwQcL7EAlDQg++6TYPR+2G3+7HyuerkB33Fsiug
    POP/GLLUx79spV0IC5amN/5Xq5LBHvskavAZmbqqxAGnay+7bTl3MFcLtXy9Psll
    DAO4vjqHR/PCu2MqzzCvz3wWiFPfGATVHwggWuug7+LGFMElTzwLqjvdUe7eFLEx
    /EB04GYdw8JPuj1k+NT8AYHiUyeqZ8LHIGfdgmAzOLosvHcz9pkZ5yFR7vOLqo2m
    T/W+rlibZ7ML0Rawz0+5Rkr83FqAjwhl68trjOiHuw5Axk+/rluh78gUNkXS8s1r
    3Ikf1IGkPq05YIiABXNzig==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=goodmis.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=goodmis.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=goodmis.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=goodmis.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753314AbeBFWpq (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Feb 2018 17:45:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:37690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753171AbeBFWpo (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 6 Feb 2018 17:45:44 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ED92217B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180206224541.231476648@goodmis.org>
User-Agent: quilt/0.63-1
Date: Tue, 06 Feb 2018 17:43:40 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>, stable@vger.kernel.org
Subject: [RFC][PATCH 2/6] tracing: Fix parsing of globs with a wildcard at the beginning
References: <20180206224338.446477232@goodmis.org>
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
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Fixes: 60f1d5e3bac44 ("ftrace: Support full glob matching")
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
