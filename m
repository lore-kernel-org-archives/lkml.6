Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B6A4C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 01:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 251CC2174B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 01:14:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 251CC2174B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731064AbeHND5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 23:57:32 -0400
Received: from smtprelay0245.hostedemail.com ([216.40.44.245]:41064 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729346AbeHND5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 23:57:32 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 03FFD180A8128;
        Tue, 14 Aug 2018 01:12:47 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: home33_182dcee706403
X-Filterd-Recvd-Size: 2358
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Tue, 14 Aug 2018 01:12:45 +0000 (UTC)
Message-ID: <991b2f20112d53863cd79e61d908f1d26d3e1971.camel@perches.com>
Subject: [PATCH] get_maintainer: Allow option --mpath <directory> to read
 all files in <directory>
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Don Zickus <dzickus@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Mon, 13 Aug 2018 18:12:44 -0700
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is an external use case for multiple private MAINTAINER
style files in a separate directory.  Allow it.

--mpath has a default of "./MAINTAINERS".

The value entered can be either a file or a directory.

The behaviors are now:

--mpath <file>          Read only the specific file as <MAINTAINER_TYPE> file
--mpath <directory>     Read all files in <directory> as <MAINTAINER_TYPE> files
--mpath <directory> --find-maintainer-files
                        Recurse through <directory> and read all files named MAINTAINERS

Signed-off-by: Joe Perches <joe@perches.com>
---
 scripts/get_maintainer.pl | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index 0ebdefe74d5b..c1c088ef1420 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -396,7 +396,12 @@ sub read_all_maintainer_files {
 
     if (-d $path) {
 	$path .= '/' if ($path !~ m@/$@);
-	if ($path eq "${lk_path}MAINTAINERS/") {
+	if ($find_maintainer_files) {
+	    find( { wanted => \&find_is_maintainer_file,
+		    preprocess => \&find_ignore_git,
+		    no_chdir => 1,
+		}, "$path");
+	} else {
 	    opendir(DIR, "$path") or die $!;
 	    my @files = readdir(DIR);
 	    closedir(DIR);
@@ -404,12 +409,6 @@ sub read_all_maintainer_files {
 		push(@mfiles, "$path$file") if ($file !~ /^\./);
 	    }
 	}
-	if ($find_maintainer_files) {
-	    find( { wanted => \&find_is_maintainer_file,
-		    preprocess => \&find_ignore_git,
-		    no_chdir => 1,
-		}, "$path");
-	}
     } elsif (-f "$path") {
 	push(@mfiles, "$path");
     } else {

