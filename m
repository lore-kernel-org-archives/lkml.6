Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvDPCydkC1iz87jUC4Yn9RCLbVlRAZdCeZpx84KcM7CjB5xr5GbtOzpGTFCHKEEr66+W8jF
ARC-Seal: i=1; a=rsa-sha256; t=1519412239; cv=none;
        d=google.com; s=arc-20160816;
        b=kVtQanGKfq689C3tI2oCKqxuxupkXJEl38DihRrjfIhSO3/GHATdXfHnkzc7Sekt0X
         GinvwVS+x86RzMqBFXutFxjk21t4R5Rk1saOI9oLvklAlKI/2kgFBWbrDe/JR4xrFUXK
         j3z+QR1W5LXl9lTdZzALcj1ewxCn6XuplVqHA1QMnlKWF2DSm8a3TgkxLu4cTYy+UucG
         KPSVUNcxxcV6Pdw61eW/dx5xNcKpfGdivk+8WVJ2bAUDv37kIwb3XLntgQmeOenhhdw5
         yz1QBOPSFJnt17IKjXLHK0f0zL0Elc5J5jjk6Uqv6QvX46Ywomhzkhxowp2JeL2WSU3B
         xKIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=k1C4F/uPkBaKHTfnvTtBJ2z/GkCGxmrr5AkgJ8tjhto=;
        b=RT3Mh7how96sOBcrums9dMmXbyhy1y1F31Zto/0RwGh0c/o0P/YJ3BZJmd9qfb0wK7
         r4j2QcOdjNorDS/PxBzdbseFpyQZPLXxrLseeECPribfsG5xYVx2+rWZ+K3o3jD4dD3L
         HkyzrUbgCNdX7wCB+7DVSrRhvtmoTB8f02DXTVmxzfRVqzmcqq2VaPNF7IIft9XnRxfV
         ZhRijxXd8mstu4mbiSp/xz/tdp+hoP/aNNR7CRLnocLrfrWD1Rfqv/H2YqG/OTPkh9Xt
         EX2E6AC5Vmm/Xg5+F97/S+EjMcRD4R3LP7mkvwtkOksXRxfjuAoOQu4dMruQhDOwr31r
         pSMA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dmitry Vyukov <dvyukov@google.com>,
	Shankara Pailoor <sp3485@columbia.edu>,
	syzbot <syzkaller@googlegroups.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.15 12/45] kcov: detect double association with a single task
Date: Fri, 23 Feb 2018 19:28:51 +0100
Message-Id: <20180223170717.269717088@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170715.197760019@linuxfoundation.org>
References: <20180223170715.197760019@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218299600984057?=
X-GMAIL-MSGID: =?utf-8?q?1593219208700456228?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Vyukov <dvyukov@google.com>

commit a77660d231f8b3d84fd23ed482e0964f7aa546d6 upstream.

Currently KCOV_ENABLE does not check if the current task is already
associated with another kcov descriptor.  As the result it is possible
to associate a single task with more than one kcov descriptor, which
later leads to a memory leak of the old descriptor.  This relation is
really meant to be one-to-one (task has only one back link).

Extend validation to detect such misuse.

Link: http://lkml.kernel.org/r/20180122082520.15716-1-dvyukov@google.com
Fixes: 5c9a8750a640 ("kernel: add kcov code coverage")
Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Reported-by: Shankara Pailoor <sp3485@columbia.edu>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/kcov.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -358,7 +358,8 @@ static int kcov_ioctl_locked(struct kcov
 		 */
 		if (kcov->mode != KCOV_MODE_INIT || !kcov->area)
 			return -EINVAL;
-		if (kcov->t != NULL)
+		t = current;
+		if (kcov->t != NULL || t->kcov != NULL)
 			return -EBUSY;
 		if (arg == KCOV_TRACE_PC)
 			kcov->mode = KCOV_MODE_TRACE_PC;
@@ -370,7 +371,6 @@ static int kcov_ioctl_locked(struct kcov
 #endif
 		else
 			return -EINVAL;
-		t = current;
 		/* Cache in task struct for performance. */
 		t->kcov_size = kcov->size;
 		t->kcov_area = kcov->area;
