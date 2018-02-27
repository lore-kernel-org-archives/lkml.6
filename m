Return-Path: <kernel-hardening-return-11990-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELsQMQ1NnSCUlk0Xbo3TbQJ5XCwlhylbbaVFqx2E1kfVPJx2QIbgkLFukT75GfZso5U7c1bW
ARC-Seal: i=1; a=rsa-sha256; t=1519706759; cv=none;
        d=google.com; s=arc-20160816;
        b=IcLr0DpGOC4dALyVVaJ/Uu1nM8b88SxQcFDsq3MyHVDGkEL3N4Cm7sxO7YOSHt/flA
         BHGF+jRT716kgBRhwnDUTb55jLs8SLydMF9zBnAjsvw/OeP5A1oPi3+bfZCRpKu1qXkx
         NFfHozslnscJbjJWimoyTgS0n/610dSIauJjTyyyQpWNx3QIRgsq7YmBdlM5w3WpUWSI
         818qozzlAwOpigxF9Uh8CXHEF78SBlJ4XrfNAdWDzA5k9JwSqGRA0kVI0G86e1znLIYE
         3JrV9t0lXuVNkW9+hrMqbUtbdsAXrLKiQTUGroEgNG0WxZYGXWHAZJWhDSRUOGSuzBxQ
         2t/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-signature:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=gUBKdolFc0w/IlaLBAmeHqsoAro/iin3sJJv8C733sQ=;
        b=Jky+ldDgVG3VhW2weV41dSxNYL6f4/5aCZXn8fBE29fNHmAAMkyuMXENDhF0HCD1Qz
         K3Sq0RlQQnQljqY8C5BEZ/IDT2wx77sNzJuVbH6du5nCw7mAEMbIHFoyEidSCIb2AMAR
         z1TuYOAcPIdepEf7xow0wrjp3ouNDpKxfThQg9QNg7xHZ8wDrG9fIs4z3Z0UT9QQx0xz
         kBhOaACA+xaZKV4x0wXJyhXOw/E7H8bUCMy1nQ1tR8GZQr0oar052ZXgufaV7fa7pLN+
         RVxDXPKHduKnsK9K4r0G2NcpXUqqyj9AOsXth6SsfEsjOn4TMHSf+gfkW3bnrKn1pqqX
         xwpQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm2 header.b=s19EOirG;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=V8M8r1bl;
       spf=pass (google.com: domain of kernel-hardening-return-11990-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11990-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm2 header.b=s19EOirG;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=V8M8r1bl;
       spf=pass (google.com: domain of kernel-hardening-return-11990-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11990-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
X-ME-Sender: <xms:aOKUWpXC5TvrGakQtCwYSovPXF1_NePsXUczW6N-dqhyArdVW4f3jw>
From: "Tobin C. Harding" <me@tobin.cc>
To: Kernel Hardening <kernel-hardening@lists.openwall.com>
Cc: "Tobin C. Harding" <me@tobin.cc>,
	Tycho Andersen <tycho@tycho.ws>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] leaking_addresses: skip '/proc/1/syscall'
Date: Tue, 27 Feb 2018 15:45:10 +1100
Message-Id: <1519706711-18580-3-git-send-email-me@tobin.cc>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519706711-18580-1-git-send-email-me@tobin.cc>
References: <1519706711-18580-1-git-send-email-me@tobin.cc>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593528034910059036?=
X-GMAIL-MSGID: =?utf-8?q?1593528034910059036?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The pointers listed in /proc/1/syscall are user pointers, and negative
syscall args will show up like kernel addresses.

For example

/proc/31808/syscall: 0 0x3 0x55b107a38180 0x2000 0xffffffffffffffb0 \
0x55b107a302d0 0x55b107a38180 0x7fffa313b8e8 0x7ff098560d11

Skip parsing /proc/1/syscall

Reported-by: Tycho Andersen <tycho@tycho.ws>
Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 scripts/leaking_addresses.pl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/leaking_addresses.pl b/scripts/leaking_addresses.pl
index fb40e2828f43..ac84a164a528 100755
--- a/scripts/leaking_addresses.pl
+++ b/scripts/leaking_addresses.pl
@@ -60,6 +60,7 @@ my $page_offset_32bit = 0;	# Page offset for 32-bit kernel.
 my @skip_abs = (
 	'/proc/kmsg',
 	'/proc/device-tree',
+	'/proc/1/syscall',
 	'/sys/firmware/devicetree',
 	'/sys/kernel/debug/tracing/trace_pipe',
 	'/sys/kernel/security/apparmor/revision');
-- 
2.7.4
