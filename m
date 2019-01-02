Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C42C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 14:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F15B218FD
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 14:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ljcki2Bz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729468AbfABO3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 09:29:49 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38749 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727424AbfABO3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 09:29:49 -0500
Received: by mail-pg1-f193.google.com with SMTP id g189so14664296pgc.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 06:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=BecXgh+kIPpPXTWVpvXLny2DUXRqtPcUA0gq4wwH7zU=;
        b=Ljcki2Bz6dBHoXCRu7qf1OUsUWnWtpkflbcT/C48RCIStK8w6VELm8o1x07d+Si/pJ
         C2uE5KSq975ZqexnGmb1vhsyZry+IWM53qjgBYOCla66XluZBE0KZknVP2bqp7EwQ1/p
         PgJazV/uY5EGbiM1fYW4snG1iiyRVr0nyF0G0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BecXgh+kIPpPXTWVpvXLny2DUXRqtPcUA0gq4wwH7zU=;
        b=o1RLrqLaQDtQ0trQoOhqG11MLr2AIBFINT1jA8qd0y9X92N5Kb7Yycp2FzI2qprqhD
         NbjftiX+stjLDe9joRYT38iqEpCYnaINXNmp9pGv5qMLQl7gPQ3qSUuol4QDz7xj7sxK
         BhGd7bisL34oqrj704zh5/one+VDsx1GfoSax5r86DL/1TshZPw65Nol6MK0Po6+IZ19
         49zoDaUt1FIe58bz9d+laRPhV4qh/Bp/9Y3jyui8MMDOo6R+Kln/A4UaEyhEBTLq/2qL
         HCdNw/hXj3Lx9puqNV/QVHYDr/gZDhBqRrTFyk0AQouDCx/fNr2pfXuffbhZbeyZI8bT
         YK8A==
X-Gm-Message-State: AJcUuke9LAPalR4//JCaMjURVunBSNHhgqGzJhXmpTYHczHGYaQr27TW
        NUX4Tmon2dTAUtKE/B3CqEclSQ==
X-Google-Smtp-Source: ALg8bN7BOQiMAeu8UrJMDo7d1IOJ397bqFSxyIFpFbYNJK37tB6RT+gzJ7gvqtsaqXifrg6AfgGnBw==
X-Received: by 2002:a63:b81a:: with SMTP id p26mr13971790pge.433.1546439388417;
        Wed, 02 Jan 2019 06:29:48 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id z127sm82640923pfb.80.2019.01.02.06.29.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Jan 2019 06:29:47 -0800 (PST)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     Paul Burton <paul.burton@mips.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH] scripts: unify system call table generation scripts
Date:   Wed,  2 Jan 2019 19:58:51 +0530
Message-Id: <1546439331-18646-1-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

System call table generation support is provided for
alpha, ia64, m68k, microblaze, mips, parisc, powerpc,
sh, sparc and xtensa architectures. The implementat-
ions are almost similar across all the above archte-
ctures.

In order to reduce the source code across all the
above architectures, create common ".sh" files and
keep it in the common directory, script/.

This will be a generic scripts which can use for all
the above architectures.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 scripts/syscallhdr.sh | 37 +++++++++++++++++++++++++++++++++++++
 scripts/syscallnr.sh  | 32 ++++++++++++++++++++++++++++++++
 scripts/syscalltbl.sh | 37 +++++++++++++++++++++++++++++++++++++
 3 files changed, 106 insertions(+)
 create mode 100644 scripts/syscallhdr.sh
 create mode 100644 scripts/syscallnr.sh
 create mode 100644 scripts/syscalltbl.sh

diff --git a/scripts/syscallhdr.sh b/scripts/syscallhdr.sh
new file mode 100644
index 0000000..d03fe3d
--- /dev/null
+++ b/scripts/syscallhdr.sh
@@ -0,0 +1,37 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+in="$1"
+out="$2"
+my_abis=`echo "($3)" | tr ',' '|'`
+prefix="$4"
+offset="$5"
+
+fileguard=_UAPI_ASM_`basename "$out" | sed \
+	-e 'y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/' \
+	-e 's/[^A-Z0-9_]/_/g' -e 's/__/_/g'`
+grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
+	printf "#ifndef %s\n" "${fileguard}"
+	printf "#define %s\n" "${fileguard}"
+	printf "\n"
+
+	nxt=0
+	while read nr abi name entry compat ; do
+		if [ -z "$offset" ]; then
+			printf "#define __NR_%s%s\t%s\n" \
+				"${prefix}" "${name}" "${nr}"
+		else
+			printf "#define __NR_%s%s\t(%s + %s)\n" \
+				"${prefix}" "${name}" "${offset}" "${nr}"
+		fi
+		nxt=$((nr+1))
+	done
+
+	printf "\n"
+	printf "#ifdef __KERNEL__\n"
+	printf "#define __NR_syscalls\t%s\n" "${nxt}"
+	printf "#endif\n"
+	printf "\n"
+	printf "#endif /* %s */" "${fileguard}"
+	printf "\n"
+) > "$out"
diff --git a/scripts/syscallnr.sh b/scripts/syscallnr.sh
new file mode 100644
index 0000000..8cf33fa
--- /dev/null
+++ b/scripts/syscallnr.sh
@@ -0,0 +1,32 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+in="$1"
+out="$2"
+my_abis=`echo "($3)" | tr ',' '|'`
+prefix="$4"
+offset="$5"
+
+fileguard=_UAPI_ASM_`basename "$out" | sed \
+	-e 'y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/' \
+	-e 's/[^A-Z0-9_]/_/g' -e 's/__/_/g'`
+grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
+	printf "#ifndef %s\n" "${fileguard}"
+	printf "#define %s\n" "${fileguard}"
+	printf "\n"
+
+	nxt=0
+	while read nr abi name entry compat ; do
+		nxt=$((nr+1))
+	done
+
+	if [ ! -z "$prefix" ]; then
+		printf "#define __NR_%s_Linux_syscalls\t%s\n" "${prefix}" "${nxt}"
+		if [ ! -z "$offset" ]; then
+			printf "#define __NR_%s_Linux\t%s\n" "${prefix}" "${offset}"
+		fi
+	fi
+	printf "\n"
+	printf "#endif /* %s */" "${fileguard}"
+	printf "\n"
+) > "$out"
diff --git a/scripts/syscalltbl.sh b/scripts/syscalltbl.sh
new file mode 100644
index 0000000..f60f762
--- /dev/null
+++ b/scripts/syscalltbl.sh
@@ -0,0 +1,37 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+in="$1"
+out="$2"
+my_abis=`echo "($3)" | tr ',' '|'`
+my_abi="$4"
+offset="$5"
+
+emit() {
+	t_nxt="$1"
+	t_nr="$2"
+	t_entry="$3"
+
+	while [ $t_nxt -lt $t_nr ]; do
+		printf "__SYSCALL(%s,sys_ni_syscall)\n" "${t_nxt}"
+		t_nxt=$((t_nxt+1))
+	done
+	printf "__SYSCALL(%s,%s)\n" "${t_nxt}" "${t_entry}"
+}
+
+grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
+	nxt=0
+	if [ -z "$offset" ]; then
+		offset=0
+	fi
+
+	while read nr abi name entry compat ; do
+		if [ "$my_abi" = "c32" -o "$my_abi" = "64_o32" ] &&
+			[ ! -z "$compat" ]; then
+			emit $((nxt+offset)) $((nr+offset)) $compat
+		else
+			emit $((nxt+offset)) $((nr+offset)) $entry
+		fi
+		nxt=$((nr+1))
+	done
+) > "$out"
-- 
1.9.1

