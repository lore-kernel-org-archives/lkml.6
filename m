Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuIodo0gbxWt46oc0ImEoMMbnvODjGrwRqRZ5yzZy8hYO/VLpvjcvcYU8h/Zpz4GToC8ZP3
ARC-Seal: i=1; a=rsa-sha256; t=1521483895; cv=none;
        d=google.com; s=arc-20160816;
        b=VI9dnNQGHUQig77AgksS8N+HlTl35fJB4KYNA59Nz9bAfykA7xumjV0Y3YAb4bgEoe
         GQHzc8S/xPJjWpr0mrkRprWG61FIZp5Vm4+/8xcCueVqUuNlvgl3mTmXcjpv6wODrz3+
         Jswv94SHfiMuTlV9p3ieYf9Bw1UnrFcuTd/GDQgZtRLE03seEQBMaWFBb4b7/H5nbc4h
         CZUqx551CuxMRv3o5wTF1cHH2mfkQ6QfZPd01Al7ZDBtgVp45fv021eF7UHWUImVEP06
         mDqE6g+/A6QxnLZMS+36nrlVrufYd9REfjJN7Epoc/xZfiycE/7ytBBbEB7zZLqq00gZ
         5XMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=GzG44Y5TpcqWAppRUO8wpXrg/9TGF092F+zO+/bQYEg=;
        b=UThkJL4LmHa3qAMXr2t7lSM3Q7ozWUgI2wJNio7Ob0KhJH6iI1114GCaMdER2FooRH
         5dPY7gDcjyzL1NWW1X2ncVsjkF6QhtYP7RQHmnEoMps8lvFj4AD1x5mOgiioogJ7rQes
         ptOPHUlaQxfCvK11m8yf6nK4osPg7SJ/0OlgJLs8rZ54wKOd+gBOGsq9JVM0qNRmytht
         a9JOISPIiSmiBSFaVjn0cXwTL5pg/tRw/MwSnir2eGy9535jhzVN84wpsDuJlO7q4p0d
         Vu6Dy3fhIeBtKOFciHLuIIlx98ro9Za5igSIf8AFxvJfF6HdOUKtYdFGKBx2SJkjD3Ex
         G7uQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Michael Scott <michael.scott@linaro.org>,
	Jukka Rissanen <jukka.rissanen@linux.intel.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 157/241] Bluetooth: 6lowpan: fix delay work init in add_peer_chan()
Date: Mon, 19 Mar 2018 19:07:02 +0100
Message-Id: <20180319180757.671943434@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391496612397287?=
X-GMAIL-MSGID: =?utf-8?q?1595391496612397287?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Scott <michael.scott@linaro.org>


[ Upstream commit d2891c4d071d807f01cc911dc42a68f4568d65cf ]

When adding 6lowpan devices very rapidly we sometimes see a crash:
[23122.306615] CPU: 2 PID: 0 Comm: swapper/2 Not tainted 4.9.0-43-arm64 #1 Debian 4.9.9.linaro.43-1
[23122.315400] Hardware name: HiKey Development Board (DT)
[23122.320623] task: ffff800075443080 task.stack: ffff800075484000
[23122.326551] PC is at expire_timers+0x70/0x150
[23122.330907] LR is at run_timer_softirq+0xa0/0x1a0
[23122.335616] pc : [<ffff000008142dd8>] lr : [<ffff000008142f58>] pstate: 600001c5

This was due to add_peer_chan() unconditionally initializing the
lowpan_btle_dev->notify_peers delayed work structure, even if the
lowpan_btle_dev passed into add_peer_chan() had previously been
initialized.

Normally, this would go unnoticed as the delayed work timer is set for
100 msec, however when calling add_peer_chan() faster than 100 msec it
clears out a previously queued delay work causing the crash above.

To fix this, let add_peer_chan() know when a new lowpan_btle_dev is passed
in so that it only performs the delay work initialization when needed.

Signed-off-by: Michael Scott <michael.scott@linaro.org>
Acked-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/bluetooth/6lowpan.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -755,7 +755,8 @@ static void set_ip_addr_bits(u8 addr_typ
 }
 
 static struct l2cap_chan *add_peer_chan(struct l2cap_chan *chan,
-					struct lowpan_btle_dev *dev)
+					struct lowpan_btle_dev *dev,
+					bool new_netdev)
 {
 	struct lowpan_peer *peer;
 
@@ -786,7 +787,8 @@ static struct l2cap_chan *add_peer_chan(
 	spin_unlock(&devices_lock);
 
 	/* Notifying peers about us needs to be done without locks held */
-	INIT_DELAYED_WORK(&dev->notify_peers, do_notify_peers);
+	if (new_netdev)
+		INIT_DELAYED_WORK(&dev->notify_peers, do_notify_peers);
 	schedule_delayed_work(&dev->notify_peers, msecs_to_jiffies(100));
 
 	return peer->chan;
@@ -843,6 +845,7 @@ out:
 static inline void chan_ready_cb(struct l2cap_chan *chan)
 {
 	struct lowpan_btle_dev *dev;
+	bool new_netdev = false;
 
 	dev = lookup_dev(chan->conn);
 
@@ -853,12 +856,13 @@ static inline void chan_ready_cb(struct
 			l2cap_chan_del(chan, -ENOENT);
 			return;
 		}
+		new_netdev = true;
 	}
 
 	if (!try_module_get(THIS_MODULE))
 		return;
 
-	add_peer_chan(chan, dev);
+	add_peer_chan(chan, dev, new_netdev);
 	ifup(dev->netdev);
 }
 
