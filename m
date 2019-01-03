Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6295FC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 12:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 300F72070D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 12:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546519723;
	bh=dbn6WHgAKGuZ1RaXKBqRoLWd0FHr/zYWigHc3izQ8e0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=p+vlBDY8c6bovRN40HnRJv+lRhIcpiYoI96Um8W/xZPdkJIeuM4BLkPiW+rcdCOSC
	 /3TTYW9lAjlY6jSvhCFvUdGXMBS2UO8FTFmfFTG0FigcWrwJr3PLfv3rI3MAmh1C7b
	 PfWlBG703Hw25vjUX3N0jJwIh9yl/RilfHaT8zl4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730369AbfACMsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 07:48:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:42344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731475AbfACMrA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 07:47:00 -0500
Received: from quaco.ghostprotocols.net (unknown [187.65.17.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51184217F5;
        Thu,  3 Jan 2019 12:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546519619;
        bh=dbn6WHgAKGuZ1RaXKBqRoLWd0FHr/zYWigHc3izQ8e0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nby4B3cK1EBeqCQ548dFMwoycAZgilO+ZoXgOoNYc0zztwXiNT3h3cKDI5o8YIChW
         ZuP+knJqF6lN8IXpyyks8S/7F3buU20mMs2I1iSfm9f9ZWiS0EXwboqaZ0GEMtmCCS
         rUSKluqqxd5zAFSglBG/V0aRi2VPwp7ioH+4ytyc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 13/29] perf trace: Wire up ioctl's USBDEBFS_ cmd table generator
Date:   Thu,  3 Jan 2019 09:45:53 -0300
Message-Id: <20190103124609.29672-14-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190103124609.29672-1-acme@kernel.org>
References: <20190103124609.29672-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

That ends up generating this:

  [acme@quaco perf]$ cat /tmp/build/perf/trace/beauty/generated/ioctl/usbdevfs_ioctl_array.c
  static const char *usbdevfs_ioctl_cmds[] = {
	[0] = "CONTROL",
	[10] = "SUBMITURB",
	[11] = "DISCARDURB",
	[12] = "REAPURB",
	[13] = "REAPURBNDELAY",
	[14] = "DISCSIGNAL",
	[15] = "CLAIMINTERFACE",
	[16] = "RELEASEINTERFACE",
	[17] = "CONNECTINFO",
	[18] = "IOCTL",
	[19] = "HUB_PORTINFO",
	[2] = "BULK",
	[20] = "RESET",
	[21] = "CLEAR_HALT",
	[22] = "DISCONNECT",
	[23] = "CONNECT",
	[24] = "CLAIM_PORT",
	[25] = "RELEASE_PORT",
	[26] = "GET_CAPABILITIES",
	[27] = "DISCONNECT_CLAIM",
	[28] = "ALLOC_STREAMS",
	[29] = "FREE_STREAMS",
	[3] = "RESETEP",
	[30] = "DROP_PRIVILEGES",
	[31] = "GET_SPEED",
	[4] = "SETINTERFACE",
	[5] = "SETCONFIGURATION",
	[8] = "GETDRIVER",
  };

  #if 0
  static const char *usbdevfs_ioctl_32_cmds[] = {
	[0] = "CONTROL32",
	[10] = "SUBMITURB32",
	[12] = "REAPURB32",
	[13] = "REAPURBNDELAY32",
	[14] = "DISCSIGNAL32",
	[18] = "IOCTL32",
	[2] = "BULK32",
  };
  #endif
  $

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-hkam6lt1g806l0p4b7buif3n@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index bd23e3f30895..ff29c3372ec3 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -497,6 +497,12 @@ prctl_option_tbl := $(srctree)/tools/perf/trace/beauty/prctl_option.sh
 $(prctl_option_array): $(prctl_hdr_dir)/prctl.h $(prctl_option_tbl)
 	$(Q)$(SHELL) '$(prctl_option_tbl)' $(prctl_hdr_dir) > $@
 
+usbdevfs_ioctl_array := $(beauty_ioctl_outdir)/usbdevfs_ioctl_array.c
+usbdevfs_ioctl_tbl := $(srctree)/tools/perf/trace/beauty/usbdevfs_ioctl.sh
+
+$(usbdevfs_ioctl_array): $(linux_uapi_dir)/usbdevice_fs.h $(usbdevfs_ioctl_tbl)
+	$(Q)$(SHELL) '$(usbdevfs_ioctl_tbl)' $(linux_uapi_dir) > $@
+
 x86_arch_prctl_code_array := $(beauty_outdir)/x86_arch_prctl_code_array.c
 x86_arch_prctl_code_tbl := $(srctree)/tools/perf/trace/beauty/x86_arch_prctl.sh
 
@@ -624,6 +630,7 @@ prepare: $(OUTPUT)PERF-VERSION-FILE $(OUTPUT)common-cmds.h archheaders $(drm_ioc
 	$(mount_flags_array) \
 	$(perf_ioctl_array) \
 	$(prctl_option_array) \
+	$(usbdevfs_ioctl_array) \
 	$(x86_arch_prctl_code_array) \
 	$(rename_flags_array) \
 	$(arch_errno_name_array)
@@ -923,6 +930,7 @@ clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clea
 		$(OUTPUT)$(vhost_virtio_ioctl_array) \
 		$(OUTPUT)$(perf_ioctl_array) \
 		$(OUTPUT)$(prctl_option_array) \
+		$(OUTPUT)$(usbdevfs_ioctl_array) \
 		$(OUTPUT)$(x86_arch_prctl_code_array) \
 		$(OUTPUT)$(rename_flags_array) \
 		$(OUTPUT)$(arch_errno_name_array)
-- 
2.19.2

