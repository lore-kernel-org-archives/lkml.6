Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4882mSH5WbRAljpoUNEpZHOJZJHxmIyKRS6vPb4Kba23OAIq2MzvliPIDKt1dQrzuPsecAW
ARC-Seal: i=1; a=rsa-sha256; t=1523399237; cv=none;
        d=google.com; s=arc-20160816;
        b=lMUHw8unwzzTazg9DpBBMFCCNquzB97Jbt9SBZHr73IRIM1T8SMZ/SEJZtlJny7yTR
         xAtz/6Zy7Yyum7nqsKqskP9YmDIlrMKbtW3QmIZxEL7zCatXJO9kYx87y8hX7Yzw56Go
         7ygXpWOvQWvPU2OQzftlL1Y9lrT3El6evYgei1LBieijTjlMzCc4PTwZM6482zGVpVd2
         YaK2iC333y0bcgX7RLkqaZRClkEtMPHasfNN2mH6r8hRfdASpbox4QYLLdgmCbzgNXJ7
         WIWmZ2s6Zi7usRInwyET0G74zdZ6Bb2fSBqgfxB2bFmFgDGEU8Medf9XEBwVHEBB+Rar
         Fe1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=kMidTX5tB7RhQZtrYEdzjHRz0l5ung1M/5+vHx1Vk74=;
        b=EwXO6wk6ItrgFahkFAGi3zJj5o8GgJamo2goZ8Yw6UJ/OenY9Xjc4bOIr/1taR6ugl
         0NiU4yxK5/i4vpMNoQ9fvtalSvFydDlqn5FvzC/7LzM120dOyVbVMwZjtVhpIWID+btf
         zJmc8it4+gGjYp9/E/q8UFW7Pel7vmo03QHTiBD0QNEbOKqPj9mkTLm+tSrlLxRPmJh6
         LJ6smgyBWfVptW8nQvQTVs8Psa9qdduOwdLPaeKyk/5aQMCoA1jc1+e0FvdjnlJVe7E1
         QUqrerhbLm4XTu95PTejjIJDp/ZtHi1mZ+KHMQ80R0rHki6KtyRUDO1WnHwO2P/j9GdH
         u/sw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Sowmini Varadhan <sowmini.varadhan@oracle.com>,
	Santosh Shilimkar <santosh.shilimkar@oracle.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 017/168] rds; Reset rs->rs_bound_addr in rds_add_bound() failure path
Date: Wed, 11 Apr 2018 00:22:39 +0200
Message-Id: <20180410212800.949934911@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399879201708927?=
X-GMAIL-MSGID: =?utf-8?q?1597399879201708927?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sowmini Varadhan <sowmini.varadhan@oracle.com>


[ Upstream commit 7ae0c649c47f1c5d2db8cee6dd75855970af1669 ]

If the rds_sock is not added to the bind_hash_table, we must
reset rs_bound_addr so that rds_remove_bound will not trip on
this rds_sock.

rds_add_bound() does a rds_sock_put() in this failure path, so
failing to reset rs_bound_addr will result in a socket refcount
bug, and will trigger a WARN_ON with the stack shown below when
the application subsequently tries to close the PF_RDS socket.

     WARNING: CPU: 20 PID: 19499 at net/rds/af_rds.c:496 \
		rds_sock_destruct+0x15/0x30 [rds]
       :
     __sk_destruct+0x21/0x190
     rds_remove_bound.part.13+0xb6/0x140 [rds]
     rds_release+0x71/0x120 [rds]
     sock_release+0x1a/0x70
     sock_close+0xe/0x20
     __fput+0xd5/0x210
     task_work_run+0x82/0xa0
     do_exit+0x2ce/0xb30
     ? syscall_trace_enter+0x1cc/0x2b0
     do_group_exit+0x39/0xa0
     SyS_exit_group+0x10/0x10
     do_syscall_64+0x61/0x1a0

Signed-off-by: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@oracle.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/rds/bind.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/rds/bind.c
+++ b/net/rds/bind.c
@@ -114,6 +114,7 @@ static int rds_add_bound(struct rds_sock
 			  rs, &addr, (int)ntohs(*port));
 			break;
 		} else {
+			rs->rs_bound_addr = 0;
 			rds_sock_put(rs);
 			ret = -ENOMEM;
 			break;
