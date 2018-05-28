Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162101AbeE1Kfk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:35:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:55950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1162072AbeE1Kff (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:35:35 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Lindroth <thomas.lindroth@gmail.com>,
        Nicolas Pitre <nico@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 208/329] kbuild: make scripts/adjust_autoksyms.sh robust against timestamp races
Date: Mon, 28 May 2018 12:02:17 +0200
Message-Id: <20180528100259.529679175@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100241.796630982@linuxfoundation.org>
References: <20180528100241.796630982@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicolas Pitre <nicolas.pitre@linaro.org>

[ Upstream commit 825d487583089f9a33d31650c9c41f6474aab7fc ]

Some filesystems have timestamps with coarse precision that may allow
for a recently built object file to have the same timestamp as the
updated time on one of its dependency files. When that happens, the
object file doesn't get rebuilt as it should.

This is especially the case on filesystems that don't have sub-second
time precision, such as ext3 or Ext4 with 128B inodes.

Let's prevent that by making sure updated dependency files have a newer
timestamp than the first file we created (i.e. autoksyms.h.tmpnew).

Reported-by: Thomas Lindroth <thomas.lindroth@gmail.com>
Signed-off-by: Nicolas Pitre <nico@linaro.org>
Tested-by: Thomas Lindroth <thomas.lindroth@gmail.com>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 scripts/adjust_autoksyms.sh |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/scripts/adjust_autoksyms.sh
+++ b/scripts/adjust_autoksyms.sh
@@ -83,6 +83,13 @@ while read sympath; do
 	depfile="include/config/ksym/${sympath}.h"
 	mkdir -p "$(dirname "$depfile")"
 	touch "$depfile"
+	# Filesystems with coarse time precision may create timestamps
+	# equal to the one from a file that was very recently built and that
+	# needs to be rebuild. Let's guard against that by making sure our
+	# dep files are always newer than the first file we created here.
+	while [ ! "$depfile" -nt "$new_ksyms_file" ]; do
+		touch "$depfile"
+	done
 	echo $((count += 1))
 done | tail -1 )
 changed=${changed:-0}
