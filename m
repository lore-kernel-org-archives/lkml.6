Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49BD4C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0404221A80
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="KAeMheDJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733014AbfBKQGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:06:16 -0500
Received: from mail-eopbgr50055.outbound.protection.outlook.com ([40.107.5.55]:47182
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730785AbfBKQGB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 11:06:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector1-cern-ch;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ECSIoVa8JW6O8tJu7FSlaxo4KybqvBjFMHglIfGO/yI=;
 b=KAeMheDJa63B5kvqb903G1m+jpmxVjI3nplqkgFN3Fwqiz4J8DDMDIPBXeHQlJh1D7e08srdbjimwHXpJ4ZpIpfB+R9N/9mU0wis95gexReDpNrCq3EWEq+utvskeNtkOiSFn+4wuMr5Tsgo6PCcGkIqg5cRdsqitFv1PVrsOOc=
Received: from VI1PR0602CA0013.eurprd06.prod.outlook.com
 (2603:10a6:800:bc::23) by AM4PR0601MB2146.eurprd06.prod.outlook.com
 (2603:10a6:200:47::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1601.22; Mon, 11 Feb
 2019 16:05:57 +0000
Received: from VE1EUR02FT009.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e06::200) by VI1PR0602CA0013.outlook.office365.com
 (2603:10a6:800:bc::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1601.19 via Frontend
 Transport; Mon, 11 Feb 2019 16:05:56 +0000
Authentication-Results: spf=pass (sender IP is 188.184.36.50)
 smtp.mailfrom=cern.ch; korsgaard.com; dkim=none (message not signed)
 header.d=none;korsgaard.com; dmarc=bestguesspass action=none
 header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.50; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.50) by
 VE1EUR02FT009.mail.protection.outlook.com (10.152.12.226) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.10 via Frontend Transport; Mon, 11 Feb 2019 16:05:56 +0000
Received: from cernfe03.cern.ch (188.184.36.39) by cernmxgwlb4.cern.ch
 (188.184.36.50) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 11 Feb
 2019 17:05:38 +0100
Received: from cwe-513-vol689.cern.ch (188.185.69.206) by smtp.cern.ch
 (188.184.36.52) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 11 Feb
 2019 17:05:39 +0100
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Peter Korsgaard <peter@korsgaard.com>, Andrew Lunn <andrew@lunn.ch>
CC:     <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Federico Vaga <federico.vaga@cern.ch>
Subject: [PATCH v5 1/5] i2c:ocores: stop transfer on timeout
Date:   Mon, 11 Feb 2019 17:05:25 +0100
Message-ID: <20190211160529.23858-2-federico.vaga@cern.ch>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20190211160529.23858-1-federico.vaga@cern.ch>
References: <20190211160529.23858-1-federico.vaga@cern.ch>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [188.185.69.206]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.50;IPV:NLI;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(376002)(39860400002)(2980300002)(189003)(199004)(4326008)(486006)(426003)(66066001)(8936002)(110136005)(11346002)(126002)(106002)(16586007)(476003)(2616005)(956004)(336012)(106466001)(8676002)(51416003)(44832011)(446003)(7696005)(47776003)(54906003)(36756003)(246002)(6116002)(74482002)(3846002)(316002)(305945005)(7636002)(7736002)(76176011)(50226002)(2906002)(786003)(1076003)(50466002)(16526019)(356004)(86362001)(6666004)(107886003)(478600001)(53416004)(26005)(14444005)(186003)(48376002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0601MB2146;H:cernmxgwlb4.cern.ch;FPR:;SPF:Pass;LANG:en;PTR:cernmx11.cern.ch;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dbf5e449-e95f-4b3f-8992-08d6903ace81
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4608076)(4709027)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM4PR0601MB2146;
X-MS-TrafficTypeDiagnostic: AM4PR0601MB2146:
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0601MB2146;20:8AWKBah5El5dLwonjugPdTlbigpL7kU+/AfzHnAy/vVCOL01zgEzuYvMvEUvuBQJmWFdWM5WVN0K72N4jRv0UVrWYSChp6My8eV+ZQjC2BKSjIFsVjRgq/iypUSdnsJ67v7hSEs2fvy7i8mRQuCrjdOqBDbvylfL8HE14TuuKtNwK7njmdwhAL+PkZ+tgrj0vYO0tCzy69LDtII+c1KEhABbUwSKL0NYgSVCiz5aVJ3QWXK0kwsZzihJo7fW0k6Cw6MqWz+MGKV4UTAsT+HPXwZ9WIln4HMfrvfJ2shE4BvDvegHjNsVKCYKttksMJc2yeYZ+pY/R5VkZhixsSGlZg+g1J328jg6fWMEit6DQg5Z83hSqUbxuP6pM0gaHJtPRwMTQSZREZN77pXktDwpd2+l2Oy5Wl8JEbxoR6avKfx8O9BI2WM14xoc8b7DxjTKN03mhkbFOEo03ZVbsT9rdvHmbiM9AG4kU+heLrGkxyvM8cvMdraLZxzR0UoI1XoG;4:s+VuCcvDFArrs+JQEwT7lq6ECnOvZZweHH1q2rYql7P97owbCoFo4E2P5XlegRPk+Bo7rekpiuLS+F4PtPIeVSXW9Buy10nQ57YL4rJL0FNd+o9IWzXbngtoOjYRvQT+jJezvRNQ7X/egstivVpeVtm9YMiPtFtk+rBzAm0dvOczZGdMwhXf3BheAehkCxg9mODGDW6HuKXvj57ceRlHnZFKLRpTlFq+4J0QcXM+XyHKfloCNEaIhobl4jd6QB98YzwsQm1wvJhuMvHCW0WbU7eeNVPQoZB3J6d7NeSXgWXr0gtnI4Lqc5mfel4j+t2A
X-Microsoft-Antispam-PRVS: <AM4PR0601MB21463AB418C82687CEEA0F10EF640@AM4PR0601MB2146.eurprd06.prod.outlook.com>
X-Forefront-PRVS: 0945B0CC72
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0601MB2146;23:CnxcSJltXNMCybf1hU6agCcwjYuSTI+m21O5lDj?=
 =?us-ascii?Q?afU4W6s5wRGajaKc5plUPgT8iPabM3L0Tqg7XU6Fr0oiFeWou5+sHFMSni1F?=
 =?us-ascii?Q?7520XrLPXxr52hYmDhEKhhnz2CsFaptkivaW4T+CLlAMFadydWKnMmRmxfgN?=
 =?us-ascii?Q?KbePWlRdN0JhNZLwU3T+7T8fi/ZOyWoxIzHRniHtgsiK8qjIPAQJN2b1QDvT?=
 =?us-ascii?Q?ri9pCmCFKqVj7Mzvd990EpEKdq4vcNDyVquzCUcxwGol40ip1bFgJ8so9blR?=
 =?us-ascii?Q?UnkhEFyUVxRuFpAAwuofImleNHnPOi40cVqPuKRQbm4mjJkQshXz72eGccST?=
 =?us-ascii?Q?cegtrl4/caEo4b7vO9Taqlv6yptws72sbyggXA9ibQKLHDdUzwtrr2AW380e?=
 =?us-ascii?Q?BvYwVErGdokEhXzgXwBDjcDTPs6dabN0+IDqIibaKqljpDQk1Be9BrdG/Ct1?=
 =?us-ascii?Q?25lMe/skCZDkQTUBdQFYpkbr+/aNB65Z8YTyZwTcQpDllRg6LxjHjBOCtzNA?=
 =?us-ascii?Q?CoMHbnjcRgjh78YbH9+R6xVplvf9x9jC1LZnVaQPk4Ne+a8NTKZQQAWXQ+w7?=
 =?us-ascii?Q?E209JhkgGeOGFNPpYkc+DqQr07UWWxVjlk6r54nkcoP9WPieLKrv5g7aBiqL?=
 =?us-ascii?Q?xgTZa0kJpU7fLd76jVbk34UxXweEV4k4KnICD69JYLn/8RLRSvpY3g9WvAcB?=
 =?us-ascii?Q?PhfJATtA2bZ1mhfZ3bnwLFDvNwZjzrA0x+kwh4K+J9n+gu0S8AQ7zrCcxsnM?=
 =?us-ascii?Q?FwG7ZhDCo3Qas14ysIZyIVSH93CH0my+ywZCXloumioO3FhTgor0uuY3Pw24?=
 =?us-ascii?Q?w8/JeT+S52SVAh/QAP1EzQ0nNuK8AP0/mhSmcT5SA6uCwLk4N1W5ekLfcQYi?=
 =?us-ascii?Q?iq2+WZ++x9dLzLW2926ttGdGlqzOKZU9kWjWj+WzGRmUNc1WrkDCYGGvb5jf?=
 =?us-ascii?Q?YSUgIEGS8oUc58xtszi7ifR3mot2PRjGDvdGPGjsaOXik31gf3yD5YBelmu8?=
 =?us-ascii?Q?vFwtBQ57fJ5Lelm16uukSbrGsk15wyfrVSBM1douxkV8JaYPM6JV53I9hp5H?=
 =?us-ascii?Q?tKTz2qqMnKAoS+x1atCqrQUVigbm+TF20cMuwBx//h8PinndX3CZN0wbg+HP?=
 =?us-ascii?Q?JmVw4Adk9NO7orPSYfv65ZynMWwhbOGwBtQE/CODE0HfhMEiS+KVTDHOLo6d?=
 =?us-ascii?Q?eISD7YhEg1s7y2Vs4poOA7ZoJ4kGUyYbwRNOo?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: E/NX5rBy923DHcAybSmU/mW3FOODynAfcmIjAjmHsJMIqMWvyuWkkPNMSQD3HSqlVD+xwKPSwZ0FliAoyu9lNzQNwZoZQbpraZLc3hHPobVx2QbOSTnx+o+6W6Uqw62WStRSltKZMNCM8VYP+A5/Co+5o1m8ZVqlpq4O1F2Tmab1i/Nd0fLmmCpWbtJ0QLabhl6aQ1W9LoRZWiTc1Avm1NjRqAXcEv4cIRFh83jZ4uCwyy2dz2b2MJWU9w7A2AovSNFtp8crJ62dIw9/O9IbyLngq/p/YxLIuuWz0EtAXGF66l3yKu3m/hp4F1t2uMuvVS4e+zW2q3d88EAlHmEaZGxWR5TcUGWGmneFomKMJz3Hz4hH+FW/wY9Qt4vX+4+t2FyDTlIvU8qjx9S0y2PO8QuES1bABuqhzcIeJi29QWI=
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0601MB2146;6:GnZqKy7aPzaHzbul0gVoxa+oWL+JIatRlwDpq/Ae7Tq/P+d5gOifX/fw+epNwzdWV1sIhdNJjPE0AhLAqFylbO+LGUuokpKpPce76UxuG/XMJrcb2pHugrmO2tzrknZbiFS0nFWgNpqrjAjlWXpKJjnoseD6UwUqbjOJx9TP4/6th8sgABZvHCjWJbZ0sVa4fUNTao8ot31diOWsEwhVViF+fSity9x4fDAlCaYiG+f46oF3oAxzQ2IFbm79eIHysCpD7hVL8vMNvpghhB8mlBXwk1jg+9JauaEH/oC7CgOTokfNOuqRqPooDmFHJ+z8zd3QvZYW3Z5sAGfr4FKfkEjag3sW0XzfCjEiG/JqdjD+P8e+0wb/znnXIlROW01vyYEqZE5F1n6WMF1H1HIdpyBzuceVUAyQGWk/tplZxiCL0xW2LDgQhmM8Qzwfb5HZsIvj0IgdXrQEb2G61G43Cg==;5:Er66ZR4oXbSKxeqbPk2VQZPjjZhCSbCRsU+I8VssRQ1Vvs0gyRd/xNIbb0A9xn/i0dwhrJ1jrhEGBCn8EGKMX5zIj9E1VrjmQUdgSItZBwO908fooZuWmSkkGJg8VpydMDvRGV1I9lheGoaDzy6OOiXw1ThMCFeU/1VxGAlBYe7FP+PTbLw8/nX/3BDAmp6D/gfJyjyYkuVnUXZczItSKQ==;7:TBXerIOXPTAq2t+mb9dweNTXrBbRn8k/7ZauTEJHW13LkaFRS9UTS1vFMVGLeGxuz0uJ//ka2YOI8NK55rzcAKHdFzLFI+sxOhAcljIsSC/DEBwXcUk0Kmc8K5sTrajV59WRqEzvHwDUK21FKdz6+A==
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2019 16:05:56.3970
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbf5e449-e95f-4b3f-8992-08d6903ace81
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.50];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0601MB2146
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Detecting a timeout is ok, but we also need to assert a STOP command on
the bus in order to prevent it from generating interrupts when there are
no on going transfers.

