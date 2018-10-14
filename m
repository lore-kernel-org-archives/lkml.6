Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93DA2C71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6175020645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:42:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6175020645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728948AbeJNXXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:23:24 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36930 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728030AbeJNXXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:23:24 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiMH-0004cm-Ht; Sun, 14 Oct 2018 16:31:09 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLO-0000Ba-DG; Sun, 14 Oct 2018 16:30:14 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Mike Frysinger" <vapier@chromium.org>
Date:   Sun, 14 Oct 2018 16:25:40 +0100
Message-ID: <lsq.1539530740.884953935@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 039/366] vt: change SGR 21 to follow the standards
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

From: Mike Frysinger <vapier@chromium.org>

commit 65d9982d7e523a1a8e7c9af012da0d166f72fc56 upstream.

ECMA-48 [1] (aka ISO 6429) has defined SGR 21 as "doubly underlined"
since at least March 1984.  The Linux kernel has treated it as SGR 22
"normal intensity" since it was added in Linux-0.96b in June 1992.
Before that, it was simply ignored.  Other terminal emulators have
either ignored it, or treat it as double underline now.  xterm for
example added support in its 304 release (May 2014) [2] where it was
previously ignoring it.

Changing this behavior shouldn't be an issue:
- It isn't a named capability in ncurses's terminfo database, so no
  script is using libtinfo/libcurses to look this up, or using tput
  to query & output the right sequence.
- Any script assuming SGR 21 will reset intensity in all terminals
  already do not work correctly on non-Linux VTs (including running
  under screen/tmux/etc...).
- If someone has written a script that only runs in the Linux VT, and
  they're using SGR 21 (instead of SGR 22), the output should still
  be readable.

imo it's important to change this as the Linux VT's non-conformance
is sometimes used as an argument for other terminal emulators to not
implement SGR 21 at all, or do so incorrectly.

[1]: https://www.ecma-international.org/publications/standards/Ecma-048.htm
[2]: https://github.com/ThomasDickey/xterm-snapshots/commit/2fd29cb98d214cb536bcafbee00bc73b3f1eeb9d

Signed-off-by: Mike Frysinger <vapier@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.16: adjust indentation]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/tty/vt/vt.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1303,6 +1303,11 @@ static void csi_m(struct vc_data *vc)
 			case 3:
 				vc->vc_italic = 1;
 				break;
+			case 21:
+				/*
+				 * No console drivers support double underline, so
+				 * convert it to a single underline.
+				 */
 			case 4:
 				vc->vc_underline = 1;
 				break;
@@ -1339,7 +1344,6 @@ static void csi_m(struct vc_data *vc)
 				vc->vc_disp_ctrl = 1;
 				vc->vc_toggle_meta = 1;
 				break;
-			case 21:
 			case 22:
 				vc->vc_intensity = 1;
 				break;

