Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755881AbeDTQFT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 12:05:19 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:45127 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755457AbeDTQFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 12:05:17 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Finn Thain <fthain@telegraphics.com.au>, Arnd Bergmann <arnd@arndb.de>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] scsi: ips: fix firmware timestamps for 32-bit
Date: Fri, 20 Apr 2018 18:04:40 +0200
Message-Id: <20180420160459.3621883-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:MUCQSYAc79uu76LXA1mvU1x+xkYn7wi8huVjx/hSqS/rV6WyNFT
 CnFCplbkjm9vWCurIm+8mX+KabC2QM2FCaIlNV+ifFu41RkJJCX3UBYH3houYpq+jWmyHXZ
 10r16qKS50SZ+JA9Sj0Ru2BZzwoJHyNSouo9BkHUxOclaBT4nNnQp8Y9Lt+545R575coRM5
 dj8/hOrXz3edBsOgQq0Yw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3oUz4y7CiZg=:W5ZQDGGWr1Sdmk0+oCf1il
 v+CBUwFAHOdVhE+YpqKjcHVsVPlzExl0/rMt05xWmmcc/qHAe2ympY/ina1DYXL2SnHX/CZzQ
 B97rHHOeDtNR+h7gUjqwkDD0mvSBYcm8RPnfoFhDT9iwFz3aKgoWiDXcsyVP6lsZkEbEcicLV
 baxeOW+uk7QHL6NjRFZKORbJZ2win1pAUgRpuCC/9r+RUW9HTHf5buPfDZ9dKKhfl6GaMioSh
 YlsEIzfREPQtm4L4dgG3yJNGNN0LTZn05/ezIrN/MR8ofTONvYKzCT8h8qDBR0JEfDHmiBcYP
 0b4su9dBjrD0BDtpWhEuLl+ln6pz7oyUIyHCvC+9djUTbadPYpcYKoG8cfQRPivCM+HyWVIq8
 bY39Xalgd2M1avfBZ4+7ls1zJeWIY620CZe8kWX0KBJkgl6XOwBMV2h7sM3y3Zj6AE3gjBNT1
 bPYMmm3LO19Y4eUplfdQLhLfQom8oLMqxJwSLIOH4x1c28L5y1oUWD22YjJSOQ2xpTYNYJtWq
 9YxnHFYFr3wrmNgxzmRRJMRdBC7oCECr5sf3r1RIq9EUTvtYQoxL0AAR8wOMRP5qJRbsCHkRZ
 K7OUUO3jWKxCTjMYWQVHUFQ4ZAJ0c8Dl1GIeNSuqiCnSU0igFl8lxb9C2zGz2EzSoT7Y2pzFg
 q7/U6ybmGy4z8P1oviRAramMoPEE8FNJJY70O3AK+doAwTw/PtzZsYtAaeD0CEZPrDpUmOBEs
 2XJ3/PX6MIeuIO2nUI95qR2MXFDahkbb2Aax7A==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

do_gettimeofday() is deprecated since it will stop working in 2038 on
32-bit platforms, leading to incorrect times passed to the firmware.
On 64-bit platforms the current code appears to be fine, as the
calculation passes an 8-bit century number into the firmware that can
represent times long in the future (possibly until 25599).

Using ktime_get_real_seconds() to get a 64-bit seconds value and
time64_to_tm() to convert it into the firmware format greatly simplifies
the ips timekeeping code, makes 32-bit and 64-bit behave the same way
here, and gets us closer to removing the deprecated interfaces.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: addressed review comments from Finn Thain:
  - rewrite changelog text
  - drop now-unused macros
  - fix incorrect century calculation
---
 drivers/scsi/ips.c | 78 +++++++++++-------------------------------------------
 drivers/scsi/ips.h | 11 +-------
 2 files changed, 17 insertions(+), 72 deletions(-)

diff --git a/drivers/scsi/ips.c b/drivers/scsi/ips.c
index a70f36a6d205..0e8a22c38c11 100644
--- a/drivers/scsi/ips.c
+++ b/drivers/scsi/ips.c
@@ -291,7 +291,7 @@ static void ips_freescb(ips_ha_t *, ips_scb_t *);
 static void ips_setup_funclist(ips_ha_t *);
 static void ips_statinit(ips_ha_t *);
 static void ips_statinit_memio(ips_ha_t *);
-static void ips_fix_ffdc_time(ips_ha_t *, ips_scb_t *, time_t);
+static void ips_fix_ffdc_time(ips_ha_t *, ips_scb_t *, time64_t);
 static void ips_ffdc_reset(ips_ha_t *, int);
 static void ips_ffdc_time(ips_ha_t *);
 static uint32_t ips_statupd_copperhead(ips_ha_t *);
@@ -985,10 +985,7 @@ static int __ips_eh_reset(struct scsi_cmnd *SC)
 
 	/* FFDC */
 	if (le32_to_cpu(ha->subsys->param[3]) & 0x300000) {
-		struct timeval tv;
-
-		do_gettimeofday(&tv);
-		ha->last_ffdc = tv.tv_sec;
+		ha->last_ffdc = ktime_get_real_seconds();
 		ha->reset_count++;
 		ips_ffdc_reset(ha, IPS_INTR_IORL);
 	}
