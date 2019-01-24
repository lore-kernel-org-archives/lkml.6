Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49FB4C282C6
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BF34218FC
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548358479;
	bh=U2Fzg3NoX+i2J97AofFE9owKrq65tWvguVGEgZK3r1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GnZvtXCIPKzNR+AO4x0gLjcfkZX9LCL9mxuiD/P0wlOy1YP51ScMwzsY1p20IISGn
	 YncWWGH/zLPUzMQH+21TljPtMQNFtkPztC4oD7zYAPbdT3367O4+qHMf6zfz1k11dj
	 wXe8sTufY2OvawP8kAmCUx/E5vypuUo+cMi/p2ys=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732237AbfAXTeh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:34:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:34396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730109AbfAXTee (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:34:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05F2B21903;
        Thu, 24 Jan 2019 19:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358473;
        bh=U2Fzg3NoX+i2J97AofFE9owKrq65tWvguVGEgZK3r1Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uORj595aTEQ8SSnSD/V6h0gAIr+cObgHWKCzwmQKpDW7qQvYJhrm2t+vFE5Z+mWkO
         rqZmCOMTLkVo4o+fyjSiny0sMKmYnJIYTQuyX72zI90qfv5lwC4DEGeLkAxmASmS+8
         ZgQsmz7sccukeYlSm4qT93YFJVZeNdsYrST65kC4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 004/106] net: dsa: mv88x6xxx: mv88e6390 errata
Date:   Thu, 24 Jan 2019 20:19:21 +0100
Message-Id: <20190124190206.612101590@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190206.342411005@linuxfoundation.org>
References: <20190124190206.342411005@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2391,6 +2391,107 @@ static int mv88e6xxx_stats_setup(struct
 	return mv88e6xxx_g1_stats_clear(chip);
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
@@ -2403,6 +2504,12 @@ static int mv88e6xxx_setup(struct dsa_sw
 
 	mutex_lock(&chip->reg_lock);
 
+	if (chip->info->ops->setup_errata) {
+		err = chip->info->ops->setup_errata(chip);
+		if (err)
+			goto unlock;
+	}
+
 	/* Cache the cmode of each port. */
 	for (i = 0; i < mv88e6xxx_num_ports(chip); i++) {
 		if (chip->info->ops->port_get_cmode) {
@@ -3201,6 +3308,7 @@ static const struct mv88e6xxx_ops mv88e6
 
 static const struct mv88e6xxx_ops mv88e6190_ops = {
 	/* MV88E6XXX_FAMILY_6390 */
+	.setup_errata = mv88e6390_setup_errata,
 	.irl_init_all = mv88e6390_g2_irl_init_all,
 	.get_eeprom = mv88e6xxx_g2_get_eeprom8,
 	.set_eeprom = mv88e6xxx_g2_set_eeprom8,
@@ -3243,6 +3351,7 @@ static const struct mv88e6xxx_ops mv88e6
 
 static const struct mv88e6xxx_ops mv88e6190x_ops = {
 	/* MV88E6XXX_FAMILY_6390 */
+	.setup_errata = mv88e6390_setup_errata,
 	.irl_init_all = mv88e6390_g2_irl_init_all,
 	.get_eeprom = mv88e6xxx_g2_get_eeprom8,
 	.set_eeprom = mv88e6xxx_g2_set_eeprom8,
@@ -3285,6 +3394,7 @@ static const struct mv88e6xxx_ops mv88e6
 
 static const struct mv88e6xxx_ops mv88e6191_ops = {
 	/* MV88E6XXX_FAMILY_6390 */
+	.setup_errata = mv88e6390_setup_errata,
 	.irl_init_all = mv88e6390_g2_irl_init_all,
 	.get_eeprom = mv88e6xxx_g2_get_eeprom8,
 	.set_eeprom = mv88e6xxx_g2_set_eeprom8,
@@ -3374,6 +3484,7 @@ static const struct mv88e6xxx_ops mv88e6
 
 static const struct mv88e6xxx_ops mv88e6290_ops = {
 	/* MV88E6XXX_FAMILY_6390 */
+	.setup_errata = mv88e6390_setup_errata,
 	.irl_init_all = mv88e6390_g2_irl_init_all,
 	.get_eeprom = mv88e6xxx_g2_get_eeprom8,
 	.set_eeprom = mv88e6xxx_g2_set_eeprom8,
@@ -3675,6 +3786,7 @@ static const struct mv88e6xxx_ops mv88e6
 
 static const struct mv88e6xxx_ops mv88e6390_ops = {
 	/* MV88E6XXX_FAMILY_6390 */
+	.setup_errata = mv88e6390_setup_errata,
 	.irl_init_all = mv88e6390_g2_irl_init_all,
 	.get_eeprom = mv88e6xxx_g2_get_eeprom8,
 	.set_eeprom = mv88e6xxx_g2_set_eeprom8,
@@ -3722,6 +3834,7 @@ static const struct mv88e6xxx_ops mv88e6
 
 static const struct mv88e6xxx_ops mv88e6390x_ops = {
 	/* MV88E6XXX_FAMILY_6390 */
+	.setup_errata = mv88e6390_setup_errata,
 	.irl_init_all = mv88e6390_g2_irl_init_all,
 	.get_eeprom = mv88e6xxx_g2_get_eeprom8,
 	.set_eeprom = mv88e6xxx_g2_set_eeprom8,
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -300,6 +300,11 @@ struct mv88e6xxx_mdio_bus {
 };
 
 struct mv88e6xxx_ops {
+	/* Switch Setup Errata, called early in the switch setup to
+	 * allow any errata actions to be performed
+	 */
+	int (*setup_errata)(struct mv88e6xxx_chip *chip);
+
 	int (*ieee_pri_map)(struct mv88e6xxx_chip *chip);
 	int (*ip_pri_map)(struct mv88e6xxx_chip *chip);
 
--- a/drivers/net/dsa/mv88e6xxx/port.h
+++ b/drivers/net/dsa/mv88e6xxx/port.h
@@ -251,6 +251,16 @@
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


