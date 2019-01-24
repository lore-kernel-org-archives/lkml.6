Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 798F0C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E172218FC
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548358360;
	bh=EJ8re1oVJJSjgFNMoqjefWpXxzD2R3xzJEkRPYivRKk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0dvAlk6TCAAEy0kGVot3EB1ZBWFJYYKlR0RA8/IuxEHmgcg4/vVnpNJNnzRqkazws
	 CnpsHVhiJHMcJ/L4DXiPw7ZPetbOiF/xzKbahNHFbeFbmOu4IN8Vq5COQEdYX0WmSE
	 BK4GxG16T5o7CRQ5frU/fmN2gYKIz7CgihMRJ6vQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730349AbfAXTci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:32:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:60454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731075AbfAXTca (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:32:30 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A18AE218FC;
        Thu, 24 Jan 2019 19:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358349;
        bh=EJ8re1oVJJSjgFNMoqjefWpXxzD2R3xzJEkRPYivRKk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rAc/t6hsgvjH4d1m1k+YW78MGcbkCu+ogvMHEdR3EL6aZQ75nLdGMW+Y7IBYSVUOe
         EG1/JKLKZ70oEc4slcWTw0qX/NZt1JICEA6CTFQSrIw2xvn2fV5o29Ysox4D/Gf/fR
         vfgPjNTClF1MzmMfYW2IGkFbnYq8jrq/kCA8fdLQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 08/63] net: dsa: mv88x6xxx: mv88e6390 errata
Date:   Thu, 24 Jan 2019 20:19:57 +0100
Message-Id: <20190124190156.052416016@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190155.176570028@linuxfoundation.org>
References: <20190124190155.176570028@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrew Lunn <andrew@lunn.ch>

[ Upstream commit ea89098ef9a574bceca00d3b5df14aaf0b3f9ccf ]

The 6390 copper ports have an errata which require poking magic values
into undocumented magic registers and then performing a software
reset.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/dsa/mv88e6xxx/chip.c |  113 +++++++++++++++++++++++++++++++++++++++
 drivers/net/dsa/mv88e6xxx/chip.h |    5 +
 drivers/net/dsa/mv88e6xxx/port.h |   10 +++
 3 files changed, 128 insertions(+)

--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -1979,6 +1979,107 @@ static int mv88e6xxx_g1_setup(struct mv8
 	return 0;
 }
 
