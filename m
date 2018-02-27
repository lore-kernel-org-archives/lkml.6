Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753329AbeB0N0t (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 08:26:49 -0500
Received: from mail-co1nam03on0056.outbound.protection.outlook.com ([104.47.40.56]:49808
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753265AbeB0N0p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 08:26:45 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=George.Cherian@cavium.com;
From: George Cherian <george.cherian@cavium.com>
To: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: wsa@the-dreams.de, George Cherian <george.cherian@cavium.com>
Subject: [PATCH 2/3] i2c: xlp9xx: Handle NACK on DATA properly
Date: Tue, 27 Feb 2018 13:26:19 +0000
Message-Id: <1519737980-27997-2-git-send-email-george.cherian@cavium.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1519737980-27997-1-git-send-email-george.cherian@cavium.com>
References: <1519737980-27997-1-git-send-email-george.cherian@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [111.93.218.67]
X-ClientProxiedBy: BM1PR01CA0086.INDPRD01.PROD.OUTLOOK.COM (10.174.208.154) To
 BY2PR07MB2328.namprd07.prod.outlook.com (10.166.114.142)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f7a1193-030a-421d-77b0-08d57de5be33
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:BY2PR07MB2328;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2328;3:6g1UKXxsyvm8nSlAqBFy7axJj+7xGtdm7pjuSjpnMn7oyzxEX7kcslMwoTi++Q7TDJMYNtWS7HJmSgXLdSM+1nO+vSC744FsLxSI/ZUcRT5uxkd6IAIhleOZOnd+mBnkbwFuZNhqTLkqrVhJHOhxG1JosXf5JHK00xSd5EgQJc/j7CyawwBd5BihcHjNk24UQh6/l4umVu6ty36b1ZcVtBKA1PrVwkBjUn25Jgi61hNQvJsXQC3ZSaQA/CL9B5TR;25:72M9V16ZYkeSGAfvQXEnenCszjzZoCm+5e8bFY7jcQA4svKABVWwruaAkrN3gVyOv/xs5JDHLMT5CoMcuF4/EOW2iJ3TxRmD6O2prk+LBrlLQRVN9zekyRkH9adYxstms+H0TG8O/ZrAwBpN0hNnTCFBA0ssZIqDzzNAhuzCkVJ57TxGy9AMzlIcEzE/CsBkOHtvhhtjnWytdo9s8MOE0IHholwg3jsggzvqaEnU9DbXAiY3DFjtNPdEmu0CKuIygoQ/Vs0VrLu/133bc7xpWQN+TtkGbG7EfRPFHfBKNELRY5GyxeT1YJeazRiPDCLm77txaZKqQbYXM1Wa5CqFjw==;31:CKul4eXze1KN64r8n2H46Zrj378n4Yr5ssMgzTFfWxATMkzTxO2RgY8YvuQKk0J+t54nGxWahPTGPvm0Lfzhajb2toB483ACPpvVDrFgfgi8km4tZHMj1ajJF8jwqMLWxVVVq/xl9p+BG0yDA6JbdBJVc2dYL77ZQm+r9ajwJGLtkuOF29a3+5c+NEHoIs7y9S5f8jR4h83e4p71+Wg9PgXZRCcV2Fx5Ky9TaalAdy4=
X-MS-TrafficTypeDiagnostic: BY2PR07MB2328:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2328;20:2OIcT6CJeXyiiSaWexvVGtEW6akH3S7WbpZk2vqOtvbICiB4lKlJiRRUPAEvZKaor1kLSZkSOxH9cahwTHSWd6EkSc8f1QtxLrV2Qk/99HIVWV+nVUJwBm9zSBnuCJdeJKLXb4Lbwaz1XrPjjKEoS7brBG7pnCbn8VgF812WOCDgDPJ7I87klw0THTJrw5il1nbPsfKeTb59cJ6hPicjfye73BSjhP0DWgZetFnoS4iRtRx9TXb78UJcAlhVSxSGAHVECzFyQKGpjVzQNrtFrVhH6V6FLD0YtzxyXrVSIhvHmOjacK2FuQTKPwMND/upnMZZi0uEj23+zIDdjfzKXmnK/JiuQkKhvv20y0uAqNoZ/NYnOrN6x1fumYmPmTLgm6JHd3EPjplDv3h3c6srDtlk5MJXeZI7RO8csM0mG3qaLIyZtvPGzJhgicdBh1A5X5OXD6NBTBjoUe7rpETKqL+lKXtMj1ISc+/5ZUaeFwhnoxx7ukrqeOZcHDYRah+5;4:0CGMShNwXEz0hR0kh34D2f47Lqxru4qxvDMI9cTOUwShuNjej6/HoDu/yTKL+VeeoCdTGpeGgiMCwVMG2Xb0R5JYGB7WVNc25uurIXN2DqzrLmxF02jQCWpJqVNN55SiwhTvQ4JIFooDRlxYYJpaPhD1QAp2i8XqwVaud6MgNPhdgMQonvFvbuwf6HtvayH9hI4jNcz1Wsw6f+I3q0sEHz2EdCSOZ9WU1fRuXb8Umuh8q/0Hr6mYps12fM7YYT9UFmlYOjwUIpO+jGEMfymHTw==
X-Microsoft-Antispam-PRVS: <BY2PR07MB23288C41C503F74FAA74DE37F9C00@BY2PR07MB2328.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(3002001)(3231220)(944501198)(93006095)(93001095)(10201501046)(6041288)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:BY2PR07MB2328;BCL:0;PCL:0;RULEID:;SRVR:BY2PR07MB2328;
X-Forefront-PRVS: 05961EBAFC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39380400002)(366004)(396003)(39860400002)(199004)(189003)(97736004)(51416003)(50466002)(86362001)(48376002)(36756003)(66066001)(305945005)(6486002)(7736002)(53416004)(26005)(386003)(68736007)(16526019)(478600001)(16586007)(6666003)(76176011)(72206003)(316002)(52116002)(4326008)(59450400001)(106356001)(5009440100003)(25786009)(2950100002)(107886003)(551934003)(105586002)(186003)(6506007)(53936002)(6512007)(6116002)(3846002)(5660300001)(81166006)(50226002)(8676002)(2906002)(69596002)(81156014)(47776003)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR07MB2328;H:ubuntu.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR07MB2328;23:1BBIpMSTP3/YEuWSp4f0Z4o5M5I9BTByCQeKI+K2B?=
 =?us-ascii?Q?ztt69t8MxzVqiq8RolSM99iMmco1bykrYG8cb48u+7QV9AaJYVc1dO6fq+3+?=
 =?us-ascii?Q?c4dqsb2Mndt688Iunt6dE5edwE1SeY2WEy7udNhZQH+6TcLbpF2wZoXCQUEn?=
 =?us-ascii?Q?nWmaNMgB3rh2hish7dzWLsgCSoAdt3oj2VsZEDNg4gKPqmQvQ4Q+Iuc9kB3Q?=
 =?us-ascii?Q?+22SIFm72wej/XOT7ztapUgRmgkzzENmtdFzHoe6wMgLJK+mMlZTG3qIT6xb?=
 =?us-ascii?Q?kxJlkwR4o4Y0ERICxUjU8DXvwd+zf3ddeJ0+K1Z2Dz0L3vW0A6ItLSxt4R22?=
 =?us-ascii?Q?7sjm6Y+0jDUydXTdMXyA0AcqHIrqoXRvPZsCsJ+RrJ1vIaO4mTGw1J8dAgS7?=
 =?us-ascii?Q?1DdnoPFMEor9tygPGFqUAHmrrFHCmN6XA7ONJ4AHWnFt7dbOghQQ0UMs7Hda?=
 =?us-ascii?Q?/kB0XzWXKfojlgbylcTI08UHGbTImEE4fZqJZuQDI6Woa0j98lCWCR0V0fM1?=
 =?us-ascii?Q?nOMMCoItWLEWtyGzhLX3/Rp7CxfINpkK50en7n3/z/QojFTIi/3tWtjqrA7h?=
 =?us-ascii?Q?xs8KWRQr4ReRjuXeD5djb9qqj/kdKuiP2ercUeBmPu7dajw6nQPtS82KdjtU?=
 =?us-ascii?Q?gzRagnUtn9AT+Tqy/u9tho9B3k0zcMCXcW8yUlewTbeOMD28PAHy/TGMzMi2?=
 =?us-ascii?Q?g9hyeavQTur8JsRDNM6qhf4LW4nFRHtuYh71FisoSajPdpEL+uEYgvctN8yO?=
 =?us-ascii?Q?6JvghbhOfW1GZywiOzOXLhTa0bJZOFVpQw0OnSR+A0qzUUCNzMBOrzB982F9?=
 =?us-ascii?Q?nWdWn/lLoz8dgPvxwBwgfkfuxUSmiICTZPSYYyya2ZNb4XtlWq+Z2Rofdms/?=
 =?us-ascii?Q?oIshmYEz3sLrMazo23pX6WcuOnFXzmqQzU8yNjQ5ZJz6KP6tgf02lSwnL67S?=
 =?us-ascii?Q?ZQqv6NpLkipBk8OxPv37NVbjVwCZG91y+U7V1xJzI86nbthdm0548Mj6ENLV?=
 =?us-ascii?Q?ue0qjzuY82rOkJD68CfgS6paskdNDesb814sx+YNyqmn5RG1RGA7WMfixT9R?=
 =?us-ascii?Q?wJJobZCXFTJtUgTx6XDVC95Pc62upmmS3wO0ilhksaafv2xMVmPRpVpbpsqq?=
 =?us-ascii?Q?2kLGmT5ZBW8IcLyv/euV/m7ATWfSLrUHPKDU90rzcYuzH+nUivxG3QCCK3v3?=
 =?us-ascii?Q?6d+2jdWUL25f4o2kYH4vnaJE3QcWzEIHjUzflLYRwCTcnuV+aB8qthT0u8rT?=
 =?us-ascii?Q?WfXDtLsYBGM8CjklD0=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2328;6:267CTjAi5pqCKgGCAGZECmtKC00N19VMnp9xtLh9grl5OcxhYXdghxT1k4ba0yMA551lBaOnyC3peQ9NloujcOzVAy6kWxvFSs/t0/QNOVBerQHYUaICmbb3R2zT/OwKci56WCN/j3fWSuxBHXflx9HeQ01I2+2l/xF6qOFuIqbe2DxruoujvbcmBiMlXHUHt9H8z1HGHfMCce82eb1b6TrlOIJWxLH8mhXlrs3+QL1MRaSLXlnX6nYYVDcRRrDyfTWMY4Z3yQGUixbfLw5Bp42vuaKV76mYXuGPQ3M2V0ocxamvA1sBtpzq37ELfBhdeI1p/w2zVoKvaCAYpwMasG8qDz/qngntFoZDitIq4ag=;5:zIn5mPsvPekLfWXZ/0AYwXCKMdjmr79S89utyf6XXHrIDToEDyDs8ULEP11XuZ7iY8UGXF8SyCEjS3glcVQ0NAmxBqKBw187QaM45jcUpprb8pXfLNFGJAa9S8wHebZEE6c680iKpSiUyBvUQmnIG16cxCqKG6/Ta+ivxcRy8qU=;24:bVNyUVoYjwuGkF1ByuZGweuRoboWucVeNBdEyYhJDMP2qbzsZ9ClnH0tfqL1G1jlfmARYo2fLnShXWN7PWxYuaAMQjuOa1JuG9kK5OnMDAo=;7:ssD9XmN4DPqLcw/tjKmM8HPZ/Xgp9rcdBfLLPUOtDHqEMAgkWApbTuAwNjauRX0s5Dzx1It5BbXIFhexJKFwzRx0SzIPeperWwlYCOEDqODftPYxQvqpCMbODQ6Ux8AQDsPDOTev8cI5x6Tx27GjSJVEb1/+uvWrhESZw6gX3he+KjAqPZ8vdEkkI01GLs831ZpGyv8DL6zKf92pD0+HIo7qu4a4liz4QyP3CtLc4JxHh+VeHvjKnmZdjngfMFio
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2018 13:26:41.8256 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f7a1193-030a-421d-77b0-08d57de5be33
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR07MB2328
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case we receive NACK on DATA we shouldn't be resetting the controller,
rather we should issue STOP command. This will terminate the current
transaction and -EIO is returned.

While at that handle the SMBus Quick Command properly.
We shouldn't be setting the XLP9XX_I2C_CMD_READ/WRITE for such
transactions.

Signed-off-by: George Cherian <george.cherian@cavium.com>
---
 drivers/i2c/busses/i2c-xlp9xx.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xlp9xx.c b/drivers/i2c/busses/i2c-xlp9xx.c
index 42dd1fa..eb8913e 100644
--- a/drivers/i2c/busses/i2c-xlp9xx.c
+++ b/drivers/i2c/busses/i2c-xlp9xx.c
@@ -352,7 +352,9 @@ static int xlp9xx_i2c_xfer_msg(struct xlp9xx_i2c_dev *priv, struct i2c_msg *msg,
 
 	/* set cmd reg */
 	cmd = XLP9XX_I2C_CMD_START;
-	cmd |= (priv->msg_read ? XLP9XX_I2C_CMD_READ : XLP9XX_I2C_CMD_WRITE);
+	if (msg->len)
+		cmd |= (priv->msg_read ?
+			XLP9XX_I2C_CMD_READ : XLP9XX_I2C_CMD_WRITE);
 	if (last_msg)
 		cmd |= XLP9XX_I2C_CMD_STOP;
 
@@ -361,12 +363,12 @@ static int xlp9xx_i2c_xfer_msg(struct xlp9xx_i2c_dev *priv, struct i2c_msg *msg,
 	timeleft = msecs_to_jiffies(XLP9XX_I2C_TIMEOUT_MS);
 	timeleft = wait_for_completion_timeout(&priv->msg_complete, timeleft);
 
-	if (priv->msg_err) {
+	if (priv->msg_err & XLP9XX_I2C_INTEN_BUSERR) {
 		dev_dbg(priv->dev, "transfer error %x!\n", priv->msg_err);
-		if (priv->msg_err & XLP9XX_I2C_INTEN_BUSERR)
-			xlp9xx_i2c_init(priv);
-		return (priv->msg_err & XLP9XX_I2C_INTEN_NACKADDR) ?
-			-ENXIO : -EIO;
+		xlp9xx_write_i2c_reg(priv, XLP9XX_I2C_CMD, XLP9XX_I2C_CMD_STOP);
+		return -EIO;
+	} else if (priv->msg_err & XLP9XX_I2C_INTEN_NACKADDR) {
+		return -ENXIO;
 	}
 
 	if (timeleft == 0) {
-- 
2.1.4
