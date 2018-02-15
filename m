Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225hGb/y3cslUWCmcDlG661Vd4dKaJ46+SnUZcErjNeEeV2jmxNBzfj4LtXOkjESZkaySXWt
ARC-Seal: i=1; a=rsa-sha256; t=1518709375; cv=none;
        d=google.com; s=arc-20160816;
        b=ymoqBFhvGSnuGnTQojUE4sXNSfAYO18u6UqI8D2Ak47V2HtCWjytmZaTBQgpw6YV/6
         lkxDld2hJB9ijHDT5jH8N2wjNqFQwlGyxZuF3Xm87pGTmOb3VelIJOOYK+Vpk/iEg7hG
         Y3EwjtlxIo/9BCmvjj3V6D2lVGbdJ+bJbwGUAlIsG+1jIvFhq0bxaKVP8gTiokB1B0da
         Qv/3V0qch75NYbtC3JeJVP3TDDKebYT8UGwDQKHD8yiZtr/uOj0B0eEQsxtauzH4QFHB
         xL+On8ZGmMVOE1BR22UBZ9kYQnwOCt4qWlFuEuFIFCBgDuu1yKSEzzLQvMJUMUJbAQwo
         gPbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=M1Y/c1mR2lF9ZfTl8iMfOGJi74m5vFTr9g8rskBCLJM=;
        b=u2Q6j9TYycDuICPQ1qyrVMS6CZWOSMR4pwq2DV57LIR0xA/h00sn2TUOQGGaN/rXMk
         C7cV1Pl7nPStydXL2e5OBGavj1yiRRkLQvBFvSTSh/nR5lzOdvbxqAgUyt720V52nnR5
         uPzVEJHxfpJdj65dBi1h1AJgTLNCmV54bglv45z2T7gX9RY+nHAaXysmTnM3WxXTiofk
         ISiRzKdSFQxTNFLh+/Z8PfS/hwf31PCxudJFcPZkLXpoyi2+C7xYQuDl3RVxm6xCkREs
         9vpG3eB+mihDCDpECmFe+X3Yu3Z8/lUKumV9eH9hrIpKwkh+r9+XuQnKLIHmHmpAsr/U
         x7gA==
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
Subject: [PATCH 4.15 096/202] nfs/pnfs: fix nfs_direct_req ref leak when i/o falls back to the mds
Date: Thu, 15 Feb 2018 16:16:36 +0100
Message-Id: <20180215151718.388606263@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480967189767317?=
X-GMAIL-MSGID: =?utf-8?q?1592482202598203476?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2255,7 +2255,7 @@ pnfs_write_through_mds(struct nfs_pageio
 		nfs_pageio_reset_write_mds(desc);
 		mirror->pg_recoalesce = 1;
 	}
-	hdr->release(hdr);
+	hdr->completion_ops->completion(hdr);
 }
 
 static enum pnfs_try_status
@@ -2378,7 +2378,7 @@ pnfs_read_through_mds(struct nfs_pageio_
 		nfs_pageio_reset_read_mds(desc);
 		mirror->pg_recoalesce = 1;
 	}
-	hdr->release(hdr);
+	hdr->completion_ops->completion(hdr);
 }
 
 /*
