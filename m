Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D93CC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30B5E208A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mt59xQyC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30B5E208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732497AbeHAXY4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 19:24:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:38730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732307AbeHAXYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 19:24:54 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D932208A4;
        Wed,  1 Aug 2018 21:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533159426;
        bh=fgaxWkAPTHAF2866FoT1D+Fo1IYKJqvt3ezsnWOqxaQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mt59xQyCAYXjOxwWPDISBx+zqVQ3lPQZ65YbuUhVjedGvQJyxMN4a5mMcg57cn3kc
         aRyLSdxCgnxx93ZquSlaRbfQfRfS1vZoKoYbVZe/8GPVm+1TTXqPefPP/cNtxrzRZn
         gf64qq8/ZoLWOlYuvsnP9kFuGWyd+7WiU3Z1ljKs=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 01/21] perf trace beauty: Default header_dir to cwd to work without parms
Date:   Wed,  1 Aug 2018 18:36:28 -0300
Message-Id: <20180801213648.4814-2-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180801213648.4814-1-acme@kernel.org>
References: <20180801213648.4814-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Useful when checking the effects of header synchs for the files it uses
as a input to generate string tables, in retrospect this is how it
should've been done from day 1, not requiring the header_dir to be set
on the Makefile, will change everything later, so that the only parm,
common to all generators will be $(srctree) and $(beauty_outdir).

So, to see what it generates, just call it without any parameters:

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
  };
  $

Or:

  $ tools/perf/trace/beauty/sndrv_pcm_ioctl.sh
  static const char *sndrv_pcm_ioctl_cmds[] = {
	[0x00] = "PVERSION",
	[0x01] = "INFO",
	[0x02] = "TSTAMP",
	[0x03] = "TTSTAMP",
	[0x04] = "USER_PVERSION",
	[0x10] = "HW_REFINE",
	[0x11] = "HW_PARAMS",
	[0x12] = "HW_FREE",
	[0x13] = "SW_PARAMS",
	[0x20] = "STATUS",
	[0x21] = "DELAY",
	[0x22] = "HWSYNC",
	[0x23] = "SYNC_PTR",
	[0x24] = "STATUS_EXT",
	[0x32] = "CHANNEL_INFO",
	[0x40] = "PREPARE",
	[0x41] = "RESET",
	[0x42] = "START",
	[0x43] = "DROP",
	[0x44] = "DRAIN",
	[0x45] = "PAUSE",
	[0x46] = "REWIND",
	[0x47] = "RESUME",
	[0x48] = "XRUN",
	[0x49] = "FORWARD",
	[0x50] = "WRITEI_FRAMES",
	[0x51] = "READI_FRAMES",
	[0x52] = "WRITEN_FRAMES",
	[0x53] = "READN_FRAMES",
	[0x60] = "LINK",
	[0x61] = "UNLINK",
  };
  $

Etc.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-90am4vm8hh1osms894dp2otr@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/drm_ioctl.sh                | 9 +++++----
 tools/perf/trace/beauty/kcmp_type.sh                | 2 +-
 tools/perf/trace/beauty/kvm_ioctl.sh                | 4 ++--
 tools/perf/trace/beauty/madvise_behavior.sh         | 2 +-
 tools/perf/trace/beauty/perf_ioctl.sh               | 2 +-
 tools/perf/trace/beauty/pkey_alloc_access_rights.sh | 2 +-
 tools/perf/trace/beauty/sndrv_ctl_ioctl.sh          | 4 ++--
 tools/perf/trace/beauty/sndrv_pcm_ioctl.sh          | 4 ++--
 tools/perf/trace/beauty/vhost_virtio_ioctl.sh       | 6 +++---
 9 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/tools/perf/trace/beauty/drm_ioctl.sh b/tools/perf/trace/beauty/drm_ioctl.sh
index 2149d3a98e42..9d3816815e60 100755
--- a/tools/perf/trace/beauty/drm_ioctl.sh
+++ b/tools/perf/trace/beauty/drm_ioctl.sh
@@ -1,13 +1,14 @@
 #!/bin/sh
 
