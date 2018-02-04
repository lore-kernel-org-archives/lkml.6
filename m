Return-Path: <kernel-hardening-return-11580-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x224XVWTTpEewLv7vgCoMqAO3qqZR48ZY9WG/5It3jEVF48rGJhS28HM0Pc7uCXoUJ83I4RaG
ARC-Seal: i=1; a=rsa-sha256; t=1517765704; cv=none;
        d=google.com; s=arc-20160816;
        b=s7Jp7v9g5oDyKQ7DO0lKsVbeMdskoo1ls160sRp32HeAgd5G6dh+ERKP+iw9Vt5a+c
         uLGC/2bpLpuurJnWr/UZTw8IaEMJQfR272ODBGwp0jZo+qLGytjTR6ZU3aRxU6zgEM8/
         Il5Ib3oZSi0ClXR2y6ooPCLHXmPiBhRa71VKm0/AkTzTEp/fzDagkxEJ6EBavQeqwl/c
         QmlstEnzn+lSEfxfAAi+PPo7E7deSp2RjGhK03xvoYRz5RaCcp/cZPZjYulnYW6FjKXC
         wKeUiTE1CxK++qZjRhKulXF436cluzxIF/hWibn+hPxvCpZepimWJdQB+8lSmbqndsCQ
         WWgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:mime-version:subject:cc:to:from:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=QPVwTxOniS1xOM6ictjFNyuXVLeCgoSDVIjhUgMrz5Y=;
        b=PUMNeOTXx5zheytPl3YlynlkCAgC8PhZMhbK1tJ3KvYS/CYSWva1IySWYRKvUEn56n
         ivFAU7l7n6HZ5VLlniXUwY/STqFR7XeRc9LK2MwmQCAsi+ojxVk9uEGLvyTthMcAHB96
         59IaJtCMFXNfV1zcKPC9LxmWm21s9NCcW+Lprl3FS3J91s8ArJOBk+OB6aQl5QPxPW6Y
         kzX7wR0d/e+OpEeur1jsY0Xr+9yF+oCitKNefNjYRCoxx12Q5yCRTReCFi7KblFdYhcq
         4TH5CY76bXbolx3Jl9K1zX1CMmyPJPKkgKcuKMsHZ9I9Z21FC0Su3t7Xzlu8dbX91ON/
         wfFA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11580-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11580-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=vt.edu
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11580-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11580-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=vt.edu
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
X-Mailer: exmh version 2.8.0 04/21/2017 with nmh-1.7+dev
From: valdis.kletnieks@vt.edu
To: Kees Cook <keescook@chromium.org>, kernel-hardening@lists.openwall.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] GCC release 8 support for gcc-plugins
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 04 Feb 2018 12:34:38 -0500
Message-ID: <123377.1517765678@turing-police.cc.vt.edu>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591490625322246882?=
X-GMAIL-MSGID: =?utf-8?q?1591492691479927314?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

For reasons totally beyond my understanding, gcc 8 changed the
order of two structure member, which leads to an error:

  HOSTCXX -fPIC scripts/gcc-plugins/latent_entropy_plugin.o
scripts/gcc-plugins/latent_entropy_plugin.c:269:1: error: designator order for field 'attribute_spec::affects_type_identity' does not match declaration order in 'attribute_spec'
 };
 ^
make[1]: *** [scripts/Makefile.host:141: scripts/gcc-plugins/latent_entropy_plugin.o] Error 1

Maybe we'll get lucky and they'll undo that change before official release, so all
this ad-crock #ifdef-ery won't be needed.  Do we know any gcc experts to ask?

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

--- diff --git a/scripts/gcc-plugins/latent_entropy_plugin.c b/scripts/gcc-plugins/latent_entropy_plugin.c
index 65264960910d..15a6df3592c5 100644
--- a/scripts/gcc-plugins/latent_entropy_plugin.c
+++ b/scripts/gcc-plugins/latent_entropy_plugin.c
@@ -262,10 +262,17 @@ static struct attribute_spec latent_entropy_attr = {
 	.decl_required			= true,
 	.type_required			= false,
 	.function_type_required		= false,
+#if BUILDING_GCC_VERSION >= 8000
+	.affects_type_identity		= false,
 	.handler			= handle_latent_entropy_attribute,
+#else
 #if BUILDING_GCC_VERSION >= 4007
-	.affects_type_identity		= false
-#endif
+	.handler			= handle_latent_entropy_attribute,
+	.affects_type_identity		= false,
+#else
+	.handler			= handle_latent_entropy_attribute,
+#endif /* >= 4007 */
+#endif /* >= 8000 */
 };
 
 static void register_attributes(void *event_data __unused, void *data __unused)