+/* The mv88e6390 has some hidden registers used for debug and
+ * development. The errata also makes use of them.
+ */
+static int mv88e6390_hidden_write(struct mv88e6xxx_chip *chip, int port,
+				  int reg, u16 val)
+{
+	u16 ctrl;
+	int err;
+
+	err = mv88e6xxx_port_write(chip, PORT_RESERVED_1A_DATA_PORT,
+				   PORT_RESERVED_1A, val);
+	if (err)
+		return err;
+
+	ctrl = PORT_RESERVED_1A_BUSY | PORT_RESERVED_1A_WRITE |
+	       PORT_RESERVED_1A_BLOCK | port << PORT_RESERVED_1A_PORT_SHIFT |
+	       reg;
+
+	return mv88e6xxx_port_write(chip, PORT_RESERVED_1A_CTRL_PORT,
+				    PORT_RESERVED_1A, ctrl);
+}
+
+static int mv88e6390_hidden_wait(struct mv88e6xxx_chip *chip)
+{
+	return mv88e6xxx_wait(chip, PORT_RESERVED_1A_CTRL_PORT,
+			      PORT_RESERVED_1A, PORT_RESERVED_1A_BUSY);
+}
+
+
+static int mv88e6390_hidden_read(struct mv88e6xxx_chip *chip, int port,
+				  int reg, u16 *val)
+{
+	u16 ctrl;
+	int err;
+
+	ctrl = PORT_RESERVED_1A_BUSY | PORT_RESERVED_1A_READ |
+	       PORT_RESERVED_1A_BLOCK | port << PORT_RESERVED_1A_PORT_SHIFT |
+	       reg;
+
+	err = mv88e6xxx_port_write(chip, PORT_RESERVED_1A_CTRL_PORT,
+				   PORT_RESERVED_1A, ctrl);
+	if (err)
+		return err;
+
+	err = mv88e6390_hidden_wait(chip);
+	if (err)
+		return err;
+
+	return 	mv88e6xxx_port_read(chip, PORT_RESERVED_1A_DATA_PORT,
+				    PORT_RESERVED_1A, val);
+}
+
+/* Check if the errata has already been applied. */
+static bool mv88e6390_setup_errata_applied(struct mv88e6xxx_chip *chip)
+{
+	int port;
+	int err;
+	u16 val;
+
+	for (port = 0; port < mv88e6xxx_num_ports(chip); port++) {
+		err = mv88e6390_hidden_read(chip, port, 0, &val);
+		if (err) {
+			dev_err(chip->dev,
+				"Error reading hidden register: %d\n", err);
+			return false;
+		}
+		if (val != 0x01c0)
+			return false;
+	}
+
+	return true;
+}
+
+/* The 6390 copper ports have an errata which require poking magic
+ * values into undocumented hidden registers and then performing a
+ * software reset.
+ */
+static int mv88e6390_setup_errata(struct mv88e6xxx_chip *chip)
+{
+	int port;
+	int err;
+
+	if (mv88e6390_setup_errata_applied(chip))
+		return 0;
+
+	/* Set the ports into blocking mode */
+	for (port = 0; port < mv88e6xxx_num_ports(chip); port++) {
+		err = mv88e6xxx_port_set_state(chip, port, BR_STATE_DISABLED);
+		if (err)
+			return err;
+	}
+
+	for (port = 0; port < mv88e6xxx_num_ports(chip); port++) {
+		err = mv88e6390_hidden_write(chip, port, 0, 0x01c0);
+		if (err)
+			return err;
+	}
+
+	return mv88e6xxx_software_reset(chip);
+}
+
 static int mv88e6xxx_setup(struct dsa_switch *ds)
 {
 	struct mv88e6xxx_chip *chip = ds->priv;
@@ -1990,6 +2091,12 @@ static int mv88e6xxx_setup(struct dsa_sw
 
 	mutex_lock(&chip->reg_lock);
 
+	if (chip->info->ops->setup_errata) {
+		err = chip->info->ops->setup_errata(chip);
+		if (err)
+			goto unlock;
+	}
+
 	/* Setup Switch Port Registers */
 	for (i = 0; i < mv88e6xxx_num_ports(chip); i++) {
 		err = mv88e6xxx_setup_port(chip, i);
@@ -2652,6 +2759,7 @@ static const struct mv88e6xxx_ops mv88e6
 
 static const struct mv88e6xxx_ops mv88e6190_ops = {
 	/* MV88E6XXX_FAMILY_6390 */
+	.setup_errata = mv88e6390_setup_errata,
 	.irl_init_all = mv88e6390_g2_irl_init_all,
 	.get_eeprom = mv88e6xxx_g2_get_eeprom8,
 	.set_eeprom = mv88e6xxx_g2_set_eeprom8,
@@ -2687,6 +2795,7 @@ static const struct mv88e6xxx_ops mv88e6
 
 static const struct mv88e6xxx_ops mv88e6190x_ops = {
 	/* MV88E6XXX_FAMILY_6390 */
+	.setup_errata = mv88e6390_setup_errata,
 	.irl_init_all = mv88e6390_g2_irl_init_all,
 	.get_eeprom = mv88e6xxx_g2_get_eeprom8,
 	.set_eeprom = mv88e6xxx_g2_set_eeprom8,
@@ -2722,6 +2831,7 @@ static const struct mv88e6xxx_ops mv88e6
 
 static const struct mv88e6xxx_ops mv88e6191_ops = {
 	/* MV88E6XXX_FAMILY_6390 */
+	.setup_errata = mv88e6390_setup_errata,
 	.irl_init_all = mv88e6390_g2_irl_init_all,
 	.get_eeprom = mv88e6xxx_g2_get_eeprom8,
 	.set_eeprom = mv88e6xxx_g2_set_eeprom8,
@@ -2793,6 +2903,7 @@ static const struct mv88e6xxx_ops mv88e6
 
 static const struct mv88e6xxx_ops mv88e6290_ops = {
 	/* MV88E6XXX_FAMILY_6390 */
+	.setup_errata = mv88e6390_setup_errata,
 	.irl_init_all = mv88e6390_g2_irl_init_all,
 	.get_eeprom = mv88e6xxx_g2_get_eeprom8,
 	.set_eeprom = mv88e6xxx_g2_set_eeprom8,
@@ -3030,6 +3141,7 @@ static const struct mv88e6xxx_ops mv88e6
 
 static const struct mv88e6xxx_ops mv88e6390_ops = {
 	/* MV88E6XXX_FAMILY_6390 */
+	.setup_errata = mv88e6390_setup_errata,
 	.irl_init_all = mv88e6390_g2_irl_init_all,
 	.get_eeprom = mv88e6xxx_g2_get_eeprom8,
 	.set_eeprom = mv88e6xxx_g2_set_eeprom8,
@@ -3068,6 +3180,7 @@ static const struct mv88e6xxx_ops mv88e6
 
 static const struct mv88e6xxx_ops mv88e6390x_ops = {
 	/* MV88E6XXX_FAMILY_6390 */
+	.setup_errata = mv88e6390_setup_errata,
 	.irl_init_all = mv88e6390_g2_irl_init_all,
 	.get_eeprom = mv88e6xxx_g2_get_eeprom8,
 	.set_eeprom = mv88e6xxx_g2_set_eeprom8,
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -222,6 +222,11 @@ struct mv88e6xxx_mdio_bus {
 };
 
 struct mv88e6xxx_ops {
+	/* Switch Setup Errata, called early in the switch setup to
+	 * allow any errata actions to be performed
+	 */
+	int (*setup_errata)(struct mv88e6xxx_chip *chip);
+
 	/* Ingress Rate Limit unit (IRL) operations */
 	int (*irl_init_all)(struct mv88e6xxx_chip *chip, int port);
 
--- a/drivers/net/dsa/mv88e6xxx/port.h
+++ b/drivers/net/dsa/mv88e6xxx/port.h
@@ -236,6 +236,16 @@
 /* Offset 0x19: Port IEEE Priority Remapping Registers (4-7) */
 #define MV88E6095_PORT_IEEE_PRIO_REMAP_4567	0x19
 
+/* Offset 0x1a: Magic undocumented errata register */
+#define PORT_RESERVED_1A			0x1a
+#define PORT_RESERVED_1A_BUSY			BIT(15)
+#define PORT_RESERVED_1A_WRITE			BIT(14)
+#define PORT_RESERVED_1A_READ			0
+#define PORT_RESERVED_1A_PORT_SHIFT		5
+#define PORT_RESERVED_1A_BLOCK			(0xf << 10)
+#define PORT_RESERVED_1A_CTRL_PORT		4
+#define PORT_RESERVED_1A_DATA_PORT		5
+
 int mv88e6xxx_port_read(struct mv88e6xxx_chip *chip, int port, int reg,
 			u16 *val);
 int mv88e6xxx_port_write(struct mv88e6xxx_chip *chip, int port, int reg,


