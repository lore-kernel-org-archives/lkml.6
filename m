Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224/Zu68LM5QQh5Xrr4EOW6Wd7Plk+lN7iLL0nEkHq3VHqsevZgiOy6ADEXJmI4lXbWFaPp/
ARC-Seal: i=1; a=rsa-sha256; t=1518708853; cv=none;
        d=google.com; s=arc-20160816;
        b=ern7BfAxzc+KE/AdoyOXGqf9KuVIUkG69ZTTi35IMHunm/i7lAi1QAWd+hbehCXpSo
         qoy6S+LCJD0EqdSNqpVRQnUzVFhNzpfuX2nEULlTAfJaI329XFJ9GfpokT8oZk/FXja7
         qIwew2HoeIP9HkknSzgdeMwalHv3JHJUWWi3NARoD9pa7Fvf0dREXHnYUG3qkkG7ypHX
         U1TjKIgQRcOPkJlhx7o7OX7yE7mKhyxRPUKjxan6MJpAbkTkNGpoi+03NY2dVbJxtK8S
         c7mf4XzPESbb1SVfQvTd3qocBD2bG807ibRcRkJyCa8MkYh/uRHxRffA88ih9E9FBCDP
         Zk/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=2Rq6xmvtbDmBInrebPKZi8XeavhjYuri0lwNmRW85TM=;
        b=Qmk1l/NSONfXkNJJWGUV/VIE5hG3BeW44kahZSF+Nglb1K4E4BpzDiYqg1zJSrTLUm
         69pGhVuRHkwVkdGgU6zvwyxKJewT/JaxYo7mpdt4BoNsB8e8fi/Xm4U0n7MhhWZmdlUZ
         3x9z2VRDH17a/imId4E4xoLbt4SfGTngtWgb6xIjzuCmav/WoAxS/zZeYC4f6Rh98KvY
         /ehkVmogxl9mD5kfQma/c5PL14tdpYLErbQzU231tm6wT3XVXcefIXkYXRYX4qvqdPec
         qrcxykul27HLkTZ/OLTC1De//rJ0qWB7DwuBtCrWE1/0kfOGHmdoN/1G5gWoefz60TW2
         BnFA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mike Galbraith <efault@gmx.de>,
	Trond Myklebust <trond.myklebust@primarydata.com>
Subject: [PATCH 4.14 105/195] NFS: Add a cond_resched() to nfs_commit_release_pages()
Date: Thu, 15 Feb 2018 16:16:36 +0100
Message-Id: <20180215151710.945599708@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480726935884245?=
X-GMAIL-MSGID: =?utf-8?q?1592481654657029425?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Trond Myklebust <trond.myklebust@primarydata.com>

commit 7f1bda447c9bd48b415acedba6b830f61591601f upstream.

The commit list can get very large, and so we need a cond_resched()
in nfs_commit_release_pages() in order to ensure we don't hog the CPU
for excessive periods of time.

Reported-by: Mike Galbraith <efault@gmx.de>
Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/nfs/write.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -1836,6 +1836,8 @@ static void nfs_commit_release_pages(str
 		set_bit(NFS_CONTEXT_RESEND_WRITES, &req->wb_context->flags);
 	next:
 		nfs_unlock_and_release_request(req);
+		/* Latency breaker */
+		cond_resched();
 	}
 	nfss = NFS_SERVER(data->inode);
 	if (atomic_long_read(&nfss->writeback) < NFS_CONGESTION_OFF_THRESH)
