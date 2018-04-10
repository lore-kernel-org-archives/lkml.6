Return-Path: <StefanSerban.Popa@analog.com>
X-Google-Smtp-Source: AIpwx49JZ9pV6fVI0qZScOlp/PUxDGt0DfCfZn+W1QDVtPGjoxCCJuB0haQa3g/ll4dPmd+QRm7N
ARC-Seal: i=1; a=rsa-sha256; t=1523375915; cv=none;
        d=google.com; s=arc-20160816;
        b=TTCbAnXHeikvYoigJvGjqXJWId3tMAvhD55YxLbSqHgtzBXIPUdwBg6JwaBl+uyjTm
         ukw3tUr/IRFaN7tzfMjaUfH/JfyZyln7TlPfPPo5N32HRbumlCX3Y1YFuFVwId7hU94w
         bIRea9JfDgNRp+oXlcvdEHqDz5vHDXYTaUm0WgnLTXY9H7X8u9qLg4mJ6npAgIQxH+gY
         lfhOfkL8BtSwZVzgh7p6mdjsEpKXbJK5dKfztKgGegCYKnqAxyvIrGVAUxM78cWmg7Wj
         yE6pvn8JMGy9WDCcFGnDxLzJu5aV++d4LMJe7Ymd/aZu3FDHc5B+R1pKrOz2ibO7pR3t
         2cjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=vaagQjecPK/YcBWQmMvSpG0Uuv3SsCAggv9LkQcw50Y=;
        b=GPrvuIYiJW2BnCeGL0/j4Kr4xFJyrrYDfSye1gSWn3VkHZA75BBFlHVt74ywMHrAla
         F58Tmzb2Z+2pxS9afVJF5ljyJk0LvLFv6pp1/u7+LFPYz6KRcb8+wZ6E4KhRXk2iWXVh
         rtdM9UitXo6cy4TmKMjC1TwTYhkY/6EaTaESVGMwZ42t2cgknywBzfTCXh84BsDNaLVQ
         4hp9EawK4eD0myvPYmAdSvFZnMb1BGE4Zn9pkokw7KvAFbP1pVxAZufla2GcMoQivvoH
         hZVExdghCWlGcmtKnBH+2qflvcyQI8O5IXVcQM/ul5kPODGM1lAtqsbScxkR/QL1ycgX
         Lcow==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@analog.onmicrosoft.com header.s=selector1-analog-com header.b=WYeTLgpE;
       spf=pass (google.com: domain of stefanserban.popa@analog.com designates 104.47.33.73 as permitted sender) smtp.mailfrom=StefanSerban.Popa@analog.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@analog.onmicrosoft.com header.s=selector1-analog-com header.b=WYeTLgpE;
       spf=pass (google.com: domain of stefanserban.popa@analog.com designates 104.47.33.73 as permitted sender) smtp.mailfrom=StefanSerban.Popa@analog.com
From: Stefan Popa <stefan.popa@analog.com>
To: <jic23@kernel.org>, <Michael.Hennerich@analog.com>, <lars@metafoo.de>
CC: <knaack.h@gmx.de>, <pmeerw@pmeerw.net>, <davem@davemloft.net>,
	<mchehab@kernel.org>, <gregkh@linuxfoundation.org>,
	<linus.walleij@linaro.org>, <akpm@linux-foundation.org>,
	<rdunlap@infradead.org>, <Ismail.Kose@maximintegrated.com>,
	<lukas@wunner.de>, <fabrice.gasnier@st.com>, <mike.looijmans@topic.nl>,
	<pombredanne@nexb.com>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stefan.popa@analog.com>
