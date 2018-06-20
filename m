Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE55C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D95E120846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:35:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D95E120846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754166AbeFTOfT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 10:35:19 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:58661 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752856AbeFTOfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 10:35:17 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue103 [212.227.15.145]) with ESMTPA (Nemesis) id
 0MYLUv-1fj2M40HXl-00V8Vn; Wed, 20 Jun 2018 16:35:05 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>,
        David Sterba <dsterba@suse.com>
Cc:     y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] btrfs: use 64-bit timestamps for struct btrfs_dev_replace_item
Date:   Wed, 20 Jun 2018 16:34:33 +0200
Message-Id: <20180620143448.44388-2-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180620143448.44388-1-arnd@arndb.de>
References: <20180620143448.44388-1-arnd@arndb.de>
X-Provags-ID: V03:K1:qfBHUeRe4dB1qRa0S8jd7SDPMnKRIt5xHOzntFHibu3uJJnuumo
 dy1cfElifhdyVTuiBRwrnxczzmZuiGythjLwCX5g1kg9vnaBc0CkTOqemChQfoXpgnZJhdm
 YlZun5zb1P2RszmzszGwwsMKn60eeTxec5wAYC4R/GASm38apvu3bfo6L8W8rUqKNVEOcqP
 nI0RPqttcwynVrfp5rZKA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fUHJ0lXFL10=:FWCl/lSF8JKMqWaDusUkvr
 9PsJlcSmk0BZDDxETliIT1yvXRgryKtrHY2d3GXw54SmKl+x3hhtd5vV6cX4UiPfhPD4ZKki3
 LDoybKt3DZLvm2v9ywNv4Ygh8d3TxUgeSjOJLn9RiHJ3N5JUF26k7V4kVVnsU4cLMhd1k/cHB
 EWZQkkk858Het2XJ6eIaCW27jgs6etAAykjgXSrv7e9T9x7JhqSpQ4XYFPtRswNGMtKktJ1xF
 Pf2fP6GszBXKkqCtalmvsilxbIaVkMuibh504QaYIykCOlMikKnA/dpkv4d9F3e4++GMR4+xu
 Ardgs1f6h+TFe96DKbuibeaxozKlfP1gH1/JtVTT09D2pdcjzv6334uCMa6qRH4TKTas8XnOE
 a2PasnvcZh4l4+gF7xJiX2LHnRUWHErMk5QPgtSeUx9zi0wjtGb8Hg5HSUczfYdGjNn/r+LoK
 vCAwv39WeZ6QtkwoqMJ7RQwq34dIIW84Ovd7rDPPjfwFLPEiP88vwMb9Vz2lHX9j+e2Hw+z4i
 kq70RNBftXHB5orSV0uynuXFDShRhQy77e4g2xtsHIrmkmRQ9F5VaEF2XVMPPd3yAE/hqHnCd
 0Z7+B0Gaj8IkfyADcno9HrtsIpmARQTaakGp7wFcAGLNox9fZQGjvwqvugjUvzw4RNlZP+Nx/
 1W1Hrrz2EALG8X17euunFRFcnPFhZZgFoo/gMm69/LHaMoJscXj+03QQJwDsFAyQo9lM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The structure already has 64-bit fields for the timestamps, but
calling get_seconds() may truncate and risk overflow on 32-bit
architectures.

This changes the dev-replace code to use ktime_get_real_seconds()
instead, which always returns 64-bit timestamps.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/btrfs/dev-replace.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index e2ba0419297a..1b30c38d05c9 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -465,7 +465,7 @@ int btrfs_dev_replace_start(struct btrfs_fs_info *fs_info,
 	 * go to the tgtdev as well (refer to btrfs_map_block()).
 	 */
 	dev_replace->replace_state = BTRFS_IOCTL_DEV_REPLACE_STATE_STARTED;
-	dev_replace->time_started = get_seconds();
+	dev_replace->time_started = ktime_get_real_seconds();
 	dev_replace->cursor_left = 0;
 	dev_replace->committed_cursor_left = 0;
 	dev_replace->cursor_left_last_write_of_item = 0;
@@ -618,7 +618,7 @@ static int btrfs_dev_replace_finishing(struct btrfs_fs_info *fs_info,
 			  : BTRFS_IOCTL_DEV_REPLACE_STATE_FINISHED;
 	dev_replace->tgtdev = NULL;
 	dev_replace->srcdev = NULL;
-	dev_replace->time_stopped = get_seconds();
+	dev_replace->time_stopped = ktime_get_real_seconds();
 	dev_replace->item_needs_writeback = 1;
 
 	/* replace old device with new one in mapping tree */
@@ -807,7 +807,7 @@ int btrfs_dev_replace_cancel(struct btrfs_fs_info *fs_info)
 		break;
 	}
 	dev_replace->replace_state = BTRFS_IOCTL_DEV_REPLACE_STATE_CANCELED;
-	dev_replace->time_stopped = get_seconds();
+	dev_replace->time_stopped = ktime_get_real_seconds();
 	dev_replace->item_needs_writeback = 1;
 	btrfs_dev_replace_write_unlock(dev_replace);
 	btrfs_scrub_cancel(fs_info);
@@ -848,7 +848,7 @@ void btrfs_dev_replace_suspend_for_unmount(struct btrfs_fs_info *fs_info)
 	case BTRFS_IOCTL_DEV_REPLACE_STATE_STARTED:
 		dev_replace->replace_state =
 			BTRFS_IOCTL_DEV_REPLACE_STATE_SUSPENDED;
-		dev_replace->time_stopped = get_seconds();
+		dev_replace->time_stopped = ktime_get_real_seconds();
 		dev_replace->item_needs_writeback = 1;
 		btrfs_info(fs_info, "suspending dev_replace for unmount");
 		break;
-- 
2.9.0

