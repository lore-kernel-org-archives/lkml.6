Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B095DC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62E3D2083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:23:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62E3D2083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730311AbeGZNkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 09:40:04 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9722 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729479AbeGZNkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 09:40:04 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7E206B6EF4CA6;
        Thu, 26 Jul 2018 20:23:18 +0800 (CST)
Received: from szvp000100637.huawei.com (10.162.55.131) by smtp.huawei.com
 (10.3.19.208) with Microsoft SMTP Server (TLS) id 14.3.382.0; Thu, 26 Jul
 2018 20:23:11 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, <yuchao0@huawei.com>,
        <miaoxie@huawei.com>, <weidu.du@huawei.com>, <hsiangkao@aol.com>,
        <chao@kernel.org>, Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH 00/25] staging: erofs: introduce erofs file system
Date:   Thu, 26 Jul 2018 20:21:43 +0800
Message-ID: <1532607728-103372-1-git-send-email-gaoxiang25@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1527764767-22190-1-git-send-email-gaoxiang25@huawei.com>
References: <1527764767-22190-1-git-send-email-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.162.55.131]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is actually the 2nd patchset of erofs file system,
the original patchset can be found at

Link: https://marc.info/?l=linux-fsdevel&m=152776480425624

In order to keep up with the mainline linux-kernel changes and
improve it in a more active and timely manner, we put forword
this upstream proposal for linux-staging.

EROFS file system is a read-only file system with compression
support designed for certain devices (especially embeded
devices) with very limited physical memory and lots of memory
consumers, such as Android devices. It aimes to provide
a complete compression solution for such devices focuing
on high performance and little extra memory overhead.

It is perferred to select larger compressed cluster sizes
(generally >= 128k) for traditional compression file systems.
It reads and decompresses a large compressed cluster at once,
which has a good-looking random read number when memory
is sufficient because all historial decompressed data
is expected to be cached in memory. However, it also
induces destructive effects when such devices have no enough
spare memory for caching and decompression.

EROFS file system acts in some different way. It uses
fixed-sized compressed size rather than fixed-sized input
size, namely VLE (variable-length extent) compression,
which has at least three adventages:

 1) all data read from block device at once can be
    utilized, and read amplification can be easier to
    estimate and control;
 2) generally, it has a better compression ratio than
    fixed-sized input compression approaches configured
    with the same size;
 3) aggressively optimized paths such as partial page
    read can be implemented to gain better performance
    for page-unaligned read (unimplemented yet, in TODO list).

As can be seen, VLE compression does a great job in small
compressed cluster sizes, which is of course suitable for
devices with limited memory. In this patchset, an in-place
decompresion is also introduced to minimize extra memory usage.


Apart from compression, EROFS also has the following features
available and some limits:
 o page-sized block support (currently, and no buffer-head);
 o 32-bit block address (16TB for 4KB block);
 o selectable v1 (32 bytes) / v2 (64 bytes) inode;
 o 32-bit / 64-bit file size;
 o 64-bit node number for addressing inodes;
 o 64-bit s and 32-bit ns timestamps;
 o inline data support;
 o inline and shared xattr support;
 o metadata and data can be mixed (optional);
 o special inode support;
 o posix acl support.


The file system is still actively WIP, see _TODO_ for more details.

Any comments are welcome. :)


Change log from the original patchset
=====================================

 o Introduce a new erofs decompression subsystem, which has
   better sequencial read than the original patchset, and
   its random read remains almost the same (note that erofs
   still only fully support page-sized compressed cluster as
   the compression unit, however some additional code enabling
   larger compressed clustersizes is also added in this version);

 o Avoid LINUX_VERSION macros for linux-staging upstream

 o several bugfix and cleanup


Short log
=========

Chao Yu (3):
  staging: erofs: support special inode
  staging: erofs: introduce error injection infrastructure
  staging: erofs: support tracepoint

