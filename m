Return-Path: <robherring2@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1517586028; cv=none;
        d=google.com; s=arc-20160816;
        b=rIIxuFauyO+UW87YgdpzDBDufWV8rDLIeXqIQOCCoFFBYT7ixxSSZUyPtotgZo0Ubf
         VXY7GWa7rdXpRhVPg61F8ZQXcEI5974+ebCA9TAfYAEHb4GeLElPRgb2bE2+rqN8+IW5
         vKQlYnAbPQS1cRdi9yC4UX6cbjV3ner5gAwupKrEUAdp2V+SnvZnGDi/MBanJU3IRgRh
         3yBfTJzmIjiTYQReYb42A5h6pX7j7+pxt8KNNL6dNKzy8+YSjqupjov1MtzXyldqPUzT
         Auxnul1u60OhoAVNTZUOmezbRdVzRiyOLKSseHX5fP+XJJzM8vjJNipiQaIviecyLTkM
         Zavg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=Dyc2s/0LAJmLfq8VwbhZI2gdgoIwzQlkb/vA3weIKgc=;
        b=eFgLJJFlXOEiHYUEGPkfRuwrstNZ9rfyfyxmymQjBva+rgwMXKEx51rc56A/N1/1QD
         pwxIJj0EJ6qZMNlmMyXPWNQ4diLTqR/br7Pat8XRWNftKpX5MHyYo0R2QaolkTrF3kch
         GZ2kNYf9jBgbUFiM1fV3Muww84nYIlgMoF8AO17b6PjvB8vK2ytNQJjleWBsw1gTVW/K
         aCu7nHjaqVjVkYEdCRh9AglBR7YYaOhHk2juXCx8y0s7rE01+bqWnJlM5GDU75UXmLmU
         QgpHrn1b50YR80ukHBpb4VTD7OVhvlN15hR+KcAKOZBOKwGie/5n47jCW+3za/ms8BdU
         dxbQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
X-Google-Smtp-Source: AH8x225/QSko9b/CZMJq4ZO6KMyF8K+KSyA9VcWDTFBXkY5RK0uM0L+4icP6oeZZbtYiZM02sJ0fCw==
From: Rob Herring <robh@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	Joe Perches <joe@perches.com>,
	Andy Whitcroft <apw@canonical.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Philippe Ombredanne <pombredanne@nexb.com>
Subject: [PATCH v6] checkpatch.pl: Add SPDX license tag check
Date: Fri,  2 Feb 2018 09:40:26 -0600
Message-Id: <20180202154026.15298-1-robh@kernel.org>
X-Mailer: git-send-email 2.14.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591304287671259020?=
X-GMAIL-MSGID: =?utf-8?q?1591304287671259020?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add SPDX license tag check based on the rules defined in
Documentation/process/license-rules.rst. To summarize, SPDX license tags
should be on the 1st line (or 2nd line in scripts) using the appropriate
comment style for the file type.

Cc: Andy Whitcroft <apw@canonical.com>
Cc: Joe Perches <joe@perches.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
v6:
- Dropped script extension check and only look for #!/... on 1st line. A 
  text executable file was not reliable either.
- Support .awk and .tc which may or may not have a #!/.
- Fixed a typo in script "#!" regex and also match on first /.
- Add Greg's ack.

 scripts/checkpatch.pl | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index ba03f17ff662..6db245e5f93b 100755
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
+			if ($rawline =~ /^[ \+]\s*\#\!\s*\//) {
+				$checklicenseline = 2;
+			} elsif ($rawline =~ /^\+/) {
+				my $comment = "";
+				if ($realfile =~ /\.(h|s|S)$/) {
+					$comment = '/*';
+				} elsif ($realfile =~ /\.(c|dts|dtsi)$/) {
+					$comment = '//';
+				} elsif (($checklicenseline == 2) || $realfile =~ /\.(sh|pl|py|awk|tc)$/) {
+					$comment = '#';
+				} elsif ($realfile =~ /\.rst$/) {
+					$comment = '..';
+				}
+
+				if ($comment !~ /^$/ &&
+				    $rawline !~ /^\+\Q$comment\E SPDX-License-Identifier: /) {
+					WARN("SPDX_LICENSE_TAG",
+					     "Missing or malformed SPDX-License-Identifier tag in line $checklicenseline\n" . $herecurr);
+				}
+			}
+		}
+
 # check we are in a valid source file if not then ignore this hunk
 		next if ($realfile !~ /\.(h|c|s|S|sh|dtsi|dts)$/);
 
-- 
2.14.1
