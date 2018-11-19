Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3950EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 041DE2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1WVRP12R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 041DE2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730690AbeKTC4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:56:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:54512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729986AbeKTC4W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:56:22 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 615BA20831;
        Mon, 19 Nov 2018 16:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645134;
        bh=Y4/H5Ch08vFBJArSPN9+yy/fpHRvUpmnjkjDsUZ5PuA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1WVRP12RXRzAEhSrrZtY+Rt/qJBaNItRz3sDVrHydVn/oEFbfEUnrjpMgBq8wliMQ
         2hwinX2ug/Sa9vmm/rySIjQDcKb2iwfuV987BPmkEtuxUFsBL5j3g8B6qAEIpjN/Rs
         MvvmwAi+HddBl1TuP4RdL9C+tWRSCQ4f9gHS8NzU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Walsh <dwalsh@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 4.19 049/205] ovl: automatically enable redirect_dir on metacopy=on
Date:   Mon, 19 Nov 2018 17:25:56 +0100
Message-Id: <20181119162626.103248453@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162616.586062722@linuxfoundation.org>
References: <20181119162616.586062722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miklos Szeredi <mszeredi@redhat.com>

commit d47748e5ae5af6572e520cc9767bbe70c22ea498 upstream.

Current behavior is to automatically disable metacopy if redirect_dir is
not enabled and proceed with the mount.

If "metacopy=on" mount option was given, then this behavior can confuse the
user: no mount failure, yet metacopy is disabled.

This patch makes metacopy=on imply redirect_dir=on.

The converse is also true: turning off full redirect with redirect_dir=
{off|follow|nofollow} will disable metacopy.

If both metacopy=on and redirect_dir={off|follow|nofollow} is specified,
then mount will fail, since there's no way to correctly resolve the
conflict.

Reported-by: Daniel Walsh <dwalsh@redhat.com>
Fixes: d5791044d2e5 ("ovl: Provide a mount option metacopy=on/off...")
Cc: <stable@vger.kernel.org> # v4.19
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Documentation/filesystems/overlayfs.txt |    6 +++++
 fs/overlayfs/super.c                    |   36 +++++++++++++++++++++++++-------
 2 files changed, 35 insertions(+), 7 deletions(-)

--- a/Documentation/filesystems/overlayfs.txt
+++ b/Documentation/filesystems/overlayfs.txt
@@ -286,6 +286,12 @@ pointed by REDIRECT. This should not be
 "trusted." xattrs will require CAP_SYS_ADMIN. But it should be possible
 for untrusted layers like from a pen drive.
 
+Note: redirect_dir={off|nofollow|follow(*)} conflicts with metacopy=on, and
+results in an error.
+
+(*) redirect_dir=follow only conflicts with metacopy=on if upperdir=... is
+given.
+
 Sharing and copying layers
 --------------------------
 
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -472,6 +472,7 @@ static int ovl_parse_opt(char *opt, stru
 {
 	char *p;
 	int err;
+	bool metacopy_opt = false, redirect_opt = false;
 
 	config->redirect_mode = kstrdup(ovl_redirect_mode_def(), GFP_KERNEL);
 	if (!config->redirect_mode)
@@ -516,6 +517,7 @@ static int ovl_parse_opt(char *opt, stru
 			config->redirect_mode = match_strdup(&args[0]);
 			if (!config->redirect_mode)
 				return -ENOMEM;
+			redirect_opt = true;
 			break;
 
 		case OPT_INDEX_ON:
@@ -548,6 +550,7 @@ static int ovl_parse_opt(char *opt, stru
 
 		case OPT_METACOPY_ON:
 			config->metacopy = true;
+			metacopy_opt = true;
 			break;
 
 		case OPT_METACOPY_OFF:
@@ -572,13 +575,32 @@ static int ovl_parse_opt(char *opt, stru
 	if (err)
 		return err;
 
-	/* metacopy feature with upper requires redirect_dir=on */
-	if (config->upperdir && config->metacopy && !config->redirect_dir) {
-		pr_warn("overlayfs: metadata only copy up requires \"redirect_dir=on\", falling back to metacopy=off.\n");
-		config->metacopy = false;
-	} else if (config->metacopy && !config->redirect_follow) {
-		pr_warn("overlayfs: metadata only copy up requires \"redirect_dir=follow\" on non-upper mount, falling back to metacopy=off.\n");
-		config->metacopy = false;
+	/*
+	 * This is to make the logic below simpler.  It doesn't make any other
+	 * difference, since config->redirect_dir is only used for upper.
+	 */
+	if (!config->upperdir && config->redirect_follow)
+		config->redirect_dir = true;
+
+	/* Resolve metacopy -> redirect_dir dependency */
+	if (config->metacopy && !config->redirect_dir) {
+		if (metacopy_opt && redirect_opt) {
+			pr_err("overlayfs: conflicting options: metacopy=on,redirect_dir=%s\n",
+			       config->redirect_mode);
+			return -EINVAL;
+		}
+		if (redirect_opt) {
+			/*
+			 * There was an explicit redirect_dir=... that resulted
+			 * in this conflict.
+			 */
+			pr_info("overlayfs: disabling metacopy due to redirect_dir=%s\n",
+				config->redirect_mode);
+			config->metacopy = false;
+		} else {
+			/* Automatically enable redirect otherwise. */
+			config->redirect_follow = config->redirect_dir = true;
+		}
 	}
 
 	return 0;


