Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7BF4C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 15:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7B9120449
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 15:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbfAWP7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 10:59:21 -0500
Received: from mail.bootlin.com ([62.4.15.54]:42260 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726875AbfAWP7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 10:59:18 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id D6171209BF; Wed, 23 Jan 2019 16:59:14 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-87-206.w90-88.abo.wanadoo.fr [90.88.29.206])
        by mail.bootlin.com (Postfix) with ESMTPSA id DB77520A12;
        Wed, 23 Jan 2019 16:58:56 +0100 (CET)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     davem@davemloft.net, sd@queasysnail.net, andrew@lunn.ch,
        f.fainelli@gmail.com, hkallweit1@gmail.com
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, alexandre.belloni@bootlin.com,
        quentin.schulz@bootlin.com, allan.nielsen@microchip.com
Subject: [PATCH net-next 10/10] net: phy: mscc: macsec support
Date:   Wed, 23 Jan 2019 16:56:38 +0100
Message-Id: <20190123155638.13852-11-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190123155638.13852-1-antoine.tenart@bootlin.com>
References: <20190123155638.13852-1-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds MACsec support to the Microsemi Ocelot PHY, to configure
flows and transformations so that matched packets can be processed by
the MACsec engine, either at egress, or at ingress. This addition allows
a user to create an hardware accelerated virtual MACsec interface on a
port using a Microsemi Ocelot PHY.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/net/phy/Kconfig       |   2 +
 drivers/net/phy/mscc.c        | 559 ++++++++++++++++++++++++++++++++++
 drivers/net/phy/mscc_macsec.h |   2 +
 3 files changed, 563 insertions(+)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 3d187cd50eb0..995b9fa697ba 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -381,6 +381,8 @@ config MICROCHIP_T1_PHY
 
 config MICROSEMI_PHY
 	tristate "Microsemi PHYs"
+	select CRYPTO_AES
+	select CRYPTO_ECB
 	---help---
 	  Currently supports VSC8530, VSC8531, VSC8540 and VSC8541 PHYs
 
diff --git a/drivers/net/phy/mscc.c b/drivers/net/phy/mscc.c
index f82d7632fb4a..89614e6b169d 100644
--- a/drivers/net/phy/mscc.c
+++ b/drivers/net/phy/mscc.c
@@ -18,6 +18,9 @@
 #include <linux/netdevice.h>
 #include <dt-bindings/net/mscc-phy-vsc8531.h>
 
+#include <linux/scatterlist.h>
+#include <crypto/skcipher.h>
+
 #include "mscc_macsec.h"
 #include "mscc_mac.h"
 #include "mscc_fc_buffer.h"
@@ -390,6 +393,29 @@ static const struct vsc85xx_hw_stat vsc8584_hw_stats[] = {
 	},
 };
 
+struct macsec_flow {
+	struct list_head list;
+	enum macsec_bank bank;
+	u32 index;
+	unsigned char assoc_num;
+
+	u8 key[MACSEC_KEYID_LEN];
+
+	union {
+		const struct macsec_rx_sa *rx_sa;
+		const struct macsec_tx_sa *tx_sa;
+	};
+
+	/* Matching */
+	bool tagged;
+	bool untagged;
+	bool control;
+	/* Action */
+	bool bypass;
+	bool drop;
+
+};
+
 struct vsc8531_private {
 	int rate_magic;
 	u16 supp_led_modes;
@@ -403,6 +429,17 @@ struct vsc8531_private {
 	 * package.
 	 */
 	unsigned int base_addr;
+
+	/* MACsec fields:
+	 * - One SecY per device (enforced at the s/w implementation level)
+	 * - macsec_flows: list of h/w flows
+	 * - ingr_flows: bitmap of ingress flows
+	 * - egr_flows: bitmap of egress flows
+	 */
+	const struct macsec_secy *secy;
+	struct list_head macsec_flows;
+	unsigned long ingr_flows;
+	unsigned long egr_flows;
 };
 
 #ifdef CONFIG_OF_MDIO
@@ -1934,6 +1971,524 @@ static int vsc8584_macsec_init(struct phy_device *phydev)
 	return 0;
 }
 
