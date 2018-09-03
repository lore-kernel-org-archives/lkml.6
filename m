Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A530C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16A6820658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:28:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16A6820658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731174AbeICVti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:49:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46436 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731162AbeICVth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:49:37 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 34071D18;
        Mon,  3 Sep 2018 17:28:29 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Kees Cook <keescook@chromium.org>,
        Lance Albertson <lance@osuosl.org>
Subject: [PATCH 4.14 165/165] gcc-plugins: Use dynamic initializers
Date:   Mon,  3 Sep 2018 18:57:31 +0200
Message-Id: <20180903165705.371605015@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165655.003605184@linuxfoundation.org>
References: <20180903165655.003605184@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kees Cook <keescook@chromium.org>

commit b86729109c5fd0a480300f40608aac68764b5adf upstream.

GCC 8 changed the order of some fields and is very picky about ordering
in static initializers, so instead just move to dynamic initializers,
and drop the redundant already-zero field assignments.

Suggested-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
Signed-off-by: Kees Cook <keescook@chromium.org>
Cc: Lance Albertson <lance@osuosl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 scripts/gcc-plugins/latent_entropy_plugin.c   |   17 +----
 scripts/gcc-plugins/randomize_layout_plugin.c |   75 +++++++-------------------
 scripts/gcc-plugins/structleak_plugin.c       |   19 ++----
 3 files changed, 33 insertions(+), 78 deletions(-)

--- a/scripts/gcc-plugins/latent_entropy_plugin.c
+++ b/scripts/gcc-plugins/latent_entropy_plugin.c
@@ -255,21 +255,14 @@ static tree handle_latent_entropy_attrib
 	return NULL_TREE;
 }
 
-static struct attribute_spec latent_entropy_attr = {
-	.name				= "latent_entropy",
-	.min_length			= 0,
-	.max_length			= 0,
-	.decl_required			= true,
-	.type_required			= false,
-	.function_type_required		= false,
-	.handler			= handle_latent_entropy_attribute,
-#if BUILDING_GCC_VERSION >= 4007
-	.affects_type_identity		= false
-#endif
-};
+static struct attribute_spec latent_entropy_attr = { };
 
 static void register_attributes(void *event_data __unused, void *data __unused)
 {
+	latent_entropy_attr.name		= "latent_entropy";
+	latent_entropy_attr.decl_required	= true;
+	latent_entropy_attr.handler		= handle_latent_entropy_attribute;
+
 	register_attribute(&latent_entropy_attr);
 }
 
--- a/scripts/gcc-plugins/randomize_layout_plugin.c
+++ b/scripts/gcc-plugins/randomize_layout_plugin.c
@@ -580,68 +580,35 @@ static void finish_type(void *event_data
 	return;
 }
 
-static struct attribute_spec randomize_layout_attr = {
-	.name		= "randomize_layout",
-	// related to args
-	.min_length	= 0,
-	.max_length	= 0,
-	.decl_required	= false,
-	// need type declaration
-	.type_required	= true,
-	.function_type_required = false,
-	.handler		= handle_randomize_layout_attr,
-#if BUILDING_GCC_VERSION >= 4007
-	.affects_type_identity  = true
-#endif
-};
+static struct attribute_spec randomize_layout_attr = { };
+static struct attribute_spec no_randomize_layout_attr = { };
+static struct attribute_spec randomize_considered_attr = { };
+static struct attribute_spec randomize_performed_attr = { };
 
-static struct attribute_spec no_randomize_layout_attr = {
-	.name		= "no_randomize_layout",
-	// related to args
-	.min_length	= 0,
-	.max_length	= 0,
-	.decl_required	= false,
-	// need type declaration
-	.type_required	= true,
-	.function_type_required = false,
-	.handler		= handle_randomize_layout_attr,
+static void register_attributes(void *event_data, void *data)
+{
+	randomize_layout_attr.name		= "randomize_layout";
+	randomize_layout_attr.type_required	= true;
+	randomize_layout_attr.handler		= handle_randomize_layout_attr;
 #if BUILDING_GCC_VERSION >= 4007
-	.affects_type_identity  = true
+	randomize_layout_attr.affects_type_identity = true;
 #endif
-};
 
-static struct attribute_spec randomize_considered_attr = {
-	.name		= "randomize_considered",
-	// related to args
-	.min_length	= 0,
-	.max_length	= 0,
-	.decl_required	= false,
-	// need type declaration
-	.type_required	= true,
-	.function_type_required = false,
-	.handler		= handle_randomize_considered_attr,
+	no_randomize_layout_attr.name		= "no_randomize_layout";
+	no_randomize_layout_attr.type_required	= true;
+	no_randomize_layout_attr.handler	= handle_randomize_layout_attr;
 #if BUILDING_GCC_VERSION >= 4007
-	.affects_type_identity  = false
+	no_randomize_layout_attr.affects_type_identity = true;
 #endif
-};
 
-static struct attribute_spec randomize_performed_attr = {
-	.name		= "randomize_performed",
-	// related to args
-	.min_length	= 0,
-	.max_length	= 0,
-	.decl_required	= false,
-	// need type declaration
-	.type_required	= true,
-	.function_type_required = false,
-	.handler		= handle_randomize_performed_attr,
-#if BUILDING_GCC_VERSION >= 4007
-	.affects_type_identity  = false
-#endif
-};
+	randomize_considered_attr.name		= "randomize_considered";
+	randomize_considered_attr.type_required	= true;
+	randomize_considered_attr.handler	= handle_randomize_considered_attr;
+
+	randomize_performed_attr.name		= "randomize_performed";
+	randomize_performed_attr.type_required	= true;
+	randomize_performed_attr.handler	= handle_randomize_performed_attr;
 
-static void register_attributes(void *event_data, void *data)
-{
 	register_attribute(&randomize_layout_attr);
 	register_attribute(&no_randomize_layout_attr);
 	register_attribute(&randomize_considered_attr);
--- a/scripts/gcc-plugins/structleak_plugin.c
+++ b/scripts/gcc-plugins/structleak_plugin.c
@@ -57,21 +57,16 @@ static tree handle_user_attribute(tree *
 	return NULL_TREE;
 }
 
-static struct attribute_spec user_attr = {
-	.name			= "user",
-	.min_length		= 0,
-	.max_length		= 0,
-	.decl_required		= false,
-	.type_required		= false,
-	.function_type_required	= false,
-	.handler		= handle_user_attribute,
-#if BUILDING_GCC_VERSION >= 4007
-	.affects_type_identity	= true
-#endif
-};
+static struct attribute_spec user_attr = { };
 
 static void register_attributes(void *event_data, void *data)
 {
+	user_attr.name			= "user";
+	user_attr.handler		= handle_user_attribute;
+#if BUILDING_GCC_VERSION >= 4007
+	user_attr.affects_type_identity	= true;
+#endif
+
 	register_attribute(&user_attr);
 }
 


