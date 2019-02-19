Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C22C10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 11:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C4AC2177E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 11:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbfBSLxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 06:53:42 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:52611 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728347AbfBSLxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 06:53:40 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.06712966|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.0600965-0.0412564-0.898647;FP=0|0|0|0|0|-1|-1|-1;HT=e01l07447;MF=liaoweixiong@allwinnertech.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.E-W9w0Q_1550577197;
Received: from PC-liaoweixiong.allwinnertech.com(mailfrom:liaoweixiong@allwinnertech.com fp:SMTPD_---.E-W9w0Q_1550577197)
          by smtp.aliyun-inc.com(10.147.40.233);
          Tue, 19 Feb 2019 19:53:34 +0800
From:   liaoweixiong <liaoweixiong@allwinnertech.com>
To:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        liaoweixiong <liaoweixiong@allwinnertech.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [RFC v9 5/5] Documentation: pstore/blk: create document for pstore_blk
Date:   Tue, 19 Feb 2019 19:52:50 +0800
Message-Id: <1550577170-18761-6-git-send-email-liaoweixiong@allwinnertech.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1550577170-18761-1-git-send-email-liaoweixiong@allwinnertech.com>
References: <1550577170-18761-1-git-send-email-liaoweixiong@allwinnertech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The document, at Documentation/admin-guide/pstore-block.rst,
tells user how to use pstore_blk and the attentions about panic
read/write

Signed-off-by: liaoweixiong <liaoweixiong@allwinnertech.com>
---
 Documentation/admin-guide/pstore-block.rst | 233 +++++++++++++++++++++++++++++
 MAINTAINERS                                |   1 +
 fs/pstore/Kconfig                          |   4 +
 3 files changed, 238 insertions(+)
 create mode 100644 Documentation/admin-guide/pstore-block.rst

diff --git a/Documentation/admin-guide/pstore-block.rst b/Documentation/admin-guide/pstore-block.rst
new file mode 100644
index 0000000..a828274
--- /dev/null
+++ b/Documentation/admin-guide/pstore-block.rst
@@ -0,0 +1,233 @@
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
+registers to pstore_blk. Note that, block driver should register to pstore_blk
+after block device has registered. Block driver transfers a structure
+``blkz_info`` which is defined in *linux/pstore_blk.h*.
+
+The following key members of ``struct blkz_info`` may be of interest to you.
+
+blkdev
+~~~~~~
+
+The block device to use. Most of the time, it is a partition of block device.
+It's ok to keep it as NULL if you passing ``read`` and ``write`` in blkz_info as
+``blkdev`` is used by blkz_default_general_read/write. If both of ``blkdev``,
+``read`` and ``write`` are NULL, no block device is effective and the data will
+be saved in ddr buffer.
+
+It accept the following variants:
+
+1. <hex_major><hex_minor> device number in hexadecimal represents itself no
+   leading 0x, for example b302.
+#. /dev/<disk_name> represents the device number of disk
+#. /dev/<disk_name><decimal> represents the device number of partition - device
+   number of disk plus the partition number
+#. /dev/<disk_name>p<decimal> - same as the above, that form is used when disk
+   name of partitioned disk ends on a digit.
+#. PARTUUID=00112233-4455-6677-8899-AABBCCDDEEFF representing the unique id of
+   a partition if the partition table provides it. The UUID may be either an
+   EFI/GPT UUID, or refer to an MSDOS partition using the format SSSSSSSS-PP,
+   where SSSSSSSS is a zero-filled hex representation of the 32-bit
+   "NT disk signature", and PP is a zero-filled hex representation of the
+   1-based partition number.
+#. PARTUUID=<UUID>/PARTNROFF=<int> to select a partition in relation to a
+   partition with a known unique id.
+#. <major>:<minor> major and minor number of the device separated by a colon.
+
+See more on section **read/write**.
+
+total_size
+~~~~~~~~~~
+
+The total size in bytes of block device used for pstore_blk. It **MUST** be less
+than or equal to size of block device if ``blkdev`` valid. It **MUST** be a
+multiple of 4096. If ``total_size`` is zero with ``blkdev``, ``total_size`` will be
+set to equal to size of ``blkdev``.
+
+The block device area is divided into many chunks, and each event writes a chunk
+of information.
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
+/sys/fs/pstore/pmsg-pstore-blk-0.
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
+but set ``blkdev``.
+
+These general APIs are used all the time expect panic. The ``read`` API is
+usually used to recover data from block device, and the ``write`` API is usually
+to flush new data and erase to block device.
+
+Pstore_blk will temporarily hold all new data before block device is ready. If
+you ignore both of ``read/write`` and ``blkdev``, the old data will be lost.
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
+        [... get block device information ...]
+        XXXX_info.blkdev = <...>;
+        XXXX_info.total_size = <...>;
+
+        [...]
+        return blkz_register(&XXXX_info);
+ }
+
+There are multiple ways by which you can get block device information.
+
+A. Use the module parameters and kernel cmdline.
+B. Use Device Tree bindings.
+C. Use Kconfig.
+D. Use Driver Feature.
+   For example, traverse all MTD device by ``register_mtd_user``, and get the
+   matching name MTD partition.
+
+NOTE that, all of above are done by block driver rather then pstore_blk. You can
+get sample on blkoops.
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
+        Panic: Total 16 times
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
+files is ``dmesg-pstore-blk-[N]`` for dmesg(oops|panic) and
+``pmsg-pstore-blk-0`` for pmsg, where N is the record number. To delete a stored
+record from block device, simply unlink the respective pstore file. The
+timestamp of the dump file records the trigger time.
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
+   If you need memory, just allocate while the block driver is initialing rather
+   than waiting until the panic.
+#. Must be polled, **NOT** interrupt driven.
+   No task schedule any more. The block driver should delay to ensure the write
+   succeeds, but NOT sleep.
+#. Can **NOT** take any lock.
+   There is no other task, no any share resource, you are safely to break all
+   locks.
+#. Just use cpu to transfer.
+   Do not use DMA to transfer unless you are sure that DMA will not keep lock.
+#. Operate register directly.
+   Try not to use linux kernel resources. Do io map while initialing rather than
+   waiting until the panic.
+#. Reset your block device and controller if necessary.
+   If you are not sure the state of you block device and controller when panic,
+   you are safely to stop and reset them.
diff --git a/MAINTAINERS b/MAINTAINERS
index 44647a8..4dd95d3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12317,6 +12317,7 @@ F:	include/linux/pstore*
 F:	drivers/firmware/efi/efi-pstore.c
 F:	drivers/acpi/apei/erst.c
 F:	Documentation/admin-guide/ramoops.rst
+F:	Documentation/admin-guide/pstore-block.rst
 F:	Documentation/devicetree/bindings/reserved-memory/ramoops.txt
 F:	Documentation/devicetree/bindings/pstore-block/
 K:	\b(pstore|ramoops|blkoops)
diff --git a/fs/pstore/Kconfig b/fs/pstore/Kconfig
index 50d196e..0247832 100644
--- a/fs/pstore/Kconfig
+++ b/fs/pstore/Kconfig
@@ -161,6 +161,10 @@ config PSTORE_BLK
 	  This enables panic and oops message to be logged to a block dev
 	  where it can be read back at some later point.
 
+	  For more information, see Documentation/admin-guide/pstore-block.rst.
+
+	  If unsure, say N.
+
 config PSTORE_BLKOOPS
 	tristate "pstore block with oops logger"
 	depends on PSTORE_BLK
-- 
1.9.1

