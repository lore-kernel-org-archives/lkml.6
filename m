Return-Path: <kernel-hardening-return-12064-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELsKfow6VLUQBOJWeIePjXlsky1k9jEjilQne1GVweW4iAD8wAvocc7ZVg5QuUjNFo2DUbUD
ARC-Seal: i=1; a=rsa-sha256; t=1519941855; cv=none;
        d=google.com; s=arc-20160816;
        b=Lh2P8L05lGxHZQL6kYinE3+vx/CJFOgbDEzzWAWVMcLdJX64XBWB/1J2SGJEwmUrKw
         9RWxb681oLXYE9+SqBNJX1HtYigQ6kqHw4Kpca3ZjAZGMzSvnspZrgENDqRxjDFBgdkA
         JZBMk8iZtgLARgQZtMQ8yzfUOmVvjcrtdoRzRK5ra5RefIZANCgnZyqsO9Rsx/k1o3zv
         JsdXU1z0yeR62OSZbYSU4HXkCPs0os9/OI+a3v3SFYrAM9hjozNyPl01RsD4YnXa8IYZ
         5JC9gdE6t3sYaUtyPDL+xH0WEC7SNyl7Fotay2No2Hcv6In9N8fk32u4qVPRIMyPvBjk
         Yc0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-signature:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=aE88WhNEM1RWMwmNE0en7qQyFse/3m+degho9/T+LUw=;
        b=hrS1FfwRYoeeMLdDDPpR3J49PRxlK1jlRHYpsO/jbMx/RAxEECo56sE54JnSMoVGGv
         +5c+4+Ws1URiEEEXqoFcCZKEhT8ye26KCO2X2Bs9ymF84WM2ulrztOO73d74zVSAPrig
         XRGjKG6TIaovN+Wtpx8mCr4ZsqW2Nt7JZt7d7o4z6OtDJJovxQLA7TjvpCUh+P8WwUJ8
         oJyeHhBlcclwOzgovjWiGo6xrGk/t5PEvF+FajMFFoPkeK2TQrRHS+ccv5vHX0xwCNh/
         weonkKLHWUoNFXQcVNM08CUKhM0OL1hdHKb2P94yHHhoFZn9FZx0TShhTpTGGzj/N/1G
         iCqw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm2 header.b=QeMXr02w;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=BcyA3y93;
       spf=pass (google.com: domain of kernel-hardening-return-12064-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12064-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm2 header.b=QeMXr02w;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=BcyA3y93;
       spf=pass (google.com: domain of kernel-hardening-return-12064-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12064-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
X-ME-Sender: <xms:vXiYWskLjba6RXI9z9Vu5qYvM4GhGsScAH2ECBVzYAHkmMn65y5QtQ>
From: "Tobin C. Harding" <me@tobin.cc>
To: Kernel Hardening <kernel-hardening@lists.openwall.com>
Cc: "Tobin C. Harding" <me@tobin.cc>,
	Tycho Andersen <tycho@tycho.ws>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] leaking_addresses: explicitly name variable used in regex
Date: Fri,  2 Mar 2018 09:03:19 +1100
Message-Id: <1519941800-27710-2-git-send-email-me@tobin.cc>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519941800-27710-1-git-send-email-me@tobin.cc>
References: <1519941800-27710-1-git-send-email-me@tobin.cc>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593774551367950492?=
X-GMAIL-MSGID: =?utf-8?q?1593774551367950492?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Currently sub routine may_leak_address() is checking regex against Perl
special variable $_ which is _fortunately_ being set correctly in a loop
before this sub routine is called.  We already have declared a variable
to hold this value '$line' we should use it.

Use $line in regex match instead of implicit $_

Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 scripts/leaking_addresses.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/leaking_addresses.pl b/scripts/leaking_addresses.pl
index d5d31f3df97e..65a65aa64d26 100755
--- a/scripts/leaking_addresses.pl
+++ b/scripts/leaking_addresses.pl
@@ -363,7 +363,7 @@ sub may_leak_address
 	}
 
 	$address_re = get_address_re();
-	while (/($address_re)/g) {
+	while ($line =~ /($address_re)/g) {
 		if (!is_false_positive($1)) {
 			return 1;
 		}
-- 
2.7.4
