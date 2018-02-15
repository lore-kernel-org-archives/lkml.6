Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224w96grUUiINmIWLRmJQO4ChV12VVhcr8cgUPK6zyvngBgOxxcGRC7WwSo82NKIyOk05bdF
ARC-Seal: i=1; a=rsa-sha256; t=1518709383; cv=none;
        d=google.com; s=arc-20160816;
        b=J3FpY5E7jSjDOtTxH7+eI2y547beuedaqFUt93POirYBXXha9+1i2/DtfG+mcnaOoR
         Q5eoVDT4kY1n4BdeB+m2d/R7j9sAUQSOuHVlvEUqdCwKv4DG+d+yv6D0SPALBHSMzQSG
         S1EkcMIQrr1N0Rlt8TX+gj5kcv4ciW0XuqK/Lzscg8L+h4PqhrQwmjjlm9YvtP0zsI6S
         A79J3x9Udsf6nsLeoKACa4na535rOwuoJuabh6udR9/p/b+k5qRf0Xl7tP2vQdxFAz88
         ZzCddnlNBSuIBSONIMjKRbLHdL7NPhiJciPfPrnoi4K45BI5UGA5NXqM3ZQF2aegvZyq
         AlLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=goNhHCrrylzGTPz1ZIonD0c6qC+z8AiRc5VmQFSLpNg=;
        b=0b3SUS0COZ/SC/PSN4Qr/xmp39NCnAXt3F6orX06ki7jDhtmjqX720icSFUDBJxbzI
         ov26+Tr8/3DaSxwvXG1yBGaK/2YvKXu43zL98zN3QTj/SjBWfabm3o575dvGJkU2BJJD
         6PEVu274YajGeYNaJVJsQf0/M4jNZMuucbCFfA69Ik8inRJRmRc9AoTYMq6UUKRg0I9r
         r43NiojEnBbKe+SgejHo8TBCAoveYTGRaMpyRgyNIEG8XK6e6YDAVT7+R3+OUrOzdAi5
         zGBxK/KpM057s+B2i6na/q59fwRAhtv80B0gG32SxvgguAxj4Jc34dnZ3xLbFvfhSzES
         1Biw==
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
Subject: [PATCH 4.15 098/202] NFS: Add a cond_resched() to nfs_commit_release_pages()
Date: Thu, 15 Feb 2018 16:16:38 +0100
Message-Id: <20180215151718.472175331@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480726935884245?=
X-GMAIL-MSGID: =?utf-8?q?1592482210013490779?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1837,6 +1837,8 @@ static void nfs_commit_release_pages(str
 		set_bit(NFS_CONTEXT_RESEND_WRITES, &req->wb_context->flags);
 	next:
 		nfs_unlock_and_release_request(req);
+		/* Latency breaker */
+		cond_resched();
 	}
 	nfss = NFS_SERVER(data->inode);
 	if (atomic_long_read(&nfss->writeback) < NFS_CONGESTION_OFF_THRESH)
