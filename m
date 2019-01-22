Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85990C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4058620844
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="mFm+5OGr";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="GXVNvlLc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbfAVKm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 05:42:56 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:33990 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726284AbfAVKmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 05:42:55 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0MAXroa008388;
        Tue, 22 Jan 2019 02:42:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=yP2Gg3DzACwrgarnwxUpZgCr5fIgSca0m0vC0OjSKEM=;
 b=mFm+5OGrTiaYIsIp8j64pw6DbvJp8TuCBAsQH7jRDBpgf5AgVmXdfIGRqXFbstNyr1Gm
 tAAP99su7XRYlEl4sf+YW5S34C5XoB68IoCnx6N4PryHS4sdxv22v4WakRsw897Kt+w7
 aA+47uWMjSV/Aai0yp9QV5p0MRqlqE9VPKIWHCmecDxO3EkrUkUN5cx/pMwi72SsOAO3
 dCJCrO60EaUbnhxMKLSXRWtoEj0yLCgURdzvOPCw4pFn2hyOs2mnTIWTJnGWFL8zRjvC
 pCGGzWm4oJvgMi8SCVDP5YNCNdmLBbvvD20F/5K9qQxCGbTgBS88ee2f5JZAdHyJoPid 1g== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=jank@cadence.com
Received: from nam03-by2-obe.outbound.protection.outlook.com (mail-by2nam03lp2058.outbound.protection.outlook.com [104.47.42.58])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2q40bxbfwp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Jan 2019 02:42:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yP2Gg3DzACwrgarnwxUpZgCr5fIgSca0m0vC0OjSKEM=;
 b=GXVNvlLcfXvW3bo0dKZTBr/NpQFDJzqM2wJwKWp7F49J7e+gYvugt66Sq3Ujqhnigj/lP6PhChFdaolOJw164lAihTkZRds9lYOk8x3KL+M4xtRmbqrjzh1e0SG4zPRRO1cQFz9v2JCoQaDnKqqM3OFvxnzo/7aiXItgxS7RAXQ=
Received: from DM5PR07CA0050.namprd07.prod.outlook.com (2603:10b6:4:ad::15) by
 SN1PR07MB2175.namprd07.prod.outlook.com (2a01:111:e400:c455::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1537.29; Tue, 22 Jan
 2019 10:42:26 +0000
Received: from DM3NAM05FT032.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::200) by DM5PR07CA0050.outlook.office365.com
 (2603:10b6:4:ad::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1558.16 via Frontend
 Transport; Tue, 22 Jan 2019 10:42:25 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 199.43.4.28 as permitted sender)
