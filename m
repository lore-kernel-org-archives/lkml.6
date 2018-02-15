Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225WEdT4hbG+lnRP0ilLrnHsEIipkF0qjxin/X8ZcT22Ob3wvjijdPtevu46TK82VdP2v6pp
ARC-Seal: i=1; a=rsa-sha256; t=1518708866; cv=none;
        d=google.com; s=arc-20160816;
        b=cApoURBXIyGZYUBjMWig4CvY/ixdCr4qUL6Vpw2WhRoDkA0QODDlS7WPm5tiA0Esig
         m0fmX/dpGzV3VaNms/ZFqkCEaVl0YowGdATOCB1ARMKgfLDFizAF6IGTwLTwvTc2gJmE
         vH/mWWha/9NNUYviJ0nfWHWEpl3urNrwhOjp6Tp/UEZc1qGEF9b9w0aAtbjFUkfGMxXb
         3cZX9YwpcJmfU74eZSh16A1G6WFQ+Ow7kzs1M7/CfIXO48NkZB60T59eCa7/E/LgYZtR
         hZDCKFl+A0CmJ7L50W8N7NVMQm6a1K5cgUZ/KogSwbdrGvXSeW7/Zf5A08b2AxYTZTVJ
         kr+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=+FJdRzyyKIJBF/vd0Dh1pDFQrEJkKYUv6qlES4ZmbgM=;
        b=a6EDURmLeRmEWN64l3F1DByFo/OKfbUyPaS2s4VNku8T6330pz9aAGBOtOAndlBqVx
         3uoZ2X38/7DYA4yNt3Z/H8d8FNC0XRGZZeAi650wrly2SYVmsOeCCyGEBtkpL096qL4k
         on+gA2nqF+owYlEf9pA2O7ibsRd8fHAZTmKaF5KlSCQYDi1iRdxDyxTT2t1ev5vlaglm
         sstn6OrAxpEbd4zqpKvsS+kw1poiJHoa4c2YZn2Lid0daf0CSHmH7rrVtiSQpz51hVtg
         joZqjm5PbTb7IMrQsEKXb6uhD1RPBL6IR2b98gZ6jP0OfQNSRmTE7gBFzxjYX96ApVnL
         VLRg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Trond Myklebust <trond.myklebust@primarydata.com>
Subject: [PATCH 4.14 109/195] NFS: Fix a race between mmap() and O_DIRECT
Date: Thu, 15 Feb 2018 16:16:40 +0100
Message-Id: <20180215151711.138931942@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481280163816585?=
X-GMAIL-MSGID: =?utf-8?q?1592481668806518769?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
 
