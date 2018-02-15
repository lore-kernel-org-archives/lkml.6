Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2269tqwtx9m9R+YFIE7JmeJzaJAU776uAAAY+Nr55iQFPX8ENOm6Cgy1gkmKWVDVOXKgSlnj
ARC-Seal: i=1; a=rsa-sha256; t=1518709393; cv=none;
        d=google.com; s=arc-20160816;
        b=ff3/RMZU4Fx6rmWSGOUqwmF7UG7kuX3vr60qpA7iSDgO9qxX8WbL6o0H//kl//zemS
         MioPpHR9uabxFv59KNoTFVbKAmAuR5nIN8Lr4e3CMpERHJwfD5+6/aguZuvgjN2F6Evj
         WDCz7YgAtXX6PKTkXcuK/DwmRVNAYuHOVutTFd7n5J79g6l7ZML4w8jrdasGWxe77/qB
         jqf89oQEIptzHtEb05LvZl4C5zCsxl65D1PLD+0lajaNa3RkEV3Z/m5JhZtj4skHCJjP
         bBATzMkRkwkO8DBwnWioOZqoM+mYqO5ZT1WCxGHzMr8MnM3ACuRng37qBe5/o6XnEtqY
         lu/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=WGp3g6B+7Q8JLNiiV2EU765747deKJp+alYFksimKBM=;
        b=txubfUiap+CllwM3T3XukETFOdY0Qcp/Rre3cn5e6ILIy/L9YN72sOjgf47Ro9uiZB
         HPXww9aHTQL5Nkh3nxgz3j2mUG0vrfkoq2XnNPIVZf8LZFRbDrxDB1B9CT1EMG7pnJl7
         VdbEbczclCDiHuWyoUI73WYNmQrt3XPr8emNwyzpWJK8B4amVT6gjqk4fT9sehGas05M
         PHSoanxqlXxd7OTome2SQC4nQMBTmVjxFLct0rczoqz45oJshKseITxWt4eYoW0t9rbf
         dQAt0ElR49BwY1HJFAxX7OMGa+hcJkgRr2bkPR0t0RJikwy3SVF5NzAR95N5w2cOCskG
         brrg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Trond Myklebust <trond.myklebust@primarydata.com>
Subject: [PATCH 4.15 102/202] NFS: Fix a race between mmap() and O_DIRECT
Date: Thu, 15 Feb 2018 16:16:42 +0100
Message-Id: <20180215151718.630262423@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481280163816585?=
X-GMAIL-MSGID: =?utf-8?q?1592482220965824292?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Trond Myklebust <trond.myklebust@primarydata.com>

commit e231c6879cfd44e4fffd384bb6dd7d313249a523 upstream.

When locking the file in order to do O_DIRECT on it, we must unmap
any mmapped ranges on the pagecache so that we can flush out the
dirty data.

Fixes: a5864c999de67 ("NFS: Do not serialise O_DIRECT reads and writes")
Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/nfs/io.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/nfs/io.c
+++ b/fs/nfs/io.c
@@ -99,7 +99,7 @@ static void nfs_block_buffered(struct nf
 {
 	if (!test_bit(NFS_INO_ODIRECT, &nfsi->flags)) {
 		set_bit(NFS_INO_ODIRECT, &nfsi->flags);
-		nfs_wb_all(inode);
+		nfs_sync_mapping(inode->i_mapping);
 	}
 }
 
