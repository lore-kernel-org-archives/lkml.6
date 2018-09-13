Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ECFCF81824
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA5862152A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 16:08:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA5862152A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbeIMVTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 17:19:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:64700 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727358AbeIMVTG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 17:19:06 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6B43F3680A;
        Thu, 13 Sep 2018 16:08:56 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 493755D6B3;
        Thu, 13 Sep 2018 16:08:55 +0000 (UTC)
Subject: [PATCH 0/6] afs: DNS and VL server handling improvements
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 13 Sep 2018 17:08:54 +0100
Message-ID: <153685493441.16086.3483582787020297039.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 13 Sep 2018 16:08:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Al,

Here's a set of patches that improves Volume Location server handling in
the AFS filesystem and improves the DNS resolver code to allow server lists
(with addresses, priorities and weights for each server).

The highlights of this patchset are:

 (1) Permit a binary blob to be attached to be attached to a dns_resolver
     type key in lieu of a text one.  The first byte of the payload must be
     0 to cause existing text parsers to error out with EINVAL.  However,
     the "server list" feature must be requested by putting "srv=1" into
     the callout info, which is passed to the upcall.

 (2) Clean up the address list handling in AFS.

 (3) Introduce a 'VL server list' concept in AFS with rotation, analogous
     to the fileserver list and rotation.  For the moment VL server
     rotation takes a simple round-robin approach and pays no attention to
     the priority and weight assigned to each server.

The patches will work as-is with the current keyutils package as the
"srv=1" option will just be ignored and a text list of addresses will be
used to instantiate the key.  The modified AFS code still handles this.

To make the server list feature work properly, the keyutils package will
need updating to 1.5.12, the proposed commits for which can be found here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/keyutils.git/log/?h=next

that will allow the program run by request-key to be overridden for
"afsdb:" dns_resolver keys by the kafs-client program.  The kafs-client
program changes to make server list resolving work can be found here:

	http://git.infradead.org/users/dhowells/kafs-client.git/shortlog/refs/heads/next

along with code to allow static configuration to be used instead.


The kernel patches can be found here also:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=afs-dns

David
---
David Howells (6):
      dns: Allow the dns resolver to retrieve a server set
      afs: Do better max capacity handling on address lists
      afs: afs_end_vnode_operation() needs to translate abort codes to errors
      afs: Differentiate VL servers
      afs: Always build address lists using the helper functions
      afs: Sort address lists so that they are in logical ascending order


 fs/afs/Makefile              |    2 
 fs/afs/addr_list.c           |  209 ++++++++++++++----------------
 fs/afs/cell.c                |   39 +++---
 fs/afs/dynroot.c             |    2 
 fs/afs/internal.h            |  114 ++++++++++++++---
 fs/afs/proc.c                |   44 +++---
 fs/afs/rotate.c              |    6 -
 fs/afs/server.c              |   42 ++----
 fs/afs/vl_list.c             |  289 ++++++++++++++++++++++++++++++++++++++++++
 fs/afs/vl_rotate.c           |  239 +++++++++++++++++++++++++++++++++++
 fs/afs/vlclient.c            |   32 ++---
 fs/afs/volume.c              |   52 ++------
 net/dns_resolver/dns_key.c   |   61 ++++++++-
 net/dns_resolver/dns_query.c |    5 -
 14 files changed, 866 insertions(+), 270 deletions(-)
 create mode 100644 fs/afs/vl_list.c
 create mode 100644 fs/afs/vl_rotate.c

