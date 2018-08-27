Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70ACFC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13123208DA
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:57:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13123208DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbeH0XpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 19:45:05 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:34991 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbeH0XpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 19:45:05 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue103 [212.227.15.145]) with ESMTPA (Nemesis) id
 0MVasZ-1gR3Ln3AMR-00YzBc; Mon, 27 Aug 2018 21:56:52 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-media@vger.kernel.org
Cc:     y2038@lists.linaro.org, awalls@md.metrocast.net,
        hans.verkuil@cisco.com, mchehab@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] media: dvb: fix compat ioctl tramslation
Date:   Mon, 27 Aug 2018 21:56:21 +0200
Message-Id: <20180827195649.4170969-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:VS+pZMGgNlfsnNJAwaoMK+Q2vIFcxSIuYCX4pv+sU1RdZJ6em6n
 iTK/Z9W6Gd+Yz5jJv9bp00+JPno33PoGTuQ6VmMr9QxDkHHMzJkiel2BYDnqoqkbxxAp5FV
 9GMNNo18bTq7PE8PumixwNOw4S6BXVlKeRIheJcb5aETZDfU2txkOX8U1ZQA6aABzDXBZ2I
 uHQIPz1nboHlO0NjnkOdw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:aGshKQyTFzM=:D8910VkZ+tDRT60GdWtwFp
 G23mWCF+8LIHz3FI1l0euo1BfXjMHgxe/gP7dm20LbJXoAqHPM7Uj+SuRkPvkrpTcx17d0W7C
 LEuHNLwG0wm8layj9YCCf0HFhYGgyUX22bSck6Zmds9pZJSl18KAcAId09IcHQTztYPYqMoI6
 e7oD5f68JZz7YOnUKbD5FahS4CH2Knpa61OQaHjBuTY29EDQszwg9IewQN1VCTo/xeE3lnbsC
 E8ce5JeThwvkb6YF9GntdDnyRLlKvzF/CFGLIDH6A6pPFI0f/iayDwUGpx8dVfNV2VzmvBAET
 hE6w65Nkv199ZQftbdtvpOZ+rr5AU8jqXCueeRFwS+tY78VddDfFzLFAdSlN23xSUHmhysv6X
 148Ngw+ZM31QbHTeg7BJIFG0p/EQO5OyhNdoPrUWW9rszJJypaUybheO4V2DXBYBfevV3MJIX
 HR5A/nfQP/8vnA1aBZSj25E7IB73UfpKxrpd64LCsuofx4/YxDREzHcx/Df6J1iZmLKTCoXfl
 PGAmQ+LHlAOmjK11caqi26mBIDJKT+dq8rKeT+PY7s5x052zAnQQNxhpkBWbEL93rfbDsu/+c
 HR0ilXfvxHDBzvidoY22O3Pd30NdaKEmqkXDwP61HUjZ5Z8Wq75NWoxfIWLmo4+rCmSeTiU6c
 vcb/IoxDJ1fp577ralgAWxArNS2+9dtJvkX5V6rOCxngqfC6zd7SBiMEsCAGbqadfBak=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The VIDEO_GET_EVENT and VIDEO_STILLPICTURE was added back in 2005 but
it never worked because the command number is wrong.

Using the right command number means we have a better chance of them
actually doing the right thing, though clearly nobody has ever tried
it successfully.

I noticed these while auditing the remaining users of compat_time_t
for y2038 bugs. This one is fine in that regard, it just never did
anything.

Fixes: 6e87abd0b8cb ("[DVB]: Add compat ioctl handling.")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/compat_ioctl.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index a9b00942e87d..0c46ce224590 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -141,6 +141,7 @@ struct compat_video_event {
 		unsigned int frame_rate;
 	} u;
 };
+#define VIDEO_GET_EVENT32 _IOR('o', 28, struct compat_video_event)
 
 static int do_video_get_event(struct file *file,
 		unsigned int cmd, struct compat_video_event __user *up)
@@ -152,7 +153,7 @@ static int do_video_get_event(struct file *file,
 	if (kevent == NULL)
 		return -EFAULT;
 
-	err = do_ioctl(file, cmd, (unsigned long)kevent);
+	err = do_ioctl(file, VIDEO_GET_EVENT, (unsigned long)kevent);
 	if (!err) {
 		err  = convert_in_user(&kevent->type, &up->type);
 		err |= convert_in_user(&kevent->timestamp, &up->timestamp);
@@ -171,6 +172,7 @@ struct compat_video_still_picture {
         compat_uptr_t iFrame;
         int32_t size;
 };
+#define VIDEO_STILLPICTURE32 _IOW('o', 30, struct compat_video_still_picture)
 
 static int do_video_stillpicture(struct file *file,
 		unsigned int cmd, struct compat_video_still_picture __user *up)
@@ -193,7 +195,7 @@ static int do_video_stillpicture(struct file *file,
 	if (err)
 		return -EFAULT;
 
-	err = do_ioctl(file, cmd, (unsigned long) up_native);
+	err = do_ioctl(file, VIDEO_STILLPICTURE, (unsigned long) up_native);
 
 	return err;
 }
@@ -1305,9 +1307,9 @@ static long do_ioctl_trans(unsigned int cmd,
 		return rtc_ioctl(file, cmd, argp);
 
 	/* dvb */
-	case VIDEO_GET_EVENT:
+	case VIDEO_GET_EVENT32:
 		return do_video_get_event(file, cmd, argp);
-	case VIDEO_STILLPICTURE:
+	case VIDEO_STILLPICTURE32:
 		return do_video_stillpicture(file, cmd, argp);
 	}
 
-- 
2.18.0

