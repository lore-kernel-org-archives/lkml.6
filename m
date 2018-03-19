Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELt2Cl23jz+K/4eugKnn5sQ49Ra5QSnp5PzVnotO2xMhechkVI7AjMeUU/g29gOatpaj9yEg
ARC-Seal: i=1; a=rsa-sha256; t=1521483513; cv=none;
        d=google.com; s=arc-20160816;
        b=zFRCrHSC5OG1x9fw8DOyeDN+HfOiWPvr1Z2po+HqKLtg2T/n6dJvgRb92WBvEGX3hS
         WXx5a44niMDbnbQge2X0zeX+lmqSPr7eqY0/zF92ADtvv66M7sgQuF76CZbNfQSp6Fel
         6jGbclyflF/eb2q5PSvpKUR93gdHo6F2BjCCSj1W+6NFjSjZ8unXaepPhzWbRWXGjhBu
         K+GW9JimNCPLcIe+5R8aWR2UwBDd69Ou+FRoYLeYwOw12fapHjLs+F7n758+iPmNC/0L
         DIV1QUxKvfe5sW9Ql4WwjFdRxeqqHKlZrYoZQRpUt0f917euYpXfkPQHqDDsnKnYl694
         FaeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=7uun66CoH6yGtz9KrI99Zp3bV5lTO8Wws8sEC/3vCUQ=;
        b=b/aK4l8sP697iQvC0TqzkRvIMw1TWG5M+vz5+KBMhiU6cXAV9C5RBbeooE0zzmd5qh
         sBKB2eEC/BOPS5qrWs86trmBZ1MGJ35CKQpj1ViH7BsIRPr7OZjvlNo01eJZFi0GLE0m
         XwGvecRU63icbNbQdp2dmhDYCsV8mFq1RieDRjJMbUFoEwQgFNms/ul7K/WYvc7ThMqU
         t6Zoxlj3uqgCiWWgd5L7ttVq6bHIhcO9lbj9MqsSN2uCR4t5iAvusfIldFk4J1oDn3im
         NBDVmpr310O/TnPEyf8ZTSRCnefobjZLUMQBXqQReVTjXcz1D/8YAIDiZZ8cJUm3Txyh
         2boA==
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
Subject: [PATCH 4.9 017/241] net: mvpp2: set dma mask and coherent dma mask on PPv2.2
Date: Mon, 19 Mar 2018 19:04:42 +0100
Message-Id: <20180319180751.880741514@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390557556706046?=
X-GMAIL-MSGID: =?utf-8?q?1595391096373928476?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -6420,6 +6420,20 @@ static int mvpp2_probe(struct platform_d
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
