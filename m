Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/XP2B6GW+CteVXa/7ydPl1wBrjbwRhUs0EEJuQmr4a36hk3GHmCCereL3cyTqPfqXurdpq
ARC-Seal: i=1; a=rsa-sha256; t=1523981113; cv=none;
        d=google.com; s=arc-20160816;
        b=FC/+zaWjxpVJ1VMeyUharlM9jIIk+XcxjN66QCUQgIdJMDX9ou/NQfPI26kIndSZoc
         dKR+Pk+0p5D4KNG8hotVitRGPOHdSG+hQ+6OEyigzoFjcVym8Y7flrtkikYKVALDRBQn
         u+c2Ws+imPXEXBI4WMjkFYJLceg8bs/hTp4rxuDaLmEIIiMM58XlUTrZiRjKL4I44xvc
         m6brOdofLF/x7BmQkrK0RiTS/jNzcZJa1Af06iH6ruPZ+ZypUeejBFXI76vjPd2ckLJC
         u7EVrvL22rpEgxm/zNnHVj3MR+PjmJuisEhQtOTnFnivCRdgxw7GZFZ7yiXgZ2VwTHQs
         2Eig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=yNTdj9mSeCYMBDzxGoBDZc6F2jImqlObqZzMQyy7FYw=;
        b=cBcU/rP+v9ZTcgz8TzAdVfQEcqXgjKo8X+iQ0k32fQ/wQqa6Zgm0Ga5+TzHVBVhl2D
         ZEhhWNhkccI1Y2CRXaniOwC23ItLriS0vAtHGMu+dI8Tbz1wOrLJrzxxSuMY8dX62rSK
         uDno7WtdYy1zmGp3EpRJDlNYWS3nko2TjYcCwg5dUNpLiOyMt77iYnLxsnsUwkDsUlba
         BM5a8NKZHSMUPVAdd0vHRZ5XfJnbxIvR2W9D90Wmp4JqRp0/1TbtaCrPiHL1GK3Ah0bM
         5BnYLIrTIkgFPqsNK26DuKmf/NPsWkV57d1k++evAsyRk9b76GrL1EuXrUG3M1JljkNT
         sRBA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Sudhir Sreedharan <ssreedharan@mvista.com>,
	Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 4.15 52/53] rtl8187: Fix NULL pointer dereference in priv->conf_mutex
Date: Tue, 17 Apr 2018 17:59:17 +0200
Message-Id: <20180417155725.567620533@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155723.091120060@linuxfoundation.org>
References: <20180417155723.091120060@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009886651691074?=
X-GMAIL-MSGID: =?utf-8?q?1598010019410818558?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sudhir Sreedharan <ssreedharan@mvista.com>

commit 7972326a26b5bf8dc2adac575c4e03ee7e9d193a upstream.

This can be reproduced by bind/unbind the driver multiple times
in AM3517 board.

Analysis revealed that rtl8187_start() was invoked before probe
finishes(ie. before the mutex is initialized).

 INFO: trying to register non-static key.
 the code is fine but needs lockdep annotation.
 turning off the locking correctness validator.
 CPU: 0 PID: 821 Comm: wpa_supplicant Not tainted 4.9.80-dirty #250
 Hardware name: Generic AM3517 (Flattened Device Tree)
 [<c010e0d8>] (unwind_backtrace) from [<c010beac>] (show_stack+0x10/0x14)
 [<c010beac>] (show_stack) from [<c017401c>] (register_lock_class+0x4f4/0x55c)
 [<c017401c>] (register_lock_class) from [<c0176fe0>] (__lock_acquire+0x74/0x1938)
 [<c0176fe0>] (__lock_acquire) from [<c0178cfc>] (lock_acquire+0xfc/0x23c)
 [<c0178cfc>] (lock_acquire) from [<c08aa2f8>] (mutex_lock_nested+0x50/0x3b0)
 [<c08aa2f8>] (mutex_lock_nested) from [<c05f5bf8>] (rtl8187_start+0x2c/0xd54)
 [<c05f5bf8>] (rtl8187_start) from [<c082dea0>] (drv_start+0xa8/0x320)
 [<c082dea0>] (drv_start) from [<c084d1d4>] (ieee80211_do_open+0x2bc/0x8e4)
 [<c084d1d4>] (ieee80211_do_open) from [<c069be94>] (__dev_open+0xb8/0x120)
 [<c069be94>] (__dev_open) from [<c069c11c>] (__dev_change_flags+0x88/0x14c)
 [<c069c11c>] (__dev_change_flags) from [<c069c1f8>] (dev_change_flags+0x18/0x48)
 [<c069c1f8>] (dev_change_flags) from [<c0710b08>] (devinet_ioctl+0x738/0x840)
 [<c0710b08>] (devinet_ioctl) from [<c067925c>] (sock_ioctl+0x164/0x2f4)
 [<c067925c>] (sock_ioctl) from [<c02883f8>] (do_vfs_ioctl+0x8c/0x9d0)
 [<c02883f8>] (do_vfs_ioctl) from [<c0288da8>] (SyS_ioctl+0x6c/0x7c)
 [<c0288da8>] (SyS_ioctl) from [<c0107760>] (ret_fast_syscall+0x0/0x1c)
 Unable to handle kernel NULL pointer dereference at virtual address 00000000
 pgd = cd1ec000
 [00000000] *pgd=8d1de831, *pte=00000000, *ppte=00000000
 Internal error: Oops: 817 [#1] PREEMPT ARM
 Modules linked in:
 CPU: 0 PID: 821 Comm: wpa_supplicant Not tainted 4.9.80-dirty #250
 Hardware name: Generic AM3517 (Flattened Device Tree)
 task: ce73eec0 task.stack: cd1ea000
 PC is at mutex_lock_nested+0xe8/0x3b0
 LR is at mutex_lock_nested+0xd0/0x3b0

Cc: stable@vger.kernel.org
Signed-off-by: Sudhir Sreedharan <ssreedharan@mvista.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c
+++ b/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c
@@ -1450,6 +1450,7 @@ static int rtl8187_probe(struct usb_inte
 		goto err_free_dev;
 	}
 	mutex_init(&priv->io_mutex);
+	mutex_init(&priv->conf_mutex);
 
 	SET_IEEE80211_DEV(dev, &intf->dev);
 	usb_set_intfdata(intf, dev);
@@ -1625,7 +1626,6 @@ static int rtl8187_probe(struct usb_inte
 		printk(KERN_ERR "rtl8187: Cannot register device\n");
 		goto err_free_dmabuf;
 	}
-	mutex_init(&priv->conf_mutex);
 	skb_queue_head_init(&priv->b_tx_status.queue);
 
 	wiphy_info(dev->wiphy, "hwaddr %pM, %s V%d + %s, rfkill mask %d\n",
