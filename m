Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47892C71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1805D2145D
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:30:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1805D2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbeJNXLk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:11:40 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35591 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726623AbeJNXLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:11:39 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLS-0004cH-Dz; Sun, 14 Oct 2018 16:30:18 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLN-00008f-5p; Sun, 14 Oct 2018 16:30:13 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Michal Srb" <msrb@suse.com>,
        "Chris Wilson" <chris@chris-wilson.co.uk>
Date:   Sun, 14 Oct 2018 16:25:40 +0100
Message-ID: <lsq.1539530740.657169528@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 004/366] drm/i915/cmdparser: Do not check past the
 cmd length.
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Michal Srb <msrb@suse.com>

commit 3aec7f871c65eb5f76b4125fda432593c834a6f2 upstream.

The command MEDIA_VFE_STATE checks bits at offset +2 dwords. However, it is
possible to have MEDIA_VFE_STATE command with length = 0 + LENGTH_BIAS = 2.
In that case check_cmd will read bits from the following command, or even past
the end of the buffer.

If the offset ends up outside of the command length, reject the command.

Fixes: 351e3db2b363 ("drm/i915: Implement command buffer parsing logic")
Signed-off-by: Michal Srb <msrb@suse.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20180205151745.29292-1-msrb@suse.com
Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Link: https://patchwork.freedesktop.org/patch/msgid/20180205160438.3267-2-chris@chris-wilson.co.uk
[bwh: Backported to 3.16: Log ring->id rather than engine->name]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/gpu/drm/i915/i915_cmd_parser.c | 6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/gpu/drm/i915/i915_cmd_parser.c
+++ b/drivers/gpu/drm/i915/i915_cmd_parser.c
@@ -941,6 +941,12 @@ static bool check_cmd(const struct intel
 					continue;
 			}
 
+			if (desc->bits[i].offset >= length) {
+				DRM_DEBUG_DRIVER("CMD: Rejected command 0x%08X, too short to check bitmask (ring=%d)\n",
+						 *cmd, ring->id);
+				return false;
+			}
+
 			dword = cmd[desc->bits[i].offset] &
 				desc->bits[i].mask;
 