-drm_header_dir=$1
+[ $# -eq 1 ] && header_dir=$1 || header_dir=tools/include/uapi/drm/
+
 printf "#ifndef DRM_COMMAND_BASE\n"
-grep "#define DRM_COMMAND_BASE" $drm_header_dir/drm.h
+grep "#define DRM_COMMAND_BASE" $header_dir/drm.h
 printf "#endif\n"
 
 printf "static const char *drm_ioctl_cmds[] = {\n"
-grep "^#define DRM_IOCTL.*DRM_IO" $drm_header_dir/drm.h | \
+grep "^#define DRM_IOCTL.*DRM_IO" $header_dir/drm.h | \
 	sed -r 's/^#define +DRM_IOCTL_([A-Z0-9_]+)[	 ]+DRM_IO[A-Z]* *\( *(0x[[:xdigit:]]+),*.*/	[\2] = "\1",/g'
-grep "^#define DRM_I915_[A-Z_0-9]\+[	 ]\+0x" $drm_header_dir/i915_drm.h | \
+grep "^#define DRM_I915_[A-Z_0-9]\+[	 ]\+0x" $header_dir/i915_drm.h | \
 	sed -r 's/^#define +DRM_I915_([A-Z0-9_]+)[	 ]+(0x[[:xdigit:]]+)/\t[DRM_COMMAND_BASE + \2] = "I915_\1",/g'
 printf "};\n"
diff --git a/tools/perf/trace/beauty/kcmp_type.sh b/tools/perf/trace/beauty/kcmp_type.sh
index 40d063b8c082..a3c304caa336 100755
--- a/tools/perf/trace/beauty/kcmp_type.sh
+++ b/tools/perf/trace/beauty/kcmp_type.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-header_dir=$1
+[ $# -eq 1 ] && header_dir=$1 || header_dir=tools/include/uapi/linux/
 
 printf "static const char *kcmp_types[] = {\n"
 regex='^[[:space:]]+(KCMP_(\w+)),'
diff --git a/tools/perf/trace/beauty/kvm_ioctl.sh b/tools/perf/trace/beauty/kvm_ioctl.sh
index bd28817afced..c4699fd46bb6 100755
--- a/tools/perf/trace/beauty/kvm_ioctl.sh
+++ b/tools/perf/trace/beauty/kvm_ioctl.sh
@@ -1,10 +1,10 @@
 #!/bin/sh
 
-kvm_header_dir=$1
+[ $# -eq 1 ] && header_dir=$1 || header_dir=tools/include/uapi/linux/
 
 printf "static const char *kvm_ioctl_cmds[] = {\n"
 regex='^#[[:space:]]*define[[:space:]]+KVM_(\w+)[[:space:]]+_IO[RW]*\([[:space:]]*KVMIO[[:space:]]*,[[:space:]]*(0x[[:xdigit:]]+).*'
-egrep $regex ${kvm_header_dir}/kvm.h	| \
+egrep $regex ${header_dir}/kvm.h	| \
 	sed -r "s/$regex/\2 \1/g"	| \
 	egrep -v " ((ARM|PPC|S390)_|[GS]ET_(DEBUGREGS|PIT2|XSAVE|TSC_KHZ)|CREATE_SPAPR_TCE_64)" | \
 	sort | xargs printf "\t[%s] = \"%s\",\n"
diff --git a/tools/perf/trace/beauty/madvise_behavior.sh b/tools/perf/trace/beauty/madvise_behavior.sh
index 60ef8640ee70..431639eb4d29 100755
--- a/tools/perf/trace/beauty/madvise_behavior.sh
+++ b/tools/perf/trace/beauty/madvise_behavior.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-header_dir=$1
+[ $# -eq 1 ] && header_dir=$1 || header_dir=tools/include/uapi/asm-generic/
 
 printf "static const char *madvise_advices[] = {\n"
 regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+MADV_([[:alnum:]_]+)[[:space:]]+([[:digit:]]+)[[:space:]]*.*'
diff --git a/tools/perf/trace/beauty/perf_ioctl.sh b/tools/perf/trace/beauty/perf_ioctl.sh
index faea4237c793..6492c74df928 100755
--- a/tools/perf/trace/beauty/perf_ioctl.sh
+++ b/tools/perf/trace/beauty/perf_ioctl.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-header_dir=$1
+[ $# -eq 1 ] && header_dir=$1 || header_dir=tools/include/uapi/linux/
 
 printf "static const char *perf_ioctl_cmds[] = {\n"
 regex='^#[[:space:]]*define[[:space:]]+PERF_EVENT_IOC_(\w+)[[:space:]]+_IO[RW]*[[:space:]]*\([[:space:]]*.\$.[[:space:]]*,[[:space:]]*([[:digit:]]+).*'
diff --git a/tools/perf/trace/beauty/pkey_alloc_access_rights.sh b/tools/perf/trace/beauty/pkey_alloc_access_rights.sh
index 62e51a02b839..e0a51aeb20b2 100755
--- a/tools/perf/trace/beauty/pkey_alloc_access_rights.sh
+++ b/tools/perf/trace/beauty/pkey_alloc_access_rights.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-header_dir=$1
+[ $# -eq 1 ] && header_dir=$1 || header_dir=tools/include/uapi/asm-generic/
 
 printf "static const char *pkey_alloc_access_rights[] = {\n"
 regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+PKEY_([[:alnum:]_]+)[[:space:]]+(0x[[:xdigit:]]+)[[:space:]]*'
diff --git a/tools/perf/trace/beauty/sndrv_ctl_ioctl.sh b/tools/perf/trace/beauty/sndrv_ctl_ioctl.sh
index aad5ab130539..eb511bb5fbd3 100755
--- a/tools/perf/trace/beauty/sndrv_ctl_ioctl.sh
+++ b/tools/perf/trace/beauty/sndrv_ctl_ioctl.sh
@@ -1,8 +1,8 @@
 #!/bin/sh
 
-sound_header_dir=$1
+[ $# -eq 1 ] && header_dir=$1 || header_dir=tools/include/uapi/sound/
 
 printf "static const char *sndrv_ctl_ioctl_cmds[] = {\n"
-grep "^#define[\t ]\+SNDRV_CTL_IOCTL_" $sound_header_dir/asound.h | \
+grep "^#define[\t ]\+SNDRV_CTL_IOCTL_" $header_dir/asound.h | \
 	sed -r 's/^#define +SNDRV_CTL_IOCTL_([A-Z0-9_]+)[\t ]+_IO[RW]*\( *.U., *(0x[[:xdigit:]]+),?.*/\t[\2] = \"\1\",/g'
 printf "};\n"
diff --git a/tools/perf/trace/beauty/sndrv_pcm_ioctl.sh b/tools/perf/trace/beauty/sndrv_pcm_ioctl.sh
index b7e9ef6b2f55..6818392968b2 100755
--- a/tools/perf/trace/beauty/sndrv_pcm_ioctl.sh
+++ b/tools/perf/trace/beauty/sndrv_pcm_ioctl.sh
@@ -1,8 +1,8 @@
 #!/bin/sh
 
-sound_header_dir=$1
+[ $# -eq 1 ] && header_dir=$1 || header_dir=tools/include/uapi/sound/
 
 printf "static const char *sndrv_pcm_ioctl_cmds[] = {\n"
-grep "^#define[\t ]\+SNDRV_PCM_IOCTL_" $sound_header_dir/asound.h | \
+grep "^#define[\t ]\+SNDRV_PCM_IOCTL_" $header_dir/asound.h | \
 	sed -r 's/^#define +SNDRV_PCM_IOCTL_([A-Z0-9_]+)[\t ]+_IO[RW]*\( *.A., *(0x[[:xdigit:]]+),?.*/\t[\2] = \"\1\",/g'
 printf "};\n"
diff --git a/tools/perf/trace/beauty/vhost_virtio_ioctl.sh b/tools/perf/trace/beauty/vhost_virtio_ioctl.sh
index 76f1de697787..0f6a5197d0be 100755
--- a/tools/perf/trace/beauty/vhost_virtio_ioctl.sh
+++ b/tools/perf/trace/beauty/vhost_virtio_ioctl.sh
@@ -1,17 +1,17 @@
 #!/bin/sh
 
-vhost_virtio_header_dir=$1
+[ $# -eq 1 ] && header_dir=$1 || header_dir=tools/include/uapi/linux/
 
 printf "static const char *vhost_virtio_ioctl_cmds[] = {\n"
 regex='^#[[:space:]]*define[[:space:]]+VHOST_(\w+)[[:space:]]+_IOW?\([[:space:]]*VHOST_VIRTIO[[:space:]]*,[[:space:]]*(0x[[:xdigit:]]+).*'
-egrep $regex ${vhost_virtio_header_dir}/vhost.h | \
+egrep $regex ${header_dir}/vhost.h | \
 	sed -r "s/$regex/\2 \1/g"	| \
 	sort | xargs printf "\t[%s] = \"%s\",\n"
 printf "};\n"
 
 printf "static const char *vhost_virtio_ioctl_read_cmds[] = {\n"
 regex='^#[[:space:]]*define[[:space:]]+VHOST_(\w+)[[:space:]]+_IOW?R\([[:space:]]*VHOST_VIRTIO[[:space:]]*,[[:space:]]*(0x[[:xdigit:]]+).*'
-egrep $regex ${vhost_virtio_header_dir}/vhost.h | \
+egrep $regex ${header_dir}/vhost.h | \
 	sed -r "s/$regex/\2 \1/g"	| \
 	sort | xargs printf "\t[%s] = \"%s\",\n"
 printf "};\n"
-- 
2.14.4

