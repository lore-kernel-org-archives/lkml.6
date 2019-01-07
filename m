Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED2AC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B275205C9
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:02:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfAGMCI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:02:08 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:44654 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726655AbfAGMB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:01:57 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436282|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e01l07391;MF=liaoweixiong@allwinnertech.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.DibxlYK_1546862495;
Received: from PC-liaoweixiong.allwinnertech.com(mailfrom:liaoweixiong@allwinnertech.com fp:SMTPD_---.DibxlYK_1546862495)
          by smtp.aliyun-inc.com(10.147.40.200);
          Mon, 07 Jan 2019 20:01:52 +0800
From:   liaoweixiong <liaoweixiong@allwinnertech.com>
To:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        liaoweixiong <liaoweixiong@allwinnertech.com>
Subject: [RFC v5 4/4] Documentation: pstore/blk: create document for pstore_blk
Date:   Mon,  7 Jan 2019 20:01:02 +0800
Message-Id: <1546862462-19640-5-git-send-email-liaoweixiong@allwinnertech.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1546862462-19640-1-git-send-email-liaoweixiong@allwinnertech.com>
References: <1546862462-19640-1-git-send-email-liaoweixiong@allwinnertech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The documemt, at Documentation/admin-guide/pstore-block.rst,
tells user how to use pstore_blk and the attentions about panic
read/write

Signed-off-by: liaoweixiong <liaoweixiong@allwinnertech.com>
---
 Documentation/admin-guide/pstore-block.rst | 226 +++++++++++++++++++++++++++++
 MAINTAINERS                                |   1 +
 fs/pstore/Kconfig                          |   4 +
 3 files changed, 231 insertions(+)
 create mode 100644 Documentation/admin-guide/pstore-block.rst

