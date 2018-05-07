Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752006AbeEGH4W (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 03:56:22 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:41357 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751378AbeEGH4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 03:56:20 -0400
X-Google-Smtp-Source: AB8JxZojotv2VF064ndZh4g2pXqDkCHHwK3xi8IsuUfFWVgntgfSixBFRsiVVzPs2igOtb1Su3l7uA==
Message-Id: <20180507075606.692875939@gmail.com>
User-Agent: quilt/0.65
Date: Mon, 07 May 2018 10:52:14 +0300
From: Cyrill Gorcunov <gorcunov@gmail.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Jonathan de Boyne Pollard
        <J.deBoynePollard-newsgroups@NTLWorld.COM>,
        Andrey Vagin <avagin@openvz.org>,
        Andrew Morton <akpm@linuxfoundation.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Michal Hocko <mhocko@kernel.org>, Cyrill Gorcunov <gorcunov@gmail.com>
Subject: [rfc linux-next 1/3] [RFC] prctl: prctl_set_mm -- Move PR_SET_MM_MAP_SIZE out of prctl_set_mm_map
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=prctl-move-PR_SET_MM_MAP_SIZE
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is a preparatory patch so next we will make prctl_set_mm_map
to accept struct prctl_mm_map as an argument and the only
thing prctl_set_mm_map will do is to setup new memory map,
not handling any other operations.

CC: Jonathan de Boyne Pollard <J.deBoynePollard-newsgroups@NTLWorld.COM>
CC: Andrey Vagin <avagin@openvz.org>
CC: Andrew Morton <akpm@linuxfoundation.org>
CC: Michael Kerrisk <mtk.manpages@gmail.com>
CC: Yang Shi <yang.shi@linux.alibaba.com>
CC: Michal Hocko <mhocko@kernel.org>
Signed-off-by: Cyrill Gorcunov <gorcunov@gmail.com>
---
 kernel/sys.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

Index: linux-ml.git/kernel/sys.c
===================================================================
--- linux-ml.git.orig/kernel/sys.c
+++ linux-ml.git/kernel/sys.c
@@ -1979,10 +1979,6 @@ static int prctl_set_mm_map(int opt, con
 	BUILD_BUG_ON(sizeof(user_auxv) != sizeof(mm->saved_auxv));
 	BUILD_BUG_ON(sizeof(struct prctl_mm_map) > 256);
 
-	if (opt == PR_SET_MM_MAP_SIZE)
-		return put_user((unsigned int)sizeof(prctl_map),
-				(unsigned int __user *)addr);
-
 	if (data_size != sizeof(prctl_map))
 		return -EINVAL;
 
@@ -2063,7 +2059,11 @@ static int prctl_set_mm(int opt, unsigne
 			unsigned long arg4, unsigned long arg5)
 {
 #ifdef CONFIG_CHECKPOINT_RESTORE
-	if (opt == PR_SET_MM_MAP || opt == PR_SET_MM_MAP_SIZE)
+	if (opt == PR_SET_MM_MAP_SIZE)
+		return put_user((unsigned int)sizeof(struct prctl_mm_map),
+				(unsigned int __user *)addr);
+
+	if (opt == PR_SET_MM_MAP)
 		return prctl_set_mm_map(opt, (const void __user *)addr, arg4);
 #endif
 
