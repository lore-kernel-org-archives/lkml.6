Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224SBzu72VOXqdpSNP2WrZGa+wl2rvFaM/mCYi4QixqgW9zxFdC6byWIG1Dxs8aW+gv7b6hT
ARC-Seal: i=1; a=rsa-sha256; t=1518708861; cv=none;
        d=google.com; s=arc-20160816;
        b=oRvifA6R8PGTRHlOJ0bO3J7DT7G7dL1/24iwoycMxf6A1KV+SztOFQuj8i0mBt6gQX
         0DGf1SYj4XSypMQn9L4YiJcXv8b60mi85TqY460RaKZRxYWYLmVvRfO2A2dvRRZkJRZb
         QzdVndKQGFGtJa/jiOROd7zBdyEE8DIS+UXDvv6vNX+hf/Katep0al2+Vd176qPBlNrG
         81E+7+58ErwgEOu7r+TCgxoS+bLvCuaij85dicH3j/MvUoeVHOr6et8S+c5kSI+cbnEv
         20UzR0jwV1r2p2kiMolOViADvtfDn5j2dLi0L4bh2vbxDYuMyV5EJNUq5chQFr0LIdQX
         0nfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=4qFmkgYWEiiQYanUJ8Rwbi3qUjHHc+YSGAr3sIoWLH8=;
        b=nN7udw8YpE5+b8hW0XDwkgaHf5+XYmAorbT77SWnrgZ4pLtoA6EeAeTXz/qo2wXrx5
         /byxo05PQPMhRKunHBMeZsHjKu6S614CMlJ8OYzazTalKVS/1T8khWo2hKIkuPsNFU17
         BxpAuoVLWiZb2WFXz204DYO/FxpxrX6bzlG43lzVaFD7Q6qaYG9v5GkconLdlECiL95f
         gA2+J96bHrpGZ6DPDz1GcCbIJXUyI2LJBLDt0fsnz91x+OS3XqoZk41QUwgNc3LH66S6
         ko+XFCZRT3g/9Elx6D26OERUlTqdm9tkiq5/gMjc/1u+7SdLvfUkSWfx3zXH1DyBUW68
         t/OA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"J. Bruce Fields" <bfields@redhat.com>,
	Trond Myklebust <trond.myklebust@primarydata.com>
Subject: [PATCH 4.14 107/195] NFS: commit direct writes even if they fail partially
Date: Thu, 15 Feb 2018 16:16:38 +0100
Message-Id: <20180215151711.045089736@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480730180404338?=
X-GMAIL-MSGID: =?utf-8?q?1592481662839781217?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: J. Bruce Fields <bfields@redhat.com>

commit 1b8d97b0a837beaf48a8449955b52c650a7114b4 upstream.

If some of the WRITE calls making up an O_DIRECT write syscall fail,
we neglect to commit, even if some of the WRITEs succeed.

We also depend on the commit code to free the reference count on the
nfs_page taken in the "if (request_commit)" case at the end of
nfs_direct_write_completion().  The problem was originally noticed
because ENOSPC's encountered partway through a write would result in a
closed file being sillyrenamed when it should have been unlinked.

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/nfs/direct.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -775,10 +775,8 @@ static void nfs_direct_write_completion(
 
 	spin_lock(&dreq->lock);
 
-	if (test_bit(NFS_IOHDR_ERROR, &hdr->flags)) {
-		dreq->flags = 0;
+	if (test_bit(NFS_IOHDR_ERROR, &hdr->flags))
 		dreq->error = hdr->error;
-	}
 	if (dreq->error == 0) {
 		nfs_direct_good_bytes(dreq, hdr);
 		if (nfs_write_need_commit(hdr)) {