Received: from rmmaillnx1.cadence.com (199.43.4.28) by
 DM3NAM05FT032.mail.protection.outlook.com (10.152.98.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.2 via Frontend Transport; Tue, 22 Jan 2019 10:42:25 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id x0MAgKxI031105
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 22 Jan 2019 05:42:22 -0500
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 22 Jan 2019 11:42:20 +0100
Received: from lvloginb.cadence.com (10.165.177.11) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 22 Jan 2019 11:42:20 +0100
Received: from lvloginb.cadence.com (localhost [127.0.0.1])
        by lvloginb.cadence.com (8.14.4/8.14.4) with ESMTP id x0MAgJDP012252;
        Tue, 22 Jan 2019 10:42:19 GMT
Received: (from jank@localhost)
        by lvloginb.cadence.com (8.14.4/8.14.4/Submit) id x0MAgHpb012182;
        Tue, 22 Jan 2019 10:42:17 GMT
From:   Jan Kotas <jank@cadence.com>
To:     <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-rtc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jan Kotas <jank@cadence.com>
Subject: [PATCH v3 0/2] rtc: Add a driver for Cadence RTC
Date:   Tue, 22 Jan 2019 10:42:14 +0000
Message-ID: <20190122104216.12077-1-jank@cadence.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(376002)(346002)(396003)(2980300002)(189003)(199004)(36092001)(47776003)(107886003)(14444005)(106466001)(105596002)(68736007)(8676002)(2906002)(6666004)(356004)(36756003)(4326008)(69596002)(26826003)(42186006)(478600001)(50466002)(316002)(426003)(87636003)(110136005)(53936002)(486006)(48376002)(16586007)(305945005)(8936002)(50226002)(26005)(1076003)(4744005)(86362001)(81166006)(81156014)(126002)(476003)(186003)(2616005)(97736004)(54906003)(336012)(51416003)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR07MB2175;H:rmmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT032;1:xAeKdlHtrb3xrB1uzhcoqxAQJ6QMLEAlCN9EgKUXTewHxv3iAntjFCU6PgugMnGM7G6hMcqFR2RpAsA5aXXh2TWUDnaSP0aAtL/pG4GX+JLDYo/EPfAV/8Rkb7JE425+YwQVkZdo85JBv05PAG8SacmTWGeyAimL1uWsqT1spqk=
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31fbd177-c34e-4e26-db6a-08d680564c54
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060);SRVR:SN1PR07MB2175;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2175;3:kp6JJFQVtGru7ojrl4uXezKHFdd+t7HfK91AaXu6NK1fY4ZY7Vo/0J76sXAbpiQ/R6vaMK9FbWKoY5SYKhu/G5j2i987/9DSikNrQZtktBBJ9ORXi99NN8iWMcWSg5/IYPjw0TQAczPnjYQbzl3mHdrPK44RTcnUEvkEWyqMODkyL34VxLEBhNBhXkLMZCrHjxFmXXoxjPV+A858s3O5sKZq86wPh4Mzta6Bxb96JrYv5Yif+kLZSpzG9WD+8i41/srhQhteFOCzI3SB+z8OTslNCaZVD+y26DcvX4RHqDdHcLtuFbvexgNSbHWUwzU2ojnUPgmvrS6xm/V+3jogssRJoeaxo4Mwg2GJe2Uzsoek4BV+10743gXUxTumBrkj;25:QgunjWLO+Gtdr5XP8BmFZedaIVrTBap7R4ndjce1nP3I4WsHiXK8e6NpgsgGrx/I5obulprlVROjmzkxIrnRsgSP1CMcalmGNdaise1HAihHxxaU7SS48jtsd7HnpRacbPbopHYgqYlUF3rjJXUmEplDNy/9JWsvuOE6+fEwwOySzVqYqaOM77CNvNGk/g7ehjHiCu94SAsIVhabZ5fF+yfDi5ZlR3RAQrLGLkrcFeVlkaUGOwBrCSe7OGkA7ApJh7XR3SjPs+keUrENgfe5yR2QxljOOtEqI4xWfhKn1ov6uk1pP7DJQU/1DTdmzcB+NcrKbAeWvdThNa4q2txTLYfEhKwk5WBMEYcXXH/l6ao=
X-MS-TrafficTypeDiagnostic: SN1PR07MB2175:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2175;31:imt0PDX1M+E707CklaA6h+FfoDe2P+O/CD1Rx877sQSv+xzyWd2ic8dYuvr+q0+Ppfe7vzyWODkitiBBC9O7QrT5qta4Lv6rfWmldvEKyG8j8OMomm2kKmru8tBNnBEBq0kX+DwuFdA6NiBi/zJI0DmCXm+x6Nbs6kFgwMTIiY1RH5EkZwDBHCKaX7PhaopgZAY955OOthwThEtBqACY5hKZcsFZ3A8kZRLxLTDKwLE=;20:3t9fdsnBGFbi5M7RlSsnjnmzVRB5WlSGOR6IwZPIqjS2UYtSsCeiobo3BM+AaFJ03eLIoe9lxXeMFQJxckifH4eOFIyaf8PXIB4gfbQzdVC5aCesfK2xyOo2h3FKyduBmFGlGHTMSqTzu4qtQs6ubh7uHFWb2Viv+PZtebFePMSulaTPT3+V4d3Q9AobGgImholeKFC8ed/pJQurXpE6AV4PimxcFFv1dlQm8EfKbsWSZ3goOx5i0il/Np1XVA7nM6sX2mA50pwvseF9FaJ8jepne123LqHnyA0q6q6xo+BLAIfgKlxP6r8Ni6sB1VvzezdEUcPMrJs3UivXJmBfjNmfg/LaevB8IUlDW27f02JsYdUg55/Cln+3uKe1DBNNfcuQPkR4W4N0HTugt1MM0lWb8cLEt/l7bH1vjXX2WFLUFJ/3RSIlxVQVDtmnoxU2f3IwA2WOVUEZpQQE+A8XoXaSPmPExS1P30mzVNpSAI9lB3CrZhWpE1R0rQ1FAo44
X-Microsoft-Antispam-PRVS: <SN1PR07MB2175D6199B7F1D57B980BC7AD0980@SN1PR07MB2175.namprd07.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2175;4:ydKRbTTWV72zml+/Jji1Q+niX1OSLA1lmICj0wGP/KNLQa8uHaPmi7vlCZLueMf/pjId3mDcHhFnu2rUXHWZ/Cu8WuxgOVMwOpsWUry74/1ogujYAn7cH1j74zQtXha1fha8flDP3BdSRLwkprg23NxYymnPbsSRRsQZOAgH9NbHpTD1UdLogF50CAEkOr8/r9POAd3bMd7elcbAXcO1G84kAJF2WRljQG70JCaB3bNzK37pSawgp06eLRxejgLDXpjtSw8t12BrsRJlFJVbcPKJV7HryTFbaFECt+RBwZJbTGHQWOUoOPyu3EH5UXcv
X-Forefront-PRVS: 0925081676
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR07MB2175;23:vNwOSLkXFg0JBMslAfyTl9o0F/heTthcR91IF0pr/?=
 =?us-ascii?Q?aIZyaccYzAixGoCPAZLYjugECXCmZfVoarF/5npHIiiKU6/LQ1muW92fZXON?=
 =?us-ascii?Q?h/1g2Zi43UM0Kd3/il5+XubhV5NsmSFQifVSzSrkN9I31KM4EwGUIYLh96Ir?=
 =?us-ascii?Q?YqtGaifOO9SGGNUk2qka6vMIOiuKCeTwWzEP+vzXYR82fLUIpiPpEhXs+wfE?=
 =?us-ascii?Q?ID31sWaVBQ11VJ+DLXBIVenwmDRPDJTufwTM1kLwpihAQJ3JFes7eBiRrV9L?=
 =?us-ascii?Q?Po6yDDXoTLA0fdP2haH0te7ZxjMWHpEYuAjSQqzXy26K1GD18Ys+9VRUpxE/?=
 =?us-ascii?Q?dtIR0xFYiTyZ5BKWfUtRhsE6tD7DFDVMy6CkoCG+w+JNo2y2N+41zwXL66j2?=
 =?us-ascii?Q?OqZYTY7Vy69J1X+8APoP6ICI/RYaG/hUVAkEI73IIv1vs5opjNHtCZNG3Rxm?=
 =?us-ascii?Q?OAIIIOKKkutRFjZD/N7TqvcUAQdzNCXaxgq52Iw6+kuHcmjwC5mlWQ3bYRw6?=
 =?us-ascii?Q?vh+79HmqYeZQ5LWvQXp0J7fhoP/CKfXDZRzff0dynLKcMIZ9m3MgKscFIR03?=
 =?us-ascii?Q?xcf4ZcyoBCkLp0kgbQXnGNUtg2qHCxDzXmBMTmnpBDH6EZbr7PRUBySIMDrX?=
 =?us-ascii?Q?ot2zD5fKNZFfpKunwDYN8hXWShG/K0N8tzR9A/VeVgAlrr2H1XQ3LoHPepI0?=
 =?us-ascii?Q?VMEKk4kEBPSFABrCmMqULjhlho2PwijocfRSHP7gk9fT0DC7c1LPzmhCszaG?=
 =?us-ascii?Q?abaKO5hy3marc5DEoEpsABz6xw0YDvzsZ6t4i1lwYkYpyE8jgzagVBMHlYsn?=
 =?us-ascii?Q?N+oPWuABn0vY02o50fm4gJ90EzbXguEUL2cqeH1lesFuP2Mi4EJJGTECTOuw?=
 =?us-ascii?Q?OY5tmMvvxleHHPxiJoLvPMoTEM+r7VJiCe1bHIIwdZevyqt6LrUuSrTNyb3K?=
 =?us-ascii?Q?z/Lk9tZdVWeyHcppoAA7q+S4GNiYl9Lu1JsZanOt//JwzfBuWilcG2OT+TAK?=
 =?us-ascii?Q?1noDfwrsiD6c9se9QQmCh9Jg9IoxQiorf57Njl1W8LSXQSCJS1oZu5bAip79?=
 =?us-ascii?Q?vW+hgojfUK1DWO69/VqKGhNkvtSx5N1CZ+mpr+Js6/xEUt8hVIY5ijdfJvtU?=
 =?us-ascii?Q?j7trN02U9TWylEN9eCvOWagLX2h/6012+aYC0ONAG7KERHFnAdz1A=3D=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 7yB2ZmuetGMarvV8uM+AarLY5v3DJ8ebFWFwfnEWL+anzLIk8CFq6I9DdjBPROW8xAM2HPrWLN0cVsb58lBxd0lDxXdZ2eo74lqq9jdTZ8dRqBz8KBeCBThbY1jWWUuhf3GH4MuNdyFrJNUfd8QINOMep7AklZ0anh9rCtLsZGlMDWNOjZcEbafZFTN+MkeMbc9M5Q5hTfz0xsRL07AsVPtERwcbDEFJSQBu5L8Y/tAnKypAIiTUBffp36vT2oDnXvrJZzOtGj07EEn10wHvEprqztouuaFwx0joF6rn03Usz1aPN5gtU9+vjB2UCj15nH/ZXr+qfQXiKpMxLJVr7hC6ncpHw+k8ZrbPfDyy5naSIQJHP0s7qoOKhAfk0n60PkBAyCf9DKO+2lassBkFzcrUepOdLsjEEtw5ysv3gEg=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2175;6:+a2QVb00g9NR1puBnq8Xcx9R754wdSsY73AUeQk43g2XOQiiNyY8BpxuKItcWQeieW/AZcGI5TXFKYuZVKj03TLsnBFVKQRFLw1su80erkihR1xOGo9hpwpZj5kyaZiTvpT9BoRrj0ngZ6twHPW/WC7bBRWUhYke4rEtr35ypcx73YARI3pMAfrEo4tS+tXVNwnmMBy9v6gab9bDOabczXq1ivT5snYHUkrMvk+LXFcp3pM9o0yIT2DRoKIJFP7LIfEHRfVHfqfp1Vo/6PBej+AkuehZeU54AkDBemq6kzgk+dP/uYkgsLuMqh2UXn6Y3ni5y6wE8Cu9yq9JpT8Vmy7TfENdOk65XGLybpUThli58TUrORLmjcdoOM7k08zK4qH84gjuKT+qCuYlRRBOnzfMDmAI4ZlEOsyY3HVIXWPQL/52O9IK9QyI4p8qTIGRrbkQAT/LxBDho3wxNEzF4A==;5:LbSpUb1AW3IYmiLE8WMOasU20l+//erlDdxgnblMjitTm6Dx4q6P1094h6RpF4zLdI/TZ/78LM1fncE2LOlzwd/RJrZ0gLnoBOrs4GeQjuM7DZ5z5EUDs8X410cFQYl3NQTHB5POe0x9x306KMR0h5S6qJprGRkgySmPCWcwb9qCiZGNyJg8doECGJyOOggIwMMky0flGlJm0WMJZA9h6A==;7:o/e5nI/C3EMvdYXzv1pKExmlnuCCDiVS9zwlAaQG4ProqHGOQL9XoTPb1D+VjJGUklAZlOIhqf2R/pgYFSA4CPxG1tjV9HfUlZIUsCg4ihQWqobQ81YLQmXYXWlXHQE7GF5oHj4TMYng4xJCb4arQg==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2175;20:RJFoJudCSAz5GKMGlt07T7HqqiORCEIAI5xjzhFgjaxk8oFeVX6p5uhlLB1q3E7xzEDaX7r5e79PijV4mQJVwilWwCNy1QKpYgvMzLINs/rMwuMHqPV10c+Bn/srCL6ZwJd/ssqcZQ2gWV7skyzxEK3MwbhYH6tROCsp2zDDVOxqrbp0zfCSeH4/+z8JUw9VwALXFUxtXc7mWbbhX2FH+1LR9xfRTHdaCAQzpXvh416Is9xSXEUaVtq+c69Dx8Mt
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2019 10:42:25.1442
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31fbd177-c34e-4e26-db6a-08d680564c54
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.28];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR07MB2175
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-22_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=910 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901220086
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds a driver support for Cadence RTC IP.
It supports time, date and wakeups from sleep.

Changes since v2:
	Fixed a typo in the bindings documentation.

Changes since v1:
	Added devm_rtc_allocate_device before requesting an IRQ
	Added range_min, range_max values
	Return -EINVAL for read_time() if RTC is disabled
	Fixed some typos

Jan Kotas (2):
 dt-bindings: rtc: Add bindings for Cadence RTC
 rtc: Add Cadence RTC driver

Jan Kotas (2):
  dt-bindings: rtc: Add bindings for Cadence RTC
  rtc: Add Cadence RTC driver

 Documentation/devicetree/bindings/rtc/cdns,rtc.txt |  25 ++
 drivers/rtc/Kconfig                                |  10 +
 drivers/rtc/Makefile                               |   1 +
 drivers/rtc/rtc-cadence.c                          | 423 +++++++++++++++++++++
 4 files changed, 459 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/cdns,rtc.txt
 create mode 100644 drivers/rtc/rtc-cadence.c

-- 
2.15.0

