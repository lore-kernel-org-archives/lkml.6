Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE31DC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 02:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2BB920645
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 02:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e0yaoPEJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbfBWCYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 21:24:49 -0500
Received: from mail-pf1-f180.google.com ([209.85.210.180]:32989 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfBWCYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 21:24:49 -0500
Received: by mail-pf1-f180.google.com with SMTP id i19so1926785pfd.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 18:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G9+Ae53ZvLV67J4HnMipCGxpuUPJhCLJMuqFiUVatho=;
        b=e0yaoPEJq+K2CbXl2tt+mSnvDQFHza7ofy3t86Ntaas/f1mIiWjKbTX1nxKWtJDNqA
         ShSVi2fn399L5ZadbFQdj/5A9GhX5woBsINlxyxu02qVlWxrxM2gTQr73UwCSSTLuKSR
         Ty/wb3CqjPxGBZtKtIcP3ncpq7F/iuwXb1BoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G9+Ae53ZvLV67J4HnMipCGxpuUPJhCLJMuqFiUVatho=;
        b=n4Gd1slrQk4AP/ICkixOjSeDqyMk2BOonVA4LqGIKPnQHJfkGc4Md9iJyX5uaxADm/
         E0vQhw+OXjoaVUDmcWXjO9Fcy7pYijrdQOqJgRiJ3lAGMnpjoCs7r5ylCtfyWbvXykGd
         u8RjnwVwIg8v349dESp29g8dwOnQBcGxQkefsnPC5XFMGHFFvK9oRIQ1AxEBHKy2ltPg
         yu5KowxalDf2lR/kA7SLJMa4Re7KVfSZpAnibjw1Ts/fXTjfpjQ4lu9tY+2/NRbh5Jk7
         J2ysTYdPh9B7F3NX6o/oguGlv4mLyOUVj8ZTgr5b2SScPEB4bd/RB62TtI0zP3Ze5RIh
         WqEg==
X-Gm-Message-State: AHQUAubnwTokThqb+6tUIR4dQDWsyWBoOnuqj8EceohWdhzSHMPK2NWn
        9NWMAPaF3tsTsGDLaPVMetk97g==
X-Google-Smtp-Source: AHgI3Ibe7zyBHUiLYdIZazFvyP09AeCtsVSY+ZwsIjB+ViDGTHGSBwQ3oicEgNbId/LgQotJ/Pa7nA==
X-Received: by 2002:a65:63c8:: with SMTP id n8mr6853651pgv.158.1550888688369;
        Fri, 22 Feb 2019 18:24:48 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id q5sm3602966pga.71.2019.02.22.18.24.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 18:24:47 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Cc:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2] checkpatch: handle PCI/USB VID,PID in DT compatible
Date:   Fri, 22 Feb 2019 18:24:40 -0800
Message-Id: <20190223022440.146915-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation/devicetree/bindings/usb/usb-device.txt describes the
'usbVID,...' compatible format, where VID is lower-case hexadecimal,
with leading zeroes suppressed. Allow it here without complaining about
lack of documentation (we don't need a new entry for every ID).

PCI has a similar format
Documentation/devicetree/bindings/pci/pci.txt
http://www.devicetree.org/open-firmware/bindings/pci/pci2_1.pdf

For both, I try to detect something that's close to a VID,PID, but I
intentionally don't parse beyond 4 characters of PID, since USB supports
extending with an interface index, and PCI supports additional subystem
IDs.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
Overall, this got a little more unwieldy, but it works.

v2:
 * Include PCI in addition to USB
 * Add special warning for leading zeroes and for upper-case
 * Move the VID,PID check up higher, so we don't complain about
   documentation at all if using the correct format
---
 scripts/checkpatch.pl | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index b737ca9d7204..9e770a8f5dfa 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3001,6 +3001,24 @@ sub process {
 			my $vp_file = $dt_path . "vendor-prefixes.txt";
 
 			foreach my $compat (@compats) {
+				my ($vendor, $device) = ("", "");
+				if ($compat =~ /^([a-zA-Z0-9\-]+)\,(.*)$/) {
+					($vendor, $device) = ($1, $2);
+				}
+
+				# PCI and USB VIDs/PIDs have special rules.
+				if ($vendor =~ /^(usb|pci)[0-9a-fA-F]{1,4}$/ && $device =~ /^[0-9a-fA-F]{1,4}/) {
+					if ($vendor =~ /^(usb|pci).*[A-F]/ || $device =~ /[A-F]/) {
+						WARN("UNDOCUMENTED_DT_STRING",
+						     "VID/PID in DT compatible string (\"$compat\") should use lower-case hexadecimal\n" . $herecurr);
+					}
+					if ($vendor =~ /^(usb|pci)0/ || $device =~ /^0/) {
+						WARN("UNDOCUMENTED_DT_STRING",
+						     "VID/PID in DT compatible string (\"$compat\") should omit leading zeroes\n" . $herecurr);
+					}
+					next;
+				}
+
 				my $compat2 = $compat;
 				$compat2 =~ s/\,[a-zA-Z0-9]*\-/\,<\.\*>\-/;
 				my $compat3 = $compat;
@@ -3011,8 +3029,7 @@ sub process {
 					     "DT compatible string \"$compat\" appears un-documented -- check $dt_path\n" . $herecurr);
 				}
 
-				next if $compat !~ /^([a-zA-Z0-9\-]+)\,/;
-				my $vendor = $1;
+				next if "$vendor" eq "";
 				`grep -Eq "^$vendor\\b" $vp_file`;
 				if ( $? >> 8 ) {
 					WARN("UNDOCUMENTED_DT_STRING",
-- 
2.21.0.rc0.258.g878e2cd30e-goog

