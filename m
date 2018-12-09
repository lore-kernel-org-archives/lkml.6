Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C0BC67838
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 20:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54B1F20672
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 20:37:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54B1F20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbeLIUhR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 15:37:17 -0500
Received: from mail.windriver.com ([147.11.1.11]:32967 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbeLIUhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 15:37:15 -0500
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id wB9Kal5H020405
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Sun, 9 Dec 2018 12:36:48 -0800 (PST)
Received: from yow-cube1.wrs.com (128.224.56.98) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.3.408.0; Sun, 9 Dec 2018
 12:36:47 -0800
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     <linux-security-module@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        David Howells <dhowells@redhat.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        John Johansen <john.johansen@canonical.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Serge E. Hallyn" <serge@hallyn.com>, <keyrings@vger.kernel.org>,
        <linux-ima-devel@lists.sourceforge.net>,
        <linux-integrity@vger.kernel.org>
Subject: [PATCH 0/5] security: remove needless usage of module header
Date:   Sun, 9 Dec 2018 15:36:28 -0500
Message-ID: <1544387793-32309-1-git-send-email-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The most important thing to note here, is these clean-ups make no
changes to the object files or the final generated run-time.

The work here represents a scan over the security dir, looking for files
that have nothing to do with a modular use case, but are using modular
infrastructure regardless.

We are trying to make driver code consistent with the Makefiles/Kconfigs
that control them.  This means not using modular functions/macros for
drivers that can never be built as a module.  This has been done in quite
a lot of other mainline subsystem dirs already.

Using modular infrastructure in non-modules might seem harmless, but some
of the downfalls this leads to are:

 (1) it is easy to accidentally write unused module_exit and remove code
 (2) it can be misleading when reading the source, thinking it can be
     modular when the Makefile and/or Kconfig prohibit it
 (3) it requires the include of the module.h header file which in turn
     includes nearly everything else, thus adding to CPP overhead.
 (4) it gets copied/replicated into other drivers and spreads quickly.

As a data point for #3 above, an empty C file that just includes the
module.h header generates over 750kB of CPP output.  Repeating the same
experiment with init.h and the result is less than 12kB; with export.h
it is only about 1/2kB; with both it still is less than 12kB.

We start with the simple ones - removing <linux/module.h> from where
it simply isn't required.  Then we remove the no-op MODULE_ macros from
non-modular files, in order to remove module.h from there as well.
Overall, we get rid of about 28 instances of <linux/module.h> here.

Build tested on v4.20-rc5 for allmodconfig on x86-64 and ARM-64.

Paul.
---

Cc: David Howells <dhowells@redhat.com>
Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: James Morris <jmorris@namei.org>
Cc: John Johansen <john.johansen@canonical.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: keyrings@vger.kernel.org
Cc: linux-ima-devel@lists.sourceforge.net
Cc: linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org

Paul Gortmaker (5):
  security: audit and remove any unnecessary uses of module.h
  keys: remove needless modular infrastructure from ecryptfs_format
  security: fs: make inode explicitly non-modular
  security: integrity: make evm_main explicitly non-modular
  security: integrity: make ima_main explicitly non-modular

 security/apparmor/apparmorfs.c                   | 2 +-
 security/commoncap.c                             | 1 -
 security/inode.c                                 | 6 ++----
 security/integrity/evm/evm_crypto.c              | 2 +-
 security/integrity/evm/evm_main.c                | 5 +----
 security/integrity/evm/evm_posix_acl.c           | 1 -
 security/integrity/evm/evm_secfs.c               | 2 +-
 security/integrity/iint.c                        | 2 +-
 security/integrity/ima/ima_api.c                 | 1 -
 security/integrity/ima/ima_appraise.c            | 2 +-
 security/integrity/ima/ima_fs.c                  | 2 +-
 security/integrity/ima/ima_init.c                | 2 +-
 security/integrity/ima/ima_main.c                | 7 +++----
 security/integrity/ima/ima_policy.c              | 2 +-
 security/integrity/ima/ima_queue.c               | 1 -
 security/keys/encrypted-keys/ecryptfs_format.c   | 5 ++---
 security/keys/encrypted-keys/masterkey_trusted.c | 1 -
 security/keys/gc.c                               | 1 -
 security/keys/key.c                              | 2 +-
 security/keys/keyctl.c                           | 1 -
 security/keys/keyring.c                          | 2 +-
 security/keys/permission.c                       | 2 +-
 security/keys/proc.c                             | 1 -
 security/keys/process_keys.c                     | 1 -
 security/keys/request_key.c                      | 2 +-
 security/keys/request_key_auth.c                 | 1 -
 security/keys/user_defined.c                     | 2 +-
 security/security.c                              | 2 +-
 28 files changed, 22 insertions(+), 39 deletions(-)

-- 
2.7.4

