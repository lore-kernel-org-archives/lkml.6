Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70202ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D2E6208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:30:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="BayqwbNp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D2E6208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729829AbeIQIzc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:55:32 -0400
Received: from mail-eopbgr700085.outbound.protection.outlook.com ([40.107.70.85]:23264
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728742AbeIQIz3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:55:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+GSGMtu9fZcxoWU2BmnilHQzG6hur0nG0XIMFrlIhw=;
 b=BayqwbNpfgt5z0pz6EFuR7/jGFbihs72t1w4MdeXfQd7QfpNfgNAFpTWUWv17k7kNWTDYhnfnj+M0QtKCZGfNytRH89yrJAJ14GNAKrWoyFqaE2EvFK/glef1APwJ3PiTs5kRutNlO6ovVuOL168c06/HFHs3fxRH4BuYTT0e+M=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 CY1PR0301MB1577.namprd03.prod.outlook.com (2a01:111:e400:529c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.14; Mon, 17 Sep
 2018 03:30:02 +0000
Date:   Mon, 17 Sep 2018 11:26:33 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/3] i2c: designware: select gpio/default pin when
 prepare/unprepare recovery
Message-ID: <20180917112633.252c591c@xhacker.debian>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: KAWPR01CA0085.jpnprd01.prod.outlook.com
 (2603:1096:402:c::21) To CY1PR0301MB1577.namprd03.prod.outlook.com
 (2a01:111:e400:529c::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e548207-d603-466a-1847-08d61c4ddc09
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CY1PR0301MB1577;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0301MB1577;3:6oGGKQH4Vp5WPDpLb6i5qMH27g/Cj1i4K86NDWE3qSOvH/8qUwLb3Vbvn6Ssez8ITxj4zxBv9XdM/QggvSsje0sKp4UZXgB1VjIm4cnTTnW1kIEpn3sn3KDXfBAFpT0LHac11ylzyq8UH6/pinctgl0xGqMAU+E7j3HTMwntB/5fUNJJoqoiUubgXmj3b3az+wQQAdHCmUhfAFscbxfbbrbOUy3DLp90YeYSwzvtTm2mLYsg5XMOqLpTdxTDStxM;25:yzA0ovFrO20aItkbKqyJ3Mwemfds0yVM85r54W/fwZZqTwVz8G6OlV9EqwBTM5IlKGkrnZD0v8de+7JoEnpulLe5wkWWoJionY3VEPHyeuhdcyJISTj1VBWwTYlQagOpu6GVvWw/pANnUMEXeheZfJwWgelQIjpXApkHuShpyBj04BTzP3tMtefWrM4jt1yW+QBv6IBa/qxZJIHGfB5YV0/gd06y1tzXKBUkKN5D/XG0Q3NcJAKDuCGf10Ol0RxBhLWHfO8UhvR9Y0iM2m/oKmaFClTIwrybeDm7kK3zIFvAadh0F6uxHA6YYL8B7vaIAOvoGYJ21A/5SD+rDmsVCw==;31:YS5PjTZc9uJUnA1oh7uKvTbJAp+9kihFzC2BU5zxeyTvN4R0IIVhbkHXTkgGXpgyUeC/tkg6BNz21adhSpJWfXatnePY/zG+sXRsOOhZfMYUtfF2Keh9SeYm8Ug1ztE6z7Avq7gd/6QUbhYf/SCZ4uxHqHQWFa6Jbq2R085K6CKlfiS9kMjWYVa35sGvWFDwJ4csQM/4Yf6c7dFvwdP6e8AxibhLPQpOKCajQzR3fmM=
X-MS-TrafficTypeDiagnostic: CY1PR0301MB1577:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0301MB1577;20:5siD/CGo2BgtdPapctlu2MgLPICssKhmr1bD9QqyJfze87+JRrShULep0JRtWTIDSoH0W5+5q3PwfoQQHS21NW9urqHnlF9vbH40boLQ10cXOmGp0tnIWfz9pOOUGB79Jm7D/4SQDDRKCGTT1PoU/qcDH2gA3UdXIUSzNv1i9Ph0fAqU8GVTdb4ToTJGQg1SZ8JcElGh+QN0b/7GvbtMTSBlg7U0aysi5gr1/4PbuMo4pMvinZkfcaORGBLlo9LODySI7BrXNgW8n7iq410vmhmb37DCdmsF9J3ynuhlePwf1e1Ylq86ix35r8so/iZ7Xq/uUiaU957N/enyUk9HrB8Xqk9CPhbLznyrTMleJHrEq6KKo09gyksy7HQhsUUDT68jZ9Lht6EVrmG6A4H2/+WQJ9f4LNK3c7xIAXOGiN972B/OGyUCAPXmUru5NboPpzxTxNf0Ao3Sg14CC74dXnDJ9j8rhyluNLau6+IOA5PFV63diBNsYX3OH5pECVNk;4:Lvw49voIzsPjv+j9S12XiD7RdmqdB7UvHXbHau5p3qaiTGqt0Kw9HEFbWNMt5wFCg4co3kpIzXBbkYhV+TaXa29X+QbwvM/2MZvuVdZTV378nk65DfH+fsfQwtvbk9lH/V4FHnuRwavy4/RUyT6eES+dLOYEuHLwmlECD0wr8y5p5efdgsSR8jqZNC8UYQNygEYHu6CVzIn7ZacxTHgw7MrgENz3NUk18BC+Y0nB0DHjuPtzHFUerKI+p9bJgA9T/Wf5dP3SuXqiW1RZuOfz+Q==
X-Microsoft-Antispam-PRVS: <CY1PR0301MB1577D4C8193D0415109944D4ED1E0@CY1PR0301MB1577.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699050);SRVR:CY1PR0301MB1577;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0301MB1577;
X-Forefront-PRVS: 0798146F16
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(396003)(366004)(39850400004)(346002)(376002)(189003)(199004)(72206003)(55016002)(53936002)(7696005)(9686003)(23726003)(8936002)(50226002)(33896004)(5660300001)(3846002)(97736004)(6116002)(230700001)(52116002)(305945005)(81156014)(7736002)(8676002)(81166006)(478600001)(105586002)(1076002)(106356001)(110136005)(25786009)(316002)(956004)(476003)(2906002)(486006)(50466002)(386003)(6506007)(66066001)(26005)(4326008)(186003)(16526019)(68736007)(6666003)(54906003)(86362001)(47776003)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0301MB1577;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR0301MB1577;23:k1HzsvLE94XXDi/vDmXIpY+Vti19+oJlBUWUjTq?=
 =?us-ascii?Q?LcAMbhkKpWe14iHwCPMG8jtqmTJt0OzliGgd4UUgIPjE8odZJJnL1l0DM84Y?=
 =?us-ascii?Q?MnrQYgutYMrPC4XzviZXKXYPOXv+8osjr9WYbjoSLPybt7vV5mjAGqr1DP6n?=
 =?us-ascii?Q?SgPEeTmBansQO2Org8ODrYsoyKHwB/ZRX/1xgXDyuzgNPsoS7UvBhJF/24iT?=
 =?us-ascii?Q?ANGalhUHhC8Xq38opuwI2aNXvktJOqvuT8lRClxIXNQNG65wzLaUuPo/rlq1?=
 =?us-ascii?Q?Mj2fwOHcUsX2+b95wqO8HGk/uIekX09qyZ/9U2J5WGyXoUvmsfvLrAAkIckt?=
 =?us-ascii?Q?xnsjel/iENgFtwPDvQWg8EBL2r/yYa7h1ohL+Hna2ID85jBT+/dxfSTSOGTi?=
 =?us-ascii?Q?tJfL0Bv94MFT3OJ/wbhjOVH92OhCVzRvJ26WFUY2jEAtOnAu3Asin34QQ6ja?=
 =?us-ascii?Q?PNR2BDoys4mfKNsqbNmaHUt8doB1b5pGL1SVrHXOK79iYdo4u1dqhV0el3so?=
 =?us-ascii?Q?op54Ou2SOQdkcpzrLl4UME2265utnVOB6JpyCbC5FftKMxuuRaEAIVBTBgCu?=
 =?us-ascii?Q?NMy7/rYChHRCntZ8spZEL5Qyi6yp0BIQhSy2SDLN5kw5FCKJMunSo7PPsZWR?=
 =?us-ascii?Q?5BfYKAs5JwDdsC3+cB6g/hi73+J4ZApLC9EdvThoXEjh6SqYorFXWZJoSuz1?=
 =?us-ascii?Q?B6egocel9cHQMrcJpEpHZEyUKPs5rVxD3E7nljcpS5rB8w60M+23DgL5Cafe?=
 =?us-ascii?Q?aS62S5M8xw7ChFfHZ803yKTxLOjG7gTllHSKkfupLHoWO31krnuaDfzxNAtt?=
 =?us-ascii?Q?KHg5XZ5nlJPzkM2bOAMo1m0SqF6devzlzCXdE6v8u59OK9tbAj3xCNy0TcqA?=
 =?us-ascii?Q?LsMiWobp6RswEJR0HhGz4PTqJWCDLbL1ot9ZzjWB9IRe3LE0V3+F23ymgc2u?=
 =?us-ascii?Q?/eEL5m2s292V3goXbfWaVY3Rwz/BjEOdDrGAxBYVGVH/Hmp0YnpMikb2ekrc?=
 =?us-ascii?Q?ZRqkdrCU+C0n778gjbbpHeTRjXzxZFkWHI9OhlTuvAV6yPNCEn0dZyDLlGhT?=
 =?us-ascii?Q?5fLE2j5N2khFMIoVQwdc2OvMez8Vt6qf6A4KAxwYZrrUrl7cFW/NoO1hl+gi?=
 =?us-ascii?Q?cn42d27P7GUzMHL81y18mU6+RWNdF1ZFc+N258K+QaqosNnnonhD8GHWk6Bd?=
 =?us-ascii?Q?9GhTMqnuDpubyCys=3D?=
X-Microsoft-Antispam-Message-Info: cgp+IhvFK4LO/CIR1gIcbEBTnbyLstvxG2w4Fwzp/2oBSKr8tXnQMFqj8muHsGeUG0WNOjuIXK7fjxBtvNcBcVXSQUFppg0vnPUQo3iBKYrHpHi/OibGJ6cN9lgWVyT4mSZFlydNhBg1ZkOlpANSXg6DZ7X/0Aho8it2RB0wfW4NPKH3QHMqi6eO991MCo7MrF295JfdOozAXso41E4/n3RzHoPJgCFoMJ0oijG3VUQtLf1D5MPuV3uT11YREKIjdAfyTKROom41Htci5/+AQAnNIkSI3oJiozx9qGaIxntdjGhb3X4brHmJmsxCzY/TxtAYvO56H61GJNmlCgU6rnt5l5J9SivdfpPR2DyBuMM=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0301MB1577;6:wAxxYj7OOVi/d02tm/UxMbcdIk/FAH4fb5sFwLcPhVEiPE30eVGbAXzCL9/y9dg+1FvXsEqHfL2TRQgR2civ5KgZOu1waXNMUMTLAy9jtRofz53ioH2SZKqrPUmtjM2PqCXIfBGN5rVnvA+d0cjUOEKb4EcLU12nba3DU2bVgQ85AMschOof64amYjWIPUtlYAJUIDoiOBq09sjskqvg0UGKFPpjkcIoGowA5kvZVOkYQoFycAOsIu7LRXYdFTEz0vHLioovR+UkXXdcM9Y4IcDBpLvG1psqLWzoENgUkVJhNqaR2rgbT34OiNrkQMafcLWbbCbnhLjNX5l33uvYFhJrzVAi+aHKsKCybnqyaVsY4bLriRRuyx5iq4Uet1GIG+08cy8GvU/zPerZVHrejLuZyilrXoQus7WBy88OVX58O0js/fLDt4F58Vey93QRYl7rptxHCyWjLE7vIPBGxw==;5:I61fEFXxBpgLp435WfzFif2RXruMbt37j8sCr2wjjqIrbnUdxN1yMBfrYKHR6oEb1K+xeD9ghSltjLSmK96hFo1AMvoHJrtAh774Ts3DoNx1KYcLvuf5PxuZwnlieau1JXna6nryD/qFS6Lh+joWvVEoRuakz5qOwoZcOkuS8A4=;7:UT6HHuMWZ/ADJ5hUjMQIaP0ouRWlJ0dAf7ocOyr1t2dSkA4MCRK8VCBoyWdSASOF9/LgodVgYivQ+wCT7SpLkqCNM5xy9L8ETT7kbdaFF+l4G/ulfQoQ3ZWh60EX2FhaxDx4efey5YpSZ7W40O17ppGER9A1wpT8xALs8lEvkaCrDjUUFoJThI6/hWAWLlNloJSPh+BoK1l2tnyE0Iqseg4OVfkgv0MFT0TEdgjulIEd09lHTzZjyybgXbBDFVc/
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2018 03:30:02.7198 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e548207-d603-466a-1847-08d61c4ddc09
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0301MB1577
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some platforms, the sda/scl pins are muxed with gpio functions, so
they could be used for recovery. Select the gpio/default pin function
when prepare/unprepare recovery.

patch1 adds the missing scl-gpios, sda-gpios properties binding doc.
patch2 adds the pintrl property for i2c bus recovery.
patch3 selects gpio/default pin when prepare/unprepare recovery.

Since v2:
 - add missing property dt-binding

Since v1:
 - use IS_ERR_OR_NULL

Jisheng Zhang (3):
  dt-bindings: i2c: designware: add optional gpio recovery properties
  dt-bindings: i2c: designware: add optional pinctrl for bus recovery
  i2c: designware: select gpio/default pin when prepare/unprepare
    recovery

 .../bindings/i2c/i2c-designware.txt           | 12 ++++++++++
 drivers/i2c/busses/i2c-designware-core.h      |  3 +++
 drivers/i2c/busses/i2c-designware-master.c    | 22 +++++++++++++++++++
 3 files changed, 37 insertions(+)

-- 
2.19.0

