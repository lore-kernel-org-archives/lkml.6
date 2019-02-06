Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17522C282CB
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 02:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE148217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 02:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbfBFCVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 21:21:43 -0500
Received: from smtprelay0148.hostedemail.com ([216.40.44.148]:50262 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726230AbfBFCVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 21:21:43 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id E57D3182CED2A;
        Wed,  6 Feb 2019 02:21:41 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: soup87_65fea1c64e017
X-Filterd-Recvd-Size: 3409
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Wed,  6 Feb 2019 02:21:40 +0000 (UTC)
Message-ID: <5e4a8fa7901148fbcd77ab391e6dd0e6bf95777f.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Verify SPDX comment style
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Whitcroft <apw@canonical.com>, Rob Herring <robh@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.org>
Date:   Tue, 05 Feb 2019 18:21:39 -0800
In-Reply-To: <20190205142136.9e7105239919596d0b2b6548@linux-foundation.org>
References: <8b02899853247a2c67669561761f354dd3bd110e.camel@perches.com>
         <20190205142136.9e7105239919596d0b2b6548@linux-foundation.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-02-05 at 14:21 -0800, Andrew Morton wrote:
> On Thu, 10 Jan 2019 16:05:11 -0800 Joe Perches <joe@perches.com> wrote:
> 
> > Using SPDX commenting style // or /* is specified for
> > various file types in Documentation/process/license-rules.rst
> > so add an appropriate test for .[chsS] files because many
> > proposed file additions and patches do not use the correct style.
> 
> Dan's
> http://lkml.kernel.org/r/154899811738.3165233.12325692939590944259.stgit@dwillia2-desk3.amr.corp.intel.com
> is giving me 
> 
> WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
> #500: FILE: mm/shuffle.h:1:
> +// SPDX-License-Identifier: GPL-2.0
> 
> and switching it to /* */ doesn't fix.  This happens with or without
> this patch applied.  What to do?

Umm, fix checkpatch?

---
 scripts/checkpatch.pl | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 37f81fe93c01..216480ae29d1 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3053,21 +3053,21 @@ sub process {
 # check SPDX comment style for .[chsS] files
 				if ($realfile =~ /\.[chsS]$/ &&
 				    $rawline =~ /SPDX-License-Identifier:/ &&
-				    $rawline !~ /^\+\s*\Q$comment\E\s*/) {
+				    $rawline !~ m@^\+\s*\Q$comment\E\s*@) {
 					WARN("SPDX_LICENSE_TAG",
 					     "Improper SPDX comment style for '$realfile', please use '$comment' instead\n" . $herecurr);
 				}
 
 				if ($comment !~ /^$/ &&
-				    $rawline !~ /^\+\Q$comment\E SPDX-License-Identifier: /) {
-					 WARN("SPDX_LICENSE_TAG",
-					      "Missing or malformed SPDX-License-Identifier tag in line $checklicenseline\n" . $herecurr);
+				    $rawline !~ m@^\+\Q$comment\E SPDX-License-Identifier: @) {
+					WARN("SPDX_LICENSE_TAG",
+					     "Missing or malformed SPDX-License-Identifier tag in line $checklicenseline\n" . $herecurr);
 				} elsif ($rawline =~ /(SPDX-License-Identifier: .*)/) {
-					 my $spdx_license = $1;
-					 if (!is_SPDX_License_valid($spdx_license)) {
-						  WARN("SPDX_LICENSE_TAG",
-						       "'$spdx_license' is not supported in LICENSES/...\n" . $herecurr);
-					 }
+					my $spdx_license = $1;
+					if (!is_SPDX_License_valid($spdx_license)) {
+						WARN("SPDX_LICENSE_TAG",
+						     "'$spdx_license' is not supported in LICENSES/...\n" . $herecurr);
+					}
 				}
 			}
 		}


