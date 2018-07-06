Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E3C7C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 22:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5046C22ACD
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 22:14:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5046C22ACD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754066AbeGFWOc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 18:14:32 -0400
Received: from smtprelay0109.hostedemail.com ([216.40.44.109]:34869 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752461AbeGFWOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 18:14:31 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id CE315180A8CBE;
        Fri,  6 Jul 2018 22:14:30 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: patch03_273ea6b0f595c
X-Filterd-Recvd-Size: 4004
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Fri,  6 Jul 2018 22:14:29 +0000 (UTC)
Message-ID: <9efeba75a47e9b0c40d5b9e5078598ff4a31f196.camel@perches.com>
Subject: Re: [PATCH] get_maintainer.pl: Add optional
 .get_maintainer.MAINTAINERS override
From:   Joe Perches <joe@perches.com>
To:     Don Zickus <dzickus@redhat.com>
Cc:     Prarit Bhargava <prarit@redhat.com>, linux-kernel@vger.kernel.org,
        jtoppins@redhat.com
Date:   Fri, 06 Jul 2018 15:14:28 -0700
In-Reply-To: <5ebb181efcdd2cdb3c1ee8eac9bba26f5759a0ea.camel@perches.com>
References: <20180626182505.4176-1-prarit@redhat.com>
         <601f0e6bf3baa88b9f6145e635d728a435542292.camel@perches.com>
         <20180706175419.6irtvs64e6dbz7hk@redhat.com>
         <c187fe5040cb616292dab6c106352273df95bc41.camel@perches.com>
         <20180706184411.ilzbt7fxuje2nhx6@redhat.com>
         <716eb88d-31ac-c488-f799-dec9c9afb5af@redhat.com>
         <948af2d06623e8fcca6f0c0fd300a65bbfd1c6fa.camel@perches.com>
         <20180706215851.sqpibusyqukbh55g@redhat.com>
         <5ebb181efcdd2cdb3c1ee8eac9bba26f5759a0ea.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-07-06 at 15:09 -0700, Joe Perches wrote:
> On Fri, 2018-07-06 at 17:58 -0400, Don Zickus wrote:
> > We have an internal use case of multiple MAINTAINER files, some folks have
> > more rights to patches than others so they are not allowed to be cc'd (think
> > embargoed stuff).

How about:
---
 scripts/get_maintainer.pl | 39 +++++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index c87fa734e3e1..f7a7d46340a8 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -60,7 +60,7 @@ my $pattern_depth = 0;
 my $self_test = undef;
 my $version = 0;
 my $help = 0;
-my $find_maintainer_files = 0;
+my $find_maintainer_files;
 
 my $vcs_used = 0;
 
@@ -262,7 +262,7 @@ if (!GetOptions(
 		'sections!' => \$sections,
 		'fe|file-emails!' => \$file_emails,
 		'f|file' => \$from_filename,
-		'find-maintainer-files' => \$find_maintainer_files,
+		'find-maintainer-files:s' => \$find_maintainer_files,
 		'self-test:s' => \$self_test,
 		'v|version' => \$version,
 		'h|help|usage' => \$help,
@@ -384,26 +384,29 @@ sub find_ignore_git {
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
+    my $path = defined $find_maintainer_files && $find_maintainer_files ne ""
+	? $find_maintainer_files : $lk_path;
+    if (-d "${path}MAINTAINERS") {
+	opendir(DIR, "${path}MAINTAINERS") or die $!;
+	my @files = readdir(DIR);
+	closedir(DIR);
+	foreach my $file (@files) {
+	    push(@mfiles, "${path}MAINTAINERS/$file") if ($file !~ /^\./);
+	}
+    }
+
+    if (defined $find_maintainer_files && (-d $find_maintainer_files)) {
+	find( { wanted => \&find_is_maintainer_file,
+		preprocess => \&find_ignore_git,
+		no_chdir => 1,
+	      }, "${path}");
     } else {
-        push(@mfiles, "${lk_path}MAINTAINERS") if -f "${lk_path}MAINTAINERS";
+	push(@mfiles, "${path}MAINTAINERS") if -f "${path}MAINTAINERS";
     }
 
+    die "$P: No MAINTAINER files found in $path\n" if (scalar(@mfiles) == 0);
     foreach my $file (@mfiles) {
-        read_maintainer_file("$file");
+	read_maintainer_file("$file");
     }
 }
 
