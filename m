Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224PCQzemqzxucN2vTFYCOHJD8ElNmoqaVoBLlnQFaL8Ff15ovdUYsy+P+7QjHUQBIxO7wWD
ARC-Seal: i=1; a=rsa-sha256; t=1518707971; cv=none;
        d=google.com; s=arc-20160816;
        b=rfESEG4NJJcp4cnt9rYhgXpg2Xvbxv9DUC9nNbcRyw/spQqXGxXfdg24g8WMa5P9zu
         B9+tKX9cVY9+NdyTXDUxeSl24uz9PaEqnjqDgajjGqXp5UXpqJGPUlLfocLior4Vr57E
         Tbcemg6AB6Sk48CFSWBIBBBJtxUfzwvPi1+yFySb0G7RxXgMtHNfWz/k1uN3v8ldMiGZ
         eHkAawxFHPfcM6+dVzDhYvCfeIIOtyRq3G78+1OvHig0riBuJEEXgj1mpTqY+tS9yrnC
         wR8N9HESAZC1jiZvPJLivnFuJt6g+nbbNXAkUheKesDOXWZGgXE71Vf0cjnI+DqUW2/X
         FhWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Scq8gNRBvZUxKmTqvSavmrGR0DU3+qukXOm/ew9YDMU=;
        b=DHHmcFMs1pcQPcbbYQ61PtrMDyoj1sy1AOcj/mec01ygNSOmhUmXABukuPfTukOMKc
         xo0h3iBHXoRh+vtI8TVYzPCi+XRKixMh3zjQ3GpToSSIkf+tY12DszwW4T0E3Wt73KxZ
         FHjnW13kWJN4LS53DYvUzhmBLGoDS15LQzwM0U9tTdMrDARS5EavMVTaIs5NxkSPDL/R
         IWVS7VoJybXG2s7Ydt2KQg+AFPwuO8TkzwpPqXZypQKQy0yxxHbSlpqOCDdMZuPQU+yx
         8QrUnFMJDfkEGfjQs68IXSsEvCVebNl45cDoCEnVwiGl1G8Lwa3fU6chWRkHFiAoyBve
         w5dQ==
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
Subject: [PATCH 3.18 29/45] NFS: commit direct writes even if they fail partially
Date: Thu, 15 Feb 2018 16:17:20 +0100
Message-Id: <20180215144122.206005137@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215144115.863307741@linuxfoundation.org>
References: <20180215144115.863307741@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480730180404338?=
X-GMAIL-MSGID: =?utf-8?q?1592480730180404338?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -716,10 +716,8 @@ static void nfs_direct_write_completion(
 
 	spin_lock(&dreq->lock);
 
-	if (test_bit(NFS_IOHDR_ERROR, &hdr->flags)) {
-		dreq->flags = 0;
+	if (test_bit(NFS_IOHDR_ERROR, &hdr->flags))
 		dreq->error = hdr->error;
-	}
 	if (dreq->error == 0) {
 		dreq->count += hdr->good_bytes;
 		if (nfs_write_need_commit(hdr)) {
