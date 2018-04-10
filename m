Return-Path: <StefanSerban.Popa@analog.com>
X-Google-Smtp-Source: AIpwx4/QhlH/aYQ7HKGkm4Jzvr7Pqv7hfBVYzCxho8q3K7xjswyWaS51E4q14cnkI1kglVO2Lopk
ARC-Seal: i=1; a=rsa-sha256; t=1523353864; cv=none;
        d=google.com; s=arc-20160816;
        b=wUH3qYQyK0C8f7N4wjMOvlEpygWyR5KAA29wMr2//a5AMhK1zTJrm1B+Bit/VOXA6z
         IpNZgjBaFIcnHOA8wCuHgnzwYCV/O2/pbJkDne8E7NJQ/OhALssyjz6fN+dse2m/RKkk
         DWIb/QbqHXVwAkMI65pwRK5y+zXs9L1Iks/IudGJCr+U6NfTNOxvgnGn+y28G16UF1Im
         KiALugYWZ2tYLiQoCububVM5xVr44uhDwlohfsGNtJb8yujOV7a+bTaD8q6TYW/ST/27
         X46biDBQ+lxcaScVWRFhn5RvK5YCfV1+xIfBZQjbd/ZTlFoXai6i5iMuGnduyvN1kAQu
         jt8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=XIbnGDcoIiHEFhSnHvNu1jj35jNYb3vHaNub+pU9Bas=;
        b=BAvyMg9uiQACiuKpzHcjvQvuJBQNfliYJZl/qT6DMZjgfJr0gvHwGzBCDV2zV4h1t+
         29y6avzgFqrK7BNl7fLTdvqu95yeALhK7CZ2zdrgt3tOnkpU6KCdmmGeE3HqKDNOhQF4
         3LfUn+nF1E1m1HNiqVk4raDPx28wFX3fL/zbJqJLpmvtEjZPQC1fz2JkkCMVMTTZgf7A
         /hQjUfqRE075jJSBjv3dcj4JTWaUg8GBxTJVcKLSPXO1+ObpiqTgyAl9rcXiQAD5yrKP
         5m7L4HOWJhgcqrj/uDr03ov7RYJzUik4CElyv5iBHezu0vMmucXkS7Q6/TGDcGSe2l+J
         6e9g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@analog.onmicrosoft.com header.s=selector1-analog-com header.b=mOZoxgbK;
       spf=pass (google.com: domain of stefanserban.popa@analog.com designates 104.47.42.83 as permitted sender) smtp.mailfrom=StefanSerban.Popa@analog.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@analog.onmicrosoft.com header.s=selector1-analog-com header.b=mOZoxgbK;
       spf=pass (google.com: domain of stefanserban.popa@analog.com designates 104.47.42.83 as permitted sender) smtp.mailfrom=StefanSerban.Popa@analog.com
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=bestguesspass action=none
 header.from=analog.com;
From: Stefan Popa <stefan.popa@analog.com>
To: <sre@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC: <davem@davemloft.net>, <mchehab@kernel.org>, <gregkh@linuxfoundation.org>,
	<linus.walleij@linaro.org>, <akpm@linux-foundation.org>,
	<rdunlap@infradead.org>, <linux-pm@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stefan.popa@analog.com>