+static void vsc8584_macsec_flow(struct phy_device *phydev,
+				struct macsec_flow *flow)
+{
+	struct vsc8531_private *priv = phydev->priv;
+	enum macsec_bank bank = flow->bank;
+	u32 val, match = 0, mask = 0, action = 0, idx = flow->index;
+
+	if (flow->control) {
+		match |= MSCC_MS_SAM_MISC_MATCH_CONTROL_PACKET;
+		mask |= MSCC_MS_SAM_MASK_CTL_PACKET_MASK;
+	}
+	if (flow->tagged)
+		match |= MSCC_MS_SAM_MISC_MATCH_TAGGED;
+	if (flow->untagged)
+		match |= MSCC_MS_SAM_MISC_MATCH_UNTAGGED;
+
+	if (bank == MACSEC_INGR) {
+		match |= MSCC_MS_SAM_MISC_MATCH_AN(flow->index);
+		mask |= MSCC_MS_SAM_MASK_AN_MASK(0x3);
+	}
+
+	/* If an SCI is present, the SC bit must be set */
+	if (bank == MACSEC_INGR && flow->rx_sa->sc->sci) {
+		match |= MSCC_MS_SAM_MISC_MATCH_TCI(BIT(3));
+		mask |= MSCC_MS_SAM_MASK_TCI_MASK(BIT(3)) |
+			MSCC_MS_SAM_MASK_SCI_MASK;
+
+		vsc8584_macsec_phy_write(phydev, bank, MSCC_MS_SAM_MATCH_SCI_LO(idx),
+					 lower_32_bits(flow->rx_sa->sc->sci));
+		vsc8584_macsec_phy_write(phydev, bank, MSCC_MS_SAM_MATCH_SCI_HI(idx),
+					 upper_32_bits(flow->rx_sa->sc->sci));
+	}
+
+	vsc8584_macsec_phy_write(phydev, bank, MSCC_MS_SAM_MISC_MATCH(idx), match);
+	vsc8584_macsec_phy_write(phydev, bank, MSCC_MS_SAM_MASK(idx), mask);
+
+	/* Action for matching packets */
+	if (flow->bypass)
+		action = MSCC_MS_FLOW_BYPASS;
+	else if (flow->drop)
+		action = MSCC_MS_FLOW_DROP;
+	else
+		action = (bank == MACSEC_INGR) ?
+			 MSCC_MS_FLOW_INGRESS : MSCC_MS_FLOW_EGRESS;
+
+	val = MSCC_MS_SAM_FLOW_CTRL_FLOW_TYPE(action) |
+	      MSCC_MS_SAM_FLOW_CTRL_DROP_ACTION(MSCC_MS_ACTION_DROP) |
+	      MSCC_MS_SAM_FLOW_CTRL_DEST_PORT(MSCC_MS_PORT_CONTROLLED);
+
+	if (bank == MACSEC_INGR) {
+		if (priv->secy->replay_protect)
+			val |= MSCC_MS_SAM_FLOW_CTRL_REPLAY_PROTECT;
+		if (priv->secy->validate_frames == MACSEC_VALIDATE_STRICT)
+			val |= MSCC_MS_SAM_FLOW_CTRL_VALIDATE_FRAMES(MSCC_MS_VALIDATE_STRICT);
+		else if (priv->secy->validate_frames == MACSEC_VALIDATE_CHECK)
+			val |= MSCC_MS_SAM_FLOW_CTRL_VALIDATE_FRAMES(MSCC_MS_VALIDATE_CHECK);
+	} else if (bank == MACSEC_EGR) {
+		if (priv->secy->protect_frames)
+			val |= MSCC_MS_SAM_FLOW_CTRL_PROTECT_FRAME;
+		if (priv->secy->tx_sc.encrypt)
+			val |= MSCC_MS_SAM_FLOW_CTRL_CONF_PROTECT;
+		if (priv->secy->tx_sc.send_sci)
+			val |= MSCC_MS_SAM_FLOW_CTRL_INCLUDE_SCI;
+	}
+
+	vsc8584_macsec_phy_write(phydev, bank, MSCC_MS_SAM_FLOW_CTRL(idx), val);
+}
+
+static enum macsec_bank vsc8584_macsec_command_to_bank(enum netdev_macsec_command command)
+{
+	switch (command) {
+	case MACSEC_ADD_RXSA:
+	case MACSEC_UPD_RXSA:
+	case MACSEC_DEL_RXSA:
+		return MACSEC_INGR;
+	case MACSEC_ADD_TXSA:
+	case MACSEC_UPD_TXSA:
+	case MACSEC_DEL_TXSA:
+		return MACSEC_EGR;
+	default:
+		return -EINVAL;
+	}
+}
+
+static struct macsec_flow *vsc8584_macsec_find_flow(struct vsc8531_private *priv,
+						    enum macsec_bank bank,
+						    struct netdev_macsec *macsec)
+{
+	struct macsec_flow *pos, *tmp;
+	sci_t flow_sci, sci = bank == MACSEC_INGR ?
+			      macsec->sa.rx_sa->sc->sci : priv->secy->sci;
+
+	list_for_each_entry_safe(pos, tmp, &priv->macsec_flows, list) {
+		flow_sci = pos->bank == MACSEC_INGR ?
+			   pos->rx_sa->sc->sci : priv->secy->sci;
+		if (pos->assoc_num == macsec->sa.assoc_num && flow_sci == sci &&
+		    pos->bank == vsc8584_macsec_command_to_bank(macsec->command))
+			return pos;
+	}
+
+	return ERR_PTR(-ENOENT);
+}
+
+static void vsc8584_macsec_flow_enable(struct phy_device *phydev,
+				       struct macsec_flow *flow)
+{
+	enum macsec_bank bank = flow->bank;
+	u32 val, idx = flow->index;
+	bool active = (flow->bank == MACSEC_INGR) ?
+		      flow->rx_sa->active : flow->tx_sa->active;
+
+	if (!active)
+		return;
+
+	/* Enable */
+	vsc8584_macsec_phy_write(phydev, bank, MSCC_MS_SAM_ENTRY_SET1, BIT(idx));
+
+	/* Set in-use */
+	val = vsc8584_macsec_phy_read(phydev, bank, MSCC_MS_SAM_FLOW_CTRL(idx));
+	val |= MSCC_MS_SAM_FLOW_CTRL_SA_IN_USE;
+	vsc8584_macsec_phy_write(phydev, bank, MSCC_MS_SAM_FLOW_CTRL(idx), val);
+}
+
+static void vsc8584_macsec_flow_disable(struct phy_device *phydev,
+					struct macsec_flow *flow)
+{
+	enum macsec_bank bank = flow->bank;
+	u32 val, idx = flow->index;
+
+	/* Disable */
+	vsc8584_macsec_phy_write(phydev, bank, MSCC_MS_SAM_ENTRY_CLEAR1, BIT(idx));
+
+	/* Clear in-use */
+	val = vsc8584_macsec_phy_read(phydev, bank, MSCC_MS_SAM_FLOW_CTRL(idx));
+	val &= ~MSCC_MS_SAM_FLOW_CTRL_SA_IN_USE;
+	vsc8584_macsec_phy_write(phydev, bank, MSCC_MS_SAM_FLOW_CTRL(idx), val);
+}
+
+static u32 vsc8584_macsec_flow_context_id(struct macsec_flow *flow)
+{
+	if (flow->bank == MACSEC_INGR)
+		return flow->index + MSCC_MS_MAX_FLOWS;
+
+	return flow->index;
+}
+
+/* Derive the AES key to get a key for the hash autentication */
+static int vsc8584_macsec_derive_key(const u8 key[MACSEC_KEYID_LEN],
+				     u16 key_len, u8 hkey[16])
+{
+	struct crypto_skcipher *tfm = crypto_alloc_skcipher("ecb(aes)", 0, 0);
+	struct skcipher_request *req = NULL;
+	struct scatterlist src, dst;
+	DECLARE_CRYPTO_WAIT(wait);
+	u32 input[4] = {0};
+	int ret;
+
+	if (IS_ERR(tfm))
+		return PTR_ERR(tfm);
+
+	req = skcipher_request_alloc(tfm, GFP_KERNEL);
+	if (!req) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	skcipher_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG |
+				      CRYPTO_TFM_REQ_MAY_SLEEP, crypto_req_done,
+				      &wait);
+	ret = crypto_skcipher_setkey(tfm, key, key_len);
+	if (ret < 0)
+		goto out;
+
+	sg_init_one(&src, input, 16);
+	sg_init_one(&dst, hkey, 16);
+	skcipher_request_set_crypt(req, &src, &dst, 16, NULL);
+
+	ret = crypto_wait_req(crypto_skcipher_encrypt(req), &wait);
+
+out:
+	skcipher_request_free(req);
+	crypto_free_skcipher(tfm);
+	return ret;
+}
+
+static int vsc8584_macsec_transformation(struct phy_device *phydev,
+					 struct macsec_flow *flow)
+{
+	u32 rec = 0, control = 0, index = flow->index;
+	struct vsc8531_private *priv = phydev->priv;
+	enum macsec_bank bank = flow->bank;
+	u8 hkey[16];
+	int i, ret;
+	sci_t sci;
+
+	ret = vsc8584_macsec_derive_key(flow->key, priv->secy->key_len, hkey);
+	if (ret)
+		return ret;
+
+	switch (priv->secy->key_len) {
+	case 16:
+		control |= CONTROL_CRYPTO_ALG(CTRYPTO_ALG_AES_CTR_128);
+		break;
+	case 32:
+		control |= CONTROL_CRYPTO_ALG(CTRYPTO_ALG_AES_CTR_256);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	control |= (bank == MACSEC_EGR) ?
+		   (CONTROL_TYPE_EGRESS | CONTROL_AN(priv->secy->tx_sc.encoding_sa)) :
+		   (CONTROL_TYPE_INGRESS | CONTROL_SEQ_MASK);
+
+	control |= CONTROL_UPDATE_SEQ | CONTROL_ENCRYPT_AUTH | CONTROL_KEY_IN_CTX |
+		   CONTROL_IV0 | CONTROL_IV1 | CONTROL_IV_IN_SEQ |
+		   CONTROL_DIGEST_TYPE(0x2) | CONTROL_SEQ_TYPE(0x1) |
+		   CONTROL_AUTH_ALG(AUTH_ALG_AES_GHAS) | CONTROL_CONTEXT_ID;
+
+	/* Set the control word */
+	vsc8584_macsec_phy_write(phydev, bank, MSCC_MS_XFORM_REC(index, rec++),
+				 control);
+
+	/* Set the context ID. Must be unique. */
+	vsc8584_macsec_phy_write(phydev, bank, MSCC_MS_XFORM_REC(index, rec++),
+				 vsc8584_macsec_flow_context_id(flow));
+
+	/* Set the encryption/decryption key */
+	for (i = 0; i < priv->secy->key_len / sizeof(u32); i++)
+		vsc8584_macsec_phy_write(phydev, bank,
+					 MSCC_MS_XFORM_REC(index, rec++),
+					 ((u32 *)flow->key)[i]);
+
+	/* Set the authentication key */
+	for (i = 0; i < 4; i++)
+		vsc8584_macsec_phy_write(phydev, bank,
+					 MSCC_MS_XFORM_REC(index, rec++),
+					 ((u32 *)hkey)[i]);
+
+	/* Initial sequence number */
+	vsc8584_macsec_phy_write(phydev, bank, MSCC_MS_XFORM_REC(index, rec++),
+				 bank == MACSEC_INGR ?
+				 flow->rx_sa->next_pn : flow->tx_sa->next_pn);
+
+	if (bank == MACSEC_INGR)
+		/* Set the mask (replay window size) */
+		vsc8584_macsec_phy_write(phydev, bank,
+					 MSCC_MS_XFORM_REC(index, rec++),
+					 priv->secy->replay_window);
+
+	/* Set the input vectors */
+	sci = bank == MACSEC_INGR ? flow->rx_sa->sc->sci : priv->secy->sci;
+	vsc8584_macsec_phy_write(phydev, bank, MSCC_MS_XFORM_REC(index, rec++),
+				 lower_32_bits(sci));
+	vsc8584_macsec_phy_write(phydev, bank, MSCC_MS_XFORM_REC(index, rec++),
+				 upper_32_bits(sci));
+
+	while (rec < 20)
+		vsc8584_macsec_phy_write(phydev, bank, MSCC_MS_XFORM_REC(index, rec++),
+					 0);
+	return 0;
+}
+
+static struct macsec_flow *vsc8584_macsec_alloc_flow(struct vsc8531_private *priv,
+						     enum macsec_bank bank)
+{
+	struct macsec_flow *flow;
+	unsigned long *bitmap;
+	int index;
+
+	bitmap = bank == MACSEC_INGR ? &priv->ingr_flows : &priv->egr_flows;
+	index = find_first_zero_bit(bitmap, MSCC_MS_MAX_FLOWS);
+
+	if (index == MSCC_MS_MAX_FLOWS)
+		return ERR_PTR(-ENOMEM);
+
+	flow = kzalloc(sizeof(*flow), GFP_KERNEL);
+	if (!flow)
+		return ERR_PTR(-ENOMEM);
+
+	set_bit(index, bitmap);
+	flow->index = index;
+	flow->bank = bank;
+
+	list_add_tail(&flow->list, &priv->macsec_flows);
+	return flow;
+}
+
+static void vsc8584_macsec_free_flow(struct vsc8531_private *priv,
+				     struct macsec_flow *flow)
+{
+	unsigned long *bitmap = flow->bank == MACSEC_INGR ?
+				&priv->ingr_flows : &priv->egr_flows;
+
+	list_del(&flow->list);
+	clear_bit(flow->index, bitmap);
+	kfree(flow);
+}
+
+static int vsc8584_macsec_add_flow(struct phy_device *phydev,
+				   enum netdev_macsec_command command,
+				   struct macsec_flow *flow)
+{
+	int ret;
+
+	vsc8584_macsec_flow(phydev, flow);
+
+	if (command == MACSEC_UPD_RXSA || command == MACSEC_UPD_TXSA)
+		return 0;
+
+	ret = vsc8584_macsec_transformation(phydev, flow);
+	if (ret) {
+		vsc8584_macsec_free_flow(phydev->priv, flow);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void vsc8584_macsec_del_flow(struct phy_device *phydev,
+				    struct macsec_flow *flow)
+{
+	vsc8584_macsec_flow_disable(phydev, flow);
+	vsc8584_macsec_free_flow(phydev->priv, flow);
+}
+
+static int vsc8584_macsec_add_rxsa(struct phy_device *phydev,
+				   struct netdev_macsec *macsec,
+				   struct macsec_flow *flow)
+{
+	struct vsc8531_private *priv = phydev->priv;
+
+	if (!flow) {
+		flow = vsc8584_macsec_alloc_flow(phydev->priv, MACSEC_INGR);
+		if (IS_ERR(flow))
+			return PTR_ERR(flow);
+
+		memcpy(flow->key, macsec->sa.key, priv->secy->key_len);
+	}
+
+	flow->assoc_num = macsec->sa.assoc_num;
+	flow->rx_sa = macsec->sa.rx_sa;
+
+	/* Always match tagged packets on ingress */
+	flow->tagged = true;
+
+	if (priv->secy->validate_frames != MACSEC_VALIDATE_DISABLED)
+		flow->untagged = true;
+
+	return vsc8584_macsec_add_flow(phydev, macsec->command, flow);
+}
+
+static int vsc8584_macsec_add_txsa(struct phy_device *phydev,
+				   struct netdev_macsec *macsec,
+				   struct macsec_flow *flow)
+{
+	struct vsc8531_private *priv = phydev->priv;
+
+	if (!flow) {
+		flow = vsc8584_macsec_alloc_flow(phydev->priv, MACSEC_EGR);
+		if (IS_ERR(flow))
+			return PTR_ERR(flow);
+
+		memcpy(flow->key, macsec->sa.key, priv->secy->key_len);
+	}
+
+	flow->assoc_num = macsec->sa.assoc_num;
+	flow->tx_sa = macsec->sa.tx_sa;
+
+	/* Always match untagged packets on egress */
+	flow->untagged = true;
+
+	return vsc8584_macsec_add_flow(phydev, macsec->command, flow);
+}
+
+/* This function should ensure vsc8584_macsec_commit() will run successfully */
+static int vsc8584_macsec_prepare(struct phy_device *phydev,
+				  struct netdev_macsec *macsec)
+{
+	struct vsc8531_private *priv = phydev->priv;
+	struct macsec_flow *flow = NULL;
+
+	if (macsec->command != MACSEC_ADD_SECY && !priv->secy)
+		return -EINVAL;
+
+	switch (macsec->command) {
+	case MACSEC_ADD_SECY:
+		if (priv->secy)
+			return -EEXIST;
+		return 0;
+	case MACSEC_UPD_RXSA:
+		flow = vsc8584_macsec_find_flow(phydev->priv, MACSEC_INGR,
+						macsec);
+		if (IS_ERR(flow))
+			return -ENOENT;
+
+		/* Make sure the flow is disabled before updating it */
+		vsc8584_macsec_flow_disable(phydev, flow);
+
+		/* Fall-through */
+	case MACSEC_ADD_RXSA:
+		return vsc8584_macsec_add_rxsa(phydev, macsec, flow);
+	case MACSEC_UPD_TXSA:
+		flow = vsc8584_macsec_find_flow(phydev->priv, MACSEC_EGR,
+						macsec);
+		if (IS_ERR(flow))
+			return -ENOENT;
+
+		/* Make sure the flow is disabled before updating it */
+		vsc8584_macsec_flow_disable(phydev, flow);
+
+		/* Fall-through */
+	case MACSEC_ADD_TXSA:
+		return vsc8584_macsec_add_txsa(phydev, macsec, flow);
+	case MACSEC_DEL_RXSA:
+		flow = vsc8584_macsec_find_flow(phydev->priv, MACSEC_INGR,
+						macsec);
+		if (IS_ERR(flow))
+			return -ENOENT;
+		return 0;
+	case MACSEC_DEL_TXSA:
+		flow = vsc8584_macsec_find_flow(phydev->priv, MACSEC_EGR,
+						macsec);
+		if (IS_ERR(flow))
+			return -ENOENT;
+		return 0;
+	/* Handled entirely in the commit phase */
+	case MACSEC_DEL_SECY:
+	case MACSEC_DEL_RXSC:
+	case MACSEC_DEV_OPEN:
+	case MACSEC_DEV_STOP:
+		return 0;
+	default:
+		break;
+	}
+
+	return -EOPNOTSUPP;
+}
+
+/* This function should not fail */
+static int vsc8584_macsec_commit(struct phy_device *phydev,
+				 struct netdev_macsec *macsec)
+{
+	struct vsc8531_private *priv = phydev->priv;
+	struct macsec_flow *flow, *tmp;
+
+	switch (macsec->command) {
+	case MACSEC_ADD_SECY:
+		priv->secy = macsec->secy;
+		break;
+	case MACSEC_DEL_SECY:
+		list_for_each_entry_safe(flow, tmp, &priv->macsec_flows, list)
+			vsc8584_macsec_del_flow(phydev, flow);
+
+		priv->secy = NULL;
+		break;
+	case MACSEC_DEL_RXSC:
+		list_for_each_entry_safe(flow, tmp, &priv->macsec_flows, list) {
+			if (flow->bank == MACSEC_INGR &&
+			    flow->rx_sa->sc->sci == macsec->rx_sc->sci)
+				vsc8584_macsec_del_flow(phydev, flow);
+		}
+		break;
+	case MACSEC_ADD_RXSA:
+	case MACSEC_UPD_RXSA:
+		flow = vsc8584_macsec_find_flow(phydev->priv, MACSEC_INGR,
+						macsec);
+		if (IS_ERR(flow))
+			return PTR_ERR(flow);
+		vsc8584_macsec_flow_enable(phydev, flow);
+		break;
+	case MACSEC_ADD_TXSA:
+	case MACSEC_UPD_TXSA:
+		flow = vsc8584_macsec_find_flow(phydev->priv, MACSEC_EGR,
+						macsec);
+		if (IS_ERR(flow))
+			return PTR_ERR(flow);
+		vsc8584_macsec_flow_enable(phydev, flow);
+		break;
+	case MACSEC_DEL_RXSA:
+		flow = vsc8584_macsec_find_flow(phydev->priv, MACSEC_INGR,
+						macsec);
+		if (IS_ERR(flow))
+			return PTR_ERR(flow);
+		vsc8584_macsec_del_flow(phydev, flow);
+		break;
+	case MACSEC_DEL_TXSA:
+		flow = vsc8584_macsec_find_flow(phydev->priv, MACSEC_EGR,
+						macsec);
+		if (IS_ERR(flow))
+			return PTR_ERR(flow);
+		vsc8584_macsec_del_flow(phydev, flow);
+		break;
+	case MACSEC_DEV_OPEN:
+		list_for_each_entry_safe(flow, tmp, &priv->macsec_flows, list)
+			vsc8584_macsec_flow_enable(phydev, flow);
+		break;
+	case MACSEC_DEV_STOP:
+		list_for_each_entry_safe(flow, tmp, &priv->macsec_flows, list)
+			vsc8584_macsec_flow_disable(phydev, flow);
+		break;
+	default:
+		/* Nothing to be done */
+		break;
+	}
+
+	return 0;
+}
+
+static int vsc8584_macsec(struct phy_device *phydev,
+			  struct netdev_macsec *macsec)
+{
+	if (macsec->prepare)
+		return vsc8584_macsec_prepare(phydev, macsec);
+
+	return vsc8584_macsec_commit(phydev, macsec);
+}
+
 /* Check if one PHY has already done the init of the parts common to all PHYs
  * in the Quad PHY package.
  */
@@ -2064,6 +2619,9 @@ static int vsc8584_config_init(struct phy_device *phydev)
 		goto err;
 
 	/* MACsec */
+	INIT_LIST_HEAD(&vsc8531->macsec_flows);
+	vsc8531->secy = NULL;
+
 	ret = vsc8584_macsec_init(phydev);
 	if (ret)
 		goto err;
@@ -2428,6 +2986,7 @@ static struct phy_driver vsc85xx_driver[] = {
 	.get_sset_count = &vsc85xx_get_sset_count,
 	.get_strings    = &vsc85xx_get_strings,
 	.get_stats      = &vsc85xx_get_stats,
+	.macsec		= &vsc8584_macsec,
 }
 
 };
diff --git a/drivers/net/phy/mscc_macsec.h b/drivers/net/phy/mscc_macsec.h
index 52902669e8ca..cf12d7967133 100644
--- a/drivers/net/phy/mscc_macsec.h
+++ b/drivers/net/phy/mscc_macsec.h
@@ -8,6 +8,8 @@
 #ifndef _MSCC_OCELOT_MACSEC_H_
 #define _MSCC_OCELOT_MACSEC_H_
 
+#define MSCC_MS_MAX_FLOWS		16
+
 #define CONTROL_TYPE_EGRESS		0x6
 #define CONTROL_TYPE_INGRESS		0xf
 #define CONTROL_IV0			BIT(5)
-- 
2.20.1

