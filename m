Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqE9nL/zeJGvuzvhf+MtjzmnKRuwgG+W3uyypXuNdkHM/iAxdBzNhtx+sIy0brO5gfqN6R1
ARC-Seal: i=1; a=rsa-sha256; t=1527155636; cv=none;
        d=google.com; s=arc-20160816;
        b=U+IIG/GlUBLTXT/qMGYv9frmwYGY0y00dsurFHr4J8FZTsAwgm49UqxWw6tO4h3xOo
         sa9g4MbUtnEz5IT+f0IdYhFbzpB9wQTWkD7Xwfu3vPwXUFbkLi4fC0ZbkD5r4e7ouzgf
         bEW7brjIlZ0nUgLtxbzrDvOR78o1zoZQTmQrhzhsynxZygAl8cdKksQg5w9VQHkWYySW
         rz/fL0wwaa2dUlf407JQDSIEPxyLvEPo1coTY2jWT7u5enlqs8foEB6rlNxcCpTvKfL9
         dksUSFBvp8NQnceD2eBKs8GpspT/YVKqUjLISNToUfksqClm4iyxgtegNxjaNSqQXPqm
         Ej2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=LLsWZJ0lu9ByJ7hXvYTw6rrX9Khd+4R+Js6zcm8EoMM=;
        b=ffJXAGdJUUFGdFsGxyVpEg0ay4HBsWnuzk4ga/ZxxcSP27oSJ0gEy6eHv6Po2ctZ+B
         235Jf5nD3DEZL9lNOYRoPrnz9PLFtnZoVqWr4fp2vxHnovosj4A8uTKNv69IQyA2GKPM
         6z23VxXpioMWgOfsf4TDpY2pyZwPb/uecSSmQMEJ9JOcOS1GbF1kyaA/hrcwJx7hgSzW
         flWqA6CLQ3uEnORmzwpApyCkc+8k2MFh6J5Dg2pP23Kb+nqVGYKMIyQRvn5gNH0iI4UZ
         uxMf+s8WV97gRh9/WagpStgztjInlFXifOfaztTBBD8gsln2PXXPP7fpFNRJieda/DD+
         U9rg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=esf2ZcOw;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=esf2ZcOw;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Greg Ungerer <gerg@linux-m68k.org>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 061/165] net: usbnet: fix potential deadlock on 32bit hosts
Date: Thu, 24 May 2018 11:37:47 +0200
Message-Id: <20180524093624.488385643@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
References: <20180524093621.979359379@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338748906424578?=
X-GMAIL-MSGID: =?utf-8?q?1601338748906424578?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 2695578b896aea472b2c0dcbe9d92daa71738484 ]

Marek reported a LOCKDEP issue occurring on 32bit host,
that we tracked down to the fact that usbnet could either
run from soft or hard irqs.

This patch adds u64_stats_update_begin_irqsave() and
u64_stats_update_end_irqrestore() helpers to solve this case.

