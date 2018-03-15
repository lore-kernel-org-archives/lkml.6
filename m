Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-247771-1521118288-2-760519838779826089
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521118288; b=R9yCGgrF+XPpulIko1HOmYvdW1H5dJpWoNodKoaKww33NGM
    uLifhxnYlmhHHbtJD8J546gEQ7UAF9ar4SJaEKBaVyMHjqGnWJWR+CnaUh8a+Nfw
    nLHMaU2F7xPhLVA6p8VZHHbHKEfR58blsrZeKTdtCWI7RSbndSCudA30hZW7aYm9
    cimONR8vvejfNlx2M8VSLkZqOnop/B9/cXgcjC9poXURy9Ull0KR9WdSjOj8VjLr
    YYj8yhjN3dt9Mnt6LLLFIRCkTDvTP6Rpm9dfUSfifobtG5bM5g7Hw3M4nczxe+kU
    lgQaAwMPeyZYLZPS9IIdyyCTAzULORNwbXah/iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1521118288; bh=HzrNvzMRMWMco61cJAYlcqCeg4
    g33JOoGLy+AjS4CfE=; b=jOzCif0ShC5O+ocCttPkzo2AmJH+tfjyxfLi6Y3bv5
    Bs7mVLuFNpdnVJuFfs8YRPCsiGeMgNjkxnGhl9EsfW9dbpvoW/dN3MQqe81CYGzD
    3qIwBDOGGDldU+XcmAUXHBJCsBFLhUHYBntzORkfl7NcM+2YeynR3rwVNxP+xtIC
    VX5qqjCqUdAzQTgAGH3UPPSrljAeGsUsjOOVjm4a0vRVSEXHkwIdiUGsQI0EZBsK
    WCdZzZDmFDNnXQoUYxj5xmBk5CVAMprl+M45uEuAuSt5bJEtsF+XerHqPTTphLuq
    evZrzVb2wsPm46QWPIKbY1E+EYBCDmLkIJHrCwQ2/swQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=efficios.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=efficios.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=efficios.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=efficios.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752131AbeCOMv0 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Mar 2018 08:51:26 -0400
Received: from mail.efficios.com ([167.114.142.138]:48400 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751982AbeCOMvZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Mar 2018 08:51:25 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>, stable@vger.kernel.org
Subject: [PATCH] Fix: tracepoint: do not warn on ENOMEM
Date: Thu, 15 Mar 2018 08:44:24 -0400
Message-Id: <20180315124424.32319-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Tracepoint should only warn when a kernel API user does not respect the
required preconditions (e.g. same tracepoint enabled twice, or called
to remove a tracepoint that does not exist).

Silence warning in out-of-memory conditions, given that the error is
returned to the caller.

This ensures that out-of-memory error-injection testing does not trigger
warnings in tracepoint.c, which were seen by syzbot.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Reported-by: syzbot+9c0d616860575a73166a@syzkaller.appspotmail.com
Reported-by: syzbot+4e9ae7fa46233396f64d@syzkaller.appspotmail.com
CC: Steven Rostedt <rostedt@goodmis.org>
CC: Ingo Molnar <mingo@redhat.com>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Jiri Olsa <jolsa@redhat.com>
CC: Arnaldo Carvalho de Melo <acme@kernel.org>
CC: Alexander Shishkin <alexander.shishkin@linux.intel.com>
CC: Namhyung Kim <namhyung@kernel.org>
CC: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/001a114465e241a8720567419a72@google.com
Link: https://lkml.kernel.org/r/001a1140e0de15fc910567464190@google.com
---
 kernel/tracepoint.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 671b13457387..1e37da2e0c25 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -207,7 +207,7 @@ static int tracepoint_add_func(struct tracepoint *tp,
 			lockdep_is_held(&tracepoints_mutex));
 	old = func_add(&tp_funcs, func, prio);
 	if (IS_ERR(old)) {
-		WARN_ON_ONCE(1);
+		WARN_ON_ONCE(PTR_ERR(old) != -ENOMEM);
 		return PTR_ERR(old);
 	}
 
@@ -239,7 +239,7 @@ static int tracepoint_remove_func(struct tracepoint *tp,
 			lockdep_is_held(&tracepoints_mutex));
 	old = func_remove(&tp_funcs, func);
 	if (IS_ERR(old)) {
-		WARN_ON_ONCE(1);
+		WARN_ON_ONCE(PTR_ERR(old) != -ENOMEM);
 		return PTR_ERR(old);
 	}
 
-- 
2.11.0
