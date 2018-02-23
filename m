Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvac9Ce1VLv8yNF1qJ1sCreL64ImhrDXN+jKcE3aABOicZvgyopX0FNAQpQ3YxIh2FEV+Z/
ARC-Seal: i=1; a=rsa-sha256; t=1519412357; cv=none;
        d=google.com; s=arc-20160816;
        b=q+9xTKDbU4uld/YCLcdeTl+B+ff/KmhohprRfVwleMe+GdaTU7XOUmmirXs0vtho+i
         C8poR+/3mRQaxg2AgrrbxamiLRShsFEWLTC8Vkx+Zd1QCL3zxUPpmtGeIg/q3tURGMBT
         1Ya+peY7ImiE6+uXpvJwqikq9tl+l3odO0rqant+OXer/eGUTKXOpHVHbft0m1gQIBtm
         OekRqZcc3CSsmCbSFkXeb69h7mdWt4qXCv99RxUwyLxS4dW0ldNxl/kOkpHRSPxAR/aH
         gd6qN8yf3X+1x+lWLgG55CJCy1McK5kXnke4UQbwerIa0kz+rF/8GVuvMU/1p5+AWmBe
         SHLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=AiCkHz6FBk1qF17NESipmNQZCc4qG5MlOKUBfkT80iA=;
        b=CRxAU2fqiTZk51Xk3qEbBCk2EI5XpDljTX2MwpyNVhMCMoMcPW5GxpUv7oMVsxvnL2
         67b80ZyHvBytGG94HvgvUuIqnaA5eUT6M/QoIgTSQzSEy9FcdwdAh8AtNYQvVnPJqYPN
         FS9SZvurojLcaBYC/YddpMrMP3qGfvgPMgKVKgPVdwJ+0uGY5TmnyHSuUs8sgPxUocDP
         WDQA8/H+4jwFxGXov/LKCTCZp4dVwdqlx0eI7++sTxRHDydQgkResh3TEdYqBnvXMesP
         8woq/2i9+oV2UGQhNJ9f87K9MmRpH0wJa1B2cfzNWmTV4O4uD8YHBp0pa3Uwy6ypeiVR
         c6cA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot <syzkaller@googlegroups.com>,
	Eric Biggers <ebiggers@google.com>
Subject: [PATCH 4.15 32/45] binder: check for binder_thread allocation failure in binder_poll()
Date: Fri, 23 Feb 2018 19:29:11 +0100
Message-Id: <20180223170720.426965518@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170715.197760019@linuxfoundation.org>
References: <20180223170715.197760019@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217729843622461?=
X-GMAIL-MSGID: =?utf-8?q?1593219332132693805?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

commit f88982679f54f75daa5b8eff3da72508f1e7422f upstream.

If the kzalloc() in binder_get_thread() fails, binder_poll()
dereferences the resulting NULL pointer.

Fix it by returning POLLERR if the memory allocation failed.

This bug was found by syzkaller using fault injection.

Reported-by: syzbot <syzkaller@googlegroups.com>
Fixes: 457b9a6f09f0 ("Staging: android: add binder driver")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/android/binder.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -4346,6 +4346,8 @@ static unsigned int binder_poll(struct f
 	bool wait_for_proc_work;
 
 	thread = binder_get_thread(proc);
+	if (!thread)
+		return POLLERR;
 
 	binder_inner_proc_lock(thread->proc);
 	thread->looper |= BINDER_LOOPER_STATE_POLL;
