Return-Path: <kernel-hardening-return-11821-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x227Y0Py1GRs49lBkLw5HgZxcir5j8Pb3/VXbbmjgtqvIEFirZO3GbqqiQGCROsIGsbWfrgLn
ARC-Seal: i=1; a=rsa-sha256; t=1519008716; cv=none;
        d=google.com; s=arc-20160816;
        b=FxS8plVbMONutLZNj/Pg/9eGJhkZsgd6i7den6P+c02M7Wbkc5eSmDaboMo6xh+vvb
         5MxdsDmwdljN6lb9k37kbFLPMjDiUFFzBMVk3IgWZkQ4Fq+069fV62CmW48yvVUJ691B
         qI4MwH7+WV81DILOCpVExwvCR7Rbm2cNlpkXCI+gpPAEa+nrj8/6DltPahGFW0agWJm7
         6ne61MMTe1OfeU4saTUHQ443BitT341XSUlYp1TcFkrlVdybIi0yrY1OPVSK8t40/leL
         Q4ucD4cKOgpZyaYJDu10qZ8PLlKzYm47++1fDSYTJ9BoGVCfOmluPF8YltpZtEwQCVBK
         1VtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-signature:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=h2+HCMDIb0Oaw84/6yEVQgh/amcpyPAymzZBUhaqT5U=;
        b=UuAjN5bfzc6H1zaKqOJCx74EFKvusr5DuPyBLMn5nJxpa0MhbqgGGt4MdBxkCeKUII
         KiGb5o7j9TL8zhvtS1gQQps4brUrtVqN3zi4cRA2IQ7hMncfoSYFC7rtfkU+5o1DRjB3
         /STfOvaYzn1jRdMxJxtCG+pkjgxBwoN6uhV8uix6ipKEWW5yeCovYirPjZd+5dw35w1n
         0ctd7Rt2IDiGqPzQnZQtfUHmxQOJozCYMCv9GPzy81Zq3Mei2Hm35tRBgk7ekWYyFcAD
         rilKEJNKINioBsZrCVpEa+RJT3T4HWXbiEl1d+vxybl4HcFgT0+NE2ghU8G9PpQ0sR1y
         DZTQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm2 header.b=LVwOp7k+;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=abrt51Xt;
       spf=pass (google.com: domain of kernel-hardening-return-11821-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11821-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm2 header.b=LVwOp7k+;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=abrt51Xt;
       spf=pass (google.com: domain of kernel-hardening-return-11821-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11821-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
X-ME-Sender: <xms:nzuKWmEPkHoW5arbsjE3cOFrg_vigYevRDTb9bKOLqpxImL3SZ-SJg>
From: "Tobin C. Harding" <me@tobin.cc>
To: Kernel Hardening <kernel-hardening@lists.openwall.com>
Cc: "Tobin C. Harding" <me@tobin.cc>,
	Tycho Andersen <tycho@tycho.ws>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/4] leaking_addresses: add scan_once array
Date: Mon, 19 Feb 2018 13:50:49 +1100
Message-Id: <1519008649-15782-5-git-send-email-me@tobin.cc>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519008649-15782-1-git-send-email-me@tobin.cc>
References: <1519008649-15782-1-git-send-email-me@tobin.cc>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592796084722705424?=
X-GMAIL-MSGID: =?utf-8?q?1592796084722705424?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

There are files under /proc that have the same format for each PID, e.g
'smaps'.  We need only scan these files a single time to verify that
they are not leaking addresses.  This reduces the work the script must
do.

Add once_only array.

Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 scripts/leaking_addresses.pl | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/scripts/leaking_addresses.pl b/scripts/leaking_addresses.pl
index f52e91ef7d5c..ab4e70d9efde 100755
--- a/scripts/leaking_addresses.pl
+++ b/scripts/leaking_addresses.pl
@@ -69,6 +69,12 @@ my @skip_any = (
 	'fd',
 	'usbmon');
 
+# These files are the same format under each PID that they appear.
+# We need only pass them once.
+my @once_only = (
+	'smaps',
+	'mb_groups');
+
 sub help
 {
 	my ($exitcode) = @_;
@@ -401,6 +407,25 @@ sub parse_dmesg
 	close $cmd;
 }
 
+sub already_scanned
+{
+	my ($filename) = @_;
+	state %seen;
+
+	foreach (@once_only) {
+		if (/^$filename$/) {
+			if ($seen{$_} == 1) {
+				return 1;
+			}
+			$seen{$_} = 1;
+
+			return 0;
+		}
+	}
+
+	return 0;
+}
+
 # True if we should skip this path.
 sub skip
 {
@@ -415,6 +440,10 @@ sub skip
 		return 1 if (/^$filename$/);
 	}
 
+	if (already_scanned($filename)) {
+		return 1;
+	}
+
 	return 0;
 }
 
-- 
2.7.4
