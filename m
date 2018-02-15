Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227QZL/Gg1IEHgHk6hZiRiGlaCVoXOWxurSkh85PQVbOe3tcC9uGN8o5V/8HSwRlAnlFjsx9
ARC-Seal: i=1; a=rsa-sha256; t=1518708495; cv=none;
        d=google.com; s=arc-20160816;
        b=CZ+fyQiQ4pVW+P5tBJoBg00YJXwfbOCVKqkY5CnztjyOuBIFxQk9uHCc2efkzMFebR
         /l1/cx70jobi5EyGqhkcoxcq0JsNmR59XJT8CUnmgMSk0P8PHaEmq7H4wBMDNi8tFDt7
         n9K1WheMEdrrybrf1XGTg+0Umnwg1PefT2d50z0boelBpg1MsXV1jKTHKYVyzLpgY8u3
         Z2LtU4QlpXO0ZW6eZEodYDm+TseBO964K/lV2gMVs1Y017IxZpsM+JsAB84t/oRCdw6K
         QZ4HMIbzEcZKDGH1/2/fn8OlcakHdgO4yQayYCGaLkjeE7l6aUutFYIObK992SKqbK9a
         WxRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=wHR42FEeuCFbKrhbn5cfVqSYlNQS9rRrty6z1lzw+J4=;
        b=yFm+E90PSlQESk+O9GfqnvKETCwT2burl+nMH/WmcCM495j3ydu8o7P9OdcZs1/tDl
         vZAKqfJVHny3BfZ6k77tSvBEt2sLDR+SQoVJ08NHOdyJPKTQDCGb2jmHtJVkQhq8MMOI
         HJiftxGkzXbFVhVooPngAkala3lKggD2qJXeWxq8dm4mpBDtQkyKY5Zssz4taIphSkVd
         S443SF2zGr2nncs9iy8qR6/B2vIqtHWBMHDbG8z2lenXe0w06yc1GzVuzltFL+kcoZEa
         HLbmZVSRVT7kpdYqffdnvt1gfgqGLZkVLU9FOWQ5M40pMry8NaSs/mmDUlUhD/0o4QMk
         /Jcw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Trond Myklebust <trond.myklebust@primarydata.com>
Subject: [PATCH 4.9 26/88] NFS: Fix a race between mmap() and O_DIRECT
Date: Thu, 15 Feb 2018 16:16:53 +0100
Message-Id: <20180215151226.311791271@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.437136975@linuxfoundation.org>
References: <20180215151222.437136975@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481280163816585?=
X-GMAIL-MSGID: =?utf-8?q?1592481280163816585?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -98,7 +98,7 @@ static void nfs_block_buffered(struct nf
 {
 	if (!test_bit(NFS_INO_ODIRECT, &nfsi->flags)) {
 		set_bit(NFS_INO_ODIRECT, &nfsi->flags);
-		nfs_wb_all(inode);
+		nfs_sync_mapping(inode->i_mapping);
 	}
 }
 
