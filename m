Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/ZxzC0M9FsrikVsnM5hbPAdn9pxthx0t22v1xj+0zuAtC4CsA6eob3x8gIzk5ctp77fPrR
ARC-Seal: i=1; a=rsa-sha256; t=1522168592; cv=none;
        d=google.com; s=arc-20160816;
        b=ivfNFqUBGuwqnQzT0m8EdC9vPd5lS0SCTIKVjdY5IU6Qf2UYBOjqUWnVS7MQHIWLL+
         cKA+255eCN14CDgRVb0cxXWkB6pFhjj8ElJomxFHPkXlgh+dSa31XoYLzUEvkfAspnwm
         b9CnD+WyLaEwPNyQICvkXqFTSMA5xzqNNXpzNpj3eDn95ch+0b2v7yd9aVlPximCeBMF
         v2BYgmg6tUh9oG/VI1OhdQMmBWxE/Utx/gUtdCGOYOOSviFa5F9R2ypzy6n3M28WAKnn
         +CxaeCUMefIpTdM5VQomZN/s+dU9Eos/dJAF77v4NSUdTv0ZK1SKG3h30e1Bju2C8f6b
         tlZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=u0Oi4WG9iK5+fk8zuASXBqFpfU8GH9Ltr2dTvmeM2UA=;
        b=qH5TJLAAZcVByAO529xvbASQgzdYC5NstosH3mb458/pAQH/lwqIL9w4aBKc6e7sYH
         o0ZUpfF3Sm53aJEvyqmIgwKyfd4/Mk1ucvImI0V6tXFrxCtbTycgU0tuLHUAdPzzct3p
         zDzQE/Jk/relL5tw+JvrIOR8QEbiC1mymVNfhO9hDH32pW6Mpd3WKdqWnn02JYB4GqPj
         2ARQf4HJVmiPNpOLCk+ZWPxSijt4MbbHJlC5FiWCVFFnKfOkCTOaC3gzclFhjvLrIoSc
         wpqzf8Gsh5eU1CCEqKOw7k4iOPucn1rbliGwgRKP9PRYIjONEgXUA87E4Wlvq4YyWmqX
         SP1g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzkaller <syzkaller@googlegroups.com>,
	Noa Osherovich <noaos@mellanox.com>,
	Leon Romanovsky <leonro@mellanox.com>,
	Doug Ledford <dledford@redhat.com>
Subject: [PATCH 4.14 028/101] RDMA/mlx5: Fix crash while accessing garbage pointer and freed memory
Date: Tue, 27 Mar 2018 18:27:00 +0200
Message-Id: <20180327162751.723986111@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162749.993880276@linuxfoundation.org>
References: <20180327162749.993880276@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109454128685109?=
X-GMAIL-MSGID: =?utf-8?q?1596109454128685109?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Leon Romanovsky <leonro@mellanox.com>

commit f3f134f5260ae9ee1f5a4d0a8cc625c6c77655b4 upstream.

The failure in rereg_mr flow caused to set garbage value (error value)
into mr->umem pointer. This pointer is accessed at the release stage
and it causes to the following crash.

There is not enough to simply change umem to point to NULL, because the
MR struct is needed to be accessed during MR deregistration phase, so
delay kfree too.

