Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2329085-1517957223-2-6505940377833874888
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
    t=1517957223; b=VbhAXibJhoSTeli89ziD2GnI7okMRL8Y+RozG1Nrf0crhn3
    i0RiJMJ/aWxBB2s2OvRTJyDb3dwuW1FdzTJUXHc/ojf/RQ5I7i2BMWVpSG/MCoIo
    1l0DoabHc54x1YOy4i7BhgSX37JaoWgBz5mJDz98zaMRIxvhd1zGu5yo8mJvN1Rl
    GlgZ76eFHQAvVWNDtxlFFAkpN1xXF4JXYMzIYp9kUKd8X2Arx992lII6ZumuzWbt
    Tx0mfOTM++jzO9vzKKChfLMe1luiwyKd21411Jb7sZRoq2OazyVWfmcc94j1qx5U
    6l6pgpTe1+znWq2w4+qYvTKlCusrQmmnGQT/0bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:date:from:to:cc:subject
    :references:mime-version:content-type:sender:list-id; s=arctest;
    t=1517957223; bh=aXvmQJ9iURDbVEsehozaob+6JPQjIzKxV9ei6DKoEKk=; b=
    E9kAMHhxIYs+seN1Cu0YpAEfM0s5L+SOIuyeV7h5O+PVxByKnVuEiu+Avv+0wgcP
    giPf8fziCgig3ErQcKoKHOxuaKJuLwfDhLyjz6K0eBOlCWar5bGICfnSg6drCdp6
    1LKGm7Z6pYQ4ZKloB8347WIKrQkdbRWPrMmAsJvaYfC1nBYN6O4wQDv0Zkp9r3kB
    180o5nM3xhPhj+O1rmnzXNMgjkCUWQvqE5T5CPX6QrrDwU2Odc7Im9/6Iy542AE1
    IKnpUlCS9C3Vdcl4Tj8A+8sefmvbghWH2Vk+lB9ED7EF8pqwJqHhHDbo5l/o2Ua4
    yRk2N3HMCN9vhxxW7mf4yg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=goodmis.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=goodmis.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=goodmis.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=goodmis.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753649AbeBFWpp (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Feb 2018 17:45:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:37696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753235AbeBFWpo (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 6 Feb 2018 17:45:44 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86D23217AA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180206224541.082571667@goodmis.org>
User-Agent: quilt/0.63-1
Date: Tue, 06 Feb 2018 17:43:39 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>, stable@vger.kernel.org
Subject: [RFC][PATCH 1/6] ftrace: Remove incorrect setting of glob search field
References: <20180206224338.446477232@goodmis.org>
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
Cc: Dmitry Safonov <0x7f454c46@gmail.com>
Fixes: 3ba009297149f ("ftrace: Introduce ftrace_glob structure")
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
