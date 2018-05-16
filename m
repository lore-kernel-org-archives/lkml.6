Return-Path: <George.Cherian@cavium.com>
X-Google-Smtp-Source: AB8JxZpBJEYVediC3pPyqNVoDxf6cNTbBayhWvCqfygekOpQ8F+pUBlA1w1Cw7BcyjpVoVV5Kffq
ARC-Seal: i=1; a=rsa-sha256; t=1526454036; cv=none;
        d=google.com; s=arc-20160816;
        b=Zk4tE3UN13WqdnO0ONw9kgpbUCxOsSoxMZ/iqJJ/Sie2tYAlenowwJuHfr90aB4CIL
         R1jSvzuJ2aCohO17GGWKu5m87t1e5rkrE0d9c5HthcdJ3qLQvGZIgt8gjV+A7rm2G8kD
         /VhemXmWJF6eQuFiW6rIoNzhON/mb6g+PvFOUnu/MAtrxWFgWrGIpNvP7Zak9oULGlyO
         Qt2kuYglPJeImGI6gwMmZvfrtuf55MXpEQbdQsMuENT4R3GnI+LHlPygxHIqqhH9wdU1
         qIu72ZxxJDuwRI+bn/NZSfm0fms7J3O6qy4mUvEPyn7w4hoF3lXNUYWkeTsdo1JOHQ/f
         ppSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=aoBNKp/3UXPaTnOe1LGC88VMSGMxpDOKGmu9rDCXN14=;
        b=FlTplM1udLbFdWWV2+L+5W0t/6Gq2logH9k21M0TgXDjXiOZMJXt8w8HwY4kuNvpSU
         zcxvyTnWEY7VIRC3oyr4NJi4EuI8PMWgBdnRya2xZZcAXMoi2O8I45VRnjF7BPsyTwoJ
         YVRR6hpHvx5Wq1j3XD9J9pa+r8hvRHXgjwq8RkSKCr5FSbLEVJdPTNOQ+2ZDNKR9JNPN
         QQs/My0b3hCt1wrP0jAUNmnibtvKykcd1xtB3wOMhUmkB+gsSf3ynBltEvokEgJ9Tlc4
         YMWRCNW9yCgGYCrUNdhVt2dBImr+rtCmRA8xGqh0Y6QA9ywaT1QgmzNgGII2da8VonPk
         G4Aw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@CAVIUMNETWORKS.onmicrosoft.com header.s=selector1-cavium-com header.b=dazHe6RA;
       spf=pass (google.com: domain of george.cherian@cavium.com designates 104.47.38.79 as permitted sender) smtp.mailfrom=George.Cherian@cavium.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@CAVIUMNETWORKS.onmicrosoft.com header.s=selector1-cavium-com header.b=dazHe6RA;
       spf=pass (google.com: domain of george.cherian@cavium.com designates 104.47.38.79 as permitted sender) smtp.mailfrom=George.Cherian@cavium.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=George.Cherian@cavium.com;
From: George Cherian <george.cherian@cavium.com>
To: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: wsa@the-dreams.de,
	jglauber@cavium.com,
	kamlakant.patel@cavium.com,
	mchehab+samsung@kernel.org,
	davem@davemloft.net,
	gregkh@linuxfoundation.org,
	akpm@linux-foundation.org,
	linus.walleij@linaro.org,
	rdunlap@infradead.org,
	george.cherian@cavium.com
Subject: [PATCH 1/4] i2c: xlp9xx: Add support for SMBAlert
Date: Wed, 16 May 2018 00:00:16 -0700
Message-Id: <1526454019-32714-2-git-send-email-george.cherian@cavium.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1526454019-32714-1-git-send-email-george.cherian@cavium.com>
References: <1526454019-32714-1-git-send-email-george.cherian@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: BYAPR01CA0033.prod.exchangelabs.com (2603:10b6:a02:80::46)
 To SN6PR07MB4926.namprd07.prod.outlook.com (2603:10b6:805:a5::27)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN6PR07MB4926;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4926;3:Yj+lASWFkL32DSWvlTH9zRHEwimEgBo8lO3BlJPvOd1jeRAi92vnZ1Pt2GsnwXAF8/3MbWrdo8qsUYCZxPtGUNrwNc2hNSy6FkfuPsFBLpUFJvTq6mzx978XngsK91iFqOWGGDd5zfw+9tkoFSeblTOMGuTEjfuJ59dTeciXfKSroIA+UTXi489WSziA7K/hUEdVjW5Bz8ens6NfY7xpTNJvjiEL0q67i0jLQbUUZm9lR2qoxLWuYCypeiCUulq/;25:N8tXUOQqmafj3BsJmlScfA7HRv/fLKegaYgRTuoyTuVzPXx+SHpt+znIOVluE8PUkVZzNYYVJkxcMKMoqLeCPKqA3oCd7nkI4mLHHJEE/xyCS5i0H/CB1Jn8tsDYPCgP0Igft9q8GtVKRtr7f6Lj84fWFu/IVD7Oeh4eKY8NldxmS2tahedXmgLkUsqydwccHmBwUUp4dTI6+/7UFkwcYtJgmzUAF+yCXjFJ8T7LxW0BUYHoSM5NVrH8zHcbhBdvd6CI1X3XKCHdIbSpFgcsSopgiF7MR641YKKss+pvSmY9bdkDWPua2LRRrD3k4AYFkeLBOzs88NfE5h/+0AsoQw==;31:Vk6znD+je6MgbCRCsFNFrK0vLCkxsygW6EwKlSoxHbVCN5qDBdDK6bnlIYb7T9KTy14MMdBt+QekpFPEwx442VHgnN/z2hfNaSTJm7mXfgFd1cEzhhnaGDnUSfRgqeZKLn53bM3RfTlqVwiKsucgAg/T+QDHwosTnWld2qeN8tQa469k2qVKF+t01zCICrDBjTQnYeGe6NVyuSgJ8s7/CUmSzMwc7ab5bJzrOrwn8EY=
