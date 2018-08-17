Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E2EC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 02:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C4C32098B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 02:33:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C4C32098B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbeHQFe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 01:34:56 -0400
Received: from nautica.notk.org ([91.121.71.147]:57634 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725833AbeHQFe4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 01:34:56 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 0A1DEC009; Fri, 17 Aug 2018 04:33:22 +0200 (CEST)
Date:   Fri, 17 Aug 2018 04:33:07 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [GIT PULL] 9p updates for 4.19
Message-ID: <20180817023307.GA32726@nautica>
References: <20180813012347.GA32555@nautica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180813012347.GA32555@nautica>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

9p has seen some recent surge of activity recently and I've stepped up
to help maintaining 9p; please let me know if there are things to
improve in how I do things.
In particular, the gpg key I used to sign the tag is getting rather old
(1024 bit dsa is considered weak nowadays) and I will have a newer key
ready for 4.20, but I didn't think I would be able to gather signatures
for 4.19 so went for this one for now. Sorry for that.

I've rebased the branch at the start of the week to add some stable Cc
but all the patches have been in linux-next for two weeks, and all
transports have been tested since the rebase (thanks to Stefano
Stabellini for xen!)


The following changes since commit 94710cac0ef4ee177a63b5227664b38c95bbf703:

  Linux 4.18 (2018-08-12 13:41:04 -0700)

are available in the Git repository at:

  git://github.com/martinetd/linux tags/9p-for-4.19-2

for you to fetch changes up to edcd9d977354304cb85aee61c2b96809edce41ed:

  net/9p/trans_virtio.c: add null terminal for mount tag (2018-08-13 09:34:58 +0900)

----------------------------------------------------------------
Pull request for inclusion in 4.19 for 9p

Contains mostly fixes (6 to be backported to stable) and a few changes,
here is the breakdown:
 * Rework how fids are attributed by replacing some custom tracking in a
list by an idr (f28cdf0430fc)
 * For packet-based transports (virtio/rdma) validate that the packet
length matches what the header says (f984579a01d8)
 * A few race condition fixes found by syzkaller (9f476d7c540c,
430ac66eb4c5)
 * Missing argument check when NULL device is passed in sys_mount
(10aa14527f45)
 * A few virtio fixes (23cba9cbde0b, 31934da81036, d28c756caee6)
 * Some spelling and style fixes

----------------------------------------------------------------
Chirantan Ekbote (1):
      9p/net: Fix zero-copy path in the 9p virtio transport

Colin Ian King (1):
      fs/9p/v9fs.c: fix spelling mistake "Uknown" -> "Unknown"

Jean-Philippe Brucker (1):
      net/9p: fix error path of p9_virtio_probe

Matthew Wilcox (4):
      9p: Fix comment on smp_wmb
      9p: Change p9_fid_create calling convention
      9p: Replace the fidlist with an IDR
      9p: Embed wait_queue_head into p9_req_t

Souptick Joarder (1):
      fs/9p/vfs_file.c: use new return type vm_fault_t

Stephen Hemminger (1):
      9p: fix whitespace issues

Tomas Bortoli (5):
      net/9p/client.c: version pointer uninitialized
      net/9p/trans_fd.c: fix race-condition by flushing workqueue before the kfree()
      net/9p/trans_fd.c: fix race by holding the lock
      9p: validate PDU length
      9p: fix multiple NULL-pointer-dereferences

jiangyiwen (2):
      net/9p/virtio: Fix hard lockup in req_done
      9p/virtio: fix off-by-one error in sg list bounds check

piaojun (5):
      net/9p/client.c: add missing '\n' at the end of p9_debug()
      9p/net/protocol.c: return -ENOMEM when kmalloc() failed
      net/9p/trans_virtio.c: fix some spell mistakes in comments
      fs/9p/xattr.c: catch the error of p9_client_clunk when setting xattr failed
      net/9p/trans_virtio.c: add null terminal for mount tag

 fs/9p/v9fs.c            |   2 +-
 fs/9p/vfs_file.c        |   2 +-
 fs/9p/xattr.c           |   6 ++-
 include/net/9p/client.h |  11 ++---
 net/9p/client.c         | 119 ++++++++++++++++++++----------------------------
 net/9p/protocol.c       |   2 +-
 net/9p/trans_fd.c       |  22 ++++++---
 net/9p/trans_rdma.c     |   4 ++
 net/9p/trans_virtio.c   |  66 ++++++++++++++++-----------
 net/9p/trans_xen.c      |   3 ++
 net/9p/util.c           |   1 -
 11 files changed, 122 insertions(+), 116 deletions(-)
-- 
Dominique Martinet
