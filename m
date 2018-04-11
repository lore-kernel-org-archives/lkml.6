Return-Path: <StefanSerban.Popa@analog.com>
X-Google-Smtp-Source: AIpwx48tFRB20iLhk6FWZQJ4lhdenzJ86I1+5SvstOgN3u7o0SRzqOPH4DpX9p/VtSscsZYmzyew
ARC-Seal: i=1; a=rsa-sha256; t=1523459403; cv=none;
        d=google.com; s=arc-20160816;
        b=lhsmE/QGAgIQvu8SR5acZFuzvU+NB+9dtg/MRkpZxnqsz7EcYNX1hgR9qH6KlPsBPn
         fEnmKyapyz+Jzt255/N0ZPu8yDL063/UJa366L/m5qxRpU2XimUlB2EpsQRphEi2L+pk
         kC61Q6mUzm2ybAybVE0P/kqQsU6PsBnyGW/ZSnUAysZKdIGIF3VIwzunoP08wPUjaVyV
         di1bDW2IV+W2IgRYK7lbYsV8IfmTxnzif8W2RJhrJQ19a7TlJyCnygPuGFqBSEys4ZDf
         LIox3xGkbnI25aKgyqTQGzK0TEwjWy3uT3rgghqxa1M4M6aWMAw/RDvQKdRFM0QIpIUa
         4eTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=kD8EpZ9PPXaylxD0hf/DtYSobDdBoVn8vT9mG6zV1bU=;
        b=xRa3YRGGBT7Upo+OxQohSUpurWJh+QqpOd0NIYWSNk/hVv7dvrUJtxEm2w3yP7dq9T
         xWxoJUIEWEvAX6li/BP32zhKpVZVo47LgSxSKXUMJ/xp5O7ojovU/z6cvWvN68LXEckA
         WQJhFAVZCmb25pRKuSG94ec0PxpYVqOrHFY93lDGGn2JLZon/KBb6oJVwDupCKl51llr
         BnmsS1vBakAEOTK0O1J78bjEw4LB/QjFMYujXmuD/QF8p9sGAS5b/r3yPWfxWhycxt2i
         GhkmAcSJr7o1uDXiVStFBWy4sREgTcXIMZ4fax7rmNZBi1UGF/Aibg/+yOR4D5VmlbPq
         JbVQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@analog.onmicrosoft.com header.s=selector1-analog-com header.b=M+TqEIm9;
       spf=pass (google.com: domain of stefanserban.popa@analog.com designates 104.47.32.53 as permitted sender) smtp.mailfrom=StefanSerban.Popa@analog.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@analog.onmicrosoft.com header.s=selector1-analog-com header.b=M+TqEIm9;
       spf=pass (google.com: domain of stefanserban.popa@analog.com designates 104.47.32.53 as permitted sender) smtp.mailfrom=StefanSerban.Popa@analog.com
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=bestguesspass action=none
 header.from=analog.com;
From: Stefan Popa <stefan.popa@analog.com>
To: <sre@kernel.org>
CC: <davem@davemloft.net>, <mchehab@kernel.org>, <gregkh@linuxfoundation.org>,
	<linus.walleij@linaro.org>, <akpm@linux-foundation.org>,
	<rdunlap@infradead.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stefan.popa@analog.com>