Example: very long transmission.

1. ocores_xfer: START a transfer
2. ocores_isr : handle byte by byte the transfer
3. ocores_xfer: goes in timeout [[bugfix here]]
4. ocores_xfer: return to I2C subsystem and to the I2C driver
5. I2C driver : it may clean up the i2c_msg memory
6. ocores_isr : receives another interrupt (pending bytes to be
                transferred) but the i2c_msg memory is invalid now

So, since the transfer was too long, we have to detect the timeout and
STOP the transfer.

Another point is that we have a critical region here. When handling the
timeout condition we may have a running IRQ handler. For this reason I
introduce a spinlock.

In order to make easier to understan locking I have:
- added a new function to handle timeout
- modified the current ocores_process() function in order to be protected
  by the new spinlock
Like this it is obvious at first sight that this locking serializes
the execution of ocores_process() and ocores_process_timeout()

Signed-off-by: Federico Vaga <federico.vaga@cern.ch>
---
 drivers/i2c/busses/i2c-ocores.c | 54 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 45 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index 87f9caa..aa85202 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -25,7 +25,12 @@
 #include <linux/slab.h>
 #include <linux/io.h>
 #include <linux/log2.h>
+#include <linux/spinlock.h>
 
+/**
+ * @process_lock: protect I2C transfer process.
+ *     ocores_process() and ocores_process_timeout() can't run in parallel.
+ */
 struct ocores_i2c {
 	void __iomem *base;
 	u32 reg_shift;
@@ -36,6 +41,7 @@ struct ocores_i2c {
 	int pos;
 	int nmsgs;
 	int state; /* see STATE_ */
+	spinlock_t process_lock;
 	struct clk *clk;
 	int ip_clock_khz;
 	int bus_clock_khz;
@@ -141,19 +147,26 @@ static void ocores_process(struct ocores_i2c *i2c)
 {
 	struct i2c_msg *msg = i2c->msg;
 	u8 stat = oc_getreg(i2c, OCI2C_STATUS);
+	unsigned long flags;
+
+	/*
+	 * If we spin here is because we are in timeout, so we are going
+	 * to be in STATE_ERROR. See ocores_process_timeout()
+	 */
+	spin_lock_irqsave(&i2c->process_lock, flags);
 
 	if ((i2c->state == STATE_DONE) || (i2c->state == STATE_ERROR)) {
 		/* stop has been sent */
 		oc_setreg(i2c, OCI2C_CMD, OCI2C_CMD_IACK);
 		wake_up(&i2c->wait);
-		return;
+		goto out;
 	}
 
 	/* error? */
 	if (stat & OCI2C_STAT_ARBLOST) {
 		i2c->state = STATE_ERROR;
 		oc_setreg(i2c, OCI2C_CMD, OCI2C_CMD_STOP);
-		return;
+		goto out;
 	}
 
 	if ((i2c->state == STATE_START) || (i2c->state == STATE_WRITE)) {
@@ -163,7 +176,7 @@ static void ocores_process(struct ocores_i2c *i2c)
 		if (stat & OCI2C_STAT_NACK) {
 			i2c->state = STATE_ERROR;
 			oc_setreg(i2c, OCI2C_CMD, OCI2C_CMD_STOP);
-			return;
+			goto out;
 		}
 	} else
 		msg->buf[i2c->pos++] = oc_getreg(i2c, OCI2C_DATA);
@@ -184,14 +197,14 @@ static void ocores_process(struct ocores_i2c *i2c)
 
 				oc_setreg(i2c, OCI2C_DATA, addr);
 				oc_setreg(i2c, OCI2C_CMD,  OCI2C_CMD_START);
-				return;
+				goto out;
 			} else
 				i2c->state = (msg->flags & I2C_M_RD)
 					? STATE_READ : STATE_WRITE;
 		} else {
 			i2c->state = STATE_DONE;
 			oc_setreg(i2c, OCI2C_CMD, OCI2C_CMD_STOP);
-			return;
+			goto out;
 		}
 	}
 
