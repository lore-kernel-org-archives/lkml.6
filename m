Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id PxrZGBV/GVupcwAAmS7hNA
	; Thu, 07 Jun 2018 18:53:11 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 76D9B6074D; Thu,  7 Jun 2018 18:53:11 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LhyOpM5O"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id DA39A60590;
	Thu,  7 Jun 2018 18:53:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DA39A60590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932582AbeFGSxI (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 14:53:08 -0400
Received: from mail-he1eur01on0066.outbound.protection.outlook.com ([104.47.0.66]:51488
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753066AbeFGSxG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 14:53:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A6FdB6RxjdP+gjBPRlaMTboTY2K7Ui0VnnSkevYb5jI=;
 b=LhyOpM5OAmnaWN5axOV5DMRX9UG2ZthgIyRkRe68/eyT1Zeu+N7kDLYVhgtDmfCO/H3ymLl3sVNjyykrYJZ2tA0H7iMQTysLKKZDl14KjtU24sxVIUYuW1nlavX6XmyCGD480Sr70xEFmzf3O/QpKsXrERjBq3mGo1pmmuXFD5s=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com;
Received: from localhost.localdomain (95.76.156.53) by
 AM0PR04MB4291.eurprd04.prod.outlook.com (2603:10a6:208:67::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.15; Thu, 7 Jun 2018 18:53:02 +0000
From: Leonard Crestez <leonard.crestez@nxp.com>
To: Harinath Nampally <harinath922@gmail.com>,
        Martin Kepplinger <martink@posteo.de>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: mma8452: Fix ignoring MMA8452_INT_DRDY
Date: Thu,  7 Jun 2018 21:52:50 +0300
Message-Id: <d3cdb3fef8434663c95b7b2f799c5ee4446a5231.1528397238.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: AM6P193CA0015.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:3e::28) To AM0PR04MB4291.eurprd04.prod.outlook.com
 (2603:10a6:208:67::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4291;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4291;3:0MzTg52x3bU4xObk9VDJNdkKr0BRWsX9shi1n59ygshq0lyq7nCoMV6SDNjRBBM5MZoQUBQnuoYe5TD+nAG1Zh0jw/hiA6G0m9F0zZldyVCm3QkR0+RZrastTPGjg9VSkU9JoBPbntbFY1ZkJLJwyXOCHtmBMPUZVF3+Bh2EGrBo34nALoT6Jpke8gRi5xdDFodiNRTuxQCJMoF44jc7VtPqyffijvlHFHE00DjGSQWTA97/MwnQBwa4YhZHLejN;25:2gHqwjQzM8hKPncp8e/AZ9wwWmAFPRrrBLZFy09LIN3sM/XvTnRSd2rcf8OAb7rBL1T2N4IjBesFaFF85N8tKOzA/dP+A+QIguPpNVihLR7RschIG84V5ZPlY4UFaQf5nCyF1IA652Icf4FJ6+ICesEN/6xVywzi6H6xd9VLNYt03mEGvS3ZYIFVC7soDeNB47yrfKsmQAZhCz0BP0FkgNXz3OZaAMfuN7HoqfSi7yhuwCZKRUv+Sz8TwTqLgj6UssrtIjM15WOS9j7wzYg3olx/LM5BsUXWxpFsDlCNckfCL5ShtonI7DhmUpTY1Hk0ZjHmFxZ4ZdpoeoUH/O3O1Q==;31:aSCQC853/mggoUzz9VJV8DO/3oS2vSODkTpEr+YUqLv15mX5VST5OqwzHYn3lyF4eNeXBInwo677CT3k9gu6qyJXSB+/aNJmD8H1Y01HG8W0vZRPnOqSwONnMEVjS5dmrqsx6cw0qtjAXrUGxh09aX5nNN3hyDWGzh3hd+pqkxKSEC+xaoKqnMSZZEYQ/AaT/aXoMfHNmtzYZ3kJv5j0WaIayQMfJcJ52C3PLhdrwmc=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4291:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4291;20:SatXA1Q6dqe7K3GNt6NqG1HHkt85EmiZGXLw2eC3RTHqX3aEQ6tcLBbGI30eNnlr+Ka+00gNsBsaTKniPzwFJOfTXwsRE4+Dy+KN0Uv2NywBPD9F77F4hYloaD92BOLtH8KTHguream8jipj602WY2XbTpZJgxWCgw69TBazF+LsZnhp2anE0gj0oy6vI9vDs9WUptAdjq6B52we5xN0nmjqZQ2nviD+m92xDpMppzy7mFBdtdYypaWKjc4IQdmp6Y+PAevLxydR3O1vpCpWid1+QDORy/TGUxguGk7cLP9OV2qo7BJm2GEaUHNp03k2EO+ZI7Iorv9qG4et8j1msSlVQqZ+Ivx3VmdGwJ5/i7jrubFiULxY4F8ougjcZmY/3Ai6fOtGKuGtsDZmwtj2wsrmKfByo+xwqKH4CRJaCh4yGPqnoYleuBcnbg7lbYa8WgXMzlMfqG6IK8lyyLJgEOFPF+3M82V3YD1opPJ7G0LQtmz1CrtF7MbSWHLkwr7T;4:UUrMbqrJ33VsInDtV/ydd4Bgt0Y+mpLMFwESaX2Ty33EtuWXhyZ9Kia7OE6oZr+hWHoVnIPTvNA2ZpdALVg/vDdQoqhyKTj0Xk9OScJR6yP/LEjA1wpEL/hhOcc7LxPlDVavweWrzSJX7Ke9s1N9rpiy6AT6OkaGH4PJ06/pZVaxy64S2H0tMi4NhWqIJ7C705Og9Mxttl66lNm4Z3ytoi3Z6J30x72qlSyXUFRuQI9Da/hU2/E5gUW/t0ETuT9EtSie8jBQ5YjXzhGDDDLPdxTC/GtcdATrEqSDMAeXHO2PTCqIhI/ST+mUaINsTtnz
X-Microsoft-Antispam-PRVS: <AM0PR04MB42911FD96726B94FADC67742EE640@AM0PR04MB4291.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB4291;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4291;
X-Forefront-PRVS: 06968FD8C4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(376002)(346002)(39860400002)(366004)(39380400002)(396003)(199004)(189003)(106356001)(1857600001)(476003)(2616005)(956004)(36756003)(486006)(25786009)(86362001)(97736004)(47776003)(59450400001)(53936002)(386003)(6506007)(16526019)(186003)(6486002)(26005)(8666007)(44832011)(6512007)(305945005)(51416003)(39060400002)(4326008)(7736002)(478600001)(52116002)(110136005)(16586007)(6666003)(50466002)(68736007)(316002)(6116002)(3846002)(48376002)(54906003)(2906002)(118296001)(66066001)(105586002)(8676002)(15760500003)(50226002)(8936002)(81166006)(5660300001)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4291;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR04MB4291;23:w0S/FtFU5l+XgYsYDHI7tYO+F/7R7C0T6xspmXkjV?=
 =?us-ascii?Q?K6T72cRcncxxN3B/WoEQlPAlvgp22tg+vNKoMB0cMJiDXVim2iCk2w1zgSZ1?=
 =?us-ascii?Q?lvzdH0UEBNTxT2Bf9Lz3N+5FvLBXIr+mTbOIt1cuFmF+IDRcWsTRSSDGfn21?=
 =?us-ascii?Q?FPwNGbH8QvPYc0tL8kmg0y/uI67ku50BrHiQQFp9j2swwf2qEpxejTc9xHh5?=
 =?us-ascii?Q?HuE1U1gSyK5Uldm396clgFlCoYWm5AwoTMluQzz9d+IsVDU89FfGx6XNnQNv?=
 =?us-ascii?Q?p1uzfwrp9Aje0mzXt3fnIV/A+UQZ31E0yQmaF1WriyJSKmP7ZqIxVtofLqsX?=
 =?us-ascii?Q?xclJQbaDUAj7D8i2SRYAOdZg5VaNKWQe3tvH57sYyx6RP0ulFOfoCeFpjT/W?=
 =?us-ascii?Q?Qrp6pDxmcuBGfQ1epSE4WfrMZeFAK8d/45VDBgnDNWNCSqnshfIIveYOrdMo?=
 =?us-ascii?Q?qrODxChow5xgEXntEdMntZYWUy96ZWFAtYVzIDagkkw/duskBSzKdcybnzcC?=
 =?us-ascii?Q?OLJoBDgfAObrF2MsuAKy3iLCjsAu293f3MoL9FAsoHALbtatE2W5nGn79jgp?=
 =?us-ascii?Q?PJQi5GiBIfxWO+Ei1qcvPtickVzaC3LzC+WiwT3z2+6DNe3M+sleohXLgXj+?=
 =?us-ascii?Q?qoERz3WBWDSkpMXIF5tuau6fk0FQ00KeATRw5eigWUuVZ0BPocFaDIt+ijiu?=
 =?us-ascii?Q?Bk4bcJi8eyDxC1xbFrbi/UoErOXcrv7UMWRwjNmAVFKOIr2VIrk3YHX0VTFo?=
 =?us-ascii?Q?sE7ns2q251xLmki9vumkmV2y8dM/9SCaQyqz8pl04r7LaBRzHozDr5W1bxN4?=
 =?us-ascii?Q?RJZCSgKaVGox/5IX9CYxKO85kNDPuridmWuqYdMEhLkaKRuEBbv1GDybiOyi?=
 =?us-ascii?Q?JQ6b77AQC+odhSuNR8wDLRQMEZpvio71YySaUavq/RAcRE5L3XOzC5v+ZDPZ?=
 =?us-ascii?Q?8vCtnefR9fWbqlfo3p44HXLSTjERyAbGfaU+ivxQB056xnSrBBzasVH2S+AP?=
 =?us-ascii?Q?zqgyCVz28n4gBxBV/GvmbtNCVm6AI6jou9uY5RXxy1CC1vpz93bXXbrooa0/?=
 =?us-ascii?Q?5p/lYW9+KbaED+pBkmgtqv9/vYjkANfmutHsQKfsZQ7kAg/dzAln1pbs7P7r?=
 =?us-ascii?Q?dSfc8xXxuUUaG6/ybhHEqP28uGQe7KW65SuAN6Ti6MR4j+dglU1662EcCppp?=
 =?us-ascii?Q?YUTDfrTIIX53iHJmFekTCJzkud2xn9FFk+CD5KKoLN6d9Uz+1x1b/BColloS?=
 =?us-ascii?Q?DNCHO93sOIXU4HvawJKnXCIrYzZmtV0ILkZAglZrlUaVMsX0dlyFlWAHUqN5?=
 =?us-ascii?Q?z2CyYjha/iKedA7V64cqFNI2sPTc0jWyNPERmgOjmH6?=
X-Microsoft-Antispam-Message-Info: 8QgqenD2DdTArW9MEBlQYWZ3iIO/kUxdR6RSLQysmi0klUpv4kZpNoln3QxQUuWu7Dk4TDyOu/cALtGnJduE3PLmXrYSp+nzNALLUEW6sREHl4/jUvHR51SnuTdYdFtQZIr685LV2KJx0rP49rI6KGIB46w9QrB6FFxJ+hXSGV8w+XpsqnfOwqdWxik0UM09
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4291;6:XROQQ6VC2JXJaVj5wXF5T+6mMIy1KbK43KPLF8MOim2AOsXCxhT8q+RdG6pKKwIvGOpHHIto5r0DFXAhvIaF7iyM8pDTl9jFX2QOgR6w62CsY5vhErpo/oFoI9Q7Fo4oBn91tUHeJHk1a4p7y8pBl2ySfVHnVLwMfveJyUBZc+9qTPdYu5lzGXWHaiUNNOrxudWTYcUeAbjhTOvCT85IvyJBfKZ3tR8f2bUYA+KsfQscFBmw3E1eITETJZlmHKvrODfNRArR9AkTGPu8kxOQkLqW5RhfBf7XJZTlhctX+bWrJCoEDF7sGFS66xvBGjhlMlCYNmPIUyFk5+2eT0z57bUDtv9vMhIxEoJfR8owOZPohmWg5NsaOE1NjKSTrvpT85UAA87qtRCuBmsDSv4LVNP5townImUGh7/nvSJ/YR+TWvi7cEJYlERraPvH/YitZu+vXN83XGd5O4PvGeScXA==;5:p5cCldAzXmmk91BOQjXc855ZdokEcnt6TqcRA2ftaskOUyj+IRtTxx5ifhA8QeTslYtrTCkWdBeXCssTRZ1sqpyUgD+xjMLvxjhqG9K4wr4Ith4ecqgoeK9a900VU0wpF0wSHv8JGYyD9Qd2d9tckz7yuW36W+YrBy/J1RlTs/4=;24:annyROIEy4Rh45Es3J0Jue5/CBnFdFWRrxq1uzPIyDME5dQwYxv9SGSVjS3QigxEumDD3+pnk6OVNgZ9qPX0fFltxl2U3U7Wwr8vWteg7V4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4291;7:WtH/mKxZ/exiDzQP/1jc2r25ieDS/EI99gTSoOcKWIOplRwp+DGqWsMO71HhAFb2uKDLRIh263l+uDD5A5XCL5fEFwiuxZP8jph4Q29hrGnGY2QKCA/jP4z4MzmgE0QSMMyVG6f/fgJcAoJFZqsvJrXZ4vaoCssJKBFr/ULY+PQaD+03Js0ykl8zlPwgOWNA+x/DNG3iNFLIZ4SZjAbqnbDu3wDauffH4744ZqeN2wSlMoKK+pGs21YYa7cvSYgN
X-MS-Office365-Filtering-Correlation-Id: 4f33f55e-21f1-4bed-4767-08d5cca7e5bc
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2018 18:53:02.4656 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f33f55e-21f1-4bed-4767-08d5cca7e5bc
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4291
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Interrupts are ignored if no event bit is set in the status status
register and this breaks the buffer interface. No data is shown when
running "iio_generic_buffer -n mma8451 -a" and interrupt counts go
crazy.

Fix by not returning IRQ_NONE if DRDY is set.

Fixes: 605f72de137a ("iio: accel: mma8452: improvements to handle
multiple events")

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

---
 drivers/iio/accel/mma8452.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Perhaps this whole early-exit check could be dropped? It is not clear
how it helps.

If for some models we want to ignore unsupported events then maybe this
should be checked for each individual bit. Instead of

if (src & MMA8452_INT_FF_MT) {

Check for:

if ((src & MMA8452_INT_FF_MT) && (data->chip_info->enabled_events & MMA8452_INT_FF_MT))

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 7a2da7f9d4dc..5485b35fe553 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -1032,11 +1032,11 @@ static irqreturn_t mma8452_interrupt(int irq, void *p)
 
 	src = i2c_smbus_read_byte_data(data->client, MMA8452_INT_SRC);
 	if (src < 0)
 		return IRQ_NONE;
 
-	if (!(src & data->chip_info->enabled_events))
+	if (!(src & (data->chip_info->enabled_events | MMA8452_INT_DRDY)))
 		return IRQ_NONE;
 
 	if (src & MMA8452_INT_DRDY) {
 		iio_trigger_poll_chained(indio_dev->trig);
 		ret = IRQ_HANDLED;
-- 
2.17.1
