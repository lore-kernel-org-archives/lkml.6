Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED27C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FC5820660
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546977623;
	bh=EIDgnGdx8vLpSJmFSEUUqjtOQUetMmSTQkGz4Md8TS8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bRUu1nQj7qA5uOy77n8mtU3dtx1a/StORKOdrmuGsMY/CNOz7zuxpe8skG70Z7tx7
	 wYSjngf+wgljzxmacr0g+qPQWe6cwrJ8Gdj6/k6E3qkIfmUyoQxz4Zbl9G7xAWV9vm
	 hIzyR9KD94KY7B0eNIxLVubucf0dUXwwlEicNipE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733092AbfAHUAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 15:00:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:57300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733081AbfAHUAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 15:00:18 -0500
Received: from quaco.ghostprotocols.net (unknown [177.135.9.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 260B02183F;
        Tue,  8 Jan 2019 20:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546977617;
        bh=EIDgnGdx8vLpSJmFSEUUqjtOQUetMmSTQkGz4Md8TS8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=br4xhy68H+mqLdPGfroXREQzf4Vdu7rHU9yr6tm/qQivCwhSjwgxDqW/nmLPfXP1Y
         HKHV2E5WMznmRR3LLmNDF5oqL8+sawPJ6ffdXTGab1bBPXba7qBWXk43koV9XM/2dH
         fR73ftDXtF4ctkdQPgthAM657xcyjNi6wwdfPnA4=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 16/16] tools include uapi: Sync linux/vhost.h with the kernel sources
Date:   Tue,  8 Jan 2019 16:59:10 -0300
Message-Id: <20190108195910.17726-17-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190108195910.17726-1-acme@kernel.org>
References: <20190108195910.17726-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To get the changes in:

  4b86713236e4 ("vhost: split structs into a separate header file")

Silencing this perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/vhost.h' differs from latest version at 'include/uapi/linux/vhost.h'
  diff -u tools/include/uapi/linux/vhost.h include/uapi/linux/vhost.h

Those didn't touch things used in tools, i.e. the following continues
working:

  $ tools/perf/trace/beauty/vhost_virtio_ioctl.sh
  static const char *vhost_virtio_ioctl_cmds[] = {
          [0x00] = "SET_FEATURES",
          [0x01] = "SET_OWNER",
          [0x02] = "RESET_OWNER",
          [0x03] = "SET_MEM_TABLE",
          [0x04] = "SET_LOG_BASE",
          [0x07] = "SET_LOG_FD",
          [0x10] = "SET_VRING_NUM",
          [0x11] = "SET_VRING_ADDR",
          [0x12] = "SET_VRING_BASE",
          [0x13] = "SET_VRING_ENDIAN",
          [0x14] = "GET_VRING_ENDIAN",
          [0x20] = "SET_VRING_KICK",
          [0x21] = "SET_VRING_CALL",
          [0x22] = "SET_VRING_ERR",
          [0x23] = "SET_VRING_BUSYLOOP_TIMEOUT",
          [0x24] = "GET_VRING_BUSYLOOP_TIMEOUT",
          [0x25] = "SET_BACKEND_FEATURES",
          [0x30] = "NET_SET_BACKEND",
          [0x40] = "SCSI_SET_ENDPOINT",
          [0x41] = "SCSI_CLEAR_ENDPOINT",
          [0x42] = "SCSI_GET_ABI_VERSION",
          [0x43] = "SCSI_SET_EVENTS_MISSED",
          [0x44] = "SCSI_GET_EVENTS_MISSED",
          [0x60] = "VSOCK_SET_GUEST_CID",
          [0x61] = "VSOCK_SET_RUNNING",
  };
  static const char *vhost_virtio_ioctl_read_cmds[] = {
          [0x00] = "GET_FEATURES",
          [0x12] = "GET_VRING_BASE",
          [0x26] = "GET_BACKEND_FEATURES",
  };
  $

At some point in the eBPFication of perf, using something like:

	# perf trace -e ioctl(cmd=VHOST_VRING*)

Will setup a BPF filter right at the raw_syscalls:sys_enter tracepoint,
i.e. filtering at the origin.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-g28usrt7l59lwq3wuh8vzbig@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/vhost.h | 113 +------------------------------
 1 file changed, 2 insertions(+), 111 deletions(-)

diff --git a/tools/include/uapi/linux/vhost.h b/tools/include/uapi/linux/vhost.h
index 84c3de89696a..40d028eed645 100644
--- a/tools/include/uapi/linux/vhost.h
+++ b/tools/include/uapi/linux/vhost.h
@@ -11,94 +11,9 @@
  * device configuration.
  */
 
+#include <linux/vhost_types.h>
 #include <linux/types.h>
-#include <linux/compiler.h>
 #include <linux/ioctl.h>
-#include <linux/virtio_config.h>
-#include <linux/virtio_ring.h>
-
-struct vhost_vring_state {
-	unsigned int index;
-	unsigned int num;
-};
-
-struct vhost_vring_file {
-	unsigned int index;
-	int fd; /* Pass -1 to unbind from file. */
-
-};
-
-struct vhost_vring_addr {
-	unsigned int index;
-	/* Option flags. */
-	unsigned int flags;
-	/* Flag values: */
-	/* Whether log address is valid. If set enables logging. */
-#define VHOST_VRING_F_LOG 0
-
-	/* Start of array of descriptors (virtually contiguous) */
-	__u64 desc_user_addr;
-	/* Used structure address. Must be 32 bit aligned */
-	__u64 used_user_addr;
-	/* Available structure address. Must be 16 bit aligned */
-	__u64 avail_user_addr;
-	/* Logging support. */
-	/* Log writes to used structure, at offset calculated from specified
-	 * address. Address must be 32 bit aligned. */
-	__u64 log_guest_addr;
-};
-
-/* no alignment requirement */
-struct vhost_iotlb_msg {
-	__u64 iova;
-	__u64 size;
-	__u64 uaddr;
-#define VHOST_ACCESS_RO      0x1
-#define VHOST_ACCESS_WO      0x2
-#define VHOST_ACCESS_RW      0x3
-	__u8 perm;
-#define VHOST_IOTLB_MISS           1
-#define VHOST_IOTLB_UPDATE         2
-#define VHOST_IOTLB_INVALIDATE     3
-#define VHOST_IOTLB_ACCESS_FAIL    4
-	__u8 type;
-};
-
-#define VHOST_IOTLB_MSG 0x1
-#define VHOST_IOTLB_MSG_V2 0x2
-
-struct vhost_msg {
-	int type;
-	union {
-		struct vhost_iotlb_msg iotlb;
-		__u8 padding[64];
-	};
-};
-
-struct vhost_msg_v2 {
-	__u32 type;
-	__u32 reserved;
-	union {
-		struct vhost_iotlb_msg iotlb;
-		__u8 padding[64];
-	};
-};
-
-struct vhost_memory_region {
-	__u64 guest_phys_addr;
-	__u64 memory_size; /* bytes */
-	__u64 userspace_addr;
-	__u64 flags_padding; /* No flags are currently specified. */
-};
-
-/* All region addresses and sizes must be 4K aligned. */
-#define VHOST_PAGE_SIZE 0x1000
-
-struct vhost_memory {
-	__u32 nregions;
-	__u32 padding;
-	struct vhost_memory_region regions[0];
-};
 
 /* ioctls */
 
@@ -186,31 +101,7 @@ struct vhost_memory {
  * device.  This can be used to stop the ring (e.g. for migration). */
 #define VHOST_NET_SET_BACKEND _IOW(VHOST_VIRTIO, 0x30, struct vhost_vring_file)
 
-/* Feature bits */
-/* Log all write descriptors. Can be changed while device is active. */
-#define VHOST_F_LOG_ALL 26
-/* vhost-net should add virtio_net_hdr for RX, and strip for TX packets. */
-#define VHOST_NET_F_VIRTIO_NET_HDR 27
-
-/* VHOST_SCSI specific definitions */
-
-/*
- * Used by QEMU userspace to ensure a consistent vhost-scsi ABI.
- *
- * ABI Rev 0: July 2012 version starting point for v3.6-rc merge candidate +
- *            RFC-v2 vhost-scsi userspace.  Add GET_ABI_VERSION ioctl usage
- * ABI Rev 1: January 2013. Ignore vhost_tpgt filed in struct vhost_scsi_target.
- *            All the targets under vhost_wwpn can be seen and used by guset.
- */
-
-#define VHOST_SCSI_ABI_VERSION	1
-
-struct vhost_scsi_target {
-	int abi_version;
-	char vhost_wwpn[224]; /* TRANSPORT_IQN_LEN */
-	unsigned short vhost_tpgt;
-	unsigned short reserved;
-};
+/* VHOST_SCSI specific defines */
 
 #define VHOST_SCSI_SET_ENDPOINT _IOW(VHOST_VIRTIO, 0x40, struct vhost_scsi_target)
 #define VHOST_SCSI_CLEAR_ENDPOINT _IOW(VHOST_VIRTIO, 0x41, struct vhost_scsi_target)
-- 
2.20.1

