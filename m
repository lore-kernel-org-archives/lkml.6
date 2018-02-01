Return-Path: <robherring2@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1517519671; cv=none;
        d=google.com; s=arc-20160816;
        b=UDkdVbX39hpZ3EIZOVXoWdBgmtNiBSK7l4Js1DbDu2cuXKgTM4wTToCM18J+OiuFmc
         NNNYKTvzQ1mm30gf+btNu2Zw0xnwuzpU9EqvyTztyDQ2N1kW6R3hOJe4HNdAImjTQ6+R
         SnRor2SjniL884rZtTGumNISMI1MbYifmqEaE84H+EEQV+xVLS4r1s5BdkWKG1WX0ELN
         qZECUkjgQXmEyuL3LI4dDuNHW81Nz5Kyc1fiGK/0HfvvVtCle1HsKjwgH/I6AuDW/G7c
         mFsH+ubMlQvuYh1BvsW3Byr+KQm62ggDCDm5s6nCq1EGYh94oGuI9/KLGMTwuIKz64px
         sZGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=OrOuGfK3PdyUbCaMSvD01na+u+j2feqqcwSnwEudh0w=;
        b=MZsKvDPhpZBC/MQdcCRZO2ch5NqH/GqH05CuacJSdF3Q9PoonrKuqEf0nsXkfPun9O
         DwSV/ANvak4HNzwxXlTeWy/Eu8ubPBirLQ4aTFss6XKcv/t4+7hJf7hHMvcVKHBdMgk9
         6uhAx4OLdWkrnKAabyx4/NuGiaCBX3yzWd6rXXnZMg1D8COMZbEpP7VsTC1FMhTmeQGi
         QAGjMoFbgB1OUlaFsKg1+oD7GV4+47kRglnH9UXnKAa0g3KQ/5gzzTO6Mgbso9go8MWc
         uhv3l2okQM2byJF/0SfkrV3rWYeWgaPuVlgy5rSzr32y5Kz45fG9XlW9Alye4iEvgmwn
         l/XQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
X-Google-Smtp-Source: AH8x225Upr1mRFTBTmgv602Oi5AEF566Ex0MUg70xBuwZbIQIseS8aGBW7rvx17cHqvrliR8YeIziQ==
From: Rob Herring <robh@kernel.org>
To: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Philippe Ombredanne <pombredanne@nexb.com>
Subject: [PATCH] checkpatch.pl: Add SPDX license tag check
Date: Thu,  1 Feb 2018 15:14:29 -0600
Message-Id: <20180201211429.32696-1-robh@kernel.org>
X-Mailer: git-send-email 2.14.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591234706723646014?=
X-GMAIL-MSGID: =?utf-8?q?1591234706723646014?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add SPDX license tag check based on the rules defined in
Documentation/process/license-rules.rst. To summarize, SPDX license tags
should be on the 1st line (or 2nd line in scripts) using the appropriate
comment style for the file type.

Cc: Andy Whitcroft <apw@canonical.com>
Cc: Joe Perches <joe@perches.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
I didn't get around to resending once license-rules.rst landed in -next. 
Hopefully, this can be picked up for 4.16 so folks can start using it. 
SPDX tags have already become a frequent review comment.

Rob

 scripts/checkpatch.pl | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index ba03f17ff662..cf1b5a90b20a 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2225,6 +2225,8 @@ sub process {
 
 	my $camelcase_file_seeded = 0;
 
+	my $checklicenseline = 1;
+
 	sanitise_line_reset();
 	my $line;
 	foreach my $rawline (@rawlines) {
@@ -2416,6 +2418,7 @@ sub process {
 			} else {
 				$check = $check_orig;
 			}
+			$checklicenseline = 1;
 			next;
 		}
 
@@ -2866,6 +2869,30 @@ sub process {
 			}
 		}
 
+# check for using SPDX license tag at beginning of files
+		if ($realline == $checklicenseline) {
+			if ($realfile =~ /\.(?:sh|pl|py)/ && $rawline =~ /\[ \+]\s*\!\#/) {
+				$checklicenseline = 2;
+			} elsif ($rawline =~ /^\+/) {
+				my $comment = "";
+				if ($realfile =~ /\.(h|s|S)$/) {
+					$comment = '/*';
+				} elsif ($realfile =~ /\.(c|dts|dtsi)$/) {
+					$comment = '//';
+				} elsif ($realfile =~ /\.(sh|pl|py)$/) {
+					$comment = '#';
+				} elsif ($realfile =~ /\.rst$/) {
+					$comment = '..';
+				}
+
+				if ($comment !~ /^$/ &&
+				    $rawline !~ /^\+\Q$comment\E SPDX-License-Identifier: /) {
+					WARN("SPDX_LICENSE_TAG",
+					     "Missing or malformed SPDX-License-Identifier tag in 1st (or 2nd for scripts) line\n" . $herecurr);
+				}
+			}
+		}
+
 # check we are in a valid source file if not then ignore this hunk
 		next if ($realfile !~ /\.(h|c|s|S|sh|dtsi|dts)$/);
 
-- 
2.14.1