X-MS-TrafficTypeDiagnostic: SN6PR07MB4926:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4926;20:TSZ+ivr1jLYJ9wBNCcXftSAyBwCh31TTYPkNXWQVamQ6AEM+GQEqRbpbd3kCKamCFKrHw7cqTbp4WkpySvJ9UlrqNXH2ivkSe4SPiVXwJe4eIIzWBqRsI9RkPBM4ZG/xGXij731pH2nz77jHEmFfCFjS5tLRULaCbGGE/qCJp502Wk8nt0gLCBLaF7dCNr6VhjenGyUhPgapX7+y8TBz6svimog1FMGmuga8k6rUf33Qf9XWW9bTQ2iJtTrDai/7LPxIZ/xA7PrKHrHwjJxvEjaM0F0bZV8e2gqy/MObSLJOhroQyIDunZJyWGAp98QZJIHIgO2BFivoH8k3gEVVg2GNX7AmIS/dHKmUrHOch9UhcTXcUyfXBqxTnsqhhK1yB7QKA0Vn/ALDlL2+skk0cpGysbLwLcJ8iwx0HWe0zcj72AKKlOax7kAvU/BWmMmU6wLjLSi+nwPr/A6NKHvXi7WqD6XFhk+lxriBkgBVG3fiu/q1caUf373Ti+QQIjjm;4:loULWIme5rGbNRR4cT8UvbDMoxOioECUUe9lXABsYTjhQsTpuZy/80a6iTH+e5SABjhY9dQ+YOaPPXVQfZDy7lnFupewQmSsUdOTnZg1aRKdMcw68hSW12GGEcnTPmpUw8sQIbGCASHLIR7YiQreRTAE3pEv9FEEB1nBI5q5TWfXPoFISvi7o30JI4Ysakt6q27porRWLRlUHw56U8lEkASWkRtl3LjTzudtUbI7HdzsVz7rcdewyTWzGoYBKm9DDhb+TyT/B3kr6NUGBsmeNA==
X-Microsoft-Antispam-PRVS: <SN6PR07MB49265B139FFBD45E3EFB4180F9920@SN6PR07MB4926.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:SN6PR07MB4926;BCL:0;PCL:0;RULEID:;SRVR:SN6PR07MB4926;
X-Forefront-PRVS: 0674DC6DD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(396003)(366004)(39380400002)(189003)(199004)(44832011)(50226002)(7736002)(50466002)(105586002)(486006)(53416004)(36756003)(8936002)(106356001)(5660300001)(186003)(48376002)(316002)(6486002)(25786009)(16526019)(16586007)(305945005)(4720700003)(68736007)(446003)(6666003)(72206003)(478600001)(476003)(2616005)(3846002)(6116002)(956004)(11346002)(97736004)(4326008)(52116002)(51416003)(76176011)(2906002)(26005)(66066001)(47776003)(6512007)(81166006)(81156014)(6506007)(386003)(69596002)(53936002)(86362001)(107886003)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB4926;H:sbr2s-28.caveonetworks.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR07MB4926;23:erCykEJpwXMCsNntt6ZMh0pvG/pptO6W3RY0s+JFK?=
 =?us-ascii?Q?bpe8+PY+ZQxj/xdUAGO22+j83B+imIhsuehub9Yw8rq+RVC6FUoNM9ZQHscJ?=
 =?us-ascii?Q?cVrQqyMNtEOgbnn5Lgn7Mzlx4+Zdd7ggKlix9NGwTNMon3IyLLz3/YC1m6MD?=
 =?us-ascii?Q?LFNrj8ta09wXzvOBFHNkwsthpkJvzv97tdXR5+oN7V0+FfMqfdf800dSl3ga?=
 =?us-ascii?Q?aZXNiTg6pxpN0oLiKkUnJTfXTjcpV5Z7wZeTRToi7bpMDVlejpWJhzjvI69g?=
 =?us-ascii?Q?WT2YptBsTwEbatTGkQlmTmHztONoU9syJgtDBYR2sWH35eyO9G1JpheJz48X?=
 =?us-ascii?Q?YnNoLgHAIUBO+oEZNmHK6os9WMfGS34klfq5kPvOCc8q/rBif4auw+8VAGkk?=
 =?us-ascii?Q?53jpUvcYLqTorJBYPRg0lj+nj0e8Q4ZEv4BpHmTYql5YXwBYHxGT2JX0itxF?=
 =?us-ascii?Q?v5jqHPQoEik4eK7EcgP5z7riZhxMDJsWxu3Mofvbbcqf8j9UVQGBjM0C0P/a?=
 =?us-ascii?Q?GLKt212jw53pMba5roSNWH+JjdyBzoD7nDdQvHeFdpWtrBKx8oM2SfoCwf0A?=
 =?us-ascii?Q?nStddluCFzAH2EmJIHkQse859gXtCu+/G97jfdiSpVYi2RqsnXcmWSkjeqYQ?=
 =?us-ascii?Q?iupG9zsOOd/hpP/jp+NrGOW7yPjeEIM5H1v61K9UHdAcOYMckbBeXTDvNb6H?=
 =?us-ascii?Q?uEcjaeYckPw9PfF9mI450DYwA+yRidE6MKFT9cMoXNITwMAeg2oU/uq6YWvJ?=
 =?us-ascii?Q?QyTkrQaTpPi6reSC5Syg17mZ1/8AXFEwg3pR+zMuAJ1QlteOh6VY12ajvuxp?=
 =?us-ascii?Q?8q8Xr8/9wBfM30A+wOHeQLXU3248FJe4uxx/2RpD1GtXoAEcSRVXWxTVZfHG?=
 =?us-ascii?Q?kEwS+FUjEvzG9hxGDzObuJNFtYXPotR4Zg/B48a3aj6tpUxySTmcVcvjqEtV?=
 =?us-ascii?Q?QFTGIw6FatI8hVLMmlIQYkwX6xuZHm3POTuCDeHW0ZNNku2Rh+QyNnSTuMom?=
 =?us-ascii?Q?qi5Si5ukzKadeONxox6TooLxp09l0eJw3Opm98G8oQdrzczLgJHvTCSTf/U+?=
 =?us-ascii?Q?BpGTEkEMHzx/QksLvAdmGWcOTlfkNRNeHE0ZGT7mipDP81vLq+JeJA8d9B+9?=
 =?us-ascii?Q?6iaKrHvjBOiw8CwStHRC6IlcTF4VOu2imMtlM/W7S3I3101U7WWd2W1PO0TT?=
 =?us-ascii?Q?ejjhfx5Kap+Tlx7NDVcwM7fsOBER3RJyL6vQpSMov6ln6QC1/l5D89uyZ/LA?=
 =?us-ascii?Q?pBsFP0jNjht+3sfJH50kOUNFodgtLwzSquuNGbIZ3TcWRUR6TU7wXQxX1Qgp?=
 =?us-ascii?B?dz09?=
