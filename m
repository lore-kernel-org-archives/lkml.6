Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=GAPPY_SUBJECT,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8543FC070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 21:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1634E213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 21:29:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1634E213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=namei.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbeIMCgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 22:36:18 -0400
Received: from namei.org ([65.99.196.166]:58810 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728232AbeIMCgS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 22:36:18 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id w8CLTW7p020235;
        Wed, 12 Sep 2018 21:29:33 GMT
Date:   Thu, 13 Sep 2018 07:29:32 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>, mic@digikod.net
cc:     LSM <linux-security-module@vger.kernel.org>,
        LKLM <linux-kernel@vger.kernel.org>,
        SE Linux <selinux@tycho.nsa.gov>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Schaufler, Casey" <casey.schaufler@intel.com>
Subject: Re: [PATCH v2 00/10] LSM: Module stacking in support of S.A.R.A and
 Landlock
In-Reply-To: <cbf848ae-a1ac-c5ab-f23b-bc9217fceebe@schaufler-ca.com>
Message-ID: <alpine.LRH.2.21.1809130727310.19741@namei.org>
References: <cbf848ae-a1ac-c5ab-f23b-bc9217fceebe@schaufler-ca.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1665246916-734686802-1536787774=:19741"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1665246916-734686802-1536787774=:19741
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

Adding the SARA and LandLock authors for review & comment.

Salvatore & Mickaël: does this patchset meet your needs for merging to 
mainline?



On Tue, 11 Sep 2018, Casey Schaufler wrote:

> LSM: Module stacking in support of S.A.R.A and Landlock
> 
> v2: Reduce the patchset to what is required to support
>     the proposed S.A.R.A. and LandLock security modules
> 
> The S.A.R.A. security module is intended to be used
> in conjunction with other security modules. It requires
> state to be maintained for the credential, which
> in turn requires a mechanism for sharing the credential
> security blob. The module also requires mechanism for
> user space manipulation of the credential information,
> hence an additional subdirectory in /proc/.../attr.
> 
> The LandLock security module provides user configurable
> policy in the secmark mechanism. It requires data in
> the credential, file and inode security blobs. For this
> to be used along side the existing "major" security
> modules mechanism for sharing these blobs is provided.
> 
> A side effect of providing sharing of the crendential
> security blob is that the TOMOYO module can be used at
> the same time as the other "major" modules.
> 
> The mechanism for configuring which security modules are
> enabled has to change when stacking in enabled. Any
> module that uses just the security blobs that are shared
> can be selected. Additionally, one other "major" module
> can be selected.
> 
> The security module stacking issues around networking and
> IPC are not addressed here as they are beyond what is
> required for TOMOYO, S.A.R.A and LandLock.
> 
> git://github.com/cschaufler/lsm-stacking.git#stacking-4.19-rc2-saralock
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  Documentation/admin-guide/LSM/index.rst |  23 ++-
>  fs/proc/base.c                          |  64 ++++++-
>  fs/proc/internal.h                      |   1 +
>  include/linux/lsm_hooks.h               |  20 ++-
>  include/linux/security.h                |  15 +-
>  kernel/cred.c                           |  13 --
>  security/Kconfig                        |  92 ++++++++++
>  security/apparmor/domain.c              |   2 +-
>  security/apparmor/include/cred.h        |  24 ++-
>  security/apparmor/include/file.h        |   9 +-
>  security/apparmor/include/lib.h         |   4 +
>  security/apparmor/lsm.c                 |  53 ++++--
>  security/apparmor/task.c                |   6 +-
>  security/security.c                     | 293 ++++++++++++++++++++++++++++++--
>  security/selinux/hooks.c                | 215 ++++++++---------------
>  security/selinux/include/objsec.h       |  37 +++-
>  security/selinux/selinuxfs.c            |   5 +-
>  security/selinux/xfrm.c                 |   4 +-
>  security/smack/smack.h                  |  42 ++++-
>  security/smack/smack_access.c           |   4 +-
>  security/smack/smack_lsm.c              | 283 +++++++++++-------------------
>  security/smack/smackfs.c                |  18 +-
>  security/tomoyo/common.h                |  31 +++-
>  security/tomoyo/domain.c                |   4 +-
>  security/tomoyo/securityfs_if.c         |  15 +-
>  security/tomoyo/tomoyo.c                |  57 +++++--
>  26 files changed, 899 insertions(+), 435 deletions(-)
> 

-- 
James Morris
<jmorris@namei.org>

--1665246916-734686802-1536787774=:19741--
