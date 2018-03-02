Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELusC3egS+WlCRucWnTHtHhB7ULP1nc6fHhB90CKqXlysk1HkEOcVRC+RS/UoISY5w1Wy40f
ARC-Seal: i=1; a=rsa-sha256; t=1519981252; cv=none;
        d=google.com; s=arc-20160816;
        b=l8VQzGsLsxtd6U0TA3Kyh5tplFKtt/nMZ9Vx82fXOZYe2WDVLmCUIhvGeXJPqpqeNs
         /iYGTlJxMutxfr9QNCgKAm630VHtTVd1HcqHx7+JllkoMJvPIIKsq8f6PzPKA5dIvLCp
         V5cmg/w99yj99qdAfQsOUhyzR92VeequeZQ/1e/veIaZwrVnSLHaKYZSDud3JCEBXnEk
         VvTn+XH6Xz1qA2YVN04cGMcj+9JezmlY00VU11EX46rZmVL6LIFDPFud4B5pmQRTrIuk
         MXkCalJy8uATl6Do4cWzEuJ7j2/OxRCYnd9oS92hMss2TYtRgAaCWXnDuer18wuw42Qi
         n2dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=nD/KEdhXMosT0FiQhS6qNUIYRDnQiKCMmMgA29tFBZo=;
        b=qEeHi5T4InLy0jPXmi3INLCpqm2iBukqz7RplHYelnrORrdd5Dcu0Neo1jcs7x3/6V
         1jHmX4pIOTqvfZsU9pGOueyUI49lwuLxMRNv9K9ptGh9AY7gjFrLON5oQmEG8zBNT2Lw
         GrBIHGwXD+9+w6nLg52zGrhizexqDi5ckj0d/x2VZ2KKwiV3J+zgBHoRzebrzNcs0Txd
         cFbjk14o08Fp6JNo7rAPWOZga1P9VPLcNB93di+vJzLjNbw3UFnXpz3YxCY0DawvmSVa
         piLA1NWlFcaBCQNPpX4rPjMKxmAYmctaFFT3WiFu0D79Mf2xPfH10J0F9kmW6IZNkCdp
         5RTA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Fredrik Hallenberg <megahallon@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 037/115] net: stmmac: Fix bad RX timestamp extraction
Date: Fri,  2 Mar 2018 09:50:40 +0100
Message-Id: <20180302084505.374403503@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815861960936258?=
X-GMAIL-MSGID: =?utf-8?q?1593815861960936258?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fredrik Hallenberg <megahallon@gmail.com>


[ Upstream commit a1762456993893795030d911106a7650481db0ef ]

As noted in dwmac4_wrback_get_rx_timestamp_status the timestamp is found
in the context descriptor following the current descriptor. However the
current code looks for the context descriptor in the current
descriptor, which will always fail.

Signed-off-by: Fredrik Hallenberg <megahallon@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/stmicro/stmmac/common.h       |    2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c |    5 +++--
 drivers/net/ethernet/stmicro/stmmac/enh_desc.c     |    3 ++-
 drivers/net/ethernet/stmicro/stmmac/norm_desc.c    |    2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |    2 +-
 5 files changed, 8 insertions(+), 6 deletions(-)

--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -409,7 +409,7 @@ struct stmmac_desc_ops {
 	/* get timestamp value */
 	 u64(*get_timestamp) (void *desc, u32 ats);
 	/* get rx timestamp status */
-	int (*get_rx_timestamp_status) (void *desc, u32 ats);
+	int (*get_rx_timestamp_status)(void *desc, void *next_desc, u32 ats);
 	/* Display ring */
 	void (*display_ring)(void *head, unsigned int size, bool rx);
 	/* set MSS via context descriptor */
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
@@ -258,7 +258,8 @@ static int dwmac4_rx_check_timestamp(voi
 	return ret;
 }
 
-static int dwmac4_wrback_get_rx_timestamp_status(void *desc, u32 ats)
+static int dwmac4_wrback_get_rx_timestamp_status(void *desc, void *next_desc,
+						 u32 ats)
 {
 	struct dma_desc *p = (struct dma_desc *)desc;
 	int ret = -EINVAL;
@@ -270,7 +271,7 @@ static int dwmac4_wrback_get_rx_timestam
 
 			/* Check if timestamp is OK from context descriptor */
 			do {
-				ret = dwmac4_rx_check_timestamp(desc);
+				ret = dwmac4_rx_check_timestamp(next_desc);
 				if (ret < 0)
 					goto exit;
 				i++;
--- a/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
@@ -400,7 +400,8 @@ static u64 enh_desc_get_timestamp(void *
 	return ns;
 }
 
-static int enh_desc_get_rx_timestamp_status(void *desc, u32 ats)
+static int enh_desc_get_rx_timestamp_status(void *desc, void *next_desc,
+					    u32 ats)
 {
 	if (ats) {
 		struct dma_extended_desc *p = (struct dma_extended_desc *)desc;
--- a/drivers/net/ethernet/stmicro/stmmac/norm_desc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/norm_desc.c
@@ -265,7 +265,7 @@ static u64 ndesc_get_timestamp(void *des
 	return ns;
 }
 
-static int ndesc_get_rx_timestamp_status(void *desc, u32 ats)
+static int ndesc_get_rx_timestamp_status(void *desc, void *next_desc, u32 ats)
 {
 	struct dma_desc *p = (struct dma_desc *)desc;
 
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -489,7 +489,7 @@ static void stmmac_get_rx_hwtstamp(struc
 		desc = np;
 
 	/* Check if timestamp is available */
-	if (priv->hw->desc->get_rx_timestamp_status(desc, priv->adv_ts)) {
+	if (priv->hw->desc->get_rx_timestamp_status(p, np, priv->adv_ts)) {
 		ns = priv->hw->desc->get_timestamp(desc, priv->adv_ts);
 		netdev_dbg(priv->dev, "get valid RX hw timestamp %llu\n", ns);
 		shhwtstamp = skb_hwtstamps(skb);
