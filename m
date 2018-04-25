Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754188AbeDYNZw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 09:25:52 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:52213 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753405AbeDYNW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 09:22:59 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v4 06/16] y2038: arm64: Extend sysvipc compat data structures
Date: Wed, 25 Apr 2018 15:22:32 +0200
Message-Id: <20180425132242.1500539-7-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180425132242.1500539-1-arnd@arndb.de>
References: <20180425132242.1500539-1-arnd@arndb.de>
X-Provags-ID: V03:K1:wgjVUuMhxC3paqxcKqToMhbRmvhgaUYuIAJ4ev5lWWQTKLC/F2U
 1Be2aBVaulk/gJatfg7RuTZOPzS63lH7EJWt7Ocd7Hw0quE/FOZ/Z5Y541v1mEyaavJTyk0
 2w2E7RE2TFcAU91TYr7Q/Jx1OPwe/RErBBjlB3q5EZzbyMVY5WIoKMFaGn3NVO565C1aQqm
 yBLkKRGMTtHWL9uAmddHg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KpeT+df1QwQ=:syNQ0sp9IUeW305c/MWtbQ
 /CWp9nH56+wR6oF0GVUJcPapl+G81PedvCbQVS7+3eQ5BF4MTKLCs2lpypiWWQ+SilUmtQ3YI
 6tvMrf1xTQT0xFGcMjg3MN+ELNW4Spa7fLvvVuyrp3Ks9zv3oc2GSQsksC4vdqR1GKA052ScM
 7bLgDWo48C6JakO54tLX2/T1wvUUvAiS6NxrH0L00PKE2EbItZq6t6YWZ1nBV31N5zyqXCG9E
 rikXXOmAd5Amq99S+91riEPXhDa7wP8RoQARQJVcPLU9bDU7t8XHbiOAQ7H304M23aDSCdN5A
 yzdz0kuBT1LAsf3mWEeU3bsn+Ih/+2cuCo4NFjw1sVpD3VP/QQGoxMIM6wpVBIRUeX+++xXWP
 HoZoUR0oj6kCj5gcctwd6RITMeVWQzkwMqh6k/Rs95dRDE7qHOjLtFKH/qKvh5fZjWe0xa568
 lVY6+Lxa0X0XhgGCSYrTM/rvc7c2ZZHu27mlYId4frBNk2ZschlN4iSpxTfFDE8k6z6Novs3S
 XprL+i8erYtLNlYvFIQOJK/Govw1o3XtlncaAimXy+o8oLoLyRfqM8TAONRr4kVuaYsPF7EGs
 ZwFSWAK1Rv5Sz3UJqc/HWrRpYYWULQwnmCMO4yEcMRVPSVxt36h02vqAHJAEJ3IziNMKoXmW/
 1LWDPcI/6/MGtk67xTf9yS8bG0HGERDhyREPYyyXG1RsgvDF0tnJsYNht82Wiz3ZHLEh7aJoZ
 33sFgoKTdMeIcsni3Ftbi4JBArewbabwovJkmQ==
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
