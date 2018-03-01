Return-Path: <kernel-hardening-return-12065-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELv4us1V3Nl5Ln8u5ePz6qm/74q+iTy/Y+sLT2id6GyvS8dcLMoCG7Y1dxElb1B/6TM10k5f
ARC-Seal: i=1; a=rsa-sha256; t=1519941862; cv=none;
        d=google.com; s=arc-20160816;
        b=lrsJcCKr0Sfja5zc/1S585MwdUGZLXEOzfIYG0EOL7m9EFadmB0djbi43XiXo+gFIX
         L3bZeuGZM3CIUhaZ/UfpjloledNeoMW9X3GajAb/VJzIVwr3wCCDPmosPa7IgosAH1Jo
         MCxsyw8NJMtdW1cLNTggfN/sqWNiiFrBcpqbtdP/2eM5Ya7Ilf6CWnJsVKzjmkctY4yP
         ACxKC0tSCzUkqvT3EYODZ+RKndJOP7MoYO26NSGJW2vVMiBpMf7iMg8YUHOv6N0YoyQT
         oB4bx3GZUQw1sMtbCtSe8fd4t+0OcjIq8NsHqb+NDIXdYv9rubtS5Z7hzJOEJxz3/6yC
         DuCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-signature:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=RmE0ZjSsR0eAmT1BlZoC1Zz7Sha0mGlimZtZTd+2KdA=;
        b=HGqojI2fpvYAwm767qH2FiwVOHTQ3lSYU/YezZK3Tc1HsE30EkExEuBc7DX0LQEMed
         /adogKALro4dyJ1RVrJ0tQA2fdyFHw8OkU7L/2dJkWHHoN81kG+CxS3FcL/WVlQUqE+4
         wKbXBS4sEkcpwlOlNMO0g3Y274G01N8Arhpc1EHgIvKe2V9W5VPgDJ0aT+bqAxpG5PdR
         Gdj6FZl4nhsw5eIWjcN/+SZ3wrKTt3WevcWjntTcjsRIDXCH9UVTlfXEIg7+ugPnGB3G
         wiIe/ibp+xQ//iGRuaVpml4iM826ChYlQ2nHzx9/iNexgiYA2/snHRxfSHoknUExm8A5
         9/sA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm2 header.b=M+IYLsad;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=XDtnqaAT;
       spf=pass (google.com: domain of kernel-hardening-return-12065-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12065-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm2 header.b=M+IYLsad;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=XDtnqaAT;
       spf=pass (google.com: domain of kernel-hardening-return-12065-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12065-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
X-ME-Sender: <xms:wXiYWsagivDdymtJfHtcGIty-Wc60O9P3vkbh_mh1DjWIBGVJyG_ww>
From: "Tobin C. Harding" <me@tobin.cc>
To: Kernel Hardening <kernel-hardening@lists.openwall.com>
Cc: "Tobin C. Harding" <me@tobin.cc>,
	Tycho Andersen <tycho@tycho.ws>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] leaking_addresses: check if file name contains address
Date: Fri,  2 Mar 2018 09:03:20 +1100
Message-Id: <1519941800-27710-3-git-send-email-me@tobin.cc>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519941800-27710-1-git-send-email-me@tobin.cc>
References: <1519941800-27710-1-git-send-email-me@tobin.cc>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593774558815330695?=
X-GMAIL-MSGID: =?utf-8?q?1593774558815330695?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Sometimes files may be created by using output from printk.  As the scan
traverses the directory tree we should parse each path name and check if
it is leaking an address.

Add check for leaking address on each path name.

Suggested-by: Tycho Andersen <tycho@tycho.ws>
Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 scripts/leaking_addresses.pl | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/scripts/leaking_addresses.pl b/scripts/leaking_addresses.pl
index 65a65aa64d26..a550c9bc34f5 100755
--- a/scripts/leaking_addresses.pl
+++ b/scripts/leaking_addresses.pl
@@ -463,6 +463,16 @@ sub parse_file
 	close $fh;
 }
 
+# Checks if the actual path name is leaking a kernel address.
+sub check_path_for_leaks
+{
+	my ($path) = @_;
+
+	if (may_leak_address($path)) {
+		printf("Path name may contain address: $path\n");
+	}
+}
+
 # Recursively walk directory tree.
 sub walk
 {
@@ -484,6 +494,8 @@ sub walk
 
 			next if (skip($path));
 
+			check_path_for_leaks($path);
+
 			if (-d $path) {
 				push @dirs, $path;
 				next;
-- 
2.7.4
