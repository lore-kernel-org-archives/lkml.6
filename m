Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B69C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 22:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64CA8206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 22:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VYWJ4Mwa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfBVW4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 17:56:03 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36195 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfBVW4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 17:56:02 -0500
Received: by mail-pl1-f196.google.com with SMTP id k2so1736825plt.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 14:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bLHnWF4HE24H98X+yqG5tX7xwosxYZa5Uek6EnvgIuA=;
        b=VYWJ4MwaclysCqYkAws5vNimsxkMlcL57r0Wm0VrGLQMS/cAYh/Lc764KHRdGRR2cq
         2LlGC7blW2jzFHTd3492A7E+wCaJEaSZKpunAcHq37gzKY9cqgY3pH/KV6AtJ9rGjn9m
         5jd2YcRiKAiuWuIq1yF23HDg8gnug96uVhkzQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bLHnWF4HE24H98X+yqG5tX7xwosxYZa5Uek6EnvgIuA=;
        b=NhL9BpNEO7YdjDA0eOYPjUXTPbZRx/NBCdLvBcqPb9qL0x/AsDOWSu4zdaegFmI6JS
         3BlU83sIniDXTbIIeRM3R28qJtpKSosDTJrl7VSxa9x27czmoRylmOT0pR3fl3BzxLO6
         zvkVRI8TmWN+Da7OOeIHqGTs2cz519mmKbh8kw0kOIdezvavaA3ASxHzficb0N+18gbr
         hDBnvCUIGYL92vyFA9m61a85n9lT/K1Yd6W7ol+PYWfV6u8RLVQ5KQqFWiq6HodCp+Xq
         z2sEdWU1bl0f1uFM7ktQ6gFvF1Oa5Tsxu9u9Tw08+8r1QGp2qpTt/q5ZDe5WSOqDfmp4
         PUbw==
X-Gm-Message-State: AHQUAuZxL0bpF2g8h9vaRY4u2SsX3Tc5Lzlw80CJvXhC24QlzCc6RCe3
        9SG3slWFxX+lRioHlg/XhHJLfVOk2eg=
X-Google-Smtp-Source: AHgI3IZaMFfyrobJGJS5JVqla0488OkpfeQPtlFfu+DOTog8zSlG3UrDWCxtGarZ+T+5Mm7j8AIP2g==
X-Received: by 2002:a17:902:59c1:: with SMTP id d1mr6427648plj.324.1550876162086;
        Fri, 22 Feb 2019 14:56:02 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id q62sm4648546pfi.183.2019.02.22.14.56.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 14:56:01 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Cc:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH] checkpatch: don't complain about "undocumented" USB VID
Date:   Fri, 22 Feb 2019 14:55:45 -0800
Message-Id: <20190222225545.78031-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation/devicetree/bindings/usb/usb-device.txt describes the
'usbVID,...' compatible format, where VID is hexadecimal, with leading
zeroes suppressed. Allow it here without complaining.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 scripts/checkpatch.pl | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index b737ca9d7204..124c6fc116b3 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3012,6 +3012,8 @@ sub process {
 				}
 
 				next if $compat !~ /^([a-zA-Z0-9\-]+)\,/;
+				# USB VIDs don't need special vendor prefix documentation.
+				next if $compat =~ /^usb[1-9a-f][0-9a-f]{0,3},/;
 				my $vendor = $1;
 				`grep -Eq "^$vendor\\b" $vp_file`;
 				if ( $? >> 8 ) {
-- 
2.21.0.rc0.258.g878e2cd30e-goog