Gao Xiang (22):
  staging: erofs: add on-disk layout
  staging: erofs: add erofs in-memory stuffs
  staging: erofs: add super block operations
  staging: erofs: add raw address_space operations
  staging: erofs: add inode operations
  staging: erofs: add directory operations
  staging: erofs: add namei functions
  staging: erofs: update Kconfig and Makefile
  staging: erofs: introduce xattr & acl support
  staging: erofs: <linux/tagptr.h>: introduce tagged pointer
  staging: erofs: introduce pagevec for unzip subsystem
  staging: erofs: add erofs_map_blocks_iter
  staging: erofs: add erofs_allocpage
  staging: erofs: globalize prepare_bio and __submit_bio
  staging: erofs: introduce a customized LZ4 decompression
  staging: erofs: add a generic z_erofs VLE decompressor
  staging: erofs: introduce superblock registration
  staging: erofs: introduce erofs shrinker
  staging: erofs: introduce workstation for decompression
  staging: erofs: introduce VLE decompression support
  staging: erofs: introduce cached decompression
  staging: erofs: add a TODO and update MAINTAINERS for staging

 MAINTAINERS                                        |    7 +
 drivers/staging/Kconfig                            |    2 +
 drivers/staging/Makefile                           |    1 +
 drivers/staging/erofs/Kconfig                      |  141 ++
 drivers/staging/erofs/Makefile                     |   13 +
 drivers/staging/erofs/TODO                         |   45 +
 drivers/staging/erofs/data.c                       |  385 +++++
 drivers/staging/erofs/dir.c                        |  145 ++
 drivers/staging/erofs/erofs_fs.h                   |  266 ++++
 drivers/staging/erofs/include/linux/tagptr.h       |  110 ++
 drivers/staging/erofs/include/trace/events/erofs.h |  240 +++
 drivers/staging/erofs/inode.c                      |  283 ++++
 drivers/staging/erofs/internal.h                   |  556 +++++++
 drivers/staging/erofs/lz4defs.h                    |  227 +++
 drivers/staging/erofs/namei.c                      |  251 +++
 drivers/staging/erofs/super.c                      |  649 ++++++++
 drivers/staging/erofs/unzip_lz4.c                  |  251 +++
 drivers/staging/erofs/unzip_pagevec.h              |  172 +++
 drivers/staging/erofs/unzip_vle.c                  | 1634 ++++++++++++++++++++
 drivers/staging/erofs/unzip_vle.h                  |  239 +++
 drivers/staging/erofs/unzip_vle_lz4.c              |  209 +++
 drivers/staging/erofs/utils.c                      |  270 ++++
 drivers/staging/erofs/xattr.c                      |  579 +++++++
 drivers/staging/erofs/xattr.h                      |   93 ++
 24 files changed, 6768 insertions(+)
 create mode 100644 drivers/staging/erofs/Kconfig
 create mode 100644 drivers/staging/erofs/Makefile
 create mode 100644 drivers/staging/erofs/TODO
 create mode 100644 drivers/staging/erofs/data.c
 create mode 100644 drivers/staging/erofs/dir.c
 create mode 100644 drivers/staging/erofs/erofs_fs.h
 create mode 100644 drivers/staging/erofs/include/linux/tagptr.h
 create mode 100644 drivers/staging/erofs/include/trace/events/erofs.h
 create mode 100644 drivers/staging/erofs/inode.c
 create mode 100644 drivers/staging/erofs/internal.h
 create mode 100644 drivers/staging/erofs/lz4defs.h
 create mode 100644 drivers/staging/erofs/namei.c
 create mode 100644 drivers/staging/erofs/super.c
 create mode 100644 drivers/staging/erofs/unzip_lz4.c
 create mode 100644 drivers/staging/erofs/unzip_pagevec.h
 create mode 100644 drivers/staging/erofs/unzip_vle.c
 create mode 100644 drivers/staging/erofs/unzip_vle.h
 create mode 100644 drivers/staging/erofs/unzip_vle_lz4.c
 create mode 100644 drivers/staging/erofs/utils.c
 create mode 100644 drivers/staging/erofs/xattr.c
 create mode 100644 drivers/staging/erofs/xattr.h

Thanks,
Gao Xiang

-- 
1.9.1

