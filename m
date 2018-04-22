Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+12WhJCK96PKrWNUY3wys3AuiLpU7HdHNAfHWTU7Qlwkh07mVU9Dd0HpqEexLSM2tHQJHz
ARC-Seal: i=1; a=rsa-sha256; t=1524405775; cv=none;
        d=google.com; s=arc-20160816;
        b=g5SrB5HFIioAgKOfmpHedhcAJMcuhoNUU7O4owlyWh9Ea+hPxHXC+Dvi5aksOd4Fdb
         0KGM7kO/hBcIgki1OGN54+njxHWaIJ7ZanDa3TanY2XQZfVx4e5iH6ia1C8hpt10nVhr
         SXml3kMdlraOhzqGmBjVeuCEGGco8fzYplEn51cc//+zB/nojDaNgNd7CLzmTZd3AZWB
         5awBdW+hRTP83gYRCGqceOZ/Ln7rCl8qxLXtZ2cAnZT/tjj+TCQGmxTf4XWCnx9f6W9S
         dwZ48AdXjfszl3rm/85u0xzCSKrwXW9ZFHBI5YKHhodDuInXQS6vhXjqzQux0m3/IsZg
         e9Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=9zAQwv+nFxvjEHIaSbVRSBKbaUya/XWV8JrCJVjfmcI=;
        b=f6s/6qsBlexJ61zDtAmArf/EK9kfmxV50g2lo2yQfzsun8q3PVThq/4w1nPhUKfSTx
         4SoL84gJBlG99OrFCvIbWAV7wlqihDM101839Pp/DS5Ps8rkftosDQSATYH+WOHPpUiS
         RZx0lTsyKhoBARQSxTAqrwpMx4o4afASYkQ6qCJFOExv1GpuVBOay0Qrl+D1QrY8Rw49
         ojc9y7BWKgJmVdAJsTHlmM3eEaXodLOF+jr7gmr1KJOlvxY29jTM8TOWhJYzYzC8NEdk
         j83GAnATc+UFUeh+gCJcKPHtq9QyidDqPuO8RK/sLdtWWMz2aHEy01VYzCJYu2o9HmEh
         hfIQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	stable@kernel.org,
	Alexander Aring <aring@mojatatu.com>,
	Kirill Tkhai <ktkhai@virtuozzo.com>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 4.16 189/196] Dont leak MNT_INTERNAL away from internal mounts
Date: Sun, 22 Apr 2018 15:53:29 +0200
Message-Id: <20180422135114.027763644@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455310413463225?=
X-GMAIL-MSGID: =?utf-8?q?1598455310413463225?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Al Viro <viro@zeniv.linux.org.uk>

commit 16a34adb9392b2fe4195267475ab5b472e55292c upstream.

We want it only for the stuff created by SB_KERNMOUNT mounts, *not* for
their copies.  As it is, creating a deep stack of bindings of /proc/*/ns/*
somewhere in a new namespace and exiting yields a stack overflow.

Cc: stable@kernel.org
Reported-by: Alexander Aring <aring@mojatatu.com>
Bisected-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Tested-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Tested-by: Alexander Aring <aring@mojatatu.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/namespace.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1089,7 +1089,8 @@ static struct mount *clone_mnt(struct mo
 			goto out_free;
 	}
 
-	mnt->mnt.mnt_flags = old->mnt.mnt_flags & ~(MNT_WRITE_HOLD|MNT_MARKED);
+	mnt->mnt.mnt_flags = old->mnt.mnt_flags;
+	mnt->mnt.mnt_flags &= ~(MNT_WRITE_HOLD|MNT_MARKED|MNT_INTERNAL);
 	/* Don't allow unprivileged users to change mount flags */
 	if (flag & CL_UNPRIVILEGED) {
 		mnt->mnt.mnt_flags |= MNT_LOCK_ATIME;
