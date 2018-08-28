Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A5FC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 05:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AF7E208B6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 05:33:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AF7E208B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbeH1JXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 05:23:17 -0400
Received: from smtprelay0241.hostedemail.com ([216.40.44.241]:58898 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726120AbeH1JXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 05:23:17 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id C3D4E182CF665;
        Tue, 28 Aug 2018 05:33:19 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: meal61_3a0c6bebef825
X-Filterd-Recvd-Size: 1975
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Tue, 28 Aug 2018 05:33:18 +0000 (UTC)
Message-ID: <0fa8a2cb83ade4c525e18261ecf6cfede3015983.camel@perches.com>
Subject: [PATCH] checkpatch: Add __ro_after_init to known $Attribute
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>
Cc:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Mon, 27 Aug 2018 22:33:16 -0700
In-Reply-To: <c07f1fd50d25077f62efbe586bfc40428959d175.camel@perches.com>
References: <CAGXu5jL9b3Ks95fpq5tdqS1avQysasaCBDzaA31-FVmJCqz=Og@mail.gmail.com>
         <c07f1fd50d25077f62efbe586bfc40428959d175.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__ro_after_init is a specific __attribute__ that checkpatch
does currently not understand.

Add it to the known $Attribute types so that code that uses
variables declared with __ro_after_init are not thought to
be a modifier type.

This appears as a defect in checkpatch output of code like:

static bool trust_cpu __ro_after_init = IS_ENABLED(CONFIG_RANDOM_TRUST_CPU);
[...]
       if (trust_cpu && arch_init) {

where checkpatch reports:

ERROR: space prohibited after that '&&' (ctx:WxW)
	if (trust_cpu && arch_init) {

Reported-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Joe Perches <joe@perches.com>
---
 scripts/checkpatch.pl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 5219280bf7ff..23cde9d90278 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -380,6 +380,7 @@ our $Attribute	= qr{
 			__noclone|
 			__deprecated|
 			__read_mostly|
+			__ro_after_init|
 			__kprobes|
 			$InitAttribute|
 			____cacheline_aligned|
