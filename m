Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 386E0C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D225320880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:12:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D225320880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbeILURq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 16:17:46 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:55975 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbeILURq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 16:17:46 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1M1YxX-1fyB9H24jb-0032LN; Wed, 12 Sep 2018 17:12:48 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/17] compat_ioctl: remove keyboard ioctl translation
Date:   Wed, 12 Sep 2018 17:08:55 +0200
Message-Id: <20180912151134.436719-4-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180912151134.436719-1-arnd@arndb.de>
References: <20180912150142.157913-1-arnd@arndb.de>
 <20180912151134.436719-1-arnd@arndb.de>
X-Provags-ID: V03:K1:kSpQWv6RxqA2EjJv0aHUx8NsS4Ezk1aP9GB29Sy1g+G/CTDNnG/
 TFNb0ROBXdWprSKhNZaYMyDNN8NKUKZeszbXvs2kcKH6YCpQ8BUDiHvdkHkkZcXjbueSAEq
 qrJZS/oQZjsznOPbKyrPsHj6KGHi88LtcnNpZJQCWA0gfHaJWUMOEygBd5V3ivc+UY3O+F4
 RuUUdlWfsX7VXEUuIZFjA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1ufQwC4YEPE=:5VAbshcSLIDZawHaVWr9on
 K5kooPLhVb1Z3H4MqJf9HkQj+DDm3Dbwf9aRBOL8bTskPkj+cw4yxodneeYg9L+G2g9WwpuA3
 OBHDOEnsbn23OMyvpZyjAeVQYI1JB5sR3B5rX7E/8GzU51YB0rK8fCR4d5Uig+CTyehI4pBKf
 Ktv4cipUbjx5M3YyzPcE6vbosPdXqSYjzDv3EjBSQ5+4QEHSAgooBxSPh2S8eLtluBYVXhskD
 qiDFadyyWXafKPTIZTxDrvUhlGt5NKkmOFibUVZmnDwzfOinS6TNfTbnBbu1RnJSoIHIWsaFS
 8EbOeRh0Heoj+azq7mhmNekEwvbbkPuCgAvYdXrcTuckjzil8a5RJ5G2NyZRxashYqydRphPB
 vXybaM4TzbQ+XKRAdHC+AD9fyASeEoSoo3YUpBtj8vxNyA+MID4I4LjfhMbC/6EAGK0uXJIGj
 BBlHz0yRb3kEKvmuh44VJkDLFkQHlh9zPO599yJe1E6XvtYOVdn47atKoIQN0Yo33pz8xl0JA
 ng/mYPmAToooEMqUWOuWKebNpSuYdTYZZH0KJsq4ujMdYQBCtId4ImeZMrp3C7V4JPn0yb+bb
 Oc64Zw+ng4RseQcFzb4nc8inP9b8iSMStKCjyIzQ+YAIuDZpEwoNIKiSyMF3xcA5GOCypLJap
 AhWVQ/2c21rT0df/osGTLNzTh+z8I6e+OyY8BwI9oWQGZ6413a8AkjBFwQty3zvJDtxg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The KD* family of ioctls is implemented in two drivers:
drivers/tty/vt and drivers/s390/char/tty3270.c. Both of them
have compat handlers for all their ioctl commands, so translation
in fs/compat_ioctl.c is never used.

Commit fb07a5f857ac ("compat_ioctl: remove all VT ioctl handling")
removed the compat handling for all the other VT ioctls back in
2009, but it seems I missed the keyboard ones back then.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/compat_ioctl.c | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index 1b47a60da455..e245deb684b5 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -687,23 +687,6 @@ COMPATIBLE_IOCTL(FIGETBSZ)
 COMPATIBLE_IOCTL(FIFREEZE)
 COMPATIBLE_IOCTL(FITHAW)
 COMPATIBLE_IOCTL(FITRIM)
-COMPATIBLE_IOCTL(KDGETKEYCODE)
-COMPATIBLE_IOCTL(KDSETKEYCODE)
-COMPATIBLE_IOCTL(KDGKBTYPE)
-COMPATIBLE_IOCTL(KDGETMODE)
-COMPATIBLE_IOCTL(KDGKBMODE)
-COMPATIBLE_IOCTL(KDGKBMETA)
-COMPATIBLE_IOCTL(KDGKBENT)
-COMPATIBLE_IOCTL(KDSKBENT)
-COMPATIBLE_IOCTL(KDGKBSENT)
-COMPATIBLE_IOCTL(KDSKBSENT)
-COMPATIBLE_IOCTL(KDGKBDIACR)
-COMPATIBLE_IOCTL(KDSKBDIACR)
-COMPATIBLE_IOCTL(KDGKBDIACRUC)
-COMPATIBLE_IOCTL(KDSKBDIACRUC)
-COMPATIBLE_IOCTL(KDKBDREP)
-COMPATIBLE_IOCTL(KDGKBLED)
-COMPATIBLE_IOCTL(KDGETLED)
 #ifdef CONFIG_BLOCK
 /* Big S */
 COMPATIBLE_IOCTL(SCSI_IOCTL_GET_IDLUN)
@@ -1210,15 +1193,6 @@ static long do_ioctl_trans(unsigned int cmd,
 	case HOT_ADD_DISK:
 	case SET_DISK_FAULTY:
 	case SET_BITMAP_FILE:
-	/* Big K */
-	case KDSIGACCEPT:
-	case KIOCSOUND:
-	case KDMKTONE:
-	case KDSETMODE:
-	case KDSKBMODE:
-	case KDSKBMETA:
-	case KDSKBLED:
-	case KDSETLED:
 		return vfs_ioctl(file, cmd, arg);
 	}
 
-- 
2.18.0

