Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225lL59CZYeHq1R4QWcT295jMzGQ4duc3rHZrqsi77q1b19tVwc0v3xJJNCZIP4uLolsBMtm
ARC-Seal: i=1; a=rsa-sha256; t=1519410791; cv=none;
        d=google.com; s=arc-20160816;
        b=PJyJi3c+ZH0HmNOXtwTD9xwsgKY8ieh1Fw/EOqFeHMiH9aGW6cLRZcaSOoRBb0MNZz
         CHPDYZOvqLWK77vxDDhNqfwAZfDbPEnj4dGVcK5ypSivL24r7h13q1Scnx3Bcfwt0yJk
         7M6BaXNT40L3l7g1YjQwBp74VPiPkkFErvB9ZrZPMB/i8XX1RMohoxVhKvaYDBbER2Ax
         aJQFxnAXshc+6CKRZ2MS4GW9lT87lquWKsqLFIUQHqMXdPQ+U3As/fabqx/PvxIdlwGj
         UOQx/UoOjHELA1hTSjkToYYfnCZlO9w/p1F7Im7LbCp/DADznLNdqeTMVHp79BIHQZ6G
         Ou/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=EC/AQ3pwxtCBvbGUxxr1jCi3B+iN7oZgR7MOtgrM9j0=;
        b=qSxRp7ttpCNcYkcuvQmonB2nD3SpR/aK8ahkrJy7JwdT5wCKfZ4xfT7EiF6wjMWWun
         T7KCnthwcvQAT13NrV8RoGUES007RoTUF2CFynsyGW/U04vnVdzJorxKWWHrK3MQFYtP
         QPzaw6TgfcSYgqdDFF8oU7iDcQh8h7tvwZ+asvvInrIwqDxbfcJw2zhbY+WpZ9sfagmD
         mr0B3SSH6cJhabzVZWmTTeM41dRukG4EEMmkx/KzYILjwpAlkVz9ZEduuh+B5Whdu8ix
         ZuaIF5GYGbDdooDHSpcHNcWwxsMUxw8Wg5Yv6d7cc65gJZE7vb/Q+tKfIGIJTiQsVOF9
         ikLA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	syzbot <syzkaller@googlegroups.com>,
	Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.4 016/193] netfilter: x_tables: avoid out-of-bounds reads in xt_request_find_{match|target}
Date: Fri, 23 Feb 2018 19:24:09 +0100
Message-Id: <20180223170328.642062300@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217537889132709?=
X-GMAIL-MSGID: =?utf-8?q?1593217690202040027?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

commit da17c73b6eb74aad3c3c0654394635675b623b3e upstream.

It looks like syzbot found its way into netfilter territory.

Issue here is that @name comes from user space and might
not be null terminated.

Out-of-bound reads happen, KASAN is not happy.

v2 added similar fix for xt_request_find_target(),
as Florian advised.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Acked-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/netfilter/x_tables.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/net/netfilter/x_tables.c
+++ b/net/netfilter/x_tables.c
@@ -206,6 +206,9 @@ xt_request_find_match(uint8_t nfproto, c
 {
 	struct xt_match *match;
 
+	if (strnlen(name, XT_EXTENSION_MAXNAMELEN) == XT_EXTENSION_MAXNAMELEN)
+		return ERR_PTR(-EINVAL);
+
 	match = xt_find_match(nfproto, name, revision);
 	if (IS_ERR(match)) {
 		request_module("%st_%s", xt_prefix[nfproto], name);
@@ -248,6 +251,9 @@ struct xt_target *xt_request_find_target
 {
 	struct xt_target *target;
 
+	if (strnlen(name, XT_EXTENSION_MAXNAMELEN) == XT_EXTENSION_MAXNAMELEN)
+		return ERR_PTR(-EINVAL);
+
 	target = xt_find_target(af, name, revision);
 	if (IS_ERR(target)) {
 		request_module("%st_%s", xt_prefix[af], name);
