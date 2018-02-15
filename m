Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2179907-1518720215-2-9335443988441020530
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518720213; b=jhBKnVC7qAUiv7IrGTm7AbrcWcl36QRXWVzPFIjpU/SYGUT
    vZfAzJpiU2oI9YMP3FHmN1URIRDalW+Y7tcN/qG7c/1wMbI/i5cEKSmOzJyzCl6A
    Y/anLl5fiOUETvaNf8QTxE4NS8lSsqgXXORIN5FOvgW8l8JZks+oHPaY7l4lN02R
    GYiMK/pStM6NpXXdURMhxqGpSqqUS7e1kBxsbSXTgfnBSRUKe2qfoeHeXrlIFVLV
    ZpkJrb2ctcI2X9eJ2vBpqtNpEwZc7pD3nV/aQ/eIlwIBF7oT+pwlCxg7OxsAFllJ
    4WUZO4L6c/7yxDo1WpbWleB7Zu8mN7VztlYz+qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518720213; bh=IyJLi3SMvLt75YnkD/yt/jyERW
    GCFDoR4cvpSuMk6kw=; b=CHs/ZN21rdsXOD2QZqLIr42zubTJSks5icngCgZIL3
    Rg3Th6uvgEZQZTGJI4/wpPdtZDMg6Ts0x1DQY1+m01nYADck3u82KrtPUMkOQV4J
    YJV905q0vGMx4IKleewc0blwJbP9GdkVwIcp813hnPRRb1iiAXyTAHEipIRM5zKg
    MMhkGxP/yOZj0fJ9Aeoezt32k+KNi6DnWiT8RiCahZageKevfczPsWzKqC0H018W
    hZQgWIYU/lck+EAhyrnynoEFycCOZ+7x4rWIUSij7njxRWhh5FOxAeLb0P2ZatLk
    0VPGNHvRu/BgoziaE1JB/1/91UkLc6aISo1Razox/jag==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162628AbeBOPXU (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:23:20 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:50864 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161910AbeBOPXQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:23:16 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@primarydata.com>,
        Scott Mayhew <smayhew@redhat.com>
Subject: [PATCH 4.4 059/108] nfs/pnfs: fix nfs_direct_req ref leak when i/o falls back to the mds
Date: Thu, 15 Feb 2018 16:16:56 +0100
Message-Id: <20180215151230.667868832@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.267507937@linuxfoundation.org>
References: <20180215151222.267507937@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Scott Mayhew <smayhew@redhat.com>

commit ba4a76f703ab7eb72941fdaac848502073d6e9ee upstream.

Currently when falling back to doing I/O through the MDS (via
pnfs_{read|write}_through_mds), the client frees the nfs_pgio_header
without releasing the reference taken on the dreq
via pnfs_generic_pg_{read|write}pages -> nfs_pgheader_init ->
nfs_direct_pgio_init.  It then takes another reference on the dreq via
nfs_generic_pg_pgios -> nfs_pgheader_init -> nfs_direct_pgio_init and
as a result the requester will become stuck in inode_dio_wait.  Once
that happens, other processes accessing the inode will become stuck as
well.

Ensure that pnfs_read_through_mds() and pnfs_write_through_mds() clean
up correctly by calling hdr->completion_ops->completion() instead of
calling hdr->release() directly.

This can be reproduced (sometimes) by performing "storage failover
takeover" commands on NetApp filer while doing direct I/O from a client.

This can also be reproduced using SystemTap to simulate a failure while
doing direct I/O from a client (from Dave Wysochanski
<dwysocha@redhat.com>):

stap -v -g -e 'probe module("nfs_layout_nfsv41_files").function("nfs4_fl_prepare_ds").return { $return=NULL; exit(); }'

Suggested-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Scott Mayhew <smayhew@redhat.com>
Fixes: 1ca018d28d ("pNFS: Fix a memory leak when attempted pnfs fails")
Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/nfs/pnfs.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -1943,7 +1943,7 @@ pnfs_write_through_mds(struct nfs_pageio
 		nfs_pageio_reset_write_mds(desc);
 		mirror->pg_recoalesce = 1;
 	}
-	hdr->release(hdr);
+	hdr->completion_ops->completion(hdr);
 }
 
 static enum pnfs_try_status
@@ -2058,7 +2058,7 @@ pnfs_read_through_mds(struct nfs_pageio_
 		nfs_pageio_reset_read_mds(desc);
 		mirror->pg_recoalesce = 1;
 	}
-	hdr->release(hdr);
+	hdr->completion_ops->completion(hdr);
 }
 
 /*
