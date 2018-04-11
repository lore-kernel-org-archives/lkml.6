Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+IED1LkJXHXln4pUCIZ7aUxvjXHHynArvaKcmHhCxyd1LFT/k7BDZenHEsz1b6lOQL28QM
ARC-Seal: i=1; a=rsa-sha256; t=1523473191; cv=none;
        d=google.com; s=arc-20160816;
        b=EllFrAF9yGP0pNdSjH5dusObUoVviuxOiP4i05v+j7EJdkeguzZ8B5B0DQwkuxB5nC
         jkjYJv1TUfz10hLaDOc0OmldpkBaiF/f33uHUPiqpAe6M1gJ58QZE18qbxF8hQd1zaXE
         DzBqtIJOSHffNDXZjbLMx0L0cjMjZg3xjRbN9VZIvXy+tdDv3vZrHgVTSAMEIk9GWqsG
         kGsKgOox2G/9JUvgWQS13r6UbYsX60MkUlLJw+28Iil5U0yEzwBzq33YVo65GSthpci/
         jCEZ40glpJSntBvpiZOU0ouLSFVAjd7DJzFKyxdTy5p4cH1gtuz9TsPyeZok41IMOAo/
         pfaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=0aRwkOq6G6CJO2frDX18YjC26FdqQ9zMRG+6ogftolE=;
        b=QtNrv6XTYqyQ/ekfL51qyjK4Dfu3xBxd++dNEamWLcGVD8CFMYqLFqNRS6386WRVOT
         0yg5zChgG+t6SDv7rerNpXELevUvcWkfqpUJ/2EGek9oqgyl74NJRTZB+vEFG3XmymQJ
         QG3LVFWgEj/vHHYpQ4tog6KpfRsUHCL1QX813aPGWBam6QD++/+iRzhEJS/rpBG5DLYv
         svJ/MAKVyP41DXarAzvTijeKPj+2wgvTX0MLr41cFGv4PG9Gz2nZSMCqgvikf4vIlizB
         LbuJM4XMw3WuQfoomwuEq3LvPa62rMREa6L8L0C+E+QddbT8XLFx4gm7ljkhe/hePhNE
         GzxA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arjun Vynipadath <arjun@chelsio.com>,
	Steve Wise <swise@opengridcomputing.com>,
	Ganesh Goudar <ganeshgr@chelsio.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 159/310] cxgb4: Fix netdev_features flag
Date: Wed, 11 Apr 2018 20:34:58 +0200
Message-Id: <20180411183629.234879736@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597477425550607885?=
X-GMAIL-MSGID: =?utf-8?q?1597477425550607885?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arjun Vynipadath <arjun@chelsio.com>


[ Upstream commit 90592b9a35836bacd34d92a3aba7958756b6a7c0 ]

GRO is not supported by Chelsio HW when rx_csum is disabled.
Update the netdev features flag when rx_csum is modified.

Signed-off-by: Arjun Vynipadath <arjun@chelsio.com>
Signed-off-by: Steve Wise <swise@opengridcomputing.com>
Signed-off-by: Ganesh Goudar <ganeshgr@chelsio.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
@@ -2742,6 +2742,16 @@ static int cxgb_setup_tc(struct net_devi
 	return -EOPNOTSUPP;
 }
 
+static netdev_features_t cxgb_fix_features(struct net_device *dev,
+					   netdev_features_t features)
+{
+	/* Disable GRO, if RX_CSUM is disabled */
+	if (!(features & NETIF_F_RXCSUM))
+		features &= ~NETIF_F_GRO;
+
+	return features;
+}
+
 static const struct net_device_ops cxgb4_netdev_ops = {
 	.ndo_open             = cxgb_open,
 	.ndo_stop             = cxgb_close,
@@ -2766,6 +2776,7 @@ static const struct net_device_ops cxgb4
 #endif
 	.ndo_set_tx_maxrate   = cxgb_set_tx_maxrate,
 	.ndo_setup_tc         = cxgb_setup_tc,
+	.ndo_fix_features     = cxgb_fix_features,
 };
 
 #ifdef CONFIG_PCI_IOV
