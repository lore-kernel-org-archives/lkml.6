Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752571AbeFERDa (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:03:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:60402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751805AbeFERD2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:03:28 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Biju Das <biju.das@bp.renesas.com>
Subject: [PATCH 4.4 21/37] i2c: rcar: dont issue stop when HW does it automatically
Date: Tue,  5 Jun 2018 19:01:26 +0200
Message-Id: <20180605170110.133552831@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180605170108.884872354@linuxfoundation.org>
References: <20180605170108.884872354@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit d89667b14f9d13b684287f6189ca209af5feee43 upstream.

The manual says (55.4.8.6) that HW does automatically send STOP after
NACK was received. My measuerments confirm that.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/i2c/busses/i2c-rcar.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -455,8 +455,8 @@ static irqreturn_t rcar_i2c_irq(int irq,
 
 	/* Nack */
 	if (msr & MNR) {
-		/* go to stop phase */
-		rcar_i2c_write(priv, ICMCR, RCAR_BUS_PHASE_STOP);
+		/* HW automatically sends STOP after received NACK */
+		rcar_i2c_write(priv, ICMCR, RCAR_BUS_PHASE_DATA);
 		rcar_i2c_write(priv, ICMIER, RCAR_IRQ_STOP);
 		rcar_i2c_flags_set(priv, ID_NACK);
 		goto out;