Subject: [PATCH v3 1/4] adp5061: New driver for ADP5061 I2C battery charger
Date: Wed, 11 Apr 2018 18:09:42 +0300
Message-ID: <1523459382-31523-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522829832-7866-1-git-send-email-stefan.popa@analog.com>
References: <1522829832-7866-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(39850400004)(376002)(39380400002)(2980300002)(438002)(189003)(199004)(5660300001)(336012)(49486002)(77096007)(26005)(11346002)(6916009)(126002)(107886003)(478600001)(356003)(575784001)(59450400001)(476003)(7636002)(966005)(426003)(2616005)(186003)(446003)(106002)(486006)(2906002)(1720100001)(47776003)(246002)(4326008)(106466001)(16586007)(50466002)(48376002)(7696005)(54906003)(76176011)(6666003)(51416003)(50226002)(72206003)(305945005)(6306002)(316002)(8936002)(8676002)(2351001)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB3055;H:nwd2mta4.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2FFO11OLC016;1:2Fn8Egc+TaDVrLMifXKkiOUEkEPizlomt+//z+rSPmUBFtc3ssSpEbAKWTi9oDfg1xFfe3BED6NlzZnMzj/ytYSem6lapOnNjF7C36WwsF/3dm5Qmzx/uycBUjaAFTWa
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4608076)(2017052603328)(7153060);SRVR:MWHPR03MB3055;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB3055;3:pQ5QPpFlWBOntrbPWE1PKyf+Gw/BqfUDqzZunK8mFh4NmkE70dgDdD9A5fJtn8ZbNBg3KGvCbraLqRizxq0HMjJSBWuYyueN97THz3cbgKvQVkcBZPB3Jeg1XygHBInSsurOZhfP/6nJ9NGSdKpo3xuheXJj/W9302F0H4SxplLTkGdpZ1e61Ar0opQLtu++DAyfME8zQE1YcmLXsruSpfaTdHNVEs6WNEXOAjbamXj5qwvEQ+fWM8XhAqws4i7awfRo/yCV0CG8zydyOYorHSYbqymfxHaL4CESfgUxWAAOgo+F2fseheoDCCvH9ubGzq4JIVVdPv2D4rgFRar8B70npnrmHfC5OjMa/2bTnFM=;25:nK8/E9QYbqaJ3QD1FonSlxnJNdW6crgDA/DKz4584tsQMV80CD1HXfc8ifdLsfxXFunbdkPf/gN20x/QOp7LeXhyiB+URsI47LNjayuYly8+2GvStEozLjiVqUAVIeXL5tdDlqIMxUEnHDFEONp+XMwny5MS5Jx/fmq7HzY3kx0TwR32MYmh72BtraBRG1mih5oMr8Wb6urUrCHB2Vi3yndNH+MmSlko3UMDLGTorC7+TK2cAdZvx4kS1L91/XbrPINYHLrNbAq4T6TAeIplDGzrIdXuKOH+MZXvSbELJaLjC0iMAUmIbyP3Aa7zy1EVuP9ZB9mGFY/3LvZwIswNlQ==
X-MS-TrafficTypeDiagnostic: MWHPR03MB3055:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB3055;31:dPLHDa9ImRue517DJzwduy7VPSX4AbLIhvcZzbz96xoHlH3dPMJF7cowbl8YLf9uJw1Qr/0MDQh2sfwFz6ixRLAreD2mVrImDu+uLCrMOfIQVGoHUPjD0/xN6tzKtqpgz8aWGIswyAXf23QEIG5l6hJX5ZYUcw0OC9ZNv4q/elFmyWOlZ/QLclQiqMtxd0oT8n3Un8gUSsYJLgvBCKo9I13xMQzBwrk/FsnfPJZ3B5E=;20:oBJdbfqup5Ta9Kp1HKCDx65/j7YKVyvdfwA3V+eYWqcpDAIyskGZ2Ij5m+YD3W6y4FF3h+utMwWIXSfjacAcHO8+fzgqbnoXpn8remexlkXgzf5p43qFSahhherJlSwzG+M5jaBXPTTUf5qI0N7nCT1Tv7i/UsHfxXo5j9kc0L04vVptSRzJnn5OQILbdhHB5eKJlSfJIXlzIi3vGZSWrWzRDraPczCeDSJk9tNWfGWjkjIfr/1bs7L2ogW6822EJbxZuR6QTyU26L+nDIO7fsDUe/FENlg5cA+l+EC0EqcmB5ozdecK+MC320fhwgWYm5LGkm/2fr1bP5kbe1B46BwQF4ErJ0HPkOy6Ux8O444vLFLictL6EaEewqUNGcJR4XTJeUPL0uYukvopQkBoDCry94IrcMdVHg/yISycGzlRan3qWtHmBiJCqnn2mRhWUVwl1Dr93o/u+BBkWXuAhSc+9j1t50EpNgF17uKySUHjcch2jha7c7+SPn/C/xxI
X-Microsoft-Antispam-PRVS: <MWHPR03MB30559F6B0DE36783F854FC019DBD0@MWHPR03MB3055.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(270121546159015)(9452136761055)(232431446821674)(170811661138872);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501327)(52105095)(93006095)(93004095)(3002001)(6055026)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:MWHPR03MB3055;BCL:0;PCL:0;RULEID:;SRVR:MWHPR03MB3055;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB3055;4:uW5drsWeCdw5hErXce+K1cymoPNfkybwuTh4vTXhatrWf4HCjTrix3x+J8IlKMqxe/HZs629snjWKMWTrke00dkt/GyXYW24NgXcyr6bK3HIS2RH2XdzZc+C4bvKdTxrVfvcX+cPGUizOK5qIeLtwGwUDaCMo8uapwraB+6vbK3fABNZmSQ1HXlHou/fOvvyL83YaVgDeBApjgum/z0m35g7nlPI7utLzigeUmB5rGyMdKroayuD2AB8Q0fSe9x5OzcLaqe6ZBt+xxAXox6Hl2+B22Jsc3Llyvx/merpoJIC5ykNUuUyJHeRkFE1DldUAp3aQn5eofnPQvmm7/AJMSF4qX0I2MKSRHF0YiyrHvgVXT884KpzZZ32bvBMWKEanF8J+4ucRToXn56FX/zY8qy770sca8Z/xM5QyknvMeo=
X-Forefront-PRVS: 0639027A9E
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR03MB3055;23:+I6NGZVtBYuT4sKCvHawu8hkpofLRa7RPmiJsKhuM?=
 =?us-ascii?Q?moRIi3dBWfBQ2Yp0Y3Yw71AhT28DPQHdGMskfFMVdB7WgHlmNidi+vkUcWmZ?=
 =?us-ascii?Q?jb0yJ0AftKHk/SXQFbw3rWAZHDK6ac7kP/Emr8c3wK2r6ODxPaIkDzAY4ES9?=
 =?us-ascii?Q?3d1A46uNGEUrpKWJ9DCh/RyLDIxmdU4IqMHoUUBoFHHG8ZSIStORMwY3RXxh?=
 =?us-ascii?Q?0YjxmVrikHnBgW9O4ZEcE+APuvdrLkl31hKU8wxgpEjYUP1c7E3YDcrpTewj?=
 =?us-ascii?Q?DliDPE1Mb43RV+RqCqoraGaahVyhzQF8t3Kkmx7PzeMdpCzTr/vwmRvoLh9q?=
 =?us-ascii?Q?NSosCgjcri2U7HPEoNoKhz/3LR3ql4O27eB3EBq+jZ/kURQu8OKIfs+PevaV?=
 =?us-ascii?Q?6UQqj2SL8tfEGlcJUdDDw+3qMXozbbJLNjxfUf6dn4ZoExTEkFC3fk2MqOhg?=
 =?us-ascii?Q?uMMUJ1q/33TjdhfhvKI676wOhPUbx19HVcmd5O2539qwN8xsmxLRHmTSmWxN?=
 =?us-ascii?Q?bbpXJ1r9qqHBHE3wcK7ns2PxNRwsYySRShCVWYiMkqPzyJPJVsrlXpNro5nT?=
 =?us-ascii?Q?t5OVe8t/BvhagSTYCAOs78Wf6UB9KhlZx9effVTdSXDsLM0yuPHHfZajp/R0?=
 =?us-ascii?Q?g/VMPAY8L+xrpKwisDr4zyNvJgbiyFkrRlZNymire54VEhvP8TvDXY5dPAbj?=
 =?us-ascii?Q?R8HET4JfSNXDfkW4exvZScOp+WYj2uQws3z9mtja4sALh3Z9OE3Hnui+hwpb?=
 =?us-ascii?Q?Q452gvR1wCWRhN8EBRYVwRZPulsVSbRdRmEPEk+V4A2S0ygy3DC7ubgpUFyg?=
 =?us-ascii?Q?IYL9a81HZR1RV+6t6t/3dDtogm0Q0QBp5F2fnlsY21vwx4XzOrGoEwdXcDS3?=
 =?us-ascii?Q?MEmyli24P7/5ICssQIAwY896O8H4p85e6aIu76A2i4mwwbgM58h/05F6PjjB?=
 =?us-ascii?Q?1Et66RzFnVHdUNn/X22xotDPXQa1GgWCsyreuG/Ypc5NNrDCQn/A9ST1A4b0?=
 =?us-ascii?Q?fSLBFACfAIRAV+ddiG5zm+BczPBAJp+bHUNLmTPxRVJM7Zo+N7U/2VGW7r2c?=
 =?us-ascii?Q?l0dNUGQZ8GP/TUGwVdRdzEzdOiIgK5YOurJIOzKgvXnub5O7qMokPnKkW5SR?=
 =?us-ascii?Q?PuEOiCKmylmSxxU5oOaF9kk4FJxqIdN7/HXavc98uAyGl8JIPByQkjw5tdRq?=
 =?us-ascii?Q?mlvPOJniB/UX7A=3D?=
