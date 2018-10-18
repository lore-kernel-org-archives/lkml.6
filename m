Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D5D4C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 04:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEC0021473
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 04:07:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rdcDJAfH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEC0021473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbeJRMGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 08:06:37 -0400
Received: from merlin.infradead.org ([205.233.59.134]:35876 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbeJRMGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 08:06:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jwJD5DaDk8RgpS+Gkbn5sR3vjLLZdWoE0Epvk7pX/qo=; b=rdcDJAfHA8KrdUfaw/yqXz3ErV
        30qS122rSfBfsQiGPMdiq7ExYgRxOUcMerUuLwR3pQmzfY+2QNQPmJLb02SbyDPpSQ33xJmBAbN4x
        MVtFNoh70pxRXWhes/xpIXSGHRugKZ/aClBUg5yb52HeKM8+TmgszyBY+if8bPnfleZyNXBmGHWwy
        1Nltq4PFLlKW20SkceWWnHNydXQj7gNr4tY1mDFkLohaoASHdauJ/L3cKJEIfGM1cgT3qlxIWG5WP
        nD8tCi7oqWSzpSBQzTDVMyY6qPM35P78wOZqxR3TJMnPPYCGtvzLiKwKTYrc7bBsYTfIab4ne4PvK
        BnPzOKBQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gCzaq-0000Ob-8H; Thu, 18 Oct 2018 04:07:28 +0000
To:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Kees Cook <keescook@chromium.org>,
        Jani Nikula <jani.nikula@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] kernel-doc: fix declaration type determination
Message-ID: <640b26f4-a6fa-ffbc-c866-ea03de4f79a5@infradead.org>
Date:   Wed, 17 Oct 2018 21:07:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Make declaration type determination more robust.

When scripts/kernel-doc is deciding if some kernel-doc notation
contains an enum, a struct, a union, a typedef, or a function,
it does a pattern match on the beginning of the string, looking
for a match with one of "struct", "union", "enum", or "typedef",
and otherwise defaults to a function declaration type.
However, if a function or a function-like macro has a name that
begins with "struct" (e.g., struct_size()), then kernel-doc
incorrectly decides that this is a struct declaration.

Fix this by looking for the declaration type keywords having an
ending word boundary (\b), so that "struct_size" will not match
a struct declaration.

I compared lots of html before/after output from core-api, driver-api,
and networking.  There were no differences in any of the files that
I checked.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Kees Cook <keescook@chromium.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 scripts/kernel-doc |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- lnx-419-rc8.orig/scripts/kernel-doc
+++ lnx-419-rc8/scripts/kernel-doc
@@ -1904,13 +1904,13 @@ sub process_name($$) {
 	    ++$warnings;
 	}
 
-	if ($identifier =~ m/^struct/) {
+	if ($identifier =~ m/^struct\b/) {
 	    $decl_type = 'struct';
-	} elsif ($identifier =~ m/^union/) {
+	} elsif ($identifier =~ m/^union\b/) {
 	    $decl_type = 'union';
-	} elsif ($identifier =~ m/^enum/) {
+	} elsif ($identifier =~ m/^enum\b/) {
 	    $decl_type = 'enum';
-	} elsif ($identifier =~ m/^typedef/) {
+	} elsif ($identifier =~ m/^typedef\b/) {
 	    $decl_type = 'typedef';
 	} else {
 	    $decl_type = 'function';


