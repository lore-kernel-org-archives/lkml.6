Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966774AbeE1KPh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:15:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:35702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966501AbeE1KPc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:15:32 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wei Yongjun <weiyongjun1@huawei.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Corey Minyard <cminyard@mvista.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 035/268] ipmi/powernv: Fix error return code in ipmi_powernv_probe()
Date: Mon, 28 May 2018 12:00:09 +0200
Message-Id: <20180528100206.039394310@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100202.045206534@linuxfoundation.org>
References: <20180528100202.045206534@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wei Yongjun <weiyongjun1@huawei.com>

[ Upstream commit e749d328b0b450aa78d562fa26a0cd8872325dd9 ]

Fix to return a negative error code from the request_irq() error
handling case instead of 0, as done elsewhere in this function.

Fixes: dce143c3381c ("ipmi/powernv: Convert to irq event interface")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Corey Minyard <cminyard@mvista.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/ipmi/ipmi_powernv.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/char/ipmi/ipmi_powernv.c
+++ b/drivers/char/ipmi/ipmi_powernv.c
@@ -251,8 +251,9 @@ static int ipmi_powernv_probe(struct pla
 		ipmi->irq = opal_event_request(prop);
 	}
 
-	if (request_irq(ipmi->irq, ipmi_opal_event, IRQ_TYPE_LEVEL_HIGH,
-				"opal-ipmi", ipmi)) {
+	rc = request_irq(ipmi->irq, ipmi_opal_event, IRQ_TYPE_LEVEL_HIGH,
+			 "opal-ipmi", ipmi);
+	if (rc) {
 		dev_warn(dev, "Unable to request irq\n");
 		goto err_dispose;
 	}
