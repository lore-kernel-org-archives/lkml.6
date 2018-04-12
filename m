Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753183AbeDLVeF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 17:34:05 -0400
Received: from mail-it0-f74.google.com ([209.85.214.74]:57863 "EHLO
        mail-it0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751661AbeDLVeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 17:34:01 -0400
X-Google-Smtp-Source: AIpwx48GOZwS8T7wRGLNz13k8GgHsMePtX/jhhkR2eC9v5G4Yzam0yLP2CEEkEBE2emTf5WOemSws11sC+uS
MIME-Version: 1.0
Date: Thu, 12 Apr 2018 14:33:42 -0700
Message-Id: <20180412213342.138010-1-hansens@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
Subject: [PATCH] Documentation/i2c: sync docs with current state of i2c-tools.
From: Sam Hansen <hansens@google.com>
To: linux-i2c@vger.kernel.org, hansens@google.com, wsa@the-dreams.de,
        corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Sam Hansen <hansens@google.com>, wsa@the-dreams.de, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, Documentation/i2c/dev-interface describes the use of i2c_smbus_*
helper routines as static inlined functions provided by linux/i2c-dev.h.  Work
has been done to refactor the linux/i2c-dev.h file in the i2c-tools project
out into its own library.  As a result, these docs have become stale.

This patch corrects the discrepancy and directs the reader to the i2c-tools
project for more information.  Additionally, some trailing-whitespace cleanups
were made.

Signed-off-by: Sam Hansen <hansens@google.com>
---
 Documentation/i2c/dev-interface | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/Documentation/i2c/dev-interface b/Documentation/i2c/dev-interface
index d04e6e4964ee..5323588fe99d 100644
--- a/Documentation/i2c/dev-interface
+++ b/Documentation/i2c/dev-interface
@@ -9,8 +9,8 @@ i2c adapters present on your system at a given time. i2cdetect is part of
 the i2c-tools package.
 
 I2C device files are character device files with major device number 89
-and a minor device number corresponding to the number assigned as 
-explained above. They should be called "i2c-%d" (i2c-0, i2c-1, ..., 
+and a minor device number corresponding to the number assigned as
+explained above. They should be called "i2c-%d" (i2c-0, i2c-1, ...,
 i2c-10, ...). All 256 minor device numbers are reserved for i2c.
 
 
@@ -23,11 +23,6 @@ First, you need to include these two headers:
   #include <linux/i2c-dev.h>
   #include <i2c/smbus.h>
 
-(Please note that there are two files named "i2c-dev.h" out there. One is
-distributed with the Linux kernel and the other one is included in the
-source tree of i2c-tools. They used to be different in content but since 2012
-they're identical. You should use "linux/i2c-dev.h").
-
 Now, you have to decide which adapter you want to access. You should
 inspect /sys/class/i2c-dev/ or run "i2cdetect -l" to decide this.
 Adapter numbers are assigned somewhat dynamically, so you can not
@@ -38,7 +33,7 @@ Next thing, open the device file, as follows:
   int file;
   int adapter_nr = 2; /* probably dynamically determined */
   char filename[20];
-  
+
   snprintf(filename, 19, "/dev/i2c-%d", adapter_nr);
   file = open(filename, O_RDWR);
   if (file < 0) {
@@ -72,7 +67,7 @@ the device supports them. Both are illustrated below.
     /* res contains the read word */
   }
 
-  /* Using I2C Write, equivalent of 
+  /* Using I2C Write, equivalent of
      i2c_smbus_write_word_data(file, reg, 0x6543) */
   buf[0] = reg;
   buf[1] = 0x43;
@@ -140,14 +135,14 @@ ioctl(file, I2C_RDWR, struct i2c_rdwr_ioctl_data *msgset)
   set in each message, overriding the values set with the above ioctl's.
 
 ioctl(file, I2C_SMBUS, struct i2c_smbus_ioctl_data *args)
-  Not meant to be called  directly; instead, use the access functions
-  below.
+  If possible, use the provided i2c_smbus_* methods described below in favor
+  of issuing direct ioctls.
 
 You can do plain i2c transactions by using read(2) and write(2) calls.
 You do not need to pass the address byte; instead, set it through
 ioctl I2C_SLAVE before you try to access the device.
 
-You can do SMBus level transactions (see documentation file smbus-protocol 
+You can do SMBus level transactions (see documentation file smbus-protocol
 for details) through the following functions:
   __s32 i2c_smbus_write_quick(int file, __u8 value);
   __s32 i2c_smbus_read_byte(int file);
@@ -158,7 +153,7 @@ for details) through the following functions:
   __s32 i2c_smbus_write_word_data(int file, __u8 command, __u16 value);
   __s32 i2c_smbus_process_call(int file, __u8 command, __u16 value);
   __s32 i2c_smbus_read_block_data(int file, __u8 command, __u8 *values);
-  __s32 i2c_smbus_write_block_data(int file, __u8 command, __u8 length, 
+  __s32 i2c_smbus_write_block_data(int file, __u8 command, __u8 length,
                                    __u8 *values);
 All these transactions return -1 on failure; you can read errno to see
 what happened. The 'write' transactions return 0 on success; the
@@ -166,10 +161,9 @@ what happened. The 'write' transactions return 0 on success; the
 returns the number of values read. The block buffers need not be longer
 than 32 bytes.
 
-The above functions are all inline functions, that resolve to calls to
-the i2c_smbus_access function, that on its turn calls a specific ioctl
-with the data in a specific format. Read the source code if you
-want to know what happens behind the screens.
+The above functions are made available by linking against the libi2c library,
+which is provided by the i2c-tools project.  See:
+https://git.kernel.org/pub/scm/utils/i2c-tools/i2c-tools.git/.
 
 
 Implementation details
-- 
2.17.0.484.g0c8726318c-goog
