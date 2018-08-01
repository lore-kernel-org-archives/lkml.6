Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77AF1C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 19:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CBCF208A5
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 19:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bLMVMHiK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CBCF208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732314AbeHAVZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 17:25:06 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36041 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730149AbeHAVZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 17:25:06 -0400
Received: by mail-wm0-f68.google.com with SMTP id w24-v6so272620wmc.1;
        Wed, 01 Aug 2018 12:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=REdI92xWN3G04bKLZe1pmGHNjtXZOohy6otviovoJZg=;
        b=bLMVMHiKR70U6uEUi3/Xt+y5iMqGINWGt2vSukK1lr8YG5f+m1vCfsKL1LmCX/K/fk
         4Bf1c8seODytjdAD39IknMD37cMdfrHTuuWVSQMvVv7zycLNHVEZGYppTh30U66f62kx
         Y6ljtBvkYNBwfUbPWv5+KmGZyBF+x0ITQ4mEFXtmuRzKwfJIzf6mxiK0FcxOmaVZLdUD
         oiNMSVi30apLhG4ZJ+7Eh8l0KTjOov2OIotWnPB2KvOtoIh6MteCfuS+qyektwIa4C2X
         4OapTo4cXRW1eLmxkCqvgn85smcz3pvNhDme2QDmqtBF7C6ECwAOsEbGLQ+9BgBKXyMh
         FXZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=REdI92xWN3G04bKLZe1pmGHNjtXZOohy6otviovoJZg=;
        b=FwnwEpH/BH+XcQNJWjmDoa7wyHkANAgV1ZhisWPAdr+1I8XTUrgDNimfwG4gHvJjw3
         fdKIgz9hgiePFp8aB/FXMLh28oZzsE5jypfectBspQRN9CKpsQZIwt4Lb2uEtwclUAZM
         Ja6R2qem4fw0GbXPGZxhXv6M3/QiqOkJSFYS2vbJH2tpg+HsfaXb3HNCLDOtblFN3IhN
         XYOxI0aPJC3RyCGC4Iezln6DprqBuq6mNna4at027A2/2VQ+/UhjX3lZxVO8sySp5ADk
         W3MoDlxNJNojDrFS9CQsjWDtcPj9Nvho1xCUAHzJE+ujnsShZRvCMMJPFmVpp/EFMNso
         PXKw==
X-Gm-Message-State: AOUpUlGp3g5efiqXdmN+yNG2tqF2TKjsA/v9LM7Hg5f6BuxZOqpMnkVz
        R4+GlslN2PCS6hPpurfkeX8TIOWRODE=
X-Google-Smtp-Source: AAOMgpe8P3K+2400bdTfKqdqu1JwYUthNj9D1iHPvWeHcP56S1sKOYh4ZbbzUx5FeVyHO7yhdMlfAg==
X-Received: by 2002:a1c:ea53:: with SMTP id i80-v6mr133290wmh.113.1533152265717;
        Wed, 01 Aug 2018 12:37:45 -0700 (PDT)
Received: from clt2.thsystems.local (host210-138-dynamic.4-87-r.retail.telecomitalia.it. [87.4.138.210])
        by smtp.googlemail.com with ESMTPSA id b202-v6sm248983wme.22.2018.08.01.12.37.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 12:37:45 -0700 (PDT)
From:   Thomas Bianchi <thomas.bianchi8@gmail.com>
To:     linux-xfs@vger.kernel.org
Cc:     Thomas Bianchi <thomas.bianchi8@gmail.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] xfs: substitute spaces with tabs
Date:   Wed,  1 Aug 2018 18:22:25 +0200
Message-Id: <1533140611-23467-1-git-send-email-thomas.bianchi8@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inside xfs_attr_shortform_list removes spaces at the beginnig of the line
and replaces with tabs.
Issue found by checkpatch.

ERROR: code indent should use tabs where possible

Signed-off-by: Thomas Bianchi <thomas.bianchi8@gmail.com>
---
 fs/xfs/xfs_attr_list.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_attr_list.c b/fs/xfs/xfs_attr_list.c
index f9ca801..a580340 100644
--- a/fs/xfs/xfs_attr_list.c
+++ b/fs/xfs/xfs_attr_list.c
@@ -87,7 +87,7 @@
 	 */
 	if (context->bufsize == 0 ||
 	    (XFS_ISRESET_CURSOR(cursor) &&
-             (dp->i_afp->if_bytes + sf->hdr.count * 16) < context->bufsize)) {
+	     (dp->i_afp->if_bytes + sf->hdr.count * 16) < context->bufsize)) {
 		for (i = 0, sfe = &sf->list[0]; i < sf->hdr.count; i++) {
 			context->put_listent(context,
 					     sfe->flags,
-- 
1.8.3.1