X-Microsoft-Antispam-Message-Info: ddKsPT+Y8xgvJv0KIwZaKlArDMp27EG59oufszAu5UrrWTiByvnv/Pn5yRdoy96z7NCqTs5LEnUxUU2d3TQDkQ+l+TqXZw0EapHZvO71BPsSBVSCq+RoIeCPvQHadHHScYMF3P9PobWq3xyvPx4rds8NP6TGrvObRqIhtanFAuLo14AaNvRAEk6YZw3IOe0r
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4926;6:zPiQpNMF3glCigR4MbLqI+zHhcZdPgwIfXKyWAgcw7lMapyKwzV4BoH/u6NBn1r+ptI2+0jhK1oox0xRySnRz2j6xfxhEEQTWXsj1wMN2oYkVds9gz/SUlVAb55+MNUYDwj2lAnA576FjXJy7AxEGGQYPeYRFduF/7yxCIga4hOn6Y+x4pKzihq6FGb2kCQy5nXhV43Hwm0EH/5reV4hVl8AOj05lbiHW6zEp5liQLGmvkdz0MxKtiFGOD8GadNh8S2FBJrT8+Py7Um3uYqk013oGbfP3FOiVUMzlNFPYCK8ihmhxq6jxbevS2EnBKssXI7pZxhRCW3xRZQKBiydvbMIRKgKBlF2UnhDDiIF2wtPnKPWUILtmlExnOWtoTu9yHq3tzQvM2H5uPyZY6lf8lCXPlpldZ9bxEngIqoUQQ8GUqFRP/MQ6l67eoDY/ry1wB0o5QF83eq8RIww8WNxuQ==;5:bz3bXboT/YahjXsYXNDsokfEBi/fTPGHqHyyNKCg3dbjgpR63Xgh1Q1N9tljVZDQ65VetxInwwkgI3SKLYN9TDUm0FBjNIKdIiBDeYaFgsbeEjit3F21hYnh5ehJoAWTQHEDZWzpFfUs/K75gtLXe87Aj2XnFOTx0PvY8z6rFSU=;24:2m4lOJC6f0pVrylTc9lXRbB8tHz/1xSr+BvJKowiz6FKI0GpcC/H3oeRNmDRFSLQktJFlCCEusuWD6Wril8RHep0h1jiyPNeMH2V6GRXOmc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4926;7:rUgDvl87XUU+ctOd7uWOm7sBN1osBslqRZZdq7dxJPwxmnBz6fzCLOVZJb8f5YbQBxFSPX1Vu3NGsBkv58VOZHxhetCZvgI42Z/jiXcmHkZtI1tBbB0BwOP0oNBfHh7DkVwh80WaMUo/HLf0Z6ZAGz9Y6OyaxbjVVUs7QgD2rPUXU54Q4NZuzbWis0bsWGDZ+5b81iEyIfe8DU64w2Liyb3lO6p71R78x34E0rGNDlEe5SvlL+vG1SlRzwpMeGRo
X-MS-Office365-Filtering-Correlation-Id: bcec910d-29b1-4bfd-008d-08d5bafab87e
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2018 07:00:33.7565 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bcec910d-29b1-4bfd-008d-08d5bafab87e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4926
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600603067396490520?=
X-GMAIL-MSGID: =?utf-8?q?1600603067396490520?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add support for SMBus alert mechanism to i2c-xlp9xx driver.
The second interrupt is parsed to use for SMBus alert.
The first interrupt is the i2c controller main interrupt.

