Return-Path: <kernel-hardening-return-11820-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x224jT5b0M8LRNJJNHzNfQsMJ04JIUzn1uh802FKqvW7VagHRtpprFlZiBR86YRltuufv29+A
ARC-Seal: i=1; a=rsa-sha256; t=1519008708; cv=none;
        d=google.com; s=arc-20160816;
        b=Tgg9wlii3q33aM25cjo+Z8zd6+yl4Qk2I9XX5EQioDQIcIzjErjt/AL+xoWHc+ydoe
         gYO+8tkMFVN43r49rWpW2RgTuNx9vNyYQSLzq5bGjcClG3ZFu25Z8JhPsIbycNyGWdFP
         Gp91H4OGeN7HYxOhHxJ1XubdnCPhY8rvoIs27tJiRF7ZT9SyDP81dvgOqP4TuZgA6+R7
         +fLnMGUp3RrgADxFILc9S7w5r69XI7k451YeRRzDiSwURyywGf1owYC2+5ZnNZYqwV7S
         ytXexQ9LfI5D55ZfUgsDpwbUAFQVzxSTcdMYAkFQTLFOqLQ6/PJiJU5wp7W9dO7Hx0Gg
         8iCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-signature:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=5LNGGAv5VmJ6N0ZiC2ctlulzNBFN47Oc19TxF0btwk0=;
        b=OGYEfNLlasYXgBoz3/7bqee1QTDAnoGgmg0Osb6gmo+lQd9KmypyLuROFnRIPLlPNS
         rqE98aIF92n80vg170KPBkYCmxCgpR4E3Ytb1iBS5zC7Wij5UNwmWXpHcMiP2Gq94+Fe
         rIpv3xtdKS3Zl98R1ysyzyVyDeoBkktfrzpUTyOr9NVTTlCcFpC7kNeksh6B4WS7/ass
         JuZdKurhfux9Xx5Qwi/LmEzy4plvmUjd5yCRfkAPUezWoEKGIB9BowvyDljsPpU8fJIV
         1zserQNkzqf3RPiTWzVIezFMx7x3fVNwXXzRvWcTnqM/gtGJAegKOZw5RXEYSbLVg0g0
         rXhg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm2 header.b=YoI97MCk;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=P9jg7I5f;
       spf=pass (google.com: domain of kernel-hardening-return-11820-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11820-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm2 header.b=YoI97MCk;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=P9jg7I5f;
       spf=pass (google.com: domain of kernel-hardening-return-11820-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11820-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
X-ME-Sender: <xms:mzuKWm6k-J5YsgMi4HAvV-vkgWhHGDJbVYggUn2HcACUnxmfqZv5gg>
From: "Tobin C. Harding" <me@tobin.cc>
To: Kernel Hardening <kernel-hardening@lists.openwall.com>
Cc: "Tobin C. Harding" <me@tobin.cc>,
	Tycho Andersen <tycho@tycho.ws>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/4] leaking_addresses: cache architecture name
Date: Mon, 19 Feb 2018 13:50:48 +1100
Message-Id: <1519008649-15782-4-git-send-email-me@tobin.cc>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519008649-15782-1-git-send-email-me@tobin.cc>
References: <1519008649-15782-1-git-send-email-me@tobin.cc>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592796076018706536?=
X-GMAIL-MSGID: =?utf-8?q?1592796076018706536?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Currently we are repeatedly calling `uname -m`.  This is causing the
script to take a long time to run (more than 10 seconds to parse
/proc/kallsyms).  We can use Perl state variables to cache the result of
the first call to `uname -m`.  With this change in place the script
scans the whole kernel in under a minute.

Cache machine architecture in state variable.

Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 scripts/leaking_addresses.pl | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/scripts/leaking_addresses.pl b/scripts/leaking_addresses.pl
index e7bf15a45a69..f52e91ef7d5c 100755
--- a/scripts/leaking_addresses.pl
+++ b/scripts/leaking_addresses.pl
@@ -175,7 +175,7 @@ sub is_32bit
 
 sub is_ix86_32
 {
-       my $arch = `uname -m`;
+       state $arch = `uname -m`;
 
        chomp $arch;
        if ($arch =~ m/i[3456]86/) {
@@ -198,12 +198,14 @@ sub is_arch
 
 sub is_x86_64
 {
-	return is_arch('x86_64');
+	state $is = is_arch('x86_64');
+	return $is;
 }
 
 sub is_ppc64
 {
-	return is_arch('ppc64');
+	state $is = is_arch('ppc64');
+	return $is;
 }
 
 # Gets config option value from kernel config file.
-- 
2.7.4
