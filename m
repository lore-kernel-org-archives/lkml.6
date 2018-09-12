Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26608C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2CDA20880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:16:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2CDA20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbeILUVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 16:21:02 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:42934 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbeILUVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 16:21:01 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1M9Frj-1fx6CD1rYF-006LvN; Wed, 12 Sep 2018 17:16:02 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 17/17] compat_ioctl: remove last RAID handling code
Date:   Wed, 12 Sep 2018 17:13:09 +0200
Message-Id: <20180912151422.571531-8-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180912151422.571531-1-arnd@arndb.de>
References: <20180912150142.157913-1-arnd@arndb.de>
 <20180912151422.571531-1-arnd@arndb.de>
X-Provags-ID: V03:K1:AEEe1t3XhQfn/PQqO62RI0+kY7j5vpcJ3TN3YcTv288fi+qTxVD
 RRd4E4dIqFwdIfbM6RjGn3fbXFwX4QSF3kYQBJLjoDCi+k0qoZ6oXMjWZYOKtInOOF8zkKO
 reTGg+W17RvDVzi/voPLsKcWcIt4af5WcBYIyvnRznwtWFD4q5Gs+eXaFiQdrDP1Exmk/6T
 A42Z6DwrHGUU2Kd6Am3Og==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vBWb9bHl638=:DaDTBk/cWOEqEVkl/RSpuP
 GYzwHB0l7BzOHlVJkuXexfQOPRXCSSDuZ3JgBkianOrwW89RvcEggBCjFUg7gBqPFAAUNcHz/
 gGEWG3odD1xt8BZgBhFqJF3BaLl9/pEPAYENRid587vekPDzQINehFTwJWmlVlNY0vjFcgZby
 dKUWvkwlVyVSII0rbt4q3+8zrhSi+IzmGpbCAJX+ZAkPHgw1nJFZud6npLsMPnXJH2ef8tkfY
 yMpW/v6rCFKW8lvxDzgjyBhTJ0MTudXvyFfJyx+wpCZz5tQCeEGbn3OqrtCIMGG/A6RdxGw9d
 8PWJi+qNEWQLP++++Lb9sA2MXuY/Y9FsSTvbhZ4SU6v9SRr1+a15S6jeiixTuqmvXsMJnN56Q
 p1OsgiHy9lQvp63SYTDzGgndKoppfMgCuQKWrX7J9icDGdfQK+aKtoGQCrv/+TwScWQoGnPYQ
 XjX6pCt7+psZyQaPABmT0wjcOq6UrPx7uYbVMY/tToI2S+rFDefw7mlnFNmUmxtIJ77z0dhzt
 PVFEE/NMWD1hJZYg73bwd3YCeibGpKNjeXvQneCppz07hm5EGqhOxs9488Ziahsz+LP0qQUM1
 9lcrXok35gqXheQYqIOB7eBPg9b9yl41D1ApAyvLs7vu23U6GPL9yqD/atDbO2m1/auC7mAO+
 oYurw+ELfj+TgtPc8M+7F6QHeziX1NocQtZ3ncoRJIRhYTr7mQlBli1RnQiNcoRxK24A=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit aa98aa31987a ("md: move compat_ioctl handling into md.c")
already removed the COMPATIBLE_IOCTL() table entries and added
a complete implementation, but a few lines got left behind and
should also be removed here.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/compat_ioctl.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index 79ad7c3afd70..37862bf91f44 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -911,11 +911,6 @@ static long do_ioctl_trans(unsigned int cmd,
 	case TCSBRKP:
 	case TIOCMIWAIT:
 	case TIOCSCTTY:
-	/* RAID */
-	case HOT_REMOVE_DISK:
-	case HOT_ADD_DISK:
-	case SET_DISK_FAULTY:
-	case SET_BITMAP_FILE:
 		return vfs_ioctl(file, cmd, arg);
 	}
 
-- 
2.18.0

