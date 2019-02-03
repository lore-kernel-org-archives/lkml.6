Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 858FAC282DA
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58088218F0
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728623AbfBCNuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 08:50:22 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53300 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728138AbfBCNtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:49:50 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9b-0003wG-S4; Sun, 03 Feb 2019 13:49:48 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9Z-000705-8T; Sun, 03 Feb 2019 14:49:45 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Jiri Kosina" <jkosina@suse.cz>, "Breno Leitao" <leitao@debian.org>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.20288622@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 117/305] HID: hiddev: fix potential Spectre v1
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Breno Leitao <leitao@debian.org>

commit f11274396a538b31bc010f782e05c2ce3f804c13 upstream.

uref->usage_index can be indirectly controlled by userspace, hence leading
to a potential exploitation of the Spectre variant 1 vulnerability.

This field is used as an array index by the hiddev_ioctl_usage() function,
when 'cmd' is either HIDIOCGCOLLECTIONINDEX, HIDIOCGUSAGES or
HIDIOCSUSAGES.

For cmd == HIDIOCGCOLLECTIONINDEX case, uref->usage_index is compared to
field->maxusage and then used as an index to dereference field->usage
array. The same thing happens to the cmd == HIDIOC{G,S}USAGES cases, where
uref->usage_index is checked against an array maximum value and then it is
used as an index in an array.

This is a summary of the HIDIOCGCOLLECTIONINDEX case, which matches the
traditional Spectre V1 first load:

	copy_from_user(uref, user_arg, sizeof(*uref))
	if (uref->usage_index >= field->maxusage)
		goto inval;
	i = field->usage[uref->usage_index].collection_index;
	return i;

This patch fixes this by sanitizing field uref->usage_index before using it
to index field->usage (HIDIOCGCOLLECTIONINDEX) or field->value in
HIDIOC{G,S}USAGES arrays, thus, avoiding speculation in the first load.

Signed-off-by: Breno Leitao <leitao@debian.org>
--

v2: Contemplate cmd == HIDIOC{G,S}USAGES case
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/hid/usbhid/hiddev.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

--- a/drivers/hid/usbhid/hiddev.c
+++ b/drivers/hid/usbhid/hiddev.c
@@ -521,14 +521,24 @@ static noinline int hiddev_ioctl_usage(s
 			if (cmd == HIDIOCGCOLLECTIONINDEX) {
 				if (uref->usage_index >= field->maxusage)
 					goto inval;
+				uref->usage_index =
+					array_index_nospec(uref->usage_index,
+							   field->maxusage);
 			} else if (uref->usage_index >= field->report_count)
 				goto inval;
 		}
 
-		if ((cmd == HIDIOCGUSAGES || cmd == HIDIOCSUSAGES) &&
-		    (uref_multi->num_values > HID_MAX_MULTI_USAGES ||
-		     uref->usage_index + uref_multi->num_values > field->report_count))
-			goto inval;
+		if (cmd == HIDIOCGUSAGES || cmd == HIDIOCSUSAGES) {
+			if (uref_multi->num_values > HID_MAX_MULTI_USAGES ||
+			    uref->usage_index + uref_multi->num_values >
+			    field->report_count)
+				goto inval;
+
+			uref->usage_index =
+				array_index_nospec(uref->usage_index,
+						   field->report_count -
+						   uref_multi->num_values);
+		}
 
 		switch (cmd) {
 		case HIDIOCGUSAGE:

