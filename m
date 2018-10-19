Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC002ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 05:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F80F21476
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 05:37:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F80F21476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbeJSNls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 09:41:48 -0400
Received: from mo-csw-fb1115.securemx.jp ([210.130.202.174]:46480 "EHLO
        mo-csw-fb.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbeJSNls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 09:41:48 -0400
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1115) id w9J59CZm006981; Fri, 19 Oct 2018 14:09:13 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id w9J593p1005330; Fri, 19 Oct 2018 14:09:03 +0900
X-Iguazu-Qid: 2wGr1FmJhuhoaJqd9f
X-Iguazu-QSIG: v=1; s=0; t=1539925742; q=2wGr1FmJhuhoaJqd9f; m=MhVjkcnCtjtZ5o2e9HVaALEX/d7av43DbZ1gc9biGj8=
Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
        by relay.securemx.jp (mx-mr1113) id w9J591JU034029;
        Fri, 19 Oct 2018 14:09:02 +0900
Received: from hop001.toshiba.co.jp ([133.199.164.63])
        by imx2.toshiba.co.jp  with ESMTP id w9J590m9027470;
        Fri, 19 Oct 2018 14:09:01 +0900 (JST)
From:   Shinya Takumi <shinya1.takumi@toshiba.co.jp>
To:     jmorris@namei.org, serge@hallyn.com,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Shinya Takumi <shinya1.takumi@toshiba.co.jp>
Subject: [RFC v4 0/2] WhiteEgret LSM module
Date:   Fri, 19 Oct 2018 14:07:52 +0900
X-TSB-HOP: ON
Message-Id: <1539925672-16744-1-git-send-email-shinya1.takumi@toshiba.co.jp>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WhiteEgret is an LSM to simply provide a whitelisting-type
execution control.

An execution-whitelist, simply called whitelist, is a list
of executable components (e.g., applications, libraries)
that are approved to run on a host. The whitelist is used
to decide whether executable components are permitted to
execute or not. This mechanism can stop an execution of
unknown software, so it helps stop the execution of
malicious code and other unauthorized software.

It is important to maintain a whitelist properly according to
the execution environments. Managing whitelists for information
systems is a difficult task because their environments are
changed frequently. On the other hand, for such devices that
continue to do the same tasks for a certain period of time,
we can use the same whitelist for the period once the whitelist
is established. Thus the whitelisting-type execution control
works best in such execution environments. Examples of the above
execution environments include control devices in industrial
control systems.

Although the number of changing whitelists is not so large,
it is necessary to change them according to a system life cycle
or each phase of system operations. There is a requirement to
change whitelists with the system operations continued because
they often cannot easily be stopped. For example, such cases
include temporarily allowing maintenance programs for maintenance
or troubleshooting purposes while running the systems.

WhiteEgret is aiming at satisfying the above requirement.
WhiteEgret adopts a model that a whitelist is managed in user space.
Namely, WhiteEgret assumes that a privileged user manages a whitelist
in user space. This makes it possible to change the whitelist while
running the systems.

Mechanism of WhiteEgret

WhiteEgret requires a user application called WhiteEgret User
Application (WEUA, for short). WhiteEgret utilizes the
bprm_check_security hook and the mmap_file hook.
WhiteEgret asks WEUA whether an executable component hooked
by the above hooks is permitted to execute or not.
If the response from the WEUA is "permit", then WhiteEgret
continues to process the executable component. If the response
is "not permit", then WhiteEgret returns an error and blocks
the execution of the executable component.
The bprm_check_security hook is triggered by execve system
call, so execution by almost all executable components are
hooked by the hook. However, because shared objects do not
invoke execve system call, WhiteEgret utilizes the mmap_file
hook to hook the memory mapping by a shared object.
Thus WhiteEgret ignores the mmap_file hook caused by
non-executable and by executable which calls execve system call.

To ask the permission to a WEUA, WhiteEgret sends the
absolute path, the inode number and the device number of the
executable component to the WEUA.
Then the WEUA is expected to work as follows.
The WEUA sees if the tuple of the absolute path and/or the inode
number and/or the device number is contained in the whitelist.
If it exists, the WEUA compares a hash value of the executable
component indicated by the absolute path (and/or the inode number
and/or device number) with that in the whitelist to see whether
the executable component is changed or not after the whitelist is
made. The WEUA returns "permit" if both tests are passed,
otherwise returns "not permit".

