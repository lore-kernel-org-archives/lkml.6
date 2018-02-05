Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226A0jxo7k6sZFA1fZ9jlecniPGblzX0UnioApS4g2abWN4hoX/bG54mz2eGjG8mudvDGo1I
ARC-Seal: i=1; a=rsa-sha256; t=1517855178; cv=none;
        d=google.com; s=arc-20160816;
        b=pwHR/2D1RDILs9aid26wGphTq+i3LSDJ39KRBUEKxYHuEKn6NtWsR9Mfp/uUFOkla8
         K2dOGUDCR8OJ7G5YoWBcAHhCaowwMzFdNU55NUZOZfJamrlfZgi/3EBWk2xitMknYlBN
         ghMS+twVA5k3u/YKVFx17mmP/0YkRS9zu6FxySxUvhCMQ0J3EPn86lun6/+UOrP5A9YP
         rGBFD3A9uN4TQjAuehxZPertDGdsvDZQBCHCrvDoOor09+xsU3tfJFunFW10m1JyZsFW
         JrnSIo8x8BisMWPxy11zmwWBdjlhPsPn44MxpY0xiBEuzwNNslCgHip5rlPZWFxxV/rd
         MzYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=A/XOia3O2ddlduaH21HMOEIydC3i/wIzUp0xcoqrF6Y=;
        b=zChYyBCzZREk2cYF++dD/VslVd971tuxDQ1LWKn2pz6C1FfjmM0pxLdarg3G0MDsB6
         XWmV9oH96cz+wcfhJWPgSs+SshiGWSyg87issLfmcy0nGCkvBKGf4x+rF54ur3PbYKv3
         vvvdh+MZ7hq0EV+/L2Cp1Jj0fdKn3URyIHNtekD81L5HL6kKN0MOUrRKnhXfwcymPuDi
         WgkWvP3xtc0sRNKOuMIuENjmIXwZhDRAy6gzP+VGLoVvrvQ5vjsAqf1aCt/IKmGCqTHG
         VaRFMnOxIgE3eCI1DRFBGJH0Yd7Olzt00OEFY4TBhrJMSMpT3S2Wy4w6KIhd1R2LwaDl
         PVmw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 19/36] net: ethernet: xilinx: Mark XILINX_LL_TEMAC broken on 64-bit
Date: Mon,  5 Feb 2018 10:23:47 -0800
Message-Id: <20180205182352.570841355@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182351.774761393@linuxfoundation.org>
References: <20180205182351.774761393@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586511726120001?=
X-GMAIL-MSGID: =?utf-8?q?1591586511726120001?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -36,6 +36,7 @@ config XILINX_AXI_EMAC
 config XILINX_LL_TEMAC
 	tristate "Xilinx LL TEMAC (LocalLink Tri-mode Ethernet MAC) driver"
 	depends on (PPC || MICROBLAZE)
+	depends on !64BIT || BROKEN
 	select PHYLIB
 	---help---
 	  This driver supports the Xilinx 10/100/1000 LocalLink TEMAC