diff --git a/Documentation/admin-guide/pstore-block.rst b/Documentation/admin-guide/pstore-block.rst
new file mode 100644
index 0000000..2fc9fd8
--- /dev/null
+++ b/Documentation/admin-guide/pstore-block.rst
@@ -0,0 +1,226 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Pstore block oops/panic logger
+==============================
+
+Introduction
+------------
+
+Pstore block (pstore_blk) is an oops/panic logger that write its logs to block
+device before the system crashes. Pstore_blk needs block device driver
+registering a partition path of the block device, like /dev/mmcblk0p7 for mmc
+driver, and read/write APIs for this partition when on panic.
+
+Pstore block concepts
+---------------------
+
+Pstore block begins at function ``blkz_register``, by which block driver
+registers to pstore_blk. Recomemd that, block driver should register to
+pstore_blk after block device is ready. Block driver transfers a structure
+``blkz_info`` which is defined in *linux/pstore_blk.h*.
+
+The following key members of ``struct blkz_info`` may be of interest to you.
+
+part_path
+~~~~~~~~~
+
+The path of partition used for pstore_blk. It may be ``/dev/mmcblk[N]p[M]`` for
+mmc, and ``/dev/mtdblock[N]`` for mtd device.
+
+The ``part_path`` is not necessarily if you self-defined general read/write APIs
+on ``blkz_info``. In other words, the ``part_path`` is only used (by function
+blkz_sample_read/write) when general read/write APIs are not defined.
+
+See more on section **read/write**.
+
+part_size
+~~~~~~~~~
+
+The total size in bytes of partition used for pstore_blk. This member **MUST**
+be effective and a multiple of 4096. It is recommended to 1M or larger for block
+device.
+
+The block device area is divided into many chunks, and each event writes
+a chunk of information.
+
+dmesg_size
+~~~~~~~~~~
+
+The chunk size in bytes for dmesg(oops/panic). It **MUST** be a multiple of
+SECTOR_SIZE (Most of the time, the SECTOR_SIZE is 512). If you don't need dmesg,
+you are safely to set it to 0.
+
+NOTE that, the remaining space, except ``pmsg_size`` and others, belongs to
+dmesg. It means that there are multiple chunks for dmesg.
+
+Psotre_blk will log to dmesg chunks one by one, and always overwrite the oldest
+chunk if no free chunk.
+
+pmsg_size
+~~~~~~~~~
+
+The chunk size in bytes for pmsg. It **MUST** be a multiple of SECTOR_SIZE (Most
+of the time, the SECTOR_SIZE is 512). If you don't need pmsg, you are safely to
+set it to 0.
+
+There is only one chunk for pmsg.
+
+Pmsg is a user space accessible pstore object. Writes to */dev/pmsg0* are
+appended to the chunk. On reboot the contents are available in
+/sys/fs/pstore/pmsg-blkoops-0.
+
+dump_oops
+~~~~~~~~~
+
+Dumping both oopses and panics can be done by setting 1 in the ``dump_oops``
+member while setting 0 in that variable dumps only the panics.
+
+read/write
+~~~~~~~~~~
+
+They are general ``read/write`` APIs. It is safely and recommended to ignore it,
+but set ``part_path``.
+
+These general APIs are used all the time expect panic. The ``read`` API is
+usually used to recover data from block device, and the ``write`` API is usually
+to flush new data and erase to block device.
+
+Pstore_blk will temporarily hold all new data before block device is ready. If
+you ignore both of ``read/write`` and ``part_path``, the old data will not be
+recovered and the new data will not be flushed until panic, using panic APIs.
+If you don't have panic APIs neither, all the data will be dropped when reboot.
+
+NOTE that, the general APIs must check whether the block device is ready if
+self-defined.
+
+panic_read/panic_write
+~~~~~~~~~~~~~~~~~~~~~~
+
+They are ``read/write`` APIs for panic. They are likely to general
+``read/write`` but will be used only when on panic.
+
+The attentions for panic read/write see section
+**Attentions in panic read/write APIs**.
+
+Register to pstore block
+------------------------
+
+Block device driver call ``blkz_register`` to register to Psotre_blk.
+For example:
+
+.. code-block:: c
+
+ #include <linux/pstore_blk.h>
+ [...]
+
+ static ssize_t XXXX_panic_read(char *buf, size bytes, loff_t pos)
+ {
+    [...]
+ }
+
+ static ssize_t XXXX_panic_write(const char *buf, size_t bytes, loff_t pos)
+ {
+        [...]
+ }
+
+ struct blkz_info XXXX_info = {
+        .onwer = THIS_MODULE,
+        .name = <...>,
+        .dmesg_size = <...>,
+        .pmsg_size = <...>,
+        .dump_oops = true,
+        .panic_read = XXXX_panic_read,
+        .panic_write = XXXX_panic_write,
+ };
+
+ static int __init XXXX_init(void)
+ {
+        [... get partition information ...]
+        XXXX_info.part_path = <...>;
+        XXXX_info.part_size = <...>;
+
+        [...]
+        return blkz_register(&XXXX_info);
+ }
+
+There are multiple ways by which you can get partition information.
+
+A. Use the module parameters and kernel cmdline.
+B. Use Device Tree bindings.
+C. Use Kconfig.
+D. Use Driver Feature.
+   For example, traverse all MTD device by ``register_mtd_user``, and get the
+   matching name MTD partition.
+
+NOTE that, all of above are done by block driver rather then pstore_blk.
+
+The attentions for panic read/write see section
+**Attentions in panic read/write APIs**.
+
+Compression and header
+----------------------
+
+Block device is large enough, it is not necessary to compress dmesg data.
+Actually, we recommend not compress. Because pstore_blk will insert some
+information into the first line of dmesg data if no compression.
+For example::
+
+        blkoops: Panic: Total 16 times
+
+It means that it's the 16th times panic log since burning.
+Sometimes, the oops|panic counter since burning is very important for embedded
+device to judge whether the system is stable.
+
+The follow line is insert by pstore filesystem.
+For example::
+
+        Oops#2 Part1
+
+It means that it's the 2nd times oops log on last booting.
+
+Reading the data
+----------------
+
+The dump data can be read from the pstore filesystem. The format for these
+files is ``dmesg-blkoops-[N]`` for dmesg(oops|panic) and ``pmsg-blkoops-0`` for
+pmsg, where N is the record number. To delete a stored record from block device,
+simply unlink the respective pstore file. The timestamp of the dump file records
+the trigger time.
+
+Attentions in panic read/write APIs
+-----------------------------------
+
+If on panic, the kernel is not going to be running for much longer. The tasks
+will not be scheduled and the most kernel resources will be out of service. It
+looks like a single-threaded program running on a single-core computer.
+
+The following points need special attention for panic read/write APIs:
+
+1. Can **NOT** allocate any memory.
+
+   If you need memory, just allocate while the block driver is initialing rather
+   than waiting until the panic.
+
+2. Must be polled, **NOT** interrupt driven.
+
+   No task schedule any more. The block driver should delay to ensure the write
+   succeeds, but NOT sleep.
+
+3. Can **NOT** take any lock.
+
+   There is no other task, no any share resource, you are safely to break all
+   locks.
+
+4. Just use cpu to transfer.
+
+   Do not use DMA to transfer unless you are sure that DMA will not keep lock.
+
+5. Operate register directly.
+
+   Try not to use linux kernel resources. Do io map while initialing rather than
+   waiting until the panic.
+
+6. Reset your block device and controller if necessary.
+
+   If you are not sure the state of you block device and controller when panic,
+   you are safely to stop and reset them.
diff --git a/MAINTAINERS b/MAINTAINERS
index 0abecc5..ebf9c71 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12054,6 +12054,7 @@ F:	include/linux/pstore*
 F:	drivers/firmware/efi/efi-pstore.c
 F:	drivers/acpi/apei/erst.c
 F:	Documentation/admin-guide/ramoops.rst
+F:	Documentation/admin-guide/pstore-block.rst
 F:	Documentation/devicetree/bindings/reserved-memory/ramoops.txt
 K:	\b(pstore|ramoops)
 
diff --git a/fs/pstore/Kconfig b/fs/pstore/Kconfig
index 18b1fe6..5c5273c 100644
--- a/fs/pstore/Kconfig
+++ b/fs/pstore/Kconfig
@@ -160,6 +160,10 @@ config PSTORE_BLK
 	  This enables panic and oops message to be logged to a block dev
 	  where it can be read back at some later point.
 
+	  For more information, see Documentation/admin-guide/pstore-block.rst.
+
+	  If unsure, say N.
+
 config PSTORE_BLKBUF
 	tristate "pstore block buffer sample"
 	depends on PSTORE_BLK
-- 
1.9.1

