Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx489ioWB2b8zHI21CFmXCgOeoe3mYetrJ+NYLg36Gpy8cAZogIojKePriwG0KfUUNRBs6LWK
ARC-Seal: i=1; a=rsa-sha256; t=1524406916; cv=none;
        d=google.com; s=arc-20160816;
        b=ihxlGXfO8bEpivxjIrFm5d8+cpk46Rk5RlGRrHtYdwZk3pCWg0v4Tz+o3g5CmBxqK5
         LB1xr0BTHkdT7J1ysA7+hNJPO6FhhLPmPMBOxMUSB/43AKonVx6mZcnaV1IE05b2BnuJ
         WQGs1iRQNSMASdnFcCvneRIeT4fqTahfpamECVVNiL/C3Ls79gvXKLqKRdsKHW5G4tS4
         5vOTQ6s9QJGnjiqzg2Ci0rbr6WJqazdTi7iHcodNg+8lR2lKhZGi6z94+pnTEaNR+kTQ
         Kgn2Fwg2ALYvpFoa6XNkANc0kBfDe2cNDxDZH/iQd/fBQA4nf6zktIbOpqQgLKkmpe3b
         faKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=jVLot0xC8ZBjXWzHyf3SUH+TpCl2/3VjqnJKWY6EQhg=;
        b=ucpnPUzeHKrgKVWEuFG5+N6js2AcQ6Ooq31O9sjE33mRlcYyqNrh+/HxJTwIV8WHE+
         w3NgjsFEW5FC0Ar8S6LRy/+wlGAOL01Ir8Vw/yHL5PqGOlLaIaNKLA95eNigpe92Qw0m
         tZEpAEUxRm5leMs1oDN83/v3ZI1Z/47xIJMCNp0tDNNixqxdk61EreCNMHQxGj9nAuSf
         Inw+I7OcAmWy7GTfF6P3QBfYVttg4i//ZArZsqSIBIDfYhzubhTb4UK+hyvTTJ3/jwDD
         3Ta9rhs7guRpEMvnuPQ1QP7XJeamE/cG0N15mj9b0u91OF6ks0Ng1x4ltYfuFgmYLKXt
         BCAQ==
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
Subject: [PATCH 3.18 50/52] Dont leak MNT_INTERNAL away from internal mounts
Date: Sun, 22 Apr 2018 15:54:23 +0200
Message-Id: <20180422135317.637169920@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135315.254787616@linuxfoundation.org>
References: <20180422135315.254787616@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455310413463225?=
X-GMAIL-MSGID: =?utf-8?q?1598456507244801213?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -944,7 +944,8 @@ static struct mount *clone_mnt(struct mo
 			goto out_free;
 	}
 
-	mnt->mnt.mnt_flags = old->mnt.mnt_flags & ~(MNT_WRITE_HOLD|MNT_MARKED);
+	mnt->mnt.mnt_flags = old->mnt.mnt_flags;
+	mnt->mnt.mnt_flags &= ~(MNT_WRITE_HOLD|MNT_MARKED|MNT_INTERNAL);
 	/* Don't allow unprivileged users to change mount flags */
 	if (flag & CL_UNPRIVILEGED) {
 		mnt->mnt.mnt_flags |= MNT_LOCK_ATIME;