X-Microsoft-Antispam-Message-Info: 4RA/hwrI6UYqfHJBU4JPbh+Q2xzzu8d8CUL/rHOW3+3bNYDaWaQ3WxmwE+uUbJ+w2yj+yliED1jQjhnEsl6tD5/C1yFYP46kaEQP+7StrVLvAMbBeMR0d35uZud6V5wsY3jLEBhcRCFWneFA0BFybhUH1cZfNX8iR4aae4V3VmKPVqG5ER5px7fz69DHPAKh
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB3055;6:ezX1mIIM+EZSwrWMpUZV+M2DG6vRPT6ThjowKExaKDSYDyKuUMpo2LDg9ihIzLfdJzPy/X+D3+YD9Orz50vzqEuIZpt5K4HhLC1UzomdmdrAyNcDdwTBvbS9gj2KDCTjeyceAbiZzrPGUVdSOcss6xGR73TSx8UsxFAhXxuf/v43CtMWN4KQn1KKQxJTduWHwAjuyE8foUVDSlW3KMESTdF+xhwxLFf59bYlv+Pk7JRlPYPnOqQrZSIZBcEQiyykcTCaby9xClqYTkpTfdXgXRYLJSdhov9rECZeT2HZiXtlGx6opdiDfsfnJG8JnXExyW5i5UoeloBtJyBok/bRr5ii3UdToSbomsKUD/TDTc6gY7hJN6B8sBVu+LFPn33sR+I792UqBztSX6nBtErX3j8Zoc7BflUzddRexzcTmR38BwWgxWWBp6evFfpTS3mL1Iei2s24HJWVMuB4etGZUQ==;5:NHr17qil9DHOE5EsSSeegLewAh3oZqXAy7LxNP4HeFDjGgZimbpq+FjcBq/m0Jtdsp3pfFfYdrEaMLC6tulWNNdyOcR+BdU3I1gaMsWtgUGgJFvQUpptVfsVzX0bg6pQZsrA3Ox+dr4APDt/b6qdGwlQv+ARBlFwCVFLqM+Koq4=;24:/ECazWfSY2EuAtjAe4AP7r9DFms8igavz9ArSSYYo5XSX13l5VWyZa/BVZPSxcIAGp3KmP5N6ndhrO5OaKpMN3UvxZOemtnWPtRLRIF+n6g=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB3055;7:VoG05ys/FFIsSIZvTcSgOT2yKa80aGbe8uw1JOst8+IvtLE1U9mMBWdT2MvaVMVxuyGRbOIsqiC2o20526MMytl05ZkaxRbQ046uOKObt109gOBV1sOAyo5Zg4+Vu1FDm4DX32jHpWA6yPgYqPea0ULHXLNFj5u8bQxMKwdvwke7M4OhzrkCqStepb93MzGWr2+fP7McR4EBY7TjWQrmf9jGB5aVIxTcthX29pq7+ewomJFsABDqG6If9YLvV9Aj
X-MS-Office365-Filtering-Correlation-Id: 8f655c62-9887-4020-a5c4-08d59fbe4b31
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2018 15:09:59.5848
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f655c62-9887-4020-a5c4-08d59fbe4b31
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB3055
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596802855517909169?=
X-GMAIL-MSGID: =?utf-8?q?1597462967733310170?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch adds basic support for Analog Devices I2C programmable linear
battery charger.

With this driver, some parameters can be read and configured such as:
* trickle charge current level (PRECHARGE_CURRENT)
* trickle charge voltage threshold (VOLTAGE_MIN)
* weak charge threshold (VOLTAGE_AVG)
* constant current (CONSTANT_CHARGE_CURRENT)
* constant charge voltage limit (CONSTANT_CHARGE_VOLTAGE_MAX)
* battery full (CAPACITY_LEVEL)
* input current limit (INPUT_CURRENT_LIMIT)
* charger status (STATUS)
* battery status (CAPACITY_LEVEL)
* termination current (CHARGE_TERM_CURRENT)

Datasheet:
http://www.analog.com/media/en/technical-documentation/data-sheets/ADP5061.pdf

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
Changes in v2:
	- Fixed typo in Kconfig file: build -> built.
