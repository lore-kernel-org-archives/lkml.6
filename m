Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD149C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 20:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9713F2087E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 20:43:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729444AbfA2Un2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 15:43:28 -0500
Received: from mga03.intel.com ([134.134.136.65]:36936 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726945AbfA2Un2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 15:43:28 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jan 2019 12:43:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,538,1539673200"; 
   d="scan'208";a="129558974"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.244.182])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Jan 2019 12:43:26 -0800
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Intel Wired LAN <intel-wired-lan@lists.osuosl.org>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH] namespace: fix namespace.pl script to support relative paths
Date:   Tue, 29 Jan 2019 12:43:19 -0800
Message-Id: <20190129204319.15238-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.18.0.219.gaf81d287a9da
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The namespace.pl script does not work properly if objtree is not set to
an absolute path. The do_nm function is run from within the find
function, which changes directories.

Because of this, appending objtree, $File::Find::dir, and $source, will
return a path which is not valid from the current directory.

This used to work when objtree was set to an absolute path when using
"make namespacecheck". It appears to have not worked when calling
./scripts/namespace.pl directly.

This behavior was changed in 7e1c04779efd ("kbuild: Use relative path
for $(objtree)", 2014-05-14)

Rather than fixing the Makefile to set objtree to an absolute path, just
fix namespace.pl to work when srctree and objtree are relative. Also fix
the script to use an absolute path for these by default.

Use the File::Spec module for this purpose. It's been part of perl
5 since 5.005.

The curdir() function is used to get the current directory when the
objtree and srctree aren't set in the environment.

rel2abs() is used to convert possibly relative objtree and srctree
environment variables to absolute paths.

Finally, the catfile() function is used instead of string appending
paths together, since this is more robust when joining paths together.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 scripts/namespace.pl | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/scripts/namespace.pl b/scripts/namespace.pl
index 6135574a6f39..1da7bca201a4 100755
--- a/scripts/namespace.pl
+++ b/scripts/namespace.pl
@@ -65,13 +65,14 @@
 use warnings;
 use strict;
 use File::Find;
+use File::Spec;
 
 my $nm = ($ENV{'NM'} || "nm") . " -p";
 my $objdump = ($ENV{'OBJDUMP'} || "objdump") . " -s -j .comment";
-my $srctree = "";
-my $objtree = "";
-$srctree = "$ENV{'srctree'}/" if (exists($ENV{'srctree'}));
-$objtree = "$ENV{'objtree'}/" if (exists($ENV{'objtree'}));
+my $srctree = File::Spec->curdir();
+my $objtree = File::Spec->curdir();
+$srctree = File::Spec->rel2abs($ENV{'srctree'}) if (exists($ENV{'srctree'}));
+$objtree = File::Spec->rel2abs($ENV{'objtree'}) if (exists($ENV{'objtree'}));
 
 if ($#ARGV != -1) {
 	print STDERR "usage: $0 takes no parameters\n";
@@ -231,9 +232,9 @@ sub do_nm
 	}
 	($source = $basename) =~ s/\.o$//;
 	if (-e "$source.c" || -e "$source.S") {
-		$source = "$objtree$File::Find::dir/$source";
+		$source = File::Spec->catfile($objtree, $File::Find::dir, $source)
 	} else {
-		$source = "$srctree$File::Find::dir/$source";
+		$source = File::Spec->catfile($srctree, $File::Find::dir, $source)
 	}
 	if (! -e "$source.c" && ! -e "$source.S") {
 		# No obvious source, exclude the object if it is conglomerate
-- 
2.18.0.219.gaf81d287a9da

