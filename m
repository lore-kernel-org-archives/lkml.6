Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC12FC433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 14:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77AD32086B
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 14:28:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77AD32086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbeIHTOk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 15:14:40 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:60997 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbeIHTOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 15:14:40 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MtO4E-1fja7C2jHC-00us4C; Sat, 08 Sep 2018 16:28:40 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     viro@zeniv.linux.org.uk
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/11] compat_ioctl: remove keyboard ioctl translation
Date:   Sat,  8 Sep 2018 16:28:07 +0200
Message-Id: <20180908142837.2819693-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:Gz8Xz6xl87kUTIzpUST9fXtlPaHTobfeRYO3+pf3eMsd4Ck/d85
 5ItkPxs+5a6/WChTlqUCiSCyfh8vMMaaq+vt6J427MFBvlfz0IcKjuuhr+YBq9csEJaf3t/
 Lardw6pIIsDI9Qdb5nAariLPcws01/eOgBt/zzPwatnj+3m+UI+f4NLmAuV8P8t77MbGBiM
 6ROJgVhNbg/T5UMmWoUfQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:27Pqvg3AFhU=:uNkLBf8C+9w11YLvPCfrPf
 15h2unUxaZPoAptUKCID34yK2FtnaUcaJrIQ6Tm5mmmxvXAN26Y8rYJTkc8bQhZeB3kHPMxGx
 +zcZk/Ke02N+StrWkraTHvoPFCHqSCgsEadsVGl0QAP6BJ7EeD7wv5cet0AYnVfoFM4NxjGC9
 M2LktmpLkjKpnhNzAJLO4fIEeKsmzWYwOBVtWanqZH1qGhmPR2IxLsA0c7ANcLmEEc3t9GOTl
 A6dKJvpm1B3KWp6UukS5dVkq+Qogeg1BMuPAN+FNnQyFu2GjRkrQEvgGc7HGMbH5djP0nKO2x
 9OREChJ84Dki6n78f9DLxuJ5qXJorRgnwfoTDSWdrHWdj2daFbs+kucIwG+B6oM5svcSB/2bq
 R4Jpk8qnnkyVzmEwoaJGC2mk+jjdycNs19+L4cGG204VmmiR0igUkGoRNbebrFTC9Zi1SFwKQ
 IjDS0rVubh1GkN3QctzogqsEXjT4+TSCbBUPY2w9ele9Jt8JHEY1mb1j0cZdGVrRb0yJE4tKL
 NeVsE2NB/ufXW4Z+fhPK5xSXAT+sh/bVGAhTy4skxaAi7xsCOwnGJogD7lLmHwvtcg6pkbbts
 ApNKoo6C1QRfzWg2FktyXpaB7BiqmaZ/lxrPo2lUgByhDqdCE5HAClW7nFAy5QKRPuHTSVzsY
 mQFckiMUPW+JIEDLpNlItot0oEnFAR34+V7WoB4ih+kOgEmhoI78deNqhshI/FhrK0oI=
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
index 9237076bdcf5..4c2f83a386a2 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -546,23 +546,6 @@ COMPATIBLE_IOCTL(FIGETBSZ)
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
@@ -974,15 +957,6 @@ static long do_ioctl_trans(unsigned int cmd,
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

