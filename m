Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2240LSDDwT9iSfP2YP5J3/LpS7I+rvQOhf50Q6dof7kVYPGb5mhS30EjyZEuqBxMCtFslhPO
ARC-Seal: i=1; a=rsa-sha256; t=1518708490; cv=none;
        d=google.com; s=arc-20160816;
        b=c0ziTIWjCjgXV4pjPexbtLuO02LHsHH4qbU1aOtqdIXeCOV7Z7/ncWTJxU1EbNgHEu
         JOdCNsbyvj+jnlRc7I0tS/kej1eWPh72Qyj0T2z49A+lSeFGFAcFA31O9gqJge1t46sK
         puadtquAoS38NtNcnao8+JmRdjD5TNtMF8iR9VnGSGY/qywHF9B0e/lP4aae8Td+4xnh
         SwCENQMF7AvpzU2hJmyt2CFFBWeKAHv2zZkT6G1A7qutTYt6hlR1MfsX0HYw1GvNIWce
         Q8kz2X5cIrS5OkPBN1ZQgJcKburiiT7mn7Nlj5AOpRREY8mVIf58b0bozlEE+QmVRncE
         ZnaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=9pJdzQdPeYS287d48gUla4klZOfPZ6A4pRaIiZdW0oI=;
        b=gZV1oXQ2Xy0yAQaD6sCa4JoTCH9UWb7gSFB/dXWLrmIE9Hyy622aiyf07j3upAy5PG
         Xd9hGs0hCTHpgXaEUzZGaFRnYsqNGfGrnhBEflwRtzvzinGNMNMq2iWSEnUVohlJuO0i
         ALYhP0ESgIpbdM8Cxr3iKVmZC1HkB9PnJ+nU5FdyMvPQuA418eYyXAgQ14fUf7E2jh5+
         4nibVsrEoqNM7AoQtpeBqL1CluEHqcWRIYlA0fg9RoTCZHp/x+VUyZlIW356MlPfXKPk
         SkcpM38n5dteT6MYBrk55VlVaepeyCQC6E+0rhP/i9GpH8DpX77HX5vgwd7DNq6PTIGr
         v16g==
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
Subject: [PATCH 4.9 24/88] NFS: commit direct writes even if they fail partially
Date: Thu, 15 Feb 2018 16:16:51 +0100
Message-Id: <20180215151226.012002344@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.437136975@linuxfoundation.org>
References: <20180215151222.437136975@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480730180404338?=
X-GMAIL-MSGID: =?utf-8?q?1592481274279023747?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -787,10 +787,8 @@ static void nfs_direct_write_completion(
 
 	spin_lock(&dreq->lock);
 
-	if (test_bit(NFS_IOHDR_ERROR, &hdr->flags)) {
-		dreq->flags = 0;
+	if (test_bit(NFS_IOHDR_ERROR, &hdr->flags))
 		dreq->error = hdr->error;
-	}
 	if (dreq->error == 0) {
 		nfs_direct_good_bytes(dreq, hdr);
 		if (nfs_write_need_commit(hdr)) {