Subject: [PATCH v2 5/6] iio:dac:ad5686: Refactor the driver
Date: Tue, 10 Apr 2018 18:58:19 +0300
Message-ID: <1523375899-29722-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522418209-11927-1-git-send-email-stefan.popa@analog.com>
References: <1522418209-11927-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(396003)(39380400002)(376002)(2980300002)(438002)(199004)(189003)(426003)(5660300001)(8936002)(246002)(305945005)(6666003)(7416002)(7636002)(186003)(54906003)(6346003)(50226002)(110136005)(316002)(8676002)(77096007)(26005)(2201001)(16586007)(356003)(966005)(36756003)(47776003)(2906002)(106002)(76176011)(50466002)(59450400001)(6306002)(48376002)(7696005)(478600001)(8666007)(51416003)(336012)(2616005)(126002)(11346002)(476003)(446003)(486006)(106466001)(1720100001)(107886003)(72206003)(4326008)(309714004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB3050;H:nwd2mta4.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11FD010;1:OlNF1d4l20yEsZi8tvmc1rgf/aC4JRym3PSSJB2kYe8kZWJsYoaT3uMEGc9yreG92EFVSD1tusAJplhTUdYE9mu0QypkCi1IXUj3eE42bO9/hg7wrR4h2PW8+QliNYBz
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:DM5PR03MB3050;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3050;3:1WTjcK6ZduM84CjZB1e6ma2n4r8Hr4fJ3qP83kQQ3dleYipRLz29ykHNv19/m7zMG6PEVfXRslkEuktBy0FU5eEqUcq23brt+H0GxvzJA6tGXTvbu4CwftAZwboTp9aLlYPgg3ocC/gpYBayt8ffhavGKgLlgfs/hamxzpAtpI9S9YMim33U/2fcMfxRDXrnHHPr5Mubgdm1mdk/GR+n3LCG2DNTDC4xKsBeDkhGNe2dHmD3LXuX4U8Y6jmmZpqji7YGx+eWUpaaqRPwewXoAwMACG26yyXWGIUbfHEVA4/ILlh8xvw0m+x+tHfv4i0De+HGWYiVGneiEkOcmLCsjti36zLpT0aBTRv0zT7b1sM=;25:R+BL6SWIFw0yvzEZnlc5uIZ4y1gk1tgQHRdov0W6A524VVtw49dkLks5ZcqDF1A9H0fZvQqZnx8cQKywTCTEMdf7/oJmMd2Zee3DlTE4F6zGFFcvOxXDhnVYlTRYGRN9A75ljWSfnvKmTIevG1sAJ+/Sq36HWXUIOui6na2Gr2zqH1wBHVxSJ2E+JO6r1vTkPkzgoNE2IA4B90JMY3BgTEq+QkErewyGdKJvy3pfQqrW9fzGSloWdZVg7ZdPZsA0A+DcjCNP/ACLG5ze+BKe557vjVsQuC7MKuuWKDHfauHgVOdwQ4HDcwgTs2a6WtOpuCYYJzjlgUuocj2f5CchGw==
X-MS-TrafficTypeDiagnostic: DM5PR03MB3050:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3050;31:r7L6c3ISVsYvX7SRrvMUseRTHREgCD0JHmKc68to8ZCyMw+LU8K2+r8pRRh2m6pdJuOtqF7eE4En1ChNzR9Z9FIpLuVV2TVsTcySNBhSF/bBF0iU12Ys7zvxnH25zkINZFeCC1bE09YaYIL9+wfhnA4pQ98kZAYs69/pt3xHUVTZey2jzboO8atT3z8tk/egXRvklGHLFtsNA+D0NGaZa6I5EuBXLIz80B//+Wu1Gkk=;20:aPxSF6ojqRPQAnVYhZ81DzdYNIBP4Ub43o7H69JolTLkQtLHedtuYxvzk0DyXjDJ2dnwgrjpwAN2Jf6aUi1Zkk7sihim0LWA08AiHea1Py2kAVYepB/YUu0Hlanvp71AxjL94wX+KYrZ3OL9IDP4AZusB2YjP0OnmWI9LKaA3aNJKHYh4ZgbD2L/YONFPGnmOkGhL+Bj+07J61+gUCzQjtoA67h9AC92STVtqRGyfcIdphg9Sc0BqGNtkRTxDquq2/gfX3alctgOcaEH8XxKPRQn6vTKLswRfIOiuacbzp+8Thq2nYgXoKcIhjN/I3cH/djEXmxr1FOHd770FH42shBXxzZP5zPRdG2fY/FDeQqj4a3ctZr9bFrPWrqU/dSvIRF+aRtRXAsZrCxk/d4YaeJ7dmdt7BRggwukuyka75tp7W6uDHyuOPl5VqK0Mx/H7JdYPTy+7wGjj3FUsOUnGRpdEpc4Z2pKkaorN+rsTvcqwqM/sJmoVsXQ2B04yduK
X-Microsoft-Antispam-PRVS: <DM5PR03MB3050BAD1B4D98E42C734DA449DBE0@DM5PR03MB3050.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(232431446821674)(95692535739014)(170811661138872);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR03MB3050;BCL:0;PCL:0;RULEID:;SRVR:DM5PR03MB3050;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3050;4:DCyRku9wvpSc73pHAxdjvkpQ9ngpwmFUDWhhELA1ZUOX/MxOi46X1KaT1oLUqxImEi8YxLFNTxpX/r70EtY5l6g5gwj/J4zibqpy71mXenpaNq6/eJ5qvih4YXUBySC93gsimu5jn5gxro4sm35b/zSxw95pMvqJ9CBNrXC1PR6rchdXsYseguilBv8do/uklrF6JeY1Ozo48X89w044hgrVx/F78gzQY2k1XfbkOccvwFIEeAVB50t9TIILKd7UY+SlyZ63qEFZBoypq3QUATn5pnPAt5Zu8iGRmpa3fPhaze/tdE3sh3bemMglEG+DnzYaGCkq2hc7bkm9GAY+vxCTmDANUo/ZKaTeVwCcStvyFNsoRx+6yLQG9xxT5Xx+ES7asyI8B/88AeGH7MjuF4NQuGOjQpoqWn/z1EWg7is=
X-Forefront-PRVS: 0638FD5066
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR03MB3050;23:ro+eSfYzB7R0PR3Te9ucyvkIbLNRGjdTIqN6ybc0Y?=
 =?us-ascii?Q?QPQ/d2jfCBwnwglqdtZ9CtYManW8bMkNa3LUL284vKflwmGwS5YKI2vacflq?=
 =?us-ascii?Q?Xq438pvDEjocTD2Bo4p6Xxp8y6dqHvezaabeQyCdk7FLz7Rhprg/+hu+PmbG?=
 =?us-ascii?Q?VnprPvblcXG//1htX529sKRLH2CYU+Qj11WvF+ikURqSKZ0/5Fo7vkx5vYTC?=
 =?us-ascii?Q?9yWanHojDkyE2A8GQocaxyrDUTvNbwCpsmugTMXZPa3f6zgDZP88snav/Ifj?=
 =?us-ascii?Q?d+BnZGgnWXFATlH2ZLBc6DEsSV0gzdgnfIrudX0VGD2MutGIhrBwOxjVCrsO?=
 =?us-ascii?Q?JndcnoRHsBMSVd6ZjVZi6ISzgNf4mFZwSGr9DeI575+RUiGyWvM1yc0/zL85?=
 =?us-ascii?Q?Mk2WLp4drBRnrIKCd/g/2ztthfVhwjiJzDtfhpKyonCiXD1fhG15qpPVPJI+?=
 =?us-ascii?Q?ep7ppnQHrLhamMEFyusfzfzX4+CeuiVrWBJqxkMENXCyXtOeLKBOMiPDj/Q7?=
 =?us-ascii?Q?gQ6gR4g9n4ZSo2YMnVymVi4cAVS+ywQfzpiAzpEBKxnI2nxHzuxfzZ1DjpXb?=
 =?us-ascii?Q?MWUx0A4hE4hS84x6Dds6XulMVoLPzMwCCRKIxlu/K6igdFxqs2GDfz7D7mUt?=
 =?us-ascii?Q?m3yKsSQlShFksnKeWdHau8LPzNXMEgnjnh06tU94XAED+MEKFhrrgC2MV2iZ?=
 =?us-ascii?Q?/kxI73q5gwvWDJqO64vYggGXGCHWpVpBBPR+Tn30gya3Ga08rkxytVM09aI/?=
 =?us-ascii?Q?A+ekkVuwGGQG5Mi0T3fRlamvijjagZbV8YaqXnQgULTr572zgQ+6XUJpg0Bh?=
 =?us-ascii?Q?PFr79Yzz0pyjClS5IOgz/IOEr4/V70k8PybjLnxIpV5V6X5iFPUjX3IpoOMb?=
 =?us-ascii?Q?QKVCqeNzt7y5+eTuXC1c+K/SCXS1Q16lAvxBa2qoDsROq9LFgQ7slhEQ3bub?=
 =?us-ascii?Q?XUA+M+KT9/xKmhsNC+lYoWW1VZeQr18ID8Ka574RQu6NXPLWtE+GyOTP8DuW?=
 =?us-ascii?Q?MwGL2YHsArCScbKEGwGTwum2gNTMI87cW/V1hPauxg8yJCxH6Rg5WCMTcQ4P?=
 =?us-ascii?Q?v26CNCtHSVtgiHbNTVDN0oaibLOaJCcyVNP1bf+Q5gu121Tm9XsRYcxLjxC6?=
 =?us-ascii?Q?VWCOYg1vqMce1rDqoGFVODLK/1+5xvCvirQPnTKACx6RvYvUJUDxeQ+JnqfT?=
 =?us-ascii?Q?wXBn4RdRCqRydZHy73Hv+GsrQmU5MelJfObuNuvyJPTFKZTK3xDk6fsFA=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: H+SOuqhw6ncbvkmeg0/BmIJVvaxqoyToGsXwyuB3Ac38rXG+fPAFLw10P5QaSclEB7QsgZMj2SRWuVOmVPG47vBRX8LnBIULW4dWoslcA5ECUWKHDoN4IpWl5zlmp7irVdZeGhqwCSGb8bNfvJoo0AkLOVmIo58IReJRFwCBh/w50Aw9OlmdA8S2ovZ560D4
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3050;6:SSe7vwIIa5zWT0LrBkbxDnSvT+r01Vyl7lZq2Jpi5qacXsBtAlhzhG6i6Q/LTloYFukNnm5I/Erenr7jCshXZ8laI1VWR2wvhYHKpd5hZtm0otggykhZ/G2MdS1jO8oUWExTHKy2WiSQvX8bgCP2t6qpOyx6lOo52yPeR1ZGQzLguJyMK/Cqh7alZhomo5QUJNA6g7jrLYeS7WMlgZwSKkvSDDsHnDzrm16SIfiEmKsXts/LiaFw8bH+Ij8UoWdW/3pCFD1fgE40i8TSrLMDgvnRtGJAHCGltojpgHKUFDv8I0XcmgXmvh1p4vamS/pdRkS5aP9bQRzIM2iCNebWPhppyuZ5ARePiTYGDiTOAjXQiCZqgCEV4ZZ2QwPvUUMc3TaVFNyLp1BWUQNJ8Q04eZnIpflL3qD2NfR2w49DA853yqAbFzaBPDTZsuDJoZJ4JTFRowEdB2DWBR28S3+VLw==;5:0xW/V5W6fMq+ATjH3db0jl5Cl8O1FYBIZcj9x7yXgZ4P/q+6LJwFHLpGkL1x6pkNgyWxvdVD5CCNFbeS0i6DAVFW+BIPGY3eXVeKO0TUJMXxUjRJCwIv4LKhLGa9LIVsehgHx+dO1EGl/mvf52BAaDW98hV57e1KxnyRj/T5wxY=;24:jdBm5SEZsUC3L1ucunMQHHUgkEHT4bQdRNdvoDuxFcc0U/DpzQdpwVz4V7EZETydzmgM8cVr24dsQDlCvSPFpzh6HmrZjRb6bblmLJrJSIc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3050;7:Ay85ciK7Ct2iY7KvEFdCsn/D7LInF+sWNLMhZvUNReYd2SIs86LssvJQ7G/FWC376WQmaPa+kTi76Mm/lfQmNgWb8ZCfHzq8e9RONlkjdhfqjBLziVhuH4pHZC8Z99z5uafDiD3pwpZfJwo4QDqX+lPbZk32SSr/GS0k7pYyVgQ+3iXZZ53RVujqla4VMQ5k4XHiUlHAf+f8x6T0HYw3RiuhSJOrXOyHaLBJkILJVPSJpzLJLcjf3QPZ3c5gSjuE
X-MS-Office365-Filtering-Correlation-Id: fad10988-8fa6-41ae-cc7d-08d59efbe8a2
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2018 15:58:31.7416
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fad10988-8fa6-41ae-cc7d-08d59efbe8a2
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB3050
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597375423931635728?=
X-GMAIL-MSGID: =?utf-8?q?1597375423931635728?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In this patch restructures the existing ad5686 driver by adding a module
for SPI and a header file, while the baseline module deals with the
chip-logic.

This is a necessary step, as this driver should support in the future
similar devices which differ only in the type of interface used (I2C
instead of SPI).

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
Changes in v2:
	- Refactored the patch
	- Use st->write directly instead of the ad5686_write() wrapper
	- Use st->read directly instead of the ad5686_read() wrapper

 MAINTAINERS                  |   7 ++
 drivers/iio/dac/Kconfig      |  17 ++--
 drivers/iio/dac/Makefile     |   1 +
 drivers/iio/dac/ad5686-spi.c |  93 +++++++++++++++++++++
 drivers/iio/dac/ad5686.c     | 190 +++++++------------------------------------
 drivers/iio/dac/ad5686.h     | 107 ++++++++++++++++++++++++
 6 files changed, 248 insertions(+), 167 deletions(-)
 create mode 100644 drivers/iio/dac/ad5686-spi.c
 create mode 100644 drivers/iio/dac/ad5686.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 473ac00..637e62d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -791,6 +791,13 @@ M:	Michael Hanselmann <linux-kernel@hansmi.ch>
 S:	Supported
 F:	drivers/macintosh/ams/
 
+ANALOG DEVICES INC AD5686 DRIVER
+M:	Stefan Popa <stefan.popa@analog.com>
+L:	linux-pm@vger.kernel.org
+W:	http://ez.analog.com/community/linux-device-drivers
+S:	Supported
+F:	drivers/iio/dac/ad5686*
+
 ANALOG DEVICES INC AD9389B DRIVER
 M:	Hans Verkuil <hans.verkuil@cisco.com>
 L:	linux-media@vger.kernel.org
diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index 965d5c0..a00fc45 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -131,15 +131,20 @@ config LTC2632
 	  module will be called ltc2632.
 
 config AD5686
-	tristate "Analog Devices AD5686R/AD5685R/AD5684R DAC SPI driver"
+	tristate
+
+config AD5686_SPI
+	tristate "Analog Devices AD5686 and similar multi-channel DACs (SPI)"
 	depends on SPI
+	select AD5686
 	help
-	  Say yes here to build support for Analog Devices AD5686R, AD5685R,
-	  AD5684R, AD5791 Voltage Output Digital to
-	  Analog Converter.
+	Say yes here to build support for Analog Devices AD5672R, AD5676,
+	AD5676R, AD5684, AD5684R, AD5684R, AD5685R, AD5686, AD5686R.
+	Voltage Output Digital to Analog Converter.
+
+	To compile this driver as a module, choose M here: the
+	module will be called ad5686.
 
-	  To compile this driver as a module, choose M here: the
-	  module will be called ad5686.
 
 config AD5755
 	tristate "Analog Devices AD5755/AD5755-1/AD5757/AD5735/AD5737 DAC driver"
diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
index 81e710e..07db92e 100644
--- a/drivers/iio/dac/Makefile
+++ b/drivers/iio/dac/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_AD5761) += ad5761.o
 obj-$(CONFIG_AD5764) += ad5764.o
 obj-$(CONFIG_AD5791) += ad5791.o
 obj-$(CONFIG_AD5686) += ad5686.o
