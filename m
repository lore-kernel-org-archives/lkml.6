Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227uH3mvBf7wM9fDO2pppZIp9qG+lTkI79SQ0fyf3vmcb3z2+Ri/BcRK04O5GJdAXPRrInKp
ARC-Seal: i=1; a=rsa-sha256; t=1518708487; cv=none;
        d=google.com; s=arc-20160816;
        b=g9K5YL2we8xsqW815odZjtmqxCtS/KxIpltQ4G9b+9AIUmArA3+THrZI3oxEH09HLZ
         FGV79xGAW7Go3xv1ebhKli/qgJCa8Y86swEfDETYMVNXFc0ZITzCXunSnhhfh7eKUHOK
         qw71Aoh2wOfJkxJTz5DccLn1udQnbNlYEMd1ZHNDFLRoZM2uQJgOjKuYfU8gZbkrI5Sk
         CMxrm8lnahAuiGay+Vea43tBibnJY6MFc+5JDFaGxFWjKMrfBl9YJ2gSJo5qwn7HhrZm
         dElj2BksPifTM022l4NGyr/WsMMK8iQAHY+aCtp2GrpT0XFIDfbRKC9cZIVsSmErKjlu
         WkbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=NklkrcAXmyCwndTbNUZMupkxTS6ZEDRUSk1xNysg/Hw=;
        b=gUi3mqFlWakqr0cXrLDnFshgmBdrNgshun0Gh70nRKVwra7sCUPdcH3pYD0oMQV2Tu
         fwgwbNk9LiCd1QRuQj0YW3UNemB+0DjxcbObedf1wuBQaSBkANmJT93hL+7tPbwa7pxP
         LuPNhhTOr5mocEQqF56x78l+QLVkxiY5DO6Pht0kIBhcqHcwZdI30BRQ9uCOBjsr97es
         Wso+vnKbauxrkwh/LCb2/iYItKn5TcP80IUwzbiSLlKUiRk9xc0RRgtAU3q41qWutRXN
         W1ClUAl1N6DBaGWW9nR4QjSMyEkh6mzQTZaPazXWVqJk5KGVE+uiOxs2h0uN5WDELKsO
         NdRQ==
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
Subject: [PATCH 4.9 23/88] NFS: Add a cond_resched() to nfs_commit_release_pages()
Date: Thu, 15 Feb 2018 16:16:50 +0100
Message-Id: <20180215151225.894700764@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.437136975@linuxfoundation.org>
References: <20180215151222.437136975@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480726935884245?=
X-GMAIL-MSGID: =?utf-8?q?1592481271578312858?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1806,6 +1806,8 @@ static void nfs_commit_release_pages(str
 		set_bit(NFS_CONTEXT_RESEND_WRITES, &req->wb_context->flags);
 	next:
 		nfs_unlock_and_release_request(req);
+		/* Latency breaker */
+		cond_resched();
 	}
 	nfss = NFS_SERVER(data->inode);
 	if (atomic_long_read(&nfss->writeback) < NFS_CONGESTION_OFF_THRESH)
