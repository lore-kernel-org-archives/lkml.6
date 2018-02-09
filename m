Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2049716-1518206689-2-4949858047228820351
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='ISO-8859-15'
X-Attached: 0001-ftrace-Remove-incorrect-setting-of-glob-search-field.patch
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518206688; b=op7VJeL7TLO27G3wTwtr6LO/gvq0kor3Ww+MJiCCEZbFhbX
    1/6dNA19i3tn+Zj3ns1gGJXWcb6eAoJTKHp8cNbRzre1eS2VrBQnQBB0fO9QK+FH
    dg9/D72rIXElv3nNfr9cR0xpA4l3cPUlSTbxmMf4Zt4IFxX1WegUzzZRdx4hhrgz
    75E9X7AjtIZWqDhrkQvV5YeP9MRTx1fbEbbDexkYGumtU6VqMcF9HYzslWQSqKd1
    b0K7//dN0FH2OCap2AUuM7bIyJotwxxHmN6WpGfoqbEKUDgD16G1gM5JbOY+yr0b
    WFjQp0ychKADAaB/8yJxBSqQNyq6IptZSQVS6aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:date:from:to:cc:subject
    :references:mime-version:content-type:sender:list-id; s=arctest;
    t=1518206688; bh=PClKy3zmqZkrGo6G4FrxO8Hx9UWztYUyQO8AQbcZWEs=; b=
    iGGTJ/aI15Dti7CxaFRVY+2Gdj8ziGD5pXEUoMwFeRYKKFgOXlsAkSVewtA2tZm2
    xu+ZufqzWY2d7ro/KGiPhFu3rwFaLwpqPeG4QfHiTCHkaA9guCW4TL3Gi5tPsBzf
    wdHgYtJtSA9+MUpGRw4KsMQAgCE/fCGTDL7tVwNQh36FHA8u0v/JKzrd0z+AYoFH
    6YEp3fz48pHWaRbgOPpwyM+o7SEOTTwTFz4z6yMgmLHpxHOBtwLms7tMfEbTanRb
    VgSIqUhVKmHAxZlPOfvTIo2UoHS+QW5dymPfsiFfyYORrCBR9WmPh2f85Ra5JwI4
    +XxTENHuzOXk2CTayGxygw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=goodmis.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=goodmis.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=goodmis.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=goodmis.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752643AbeBIUEC (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 15:04:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:52548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752560AbeBIUEB (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 9 Feb 2018 15:04:01 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CB67217A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180209200359.208217487@goodmis.org>
User-Agent: quilt/0.63-1
Date: Fri, 09 Feb 2018 15:03:05 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>, stable@vger.kernel.org
Subject: [PATCH 1/6] ftrace: Remove incorrect setting of glob search field
References: <20180209200304.703130163@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0001-ftrace-Remove-incorrect-setting-of-glob-search-field.patch
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

__unregister_ftrace_function_probe() will incorrectly parse the glob filter
because it resets the search variable that was setup by filter_parse_regex().

Al Viro reported this:

    After that call of filter_parse_regex() we could have func_g.search not
    equal to glob only if glob started with '!' or '*'.  In the former case
    we would've buggered off with -EINVAL (not = 1).  In the latter we
    would've set func_g.search equal to glob + 1, calculated the length of
    that thing in func_g.len and proceeded to reset func_g.search back to
    glob.

    Suppose the glob is e.g. *foo*.  We end up with
	    func_g.type = MATCH_MIDDLE_ONLY;
	    func_g.len = 3;
	    func_g.search = "*foo";
    Feeding that to ftrace_match_record() will not do anything sane - we
    will be looking for names containing "*foo" (->len is ignored for that
    one).

Link: http://lkml.kernel.org/r/20180127031706.GE13338@ZenIV.linux.org.uk

Cc: stable@vger.kernel.org
Fixes: 3ba009297149f ("ftrace: Introduce ftrace_glob structure")
Reviewed-by: Dmitry Safonov <0x7f454c46@gmail.com>
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Reported-by: Al Viro <viro@ZenIV.linux.org.uk>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index dabd9d167d42..eac9ce2c57a2 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -4456,7 +4456,6 @@ unregister_ftrace_function_probe_func(char *glob, struct trace_array *tr,
 		func_g.type = filter_parse_regex(glob, strlen(glob),
 						 &func_g.search, &not);
 		func_g.len = strlen(func_g.search);
-		func_g.search = glob;
 
 		/* we do not support '!' for function probes */
 		if (WARN_ON(not))
-- 
2.15.1