diff --git a/scripts/gcc-plugins/structleak_plugin.c b/scripts/gcc-plugins/structleak_plugin.c
index 3f8dd4868178..f700bc059050 100644
--- a/scripts/gcc-plugins/structleak_plugin.c
+++ b/scripts/gcc-plugins/structleak_plugin.c
@@ -64,10 +64,17 @@ static struct attribute_spec user_attr = {
 	.decl_required		= false,
 	.type_required		= false,
 	.function_type_required	= false,
-	.handler		= handle_user_attribute,
+#if BUILDING_GCC_VERSION >= 8000
+	.affects_type_identity		= false,
+	.handler			= handle_latent_entropy_attribute,
+#else
 #if BUILDING_GCC_VERSION >= 4007
-	.affects_type_identity	= true
-#endif
+	.handler			= handle_latent_entropy_attribute,
+	.affects_type_identity		= false,
+#else
+	.handler			= handle_latent_entropy_attribute,
+#endif /* >= 4007 */
+#endif /* >= 8000 */
 };
 
 static void register_attributes(void *event_data, void *data)
diff --git a/scripts/gcc-plugins/randomize_layout_plugin.c b/scripts/gcc-plugins/randomize_layout_plugin.c
index 0073af326449..1dafa102a907 100644
--- a/scripts/gcc-plugins/randomize_layout_plugin.c
+++ b/scripts/gcc-plugins/randomize_layout_plugin.c
@@ -589,10 +589,17 @@ static struct attribute_spec randomize_layout_attr = {
 	// need type declaration
 	.type_required	= true,
 	.function_type_required = false,
-	.handler		= handle_randomize_layout_attr,
+#if BUILDING_GCC_VERSION >= 8000
+	.affects_type_identity		= false,
+	.handler			= handle_latent_entropy_attribute,
+#else
 #if BUILDING_GCC_VERSION >= 4007
-	.affects_type_identity  = true
-#endif
+	.handler			= handle_latent_entropy_attribute,
+	.affects_type_identity		= false,
+#else
+	.handler			= handle_latent_entropy_attribute,
+#endif /* >= 4007 */
+#endif /* >= 8000 */
 };
 
 static struct attribute_spec no_randomize_layout_attr = {
@@ -604,10 +611,17 @@ static struct attribute_spec no_randomize_layout_attr = {
 	// need type declaration
 	.type_required	= true,
 	.function_type_required = false,
-	.handler		= handle_randomize_layout_attr,
+#if BUILDING_GCC_VERSION >= 8000
+	.affects_type_identity		= false,
+	.handler			= handle_latent_entropy_attribute,
+#else
 #if BUILDING_GCC_VERSION >= 4007
-	.affects_type_identity  = true
-#endif
+	.handler			= handle_latent_entropy_attribute,
+	.affects_type_identity		= false,
+#else
+	.handler			= handle_latent_entropy_attribute,
+#endif /* >= 4007 */
+#endif /* >= 8000 */
 };
 
 static struct attribute_spec randomize_considered_attr = {
@@ -619,10 +633,17 @@ static struct attribute_spec randomize_considered_attr = {
 	// need type declaration
 	.type_required	= true,
 	.function_type_required = false,
-	.handler		= handle_randomize_considered_attr,
+#if BUILDING_GCC_VERSION >= 8000
+	.affects_type_identity		= false,
+	.handler			= handle_latent_entropy_attribute,
+#else
 #if BUILDING_GCC_VERSION >= 4007
-	.affects_type_identity  = false
-#endif
+	.handler			= handle_latent_entropy_attribute,
+	.affects_type_identity		= false,
+#else
+	.handler			= handle_latent_entropy_attribute,
+#endif /* >= 4007 */
+#endif /* >= 8000 */
 };
 
 static struct attribute_spec randomize_performed_attr = {
@@ -634,10 +655,17 @@ static struct attribute_spec randomize_performed_attr = {
 	// need type declaration
 	.type_required	= true,
 	.function_type_required = false,
-	.handler		= handle_randomize_performed_attr,
+#if BUILDING_GCC_VERSION >= 8000
+	.affects_type_identity		= false,
+	.handler			= handle_latent_entropy_attribute,
+#else
 #if BUILDING_GCC_VERSION >= 4007
-	.affects_type_identity  = false
-#endif
+	.handler			= handle_latent_entropy_attribute,
+	.affects_type_identity		= false,
+#else
+	.handler			= handle_latent_entropy_attribute,
+#endif /* >= 4007 */
+#endif /* >= 8000 */
 };
 
 static void register_attributes(void *event_data, void *data)
