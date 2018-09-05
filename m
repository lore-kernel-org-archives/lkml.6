Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A95E1C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 15:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5852920869
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 15:54:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5852920869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbeIEUZZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 16:25:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50448 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726189AbeIEUZZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 16:25:25 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B7D794007865;
        Wed,  5 Sep 2018 15:54:35 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 371D610DCF4B;
        Wed,  5 Sep 2018 15:54:27 +0000 (UTC)
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
        Takashi Iwai <tiwai@suse.com>, linux-bcache@vger.kernel.org,
        Coly Li <colyli@suse.de>, Jaroslav Kysela <perex@perex.cz>,
        Jan Harkes <jaharkes@cs.cmu.edu>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>,
        Jason Wang <jasowang@redhat.com>,
        Mat Martineau <mathew.j.martineau@linux.intel.com>,
        netfilter-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        moderated for non-subscribers <alsa-devel@alsa-project.org>,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dhowells@redhat.com
Date:   Wed, 05 Sep 2018 16:54:27 +0100
Message-ID: <153616286704.23468.584491117180383924.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 05 Sep 2018 15:54:35 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 05 Sep 2018 15:54:35 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Here's a set of patches that inserts a step into the build process to make
sure that the UAPI headers can all be built together with C++ (if the
compiler being used supports C++).  All but the final patch perform fixups,
including:

 (1) Fix member names that conflict with C++ reserved words by providing
     alternates that can be used anywhere.  An anonymous union is used so
     that that the conflicting name is still available outside of C++.

 (2) Fix the use of flexible arrays in structs that get embedded (which is
     illegal in C++).

 (3) Remove the use of internal kernel structs in UAPI structures.

 (4) Fix symbol collisions.

 (5) Replace usage of u32 and co. with __u32 and co.

 (6) Fix use of sparsely initialised arrays (which g++ doesn't implement).

 (7) Remove some use of PAGE_SIZE since this isn't valid outside of the
     kernel.

And lastly:

 (8) Compile all of the UAPI headers (with a few exceptions) together as
     C++ to catch new errors occurring as part of the regular build
     process.

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
      UAPI: coda: Don't use internal kernel structs in UAPI
      UAPI: netfilter: Fix symbol collision issues
      UAPI: nilfs2: Fix use of undefined byteswapping functions
      UAPI: sound: Fix use of u32 and co. in UAPI headers
      UAPI: ndctl: Fix g++-unsupported initialisation in headers
      UAPI: ndctl: Remove use of PAGE_SIZE
      UAPI: Check headers build for C++


 Makefile                                          |    1 
 include/linux/ndctl.h                             |   22 ++++
 include/uapi/drm/i810_drm.h                       |    7 +
 include/uapi/drm/msm_drm.h                        |    7 +
 include/uapi/linux/bcache.h                       |    2 
 include/uapi/linux/coda_psdev.h                   |    4 +
 include/uapi/linux/keyctl.h                       |    7 +
 include/uapi/linux/ndctl.h                        |   20 ++-
 include/uapi/linux/netfilter/nfnetlink_cthelper.h |    2 
 include/uapi/linux/netfilter_ipv4/ipt_ECN.h       |    9 --
 include/uapi/linux/nilfs2_ondisk.h                |   21 ++--
 include/uapi/linux/virtio_net.h                   |    7 +
 include/uapi/sound/skl-tplg-interface.h           |  106 +++++++++---------
 scripts/headers-c++.sh                            |  124 +++++++++++++++++++++
 14 files changed, 255 insertions(+), 84 deletions(-)
 create mode 100644 include/linux/ndctl.h
 create mode 100755 scripts/headers-c++.sh

