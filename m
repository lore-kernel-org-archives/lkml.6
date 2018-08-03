Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE67C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 13:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B909121763
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 13:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="MwDB82p/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B909121763
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732253AbeHCPBN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 11:01:13 -0400
Received: from mail-by2nam03on0088.outbound.protection.outlook.com ([104.47.42.88]:21184
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730848AbeHCPBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 11:01:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6GKsboTA+UMEPoKDqElRaKjHhjTJsMN+ZtD/UpSfWY4=;
 b=MwDB82p/FMfAZFWCmPeIJAAlqaohgSekVvH+72Ko+cMK5DB1aZGFs6iNPt54xDGZAQEA9s6/bMulEtKwKjX7cGvG7xRjso+NPloTnsnh8GqhRolF1B4PoxRFxMyoXBQprAgpdDjACPWF5ZWSI+mYRy6XlBOqdkup4AoYVa8IYG0=
Received: from CY1PR03CA0023.namprd03.prod.outlook.com (2603:10b6:600::33) by
 BLUPR03MB550.namprd03.prod.outlook.com (2a01:111:e400:880::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Fri, 3 Aug 2018 13:04:52 +0000
Received: from BY2FFO11FD001.protection.gbl (2a01:111:f400:7c0c::138) by
 CY1PR03CA0023.outlook.office365.com (2603:10b6:600::33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1017.14 via Frontend Transport; Fri, 3 Aug 2018 13:04:52 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BY2FFO11FD001.mail.protection.outlook.com (10.1.14.123) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1017.15
 via Frontend Transport; Fri, 3 Aug 2018 13:04:51 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id w73D4oaR012467
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
        Fri, 3 Aug 2018 06:04:50 -0700
Received: from linux.analog.com (10.50.1.113) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.301.0; Fri, 3 Aug 2018
 09:04:49 -0400
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <broonie@kernel.org>
CC:     Stefan Popa <stefan.popa@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <mark.rutland@arm.com>, <davem@davemloft.net>,
        <mchehab+samsung@kernel.org>, <gregkh@linuxfoundation.org>,
        <akpm@linux-foundation.org>, <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 6/6] iio:adxl372: Add filter bandwidth support
Date:   Fri, 3 Aug 2018 16:02:21 +0300
Message-ID: <1533301341-26560-7-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533301341-26560-1-git-send-email-stefan.popa@analog.com>
References: <1533301341-26560-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(7966004)(396003)(346002)(136003)(376002)(39860400002)(2980300002)(438002)(189003)(199004)(6346003)(76176011)(51416003)(54906003)(110136005)(26005)(77096007)(508600001)(106002)(4326008)(316002)(7696005)(72206003)(16586007)(7636002)(246002)(5660300001)(336012)(6666003)(8936002)(47776003)(8676002)(126002)(476003)(7416002)(446003)(11346002)(486006)(426003)(48376002)(305945005)(36756003)(2616005)(53416004)(186003)(50466002)(106466001)(356003)(44832011)(2906002)(50226002);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR03MB550;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11FD001;1:Gmh+oGoINz562IvAcZK1O4qt54pDjeFwyVxWRQrKNa1YwETOpd0KU5MzJn3gb42LHkFNU6wiERl1nm23VNsrLB92fBbFTDIkAPR/kVw/k3lQNlILlsGwATqTphm4aV46
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69cdbbbf-8a18-4381-abcf-08d5f941b329
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BLUPR03MB550;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB550;3:SqxUckfGeucF8cSXi3RozoX696dV8LnmoqhXdavWALQ9ylX5DjDi1VSi82GozmilsDvh4S47AnkKQddJfXrBELFr8+OVLCV4f7odMDQVaRNo4gHWVufLMqTvTsHhd9SLs402M9VV8cWxRd83HfwQ8+4JW5BvMC8AlYY24epX1WOxfP4SnH5DZOSfLNgWEP3YtVn+tq2hJ7JxKv3pk7X67YSd2nrG0f45TJ9bpmrFTqJX+S+nm5uBf6abAEz4p7EqD0Un/96xrmGa8uQ2NQYRdgGN1tG4uwUmNIHatg0dBvLHPC6pi+Q45UInE0khnx+OuMZK4wrw3nnwDoGOZ3djXun6L+AV42iT2EnuDggSzR0=;25:siwWVa2RYWo5gQDKXdSk9OfBPDMHz5SGMnFmYj5oWqKv7IiJBmfpRlzD4kciPUksXrCEjdueqmhOfLplTOSOCn/FLsv7nJclOcPY+Ib+/ScD/xKknwsoU8z1by9PUr5UrwLvBXMEKV/UdOD7OLiVzHhy6oiL0hLRhtbPgfD0Hh47Kk3tSeWWiEexpAz4z9R/CtQJbCaThSdUU6oOR/qOfxJpWkBAdKOeqAs6zXTFv//hGoOpVu3wrUlq5yGWIenA5fkwI+cxaN1Y9uO9F2NxcO6VImxRFn8xb34GGzveSjBrxA+tSdlc9J+esZNJE+YRyzXDIWadwcHTc3xfqXXc1Q==
X-MS-TrafficTypeDiagnostic: BLUPR03MB550:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB550;31:va4tRlQv30jf0ZOyEiK9YEkshF8DFFLIv9kq6t6hrZ5552zzFEJwSqnTl2M74nj44Zt24fNnS02xhZ3ruDPNn8IMSGfZd8+NGMKOEPjn8Xr7INapvl77WzuOZR0WWWwRIrRASgeCLpzEOY6ywX0Vea2G63k3ImaW2CjF7a0o6qYHZ0BxrtkDd8YEBPUQtWSCMXNY3BD3kV9SwO1ZVqgoMJZyfKka3uQzqe6IGgoqp2w=;20:pxrWhYrA56I52u5DUGaxFjHW+IpxGYAhM+GZ1/HZUXTJymLQcfm+hyQoDYpRgwVbB0S/6xc4LERb2Q0qrkhc33aQfAjUnJ2syuc2YnnvP59nE1blCCYyncflFIBbjYItzC9WyV6HVCUR1609Y5Ngg33lP9e8nW3ZO30zEtZ5HnwKFyjrLqXEFFRjfC8R7dLVl3jhU881hoRLXLj4K24+MV8UpWb+4qZAUmcbUmI4I4fTEYjko0466DiMVaAX1OwaxyBudJOwWJsqFV9T6e3X+ymlP8Q7DxpHDWJfg+CTlnkOgm+xavARhLaXC5aLWQzMX3y/P+c7ubYMrtP3aLct+dXhsD9hiIkrbZEstTncW5ePq6jMeCCosxkdExvhRli77Zz5m7HliMPumuN4U9dHf5xzknbN8E+xsjS+FQsdJ3TtXMzNjcCIDhRIdWEVjNy21ZCu0a2bPWJEffvvU5HUTgsc5UUzljuRU9sQdY3uAyU/5r73iX6YcTrQPPct+sGk
X-Microsoft-Antispam-PRVS: <BLUPR03MB5501A0DAAC7FB4B7AEF7A709D230@BLUPR03MB550.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(232431446821674);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93004095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201703011903075)(201702281528075)(20161123555045)(201703061421075)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BLUPR03MB550;BCL:0;PCL:0;RULEID:;SRVR:BLUPR03MB550;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB550;4:vebGMD6FmY1bB8D3xjNwGvWEHx1ey87XPDHvNQpjTyhpqqhSf2LXB6YBTScrNCGp9GvFGSnJLhcwi15mDdnYXfBBFTY3siL+wYarinqAJVbuGZNnKUGtQO2NI/fSdrFO3NEsg9jIGQ3SkwGESCZHguCuNNV95A5Ku+EcMMzX4K/UkWYFTx7JsSQXQlRLVdGIg/+A6YfLfn7Qxra6ahlS8uwadUR2qEavBZU8vA6sDnN0Qj1mSWbAlnEW95JquuDA0HYqCxCYOJtYZjmI7h2q0956XJBZ1eqtlHAu5vXoXs1YxoUUyDoh4Xu0RPddX3nI
X-Forefront-PRVS: 0753EA505A
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR03MB550;23:Obf2laXKHtoBeCQ3Yo637Du2o4+P0vQ1dNojFOU3Ix?=
 =?us-ascii?Q?1redMTMwUtGoKa+yVDIKXaPfUrjTKAZ7CwKMMHUQK6UGkGESFWFHAnwA6vFY?=
 =?us-ascii?Q?7pecoscuPGhZsuj0kYZRLYfZEfsHgZs/rCNWxhsqtZtnt48D60PS7WM2qY3z?=
 =?us-ascii?Q?/dmJZrzWnZeagICiay7CF+xiFfSzGUMJGs5H41ca0sFJUnpwhpAMZTiazA7y?=
 =?us-ascii?Q?CPLjv+/aBNhDwU5NSsXR27+9S1/CZnTHySrtjoo2qCbS0yv12U50OjgAsIWL?=
 =?us-ascii?Q?dOxufKDHOU3vNjteZIQkHXkRxKZs4UwYQwiF8xxr2bCN5djPVOutvkjLalMK?=
 =?us-ascii?Q?SUkuLm5c+kRfYmmgnJdGjK7lmT/AWq47ulvmkYWSatGKbjeTw+Fyuwx/LWTm?=
 =?us-ascii?Q?qQUULA0w0OdoPq+TxSITXWcaFuB9CVTUx+ukCJP4sQfQtkGH5F6OIy45rywB?=
 =?us-ascii?Q?v1Kd70ciAf2v1S5PPsYruIxUgWWha0Dds6zAsQOpkvTmF8vdZ69L5ihqkXS2?=
 =?us-ascii?Q?qgVt8xsWOjzGRC8YJhZZoFLzeQGUMwlWe4/Ph71XneJSFLDjo29DP8fLVW4y?=
 =?us-ascii?Q?eu0wx0jAiCq7Uclz23eVW2tqyT/tkzXDgZcivnQX9yNIH1SVg5TUrvCz/tcd?=
 =?us-ascii?Q?OJEgtbez6nMUqvjROJk8pBKMzVujwI/8gvDQR0QeXfeVfY8m2fWARcYAOUjg?=
 =?us-ascii?Q?aMGxpEfld2LkZHTfsmMrTKPpBT4j/QkATKftxGwj85g2Ctx1MKl33H4TGEBc?=
 =?us-ascii?Q?33BEAl6imv/jfgJEx2Mpfzh18LstzF3o1e9XOeByDy8y/R5E56opJy+O6n9w?=
 =?us-ascii?Q?Q9TqTiIBSVdT4Z6+dzRPN4LEGaS/WoJta54Oho3Ux3tL1PTNYUiUj23qKVKe?=
 =?us-ascii?Q?EqTFbK5FtoTHWdHZbdt4o3Vg3p83eX5khJ5N7TzBAxYZP5hfT++NmlI8dUzm?=
 =?us-ascii?Q?uXRd/3ylANyjpKKHYsxFj21ExRXd7h4DAWd+3LwB897ibk0kGMwqRhwQ9cos?=
 =?us-ascii?Q?w4AwALeFLI/3aTiDT15suxsVrurhFsgyqMeFVZt68Bs+gjA5jSuIMJooXlNy?=
 =?us-ascii?Q?aOgLnWAgJCwAzkSIw8neAaF1bo4E0XF9H1doCSUU3vYd897yhWy/3Gf+3Ty0?=
 =?us-ascii?Q?gBf84ePgk=3D?=
X-Microsoft-Antispam-Message-Info: DbpnEGQfnQ4/aTpdtkt6PZl44a/IryxCPLrdBqGMba9CMeE478Kxp+x0/KFDA7wK2J4mQQiwitKKiSJnHEK53YjkAFDhChMquJ/yxkcry4vbhwgYd7rk2WV6pszTcaDv5iaAbd4gi1xWNHWI3t6dAb1KIffcAKxNw9O3S8TgPzRylzrKgdbs80VI2GTYTUem3pr9W8EP4XqRjN0F+yTnyg+L1DVJIDEedBJCihcrEHisxi5h4dgnpNCNzSIe7BjiDZXJfKfpQP6Zt3uP+26FJnIMpZM2FpJGj6HkP2cWeupCwzOT3NlqDBUcdJV61uXhs909BiUTprB1uURcq7HYCa1sWAOB79skm/GRO2Gv9IU=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB550;6:eVGPpd8YqGgeO1K+dy2aa/lRdi3o+d8pbFZQ4z8qRQ8gN72HysrfXnCVjqVTAEnXQX6NWujbX1vPZvpvqCsgDOrGad0c9YktV1bmdi7ix2U2hUr6xH6ytYWAal1ubD3r4FVr5gH9SSIespmcMtY5E5GL7J3OC+LNEhvXnztrTwPEjJAAppsXNo3UsewfDAyLq2IsKAnAstXtYhCW7SdRZaognchf7anOkbstHrk4PjcKpd44Wtsl0hhYd2D0KkQK5WtuDld16NiEGo0JtfXdsEt5DTpXZ9oZBmqLRYDxrsOIMoPH540EOcvXhC6r43jA6Xrn8FWKmPihLLafopPx2S9JhEbXeUgQsv6VGQ0QyvWKOtZ6E6Cg98/g5V2+lKMhIUGCm0Kkp1avLCLNVM9OdzpHeoQFbTQmGTFbYk2pDh/kRuQTaJikjSomdnU4H/cCMW36dLo16rGQYXq4t2r7nw==;5:fl/eLZ4A/Fw1XN/a6AovaDw6gdWZJaEikVEB/CvPfeDqyp7nhbLKl97X+fLK9IVdHumZ3Zp1j83+t90/rcT0OqDjn0opK2q/xXUENkny26vjn0JRuKRFejwzIdmV3wGoCWgYYJr1wViXwNyrflttdO2OEUXsQoBILLjhp0a83+s=;7:OUEbQbsBr9iXexqhvIfEXAMeQcZBsX21KWfBbYrNMSyGUlDn/Azq+gGla/8FTvIad/qO+Ir5dzHShIsB+zx6UmhTiOH6zFDj0qCBQHbJptMmmh4GXn/whqZe3RnBSJv8QpWDNjE/G/Cm3Cx0ckqhKjFBafZaDfD1In1kpdoSgCBiWxtQOsq9olJZzzW/oD35S0vYNPO8OoY1FCCqH3pEtOK/lFJUUhSMIvLpRHmZ3czoct83ZD4O2eTIlfBI7wyE
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2018 13:04:51.4023
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69cdbbbf-8a18-4381-abcf-08d5f941b329
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR03MB550
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the option for the user to select the filter bandwidth. The
user can also read the available bandwidths which are always adjusted to be
at most half of the sampling frequency. Furthermore, the currently selected
bandwidth can be read via the read_raw function, while the write_raw sets a
new bandwidth value.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 drivers/iio/accel/adxl372.c | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
index 80b1838..3a9d55a 100644
--- a/drivers/iio/accel/adxl372.c
+++ b/drivers/iio/accel/adxl372.c
@@ -196,6 +196,10 @@ static const int adxl372_samp_freq_tbl[5] = {
 	400, 800, 1600, 3200, 6400,
 };
 
+static const int adxl372_bw_freq_tbl[5] = {
+	200, 400, 800, 1600, 3200,
+};
+
 struct adxl372_axis_lookup {
 	unsigned int bits;
 	enum adxl372_fifo_format fifo_format;
@@ -218,7 +222,8 @@ static const struct adxl372_axis_lookup adxl372_axis_lookup_table[] = {
 	.channel2 = IIO_MOD_##axis,					\
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |		\
-				    BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
+				    BIT(IIO_CHAN_INFO_SAMP_FREQ) |	\
+		BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),	\
 	.scan_index = index,						\
 	.scan_type = {							\
 		.sign = 's',						\
@@ -656,6 +661,9 @@ static int adxl372_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		*val = adxl372_samp_freq_tbl[st->odr];
 		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		*val = adxl372_bw_freq_tbl[st->bw];
+		return IIO_VAL_INT;
 	}
 
 	return -EINVAL;
@@ -666,7 +674,7 @@ static int adxl372_write_raw(struct iio_dev *indio_dev,
 			     int val, int val2, long info)
 {
 	struct adxl372_state *st = iio_priv(indio_dev);
-	int odr_index, ret;
+	int odr_index, bw_index, ret;
 
 	switch (info) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
@@ -698,11 +706,34 @@ static int adxl372_write_raw(struct iio_dev *indio_dev,
 			ret = adxl372_set_bandwidth(st, odr_index);
 
 		return ret;
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		bw_index = adxl372_find_closest_match(adxl372_bw_freq_tbl,
+					ARRAY_SIZE(adxl372_bw_freq_tbl),
+					val);
+		return adxl372_set_bandwidth(st, bw_index);
 	default:
 		return -EINVAL;
 	}
 }
 
+static ssize_t adxl372_show_filter_freq_avail(struct device *dev,
+					      struct device_attribute *attr,
+					      char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct adxl372_state *st = iio_priv(indio_dev);
+	int i;
+	size_t len = 0;
+
+	for (i = 0; i <= st->odr; i++)
+		len += scnprintf(buf + len, PAGE_SIZE - len,
+				 "%d ", adxl372_bw_freq_tbl[i]);
+
+	buf[len - 1] = '\n';
+
+	return len;
+}
+
 static ssize_t adxl372_get_fifo_enabled(struct device *dev,
 					  struct device_attribute *attr,
 					  char *buf)
@@ -826,9 +857,12 @@ static const struct iio_trigger_ops adxl372_trigger_ops = {
 };
 
 static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("400 800 1600 3200 6400");
+static IIO_DEVICE_ATTR(in_accel_filter_low_pass_3db_frequency_available,
+		       0444, adxl372_show_filter_freq_avail, NULL, 0);
 
 static struct attribute *adxl372_attributes[] = {
 	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
+	&iio_dev_attr_in_accel_filter_low_pass_3db_frequency_available.dev_attr.attr,
 	NULL,
 };
 
-- 
2.7.4

