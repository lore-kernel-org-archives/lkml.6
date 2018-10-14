Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 539EDC7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26A3B20645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:51:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26A3B20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729423AbeJNXc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:32:58 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36146 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727980AbeJNXL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:11:59 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLl-0004cf-3L; Sun, 14 Oct 2018 16:30:37 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLY-0000eW-Qz; Sun, 14 Oct 2018 16:30:24 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Wenwen Wang" <wang6495@umn.edu>,
        "Takashi Iwai" <tiwai@suse.de>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.312508087@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 296/366] ALSA: control: fix a redundant-copy issue
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

From: Wenwen Wang <wang6495@umn.edu>

commit 3f12888dfae2a48741c4caa9214885b3aaf350f9 upstream.

In snd_ctl_elem_add_compat(), the fields of the struct 'data' need to be
copied from the corresponding fields of the struct 'data32' in userspace.
This is achieved by invoking copy_from_user() and get_user() functions. The
problem here is that the 'type' field is copied twice. One is by
copy_from_user() and one is by get_user(). Given that the 'type' field is
not used between the two copies, the second copy is *completely* redundant
and should be removed for better performance and cleanup. Also, these two
copies can cause inconsistent data: as the struct 'data32' resides in
userspace and a malicious userspace process can race to change the 'type'
field between the two copies to cause inconsistent data. Depending on how
the data is used in the future, such an inconsistency may cause potential
security risks.

For above reasons, we should take out the second copy.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 sound/core/control_compat.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/sound/core/control_compat.c
+++ b/sound/core/control_compat.c
@@ -400,8 +400,7 @@ static int snd_ctl_elem_add_compat(struc
 	if (copy_from_user(&data->id, &data32->id, sizeof(data->id)) ||
 	    copy_from_user(&data->type, &data32->type, 3 * sizeof(u32)))
 		goto error;
-	if (get_user(data->owner, &data32->owner) ||
-	    get_user(data->type, &data32->type))
+	if (get_user(data->owner, &data32->owner))
 		goto error;
 	switch (data->type) {
 	case SNDRV_CTL_ELEM_TYPE_BOOLEAN:

