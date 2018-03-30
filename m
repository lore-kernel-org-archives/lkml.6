Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751068AbeC3Igg (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 04:36:36 -0400
Received: from mo-csw-fb1516.securemx.jp ([210.130.202.172]:47928 "EHLO
        mo-csw-fb.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750744AbeC3Igb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 04:36:31 -0400
X-Iguazu-Qid: 34tIYlmO6sM7jJpilw
X-Iguazu-QSIG: v=1; s=0; t=1522398645; q=34tIYlmO6sM7jJpilw; m=mmBRJ3N2lOW7JkXBlIkLOZ4YIBHqPv/DiunmQ76r1Qo=
Content-Transfer-Encoding: 7bit
From: Masanobu Koike <masanobu2.koike@toshiba.co.jp>
To: jmorris@namei.org, serge@hallyn.com,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Masanobu Koike <masanobu2.koike@toshiba.co.jp>
Subject: [RFC v3 0/2] WhiteEgret LSM module
Date: Fri, 30 Mar 2018 17:30:31 +0900
X-TSB-HOP: ON
Message-Id: <20180330083031.2199-1-masanobu2.koike@toshiba.co.jp>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
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

To use WhiteEgret

Users have to prepare a whitelist and a WEUA to use WhiteEgret.
A sample WEUA is involved in samples/whiteegret/.

To enable WhiteEgret, you are required to build the kernel using
normal procedures with CONFIG_SECURITY_WHITEEGRET=y.

Assumptions and ToDos

At this stage, WhiteEgret assumes the following.
Relaxing these assumptions are future works.
- Root is not compromised. And using a whitelist and a WEUA
requires root privilege.
- WEUA is reliable.
- It is allowed for scripting languages, e.g., Perl or Python,
to read arbitrary scripts and to execute them.


The patchset is also available in our github repo:
  https://github.com/whiteegret/whiteegret

---
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

Masanobu Koike (2):
  WhiteEgret: Add WhiteEgret core functions.
  WhiteEgret: Add an example of user application.

 samples/Kconfig                    |   6 +
 samples/Makefile                   |   2 +-
 samples/whiteegret/Makefile        |  14 ++
 samples/whiteegret/checkwl.c       |  57 ++++++++
 samples/whiteegret/checkwl.h       |  26 ++++
 samples/whiteegret/main.c          |  86 +++++++++++
 security/Kconfig                   |   1 +
 security/Makefile                  |   2 +
 security/whiteegret/Kconfig        |  11 ++
 security/whiteegret/Makefile       |   2 +
 security/whiteegret/init.c         |  72 ++++++++++
 security/whiteegret/main.c         | 255 +++++++++++++++++++++++++++++++++
 security/whiteegret/request.c      | 151 ++++++++++++++++++++
 security/whiteegret/request.h      |  52 +++++++
 security/whiteegret/we.h           |  66 +++++++++
 security/whiteegret/we_fs.c        | 284 +++++++++++++++++++++++++++++++++++++
 security/whiteegret/we_fs.h        |  23 +++
 security/whiteegret/we_fs_common.h |  36 +++++
 18 files changed, 1145 insertions(+), 1 deletion(-)
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
2.14.1
