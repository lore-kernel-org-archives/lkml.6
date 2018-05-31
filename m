Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754021AbeEaGYp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 02:24:45 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50886 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751037AbeEaGYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 02:24:42 -0400
Date: Thu, 31 May 2018 09:24:24 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Hoan Tran <hotran@apm.com>, Phil Edworthy <phil.edworthy@renesas.com>
Cc: Hoan Tran <hotran@apm.com>, Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] gpio: dwapb: fix a signedness bug handling IRQs
Message-ID: <20180531062424.3pfqikwzxryi6teu@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8909 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=731
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1805310071
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch flags a couple bugs here:

drivers/gpio/gpio-dwapb.c:447 dwapb_configure_irqs() warn: always true condition '(pp->irq[i] >= 0) => (0-u32max >= 0)'
drivers/gpio/gpio-dwapb.c:627 dwapb_gpio_get_pdata() warn: always true condition '(pp->irq[j] >= 0) => (0-u32max >= 0)'

The problem is that we're storing error codes in pp->irq[] so it needs
to be signed for the error handling to work correctly.

Fixes: da069d5d2b81 ("gpio: dwapb: Rework support for 1 interrupt per port A GPIO")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/include/linux/platform_data/gpio-dwapb.h b/include/linux/platform_data/gpio-dwapb.h
index 5a52d69c13f3..419cfacb4b42 100644
--- a/include/linux/platform_data/gpio-dwapb.h
+++ b/include/linux/platform_data/gpio-dwapb.h
@@ -19,7 +19,7 @@ struct dwapb_port_property {
 	unsigned int	idx;
 	unsigned int	ngpio;
 	unsigned int	gpio_base;
-	unsigned int	irq[32];
+	int		irq[32];
 	bool		has_irq;
 	bool		irq_shared;
 };
