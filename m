Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3450C67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 08:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8222D20849
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 08:34:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8222D20849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbeLLIeK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 03:34:10 -0500
Received: from smtp-sh2.infomaniak.ch ([128.65.195.6]:56329 "EHLO
        smtp-sh2.infomaniak.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbeLLIeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 03:34:10 -0500
Received: from smtp6.infomaniak.ch (smtp6.infomaniak.ch [83.166.132.19])
        by smtp-sh.infomaniak.ch (8.14.5/8.14.5) with ESMTP id wBC8Hpqe022900
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Dec 2018 09:17:51 +0100
Received: from localhost (ns3096276.ip-94-23-54.eu [94.23.54.103])
        (authenticated bits=0)
        by smtp6.infomaniak.ch (8.14.5/8.14.5) with ESMTP id wBC8HoSC003779;
        Wed, 12 Dec 2018 09:17:50 +0100
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Matthew Garrett <mjg59@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mickael.salaun@ssi.gouv.fr>,
        Mimi Zohar <zohar@linux.ibm.com>,
        =?UTF-8?q?Philippe=20Tr=C3=A9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>, Shuah Khan <shuah@kernel.org>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        Yves-Alexis Perez <yves-alexis.perez@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH v1 5/5] doc: Add documentation for Yama's open_mayexec_enforce
Date:   Wed, 12 Dec 2018 09:17:12 +0100
Message-Id: <20181212081712.32347-6-mic@digikod.net>
X-Mailer: git-send-email 2.20.0.rc2
In-Reply-To: <20181212081712.32347-1-mic@digikod.net>
References: <20181212081712.32347-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Antivirus: Dr.Web (R) for Unix mail servers drweb plugin ver.6.0.2.8
X-Antivirus-Code: 0x100000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mickaël Salaün <mic@digikod.net>
Reviewed-by: Philippe Trébuchet <philippe.trebuchet@ssi.gouv.fr>
Reviewed-by: Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Kees Cook <keescook@chromium.org>
Cc: Mickaël Salaün <mickael.salaun@ssi.gouv.fr>
---
 Documentation/admin-guide/LSM/Yama.rst | 41 ++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/Documentation/admin-guide/LSM/Yama.rst b/Documentation/admin-guide/LSM/Yama.rst
index d0a060de3973..a72c86a24b35 100644
--- a/Documentation/admin-guide/LSM/Yama.rst
+++ b/Documentation/admin-guide/LSM/Yama.rst
@@ -72,3 +72,44 @@ The sysctl settings (writable only with ``CAP_SYS_PTRACE``) are:
     ``PTRACE_TRACEME``. Once set, this sysctl value cannot be changed.
 
 The original children-only logic was based on the restrictions in grsecurity.
+
+open_mayexec_enforce
+====================
+
+The ``O_MAYEXEC`` flag can be passed to :manpage:`open(2)` to only open files
+(or directories) that are executable.  If the file is not identified as
+executable, then the syscall returns -EACCES.  This may allow a script
+interpreter to check executable permission before reading commands from a file.
+One interesting use case is to enforce a "write xor execute" policy through
+interpreters.
+
+Thanks to this flag, Yama enables to enforce the ``noexec`` mount option (i.e.
+the underlying mount point of the file is mounted with MNT_NOEXEC or its
+underlying superblock is SB_I_NOEXEC) not only on ELF binaries but also on
+scripts.  This may be possible thanks to script interpreters using the
+``O_MAYEXEC`` flag.  The executable permission is then checked before reading
+commands from a file, and thus can enforce the ``noexec`` at the interpreter
+level by propagating this security policy to the scripts.  To be fully
+effective, these interpreters also need to handle the other ways to execute
+code (for which the kernel can't help): command line parameters (e.g., option
+``-e`` for Perl), module loading (e.g., option ``-m`` for Python), stdin, file
+sourcing, environment variables, configuration files...  According to the
+threat model, it may be acceptable to allow some script interpreters (e.g.
+Bash) to interpret commands from stdin, may it be a TTY or a pipe, because it
+may not be enough to (directly) perform syscalls.
+
+Yama implements two complementary security policies to propagate the ``noexec``
+mount option or the executable file permission.  These policies are handled by
+the ``kernel.yama.open_mayexec_enforce`` sysctl (writable only with
+``CAP_MAC_ADMIN``) as a bitmask:
+
+1 - mount restriction:
+    check that the mount options for the underlying VFS mount do not prevent
+    execution.
+
+2 - file permission restriction:
+    check that the to-be-opened file is marked as executable for the current
+    process (e.g., POSIX permissions).
+
+Code samples can be found in tools/testing/selftests/yama/test_omayexec.c and
+https://github.com/clipos-archive/clipos4_portage-overlay/search?q=O_MAYEXEC .
-- 
2.20.0.rc2

