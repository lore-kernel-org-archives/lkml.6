Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932923AbeBLWkp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 17:40:45 -0500
Received: from casper.infradead.org ([85.118.1.10]:45758 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932885AbeBLWkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 17:40:40 -0500
To: LKML <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] fs/signalfd: fix build error for BUS_MCEERR_AR
Message-ID: <8a85cfae-0c26-e50c-9b26-582802a7f3eb@infradead.org>
Date: Mon, 12 Feb 2018 13:18:38 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix build error in fs/signalfd.c by using same method that is used in
kernel/signal.c: separate blocks for different signal si_code values.

./fs/signalfd.c: error: 'BUS_MCEERR_AR' undeclared (first use in this function)

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
---
 fs/signalfd.c |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

Applies to mainline 4.16-rc1.

--- linux-next-20180212.orig/fs/signalfd.c
+++ linux-next-20180212/fs/signalfd.c
@@ -118,13 +118,22 @@ static int signalfd_copyinfo(struct sign
 		err |= __put_user(kinfo->si_trapno, &uinfo->ssi_trapno);
 #endif
 #ifdef BUS_MCEERR_AO
-		/* 
+		/*
 		 * Other callers might not initialize the si_lsb field,
 		 * so check explicitly for the right codes here.
 		 */
 		if (kinfo->si_signo == SIGBUS &&
-		    (kinfo->si_code == BUS_MCEERR_AR ||
-		     kinfo->si_code == BUS_MCEERR_AO))
+		     kinfo->si_code == BUS_MCEERR_AO)
+			err |= __put_user((short) kinfo->si_addr_lsb,
+					  &uinfo->ssi_addr_lsb);
+#endif
+#ifdef BUS_MCEERR_AR
+		/*
+		 * Other callers might not initialize the si_lsb field,
+		 * so check explicitly for the right codes here.
+		 */
+		if (kinfo->si_signo == SIGBUS &&
+		    kinfo->si_code == BUS_MCEERR_AR)
 			err |= __put_user((short) kinfo->si_addr_lsb,
 					  &uinfo->ssi_addr_lsb);
 #endif