Changes in v3:
	- Described the commit message parameters with bindings to
	  power-supply properties.
 MAINTAINERS                    |   7 +
 drivers/power/supply/Kconfig   |  11 +
 drivers/power/supply/Makefile  |   1 +
 drivers/power/supply/adp5061.c | 745 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 764 insertions(+)
 create mode 100644 drivers/power/supply/adp5061.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 3bdc260..60cd6db 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -797,6 +797,13 @@ L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	drivers/media/i2c/ad9389b*
 
+ANALOG DEVICES INC ADP5061 DRIVER
+M:	Stefan Popa <stefan.popa@analog.com>
+L:	linux-pm@vger.kernel.org
+W:	http://ez.analog.com/community/linux-device-drivers
+S:	Supported
+F:	drivers/power/supply/adp5061.c
+
 ANALOG DEVICES INC ADV7180 DRIVER
 M:	Lars-Peter Clausen <lars@metafoo.de>
 L:	linux-media@vger.kernel.org
diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 428b426..4cc9aa9 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -75,6 +75,17 @@ config BATTERY_88PM860X
 	help
 	  Say Y here to enable battery monitor for Marvell 88PM860x chip.
 
+config CHARGER_ADP5061
+	tristate "ADP5061 battery charger driver"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  Say Y here to enable support for the ADP5061 standalone battery
+	  charger.
+
+	  This driver can be built as a module. If so, the module will be
+	  called adp5061.
+
 config BATTERY_ACT8945A
 	tristate "Active-semi ACT8945A charger driver"
 	depends on MFD_ACT8945A || COMPILE_TEST
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index e83aa84..71b1398 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_WM8350_POWER)	+= wm8350_power.o
 obj-$(CONFIG_TEST_POWER)	+= test_power.o
 
 obj-$(CONFIG_BATTERY_88PM860X)	+= 88pm860x_battery.o
+obj-$(CONFIG_CHARGER_ADP5061)	+= adp5061.o
 obj-$(CONFIG_BATTERY_ACT8945A)	+= act8945a_charger.o
 obj-$(CONFIG_BATTERY_AXP20X)	+= axp20x_battery.o
 obj-$(CONFIG_CHARGER_AXP20X)	+= axp20x_ac_power.o