[    6.237617] BUG: unable to handle kernel NULL pointer dereference a 0000000000000228
[    6.238756] IP: ib_dereg_mr+0xd/0x30
[    6.239264] PGD 80000000167eb067 P4D 80000000167eb067 PUD 167f9067 PMD 0
[    6.240320] Oops: 0000 [#1] SMP PTI
[    6.240782] CPU: 0 PID: 367 Comm: dereg Not tainted 4.16.0-rc1-00029-gc198fafe0453 #183
[    6.242120] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.7.5-0-ge51488c-20140602_164612-nilsson.home.kraxel.org 04/01/2014
[    6.244504] RIP: 0010:ib_dereg_mr+0xd/0x30
[    6.245253] RSP: 0018:ffffaf5d001d7d68 EFLAGS: 00010246
[    6.246100] RAX: 0000000000000000 RBX: ffff95d4172daf00 RCX: 0000000000000000
[    6.247414] RDX: 00000000ffffffff RSI: 0000000000000001 RDI: ffff95d41a317600
[    6.248591] RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
[    6.249810] R10: ffff95d417033c10 R11: 0000000000000000 R12: ffff95d4172c3a80
[    6.251121] R13: ffff95d4172c3720 R14: ffff95d4172c3a98 R15: 00000000ffffffff
[    6.252437] FS:  0000000000000000(0000) GS:ffff95d41fc00000(0000) knlGS:0000000000000000
[    6.253887] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    6.254814] CR2: 0000000000000228 CR3: 00000000172b4000 CR4: 00000000000006b0
[    6.255943] Call Trace:
[    6.256368]  remove_commit_idr_uobject+0x1b/0x80
[    6.257118]  uverbs_cleanup_ucontext+0xe4/0x190
[    6.257855]  ib_uverbs_cleanup_ucontext.constprop.14+0x19/0x40
[    6.258857]  ib_uverbs_close+0x2a/0x100
[    6.259494]  __fput+0xca/0x1c0
[    6.259938]  task_work_run+0x84/0xa0
[    6.260519]  do_exit+0x312/0xb40
[    6.261023]  ? __do_page_fault+0x24d/0x490
[    6.261707]  do_group_exit+0x3a/0xa0
[    6.262267]  SyS_exit_group+0x10/0x10
[    6.262802]  do_syscall_64+0x75/0x180
[    6.263391]  entry_SYSCALL_64_after_hwframe+0x21/0x86
[    6.264253] RIP: 0033:0x7f1b39c49488
[    6.264827] RSP: 002b:00007ffe2de05b68 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
[    6.266049] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f1b39c49488
[    6.267187] RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
[    6.268377] RBP: 00007f1b39f258e0 R08: 00000000000000e7 R09: ffffffffffffff98
[    6.269640] R10: 00007f1b3a147260 R11: 0000000000000246 R12: 00007f1b39f258e0
[    6.270783] R13: 00007f1b39f2ac20 R14: 0000000000000000 R15: 0000000000000000
[    6.271943] Code: 74 07 31 d2 e9 25 d8 6c 00 b8 da ff ff ff c3 0f 1f
44 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 8b 07 53 48 8b
5f 08 <48> 8b 80 28 02 00 00 e8 f7 d7 6c 00 85 c0 75 04 3e ff 4b 18 5b
[    6.274927] RIP: ib_dereg_mr+0xd/0x30 RSP: ffffaf5d001d7d68
[    6.275760] CR2: 0000000000000228
[    6.276200] ---[ end trace a35641f1c474bd20 ]---

Fixes: e126ba97dba9 ("mlx5: Add driver for Mellanox Connect-IB adapters")
Cc: syzkaller <syzkaller@googlegroups.com>
Cc: <stable@vger.kernel.org>
Reported-by: Noa Osherovich <noaos@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/hw/mlx5/mr.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -838,7 +838,8 @@ static int mr_umem_get(struct ib_pd *pd,
 	*umem = ib_umem_get(pd->uobject->context, start, length,
 			    access_flags, 0);
 	err = PTR_ERR_OR_ZERO(*umem);
-	if (err < 0) {
+	if (err) {
+		*umem = NULL;
 		mlx5_ib_err(dev, "umem get failed (%d)\n", err);
 		return err;
 	}
@@ -1415,6 +1416,7 @@ int mlx5_ib_rereg_user_mr(struct ib_mr *
 		if (err) {
 			mlx5_ib_warn(dev, "Failed to rereg UMR\n");
 			ib_umem_release(mr->umem);
+			mr->umem = NULL;
 			clean_mr(dev, mr);
 			return err;
 		}
@@ -1498,14 +1500,11 @@ static int clean_mr(struct mlx5_ib_dev *
 		u32 key = mr->mmkey.key;
 
 		err = destroy_mkey(dev, mr);
-		kfree(mr);
 		if (err) {
 			mlx5_ib_warn(dev, "failed to destroy mkey 0x%x (%d)\n",
 				     key, err);
 			return err;
 		}
-	} else {
-		mlx5_mr_cache_free(dev, mr);
 	}
 
 	return 0;
@@ -1548,6 +1547,11 @@ static int dereg_mr(struct mlx5_ib_dev *
 		atomic_sub(npages, &dev->mdev->priv.reg_pages);
 	}
 
+	if (!mr->allocated_from_cache)
+		kfree(mr);
+	else
+		mlx5_mr_cache_free(dev, mr);
+
 	return 0;
 }
 