+obj-$(CONFIG_AD5686_SPI) += ad5686-spi.o
 obj-$(CONFIG_AD7303) += ad7303.o
 obj-$(CONFIG_AD8801) += ad8801.o
 obj-$(CONFIG_CIO_DAC) += cio-dac.o
diff --git a/drivers/iio/dac/ad5686-spi.c b/drivers/iio/dac/ad5686-spi.c
new file mode 100644
index 0000000..d68579b
--- /dev/null
+++ b/drivers/iio/dac/ad5686-spi.c
@@ -0,0 +1,93 @@
+/*
+ * AD5672R, AD5676, AD5676R, AD5684, AD5684R, AD5684R, AD5685R, AD5686, AD5686R
+ * Digital to analog converters driver
+ *
+ * Copyright 2018 Analog Devices Inc.
+ *
+ * Licensed under the GPL-2.
+ */
+
+#include "ad5686.h"
+
+#include <linux/module.h>
+#include <linux/spi/spi.h>
+
+static int ad5686_spi_write(struct ad5686_state *st,
+			    u8 cmd, u8 addr, u16 val)
+{
+	struct spi_device *spi = to_spi_device(st->dev);
+
+	st->data[0].d32 = cpu_to_be32(AD5686_CMD(cmd) |
+				      AD5686_ADDR(addr) |
+				      val);
+
+	return spi_write(spi, &st->data[0].d8[1], 3);
+}
+
+static int ad5686_spi_read(struct ad5686_state *st, u8 addr)
+{
+	struct spi_transfer t[] = {
+		{
+			.tx_buf = &st->data[0].d8[1],
+			.len = 3,
+			.cs_change = 1,
+		}, {
+			.tx_buf = &st->data[1].d8[1],
+			.rx_buf = &st->data[2].d8[1],
+			.len = 3,
+		},
+	};
+	struct spi_device *spi = to_spi_device(st->dev);
+	int ret;
+
+	st->data[0].d32 = cpu_to_be32(AD5686_CMD(AD5686_CMD_READBACK_ENABLE) |
+				      AD5686_ADDR(addr));
+	st->data[1].d32 = cpu_to_be32(AD5686_CMD(AD5686_CMD_NOOP));
+
+	ret = spi_sync_transfer(spi, t, ARRAY_SIZE(t));
+	if (ret < 0)
+		return ret;
+
+	return be32_to_cpu(st->data[2].d32);
+}
+
+static int ad5686_spi_probe(struct spi_device *spi)
+{
+	const struct spi_device_id *id = spi_get_device_id(spi);
+
+	return ad5686_probe(&spi->dev, id->driver_data, id->name,
+			    ad5686_spi_write, ad5686_spi_read);
+}
+
+static int ad5686_spi_remove(struct spi_device *spi)
+{
+	return ad5686_remove(&spi->dev);
+}
+
+static const struct spi_device_id ad5686_spi_id[] = {
+	{"ad5672r", ID_AD5672R},
+	{"ad5676", ID_AD5676},
+	{"ad5676r", ID_AD5676R},
+	{"ad5684", ID_AD5684},
+	{"ad5684r", ID_AD5684R},
+	{"ad5685r", ID_AD5685R},
+	{"ad5686", ID_AD5686},
+	{"ad5686r", ID_AD5686R},
+	{}
+};
+MODULE_DEVICE_TABLE(spi, ad5686_spi_id);
+
+static struct spi_driver ad5686_spi_driver = {
+	.driver = {
+		.name = "ad5686",
+	},
+	.probe = ad5686_spi_probe,
+	.remove = ad5686_spi_remove,
+	.id_table = ad5686_spi_id,
+};
+
+module_spi_driver(ad5686_spi_driver);
+
+MODULE_AUTHOR("Stefan Popa <stefan.popa@analog.com>");
+MODULE_DESCRIPTION("Analog Devices AD5686 and similar multi-channel DACs");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index 5fb0179..95de8b8 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -11,7 +11,6 @@
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
-#include <linux/spi/spi.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
 #include <linux/regulator/consumer.h>