Subject: [PATCH v2 1/3] adp5061: New driver for ADP5061 I2C battery charger
Date: Tue, 10 Apr 2018 12:49:58 +0300
Message-ID: <1523353798-23522-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522829832-7866-1-git-send-email-stefan.popa@analog.com>
References: <1522829832-7866-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(39380400002)(39860400002)(376002)(2980300002)(438002)(189003)(199004)(54906003)(8676002)(26005)(110136005)(106466001)(186003)(50226002)(6306002)(36756003)(16586007)(72206003)(77096007)(2906002)(8936002)(305945005)(59450400001)(7636002)(7416002)(316002)(478600001)(76176011)(51416003)(5660300001)(486006)(7696005)(4326008)(107886003)(336012)(575784001)(126002)(50466002)(106002)(426003)(11346002)(48376002)(356003)(246002)(446003)(47776003)(2616005)(476003)(966005)(1720100001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB2492;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11FD021;1:gmIp2+B33CY/j3SansF1eUSYOnlXO8hxHqYBG99oRpF+f66h/Rbas0GkqlnUnZVlavsjDElODoUcJ/HAj+CxGDqh1SQoLZ5gRBzJWceVN73kZ3jcRRKQJurukDK+JVFO
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:DM5PR03MB2492;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2492;3:qmyzMIZAP9cx6JAvB0/Jy4S7aOdujxx9u+y0PjCcUeFqiLLGVEyp0WXrZ2hih87L1SxHUpaN/dUV/FnsgHA9IzBVYcRIdeU5kyUrvC/rAY6zGABHJdvwPoV4IbzPP3ndqVnGLtpABdVmIjr2fB6w1NGRWpEGwhNzKBngMcnEl1EB0T7TdJbr0mmXCrlUP74iQNlX6KY0mFIGEp0sqQqocWEWN1oQ+LX+egXYIOZS3gdUE8ufqL6BIxbwIeoPC7K2ZM0d/istT7cNix+kwLVO8qDn2RkElKJQ7U1tH/EDL/4XnSvwQvwKF0+fltFUBJf+kRZTyL6yNFrT5iD5p5Ijy2cyX4hWsZlCeHIvk9oTb+g=;25:2JZeZpw4ZGo9lkpeEpd2qIntFZRivOR3c5pn2+LBcpCWuReyMPYVxlfte1PFsJkMfLvA7wxxZcHLVTA9xN6jtrD9m7jzz+cAcaOBaAg7prCdg7Ae/zu1LlLwbZexyI6DCzji3XwHuHYqIur5niADnXKYw7vwdbr+kj+SCeVEO8fH4d5CDjPFZSaycYYa5DMZDNDQV0102X3C7rz6bOX2H+MzmBSuozykXjP4fQY/j8a6BgvIbjsw3wxNrldJuBM/C3/StGzbx/yUubTWK7ScrQKbWGO2v6qcIVJ5WBxNbdL+qSZoexYxY2pcdHBLsBLCRcNM6siE9H/nlNJPZrpFpQ==
X-MS-TrafficTypeDiagnostic: DM5PR03MB2492:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2492;31:scPEqy8mUmnvmQtoFkNGl43PJZx9D3cDG4nN7SnhjK2vWbwpaxZtdWm40FbEjyqqvQ6iUw4K5XmeU5UWDkbccR5n4JBv3M9hwD6sQVUOaFZpe2J1SviVBsTELdjfcTDqteglzsxL78WNAQkh9jKivGi9yMqDYt+MBAKUJBj/n1Isq/J0F4BEwbT3MbmXADo7ZZQL778Dbfw1GMziFQ2f8DIQfEhfIJoFWvIajCEctKM=;20:o5pbivhRrYPxg7gp1sdV2T/6CiB3BVLZUFVxnP3Q5KWPFAv1/p7+MnEzDTI1wbAspxCA/U3z/DRQ2SVuWnjrHIyPQWnbS7HAUsRFlzuHDyEyP9Ye9n5xH0SdUIrSbL1e8PxOV4irX9VAewqqj5SSlBk0d+ph2+qD2YBXKHJFgVjPJmU4vV2bqddNCmrcjyQuKY4XUIeHlG6+hiNH3GZe9zK4wNpphwmX4myTR3U/23m+imSKLpxPsTxd8jH7xhKmAAIDWRchNAP83iJR1d0SKM7vU6I4EsuVzvSH0llQUJQLBFh7ctBaJ1wl03J0n3L3HrYzphTOJi8r2xuFgEtahl7oCnW+9iNMzseAiIUf77xcPdgN/iKLjMQw5d9UkyRHnwNsxgd9zmEIdkx0/mB7/KTfJhLKCJVFmp1+4hg+gLnsPfEMjtQXiu3UPlOZivDwXk+W3AMb34bvXcv8pqjX8iUMDgV1uv8NCtB1lHJugLvjg/QWBV1MftnNT3yaEq72
X-Microsoft-Antispam-PRVS: <DM5PR03MB2492C99FD73651FF1F32E5059DBE0@DM5PR03MB2492.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(270121546159015)(9452136761055)(232431446821674)(170811661138872);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93004095)(3231221)(944501327)(52105095)(6055026)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR03MB2492;BCL:0;PCL:0;RULEID:;SRVR:DM5PR03MB2492;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2492;4:tIbSeJs6ws6aylLiqCYMbR5Na6e6u/MGSLwl+m01dbo9BrWzMoU83lHEVSO4pVVvc5aXVcJ8oN46m2llDpbo27B1AcBVdpsO3Ejy6uUNFcBsdEGpxOnzfVRMsT5qACAkSpG9fCr1XZn44T38kjqFmIYWdBd6rwzEdzzb1GmqcrBTP78zZCXi5xDfR7p1le49Qnf65XePJ9JiAifBrYJbmc4sJhaCxw1bg1khIzf8dN+ibDgB0BXWCagy/kMimdNK7tNNDWsg1UOuW4/MtMdZbjSbhgyvGAlLwHTxmQ31bNfZzkenVNk/PLMjeIkkQRLlwpO5DPKz6F+uMJh6gzVb5qv1lOFcNv3xWAqMffXoJcu492LUE7U7C/N541btPjI7gN9fFIGmyruRR0wTYAjezbLw3CAS+V1D6DN0++x+Tc0=
X-Forefront-PRVS: 0638FD5066
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR03MB2492;23:TirFIcUM574LcSC5FAU+5q2p12S6SVfAG4y+oTQ1y?=
 =?us-ascii?Q?E/vsgCIH/SP900nznjXCE6HZtoMySLsbzFOD5iDFILlThssr4JQuoCH0juNQ?=
 =?us-ascii?Q?HdDJO1tufVXEMh5KQ7seIL71JLajioWqT6JrPSILARpPzx4rRxlNzHTgNGJp?=
 =?us-ascii?Q?bWXVHi31OoaQpOY8xDOfe2iUMMY8dpptzBbcKu66JDiZu1wj7Unv/XDbkpDs?=
 =?us-ascii?Q?rEE2pHVm+tYwAzVsPE2FzWxeod9JEjqsk8rXYN+3Y40Si/4FWPslTUFiT6h3?=
 =?us-ascii?Q?24NQsxMUjfaoqEUiH78vObfkIeqUW3FztusG4FgUrf6//jmeGxGKlmnTT6GD?=
 =?us-ascii?Q?QivaDc1otB3LMg1PSwBDMzAIXKnLg2Oj0TYnAqjAShS+ag6M/hYnTW+Rbgkh?=
 =?us-ascii?Q?ZzDeKbXIY/yhkwn8HECbTm1TUfd118HhFkCYml+fpBqJxe9OXadYjNuHb0ar?=
 =?us-ascii?Q?HnE3sPSw0VvJnlHPP4H+A+h89DzLJnbJaXEwH5iOXTKraXXh5BE0d3vpzhal?=
 =?us-ascii?Q?c6TPbEhTQw2pN9AgCGCZJkQR7C+sIat91+YV1+RkEDEpiVqUalG5SgAwty9F?=
 =?us-ascii?Q?j9CqxVw+836UQl58IZvK/wgpbwJYRUr755KOk+NIUn0E/Y7BWwfoaznG9QRA?=
 =?us-ascii?Q?62n/ei9jOOJ7IAJERTMELiASp9DbeTnd9o7iOB/q0OBnEZYDDwi+0igjPrvL?=
 =?us-ascii?Q?BHYMSVPlq9huPpzFKeBU+YR3BP1FDPoA/RXK3pX/0xEV8NWhRkif9lFHMgZn?=
 =?us-ascii?Q?m04iQNTe6k/yPg8bZIfxor2w7A8cIC0QeG8AwIZHr+rHHpaz2hEJzL2U55sL?=
 =?us-ascii?Q?KKfjBP8kQXxTKQrvZrR9wIolwSiCXuxHEExJKGnKZNsISXBGtv+/UZLRFCS2?=
 =?us-ascii?Q?FavsWUDOUc4AxsQOUDVaVxUzNYIaTwu9Y0nuaFffDeCBr3yEOK5rYydisYsK?=
 =?us-ascii?Q?QPa4lH1GdI9t0F6NzudVmsJ7XGTObx30UNzBz6FmXne5rqEgG1CRR1+2SZOb?=
 =?us-ascii?Q?8YOs1GdQCjuq2HixDKhIQ+ZoidUTrQcNFyvFEpny5oFDNCTqFsAZ3sdTCwmR?=
 =?us-ascii?Q?SWpzTj1vcjCcwCshc9SL2ABHHEZaYJ25A+HekNuLxHnfj+thsqKQ3A2fmxJN?=
 =?us-ascii?Q?plUWl1cHjc72FiqC4g/GEDmZDrrw5bBSRMxS7cVM/fa1/jxNHJKnQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: 0oliGX0o0ouqJ9/wYXBtq6XeeNIpLa5TWnrkfbNyXi24ICnerDi423r7SQYKRhfSEL6R3QdMKXccT0KyLdjbQyNH2MHyteTKIXK1h1Gwn3ygqate73dC+cagUbvME7t/etp1m+SP4HF0JbZd6brwB2eqlYRZG14TzkpQeYNgPKzUDz4u2Ka/xx3Fl+m7idwr
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2492;6:2mKWATzP7X+bBUHtpxwo3su6qGPj56aG/HAvSrrF84CYhGtul4WUSmwwwsa+Xe/1seFjeNyaBSxZEmKS6U4/ZoHNLo3XdfxqcIBDNXBdb/Eix2G6c7tSAygjsYkVJYNaASvI9ZH1FlSD8XXPfvJTssg0hhrhFTl7wqoBLbH6w63Ce45XIv19+bmEzI5GRUG+5/2L/ikm57z4vS6deDQrWdhBo8QpbBxoSwxPNtj72PEhaAeTvwOC79tH9KZsgj8sPJvSkO20VZtg+HJKHzAf3IB5v0v9NhLkHjFepDx0JohOaX08B76oQjAGPXEFax1yxgkbIQt23EYQsqVGNnoQiS5fFHebjROeue6BCncl9i5CRIDabLeJaXM2Ifv5m3ofEZ3PoRYMcA1Kb+cjrzxA7B89pmiBpCITt2lSAd3RmA3ha71FiOXDbvBh9TiRlks8wDdxh36uk0krJGYt7z4o8Q==;5:tPirAEbedFhkc2rqVSc01jlBnj2J5oecnfU5HhTmEmkcfsCrPBByOQnmephk4TQAI08jr9TyqMm6IbOEl3Qn2hXH/5+NCPTAmaV5TDAFpgcRNhdUAVco0+ye2edGmqpbHoSkpIW4wPyokXo35HhMZa2/ufX3tN/co1J56Lmoa1w=;24:8vFbRwdSzkjqct9hAMNhXLwvL1xoyeuXeMRUhi7TLCGbA1geiV0LFgUX7DBLQI5BAf14y5KlbVF2TY7RS37D2WNkoD2Frh396qkWI64fjHo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2492;7:Bju/VAQ/j5ktHmDky8b7SgTazOkmPpSKr+iPycehk7WjZXsFhm6E98x93pAE+yoEJKqv1KwPru8LFPanKxZWsJ0JliWDDvzXxMkgLrySUo2UapAxAmNqnPR+uD0v9eCWyhYolgaVnPE/hTSU8YWR2u6RKPp8B7D4Evtrsjnsy/NgES0xgYtZvGlU86ojxPjPQIS+GuOqlLleSQYmKiBCn4+gsWERJ9tQlGakQ+GSiEaudZN0OhpSSbxo+iweSDm1
X-MS-Office365-Filtering-Correlation-Id: 32bb436a-d683-4a97-8e14-08d59ec89151
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2018 09:51:00.8518
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32bb436a-d683-4a97-8e14-08d59ec89151
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB2492
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596802855517909169?=
X-GMAIL-MSGID: =?utf-8?q?1597352302381163031?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch adds basic support for Analog Devices I2C programmable linear
battery charger.

