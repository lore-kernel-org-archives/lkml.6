Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225rhMjwoMb1hFeRhN9Raym6Ov9u9Z/vi3hR2iwXv4pwcQJo/1gNJNUSbKbknkjHht0g/1zu
ARC-Seal: i=1; a=rsa-sha256; t=1517591519; cv=none;
        d=google.com; s=arc-20160816;
        b=ZQAjRoz0GrEYOMhLIIeM3Trn8mqdhVZekqB38KpA+qtsoqgo55U7fGfde+ZyFnLPhA
         nFFunRaNQ3cKuVSurs1zAioQryjy737IqzEa20NyM7qS93iEaiITC/RF1Bn0HpRpYJVk
         xvY9qJ1Cubvwbb+F7wyDiuaIW/9UG586Z31mfrKZ9+J20a4YL/gYncbkfY2U6pyPgifE
         Gob0fBWgCGPN1H74+X0exJzr6JVgFxRkGkn43QREmb9MdZ/j/v3TyEOl0NTpTj2dI76F
         4hAe4ca7mfQ6E5i5+mIrgVqd51gW7I+y8oSTuN84TLbAco1bVv1Y7YPQLYJps+O5phyX
         TIxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=6xwpLGNt3mRfye0gqxbtQaGRabZxPjoFKhhAvu2FPhE=;
        b=xgXEOyhFS3pex5SSzdC5yew22LXIbKTBJL7CVH6cAU5QiLnXyTg9M0AZ3y9YcqauwM
         dRFirFjfaSW2geTk8w+PpswF1mVnQoFHpWk9zxwqOFVOeAE7DRosFe1PVbvPXddix4Mb
         1cvJFYjunLs9kSzAu0CyvG+vF8itPbzUqHbP0Ovi3rqmYSudxPkL0ayrNGzSNeO2eJQG
         8j/aHEkE5MvmLt67jsLdGB3qvGEVWyueBt12r/F6T8/lV2lgGOte2QGTdj/9sm6FkYwD
         9w/HfBsElwExHSdEmYWc3f3+Fie8nq10gezrFOge3Nvc4xjTS8dnpc+MdCkgpYF96H38
         V6pg==
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
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 100/156] net: ethernet: xilinx: Mark XILINX_LL_TEMAC broken on 64-bit
Date: Fri,  2 Feb 2018 17:58:01 +0100
Message-Id: <20180202140844.737064475@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309373573918616?=
X-GMAIL-MSGID: =?utf-8?q?1591310045249430470?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
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
