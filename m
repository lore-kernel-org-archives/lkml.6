Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932394AbeBTCOD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 21:14:03 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:42152 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932321AbeBTCOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 21:14:01 -0500
X-Google-Smtp-Source: AH8x226AVeb0yRXb2tsQVVv1IBAPwX1T+cYzLBNEKGOPDhxd3HRR3nStbFndbRE6XBMcRbAnzBN3OQ==
Date: Tue, 20 Feb 2018 02:13:58 +0000
From: Sargun Dhillon <sargun@sargun.me>
To: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: james.l.morris@oracle.com, penguin-kernel@i-love.sakura.ne.jp,
        keescook@chromium.org, igor.stoppa@huawei.com, casey@schaufler-ca.com
Subject: [RFC PATCH v3 0/3] Safe, dynamically loadable LSM hooks
Message-ID: <cover.1519092378.git.sargun@sargun.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset introduces safe dynamic LSM support. These are currently
not unloadable, until we figure out a use case that needs that. Adding
an unload hook is trivial given the way the patch is written.

This exposes a second mechanism of loading hooks which are in modules,
because they are behind static keys, and kept in a set of hooks which
is not marked as read only.

The point of this security feature is to resolve "unknown unknowns"
as well. Although, livepatch is excellent, sometimes, a surgical
LSM is simpler.

It includes an example LSM that prevents specific time travel.

Changes since v2:
  * inode get/set security is readded
  * xfrm singleton hook readded
  * Security hooks are turned into an array
  * Security hooks and dynamic hooks enum is collapsed

Changes since v1:
  * It no longer allows unloading of modules
  * prctl is fixed
  * inode get/set security is removed
  * xfrm singleton hook removed


Sargun Dhillon (3):
  security: Refactor LSM hooks into an array
  security: Expose a mechanism to load lsm hooks dynamically at runtime
  security: Add an example sample dynamic LSM

 include/linux/lsm_hooks.h | 454 ++++++++++++++++++++++++----------------------
 samples/Kconfig           |   6 +
 samples/Makefile          |   2 +-
 samples/lsm/Makefile      |   4 +
 samples/lsm/lsm_example.c |  33 ++++
 security/Kconfig          |   9 +
 security/inode.c          |  13 +-
 security/security.c       | 250 +++++++++++++++++++++++--
 8 files changed, 531 insertions(+), 240 deletions(-)
 create mode 100644 samples/lsm/Makefile
 create mode 100644 samples/lsm/lsm_example.c

-- 
2.14.1
