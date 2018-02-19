Return-Path: <kernel-hardening-return-11819-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x227zyTGtJVFcWX2qiYYGDhg0DmOS4F1pRnAVOv0PGPpchtDCPUEs7lcaj4g2WXnErByEMK5h
ARC-Seal: i=1; a=rsa-sha256; t=1519008697; cv=none;
        d=google.com; s=arc-20160816;
        b=WB2w1B7MyH7wveUgCysvg01FTJbDFYgzJm0rs5FHRl3clsiuWALpCDop5uKqx5y0a7
         RhfGlv5WgQCj9ZUpV95SahGDxmhFDCnuv4Zh3EabRNVZPjIvJvkj82AcpApWV2qAVTLR
         9mLY/VTv2gBvw2uK6d05iTgEgTbIl6cxJgnzYATLn3k+nzPRZ/I9M32e6hpZaOLfIJ4E
         HZMhJYIAk+3kOqBkXeFA5dgIyM0gqIXs5cupHro8R5+MwuqEvc7WhwoMZEw0XIEff94W
         oPIAU+DfS/1puWvwZbtBfkFGjWN9sxr4TzVMukc8PlrDh7nyeh/DDtUnHC6su/IXOBWP
         pXgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-signature:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=9Ij8tsZbZzOlKE+qd7wd9Qy/gM1Rpa/rXs/vDMFq5dI=;
        b=D2ut3xJQs0faQ6q4IzYsmxLHR6Tt5FEkO5S2uGbbI/02whxILGwqLxWphnbfe7wuzl
         lQFiCGP9yah20/ctyWCYUpqW1Uq+jjmFrkfWXWv1hJGWtV2i/HqFh9uBoLLvaWw3195s
         Wxxi1uvuzBq4Kl8LCj/jPExXSOPOZPrWbqqCNkjyGTRX2Ap660nVyOR0QUivSKK1bRUi
         1Yiv/LXPmWg0+X77gHJ//dov+IjwoH0kn5bj8Gf5HdsM5XgJWsmKyM0oJlYFCyFj4flU
         whESNOdHBeG98I0/pfQ/uke1pt6KvUKiDrzH1HJOe/LtXlR3kPe00JdmE7rNdRqcSDVE
         GyPA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm2 header.b=jgYJzbIs;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=T31a2dgV;
       spf=pass (google.com: domain of kernel-hardening-return-11819-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11819-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm2 header.b=jgYJzbIs;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=T31a2dgV;
       spf=pass (google.com: domain of kernel-hardening-return-11819-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11819-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
X-ME-Sender: <xms:mDuKWr9nYTGD8wMRIlFUVr5bUy4l_Dkcphq0-2l1Ub-0_kCzTUtpKg>
From: "Tobin C. Harding" <me@tobin.cc>
To: Kernel Hardening <kernel-hardening@lists.openwall.com>
Cc: "Tobin C. Harding" <me@tobin.cc>,
	Tycho Andersen <tycho@tycho.ws>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/4] leaking_addresses: simplify path skipping
Date: Mon, 19 Feb 2018 13:50:47 +1100
Message-Id: <1519008649-15782-3-git-send-email-me@tobin.cc>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519008649-15782-1-git-send-email-me@tobin.cc>
References: <1519008649-15782-1-git-send-email-me@tobin.cc>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592796064766188382?=
X-GMAIL-MSGID: =?utf-8?q?1592796064766188382?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Currently script has multiple configuration arrays.  This is confusing,
evident by the fact that a bunch of the entries are in the wrong place.
We can simplify the code by just having a single array for absolute
paths to skip and a single array for file names to skip wherever they
appear in the scanned directory tree.  There are also currently multiple
subroutines to handle the different arrays, we can reduce these to a
single subroutine also.

Simplify the path skipping code.

Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 scripts/leaking_addresses.pl | 90 ++++++++++++++------------------------------
 1 file changed, 29 insertions(+), 61 deletions(-)

diff --git a/scripts/leaking_addresses.pl b/scripts/leaking_addresses.pl
index 3d5c3096aac8..e7bf15a45a69 100755
--- a/scripts/leaking_addresses.pl
+++ b/scripts/leaking_addresses.pl
@@ -48,41 +48,26 @@ my $kernel_config_file = "";	# Kernel configuration file.
 my $opt_32bit = 0;		# Scan 32-bit kernel.
 my $page_offset_32bit = 0;	# Page offset for 32-bit kernel.
 
-# Do not parse these files (absolute path).
-my @skip_parse_files_abs = ('/proc/kmsg',
-			    '/proc/kcore',
-			    '/proc/fs/ext4/sdb1/mb_groups',
-			    '/proc/1/fd/3',
-			    '/sys/firmware/devicetree',
-			    '/proc/device-tree',
-			    '/sys/kernel/debug/tracing/trace_pipe',
-			    '/sys/kernel/security/apparmor/revision');
-
-# Do not parse these files under any subdirectory.
-my @skip_parse_files_any = ('0',
-			    '1',
-			    '2',
-			    'pagemap',
-			    'events',
-			    'access',
-			    'registers',
-			    'snapshot_raw',
-			    'trace_pipe_raw',
-			    'ptmx',
-			    'trace_pipe');
-
-# Do not walk these directories (absolute path).
-my @skip_walk_dirs_abs = ();
-
-# Do not walk these directories under any subdirectory.
-my @skip_walk_dirs_any = ('self',
-			  'thread-self',
-			  'cwd',
-			  'fd',
-			  'usbmon',
-			  'stderr',
-			  'stdin',
-			  'stdout');
+# Skip these absolute paths.
+my @skip_abs = (
+	'/proc/kmsg',
+	'/sys/firmware/devicetree',
+	'/proc/device-tree',
+	'/sys/kernel/debug/tracing/trace_pipe',
+	'/sys/kernel/security/apparmor/revision');
+
+# Skip these under any subdirectory.
+my @skip_any = (
+	'pagemap',
+	'events',
+	'access',
+	'registers',
+	'snapshot_raw',
+	'trace_pipe_raw',
+	'ptmx',
+	'trace_pipe',
+	'fd',
+	'usbmon');
 
 sub help
 {
@@ -417,26 +402,20 @@ sub parse_dmesg
 # True if we should skip this path.
 sub skip
 {
-	my ($path, $paths_abs, $paths_any) = @_;
+	my ($path) = @_;
 
-	foreach (@$paths_abs) {
+	foreach (@skip_abs) {
 		return 1 if (/^$path$/);
 	}
 
 	my($filename, $dirs, $suffix) = fileparse($path);
-	foreach (@$paths_any) {
+	foreach (@skip_any) {
 		return 1 if (/^$filename$/);
 	}
 
 	return 0;
 }
 
-sub skip_parse
-{
-	my ($path) = @_;
-	return skip($path, \@skip_parse_files_abs, \@skip_parse_files_any);
-}
-
 sub timed_parse_file
 {
 	my ($file) = @_;
@@ -466,12 +445,6 @@ sub parse_file
 		return;
 	}
 
-	if (skip_parse($file)) {
-		dprint "skipping file: $file\n";
-		return;
-	}
-	dprint "parsing: $file\n";
-
 	open my $fh, "<", $file or return;
 	while ( <$fh> ) {
 		if (may_leak_address($_)) {
@@ -481,21 +454,12 @@ sub parse_file
 	close $fh;
 }
 
-
-# True if we should skip walking this directory.
-sub skip_walk
-{
-	my ($path) = @_;
-	return skip($path, \@skip_walk_dirs_abs, \@skip_walk_dirs_any)
-}
-
 # Recursively walk directory tree.
 sub walk
 {
 	my @dirs = @_;
 
 	while (my $pwd = shift @dirs) {
-		next if (skip_walk($pwd));
 		next if (!opendir(DIR, $pwd));
 		my @files = readdir(DIR);
 		closedir(DIR);
@@ -506,11 +470,15 @@ sub walk
 			my $path = "$pwd/$file";
 			next if (-l $path);
 
+			next if (skip($path));
+
 			if (-d $path) {
 				push @dirs, $path;
-			} else {
-				timed_parse_file($path);
+				next;
 			}
+
+			dprint "parsing: $file\n";
+			timed_parse_file($path);
 		}
 	}
 }
-- 
2.7.4
