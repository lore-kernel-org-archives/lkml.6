Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224AEs78M40OHs0DOF/gVLophZfCXTIoQCdxvYn0Nemm8XbsAFUT+UcKnDQH6Iwx+NWwgX2h
ARC-Seal: i=1; a=rsa-sha256; t=1517591176; cv=none;
        d=google.com; s=arc-20160816;
        b=GYs39dcjjoi4ZXxKs2+W+6T+MG8jPOjHr14f3ssmO+7kKRB7ZmtGOWOI0UIQTYiTBi
         DVZn02E/yAIM4U+dUQaYU9QR62D8cll2+HeuGbCBjcZFc9EwMWnxAq9Sqjxnl2fVp7qv
         9AAArKhD0o8Lf28A7JyzRrbmCfBGFDF63nXZIyAgXiO9+hD3jdS0qc7CkJNq/oVpOhVL
         oL5CSa8aucjDcMcIUv3IB4+zPsElFYtaTiGcE5Xzwv+3GRl0zgWiTcyGvNiKIF8EB7lv
         2EF1KMxXs0ceeDNMWNT5wbs+qz6lWvCkJ5m/eNHfuXzwsYTaCX2RTnYXs97bRWlzi8RD
         W5mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=F96jAw0cLjXeR7Fdf0GAXiDSg7KwP8FpIMV9ZLrql6w=;
        b=roZ8hK5PTSbLYVNiLytaf+Wr8Wv3axIo+NVGBqOEVmxV6YvHWpRxuxut7d4ugSjwSh
         ms6B9U1nTGGfLzl3grEDtSbc3b6JGdVqZX99bpcX64zvQ3cNlBKMpzuFmGGowflU9Re3
         rK4BMihXkYiF8PayVcpL/q6+wmxLyH9igDnB1V5ggeYR/J/rIZ0+IewrVQP8UD0QbKXh
         6hucgdoLcGh5zUEycyYw0QtzBrmb0PzuQjwAxVOSrO9He5jPNr/N2KM3LcIKbE38LTd7
         v6dgaRmWg5nuGskxRaMAfmMAzpys0BhGJYq7rynpuMEb89F+6FMmCX3eIOzsOPvoHIR6
         9W/w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 50/86] net: ethernet: xilinx: Mark XILINX_LL_TEMAC broken on 64-bit
Date: Fri,  2 Feb 2018 17:58:10 +0100
Message-Id: <20180202140826.853467548@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140822.679101338@linuxfoundation.org>
References: <20180202140822.679101338@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309373573918616?=
X-GMAIL-MSGID: =?utf-8?q?1591309684661072195?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert+renesas@glider.be>


[ Upstream commit 15bfe05c8d6386f1a90e9340d15336e85e32aad6 ]

On 64-bit (e.g. powerpc64/allmodconfig):

    drivers/net/ethernet/xilinx/ll_temac_main.c: In function 'temac_start_xmit_done':
    drivers/net/ethernet/xilinx/ll_temac_main.c:633:22: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
	dev_kfree_skb_irq((struct sk_buff *)cur_p->app4);
			  ^

cdmac_bd.app4 is u32, so it is too small to hold a kernel pointer.

Note that several other fields in struct cdmac_bd are also too small to
hold physical addresses on 64-bit platforms.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/xilinx/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/ethernet/xilinx/Kconfig
+++ b/drivers/net/ethernet/xilinx/Kconfig
@@ -34,6 +34,7 @@ config XILINX_AXI_EMAC
 config XILINX_LL_TEMAC
 	tristate "Xilinx LL TEMAC (LocalLink Tri-mode Ethernet MAC) driver"
 	depends on (PPC || MICROBLAZE)
+	depends on !64BIT || BROKEN
 	select PHYLIB
 	---help---
 	  This driver supports the Xilinx 10/100/1000 LocalLink TEMAC
