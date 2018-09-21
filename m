Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91889ECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 19:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9267721567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 19:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1/eWWNt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9267721567
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391343AbeIVBqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 21:46:32 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42956 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390726AbeIVBqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 21:46:32 -0400
Received: by mail-lj1-f194.google.com with SMTP id f1-v6so12908850ljc.9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 12:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=tyNFqlRgNIU7/JV5URMRHBQpAzwuRhN3gj7rS87SzuU=;
        b=K1/eWWNt+yMrFsSjuBZLlgz3+ShAqzgPmDd+dEKAGkeKvQ6BCHYabdmGZWZn92V/HV
         sKy6iMSfbI9FK5M17Vsp+ge69+AcG+zHX/Eu2qHqGyU1pa7mnmBYAZQUKXJLUyrX6qCY
         4jPXZXo0FfrKHHHbM82+Rbz7jeA15/q7T7YOcG1BWkwGNS6x0Et6wHZFb/VWEUVvRdui
         msOBQfdtWuVqx6TE90Ac86+B2KXEC1zG7Gdg1P0wiLuejx3/1LrOOabLCEoe6jxb0xyK
         JOkz76jf4gnoihbpfCMgZzI3zC5fVnrCRgvoobQqu70xwX2b3KOQSTIy9tUuhNGXT74a
         YehQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=tyNFqlRgNIU7/JV5URMRHBQpAzwuRhN3gj7rS87SzuU=;
        b=BGBvKExvtn/KDakWsCjp4cj7K8BW8lzBaD+UFHJbToxAx4/Vw49WsTSzCOduz23t3P
         bmOZ4l91KqzO7LyhdycpTIA/h/4EFajwwzPrRzqtMwvcpD9IYafBFTrkmzfceZz3aXH9
         VhL9RlY2phtLK2eMFEyIGAGsE5IXATOoXpZHcozH8A2ek8yohkJfA0mYjEILa3E9nt9H
         vWoB8bJdFBs5YwSoW4Dn9UoDeUHrTBSXMDu7CgnQ0Ua+2ps2NlSoFdws8FW/OeBUovQ9
         trgLeGojmaX0gSSAKNewvUdKoz2bftQEUDagXdLMzM+0sEIZ3ZCQMXgGyhH8DY1g5gym
         Garw==
X-Gm-Message-State: ABuFfoiXJrk/sDv7IehpJyXT8UXpnUe7HOStRNlauAXugaVQofqfOCZO
        CSsDVcnfmPijbSwBA4VLoiA=
X-Google-Smtp-Source: ACcGV63xqxhWnwiHSOLYZWpQ/bSfuPrsunQbL01DTf0ghHshpFbkkjhdPSFd/DIY7s0F0+xucA8iBw==
X-Received: by 2002:a2e:8905:: with SMTP id d5-v6mr3613071lji.97.1537559767369;
        Fri, 21 Sep 2018 12:56:07 -0700 (PDT)
Received: from duuni.helsinki.fi (nat-eduroam-hy-138-172.fe.helsinki.fi. [128.214.138.172])
        by smtp.gmail.com with ESMTPSA id m12-v6sm5124683ljh.24.2018.09.21.12.56.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 12:56:06 -0700 (PDT)
From:   Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        linux-rpi-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: [PATCH] staging: vc04_services: Remove unused vchiq_genversion script
Date:   Fri, 21 Sep 2018 22:56:01 +0300
Message-Id: <20180921195601.8776-1-tuomas.tynkkynen@iki.fi>
X-Mailer: git-send-email 2.16.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As far as I can tell, this has never been used.

Signed-off-by: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
---
 .../interface/vchiq_arm/vchiq_genversion           | 88 ----------------------
 1 file changed, 88 deletions(-)
 delete mode 100644 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_genversion

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_genversion b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_genversion
deleted file mode 100644
index dd1f324a8654..000000000000
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_genversion
+++ /dev/null
@@ -1,88 +0,0 @@
-#!/usr/bin/perl -w
-# SPDX-License-Identifier: GPL-2.0
-
-use strict;
-
-#
-# Generate a version from available information
-#
-
-my $prefix = shift @ARGV;
-my $root = shift @ARGV;
-
-
-if ( not defined $root ) {
-	die "usage: $0 prefix root-dir\n";
-}
-
-if ( ! -d $root ) {
-	die "root directory $root not found\n";
-}
-
-my $version = "unknown";
-my $tainted = "";
-
-if ( -d "$root/.git" ) {
-	# attempt to work out git version. only do so
-	# on a linux build host, as cygwin builds are
-	# already slow enough
-
-	if ( -f "/usr/bin/git" || -f "/usr/local/bin/git" ) {
-		if (not open(F, "git --git-dir $root/.git rev-parse --verify HEAD|")) {
-			$version = "no git version";
-		}
-		else {
-			$version = <F>;
-			$version =~ s/[ \r\n]*$//;     # chomp may not be enough (cygwin).
-			$version =~ s/^[ \r\n]*//;     # chomp may not be enough (cygwin).
-		}
-
-		if (open(G, "git --git-dir $root/.git status --porcelain|")) {
-			$tainted = <G>;
-			$tainted =~ s/[ \r\n]*$//;     # chomp may not be enough (cygwin).
-			$tainted =~ s/^[ \r\n]*//;     # chomp may not be enough (cygwin).
-			if (length $tainted) {
-			$version = join ' ', $version, "(tainted)";
-		}
-		else {
-			$version = join ' ', $version, "(clean)";
-         }
-		}
-	}
-}
-
-my $hostname = `hostname`;
-$hostname =~ s/[ \r\n]*$//;     # chomp may not be enough (cygwin).
-$hostname =~ s/^[ \r\n]*//;     # chomp may not be enough (cygwin).
-
-
-print STDERR "Version $version\n";
-print <<EOF;
-#include "${prefix}_build_info.h"
-#include <linux/broadcom/vc_debug_sym.h>
-
-VC_DEBUG_DECLARE_STRING_VAR( ${prefix}_build_hostname, "$hostname" );
-VC_DEBUG_DECLARE_STRING_VAR( ${prefix}_build_version, "$version" );
-VC_DEBUG_DECLARE_STRING_VAR( ${prefix}_build_time,    __TIME__ );
-VC_DEBUG_DECLARE_STRING_VAR( ${prefix}_build_date,    __DATE__ );
-
-const char *vchiq_get_build_hostname( void )
-{
-   return vchiq_build_hostname;
-}
-
-const char *vchiq_get_build_version( void )
-{
-   return vchiq_build_version;
-}
-
-const char *vchiq_get_build_date( void )
-{
-   return vchiq_build_date;
-}
-
-const char *vchiq_get_build_time( void )
-{
-   return vchiq_build_time;
-}
-EOF
-- 
2.16.3

