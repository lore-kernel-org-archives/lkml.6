Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA06C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 08:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 193D220849
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 08:34:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 193D220849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbeLLId7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 03:33:59 -0500
Received: from smtp-sh2.infomaniak.ch ([128.65.195.6]:48195 "EHLO
        smtp-sh2.infomaniak.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbeLLId6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 03:33:58 -0500
Received: from smtp5.infomaniak.ch (smtp5.infomaniak.ch [83.166.132.18])
        by smtp-sh.infomaniak.ch (8.14.5/8.14.5) with ESMTP id wBC8Hch1022149
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Dec 2018 09:17:38 +0100
Received: from localhost (ns3096276.ip-94-23-54.eu [94.23.54.103])
        (authenticated bits=0)
        by smtp5.infomaniak.ch (8.14.5/8.14.5) with ESMTP id wBC8Hal6056080;
        Wed, 12 Dec 2018 09:17:36 +0100
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
Subject: [RFC PATCH v1 0/5] Add support for O_MAYEXEC
Date:   Wed, 12 Dec 2018 09:17:07 +0100
Message-Id: <20181212081712.32347-1-mic@digikod.net>
X-Mailer: git-send-email 2.20.0.rc2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Antivirus: Dr.Web (R) for Unix mail servers drweb plugin ver.6.0.2.8
X-Antivirus-Code: 0x100000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The goal of this patch series is to control script interpretation.  A
new O_MAYEXEC flag used by sys_open() is added to enable userland script
interpreter to delegate to the kernel (and thus the system security
policy) the permission to interpret scripts or other files containing
what can be seen as commands.

The security policy is the responsibility of an LSM.  A basic
system-wide policy is implemented with Yama and configurable through a
sysctl.

The initial idea come from CLIP OS and the original implementation has
been used for more than 10 years:
https://github.com/clipos-archive/clipos4_doc

An introduction to O_MAYEXEC was given at the Linux Security Summit
Europe 2018 - Linux Kernel Security Contributions by ANSSI:
https://www.youtube.com/watch?v=chNjCRtPKQY&t=17m15s
The "write xor execute" principle was explained at Kernel Recipes 2018 -
CLIP OS: a defense-in-depth OS:
https://www.youtube.com/watch?v=PjRE0uBtkHU&t=11m14s

This patch series can be applied on top of v4.20-rc6.  This can be
tested with CONFIG_SECURITY_YAMA.  I would really appreciate
constructive comments on this RFC.

Regards,

Mickaël Salaün (5):
  fs: Add support for an O_MAYEXEC flag on sys_open()
  fs: Add a MAY_EXECMOUNT flag to infer the noexec mount propertie
  Yama: Enforces noexec mounts or file executability through O_MAYEXEC
  selftest/yama: Add tests for O_MAYEXEC enforcing
  doc: Add documentation for Yama's open_mayexec_enforce

 Documentation/admin-guide/LSM/Yama.rst       |  41 +++
 MAINTAINERS                                  |   1 +
 fs/fcntl.c                                   |   2 +-
 fs/namei.c                                   |   2 +
 fs/open.c                                    |   4 +
 include/linux/fcntl.h                        |   2 +-
 include/linux/fs.h                           |   4 +
 include/uapi/asm-generic/fcntl.h             |   3 +
 security/yama/Kconfig                        |   3 +-
 security/yama/yama_lsm.c                     |  82 +++++-
 tools/testing/selftests/Makefile             |   1 +
 tools/testing/selftests/yama/.gitignore      |   1 +
 tools/testing/selftests/yama/Makefile        |  19 ++
 tools/testing/selftests/yama/config          |   2 +
 tools/testing/selftests/yama/test_omayexec.c | 276 +++++++++++++++++++
 15 files changed, 439 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/yama/.gitignore
 create mode 100644 tools/testing/selftests/yama/Makefile
 create mode 100644 tools/testing/selftests/yama/config
 create mode 100644 tools/testing/selftests/yama/test_omayexec.c

-- 
2.20.0.rc2

