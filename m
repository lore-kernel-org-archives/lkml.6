Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELu8gGz0m3qass26ZEn9927oRzESkK9G74eDS4hSx5Ixj7/Ta0jkCQQh+eBt/zZhDpDnjw1p
ARC-Seal: i=1; a=rsa-sha256; t=1521483212; cv=none;
        d=google.com; s=arc-20160816;
        b=APA9ZKXV1J0HyzXkkR9Wh4jg5lwrQ5rseiJ3/ACw7CaLVnmwuKQ0dg3G83Fua1UZJk
         WYK4pUrTZWh/jT3hSeQEB+JhY/ZRMU3WJQVMHHJ3WRLBpIQ1/idcXv9TRC3XRSMNF3vo
         o5+41F296ZQfdN2cvLxAxwmb4e3cGkYz0LXBgbr48qjuVbcuCV5XI8UABq64xEStAj5g
         xSotSUI1Uqb8iRYHU9+PnKaxkjPz4+D2EWRlQ6H0M7XKfAQ36nrI33Dn8lAr8owMYwL8
         tUAMguctaUoVGEW/A/YGQBVFYtvhH5IE9ukH4DH4CNfA3ns532hpaRhk2COSJVyWJ1zz
         6+RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=oSjX3Q8NZEkHKGnujRZCkWodxDXPUBRWPNGTZnUSlJU=;
        b=sjwvPVhbBRKhJGbthOp9wQvrmPbET47FTBNH7Dv6Z/amKiQ0VhebGCLbU3aqTkbjKy
         odwTWi85e1kI/Yw6AelkAbsWB5b5EtIn2ex/5yo0Dsmbh9OjsafRbgowheRwUrq2JxLb
         yVWeI6KG0lmSlWlUf69OX4DPOJPzf9qYHPwvtkBnTEbIv9BHVGJNUz5o0/5OZxWlPx7X
         KbBxiAWKgTgV48H+2ZGgD9EwighSf1y0zN713U3AEEZbtYFEb/X3laQtSAwOIOhpN3uh
         zEbScTnel19RdGoUxE/8FqE31MxPOr9n6+Y/SjI3IwfeIYf07+oWpFtee3Tv7P8bLtEU
         A/UA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 008/134] net: mvpp2: set dma mask and coherent dma mask on PPv2.2
Date: Mon, 19 Mar 2018 19:04:51 +0100
Message-Id: <20180319171850.300796587@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390557556706046?=
X-GMAIL-MSGID: =?utf-8?q?1595390780462437336?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>


[ Upstream commit 2067e0a13cfe0b1bdca7b91bc5e4f2740b07d478 ]

On PPv2.2, the streaming mappings can be anywhere in the first 40 bits
of the physical address space. However, for the coherent mappings, we
still need them to be in the first 32 bits of the address space,
because all BM pools share a single register to store the high 32 bits
of the BM pool address, which means all BM pools must be allocated in
the same 4GB memory area.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/marvell/mvpp2.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- a/drivers/net/ethernet/marvell/mvpp2.c
+++ b/drivers/net/ethernet/marvell/mvpp2.c
@@ -6448,6 +6448,20 @@ static int mvpp2_probe(struct platform_d
 	/* Get system's tclk rate */
 	priv->tclk = clk_get_rate(priv->pp_clk);
 
+	if (priv->hw_version == MVPP22) {
+		err = dma_set_mask(&pdev->dev, DMA_BIT_MASK(40));
+		if (err)
+			goto err_mg_clk;
+		/* Sadly, the BM pools all share the same register to
+		 * store the high 32 bits of their address. So they
+		 * must all have the same high 32 bits, which forces
+		 * us to restrict coherent memory to DMA_BIT_MASK(32).
+		 */
+		err = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
+		if (err)
+			goto err_mg_clk;
+	}
+
 	/* Initialize network controller */
 	err = mvpp2_init(pdev, priv);
 	if (err < 0) {
