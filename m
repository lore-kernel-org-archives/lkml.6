Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753082AbeDLOXa (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 10:23:30 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:59225 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752907AbeDLOUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 10:20:34 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 05/13] y2038: arm64: extend sysvipc compat data structures
Date: Thu, 12 Apr 2018 16:20:16 +0200
Message-Id: <20180412142024.853892-6-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180412142024.853892-1-arnd@arndb.de>
References: <20180412142024.853892-1-arnd@arndb.de>
X-Provags-ID: V03:K1:/d4c/PFsTZDb3h7IbX0qLHp5RsKyc7pWLUjoyvrsKe9+pQltb7p
 tmhnV5njPoYS3uPzIyyOHXs8rpK+0Ex5Z3TRpGe3gCST5S2eRWd6H79Wf33xMakhyrE0fQy
 WEpWENskJwgcITpD/3pv/xXCME9ucmdK6Ky/YDFsJj9/Bdeuotl2A0aEH8l24PHzfiO0v5A
 chozliEoZq6ughykbmXJQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:P6toYeI/wAQ=:P6DidJEqFprQWPAqhJC5ac
 G+jNxVYpChEyOubbP15cv/mpsevmGXQw9DFYoN0TlPvUVsrE6XtqNYLL+ggD+IJH2WKIbDtC9
 B0bHv9N/yB9LcmNrKxptAKUwGCLo8fIIjdpByv7HaSfFVJrYnxIbsobWyJt5gl6zXJZb7QJ51
 pEaGhI4L/V/AXytmUyVf7/1+4YxxMpMOz3sohwnJ/HNI4svXj+dBgkh/1qtzOgvzEj2bEwx7a
 Yexr+Qrv11EyI8ynQTerod4YzapkqC/c15j64cmkc1Yc3nxYU0jxnZXcVZF+6EuO3HNMP7tw4
 xSDnFEWsaIOEtLJJ88cxreR+MJKatasA545SSBrVqwVXgMRISTRfPELpjPi+RYH6nedRth2NP
 Qwk4vC8tPXVoBPwVVtz/36FfHvEMcZ6GY13M0bCGMggrvQAzkkSsq1EybiRO4YUXbjbz+4lUr
 QFMWn5GJE7WmAubqgxuISX7DtgR5REDX/dXuiW9ccH9AbH9jRecRTnWnP/7z0Bv3n523PtPS6
 2DJ1U3LiaJ2xl03EnImYZrz3vRRXKrTitZl4YO3H81PtZL+bVwISZEYzuYR8aYvQil1cdk66c
 YKYj3JuVrPrjmtakQ+YKXwzd40C9V+EyY6egwFjY2IMJ63c1BVeFRQ3AaWBkYZBL2fH+gHWI0
 hf98ya/sLGyIkcPvF3TiX5M/rvj/Pu2dacD/8btwYun9MYWI4HozmDlul1iMk+/MTr0ahh4Zo
 fse4RsgjNSETBp1HUffOukLSR6CUi+UQn9mo8w==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both 32-bit amd 64-bit ARM use the asm-generic header files for their
sysvipc data structures, so no special care is needed to make those
work beyond y2038, with the one exception of compat mode: Since there
is no asm-generic definition of the compat mode IPC structures, ARM64
provides its own copy, and we make those match the changes in the native
asm-generic header files.

There is sufficient padding in these data structures to extend all
timestamps to 64 bit, but on big-endian ARM kernels, the padding
is in the wrong place, so the C library has to ensure it reassembles
a 64-bit time_t correctly.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/include/asm/compat.h | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/include/asm/compat.h b/arch/arm64/include/asm/compat.h
index 0030f79808b3..1a037b94eba1 100644
--- a/arch/arm64/include/asm/compat.h
+++ b/arch/arm64/include/asm/compat.h
@@ -181,10 +181,10 @@ struct compat_ipc64_perm {
 
 struct compat_semid64_ds {
 	struct compat_ipc64_perm sem_perm;
-	compat_time_t  sem_otime;
-	compat_ulong_t __unused1;
-	compat_time_t  sem_ctime;
-	compat_ulong_t __unused2;
+	compat_ulong_t sem_otime;
+	compat_ulong_t sem_otime_high;
+	compat_ulong_t sem_ctime;
+	compat_ulong_t sem_ctime_high;
 	compat_ulong_t sem_nsems;
 	compat_ulong_t __unused3;
 	compat_ulong_t __unused4;
@@ -192,12 +192,12 @@ struct compat_semid64_ds {
 
 struct compat_msqid64_ds {
 	struct compat_ipc64_perm msg_perm;
-	compat_time_t  msg_stime;
-	compat_ulong_t __unused1;
-	compat_time_t  msg_rtime;
-	compat_ulong_t __unused2;
-	compat_time_t  msg_ctime;
-	compat_ulong_t __unused3;
+	compat_ulong_t msg_stime;
+	compat_ulong_t msg_stime_high;
+	compat_ulong_t msg_rtime;
+	compat_ulong_t msg_rtime_high;
+	compat_ulong_t msg_ctime;
+	compat_ulong_t msg_ctime_high;
 	compat_ulong_t msg_cbytes;
 	compat_ulong_t msg_qnum;
 	compat_ulong_t msg_qbytes;
@@ -210,12 +210,12 @@ struct compat_msqid64_ds {
 struct compat_shmid64_ds {
 	struct compat_ipc64_perm shm_perm;
 	compat_size_t  shm_segsz;
-	compat_time_t  shm_atime;
-	compat_ulong_t __unused1;
-	compat_time_t  shm_dtime;
-	compat_ulong_t __unused2;
-	compat_time_t  shm_ctime;
-	compat_ulong_t __unused3;
+	compat_ulong_t shm_atime;
+	compat_ulong_t shm_atime_high;
+	compat_ulong_t shm_dtime;
+	compat_ulong_t shm_dtime_high;
+	compat_ulong_t shm_ctime;
+	compat_ulong_t shm_ctime_high;
 	compat_pid_t   shm_cpid;
 	compat_pid_t   shm_lpid;
 	compat_ulong_t shm_nattch;
-- 
2.9.0
