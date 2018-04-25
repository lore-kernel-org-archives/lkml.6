Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754279AbeDYNXQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 09:23:16 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:50043 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754164AbeDYNXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 09:23:02 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v4 16/16] y2038: ipc: Redirect ipc(SEMTIMEDOP, ...) to compat_ksys_semtimedop
Date: Wed, 25 Apr 2018 15:22:42 +0200
Message-Id: <20180425132242.1500539-17-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180425132242.1500539-1-arnd@arndb.de>
References: <20180425132242.1500539-1-arnd@arndb.de>
X-Provags-ID: V03:K1:LDLhkduSZObZwgT5eCRs8HvrmF3o3noQ6N/6vUJD9EddNFII23S
 5xi0UupBvUU/V0rVfzGb0Q2v3PGVMtosUM7YCi394isIDlXDwz9vD29o+d/IE86L9x9X8GD
 bwIcUKBAwQ4CTViH2VVbIZWogroYP+3V5AE4ai7i2WZPW/gVlSEJTvKnc6HHZnAn0km7GWu
 lk7uVEAD4Bq4cn0YSM7rg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TUA867JTD8A=:dHfik+fFiWdwYR4IDD/73y
 Byxo6j4Q7XHo6rDc2eBHQSh+UgTLLeSgmPeyTXpCJ9xNL5rnDtUYm3dV4gC2AQcEa+mEEhznj
 DDTHwsl7kLxqewTq57pSMQHOGL8xy1TdQXFuyGqZ7956yRnClBqthThJIJxYq0oNlngIkDp7h
 jgRdsrvi4C7ARkD0chFh9wyj35Kn/BBa/xNdyCUbXDUvLX/XekJVB1FKElzZ2hhBm4EtkaA44
 VsvOiDmf4bQe9Jq6t6inJ8ZIDq831QIUATarf4Jjj/3PQUoxyWK+4mkHzld5nZeGS8WITWHgT
 rnrysDDZWsVvwYn8JHn1cOd6GITraAl+q3dqHpYz6K2Ih9EA0fZMmg7cMeTGgqVLZquVq7oF4
 TzKW9ibf+ZEpWPMuuGkbzCaJMT/zJ5Oj1VUUgkOr9RJVW/EeSW+6InuJCDNtWRpLvk1Q6n1TZ
 b+upBdeVmeJlC4kYlKyGmRjLqTgeSOpDRUXedqYV2oqJCP86yVjMSznOjIUG556L9NiNcYtoK
 C+pFioy/6uags2rfQ8ceKIzHr/t6kskGXfFEDmQkDnYpjiI+5df23SatvuOmbw8+KniMn75Hs
 UEfGlcU8iGy8OAAnw1upfCC8Z+dIsvXaTpvuBtOxafm6eat/Q7tqfRvVUQ9mYOhHQPSX8wBkr
 m7FsuIewv3O3VIt1csgJ85sbHvrNNLxzR5AvF/i32n7w/TRIAqGdwrD8qXNM+FS286j8Hodmn
 mqWj2Cb/XXfMowl2zSsVoVZv7NOzk5vZpsH/qw==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

32-bit architectures implementing 64BIT_TIME and COMPAT_32BIT_TIME
need to have the traditional semtimedop() behavior with 32-bit timestamps
for sys_ipc() by calling compat_ksys_semtimedop(), while those that
are not yet converted need to keep using ksys_semtimedop() like
64-bit architectures do.

Note that I chose to not implement a new SEMTIMEDOP64 function that
corresponds to the new sys_semtimedop() with 64-bit timeouts. The reason
here is that sys_ipc() should no longer be used for new system calls,
and libc should just call the semtimedop syscall directly.

One open question remain to whether we want to completely avoid the
sys_ipc() system call for architectures that do not yet have all the
individual calls as they get converted to 64-bit time_t. Doing that
would require adding several extra system calls on m68k, mips, powerpc,
s390, sh, sparc, and x86-32.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 ipc/syscall.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/ipc/syscall.c b/ipc/syscall.c
index 77a883ef2eca..65d405f1ba0c 100644
--- a/ipc/syscall.c
+++ b/ipc/syscall.c
@@ -30,9 +30,14 @@ SYSCALL_DEFINE6(ipc, unsigned int, call, int, first, unsigned long, second,
 		return ksys_semtimedop(first, (struct sembuf __user *)ptr,
 				       second, NULL);
 	case SEMTIMEDOP:
-		return ksys_semtimedop(first, (struct sembuf __user *)ptr,
-				       second,
-				       (const struct timespec __user *)fifth);
+		if (IS_ENABLED(CONFIG_64BIT) || !IS_ENABLED(CONFIG_64BIT_TIME))
+			return ksys_semtimedop(first, ptr, second,
+			        (const struct __kernel_timespec __user *)fifth);
+		else if (IS_ENABLED(CONFIG_COMPAT_32BIT_TIME))
+			return compat_ksys_semtimedop(first, ptr, second,
+			        (const struct compat_timespec __user *)fifth);
+		else
+			return -ENOSYS;
 
 	case SEMGET:
 		return ksys_semget(first, second, third);
@@ -130,6 +135,8 @@ COMPAT_SYSCALL_DEFINE6(ipc, u32, call, int, first, int, second,
 		/* struct sembuf is the same on 32 and 64bit :)) */
 		return ksys_semtimedop(first, compat_ptr(ptr), second, NULL);
 	case SEMTIMEDOP:
+		if (!IS_ENABLED(CONFIG_COMPAT_32BIT_TIME))
+			return -ENOSYS;
 		return compat_ksys_semtimedop(first, compat_ptr(ptr), second,
 						compat_ptr(fifth));
 	case SEMGET:
-- 
2.9.0