@@ -19,121 +18,7 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 
-#define AD5686_ADDR(x)				((x) << 16)
-#define AD5686_CMD(x)				((x) << 20)
-
-#define AD5686_ADDR_DAC(chan)			(0x1 << (chan))
-#define AD5686_ADDR_ALL_DAC			0xF
-
-#define AD5686_CMD_NOOP				0x0
-#define AD5686_CMD_WRITE_INPUT_N		0x1
-#define AD5686_CMD_UPDATE_DAC_N			0x2
-#define AD5686_CMD_WRITE_INPUT_N_UPDATE_N	0x3
-#define AD5686_CMD_POWERDOWN_DAC		0x4
-#define AD5686_CMD_LDAC_MASK			0x5
-#define AD5686_CMD_RESET			0x6
-#define AD5686_CMD_INTERNAL_REFER_SETUP		0x7
-#define AD5686_CMD_DAISY_CHAIN_ENABLE		0x8
-#define AD5686_CMD_READBACK_ENABLE		0x9
-
-#define AD5686_LDAC_PWRDN_NONE			0x0
-#define AD5686_LDAC_PWRDN_1K			0x1
-#define AD5686_LDAC_PWRDN_100K			0x2
-#define AD5686_LDAC_PWRDN_3STATE		0x3
-
-/**
- * struct ad5686_chip_info - chip specific information
- * @int_vref_mv:	AD5620/40/60: the internal reference voltage
- * @num_channels:	number of channels
- * @channel:		channel specification
-*/
-
-struct ad5686_chip_info {
-	u16				int_vref_mv;
-	unsigned int			num_channels;
-	struct iio_chan_spec		*channels;
-};
-
-/**
- * struct ad5446_state - driver instance specific data
- * @spi:		spi_device
- * @chip_info:		chip model specific constants, available modes etc
- * @reg:		supply regulator
- * @vref_mv:		actual reference voltage used
- * @pwr_down_mask:	power down mask
- * @pwr_down_mode:	current power down mode
- * @data:		spi transfer buffers
- */
-
-struct ad5686_state {
-	struct spi_device		*spi;
-	const struct ad5686_chip_info	*chip_info;
-	struct regulator		*reg;
-	unsigned short			vref_mv;
-	unsigned			pwr_down_mask;
-	unsigned			pwr_down_mode;
-	/*
-	 * DMA (thus cache coherency maintenance) requires the
-	 * transfer buffers to live in their own cache lines.
-	 */
-
-	union {
-		__be32 d32;
-		u8 d8[4];
-	} data[3] ____cacheline_aligned;
-};
-
-/**
- * ad5686_supported_device_ids:
- */
-
-enum ad5686_supported_device_ids {
-	ID_AD5672R,
-	ID_AD5676,
-	ID_AD5676R,
-	ID_AD5684,
-	ID_AD5684R,
-	ID_AD5685R,
-	ID_AD5686,
-	ID_AD5686R
-};
-static int ad5686_spi_write(struct ad5686_state *st,
-			     u8 cmd, u8 addr, u16 val, u8 shift)
-{
-	val <<= shift;
-
-	st->data[0].d32 = cpu_to_be32(AD5686_CMD(cmd) |
-			      AD5686_ADDR(addr) |
-			      val);
-
-	return spi_write(st->spi, &st->data[0].d8[1], 3);
-}
-
-static int ad5686_spi_read(struct ad5686_state *st, u8 addr)
-{
-	struct spi_transfer t[] = {
-		{
-			.tx_buf = &st->data[0].d8[1],
-			.len = 3,
-			.cs_change = 1,
-		}, {
-			.tx_buf = &st->data[1].d8[1],
-			.rx_buf = &st->data[2].d8[1],
-			.len = 3,
-		},
-	};
-	int ret;
-
-	st->data[0].d32 = cpu_to_be32(AD5686_CMD(AD5686_CMD_READBACK_ENABLE) |
-			      AD5686_ADDR(addr));
-	st->data[1].d32 = cpu_to_be32(AD5686_CMD(AD5686_CMD_NOOP));
-
-	ret = spi_sync_transfer(st->spi, t, ARRAY_SIZE(t));
-	if (ret < 0)
-		return ret;
-
-	return be32_to_cpu(st->data[2].d32);
-}
+#include "ad5686.h"
 
 static const char * const ad5686_powerdown_modes[] = {
 	"1kohm_to_gnd",
@@ -196,8 +81,9 @@ static ssize_t ad5686_write_dac_powerdown(struct iio_dev *indio_dev,
 	else
 		st->pwr_down_mask &= ~(0x3 << (chan->channel * 2));
 
-	ret = ad5686_spi_write(st, AD5686_CMD_POWERDOWN_DAC, 0,
-			       st->pwr_down_mask & st->pwr_down_mode, 0);
+	ret = st->write(st, AD5686_CMD_POWERDOWN_DAC, 0,
+			st->pwr_down_mask & st->pwr_down_mode);
+
 
 	return ret ? ret : len;
 }
@@ -214,7 +100,7 @@ static int ad5686_read_raw(struct iio_dev *indio_dev,
 	switch (m) {
 	case IIO_CHAN_INFO_RAW:
 		mutex_lock(&indio_dev->mlock);
-		ret = ad5686_spi_read(st, chan->address);
+		ret = st->read(st, chan->address);
 		mutex_unlock(&indio_dev->mlock);
 		if (ret < 0)
 			return ret;
@@ -243,11 +129,10 @@ static int ad5686_write_raw(struct iio_dev *indio_dev,
 			return -EINVAL;
 
 		mutex_lock(&indio_dev->mlock);
-		ret = ad5686_spi_write(st,
-				 AD5686_CMD_WRITE_INPUT_N_UPDATE_N,
-				 chan->address,
-				 val,
-				 chan->scan_type.shift);
+		ret = st->write(st,
+				AD5686_CMD_WRITE_INPUT_N_UPDATE_N,
+				chan->address,
+				val << chan->scan_type.shift);
 		mutex_unlock(&indio_dev->mlock);
 		break;
 	default:
@@ -357,20 +242,27 @@ static const struct ad5686_chip_info ad5686_chip_info_tbl[] = {
 	},
 };
 
-static int ad5686_probe(struct spi_device *spi)
+int ad5686_probe(struct device *dev,
+		 enum ad5686_supported_device_ids chip_type,
+		 const char *name, ad5686_write_func write,
+		 ad5686_read_func read)
 {
 	struct ad5686_state *st;
 	struct iio_dev *indio_dev;
 	int ret, voltage_uv = 0;
 
-	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
 	if (indio_dev == NULL)
 		return  -ENOMEM;
 
 	st = iio_priv(indio_dev);
-	spi_set_drvdata(spi, indio_dev);
+	dev_set_drvdata(dev, indio_dev);
+
+	st->dev = dev;
+	st->write = write;
+	st->read = read;
 
-	st->reg = devm_regulator_get_optional(&spi->dev, "vcc");
+	st->reg = devm_regulator_get_optional(dev, "vcc");
 	if (!IS_ERR(st->reg)) {
 		ret = regulator_enable(st->reg);
 		if (ret)
@@ -383,28 +275,25 @@ static int ad5686_probe(struct spi_device *spi)
 		voltage_uv = ret;
 	}
 
-	st->chip_info =
-		&ad5686_chip_info_tbl[spi_get_device_id(spi)->driver_data];
+	st->chip_info = &ad5686_chip_info_tbl[chip_type];
 
 	if (voltage_uv)
 		st->vref_mv = voltage_uv / 1000;
 	else
 		st->vref_mv = st->chip_info->int_vref_mv;
 
-	st->spi = spi;
-
 	/* Set all the power down mode for all channels to 1K pulldown */
 	st->pwr_down_mode = 0x55;
 
-	indio_dev->dev.parent = &spi->dev;
-	indio_dev->name = spi_get_device_id(spi)->name;
+	indio_dev->dev.parent = dev;
+	indio_dev->name = name;
 	indio_dev->info = &ad5686_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = st->chip_info->channels;
 	indio_dev->num_channels = st->chip_info->num_channels;
 
-	ret = ad5686_spi_write(st, AD5686_CMD_INTERNAL_REFER_SETUP, 0,
-				!!voltage_uv, 0);
+	ret = st->write(st, AD5686_CMD_INTERNAL_REFER_SETUP,
+			0, !!voltage_uv);
 	if (ret)
 		goto error_disable_reg;
 
@@ -419,10 +308,11 @@ static int ad5686_probe(struct spi_device *spi)
 		regulator_disable(st->reg);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(ad5686_probe);
 
-static int ad5686_remove(struct spi_device *spi)
+int ad5686_remove(struct device *dev)
 {
-	struct iio_dev *indio_dev = spi_get_drvdata(spi);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct ad5686_state *st = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
@@ -431,29 +321,7 @@ static int ad5686_remove(struct spi_device *spi)
 
 	return 0;
 }
-
-static const struct spi_device_id ad5686_id[] = {
-	{"ad5672r", ID_AD5672R},
-	{"ad5676", ID_AD5676},
-	{"ad5676r", ID_AD5676R},
-	{"ad5684", ID_AD5684},
-	{"ad5684r", ID_AD5684R},
-	{"ad5685r", ID_AD5685R},
-	{"ad5686", ID_AD5686},
-	{"ad5686r", ID_AD5686R},
-	{}
-};
-MODULE_DEVICE_TABLE(spi, ad5686_id);
-
-static struct spi_driver ad5686_driver = {
-	.driver = {
-		   .name = "ad5686",
-		   },
-	.probe = ad5686_probe,
-	.remove = ad5686_remove,
-	.id_table = ad5686_id,
-};
-module_spi_driver(ad5686_driver);
+EXPORT_SYMBOL_GPL(ad5686_remove);
 
 MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
 MODULE_DESCRIPTION("Analog Devices AD5686/85/84 DAC");
diff --git a/drivers/iio/dac/ad5686.h b/drivers/iio/dac/ad5686.h
new file mode 100644
index 0000000..e6423af
--- /dev/null
+++ b/drivers/iio/dac/ad5686.h
@@ -0,0 +1,107 @@
+#ifndef __DRIVERS_IIO_DAC_AD5686_H__
+#define __DRIVERS_IIO_DAC_AD5686_H__
+
+#include <linux/types.h>
+#include <linux/cache.h>
+#include <linux/mutex.h>
+#include <linux/kernel.h>
+
+#define AD5686_ADDR(x)				((x) << 16)
+#define AD5686_CMD(x)				((x) << 20)
+
+#define AD5686_ADDR_DAC(chan)			(0x1 << (chan))
+#define AD5686_ADDR_ALL_DAC			0xF
+
+#define AD5686_CMD_NOOP				0x0
+#define AD5686_CMD_WRITE_INPUT_N		0x1
+#define AD5686_CMD_UPDATE_DAC_N			0x2
+#define AD5686_CMD_WRITE_INPUT_N_UPDATE_N	0x3
+#define AD5686_CMD_POWERDOWN_DAC		0x4
+#define AD5686_CMD_LDAC_MASK			0x5
+#define AD5686_CMD_RESET			0x6
+#define AD5686_CMD_INTERNAL_REFER_SETUP		0x7
+#define AD5686_CMD_DAISY_CHAIN_ENABLE		0x8
+#define AD5686_CMD_READBACK_ENABLE		0x9
+
+#define AD5686_LDAC_PWRDN_NONE			0x0
+#define AD5686_LDAC_PWRDN_1K			0x1
+#define AD5686_LDAC_PWRDN_100K			0x2
+#define AD5686_LDAC_PWRDN_3STATE		0x3
+
+/**
+ * ad5686_supported_device_ids:
+ */
+enum ad5686_supported_device_ids {
+	ID_AD5672R,
+	ID_AD5676,
+	ID_AD5676R,
+	ID_AD5684,
+	ID_AD5684R,
+	ID_AD5685R,
+	ID_AD5686,
+	ID_AD5686R,
+};
+
+struct ad5686_state;
+
+typedef int (*ad5686_write_func)(struct ad5686_state *st,
+				 u8 cmd, u8 addr, u16 val);
+
+typedef int (*ad5686_read_func)(struct ad5686_state *st, u8 addr);
+
+/**
+ * struct ad5686_chip_info - chip specific information
+ * @int_vref_mv:	AD5620/40/60: the internal reference voltage
+ * @num_channels:	number of channels
+ * @channel:		channel specification
+ */
+
+struct ad5686_chip_info {
+	u16				int_vref_mv;
+	unsigned int			num_channels;
+	struct iio_chan_spec		*channels;
+};
+
+/**
+ * struct ad5446_state - driver instance specific data
+ * @spi:		spi_device
+ * @chip_info:		chip model specific constants, available modes etc
+ * @reg:		supply regulator
+ * @vref_mv:		actual reference voltage used
+ * @pwr_down_mask:	power down mask
+ * @pwr_down_mode:	current power down mode
+ * @data:		spi transfer buffers
+ */
+
+struct ad5686_state {
+	struct device			*dev;
+	const struct ad5686_chip_info	*chip_info;
+	struct regulator		*reg;
+	unsigned short			vref_mv;
+	unsigned int			pwr_down_mask;
+	unsigned int			pwr_down_mode;
+	ad5686_write_func		write;
+	ad5686_read_func		read;
+
+	/*
+	 * DMA (thus cache coherency maintenance) requires the
+	 * transfer buffers to live in their own cache lines.
+	 */
+
+	union {
+		__be32 d32;
+		__be16 d16;
+		u8 d8[4];
+	} data[3] ____cacheline_aligned;
+};
+
+
+int ad5686_probe(struct device *dev,
+		 enum ad5686_supported_device_ids chip_type,
+		 const char *name, ad5686_write_func write,
+		 ad5686_read_func read);
+
+int ad5686_remove(struct device *dev);
+
+
+#endif /* __DRIVERS_IIO_DAC_AD5686_H__ */
-- 
2.7.4
