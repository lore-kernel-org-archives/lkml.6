Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48tZ5iBQKF94REo2z6R7OC1UDBGswCHreYJTD76wgzYjTGw6qtbyz7TnfmLbcelrK2IVrGn
ARC-Seal: i=1; a=rsa-sha256; t=1524406218; cv=none;
        d=google.com; s=arc-20160816;
        b=bVNAxvlKLYOeMd/Us3pm/Lzrr8FmM3vpaorw6rWSe2uUlcDXyVOKyVpruYQ/VT5q6i
         RqQ8op0rIH/icJ2TYuhD6FiIKLga0AWwA+186Io0hoKWsMN9iL1LzBbJ8z3/vDM6E5LF
         4TB7RMCnsZ7Q3rN2yr/aSLNrSb9xHvQ3YrMhjDbCN6Hwy/kXVlF5xuNAK95Hj+y1uWHl
         Q7q9zsv0FLV8ooPAZ2W7rdA2cLI3BNzOYfeNTcXpc9Gm0d6dl+0aCgKJGHlqBZTzQwNc
         /tQriufjau6e5+myRjYCfpTysKB0bR3Zp4FO2xUh9sGFUN6igoUHGAJHro3Gg4JVbflR
         3Lqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=uosptS5cu2EkhvvFv1jvObVHqltthFjnyPwra6Mh9ts=;
        b=Zk/mMuadoT21m8fFquJUuIN1gKTTGYCLBccuNmczjT6Oo06HlbCjh6lR028N8Xdo+R
         8125BzKYMIQFN8p0AwEygnlFmzZxx7re9qLdtK3Q6HTHLgdWSgHyAoaUzvaIkbEKXOa+
         V2kd6mA3Wf90JOffTVVDNVEkv+WXN+xQL3kLeWAPq74+B031uYwUlJkW3gtpBzb9bra6
         nJUuhsDkWUji9X7jjDnIQrq3f4Yk8zFWbqP8zZNf+kVZ2sQkQ4rvwIEaNzr7a3g3ftkm
         dTkIKCYD+YeanzdU1RsdShFjZN9lfjdtSrlfLNywzU2zNlBUFmkNbDWrjKUgEwft+ZJ4
         QudQ==
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
Subject: [PATCH 4.14 156/164] Dont leak MNT_INTERNAL away from internal mounts
Date: Sun, 22 Apr 2018 15:53:43 +0200
Message-Id: <20180422135141.968549701@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455310413463225?=
X-GMAIL-MSGID: =?utf-8?q?1598455775682451365?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