WhiteEgret v4 is also able to control for script execution. Some
LSM hooks (file_open/file_permission/task_alloc/task_free) are
added. Kernel configs are required to enable the hooks.

Most of interpreters open script files to execute. Therefore
WhiteEgret hooks for reading or opening a file. Then WhiteEgret
asks the WEUA whether an execution of the script is permitted to
execute or not. WhiteEgret is able to choose a hook entry for
execution control between file_open or file_permission.

Hook entries of task_alloc and task_free are used to control
exections of script effectively. Some interpreters forks child
processes to execte script files, so the WEUA managed a process
family of an interpter by bprm_check_security, task_alloc and
task_free.

To use WhiteEgret

Users have to prepare a whitelist and a WEUA to use WhiteEgret.
A sample WEUA is involved in samples/whiteegret/.

To enable WhiteEgret, you are required to build the kernel using
normal procedures with CONFIG_SECURITY_WHITEEGRET=y.

Additionally, SECURITY_WHITEEGRET_INTERPRETER=y option is
required to enable to control script executions.
And SECURITY_WHITEEGRET_WRITE=y option is also required to
detect of writing script files.

The patchset is also available in our github repo:
  https://github.com/whiteegret/whiteegret

---
Changes in v4:
- Add LSM hooks (file_open/file_permission/task_alloc/task_free)
  to control for script execution. Kernel configs are required
    to enable the hooks.
    - Modify the data struct for kernel space and user space
      communication.

Changes in v3:
- Change to a minor LSM module.

Changes in v2:
- Change communication method between kernel space and user space
from netlink to device driver, and device driver utilizes not LKM
but securityfs.
- Add inode number and device number to information of executable
component sent from kernel space to user space.
- Fix bugs regarding to locks during kernel space and user space
communication.
- Change return value from -EPERM to -EACCES when the execution of
an executable component is denied.

Shinya Takumi (2):
  WhiteEgret: Add WhiteEgret core functions.
  WhiteEgret: Add an example of user application.

 samples/Kconfig                    |   6 +
 samples/Makefile                   |   2 +-
 samples/whiteegret/Makefile        |  14 ++
 samples/whiteegret/checkwl.c       | 215 +++++++++++++++++
 samples/whiteegret/checkwl.h       |  33 +++
 samples/whiteegret/main.c          | 119 ++++++++++
 security/Kconfig                   |   1 +
 security/Makefile                  |   2 +
 security/whiteegret/Kconfig        |  82 +++++++
 security/whiteegret/Makefile       |   2 +
 security/whiteegret/init.c         | 148 ++++++++++++
 security/whiteegret/main.c         | 466 +++++++++++++++++++++++++++++++++++++
 security/whiteegret/request.c      |  98 ++++++++
 security/whiteegret/request.h      |  47 ++++
 security/whiteegret/we.h           |  72 ++++++
 security/whiteegret/we_fs.c        | 269 +++++++++++++++++++++
 security/whiteegret/we_fs.h        |  23 ++
 security/whiteegret/we_fs_common.h |  60 +++++
 18 files changed, 1658 insertions(+), 1 deletion(-)
 create mode 100644 samples/whiteegret/Makefile
 create mode 100644 samples/whiteegret/checkwl.c
 create mode 100644 samples/whiteegret/checkwl.h
 create mode 100644 samples/whiteegret/main.c
 create mode 100644 security/whiteegret/Kconfig
 create mode 100644 security/whiteegret/Makefile
 create mode 100644 security/whiteegret/init.c
 create mode 100644 security/whiteegret/main.c
 create mode 100644 security/whiteegret/request.c
 create mode 100644 security/whiteegret/request.h
 create mode 100644 security/whiteegret/we.h
 create mode 100644 security/whiteegret/we_fs.c
 create mode 100644 security/whiteegret/we_fs.h
 create mode 100644 security/whiteegret/we_fs_common.h

-- 
2.7.4

