Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/lgucCNi2nPcF71nX8eBvczAQDgQYLVez0gIX9iJ4zUhsN4YZG3wzu0OADEf8i185HiOFc
ARC-Seal: i=1; a=rsa-sha256; t=1524406492; cv=none;
        d=google.com; s=arc-20160816;
        b=oZSMOM2fjm7pn8nO6Jv3z5gE+VHOpDqHTyz8W4ne1gJwrgz+f/61fIkntKthS5QeN1
         rVKHvKC5J8aMZxoq5UrynXQD9Ax0nIxUQLC0Lh/s/LAPVmpsasZG8E+gnJLTcYkNsjEX
         JVQh+66PzUcn94HkQRZB4f5psK01TDOjZQTAETGLADdqaGJADC7JHIvbl3I9S9jy9z2s
         DinglLxaYyLbdHZo5xGFdXQomSmExguqPcRjLFvQSHxxhm1UA30nipwvyaMlAxe4Mx5R
         SwJpGHPmS6uOV59X78HgG4aguttG07LPeyg/u1JlocZu2BUSzb6OqOlmYSRG4L9q55h9
         QNDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=AZ3EAJ+mm4Slf4PGRtHY7aNvemc3f4zK53iVPXnfeYc=;
        b=AJMftENFritGT2wOZ15URfrWSnBDTKO5OwwQmX3Di/tU+3aKX/uqlHYz0+hOK7/VEK
         sGC5rumBVfahDISDcvXuxI/zBE6ya180v3MYiVpfdyH/HbqQ8Aq0atQyTX5wC61u2rq1
         NMPvA64QYSl6OdUGMco2gRGo5czVb+DvwNxY8JPhL+jSiUsY3V0iA3lGlPzKsZNoWq70
         8hDR5N5B/dLnkgqjJeW69K2xu2Cacue6hDgg6PloUIn31WA/crbNKBtueqpdRNwg01oS
         C/QhDVZG2kpZ7fhlb/sc0DndBtuhDPYFpaRw20c437I11AGuiSrzvdwU1zjwHehU50nV
         gTrw==
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
Subject: [PATCH 4.9 90/95] Dont leak MNT_INTERNAL away from internal mounts
Date: Sun, 22 Apr 2018 15:53:59 +0200
Message-Id: <20180422135214.109430105@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135210.432103639@linuxfoundation.org>
References: <20180422135210.432103639@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455310413463225?=
X-GMAIL-MSGID: =?utf-8?q?1598456062250619075?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1033,7 +1033,8 @@ static struct mount *clone_mnt(struct mo
 			goto out_free;
 	}
 
-	mnt->mnt.mnt_flags = old->mnt.mnt_flags & ~(MNT_WRITE_HOLD|MNT_MARKED);
+	mnt->mnt.mnt_flags = old->mnt.mnt_flags;
+	mnt->mnt.mnt_flags &= ~(MNT_WRITE_HOLD|MNT_MARKED|MNT_INTERNAL);
 	/* Don't allow unprivileged users to change mount flags */
 	if (flag & CL_UNPRIVILEGED) {
 		mnt->mnt.mnt_flags |= MNT_LOCK_ATIME;