@@ -202,6 +215,9 @@ static void ocores_process(struct ocores_i2c *i2c)
 		oc_setreg(i2c, OCI2C_DATA, msg->buf[i2c->pos++]);
 		oc_setreg(i2c, OCI2C_CMD, OCI2C_CMD_WRITE);
 	}
+
+out:
+	spin_unlock_irqrestore(&i2c->process_lock, flags);
 }
 
 static irqreturn_t ocores_isr(int irq, void *dev_id)
@@ -213,9 +229,24 @@ static irqreturn_t ocores_isr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+/**
+ * Process timeout event
+ * @i2c: ocores I2C device instance
+ */
+static void ocores_process_timeout(struct ocores_i2c *i2c)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&i2c->process_lock, flags);
+	i2c->state = STATE_ERROR;
+	oc_setreg(i2c, OCI2C_CMD, OCI2C_CMD_STOP);
+	spin_unlock_irqrestore(&i2c->process_lock, flags);
+}
+
 static int ocores_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 {
 	struct ocores_i2c *i2c = i2c_get_adapdata(adap);
+	int ret;
 
 	i2c->msg = msgs;
 	i2c->pos = 0;
@@ -225,11 +256,14 @@ static int ocores_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 	oc_setreg(i2c, OCI2C_DATA, i2c_8bit_addr_from_msg(i2c->msg));
 	oc_setreg(i2c, OCI2C_CMD, OCI2C_CMD_START);
 
-	if (wait_event_timeout(i2c->wait, (i2c->state == STATE_ERROR) ||
-			       (i2c->state == STATE_DONE), HZ))
-		return (i2c->state == STATE_DONE) ? num : -EIO;
-	else
+	ret = wait_event_timeout(i2c->wait, (i2c->state == STATE_ERROR) ||
+				 (i2c->state == STATE_DONE), HZ);
+	if (ret == 0) {
+		ocores_process_timeout(i2c);
 		return -ETIMEDOUT;
+	}
+
+	return (i2c->state == STATE_DONE) ? num : -EIO;
 }
 
 static int ocores_init(struct device *dev, struct ocores_i2c *i2c)
@@ -422,6 +456,8 @@ static int ocores_i2c_probe(struct platform_device *pdev)
 	if (!i2c)
 		return -ENOMEM;
 
+	spin_lock_init(&i2c->process_lock);
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	i2c->base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(i2c->base))
-- 
2.15.0

