Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuh8rC0N6BsvreeJrS9TpTML+s1MCWNvlXLd0ru6wvWnTN2I7IV8ipKwUShGubIIsNYT0nR
ARC-Seal: i=1; a=rsa-sha256; t=1520451751; cv=none;
        d=google.com; s=arc-20160816;
        b=mYYoDL2ZVZAM5/EJPoYvKVlORwoG0Nj+4nJPRQ0Eo8kWEYbIbORrevBQo6PTo4aYYo
         EwXFDIUO8m6WKOQMW9Brok+od/rywnt0AzswBUa5EdnInOc4PqCCMFY03kxFnTWsM1FL
         GTxVImHgD0foifz/ncmoZvFgi953ZhNNjOlDrYA0kiQrpL66u1soiW7YCFuCxXdTb2/k
         Ut7Vr7NIUulgh64uGr1NrB5GjVR7vFlbvvDXou8hBkGf0mcT5h/WWB/zrnqYTEXsDKh1
         0DbrKclMp8QYRBcoxP8jCw3aT0HXzS26sPE36OnRW0hQXei+M9kBTO/3njlVITLyd7qe
         FQkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=HHzmLQsFhQlCp2YYQwJrEosGpWQl39wfo257AD8jYJk=;
        b=Lqe8r11FR9tHK4ntvKgZQeFgyCUfZlRv2+mt2kzIrWZfd3NSPDJ+xIqd+pUdacUXQj
         fBMxB2DZq2KZ554HhIrNBPuDVh+XiYjrG6av4shGBlHI3XRlPjzWC+7sUKfyX0AMIhGC
         /3seK/I63cis0p/tUurDM7N3kJMwLxL316lqroRALmWafw5rCeUDFtHxd5FFApSDwYek
         MQv0rF7JgMil0phXRG3hDL3Hy2VPlfKIVIKvcXevEt8veDsTwYw5dHqaOCLZZnGLLZR/
         mCuUoO/M841OS4FhWCoEImUb79LPiZR5pHIGaGZH32JAGXPOmAf5O6M+hFSnhd4nLefo
         ImkA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 071/122] amd-xgbe: Restore PCI interrupt enablement setting on resume
Date: Wed,  7 Mar 2018 11:38:03 -0800
Message-Id: <20180307191739.608278488@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309215205730962?=
X-GMAIL-MSGID: =?utf-8?q?1594309215205730962?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tom Lendacky <thomas.lendacky@amd.com>


[ Upstream commit cfd092f2db8b4b6727e1c03ef68a7842e1023573 ]

After resuming from suspend, the PCI device support must re-enable the
interrupt setting so that interrupts are actually delivered.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/amd/xgbe/xgbe-pci.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
@@ -426,6 +426,8 @@ static int xgbe_pci_resume(struct pci_de
 	struct net_device *netdev = pdata->netdev;
 	int ret = 0;
 
+	XP_IOWRITE(pdata, XP_INT_EN, 0x1fffff);
+
 	pdata->lpm_ctrl &= ~MDIO_CTRL1_LPOWER;
 	XMDIO_WRITE(pdata, MDIO_MMD_PCS, MDIO_CTRL1, pdata->lpm_ctrl);
 