With this driver, some parameters can be read and configured such as:
* trickle charge current level
* trickle charge voltage threshold
* weak charge threshold
* constant current
* constant charge voltage limit
* battery full
* input current limit
* charger status
* battery status
* termination current

Datasheet:
http://www.analog.com/media/en/technical-documentation/data-sheets/ADP5061.pdf

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
Changes in v2:
  - Fixed typo in Kconfig file: build -> built

 .../devicetree/bindings/power/supply/adp5061.txt   |  17 +
 MAINTAINERS                                        |   8 +
 drivers/power/supply/Kconfig                       |  11 +
 drivers/power/supply/Makefile                      |   1 +
 drivers/power/supply/adp5061.c                     | 745 +++++++++++++++++++++
 5 files changed, 782 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/adp5061.txt
 create mode 100644 drivers/power/supply/adp5061.c

diff --git a/Documentation/devicetree/bindings/power/supply/adp5061.txt b/Documentation/devicetree/bindings/power/supply/adp5061.txt
new file mode 100644
index 0000000..7447446
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/adp5061.txt
@@ -0,0 +1,17 @@
+Analog Devices ADP5061 Programmable Linear Battery Charger Driver
+
+Required properties:
+  - compatible:		should be "adi,adp5061"
+  - reg:		i2c address of the device
+
+The node for this driver must be a child node of a I2C controller, hence
+all mandatory properties described in
+Documentation/devicetree/bindings/i2c/i2c.txt
+must be specified.
+
+Example:
+
+	adp5061@14 {
+		    compatible = "adi,adp5061";
+		    reg = <0x14>;
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 3bdc260..a9ca73b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -797,6 +797,14 @@ L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	drivers/media/i2c/ad9389b*
 
+ANALOG DEVICES INC ADP5061 DRIVER
+M:	Stefan Popa <stefan.popa@analog.com>
+L:	linux-pm@vger.kernel.org
+W:	http://ez.analog.com/community/linux-device-drivers
+S:	Supported
+F:	Documentation/devicetree/bindings/power/supply/adp5061.txt
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