diff --git a/drivers/power/supply/adp5061.c b/drivers/power/supply/adp5061.c
new file mode 100644
index 0000000..c00a02e
--- /dev/null
+++ b/drivers/power/supply/adp5061.c
@@ -0,0 +1,745 @@
+/*
+ * ADP5061 I2C Programmable Linear Battery Charger
+ *
+ * Copyright 2018 Analog Devices Inc.
+ *
+ * Licensed under the GPL-2.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/delay.h>
+#include <linux/pm.h>
+#include <linux/mod_devicetable.h>
+#include <linux/power_supply.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/regmap.h>
+
+/* ADP5061 registers definition */
+#define ADP5061_ID			0x00
+#define ADP5061_REV			0x01
+#define ADP5061_VINX_SET		0x02
+#define ADP5061_TERM_SET		0x03
+#define ADP5061_CHG_CURR		0x04
+#define ADP5061_VOLTAGE_TH		0x05
+#define ADP5061_TIMER_SET		0x06
+#define ADP5061_FUNC_SET_1		0x07
+#define ADP5061_FUNC_SET_2		0x08
+#define ADP5061_INT_EN			0x09
+#define ADP5061_INT_ACT			0x0A
+#define ADP5061_CHG_STATUS_1		0x0B
+#define ADP5061_CHG_STATUS_2		0x0C
+#define ADP5061_FAULT			0x0D
+#define ADP5061_BATTERY_SHORT		0x10
+#define ADP5061_IEND			0x11
+
+/* ADP5061_VINX_SET */
+#define ADP5061_VINX_SET_ILIM_MSK		GENMASK(3, 0)
+#define ADP5061_VINX_SET_ILIM_MODE(x)		(((x) & 0x0F) << 0)
+
+/* ADP5061_TERM_SET */
+#define ADP5061_TERM_SET_VTRM_MSK		GENMASK(7, 2)
+#define ADP5061_TERM_SET_VTRM_MODE(x)		(((x) & 0x3F) << 2)
+#define ADP5061_TERM_SET_CHG_VLIM_MSK		GENMASK(1, 0)
+#define ADP5061_TERM_SET_CHG_VLIM_MODE(x)	(((x) & 0x03) << 0)
+
+/* ADP5061_CHG_CURR */
+#define ADP5061_CHG_CURR_ICHG_MSK		GENMASK(6, 2)
+#define ADP5061_CHG_CURR_ICHG_MODE(x)		(((x) & 0x1F) << 2)
+#define ADP5061_CHG_CURR_ITRK_DEAD_MSK		GENMASK(1, 0)
+#define ADP5061_CHG_CURR_ITRK_DEAD_MODE(x)	(((x) & 0x03) << 0)
+
+/* ADP5061_VOLTAGE_TH */
+#define ADP5061_VOLTAGE_TH_DIS_RCH_MSK		BIT(7)
+#define ADP5061_VOLTAGE_TH_DIS_RCH_MODE(x)	(((x) & 0x01) << 7)
+#define ADP5061_VOLTAGE_TH_VRCH_MSK		GENMASK(6, 5)
+#define ADP5061_VOLTAGE_TH_VRCH_MODE(x)		(((x) & 0x03) << 5)
+#define ADP5061_VOLTAGE_TH_VTRK_DEAD_MSK	GENMASK(4, 3)
+#define ADP5061_VOLTAGE_TH_VTRK_DEAD_MODE(x)	(((x) & 0x03) << 3)
+#define ADP5061_VOLTAGE_TH_VWEAK_MSK		GENMASK(2, 0)
+#define ADP5061_VOLTAGE_TH_VWEAK_MODE(x)	(((x) & 0x07) << 0)
+
+/* ADP5061_CHG_STATUS_1 */
+#define ADP5061_CHG_STATUS_1_VIN_OV(x)		(((x) >> 7) & 0x1)
+#define ADP5061_CHG_STATUS_1_VIN_OK(x)		(((x) >> 6) & 0x1)
+#define ADP5061_CHG_STATUS_1_VIN_ILIM(x)	(((x) >> 5) & 0x1)
+#define ADP5061_CHG_STATUS_1_THERM_LIM(x)	(((x) >> 4) & 0x1)
+#define ADP5061_CHG_STATUS_1_CHDONE(x)		(((x) >> 3) & 0x1)
+#define ADP5061_CHG_STATUS_1_CHG_STATUS(x)	(((x) >> 0) & 0x7)
+
+/* ADP5061_CHG_STATUS_2 */
+#define ADP5061_CHG_STATUS_2_THR_STATUS(x)	(((x) >> 5) & 0x7)
+#define ADP5061_CHG_STATUS_2_RCH_LIM_INFO(x)	(((x) >> 3) & 0x1)
+#define ADP5061_CHG_STATUS_2_BAT_STATUS(x)	(((x) >> 0) & 0x7)
+
+/* ADP5061_IEND */
+#define ADP5061_IEND_IEND_MSK			GENMASK(7, 5)
+#define ADP5061_IEND_IEND_MODE(x)		(((x) & 0x07) << 5)
+
+#define ADP5061_NO_BATTERY	0x01
+#define ADP5061_ICHG_MAX	1300 // mA
+
+enum adp5061_chg_status {
+	ADP5061_CHG_OFF,
+	ADP5061_CHG_TRICKLE,
+	ADP5061_CHG_FAST_CC,
+	ADP5061_CHG_FAST_CV,
+	ADP5061_CHG_COMPLETE,
+	ADP5061_CHG_LDO_MODE,
+	ADP5061_CHG_TIMER_EXP,
+	ADP5061_CHG_BAT_DET,
+};
+
+static const int adp5061_chg_type[4] = {
+	[ADP5061_CHG_OFF] = POWER_SUPPLY_CHARGE_TYPE_NONE,
+	[ADP5061_CHG_TRICKLE] = POWER_SUPPLY_CHARGE_TYPE_TRICKLE,
+	[ADP5061_CHG_FAST_CC] = POWER_SUPPLY_CHARGE_TYPE_FAST,
+	[ADP5061_CHG_FAST_CV] = POWER_SUPPLY_CHARGE_TYPE_FAST,
+};
+
+static const int adp5061_vweak_th[8] = {
+	2700, 2800, 2900, 3000, 3100, 3200, 3300, 3400,
+};
+
+static const int adp5061_prechg_current[4] = {
+	5, 10, 20, 80,
+};
+
+static const int adp5061_vmin[4] = {
+	2000, 2500, 2600, 2900,
+};
+
+static const int adp5061_const_chg_vmax[4] = {
+	3200, 3400, 3700, 3800,
+};
+
+static const int adp5061_const_ichg[24] = {
+	50, 100, 150, 200, 250, 300, 350, 400, 450, 500, 550, 600, 650,
+	700, 750, 800, 850, 900, 950, 1000, 1050, 1100, 1200, 1300,
+};
+
+static const int adp5061_vmax[36] = {
+	3800, 3820, 3840, 3860, 3880, 3900, 3920, 3940, 3960, 3980,
+	4000, 4020, 4040, 4060, 4080, 4100, 4120, 4140, 4160, 4180,
+	4200, 4220, 4240, 4260, 4280, 4300, 4320, 4340, 4360, 4380,
+	4400, 4420, 4440, 4460, 4480, 4500,
+};
+
+static const int adp5061_in_current_lim[16] = {
+	100, 150, 200, 250, 300, 400, 500, 600, 700,
+	800, 900, 1000, 1200, 1500, 1800, 2100,
+};
+
+static const int adp5061_iend[8] = {
+	12500, 32500, 52500, 72500, 92500, 117500, 142500, 170000,
+};
+
+struct adp5061_state {
+	struct i2c_client		*client;
+	struct regmap			*regmap;
+	struct power_supply		*psy;
+};
+
+static int adp5061_get_array_index(const int *array, u8 size, int val)
+{
+	int i;
+
+	for (i = 1; i < size; i++) {
+		if (val < array[i])
+			break;
+	}
+
+	return i-1;
+}
+
+static int adp5061_get_status(struct adp5061_state *st,
+			      u8 *status1, u8 *status2)
+{
+	u8 buf[2];
+	int ret;
+
+	/* CHG_STATUS1 and CHG_STATUS2 are adjacent regs */
+	ret = regmap_bulk_read(st->regmap, ADP5061_CHG_STATUS_1,
+			       &buf[0], 2);
+	if (ret < 0)
+		return ret;
+
+	*status1 = buf[0];
+	*status2 = buf[1];
+
+	return ret;
+}
+
+static int adp5061_get_input_current_limit(struct adp5061_state *st,
+		union power_supply_propval *val)
+{
+	unsigned int regval;
+	int mode, ret;
+
+	ret = regmap_read(st->regmap, ADP5061_VINX_SET, &regval);
+	if (ret < 0)
+		return ret;
+
+	mode = ADP5061_VINX_SET_ILIM_MODE(regval);
+	val->intval = adp5061_in_current_lim[mode] * 1000;
+
+	return ret;
+}
+
+static int adp5061_set_input_current_limit(struct adp5061_state *st, int val)
+{
+	int index;
+
+	/* Convert from uA to mA */
+	val /= 1000;
+	index = adp5061_get_array_index(adp5061_in_current_lim,
+					ARRAY_SIZE(adp5061_in_current_lim),
+					val);
+	if (index < 0)
+		return index;
+
+	return regmap_update_bits(st->regmap, ADP5061_VINX_SET,
+				  ADP5061_VINX_SET_ILIM_MSK,
+				  ADP5061_VINX_SET_ILIM_MODE(index));
+}
+
+static int adp5061_set_min_voltage(struct adp5061_state *st, int val)
+{
+	int index;
+
+	/* Convert from uV to mV */
+	val /= 1000;
+	index = adp5061_get_array_index(adp5061_vmin,
+					ARRAY_SIZE(adp5061_vmin),
+					val);
+	if (index < 0)
+		return index;
+
+	return regmap_update_bits(st->regmap, ADP5061_VOLTAGE_TH,
+				  ADP5061_VOLTAGE_TH_VTRK_DEAD_MSK,
+				  ADP5061_VOLTAGE_TH_VTRK_DEAD_MODE(index));
+}
+
+static int adp5061_get_min_voltage(struct adp5061_state *st,
+				   union power_supply_propval *val)
+{
+	unsigned int regval;
+	int ret;
+
+	ret = regmap_read(st->regmap, ADP5061_VOLTAGE_TH, &regval);
+	if (ret < 0)
+		return ret;
+
+	regval = ((regval & ADP5061_VOLTAGE_TH_VTRK_DEAD_MSK) >> 3);
+	val->intval = adp5061_vmin[regval] * 1000;
+
+	return ret;
+}
+
+static int adp5061_get_chg_volt_lim(struct adp5061_state *st,
+				    union power_supply_propval *val)
+{
+	unsigned int regval;
+	int mode, ret;
+
+	ret = regmap_read(st->regmap, ADP5061_TERM_SET, &regval);
+	if (ret < 0)
+		return ret;
+
+	mode = ADP5061_TERM_SET_CHG_VLIM_MODE(regval);
+	val->intval = adp5061_const_chg_vmax[mode] * 1000;
+
+	return ret;
+}
+
+static int adp5061_get_max_voltage(struct adp5061_state *st,
+				   union power_supply_propval *val)
+{
+	unsigned int regval;
+	int ret;
+
+	ret = regmap_read(st->regmap, ADP5061_TERM_SET, &regval);
+	if (ret < 0)
+		return ret;
+
+	regval = ((regval & ADP5061_TERM_SET_VTRM_MSK) >> 2) - 0x0F;
+	if (regval > ARRAY_SIZE(adp5061_vmax))
+		regval = ARRAY_SIZE(adp5061_vmax);
+
+	val->intval = adp5061_vmax[regval] * 1000;
+
+	return ret;
+}
+
+static int adp5061_set_max_voltage(struct adp5061_state *st, int val)
+{
+	int vmax_index;
+
+	/* Convert from uV to mV */
+	val /= 1000;
+	if (val > 4500)
+		val = 4500;
+
+	vmax_index = adp5061_get_array_index(adp5061_vmax,
+					     ARRAY_SIZE(adp5061_vmax), val);
+	if (vmax_index < 0)
+		return vmax_index;
+
+	vmax_index += 0x0F;
+
+	return regmap_update_bits(st->regmap, ADP5061_TERM_SET,
+				  ADP5061_TERM_SET_VTRM_MSK,
+				  ADP5061_TERM_SET_VTRM_MODE(vmax_index));
+}
+
+static int adp5061_set_const_chg_vmax(struct adp5061_state *st, int val)
+{
+	int index;
+
+	/* Convert from uV to mV */
+	val /= 1000;
+	index = adp5061_get_array_index(adp5061_const_chg_vmax,
+					ARRAY_SIZE(adp5061_const_chg_vmax),
+					val);
+	if (index < 0)
+		return index;
+
+	return regmap_update_bits(st->regmap, ADP5061_TERM_SET,
+				  ADP5061_TERM_SET_CHG_VLIM_MSK,
+				  ADP5061_TERM_SET_CHG_VLIM_MODE(index));
+}
+
+static int adp5061_set_const_chg_current(struct adp5061_state *st, int val)
+{
+
+	int index;
+
+	/* Convert from uA to mA */
+	val /= 1000;
+	if (val > ADP5061_ICHG_MAX)
+		val = ADP5061_ICHG_MAX;
+
+	index = adp5061_get_array_index(adp5061_const_ichg,
+					ARRAY_SIZE(adp5061_const_ichg),
+					val);
+	if (index < 0)
+		return index;
+
+	return regmap_update_bits(st->regmap, ADP5061_CHG_CURR,
+				  ADP5061_CHG_CURR_ICHG_MSK,
+				  ADP5061_CHG_CURR_ICHG_MODE(index));
+}
+
+static int adp5061_get_const_chg_current(struct adp5061_state *st,
+		union power_supply_propval *val)
+{
+	unsigned int regval;
+	int ret;
+
+	ret = regmap_read(st->regmap, ADP5061_CHG_CURR, &regval);
+	if (ret < 0)
+		return ret;
+
+	regval = ((regval & ADP5061_CHG_CURR_ICHG_MSK) >> 2);
+	if (regval > ARRAY_SIZE(adp5061_const_ichg))
+		regval = ARRAY_SIZE(adp5061_const_ichg);
+
+	val->intval = adp5061_const_ichg[regval] * 1000;
+
+	return ret;
+}
+
+static int adp5061_get_prechg_current(struct adp5061_state *st,
+				      union power_supply_propval *val)
+{
+	unsigned int regval;
+	int ret;
+
+	ret = regmap_read(st->regmap, ADP5061_CHG_CURR, &regval);
+	if (ret < 0)
+		return ret;
+
+	regval &= ADP5061_CHG_CURR_ITRK_DEAD_MSK;
+	val->intval = adp5061_prechg_current[regval] * 1000;
+
+	return ret;
+}
+
+static int adp5061_set_prechg_current(struct adp5061_state *st, int val)
+{
+	int index;
+
+	/* Convert from uA to mA */
+	val /= 1000;
+	index = adp5061_get_array_index(adp5061_prechg_current,
+					ARRAY_SIZE(adp5061_prechg_current),
+					val);
+	if (index < 0)
+		return index;
+
+	return regmap_update_bits(st->regmap, ADP5061_CHG_CURR,
+				  ADP5061_CHG_CURR_ITRK_DEAD_MSK,
+				  ADP5061_CHG_CURR_ITRK_DEAD_MODE(index));
+}
+
+static int adp5061_get_vweak_th(struct adp5061_state *st,
+				union power_supply_propval *val)
+{
+	unsigned int regval;
+	int ret;
+
+	ret = regmap_read(st->regmap, ADP5061_VOLTAGE_TH, &regval);
+	if (ret < 0)
+		return ret;
+
+	regval &= ADP5061_VOLTAGE_TH_VWEAK_MSK;
+	val->intval = adp5061_vweak_th[regval] * 1000;
+
+	return ret;
+}
+
+static int adp5061_set_vweak_th(struct adp5061_state *st, int val)
+{
+	int index;
+
+	/* Convert from uV to mV */
+	val /= 1000;
+	index = adp5061_get_array_index(adp5061_vweak_th,
+					ARRAY_SIZE(adp5061_vweak_th),
+					val);
+	if (index < 0)
+		return index;
+
+	return regmap_update_bits(st->regmap, ADP5061_VOLTAGE_TH,
+				  ADP5061_VOLTAGE_TH_VWEAK_MSK,
+				  ADP5061_VOLTAGE_TH_VWEAK_MODE(index));
+}
+
+static int adp5061_get_chg_type(struct adp5061_state *st,
+				union power_supply_propval *val)
+{
+	u8 status1, status2;
+	int chg_type, ret;
+
+	ret = adp5061_get_status(st, &status1, &status2);
+	if (ret < 0)
+		return ret;
+
+	chg_type = adp5061_chg_type[ADP5061_CHG_STATUS_1_CHG_STATUS(status1)];
+	if (chg_type > ADP5061_CHG_FAST_CV)
+		val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
+	else
+		val->intval = chg_type;
+
+	return ret;
+}
+
+static int adp5061_get_charger_status(struct adp5061_state *st,
+				      union power_supply_propval *val)
+{
+	u8 status1, status2;
+	int ret;
+
+	ret = adp5061_get_status(st, &status1, &status2);
+	if (ret < 0)
+		return ret;
+
+	switch (ADP5061_CHG_STATUS_1_CHG_STATUS(status1)) {
+	case ADP5061_CHG_OFF:
+		val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
+		break;
+	case ADP5061_CHG_TRICKLE:
+	case ADP5061_CHG_FAST_CC:
+	case ADP5061_CHG_FAST_CV:
+		val->intval = POWER_SUPPLY_STATUS_CHARGING;
+		break;
+	case ADP5061_CHG_COMPLETE:
+		val->intval = POWER_SUPPLY_STATUS_FULL;
+		break;
+	case ADP5061_CHG_TIMER_EXP:
+		/* The battery must be discharging if there is a charge fault */
+		val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
+		break;
+	default:
+		val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
+	}
+
+	return ret;
+}
+
+static int adp5061_get_battery_status(struct adp5061_state *st,
+				      union power_supply_propval *val)
+{
+	u8 status1, status2;
+	int ret;
+
+	ret = adp5061_get_status(st, &status1, &status2);
+	if (ret < 0)
+		return ret;
+
+	switch (ADP5061_CHG_STATUS_2_BAT_STATUS(status2)) {
+	case 0x0: /* Battery monitor off */
+	case 0x1: /* No battery */
+		val->intval = POWER_SUPPLY_CAPACITY_LEVEL_UNKNOWN;
+		break;
+	case 0x2: /* VBAT < VTRK */
+		val->intval = POWER_SUPPLY_CAPACITY_LEVEL_CRITICAL;
+		break;
+	case 0x3: /* VTRK < VBAT_SNS < VWEAK */
+		val->intval = POWER_SUPPLY_CAPACITY_LEVEL_LOW;
+		break;
+	case 0x4: /* VBAT_SNS > VWEAK */
+		val->intval = POWER_SUPPLY_CAPACITY_LEVEL_NORMAL;
+		break;
+	}
+
+	return ret;
+}
+
+static int adp5061_get_termination_current(struct adp5061_state *st,
+					   union power_supply_propval *val)
+{
+	unsigned int regval;
+	int ret;
+
+	ret = regmap_read(st->regmap, ADP5061_IEND, &regval);
+	if (ret < 0)
+		return ret;
+
+	regval = (regval & ADP5061_IEND_IEND_MSK) >> 5;
+	val->intval = adp5061_iend[regval];
+
+	return ret;
+}
+
+static int adp5061_set_termination_current(struct adp5061_state *st, int val)
+{
+	int index;
+
+	index = adp5061_get_array_index(adp5061_iend,
+					ARRAY_SIZE(adp5061_iend),
+					val);
+	if (index < 0)
+		return index;
+
+	return regmap_update_bits(st->regmap, ADP5061_IEND,
+				  ADP5061_IEND_IEND_MSK,
+				  ADP5061_IEND_IEND_MODE(index));
+}
+
+static int adp5061_get_property(struct power_supply *psy,
+				enum power_supply_property psp,
+				union power_supply_propval *val)
+{
+	struct adp5061_state *st = power_supply_get_drvdata(psy);
+	u8 status1, status2;
+	int mode, ret;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_PRESENT:
+		ret = adp5061_get_status(st, &status1, &status2);
+		if (ret < 0)
+			return ret;
+
+		mode = ADP5061_CHG_STATUS_2_BAT_STATUS(status2);
+		if (mode == ADP5061_NO_BATTERY)
+			val->intval = 0;
+		else
+			val->intval = 1;
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_TYPE:
+		return adp5061_get_chg_type(st, val);
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		/* This property is used to indicate the input current
+		 * limit into VINx (ILIM)
+		 */
+		return adp5061_get_input_current_limit(st, val);
+	case POWER_SUPPLY_PROP_VOLTAGE_MAX:
+		/* This property is used to indicate the termination
+		 * voltage (VTRM)
+		 */
+		return adp5061_get_max_voltage(st, val);
+	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
+		/*
+		 * This property is used to indicate the trickle to fast
+		 * charge threshold (VTRK_DEAD)
+		 */
+		return adp5061_get_min_voltage(st, val);
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
+		/* This property is used to indicate the charging
+		 * voltage limit (CHG_VLIM)
+		 */
+		return adp5061_get_chg_volt_lim(st, val);
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
+		/*
+		 * This property is used to indicate the value of the constant
+		 * current charge (ICHG)
+		 */
+		return adp5061_get_const_chg_current(st, val);
+	case POWER_SUPPLY_PROP_PRECHARGE_CURRENT:
+		/*
+		 * This property is used to indicate the value of the trickle
+		 * and weak charge currents (ITRK_DEAD)
+		 */
+		return adp5061_get_prechg_current(st, val);
+	case POWER_SUPPLY_PROP_VOLTAGE_AVG:
+		/*
+		 * This property is used to set the VWEAK threshold
+		 * bellow this value, weak charge mode is entered
+		 * above this value, fast chargerge mode is entered
+		 */
+		return adp5061_get_vweak_th(st, val);
+	case POWER_SUPPLY_PROP_STATUS:
+		/*
+		 * Indicate the charger status in relation to power
+		 * supply status property
+		 */
+		return adp5061_get_charger_status(st, val);
+	case POWER_SUPPLY_PROP_CAPACITY_LEVEL:
+		/*
+		 * Indicate the battery status in relation to power
+		 * supply capacity level property
+		 */
+		return adp5061_get_battery_status(st, val);
+	case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
+		/* Indicate the values of the termination current */
+		return adp5061_get_termination_current(st, val);
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int adp5061_set_property(struct power_supply *psy,
+				enum power_supply_property psp,
+				const union power_supply_propval *val)
+{
+	struct adp5061_state *st = power_supply_get_drvdata(psy);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		return adp5061_set_input_current_limit(st, val->intval);
+	case POWER_SUPPLY_PROP_VOLTAGE_MAX:
+		return adp5061_set_max_voltage(st, val->intval);
+	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
+		return adp5061_set_min_voltage(st, val->intval);
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
+		return adp5061_set_const_chg_vmax(st, val->intval);
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
+		return adp5061_set_const_chg_current(st, val->intval);
+	case POWER_SUPPLY_PROP_PRECHARGE_CURRENT:
+		return adp5061_set_prechg_current(st, val->intval);
+	case POWER_SUPPLY_PROP_VOLTAGE_AVG:
+		return adp5061_set_vweak_th(st, val->intval);
+	case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
+		return adp5061_set_termination_current(st, val->intval);
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int adp5061_prop_writeable(struct power_supply *psy,
+				  enum power_supply_property psp)
+{
+	switch (psp) {
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+	case POWER_SUPPLY_PROP_VOLTAGE_MAX:
+	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
+	case POWER_SUPPLY_PROP_PRECHARGE_CURRENT:
+	case POWER_SUPPLY_PROP_VOLTAGE_AVG:
+	case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
+		return 1;
+	default:
+		return 0;
+	}
+}
+
+static enum power_supply_property adp5061_props[] = {
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_CHARGE_TYPE,
+	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
+	POWER_SUPPLY_PROP_VOLTAGE_MAX,
+	POWER_SUPPLY_PROP_VOLTAGE_MIN,
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX,
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT,
+	POWER_SUPPLY_PROP_PRECHARGE_CURRENT,
+	POWER_SUPPLY_PROP_VOLTAGE_AVG,
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_CAPACITY_LEVEL,
+	POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT,
+};
+
+static const struct regmap_config adp5061_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+};
+
+static const struct power_supply_desc adp5061_desc = {
+	.name			= "adp5061",
+	.type			= POWER_SUPPLY_TYPE_USB,
+	.get_property		= adp5061_get_property,
+	.set_property		= adp5061_set_property,
+	.property_is_writeable	= adp5061_prop_writeable,
+	.properties		= adp5061_props,
+	.num_properties		= ARRAY_SIZE(adp5061_props),
+};
+
+static int adp5061_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id)
+{
+	struct power_supply_config psy_cfg = {};
+	struct adp5061_state *st;
+
+	st = devm_kzalloc(&client->dev, sizeof(*st), GFP_KERNEL);
+	if (!st)
+		return -ENOMEM;
+
+	st->client = client;
+	st->regmap = devm_regmap_init_i2c(client,
+					  &adp5061_regmap_config);
+	if (IS_ERR(st->regmap)) {
+		dev_err(&client->dev, "Failed to initialize register map\n");
+		return -EINVAL;
+	}
+
+	i2c_set_clientdata(client, st);
+	psy_cfg.drv_data = st;
+
+	st->psy = devm_power_supply_register(&client->dev,
+					     &adp5061_desc,
+					     &psy_cfg);
+
+	if (IS_ERR(st->psy)) {
+		dev_err(&client->dev, "Failed to register power supply\n");
+		return PTR_ERR(st->psy);
+	}
+
+	return 0;
+}
+
+static const struct i2c_device_id adp5061_id[] = {
+	{ "adp5061", 0},
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, adp5061_id);
+
+static struct i2c_driver adp5061_driver = {
+	.driver = {
+		.name = KBUILD_MODNAME,
+	},
+	.probe = adp5061_probe,
+	.id_table = adp5061_id,
+};
+module_i2c_driver(adp5061_driver);
+
+MODULE_DESCRIPTION("Analog Devices adp5061 battery charger driver");
+MODULE_AUTHOR("Stefan Popa <stefan.popa@analog.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4