@@ -2392,7 +2389,6 @@ static int
 ips_hainit(ips_ha_t * ha)
 {
 	int i;
-	struct timeval tv;
 
 	METHOD_TRACE("ips_hainit", 1);
 
@@ -2407,8 +2403,7 @@ ips_hainit(ips_ha_t * ha)
 
 	/* Send FFDC */
 	ha->reset_count = 1;
-	do_gettimeofday(&tv);
-	ha->last_ffdc = tv.tv_sec;
+	ha->last_ffdc = ktime_get_real_seconds();
 	ips_ffdc_reset(ha, IPS_INTR_IORL);
 
 	if (!ips_read_config(ha, IPS_INTR_IORL)) {
@@ -2548,12 +2543,9 @@ ips_next(ips_ha_t * ha, int intr)
 
 	if ((ha->subsys->param[3] & 0x300000)
 	    && (ha->scb_activelist.count == 0)) {
-		struct timeval tv;
-
-		do_gettimeofday(&tv);
-
-		if (tv.tv_sec - ha->last_ffdc > IPS_SECS_8HOURS) {
-			ha->last_ffdc = tv.tv_sec;
+		time64_t now = ktime_get_real_seconds();
+		if (now - ha->last_ffdc > IPS_SECS_8HOURS) {
+			ha->last_ffdc = now;
 			ips_ffdc_time(ha);
 		}
 	}
@@ -5988,59 +5980,21 @@ ips_ffdc_time(ips_ha_t * ha)
 /*                                                                          */
 /****************************************************************************/
 static void
-ips_fix_ffdc_time(ips_ha_t * ha, ips_scb_t * scb, time_t current_time)
+ips_fix_ffdc_time(ips_ha_t * ha, ips_scb_t * scb, time64_t current_time)
 {
-	long days;
-	long rem;
-	int i;
-	int year;
-	int yleap;
-	int year_lengths[2] = { IPS_DAYS_NORMAL_YEAR, IPS_DAYS_LEAP_YEAR };
-	int month_lengths[12][2] = { {31, 31},
-	{28, 29},
-	{31, 31},
-	{30, 30},
-	{31, 31},
-	{30, 30},
-	{31, 31},
-	{31, 31},
-	{30, 30},
-	{31, 31},
-	{30, 30},
-	{31, 31}
-	};
+	struct tm tm;
 
 	METHOD_TRACE("ips_fix_ffdc_time", 1);
 
-	days = current_time / IPS_SECS_DAY;
-	rem = current_time % IPS_SECS_DAY;
-
-	scb->cmd.ffdc.hour = (rem / IPS_SECS_HOUR);
-	rem = rem % IPS_SECS_HOUR;
-	scb->cmd.ffdc.minute = (rem / IPS_SECS_MIN);
-	scb->cmd.ffdc.second = (rem % IPS_SECS_MIN);
-
-	year = IPS_EPOCH_YEAR;
-	while (days < 0 || days >= year_lengths[yleap = IPS_IS_LEAP_YEAR(year)]) {
-		int newy;
-
-		newy = year + (days / IPS_DAYS_NORMAL_YEAR);
-		if (days < 0)
-			--newy;
-		days -= (newy - year) * IPS_DAYS_NORMAL_YEAR +
-		    IPS_NUM_LEAP_YEARS_THROUGH(newy - 1) -
-		    IPS_NUM_LEAP_YEARS_THROUGH(year - 1);
-		year = newy;
-	}
-
-	scb->cmd.ffdc.yearH = year / 100;
-	scb->cmd.ffdc.yearL = year % 100;
-
-	for (i = 0; days >= month_lengths[i][yleap]; ++i)
-		days -= month_lengths[i][yleap];
+	time64_to_tm(current_time, 0, &tm);
 
-	scb->cmd.ffdc.month = i + 1;
-	scb->cmd.ffdc.day = days + 1;
+	scb->cmd.ffdc.hour   = tm.tm_hour;
+	scb->cmd.ffdc.minute = tm.tm_min;
+	scb->cmd.ffdc.second = tm.tm_sec;
+	scb->cmd.ffdc.yearH  = (tm.tm_year + 1900) / 100;
+	scb->cmd.ffdc.yearL  = tm.tm_year % 100;
+	scb->cmd.ffdc.month  = tm.tm_mon + 1;
+	scb->cmd.ffdc.day    = tm.tm_mday;
 }
 
 /****************************************************************************
diff --git a/drivers/scsi/ips.h b/drivers/scsi/ips.h
index 366be3b2f9b4..db546171e97f 100644
--- a/drivers/scsi/ips.h
+++ b/drivers/scsi/ips.h
@@ -402,16 +402,7 @@
    #define IPS_BIOS_HEADER             0xC0
 
    /* time oriented stuff */
-   #define IPS_IS_LEAP_YEAR(y)           (((y % 4 == 0) && ((y % 100 != 0) || (y % 400 == 0))) ? 1 : 0)
-   #define IPS_NUM_LEAP_YEARS_THROUGH(y) ((y) / 4 - (y) / 100 + (y) / 400)
-
-   #define IPS_SECS_MIN                 60
-   #define IPS_SECS_HOUR                3600
    #define IPS_SECS_8HOURS              28800
-   #define IPS_SECS_DAY                 86400
-   #define IPS_DAYS_NORMAL_YEAR         365
-   #define IPS_DAYS_LEAP_YEAR           366
-   #define IPS_EPOCH_YEAR               1970
 
    /*
     * Scsi_Host Template
@@ -1054,7 +1045,7 @@ typedef struct ips_ha {
    uint8_t            active;
    int                ioctl_reset;        /* IOCTL Requested Reset Flag */
    uint16_t           reset_count;        /* number of resets           */
-   time_t             last_ffdc;          /* last time we sent ffdc info*/
+   time64_t           last_ffdc;          /* last time we sent ffdc info*/
    uint8_t            slot_num;           /* PCI Slot Number            */
    int                ioctl_len;          /* size of ioctl buffer       */
    dma_addr_t         ioctl_busaddr;      /* dma address of ioctl buffer*/
-- 
2.9.0
