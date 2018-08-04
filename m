Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CA4C28CF6
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 01:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F35A21782
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 01:11:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F35A21782
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732106AbeHDDKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 23:10:37 -0400
Received: from smtprelay0120.hostedemail.com ([216.40.44.120]:36475 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731925AbeHDDKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 23:10:37 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 3FD75180A843A;
        Sat,  4 Aug 2018 01:11:55 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: scarf78_10a13f7acc11d
X-Filterd-Recvd-Size: 3800
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Sat,  4 Aug 2018 01:11:54 +0000 (UTC)
Message-ID: <a86e69195076ed3c4c526fddc76b86c28e0a1e37.camel@perches.com>
Subject: [PATCH] get_maintainer.pl: Add -mpath=<path or file> for
 MAINTAINERS file location
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linuxfoundation.org>,
        Don Zickus <dzickus@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Prarit Bhargava <prarit@redhat.com>, jtoppins@redhat.com
Date:   Fri, 03 Aug 2018 18:11:53 -0700
In-Reply-To: <20180706175419.6irtvs64e6dbz7hk@redhat.com>
References: <20180626182505.4176-1-prarit@redhat.com>
         <601f0e6bf3baa88b9f6145e635d728a435542292.camel@perches.com>
         <20180706175419.6irtvs64e6dbz7hk@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the ability to have an override for the location of the
MAINTAINERS file.

Miscellanea:

o Properly indent a few lines with leading spaces

Suggested-by: Don Zickus <dzickus@redhat.com>
Signed-off-by: Joe Perches <joe@perches.com>
---
 scripts/get_maintainer.pl | 48 +++++++++++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 18 deletions(-)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index 82a482f858ee..0ebdefe74d5b 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -62,7 +62,7 @@ my $self_test = undef;
 my $version = 0;
 my $help = 0;
 my $find_maintainer_files = 0;
-
+my $maintainer_path;
 my $vcs_used = 0;
 
 my $exit = 0;
@@ -265,6 +265,7 @@ if (!GetOptions(
 		'fe|file-emails!' => \$file_emails,
 		'f|file' => \$from_filename,
 		'find-maintainer-files' => \$find_maintainer_files,
+		'mpath|maintainer-path=s' => \$maintainer_path,
 		'self-test:s' => \$self_test,
 		'v|version' => \$version,
 		'h|help|usage' => \$help,
@@ -386,26 +387,37 @@ sub find_ignore_git {
 read_all_maintainer_files();
 
 sub read_all_maintainer_files {
-    if (-d "${lk_path}MAINTAINERS") {
-        opendir(DIR, "${lk_path}MAINTAINERS") or die $!;
-        my @files = readdir(DIR);
-        closedir(DIR);
-        foreach my $file (@files) {
-            push(@mfiles, "${lk_path}MAINTAINERS/$file") if ($file !~ /^\./);
-        }
-    }
-
-    if ($find_maintainer_files) {
-        find( { wanted => \&find_is_maintainer_file,
-                preprocess => \&find_ignore_git,
-                no_chdir => 1,
-        }, "${lk_path}");
+    my $path = "${lk_path}MAINTAINERS";
+    if (defined $maintainer_path) {
+	$path = $maintainer_path;
+	# Perl Cookbook tilde expansion if necessary
+	$path =~ s@^~([^/]*)@ $1 ? (getpwnam($1))[7] : ( $ENV{HOME} || $ENV{LOGDIR} || (getpwuid($<))[7])@ex;
+    }
+
+    if (-d $path) {
+	$path .= '/' if ($path !~ m@/$@);
+	if ($path eq "${lk_path}MAINTAINERS/") {
+	    opendir(DIR, "$path") or die $!;
+	    my @files = readdir(DIR);
+	    closedir(DIR);
+	    foreach my $file (@files) {
+		push(@mfiles, "$path$file") if ($file !~ /^\./);
+	    }
+	}
+	if ($find_maintainer_files) {
+	    find( { wanted => \&find_is_maintainer_file,
+		    preprocess => \&find_ignore_git,
+		    no_chdir => 1,
+		}, "$path");
+	}
+    } elsif (-f "$path") {
+	push(@mfiles, "$path");
     } else {
-        push(@mfiles, "${lk_path}MAINTAINERS") if -f "${lk_path}MAINTAINERS";
+	die "$P: MAINTAINER file not found '$path'\n";
     }
-
+    die "$P: No MAINTAINER files found in '$path'\n" if (scalar(@mfiles) == 0);
     foreach my $file (@mfiles) {
-        read_maintainer_file("$file");
+	read_maintainer_file("$file");
     }
 }
 
