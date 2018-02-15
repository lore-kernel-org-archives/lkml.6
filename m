Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227kWYAss/TO19bjrXbo65knOFsci4rUTWH82WtuHsRVUJyF80DsMtEb+d/zyeycLrBQUyxj
ARC-Seal: i=1; a=rsa-sha256; t=1518708847; cv=none;
        d=google.com; s=arc-20160816;
        b=dspve4J8ma041g1bF3+FRJot0R9XOdmhHYuWJ3u1MFi9GdCuuyPjDnNYY/1lEezRDm
         voQLRiZTVx+EF68w3xxUdgpU6qwoGHQeN2xqw4HcPSfyNKH8jJlmizCuREeVbOAoZoB/
         Expcv/ShWTMRx0ENRcecgIrhvjdt0UGy4IA94REwbKix6+ZI3v3gXPCrUtgTLPiTIBIW
         zI7wiRTpTL0AJ0yCE39CBH/2G478GSzoaOyYcL5AmNGc3a+T2qCFsUGkdNKBV66mP7bU
         zMznjDzcayfg1xfX9FaftnB8XBIZ3o0h0rYkibZYqJb1FkR+c328BXqFXlBNeDu4hDwn
         7X5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=lkTK7arZPBERR44bPgEyQR79DShybcOgNs9DAJhvN48=;
        b=wuO0cN0AnxTHTgGmqcrT/Y8ocCr45rkOc4kDzBYzHRfnn3bB/blfexaZH2ERLF57Kz
         Rixs/k0JPq4B/KO4o/1pXvmvjYJ6H51/a2Obonxg93g53RqIKF4gT7hQnbBBjf21gmza
         X1HRCZWzkh5CkudoovaPNslwS5JFnHm6bo2UaaSlsnf3l3hM9AY5e1oHd9MPQcKDNHiX
         nGF9zyW/T/mIoF4mk6mNIXdYOqGZLpPZqLMZDAStCWBNInu3IanoJwYkguHvb730MAo+
         A38/Qbj0c5/rlkFqxchxvJKchV8WOGq/4jEfc2tkqC4bFyuDolvJFBBITO8fwIJDZoXI
         rs4Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Trond Myklebust <trond.myklebust@primarydata.com>,
	Scott Mayhew <smayhew@redhat.com>
Subject: [PATCH 4.14 103/195] nfs/pnfs: fix nfs_direct_req ref leak when i/o falls back to the mds
Date: Thu, 15 Feb 2018 16:16:34 +0100
Message-Id: <20180215151710.833318054@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480967189767317?=
X-GMAIL-MSGID: =?utf-8?q?1592481648956185801?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2237,7 +2237,7 @@ pnfs_write_through_mds(struct nfs_pageio
 		nfs_pageio_reset_write_mds(desc);
 		mirror->pg_recoalesce = 1;
 	}
-	hdr->release(hdr);
+	hdr->completion_ops->completion(hdr);
 }
 
 static enum pnfs_try_status
@@ -2360,7 +2360,7 @@ pnfs_read_through_mds(struct nfs_pageio_
 		nfs_pageio_reset_read_mds(desc);
 		mirror->pg_recoalesce = 1;
 	}
-	hdr->release(hdr);
+	hdr->completion_ops->completion(hdr);
 }
 
 /*
