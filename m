Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1825685-1518708491-2-3157183137840868569
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
    t=1518708490; b=mhQNlTzCEFosh3Gufev54HFU4+jHUNP3uP0yNUu3nEo7ip3
    Omlf33dc52ek2Idkjgi0BXYbz7iwxHgPy2MGR5tJa6AXoMOPZ0gA4eIh4s4zieac
    CODOFudt9ADi7NJ+VT4K2llrD0YcXbtKFFns+9lcevXC+2/srXqcsAYssVrWAtRy
    QDdd4XZYToJWikAe05moM89dmoOW6YmZP9XJAss0jjin4n6eyq6ou/I5pu8SVh97
    CJqiFgawTjz4GmKYMYJUVB+cHecXdc+w63j7O/Rneoeirv+GRlWXhhRNjsWCaEO3
    wCbKuFs1phzq1AGf6h33jBRIEIi1BWdiyPPxJlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518708490; bh=u55rjbYibP1PSrfQEGnRBcWQSc
    OJBqPJy5NtzhhDE4M=; b=Zr16LeUnbhD7LGc/IJz9Sz+nqC3YT96mzPl7J9CfKv
    zfuunotBO+beTNnAAl9EnJ8LS7WD4f+i7wnyjYrddBz+Lo2IrMJOBXUZiLtKGWti
    /ePTNdxCfodUKH4MWAV/04CoYgasm+vZdk4z8tmfXxr081HV16Q4YLMYXnC4a8dl
    bFTgEiUQVM/+qydqT5yXXAOX2TST0BoSYdgfCyLf+PYkpwwLP5BYouLt+HPXoxwh
    J1KeqQ89LpwIr3RzB2lULAJmxoA98JVsG6V1zZR4G7OdUuLaFzAmrMKYXnnl3oLN
    T7ZIXgFFO4NdxjKX5qfzYmrkXlkc9CsfFqUVjOerdlGQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163725AbeBOP2G (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:28:06 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:53722 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163693AbeBOP2E (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:28:04 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@primarydata.com>,
        Scott Mayhew <smayhew@redhat.com>
Subject: [PATCH 4.9 22/88] nfs/pnfs: fix nfs_direct_req ref leak when i/o falls back to the mds
Date: Thu, 15 Feb 2018 16:16:49 +0100
Message-Id: <20180215151225.750670993@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.437136975@linuxfoundation.org>
References: <20180215151222.437136975@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2145,7 +2145,7 @@ pnfs_write_through_mds(struct nfs_pageio
 		nfs_pageio_reset_write_mds(desc);
 		mirror->pg_recoalesce = 1;
 	}
-	hdr->release(hdr);
+	hdr->completion_ops->completion(hdr);
 }
 
 static enum pnfs_try_status
@@ -2256,7 +2256,7 @@ pnfs_read_through_mds(struct nfs_pageio_
 		nfs_pageio_reset_read_mds(desc);
 		mirror->pg_recoalesce = 1;
 	}
-	hdr->release(hdr);
+	hdr->completion_ops->completion(hdr);
 }
 
 /*