Signed-off-by: Kamlakant Patel <kamlakant.patel@cavium.com>
Signed-off-by: George Cherian <george.cherian@cavium.com>
Reviewed-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/i2c/busses/i2c-xlp9xx.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/i2c/busses/i2c-xlp9xx.c b/drivers/i2c/busses/i2c-xlp9xx.c
index eb8913e..fe54512 100644
--- a/drivers/i2c/busses/i2c-xlp9xx.c
+++ b/drivers/i2c/busses/i2c-xlp9xx.c
@@ -10,6 +10,7 @@
 #include <linux/clk.h>
 #include <linux/completion.h>
 #include <linux/i2c.h>
+#include <linux/i2c-smbus.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -84,6 +85,8 @@ struct xlp9xx_i2c_dev {
 	struct device *dev;
 	struct i2c_adapter adapter;
 	struct completion msg_complete;
+	struct i2c_smbus_alert_setup alert_data;
+	struct i2c_client *ara;
 	int irq;
 	bool msg_read;
 	bool len_recv;
@@ -447,6 +450,19 @@ static int xlp9xx_i2c_get_frequency(struct platform_device *pdev,
 	return 0;
 }
 
+static int xlp9xx_i2c_smbus_setup(struct xlp9xx_i2c_dev *priv,
+				  struct platform_device *pdev)
+{
+	if (!priv->alert_data.irq)
+		return -EINVAL;
+
+	priv->ara = i2c_setup_smbus_alert(&priv->adapter, &priv->alert_data);
+	if (!priv->ara)
+		return -ENODEV;
+
+	return 0;
+}
+
 static int xlp9xx_i2c_probe(struct platform_device *pdev)
 {
 	struct xlp9xx_i2c_dev *priv;
@@ -467,6 +483,10 @@ static int xlp9xx_i2c_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "invalid irq!\n");
 		return priv->irq;
 	}
+	/* SMBAlert irq */
+	priv->alert_data.irq = platform_get_irq(pdev, 1);
+	if (priv->alert_data.irq <= 0)
+		priv->alert_data.irq = 0;
 
 	xlp9xx_i2c_get_frequency(pdev, priv);
 	xlp9xx_i2c_init(priv);
@@ -493,6 +513,10 @@ static int xlp9xx_i2c_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
+	err = xlp9xx_i2c_smbus_setup(priv, pdev);
+	if (err)
+		dev_dbg(&pdev->dev, "No active SMBus alert %d\n", err);
+
 	platform_set_drvdata(pdev, priv);
 	dev_dbg(&pdev->dev, "I2C bus:%d added\n", priv->adapter.nr);
 
-- 
1.8.3.1
