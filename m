Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABBC5C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45684206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:18:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45684206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbeIFNw6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 09:52:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49886 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726541AbeIFNw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 09:52:57 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 431A9402332F;
        Thu,  6 Sep 2018 09:18:24 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B8C2D94646;
        Thu,  6 Sep 2018 09:18:17 +0000 (UTC)
Subject: [RFC] UAPI: Check headers by compiling all together as C++
From:   David Howells <dhowells@redhat.com>
To:     linux-api@vger.kernel.org, linux-kbuild@vger.kernel.org
Cc:     Michal Marek <michal.lkml@markovi.net>,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        keyrings@vger.kernel.org, David Airlie <airlied@linux.ie>,
        linux-nilfs@vger.kernel.org, linux-nvdimm@lists.01.org,
        "Michael S. Tsirkin" <mst@redhat.com>, codalist@coda.cs.cmu.edu,
        coda@cs.cmu.edu, coreteam@netfilter.org,
        Rob Clark <robdclark@gmail.com>, linux-arm-msm@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-bcache@vger.kernel.org, Coly Li <colyli@suse.de>,
        Jan Harkes <jaharkes@cs.cmu.edu>,
        Yann Droneaud <ydroneaud@opteya.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>,
        Jason Wang <jasowang@redhat.com>,
        Mat Martineau <mathew.j.martineau@linux.intel.com>,
        netfilter-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dhowells@redhat.com
Date:   Thu, 06 Sep 2018 10:18:17 +0100
Message-ID: <153622549721.14298.8116794954073122489.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 06 Sep 2018 09:18:24 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 06 Sep 2018 09:18:24 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Here's a set of patches that inserts a step into the build process to make
sure that the UAPI headers can all be built together with C++ (if the
compiler being used supports C++).

Note that it's based on a commit from the sound tree to fix usage of u32
and co..

Most of the patches perform fixups, including:

 (1) Fix member names that conflict with C++ reserved words by providing
     alternates that can be used anywhere.  An anonymous union is used so
     that that the conflicting name is still available outside of C++.

 (2) Fix the use of flexible arrays in structs that get embedded (which is
     illegal in C++).

 (3) Remove the use of internal kernel structs in UAPI structures.

 (4) Fix symbol collisions.

 (5) Fix use of sparsely initialised arrays (which g++ doesn't implement).

 (6) Remove some use of PAGE_SIZE since this isn't valid outside of the
     kernel.

There's also:

 (7) Move the coda_psdev.h header file to fs/coda/.

And lastly:

 (8) Compile all of the UAPI headers (with a few exceptions) together as
     C++ to catch new errors occurring as part of the regular build
     process.

Changes for v2:

 - Merge commit from sound tree to fix u32 usage issues
 - Use a switch to fix sparse array initialisation
 - Simplify nilfs2 by performing bitwise ops in LE space not CPU space
 - Handle conflicting fix to use of 'private' in keyctl.h
 - Move kernel internal coda bits to coda internal headers
 - Move coda_psdev.h header to fs/coda/.

The patches can also be found here:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=uapi-check

Thanks,
David
---
David Howells (11):
      UAPI: drm: Fix use of C++ keywords as structural members
      UAPI: keys: Fix use of C++ keywords as structural members
      UAPI: virtio_net: Fix use of C++ keywords as structural members
      UAPI: bcache: Fix use of embedded flexible array
      UAPI: coda: Move kernel internals out of public view
      coda: Move internal defs out of include/linux/
      UAPI: netfilter: Fix symbol collision issues
      UAPI: nilfs2: Fix use of undefined byteswapping functions
      UAPI: ndctl: Fix g++-unsupported initialisation in headers
      UAPI: ndctl: Remove use of PAGE_SIZE
      UAPI: Check headers build for C++


 Makefile                                          |    1 
 fs/coda/cache.c                                   |    2 
 fs/coda/cnode.c                                   |    2 
 fs/coda/coda_linux.c                              |    2 
 fs/coda/coda_psdev.h                              |   88 +++++++++++++++
 fs/coda/dir.c                                     |    2 
 fs/coda/file.c                                    |    3 -
 fs/coda/inode.c                                   |    2 
 fs/coda/pioctl.c                                  |    3 -
 fs/coda/psdev.c                                   |    3 -
 fs/coda/symlink.c                                 |    3 -
 fs/coda/upcall.c                                  |    2 
 include/linux/coda_psdev.h                        |   72 ------------
 include/linux/ndctl.h                             |   22 ++++
 include/uapi/drm/i810_drm.h                       |    7 +
 include/uapi/drm/msm_drm.h                        |    7 +
 include/uapi/linux/bcache.h                       |    2 
 include/uapi/linux/coda_psdev.h                   |   18 ---
 include/uapi/linux/keyctl.h                       |    7 +
 include/uapi/linux/ndctl.h                        |   52 ++++-----
 include/uapi/linux/netfilter/nfnetlink_cthelper.h |    2 
 include/uapi/linux/netfilter_ipv4/ipt_ECN.h       |    9 --
 include/uapi/linux/nilfs2_ondisk.h                |   28 ++---
 include/uapi/linux/virtio_net.h                   |    7 +
 scripts/headers-c++.sh                            |  124 +++++++++++++++++++++
 25 files changed, 304 insertions(+), 166 deletions(-)
 create mode 100644 fs/coda/coda_psdev.h
 delete mode 100644 include/linux/coda_psdev.h
 create mode 100644 include/linux/ndctl.h
 create mode 100755 scripts/headers-c++.sh

