Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13CAFC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3702218D9
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388680AbfAKTjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 14:39:16 -0500
Received: from ms.lwn.net ([45.79.88.28]:60176 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730371AbfAKTjP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 14:39:15 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E27D22F3;
        Fri, 11 Jan 2019 19:39:14 +0000 (UTC)
Date:   Fri, 11 Jan 2019 12:39:14 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] kernel-doc: suppress 'not described' warnings for embedded
 struct fields
Message-ID: <20190111123841.6f195c2c@lwn.net>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ability to add kerneldoc comments for fields in embedded structures is
useful, but it brought along a whole bunch of warnings for fields that
could not be described before.  In many cases, there's little value in
adding docs for these nested fields, and in cases like:

       	struct a {
            struct b {
	        int c;
	    } d, e;
	};

"c" would have to be described twice (as d.c and e.c) to make the warnings
go away.

We can no doubt do something smarter, but simply suppressing the warnings
for this case removes about 70 relatively useless warnings from the docs
build, freeing us to focus on the ones that matter more.  So make
kerneldoc be silent about missing descriptions for any field containing a
".".

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 scripts/kernel-doc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index c5333d251985..3350e498b4ce 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -1474,7 +1474,7 @@ sub push_parameter($$$$) {
 	if (!defined $parameterdescs{$param} && $param !~ /^#/) {
 		$parameterdescs{$param} = $undescribed;
 
-	        if (show_warnings($type, $declaration_name)) {
+	        if (show_warnings($type, $declaration_name) && $param !~ /\./) {
 			print STDERR
 			      "${file}:$.: warning: Function parameter or member '$param' not described in '$declaration_name'\n";
 			++$warnings;
-- 
2.20.1

