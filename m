Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227vYC2KGgWTsjy4mQECa28MI/7eEUvDad6vVDhihB+6787EWNEswGGe4y5a4HtjcQ188XNb
ARC-Seal: i=1; a=rsa-sha256; t=1517590878; cv=none;
        d=google.com; s=arc-20160816;
        b=KNKKZEIxmsrJt0iRfZPXVGwaZA4fpO8Q+aB8PuGMhpUkvrrSO1GfrnQ84Fwz2QvSK7
         JZiBajRv8IvxTKlrvikCWfNHhYW5e5ARaYGdHB4mP81iXtBTRMjZBFAA4OLXkpfAmj2N
         eRlsfkxVZGQUihX1ImuSpSLDJWde+uDTmsImqiPiKqVt0TRaA7FMEyqGBU17X67WUFbG
         LoVNtgoiUd/t/wZY+JSahLbdFLFnaV20kuN4xEoL0LFKHXpZpxqAC+9hsliARHCZpaEn
         AMcKm7h/f1+6DkoLWa+N9tpWU1r5cY6/UDq7HMk6sMkIhSG4gz3kbQ16PPAbGEEVzdW5
         7uGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=CVI63uG8wKTt1xkqKX1SNG/Fq7Oq3R9CBQBcyGoREQA=;
        b=rkKLbO58h5zy3RESM4nsQ1gpuX9r4xGh7Zj/lazvcsbejMkCi/VlScPeveqgzgERul
         VuMlJ08PQrX9kba0K9HIbT4bzARc6z/MnKaAIlZVtQzpXQXsZMdIT8o1izGlA9+njLQu
         BW9IaFoLlmtkUGhurT06yxOa+8/uvb8wr7up7O8r8TXB65puD4FU7VMuAPq3fBR+xNM4
         bnWjlDkGfvesVKNa3U1Dm7e52QebcDmgY2uX/HfqlMCeX/UJ0dfpL7b4yS9dcJc+fY/K
         ocXVcsXsAevGqWTNIHQz8NJZfLg6+rm+V3NSadc9aS6xdZwhW5vYmZ9vr0RAHcaz7Thj
         /9HA==
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
Subject: [PATCH 4.4 44/67] net: ethernet: xilinx: Mark XILINX_LL_TEMAC broken on 64-bit
Date: Fri,  2 Feb 2018 17:58:13 +0100
Message-Id: <20180202140820.323438020@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140815.091718203@linuxfoundation.org>
References: <20180202140815.091718203@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309373573918616?=
X-GMAIL-MSGID: =?utf-8?q?1591309373573918616?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
