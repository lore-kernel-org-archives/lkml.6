Return-Path: <kernel-hardening-return-11818-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x224p3Ig/bUyz3X502hinhEmhzV2ObvfhnRrHIVxKWYASfNy42CWhK8kt/Y89/klFwIzo0pln
ARC-Seal: i=1; a=rsa-sha256; t=1519008690; cv=none;
        d=google.com; s=arc-20160816;
        b=zy4AebXxM63WQkoI4XE+m+Xvr8ajdPXJuOBve9Kw/P9Gv3/0Dl6yqJ7bmtMeofkGB6
         K3ZS7a3aW/2aZ3QBQFPFBf3rSIMBNL1H9W2o8w5WuLBN6JdIekoq25ggvxtld0nDK9sj
         wHintlZVQc12okk8xTie+9O5yXoxEI6eRgibb9MXj6l1SrYLDqnvvSR22Nz5vNs3ASRl
         dMEv0ZTntPBW4TZgTEATAiQny+yZXUvWy4rUEFq/fhpp6EqDdwfEqXlIO7FZ/Yzz+6vo
         Jkr5yudnz7u7gUUugY4U22QxFr4NhZ1QGzzOzP7loks+oV4VsApqqT9buuC4XxQI0gxV
         v86w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-signature:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=wNKDrZ+zIgYg1yyn1wDiQdiQjjWWzuKIOYt96iYicug=;
        b=wDQJW43YYukVte78XxOh2ImjBqKCyGAha9mYsgUAmDQWCnwpfIB+PZye4duVAim62C
         GtX2NiavS2l6JeiikumpkOCyQhXDlScgqrsljUjzbpa6lWPBcUMB3wJqgcuFEB4hppn8
         08YlWCfGhhIn74XJ6Qa+YPqP9Ji8W5Sx06ZlzjVjKsJlPe+LV8XchQ6FEEX17O4wufkS
         OlyCGTGT0Y+Ce1iZqk4pB5gnLLNpvjwkkanz/LdW5dHGxVfI3VemfkWCDDWUa5OPlq49
         aIi/fkDSpZqAG6iLQB3m/WU7mQ8uysBeHvu9wZi+fw74pR/eoUT8+WdjxcWyJ6uqvoxm
         /e+Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm2 header.b=NNMRITuz;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=QPo0GJMy;
       spf=pass (google.com: domain of kernel-hardening-return-11818-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11818-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm2 header.b=NNMRITuz;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=QPo0GJMy;
       spf=pass (google.com: domain of kernel-hardening-return-11818-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11818-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
X-ME-Sender: <xms:lTuKWvsI4i8LGoWT9uffqMzWVge5xxNw2ptt6fO7lAdhGGCJUkrgHQ>
From: "Tobin C. Harding" <me@tobin.cc>
To: Kernel Hardening <kernel-hardening@lists.openwall.com>
Cc: "Tobin C. Harding" <me@tobin.cc>,
	Tycho Andersen <tycho@tycho.ws>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/4] leaking_addresses: do not parse binary files
Date: Mon, 19 Feb 2018 13:50:46 +1100
Message-Id: <1519008649-15782-2-git-send-email-me@tobin.cc>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519008649-15782-1-git-send-email-me@tobin.cc>
References: <1519008649-15782-1-git-send-email-me@tobin.cc>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592796056681057091?=
X-GMAIL-MSGID: =?utf-8?q?1592796056681057091?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Currently script parses binary files.  Since we are scanning for
readable kernel addresses there is no need to parse binary files.  We
can use Perl to check if file is binary and skip parsing it if so.

Do not parse binary files.

Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 scripts/leaking_addresses.pl | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/leaking_addresses.pl b/scripts/leaking_addresses.pl
index 05906f6cf6b9..3d5c3096aac8 100755
--- a/scripts/leaking_addresses.pl
+++ b/scripts/leaking_addresses.pl
@@ -462,6 +462,10 @@ sub parse_file
 		return;
 	}
 
+	if (! -T $file) {
+		return;
+	}
+
 	if (skip_parse($file)) {
 		dprint "skipping file: $file\n";
 		return;
-- 
2.7.4
