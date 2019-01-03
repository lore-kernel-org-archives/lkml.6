Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DB3C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 12:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8BAB21872
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 12:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546519629;
	bh=y3+WE9IN9WqP/V9Vu1fCSwlqJKGv5bwR7FSQek4sevo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pv3wOkJNzK8qoIj7OkjhHBD3bMZu1tDQ1Tr1CwnzaaUz0uSmhXp3MaEG/HpwXTqrw
	 zUcrMK6OS0XbHHPbVMsxXorbWJa1cDa0P7SyhKlw3KDkQ+uTLgmbT1K9LNyj2/DxDX
	 4t/rQ5It/vTf72h7Ug92cExPhkXiQsB79m4MINzc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731515AbfACMrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 07:47:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:42454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730156AbfACMrH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 07:47:07 -0500
Received: from quaco.ghostprotocols.net (unknown [187.65.17.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0673217F5;
        Thu,  3 Jan 2019 12:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546519626;
        bh=y3+WE9IN9WqP/V9Vu1fCSwlqJKGv5bwR7FSQek4sevo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2i/UnhC2bUWAtv1QILZ+CJUXMHDLeXwojbH4wXtonfF9x+AcgnS376w2V4YILrrus
         0F0445M1v3sFbzh8Xls1QZA0WNk65++oV8ZavNmrkXtUvhrd7ei0eRpIugT5Dnvq81
         2oOvq1rJ3DhJ/a3CbJvbF2cFoG5IUtxCcf83YWeE=
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
Subject: [PATCH 15/29] perf trace beauty ioctl: Beautify USBDEVFS_ commands
Date:   Thu,  3 Jan 2019 09:45:55 -0300
Message-Id: <20190103124609.29672-16-acme@kernel.org>
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

For instance, while debugging the 'galileo' python utility to
synchronize fitbit trackers:

  # perf trace -e ioctl ./run --force
  ioctl(0</dev/pts/8>, TCSETS, 0x7ffe28666420) = 0
  ioctl(0</dev/pts/8>, TCSETS, 0x7ffe28666290) = 0
  ioctl(1</dev/pts/8>, TCSETS, 0x7ffe28666290) = 0
  ioctl(2</dev/pts/8>, TCSETS, 0x7ffe28666290) = 0
  ioctl(3</home/acme/hg/galileo/run>, TCSETS, 0x7ffe286663f0) = -1 ENOTTY (Inappropriate ioctl for device)
  ioctl(1</dev/pts/8>, TCSETS, 0x7ffe286655a0) = 0
  ioctl(1</dev/pts/8>, TCSETS, 0x7ffe28665470) = 0
  ioctl(1</dev/pts/8>, TCSETS, 0x7ffe28665470) = 0
  ioctl(1</dev/pts/8>, TCSETS, 0x7ffe286654a0) = 0
  ioctl(1</dev/pts/8>, TCSETS, 0x7ffe286654a0) = 0
  ioctl(1</dev/pts/8>, TCSETS, 0x7ffe28665400) = 0
  ioctl(1</dev/pts/8>, TIOCSWINSZ, 0x7ffe286654c0) = 0
  ioctl(0</dev/pts/8>, TIOCSWINSZ, 0x7ffe28665560) = 0
  ioctl(0</dev/pts/8>, TIOCSWINSZ, 0x7ffe28665560) = 0
  ioctl(0</dev/pts/8>, TIOCMGET, 0x7ffe28665560) = 0
  ioctl(0</dev/pts/8>, TCSETS, 0x7ffe28665530) = 0
  ioctl(10</dev/bus/usb/001/011>, USBDEVFS_GET_CAPABILITIES, 0x561468dad048) = 0
  ioctl(10</dev/bus/usb/001/011>, USBDEVFS_GETDRIVER, 0x7ffe28665500) = -1 ENODATA (No data available)
  ioctl(10</dev/bus/usb/001/011>, USBDEVFS_GETDRIVER, 0x7ffe28665500) = -1 ENODATA (No data available)
  ioctl(10</dev/bus/usb/001/011>, USBDEVFS_SETCONFIGURATION, 0x7ffe2866513c) = 0
  ioctl(10</dev/bus/usb/001/011>, USBDEVFS_CLAIMINTERFACE, 0x7ffe286647bc) = 0
  ioctl(10</dev/bus/usb/001/011>, USBDEVFS_SUBMITURB, 0x561468dace40) = 0
  ioctl(10</dev/bus/usb/001/011>, USBDEVFS_REAPURBNDELAY, 0x7ffe28664c10) = 0
  ioctl(10</dev/bus/usb/001/011>, USBDEVFS_REAPURBNDELAY, 0x7ffe28664c10) = -1 EAGAIN (Resource temporarily unavailable)
  ioctl(10</dev/bus/usb/001/011>, USBDEVFS_SUBMITURB, 0x561468dace40) = 0
  ioctl(10</dev/bus/usb/001/011>, USBDEVFS_REAPURBNDELAY, 0x7ffe28664dd0) = 0
  ioctl(10</dev/bus/usb/001/011>, USBDEVFS_REAPURBNDELAY, 0x7ffe28664dd0) = -1 EAGAIN (Resource temporarily unavailable)
  <SNIP>
  ioctl(10</dev/bus/usb/001/011>, USBDEVFS_SUBMITURB, 0x561468e72ec0) = 0
  ioctl(10</dev/bus/usb/001/011>, USBDEVFS_REAPURBNDELAY, 0x7ffe28664cc0) = 0
  ioctl(10</dev/bus/usb/001/011>, USBDEVFS_REAPURBNDELAY, 0x7ffe28664cc0) = -1 EAGAIN (Resource temporarily unavailable)
  ioctl(10</dev/bus/usb/001/011>, USBDEVFS_RELEASEINTERFACE, 0x7ffe2866463c) = 0
  ioctl(10</dev/bus/usb/001/011>, USBDEVFS_RELEASEINTERFACE, 0x7ffe2866463c) = 0
  Tracker: 813F4690C3D1: Synchronisation successful
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-6x2cawak7jno3gpp5pagzj50@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/ioctl.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/perf/trace/beauty/ioctl.c b/tools/perf/trace/beauty/ioctl.c
index 9efeb6a936c2..620350d41209 100644
--- a/tools/perf/trace/beauty/ioctl.c
+++ b/tools/perf/trace/beauty/ioctl.c
@@ -112,6 +112,17 @@ static size_t ioctl__scnprintf_perf_cmd(int nr, int dir, char *bf, size_t size)
 	return scnprintf(bf, size, "(%#x, %#x, %#x)", 0xAE, nr, dir);
 }
 
+static size_t ioctl__scnprintf_usbdevfs_cmd(int nr, int dir, char *bf, size_t size)
+{
+#include "trace/beauty/generated/ioctl/usbdevfs_ioctl_array.c"
+	static DEFINE_STRARRAY(usbdevfs_ioctl_cmds, "");
+
+	if (nr < strarray__usbdevfs_ioctl_cmds.nr_entries && strarray__usbdevfs_ioctl_cmds.entries[nr] != NULL)
+		return scnprintf(bf, size, "USBDEVFS_%s", strarray__usbdevfs_ioctl_cmds.entries[nr]);
+
+	return scnprintf(bf, size, "(%c, %#x, %#x)", 'U', nr, dir);
+}
+
 static size_t ioctl__scnprintf_cmd(unsigned long cmd, char *bf, size_t size, bool show_prefix)
 {
 	const char *prefix = "_IOC_";
@@ -157,9 +168,20 @@ static size_t ioctl__scnprintf_cmd(unsigned long cmd, char *bf, size_t size, boo
 	return printed + scnprintf(bf + printed, size - printed, ", %#x, %#x, %#x)", type, nr, sz);
 }
 
+#ifndef USB_DEVICE_MAJOR
+#define USB_DEVICE_MAJOR 189
+#endif // USB_DEVICE_MAJOR
+
 size_t syscall_arg__scnprintf_ioctl_cmd(char *bf, size_t size, struct syscall_arg *arg)
 {
 	unsigned long cmd = arg->val;
+	unsigned int fd = syscall_arg__val(arg, 0);
+	struct file *file = thread__files_entry(arg->thread, fd);
+
+	if (file != NULL) {
+		if (file->dev_maj == USB_DEVICE_MAJOR)
+			return ioctl__scnprintf_usbdevfs_cmd(_IOC_NR(cmd), _IOC_DIR(cmd), bf, size);
+	}
 
 	return ioctl__scnprintf_cmd(cmd, bf, size, arg->show_string_prefix);
 }
-- 
2.19.2

