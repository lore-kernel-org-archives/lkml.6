Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227aHKOw/3L5UZcGpC1FUyKl3BRm3oRf/3/miL8K3hv1Xqkxe6sDCxpMME/TCeMAWGm/PhDP
ARC-Seal: i=1; a=rsa-sha256; t=1519410878; cv=none;
        d=google.com; s=arc-20160816;
        b=t2Pz3wyZsUvwJkyqoCt7lVuktnPSTtVkduiNxCHkz5UPKzky6fLHtZSI0/PFVtKqpF
         2t5cnP9wBM2ZZq3yNDIJPnI5FxMz+eYJ0AJYt+RrLGzHFehJxjHu0oeubgmaLCf7Vecs
         i6kRHiICH7mIA3O9dT3FimS425J8XocNe6nXJ00OuD9OLnZmkE+qFlYsWgzVij50rHc9
         PFur1NvEyPsheFJipgmqgOJcoZyqcpz2FeKjqxU53EmuTckGzIoD76c80CqqJQr51rax
         wkBze7lEKpXX0WtDnQOVPgkh/UDzunXkPib7bla4YUb21FwSXbcdaEjPjS0cj8SCx61C
         6dbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=k0X8iWy3nNcHjE/9yQiJv97QMOVckbaudYA/12Jlslw=;
        b=nyCvktZnQygTF2+CZYWaFPXNwkbkfw3DB+KKky3nR+QMuniHbBgzb9u7vOXmsMMGDz
         eJYVSbWMGtpqboDM/HRyb6f3/g55cap8hBEyHzIDCBhMHXM//uP5lH/JPR+Jvl0Tkqth
         5w2Sg7tACMqnFOEzdTjQQJAfV4CuaRPuYprK1uSi9+m4YQTfUXLEe4UA3pWHAurmLFg9
         dH7JN7AbjzsYW/pXJoeQLUPcm6EJoRNMa/HjmIQCCt6UNnrd5YyMlebffu9ZPetESOIt
         yPKiWWQAsbypc+PKssYWf+ovrgiAJtpNLaJ6QXIifwhTGvD193K7JU3KY9G1WhlB2lyO
         TmDw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Zumeng Chen <zumeng.chen@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 045/193] gianfar: fix a flooded alignment reports because of padding issue.
Date: Fri, 23 Feb 2018 19:24:38 +0100
Message-Id: <20180223170333.056361099@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217651736997549?=
X-GMAIL-MSGID: =?utf-8?q?1593217780923020415?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zumeng Chen <zumeng.chen@gmail.com>


[ Upstream commit 58117672943734715bbe7565ac9f062effa524f0 ]

According to LS1021A RM, the value of PAL can be set so that the start of the
IP header in the receive data buffer is aligned to a 32-bit boundary. Normally,
setting PAL = 2 provides minimal padding to ensure such alignment of the IP
header.

However every incoming packet's 8-byte time stamp will be inserted into the
packet data buffer as padding alignment bytes when hardware time stamping is
enabled.

So we set the padding 8+2 here to avoid the flooded alignment faults:

root@128:~# cat /proc/cpu/alignment
User:           0
System:         17539 (inet_gro_receive+0x114/0x2c0)
Skipped:        0
Half:           0
Word:           0
DWord:          0
Multi:          17539
User faults:    2 (fixup)

Also shown when exception report enablement

CPU: 0 PID: 161 Comm: irq/66-eth1_g0_ Not tainted 4.1.21-rt13-WR8.0.0.0_preempt-rt #16
Hardware name: Freescale LS1021A
[<8001b420>] (unwind_backtrace) from [<8001476c>] (show_stack+0x20/0x24)
[<8001476c>] (show_stack) from [<807cfb48>] (dump_stack+0x94/0xac)
[<807cfb48>] (dump_stack) from [<80025d70>] (do_alignment+0x720/0x958)
[<80025d70>] (do_alignment) from [<80009224>] (do_DataAbort+0x40/0xbc)
[<80009224>] (do_DataAbort) from [<80015398>] (__dabt_svc+0x38/0x60)
Exception stack(0x86ad1cc0 to 0x86ad1d08)
1cc0: f9b3e080 86b3d072 2d78d287 00000000 866816c0 86b3d05e 86e785d0 00000000
1ce0: 00000011 0000000e 80840ab0 86ad1d3c 86ad1d08 86ad1d08 806d7fc0 806d806c
1d00: 40070013 ffffffff
[<80015398>] (__dabt_svc) from [<806d806c>] (inet_gro_receive+0x114/0x2c0)
[<806d806c>] (inet_gro_receive) from [<80660eec>] (dev_gro_receive+0x21c/0x3c0)
[<80660eec>] (dev_gro_receive) from [<8066133c>] (napi_gro_receive+0x44/0x17c)
[<8066133c>] (napi_gro_receive) from [<804f0538>] (gfar_clean_rx_ring+0x39c/0x7d4)
[<804f0538>] (gfar_clean_rx_ring) from [<804f0bf4>] (gfar_poll_rx_sq+0x58/0xe0)
[<804f0bf4>] (gfar_poll_rx_sq) from [<80660b10>] (net_rx_action+0x27c/0x43c)
[<80660b10>] (net_rx_action) from [<80033638>] (do_current_softirqs+0x1e0/0x3dc)
[<80033638>] (do_current_softirqs) from [<800338c4>] (__local_bh_enable+0x90/0xa8)
[<800338c4>] (__local_bh_enable) from [<8008025c>] (irq_forced_thread_fn+0x70/0x84)
[<8008025c>] (irq_forced_thread_fn) from [<800805e8>] (irq_thread+0x16c/0x244)
[<800805e8>] (irq_thread) from [<8004e490>] (kthread+0xe8/0x104)
[<8004e490>] (kthread) from [<8000fda8>] (ret_from_fork+0x14/0x2c)

Signed-off-by: Zumeng Chen <zumeng.chen@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/freescale/gianfar.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/freescale/gianfar.c
+++ b/drivers/net/ethernet/freescale/gianfar.c
@@ -1375,9 +1375,11 @@ static int gfar_probe(struct platform_de
 
 	gfar_init_addr_hash_table(priv);
 
-	/* Insert receive time stamps into padding alignment bytes */
+	/* Insert receive time stamps into padding alignment bytes, and
+	 * plus 2 bytes padding to ensure the cpu alignment.
+	 */
 	if (priv->device_flags & FSL_GIANFAR_DEV_HAS_TIMER)
-		priv->padding = 8;
+		priv->padding = 8 + DEFAULT_PADDING;
 
 	if (dev->features & NETIF_F_IP_CSUM ||
 	    priv->device_flags & FSL_GIANFAR_DEV_HAS_TIMER)
