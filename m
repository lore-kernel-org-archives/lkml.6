Return-Path: <me@tobin.cc>
X-Google-Smtp-Source: AG47ELuxEk9BMCgNkl1n2+vQXNIkbQAmZsp+bUYtTxhoevYDHPXENzRByX64ovvbFgWVmWI3OcKI
ARC-Seal: i=1; a=rsa-sha256; t=1520222319; cv=none;
        d=google.com; s=arc-20160816;
        b=PZM0M0s7wEEGM42lu+0Ck5nqEZRuZZWwMRsM95JKpGG8+A1EPjAHBNr8aAaPfq0/EO
         Ski++4VDzi908jHjFPGksqsR6OLf/iGFhvLTT371TdCdqr7Aig1QHvEJu0k+uRCB9dnQ
         uojvWC3Dc84EuoemXHHpnqTgqsEfK3n4ECyf+JP7BqHTDNcssjZ3MrbrIBjxqUwdwAQD
         E1GyR91u4kgBbkxny968MfHQZvVDaKsku8Yc7SrbW12JaWOcIboS5HdiesYwMHfDX8xK
         wQEqzIbp5cto+yR4xjM8CGd4LzQioMMFQDdaqwbyHr+4pHBgcX6qtXZXJCYuEcmfiJwg
         TKFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-signature:arc-authentication-results;
        bh=T5rmsaOHMRrS3v9pfr0KZPzlk7qSPCqPncFWGTdHdk4=;
        b=yJUUdyR1yFwUHfnXoUQy+wKZhYHQLB57q16NFKDtqcmFe4wfwN3lJ5Yi2R12EXVm8S
         zXhhPGCiyjGwLki4/KQ5wkbnQKBvBJ9NKfq6Uv1GQ0yE4f8YSdpvakam7J3dLxGLrCdK
         beRFwS4aaJkVwKhCLPU7K1WTVCNrYB8EALbDUsGlrC3yYyYsTZwpr+vllddr0ksjjoI/
         oYE03wsKMp6aHipnXbhVS+WfBwYMA5gf8m0XAGAQ5sOZS3XVU5r8fh/sXi0UWaifvN5w
         BeitGGPlB+g9Bg10/PUQssJboB5K8bg2kuGIjcKJrmsFT9DNnuDaAGodsWfU0ISvBcFJ
         xBdQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm2 header.b=EqPa+sub;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=ON9L02Cb;
       spf=neutral (google.com: 66.111.4.29 is neither permitted nor denied by best guess record for domain of me@tobin.cc) smtp.mailfrom=me@tobin.cc
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm2 header.b=EqPa+sub;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=ON9L02Cb;
       spf=neutral (google.com: 66.111.4.29 is neither permitted nor denied by best guess record for domain of me@tobin.cc) smtp.mailfrom=me@tobin.cc
X-ME-Sender: <xms:bsCcWhhLVfHooBez_H2j8oDSYFLX0GEoaToqMF0pWEvKdKckKBAU5A>
From: "Tobin C. Harding" <me@tobin.cc>
To: Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Tobin C. Harding" <me@tobin.cc>,
	Joe Perches <joe@perches.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH 1/2] checkpatch: add check for tag Co-Developed-by
Date: Mon,  5 Mar 2018 14:58:20 +1100
Message-Id: <1520222301-11874-2-git-send-email-me@tobin.cc>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520222301-11874-1-git-send-email-me@tobin.cc>
References: <1520222301-11874-1-git-send-email-me@tobin.cc>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594068638523514417?=
X-GMAIL-MSGID: =?utf-8?q?1594068638523514417?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Joe Perches <joe@perches.com>

Recently signature tag Co-Developed-by was added to the
kernel (Documentation/process/5.Posting.rst). checkpatch.pl doesn't know
about it yet. All prior tags used all lowercase characters except for first
character. Checks for this format had to be re-worked to allow for the
new tag.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 scripts/checkpatch.pl | 58 +++++++++++++++++++++++++++++++--------------------
 1 file changed, 35 insertions(+), 23 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 3d4040322ae1..fbe2ae2d035f 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -461,16 +461,18 @@ our $logFunctions = qr{(?x:
 	seq_vprintf|seq_printf|seq_puts
 )};
 
-our $signature_tags = qr{(?xi:
-	Signed-off-by:|
-	Acked-by:|
-	Tested-by:|
-	Reviewed-by:|
-	Reported-by:|
-	Suggested-by:|
-	To:|
-	Cc:
-)};
+our @valid_signatures = (
+	"Signed-off-by:",
+	"Acked-by:",
+	"Tested-by:",
+	"Reviewed-by:",
+	"Reported-by:",
+	"Suggested-by:",
+	"Co-Developed-by:",
+	"To:",
+	"Cc:"
+);
+my $signature_tags = "(?x:" . join('|', @valid_signatures) . ")";
 
 our @typeListMisordered = (
 	qr{char\s+(?:un)?signed},
@@ -2193,6 +2195,17 @@ sub pos_last_openparen {
 	return length(expand_tabs(substr($line, 0, $last_openparen))) + 1;
 }
 
+sub get_preferred_sign_off {
+	my ($sign_off) = @_;
+
+	foreach my $sig (@valid_signatures) {
+		if (lc($sign_off) eq lc($sig)) {
+			return $sig;
+		}
+	}
+	return "";
+}
+
 sub process {
 	my $filename = shift;
 
@@ -2499,35 +2512,34 @@ sub process {
 			my $sign_off = $2;
 			my $space_after = $3;
 			my $email = $4;
-			my $ucfirst_sign_off = ucfirst(lc($sign_off));
+			my $preferred_sign_off = ucfirst(lc($sign_off));
 
-			if ($sign_off !~ /$signature_tags/) {
+			if ($sign_off !~ /$signature_tags/i) {
 				WARN("BAD_SIGN_OFF",
 				     "Non-standard signature: $sign_off\n" . $herecurr);
-			}
-			if (defined $space_before && $space_before ne "") {
+			} elsif ($sign_off !~ /$signature_tags/) {
+				$preferred_sign_off = get_preferred_sign_off($sign_off);
 				if (WARN("BAD_SIGN_OFF",
-					 "Do not use whitespace before $ucfirst_sign_off\n" . $herecurr) &&
+					 "'$preferred_sign_off' is the preferred signature form\n" . $herecurr) &&
 				    $fix) {
-					$fixed[$fixlinenr] =
-					    "$ucfirst_sign_off $email";
+					$fixed[$fixlinenr] = "$preferred_sign_off $email";
 				}
 			}
-			if ($sign_off =~ /-by:$/i && $sign_off ne $ucfirst_sign_off) {
+			if (defined $space_before && $space_before ne "") {
 				if (WARN("BAD_SIGN_OFF",
-					 "'$ucfirst_sign_off' is the preferred signature form\n" . $herecurr) &&
+					 "Do not use whitespace before $preferred_sign_off\n" . $herecurr) &&
 				    $fix) {
 					$fixed[$fixlinenr] =
-					    "$ucfirst_sign_off $email";
+					    "$preferred_sign_off $email";
 				}
-
 			}
+
 			if (!defined $space_after || $space_after ne " ") {
 				if (WARN("BAD_SIGN_OFF",
-					 "Use a single space after $ucfirst_sign_off\n" . $herecurr) &&
+					 "Use a single space after $preferred_sign_off\n" . $herecurr) &&
 				    $fix) {
 					$fixed[$fixlinenr] =
-					    "$ucfirst_sign_off $email";
+					    "$preferred_sign_off $email";
 				}
 			}
 
-- 
2.7.4