[   17.768040] ================================
[   17.772239] WARNING: inconsistent lock state
[   17.776511] 4.16.0-rc3-next-20180227-00007-g876c53a7493c #453 Not tainted
[   17.783329] --------------------------------
[   17.787580] inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
[   17.793607] swapper/0/0 [HC0[0]:SC1[1]:HE1:SE0] takes:
[   17.798751]  (&syncp->seq#5){?.-.}, at: [<9b22e5f0>]
asix_rx_fixup_internal+0x188/0x288
[   17.806790] {IN-HARDIRQ-W} state was registered at:
[   17.811677]   tx_complete+0x100/0x208
[   17.815319]   __usb_hcd_giveback_urb+0x60/0xf0
[   17.819770]   xhci_giveback_urb_in_irq+0xa8/0x240
[   17.824469]   xhci_td_cleanup+0xf4/0x16c
[   17.828367]   xhci_irq+0xe74/0x2240
[   17.831827]   usb_hcd_irq+0x24/0x38
[   17.835343]   __handle_irq_event_percpu+0x98/0x510
[   17.840111]   handle_irq_event_percpu+0x1c/0x58
[   17.844623]   handle_irq_event+0x38/0x5c
[   17.848519]   handle_fasteoi_irq+0xa4/0x138
[   17.852681]   generic_handle_irq+0x18/0x28
[   17.856760]   __handle_domain_irq+0x6c/0xe4
[   17.860941]   gic_handle_irq+0x54/0xa0
[   17.864666]   __irq_svc+0x70/0xb0
[   17.867964]   arch_cpu_idle+0x20/0x3c
[   17.871578]   arch_cpu_idle+0x20/0x3c
[   17.875190]   do_idle+0x144/0x218
[   17.878468]   cpu_startup_entry+0x18/0x1c
[   17.882454]   start_kernel+0x394/0x400
[   17.886177] irq event stamp: 161912
[   17.889616] hardirqs last  enabled at (161912): [<7bedfacf>]
__netdev_alloc_skb+0xcc/0x140
[   17.897893] hardirqs last disabled at (161911): [<d58261d0>]
__netdev_alloc_skb+0x94/0x140
[   17.904903] exynos5-hsi2c 12ca0000.i2c: tx timeout
[   17.906116] softirqs last  enabled at (161904): [<387102ff>]
irq_enter+0x78/0x80
[   17.906123] softirqs last disabled at (161905): [<cf4c628e>]
irq_exit+0x134/0x158
[   17.925722].
[   17.925722] other info that might help us debug this:
[   17.933435]  Possible unsafe locking scenario:
[   17.933435].
[   17.940331]        CPU0
[   17.942488]        ----
[   17.944894]   lock(&syncp->seq#5);
[   17.948274]   <Interrupt>
[   17.950847]     lock(&syncp->seq#5);
[   17.954386].
[   17.954386]  *** DEADLOCK ***
[   17.954386].
[   17.962422] no locks held by swapper/0/0.

Fixes: c8b5d129ee29 ("net: usbnet: support 64bit stats")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Greg Ungerer <gerg@linux-m68k.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/usbnet.c       |   10 ++++++----
 include/linux/u64_stats_sync.h |   22 ++++++++++++++++++++++
 2 files changed, 28 insertions(+), 4 deletions(-)

--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -315,6 +315,7 @@ static void __usbnet_status_stop_force(s
 void usbnet_skb_return (struct usbnet *dev, struct sk_buff *skb)
 {
 	struct pcpu_sw_netstats *stats64 = this_cpu_ptr(dev->stats64);
+	unsigned long flags;
 	int	status;
 
 	if (test_bit(EVENT_RX_PAUSED, &dev->flags)) {
@@ -326,10 +327,10 @@ void usbnet_skb_return (struct usbnet *d
 	if (skb->protocol == 0)
 		skb->protocol = eth_type_trans (skb, dev->net);
 
-	u64_stats_update_begin(&stats64->syncp);
+	flags = u64_stats_update_begin_irqsave(&stats64->syncp);
 	stats64->rx_packets++;
 	stats64->rx_bytes += skb->len;
-	u64_stats_update_end(&stats64->syncp);
+	u64_stats_update_end_irqrestore(&stats64->syncp, flags);
 
 	netif_dbg(dev, rx_status, dev->net, "< rx, len %zu, type 0x%x\n",
 		  skb->len + sizeof (struct ethhdr), skb->protocol);
@@ -1250,11 +1251,12 @@ static void tx_complete (struct urb *urb
 
 	if (urb->status == 0) {
 		struct pcpu_sw_netstats *stats64 = this_cpu_ptr(dev->stats64);
+		unsigned long flags;
 
-		u64_stats_update_begin(&stats64->syncp);
+		flags = u64_stats_update_begin_irqsave(&stats64->syncp);
 		stats64->tx_packets += entry->packets;
 		stats64->tx_bytes += entry->length;
-		u64_stats_update_end(&stats64->syncp);
+		u64_stats_update_end_irqrestore(&stats64->syncp, flags);
 	} else {
 		dev->net->stats.tx_errors++;
 
--- a/include/linux/u64_stats_sync.h
+++ b/include/linux/u64_stats_sync.h
@@ -90,6 +90,28 @@ static inline void u64_stats_update_end(
 #endif
 }
 
+static inline unsigned long
+u64_stats_update_begin_irqsave(struct u64_stats_sync *syncp)
+{
+	unsigned long flags = 0;
+
+#if BITS_PER_LONG==32 && defined(CONFIG_SMP)
+	local_irq_save(flags);
+	write_seqcount_begin(&syncp->seq);
+#endif
+	return flags;
+}
+
+static inline void
+u64_stats_update_end_irqrestore(struct u64_stats_sync *syncp,
+				unsigned long flags)
+{
+#if BITS_PER_LONG==32 && defined(CONFIG_SMP)
+	write_seqcount_end(&syncp->seq);
+	local_irq_restore(flags);
+#endif
+}
+
 static inline void u64_stats_update_begin_raw(struct u64_stats_sync *syncp)
 {
 #if BITS_PER_LONG==32 && defined(CONFIG_SMP)
