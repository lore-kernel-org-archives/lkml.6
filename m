Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuiUvJYAKS512RDhjVOfGYcbssQVtDGhVOuuK/AQxNHONfWgBLOw0T2Lb2ga8W5M0iphMda
ARC-Seal: i=1; a=rsa-sha256; t=1521482999; cv=none;
        d=google.com; s=arc-20160816;
        b=iMTFN1GzVy8kSqdnvINO4hDSLgGe8OO/BZ+rMhsvAovBI4EGW/0skRcVp/iiUlr3Uo
         5XLuhmHmHdrY8xnmo7l5ETgX9if1TLZVREeDkOGyab8tKNZers9O1WJp8TifoJ83iRPF
         lx68NzAvj9vxjlCK0woEmVpdCNORRdX2zkkw0kQyj3+eksKjeTuKB38I45Mcyo46/eDR
         LgBe6RfxLRawWSe/prc5G84iWJgnayzUs89gb/AK3CBGJNRg8sOjJ5f7Axn0Lg5auF7k
         EEUqBsrgXG8CYl9Ttl0z6E1ZK0fnjBxEVSpuFV+3RZJSJbF/iDIyg0mXKfRM2W3H+idU
         jSRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=y0hpjRBIF9UckbKoSU/cR0ZzCEUz0ty+tPE+cU5DN5E=;
        b=l0sVDkaOG4ecYbAW/HlMCyWKFaNY1RKO8Jxcstlm8H88OwaT/gXe9eDa7QyAOPIomu
         PuLhrdTZUysiIFH+txao/yTcFSuULZCUHR89E3EyWKLIosboZ0UMfCuQeCDuIYKdaNZV
         fMt1o8i1Qq2EFJBXvVDKL8w2u30MPpk3T6i5tfyMoM/4ZUo6fK9236HmxCLrFCLmrvZc
         2QCuD8TuBD8/xdmExPbX6A7Pi7cb7pwUJ0DeXi6yggwrbQojcb7onNtUBkumEG8nagF2
         8qgCN43xJ/7Yi5flaxnFVIsS+FrFv8o6Mn07pdwbAMR3mFGSq+Rnc4knGkBZuOjvNBrw
         B/6Q==
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
Subject: [PATCH 3.18 03/68] net: mvpp2: set dma mask and coherent dma mask on PPv2.2
Date: Mon, 19 Mar 2018 19:05:41 +0100
Message-Id: <20180319171828.377722653@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171827.899658615@linuxfoundation.org>
References: <20180319171827.899658615@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390557556706046?=
X-GMAIL-MSGID: =?utf-8?q?1595390557556706046?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -6339,6 +6339,20 @@ static int mvpp2_probe(struct platform_d
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
