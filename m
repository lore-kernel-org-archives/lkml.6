Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649A3C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 12:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0196218F1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 12:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="NJfc6yPM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0196218F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbeHQPf1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 11:35:27 -0400
Received: from mail-cys01nam02on0075.outbound.protection.outlook.com ([104.47.37.75]:11440
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726339AbeHQPf1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 11:35:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4gVBR0wsEW0oNi8w6/PJB9xR/+KyVM+fh0aGByb8IyA=;
 b=NJfc6yPMVu2CiJnJk5lzgcX6mHF6et+3oaF7d2um3nEUXFVbZo4yRvhVPIK+KOhEG6GO7tHv65l22UPgey2M8eW+wSsN+snLCHjlGmOo8HCLLM2Tez4za0r1ITMMRzr2IhSKQeIT63f3Wqy5fT2wwn3n3k2zLh+QRfSrB1zrLyY=
Received: from DM6PR07CA0013.namprd07.prod.outlook.com (2603:10b6:5:94::26) by
 BY2PR07MB2294.namprd07.prod.outlook.com (2a01:111:e400:c50d::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1059.20; Fri, 17 Aug
 2018 12:32:02 +0000
Received: from DM3NAM05FT010.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::203) by DM6PR07CA0013.outlook.office365.com
 (2603:10b6:5:94::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1059.20 via Frontend
 Transport; Fri, 17 Aug 2018 12:32:02 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=fail action=none header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 DM3NAM05FT010.mail.protection.outlook.com (10.152.98.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1080.6 via Frontend Transport; Fri, 17 Aug 2018 12:32:01 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w7HCVwPF002475
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Fri, 17 Aug 2018 05:32:00 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Fri, 17 Aug 2018 14:32:11 +0200
Received: from lvloginb.cadence.com (10.165.177.11) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Fri, 17 Aug 2018 14:32:11 +0200
Received: from lvloginb.cadence.com (localhost [127.0.0.1])
        by lvloginb.cadence.com (8.14.4/8.14.4) with ESMTP id w7HCVvos013681;
        Fri, 17 Aug 2018 13:31:57 +0100
Received: (from adouglas@localhost)
        by lvloginb.cadence.com (8.14.4/8.14.4/Submit) id w7HCVvZD013680;
        Fri, 17 Aug 2018 13:31:57 +0100
From:   Alan Douglas <adouglas@cadence.com>
To:     <kishon@ti.com>, <linux-kernel@vger.kernel.org>
CC:     <stelford@cadence.com>, Alan Douglas <adouglas@cadence.com>
Subject: [RFC PATCH 2/2] phy: cadence: Add driver for Sierra PHY
Date:   Fri, 17 Aug 2018 13:31:55 +0100
Message-ID: <1534509115-13577-1-git-send-email-adouglas@cadence.com>
X-Mailer: git-send-email 1.9.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(346002)(39850400004)(396003)(376002)(2980300002)(199004)(189003)(36092001)(575784001)(86362001)(8936002)(2616005)(126002)(476003)(486006)(47776003)(50466002)(48376002)(42186006)(105596002)(87636003)(8676002)(336012)(478600001)(2906002)(26826003)(426003)(186003)(36756003)(26005)(316002)(246002)(356003)(5660300001)(14444005)(54906003)(16586007)(107886003)(4326008)(305945005)(7636002)(51416003)(106466001)(217873002)(50226002)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR07MB2294;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT010;1:z7XS58qTQ38KUnZYtG3dJMlKvmUQRe3tZUPpihm+iu9UxYSgeekkT0JyxITGiQrn4PEs7femlGvqU7mPjl4HzS7UU96XycmwPCikMtfcq4HlVla0U26QqfXri7971LGN
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 504cf500-3b3d-4292-7af0-08d6043d6f0b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060);SRVR:BY2PR07MB2294;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2294;3:AbjIXcPK3kussgKszsRyjClGfni3doTEbfni8L1FGdqj8vM35nX9uWIy3nsXyX+i4YsBhXaIpFVjI0vo97zFrtPdrB0GI8sQIIA76b7CVffD+KC5eDk0fFHO0krYfn/ddKmW+kHzPsjkrk9wSNNe804knl6HMaOktPqvr+aZxBBG6MyMFlLxkJrrxoyukKcXI4CLsWOapjtIn3YZb64ck2iM4lz2nS6i8z1tjkyKlIf9KFm8eHYd9GsQYYBvEUfsOazX+I0L2Zjh5ZY9sgxWKp0xbikc2Ov61wVGX6uSkziI7+NmDIxWV6ENdnzpENERjqplUXw+A/BPJN4YUHdhIjDeABKp4FG21AxAiBz05hI=;25:4ocpL+fplJrxw3SS+x0whF8UMukm01knZVG5S3KCcL+gGPDi4eszlCPmpQwrnf7UIe98Y9DTFkOg8K+tJwP5C7YJSrZr15qSNA4nvrXb98yTQWzUSoVS575tFr7h+t8erSu+28qME/peLK0JnqzbkRfBO7YwXbgtGqf24uv7+0RS3qyh5ZZm9wDiQOCUiyoBTkDe70s6/L5jM11r5dV4yq4keZULW2q/CCYoOYBwBxEPG8L6RwfTytKp++e2xKtYPmqZKrA298rDpPXx5Nu1UsJTfT9TAejxxanTstcAJYcSMsuumfDBXol0GVv2d72krWqvWyu04qBGnzMJsBDE2w==
X-MS-TrafficTypeDiagnostic: BY2PR07MB2294:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2294;31:jZlPnizgOxxrzZmpnaPXVm1h1mlRmiUBtJ8uO7FJ26Q37MM5YcoIhuilP1hqXgedsJFYdCGqJrapynbQ/tmlWk2M9YSGObng84y4bvUAqU/fXFrPKhr3tgjb0y9Pq3kAM0i7yjt4qdEgbUt7nZxPkkw2MZ7FVDZYvXTbAdh216CZlvAuDHEvkCQhKDERm08+idsigP6SWxuYVK8LecbDVDRrHfdBe0GXeAFQmgHaMO4=;20:EnhWuVYYkwYP17Tn59xmzxtGxdXYTzTN8rKQPKJxBSkEpUPGUJA39pGSGhxhKRJrkuyKXrWL8s9y52kJkWVfikHRRoAMxR9UzQb5pBro/qGvdhtLnSesfSQIko8Sk5sw70u+kLQOqnZYUuzvLoo3d9iseTcS+inFX1l6CfRFMhQ+2/qQ8iHuVil7mRHt/FPNzW/f+9g5u0GjKJKaSEWLNPzeZx4q1/vh5TS0fSR2AmzyNM3d+MskN3CWEI6+1lK+8gzzSzNJxPNiMlFttz76GZO5T/TnMZ4hryj7WIec9zesuHozeDz35zxKW6XvsKGmp7bYKtQC0pQrg/LsQrBGkodyLm891QIPeGN0bezoCtvuY9zCn5MEBJt6dT4sTVyWRCcKSoPvXm+jBoLfPTVxFTu0YR6zQA7qasl0ZJOFN1cqXGRBsdGaGMp7SAbxmJxnNcKjjEpK9BeAF1fpOt8i5xci10B7ytaxZDp/kHTaV0K7xGelJJJrdDqxn46F8tfu
X-Microsoft-Antispam-PRVS: <BY2PR07MB22949635072EA2BADC5D68AFD83D0@BY2PR07MB2294.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(3002001)(10201501046)(93006095)(93003095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699016);SRVR:BY2PR07MB2294;BCL:0;PCL:0;RULEID:;SRVR:BY2PR07MB2294;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2294;4:U61AEb8INQQ+jeKWudKtT8bwUCGaKDEye0thk7J0YAGnHtEVEBCHBCNNJ+Bq12luXCAfs8IRDXexGHdEX0D7z0OM5H3RPxZHzsJxIx5TCGGXlLUtn5CgvFnLNrjMRxxiXUmUyM4iPqXQAll4s2ftxdTYwBhKK7UyzpbRUPuU+Ql4GVANVB2sjvqhqt60QTk+OC3h/ajWLHuNhYc85PQ2BBnmGD+u4Xq5FeZcYfsIxQ2N1wtz+v1D/FBEI35KLyjySHk1DqZZqXfVX9hBY2oPkiVx04/hwVIZgb0KbWK8nD2am1KTKpOdA8D0zLyFlkIq
X-Forefront-PRVS: 076777155F
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR07MB2294;23:kN/YhemDBGesXkH9MOvDw7pOhuu+cz13mY3aV06/h?=
 =?us-ascii?Q?rg9PjRDvla1Y6Uho1McQuMf4U7sJW+g/9xWHTtB4Cxk2f7vqILlVD/uMOr9P?=
 =?us-ascii?Q?95264OVnNfUKegXNRua0n2Gx3cgeF4J3kCGegFE4sma4cNn4VUPB8q5co/G/?=
 =?us-ascii?Q?9k7S2X57boM5GajYsyetYRsaaB8DV+t+AcjvJ7bolKjKzo9So5ggh07IRvKh?=
 =?us-ascii?Q?XBK+MXgEPYuK1n6EZKk2WyIonEFHZ+QXJ5rnnfHH30WPqvr0J8V1NJUNp1tx?=
 =?us-ascii?Q?i4xX3s1XPsGbQUvZem7iyoL4MGfNBMY48FAR8sOuj0N8OQdKbpXcGqY8H4c2?=
 =?us-ascii?Q?tD9Hj3RqefQvb+VzqksgO3zV+kLk/N6WDJY7gZi8XF8Kii6YF185OY/vh4Oo?=
 =?us-ascii?Q?3CQrPHvQxxH9PI18qRvbEoI7EaPDVLRoaukfwMO2M5vRvmaYjKmllTnO5Ul/?=
 =?us-ascii?Q?6DIGxiS7ms7LMmXUwu91vd2pOq3LBS05/BjCwGi4P0S0WhFMNhDjnfgS5qfq?=
 =?us-ascii?Q?Ug2r83f7SV6e/08aPyXE04Vr3AoWycbZh26fK4euZ+eYQDEid3q9hvVvACKt?=
 =?us-ascii?Q?yinsMBtx1PSuymItpG24dLEwFQgjC1oEt2EQOVX29Fwj3iltk6EXKcUbU5bb?=
 =?us-ascii?Q?RM/zAoFDcxioOEtExL51ooKr0cv75ZN+igwdRd2JoCeLlXTpfZW0qVzK2oeV?=
 =?us-ascii?Q?zXwo/3LjPz/fQEAUkAxzPXuy7uREu5dUv9SckfQNLxx/PNTvgJMMaOnHebtr?=
 =?us-ascii?Q?kImfLP8Yr31N575ddR4XG0kOnLfW7nOnF+iqdV7TkU6JNEtX5pZnl3FyjHCb?=
 =?us-ascii?Q?SC0U6rQM0e19IOH95EJ8PGP7sU1oQXOYfwR+TB+7Ijbp3t+6H01jB4ahGKHM?=
 =?us-ascii?Q?74E0apqbdD8mamx34a/I8G4ERFyVu7GGH2ElWr8TQkPDzXJsW9uH8HtRknMf?=
 =?us-ascii?Q?sSb+WoOKnPBlf1ej3JfgQXu7oBwgmTyKLMn+sQHunCSG6gr0xRKr1MxNOY3B?=
 =?us-ascii?Q?GslLoNgEQKMs32+WkvH1to0QVqMfHUIWTswkV6mCTb6DhHnC+hZNHwobchH0?=
 =?us-ascii?Q?Xb8SNQ=3D?=
X-Microsoft-Antispam-Message-Info: DCJd1FIYuD2icgnZveueHyyEt+kFidgi3Io3IlhzOArieBv64n7uFAh3SVXRhNajV3+9+Tj6MLlC9ukJemxau2XZIabVPma2uDHtotsLoYBVIwSj3uAg9DnbOJ0TAli4R6e0F6ljQUmsvPZVPLPTUxSWiEg/hQRfhAfEzvonO1txW2JTtEtTMc2j1mgJ4YYMGzN8ej/RAVmIEcNRghbJzNOHM7IebGfijxKoHVktBcq44dgDcLMbOhcDK8ZnVeErc6RxHms1VBfd/i4+MgcWqGcpQMQ6dyDdpKDhvipWpAqhTinRZNjWvV/IzxaznGO6sc8fQtwYSxvr8UAwlgt48E7Uh/Z01NJJd6/LDgwGyUEYReQLI/PWCNukYelzNJ2VnFuoJP43/wU/WJ2W7B9qNw==
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2294;6:wnYTAGbBi4J7woHZkDkm7nb9j/7QIWZRcwvL8CGB6xn233anwwgJAqGXcnYZ3HrMT9Rsguohff5bTHwgjmofNE1vVcdwwr1+sHQapqaBZNdT0l6B9OA/MgqcJUzgH1utMRuWh2A3VcTQXcopf3U7i/ceVdK9DKBqDVHY8x6vXNOwCyKH+G5g6WVVovpccjDUOvQRVVro+2nQNfClXd9BGI9F7q1XvyEPzOssqj8IjWbFQvzOjWRynvVFKFKs/JMXf9X5p//8Qre/49H71LD4YgcrThY7g4EDCrtLOMUGER2Z8WfBnt6logrXw+xRn5JshcwdSrSa7tIFU0tvxeK7gHM/dJ2b39OrQCUpVli8ygVXQcaeikxisQuziX3jpfeyrqP40FuoMvg7ltn0gOIkwdrPI156oLk+O3JSF5rQ1gmWw3bxiHS6D4RK1n8BTcA3mILNerJ4DlHi7kUAPpGEfw==;5:fYG+vPF9vsC1XiZTQS2PuaQmn3rgQw5yjDASJZY3T4oTZfnrikaMgHcYarppoHClQIC5rqeOt5TbtrsXkNz9phP+9w58Qu/auyH+/gR508k1tI93CCalEPJVlaMaboGus/7sxCrLqTm8V2PyaYgRFapOsNAy4svqtcdllU6KXBM=;7:MU0FA8Al9nJaNoGweleRoLctIaU6Y9g4Bfh2TggXuckFfcweqW0A9H1JsVt6onVMp25ittaixXQJq0tZ3lKG/yQZyGTJlVcI1xQiwp8mGLaE+rLJUsl6eqArlZLTA2ImKtB+kwSRKnllLSS2QPoOfVStTPA4d6jvnsu/ekmlZXEZVWlsamymrds7Ijm3hHJN/+6gSCi3qKTex0hWrGKcxEvpSf2+DdlGUB8FEP/S212GO2klA01Yfrhy8FN0LlWi
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2294;20:Zat6UG1V7tvoHbcHIwy01SLJKhEzeHMtZCRWnIZD/cFOaHspPd5mmQl8aqhJvElzh3nDSwz2jM/VfFAymfFuin+eutH2Xc3cS+ne3RYMLMxzwBlN02l+46YC8FZhE1OhWII6GtHmyPHGWdrxMj0+V+c4mWcoR0iRSsaa4jPQYkpi02QYOBxloALis12LtzNpK7u35b1xLD+G1u6QNCMufjVoTjtTLgwsXqT/FFzN7lg9mbqfJxu4sD19HoA61Z28
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2018 12:32:01.9855
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 504cf500-3b3d-4292-7af0-08d6043d6f0b
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR07MB2294
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a Sierra PHY driver with PCIe and USB support.
There are two resets to the PHY, one to enable
the APB interface for programming registers, and
another to enable the PHY itself.

The sequence of operation on startup is to enable
the APB bus, write the PHY registers and then
enable the PHY.

On power-down we simply put the PHY and APB bus in
reset.

Signed-off-by: Alan Douglas <adouglas@cadence.com>
---
 drivers/phy/Kconfig               |   1 +
 drivers/phy/Makefile              |   1 +
 drivers/phy/cadence/Kconfig       |   9 ++
 drivers/phy/cadence/Makefile      |   3 +
 drivers/phy/cadence/cdns-sierra.c | 326 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 340 insertions(+)
 create mode 100644 drivers/phy/cadence/Kconfig
 create mode 100644 drivers/phy/cadence/Makefile
 create mode 100644 drivers/phy/cadence/cdns-sierra.c

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 5c8d452..cc47f85 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -43,6 +43,7 @@ config PHY_XGENE
 source "drivers/phy/allwinner/Kconfig"
 source "drivers/phy/amlogic/Kconfig"
 source "drivers/phy/broadcom/Kconfig"
+source "drivers/phy/cadence/Kconfig"
 source "drivers/phy/hisilicon/Kconfig"
 source "drivers/phy/lantiq/Kconfig"
 source "drivers/phy/marvell/Kconfig"
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index 84e3bd9..ba48acd 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_ARCH_RENESAS)		+= renesas/
 obj-$(CONFIG_ARCH_ROCKCHIP)		+= rockchip/
 obj-$(CONFIG_ARCH_TEGRA)		+= tegra/
 obj-y					+= broadcom/	\
+					   cadence/	\
 					   hisilicon/	\
 					   marvell/	\
 					   motorola/	\
diff --git a/drivers/phy/cadence/Kconfig b/drivers/phy/cadence/Kconfig
new file mode 100644
index 0000000..6bbe5a2
--- /dev/null
+++ b/drivers/phy/cadence/Kconfig
@@ -0,0 +1,9 @@
+#
+# Phy drivers for cadence devices
+#
+config CDNS_SIERRA_PHY
+	tristate "CDNS Sierra PHY Driver"
+	depends on OF && HAS_IOMEM
+	select GENERIC_PHY
+	help
+	  Enable this to support the Cadence Sierra PHY driver
diff --git a/drivers/phy/cadence/Makefile b/drivers/phy/cadence/Makefile
new file mode 100644
index 0000000..b384cb3
--- /dev/null
+++ b/drivers/phy/cadence/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_CDNS_SIERRA_PHY)		+= cdns-sierra.o
+
diff --git a/drivers/phy/cadence/cdns-sierra.c b/drivers/phy/cadence/cdns-sierra.c
new file mode 100644
index 0000000..0581516
--- /dev/null
+++ b/drivers/phy/cadence/cdns-sierra.c
@@ -0,0 +1,326 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Cadence Sierra PHY Driver
+ *
+ * Copyright (c) 2018 Cadence Design Systems
+ * Author: Alan Douglas <adouglas@cadence.com>
+ *
+ */
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <dt-bindings/phy/phy.h>
+
+#define CDNS_PHY_PLL_CFG		(0xc00e << 2)
+#define CDNS_DET_STANDEC_A		(0x4000 << 2)
+#define CDNS_DET_STANDEC_B		(0x4001 << 2)
+#define CDNS_DET_STANDEC_C		(0x4002 << 2)
+#define CDNS_DET_STANDEC_D		(0x4003 << 2)
+#define CDNS_DET_STANDEC_E		(0x4004 << 2)
+#define CDNS_PSM_LANECAL		(0x4008 << 2)
+#define CDNS_PSM_DIAG			(0x4015 << 2)
+#define CDNS_PSC_TX_A0			(0x4028 << 2)
+#define CDNS_PSC_TX_A1			(0x4029 << 2)
+#define CDNS_PSC_TX_A2			(0x402A << 2)
+#define CDNS_PSC_TX_A3			(0x402B << 2)
+#define CDNS_PSC_RX_A0			(0x4030 << 2)
+#define CDNS_PSC_RX_A1			(0x4031 << 2)
+#define CDNS_PSC_RX_A2			(0x4032 << 2)
+#define CDNS_PSC_RX_A3			(0x4033 << 2)
+#define CDNS_PLLCTRL_SUBRATE		(0x403A << 2)
+#define CDNS_PLLCTRL_GEN_D		(0x403E << 2)
+#define CDNS_DRVCTRL_ATTEN		(0x406A << 2)
+#define CDNS_CLKPATHCTRL_TMR		(0x4081 << 2)
+#define CDNS_RX_CREQ_FLTR_A_MODE1	(0x4087 << 2)
+#define CDNS_RX_CREQ_FLTR_A_MODE0	(0x4088 << 2)
+#define CDNS_CREQ_CCLKDET_MODE01	(0x408E << 2)
+#define CDNS_RX_CTLE_MAINTENANCE	(0x4091 << 2)
+#define CDNS_CREQ_FSMCLK_SEL		(0x4092 << 2)
+#define CDNS_CTLELUT_CTRL		(0x4098 << 2)
+#define CDNS_DFE_ECMP_RATESEL		(0x40C0 << 2)
+#define CDNS_DFE_SMP_RATESEL		(0x40C1 << 2)
+#define CDNS_DEQ_VGATUNE_CTRL		(0x40E1 << 2)
+#define CDNS_TMRVAL_MODE3		(0x416E << 2)
+#define CDNS_TMRVAL_MODE2		(0x416F << 2)
+#define CDNS_TMRVAL_MODE1		(0x4170 << 2)
+#define CDNS_TMRVAL_MODE0		(0x4171 << 2)
+#define CDNS_PICNT_MODE1		(0x4174 << 2)
+#define CDNS_CPI_OUTBUF_RATESEL		(0x417C << 2)
+#define CDNS_LFPSFILT_NS		(0x418A << 2)
+#define CDNS_LFPSFILT_RD		(0x418B << 2)
+#define CDNS_LFPSFILT_MP		(0x418C << 2)
+#define CDNS_SDFILT_H2L_A		(0x4191 << 2)
+
+#define SIERRA_PHYS_NUM 2
+
+struct cdns_phy_instance {
+	struct phy *phy;
+	u32 phy_type;
+	u32 nlanes;
+	void __iomem *base;
+};
+
+struct cdns_sierra_phy {
+	struct device *dev;
+	void __iomem *base;
+	u32 *init_data;
+	struct cdns_phy_instance phys[SIERRA_PHYS_NUM];
+	struct reset_control *reset;
+	struct reset_control *apb_reset;
+	struct clk *clk;
+	struct phy *pcie_phy;
+};
+
+static void cdns_sierra_pcie_on(struct cdns_phy_instance *ins)
+{
+	int i;
+
+	for (i = 0; i < (ins->nlanes << 11); i += (1 << 11)) {
+		writel(0x891f, ins->base + CDNS_DET_STANDEC_D + i);
+		writel(0x0053, ins->base + CDNS_DET_STANDEC_E + i);
+		writel(0x0400, ins->base + CDNS_TMRVAL_MODE2 + i);
+		writel(0x0200, ins->base + CDNS_TMRVAL_MODE3 + i);
+	}
+}
+
+static void cdns_sierra_usb_on(struct cdns_phy_instance *ins)
+{
+	int i;
+
+	writel(0x0000, ins->base + CDNS_PHY_PLL_CFG);
+	for (i = 0; i < (ins->nlanes << 11); i += (1 << 11)) {
+		writel(0xFE0A, ins->base + CDNS_DET_STANDEC_A + i);
+		writel(0x000F, ins->base + CDNS_DET_STANDEC_B + i);
+		writel(0x55A5, ins->base + CDNS_DET_STANDEC_C + i);
+		writel(0x69AD, ins->base + CDNS_DET_STANDEC_D + i);
+		writel(0x0241, ins->base + CDNS_DET_STANDEC_E + i);
+		writel(0x0110, ins->base + CDNS_PSM_LANECAL + i);
+		writel(0xCF00, ins->base + CDNS_PSM_DIAG + i);
+		writel(0x001F, ins->base + CDNS_PSC_TX_A0 + i);
+		writel(0x0007, ins->base + CDNS_PSC_TX_A1 + i);
+		writel(0x0003, ins->base + CDNS_PSC_TX_A2 + i);
+		writel(0x0003, ins->base + CDNS_PSC_TX_A3 + i);
+		writel(0x0FFF, ins->base + CDNS_PSC_RX_A0 + i);
+		writel(0x0003, ins->base + CDNS_PSC_RX_A1 + i);
+		writel(0x0003, ins->base + CDNS_PSC_RX_A2 + i);
+		writel(0x0001, ins->base + CDNS_PSC_RX_A3 + i);
+		writel(0x0001, ins->base + CDNS_PLLCTRL_SUBRATE + i);
+		writel(0x0406, ins->base + CDNS_PLLCTRL_GEN_D + i);
+		writel(0x0000, ins->base + CDNS_DRVCTRL_ATTEN + i);
+		writel(0x823E, ins->base + CDNS_CLKPATHCTRL_TMR + i);
+		writel(0x078F, ins->base + CDNS_RX_CREQ_FLTR_A_MODE1 + i);
+		writel(0x078F, ins->base + CDNS_RX_CREQ_FLTR_A_MODE0 + i);
+		writel(0x7B3C, ins->base + CDNS_CREQ_CCLKDET_MODE01 + i);
+		writel(0x023C, ins->base + CDNS_RX_CTLE_MAINTENANCE + i);
+		writel(0x3232, ins->base + CDNS_CREQ_FSMCLK_SEL + i);
+		writel(0x8452, ins->base + CDNS_CTLELUT_CTRL + i);
+		writel(0x4121, ins->base + CDNS_DFE_ECMP_RATESEL + i);
+		writel(0x4121, ins->base + CDNS_DFE_SMP_RATESEL + i);
+		writel(0x9999, ins->base + CDNS_DEQ_VGATUNE_CTRL + i);
+		writel(0x0330, ins->base + CDNS_TMRVAL_MODE0 + i);
+		writel(0x01FF, ins->base + CDNS_PICNT_MODE1 + i);
+		writel(0x0009, ins->base + CDNS_CPI_OUTBUF_RATESEL + i);
+		writel(0x000F, ins->base + CDNS_LFPSFILT_NS + i);
+		writel(0x0009, ins->base + CDNS_LFPSFILT_RD + i);
+		writel(0x0001, ins->base + CDNS_LFPSFILT_MP + i);
+		writel(0x8013, ins->base + CDNS_SDFILT_H2L_A + i);
+		writel(0x0400, ins->base + CDNS_TMRVAL_MODE1 + i);
+	}
+}
+
+static int cdns_sierra_phy_on(struct phy *x)
+{
+	struct cdns_phy_instance *ins = phy_get_drvdata(x);
+	struct cdns_sierra_phy *phy = dev_get_drvdata(x->dev.parent);
+	int ret;
+
+	ret = clk_prepare_enable(phy->clk);
+	if (ret)
+		return ret;
+
+	/* Ensure the PHY is in reset */
+	reset_control_assert(phy->reset);
+
+	/* Enable APB */
+	reset_control_deassert(phy->apb_reset);
+
+	/* Program the PHY registers*/
+	if (ins->phy_type == PHY_TYPE_PCIE)
+		cdns_sierra_pcie_on(ins);
+	else
+		cdns_sierra_usb_on(ins);
+
+	/* Take the PHY out of reset */
+	ret = reset_control_assert(phy->reset);
+
+	if (ret) {
+		clk_disable_unprepare(phy->clk);
+		return ret;
+	}
+
+	return ret;
+}
+
+static int cdns_sierra_phy_off(struct phy *x)
+{
+	struct cdns_sierra_phy *phy = dev_get_drvdata(x->dev.parent);
+	int ret = 0;
+
+	reset_control_assert(phy->reset);
+	reset_control_assert(phy->apb_reset);
+	clk_disable_unprepare(phy->clk);
+	dev_info(phy->dev, "sierra PHY OFF\n");
+
+	return ret;
+}
+
+static const struct phy_ops ops = {
+	.power_on	= cdns_sierra_phy_on,
+	.power_off	= cdns_sierra_phy_off,
+	.owner		= THIS_MODULE,
+};
+
+static const struct of_device_id cdns_sierra_id_table[];
+static struct phy *cdns_sierra_xlate(struct device *dev,
+				     struct of_phandle_args *args)
+{
+	struct cdns_sierra_phy *sphy = dev_get_drvdata(dev);
+	struct cdns_phy_instance *ins = NULL;
+	int i;
+
+	if (args->args_count != 2) {
+		dev_err(dev, "invalid number of cells in 'phy' property\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	if (WARN_ON(args->args[1] == 0 || args->args[1] > 4))
+		return ERR_PTR(-ENODEV);
+
+	for (i = 0; i < SIERRA_PHYS_NUM; i++) {
+		if (sphy->phys[i].phy_type == args->args[0])
+			ins = &sphy->phys[i];
+	}
+
+	if (!ins) {
+		dev_err(dev, "failed to find appropriate phy\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	ins->nlanes = args->args[1];
+
+	return ins->phy;
+}
+
+static int cdns_sierra_phy_probe(struct platform_device *pdev)
+{
+	struct cdns_sierra_phy *sphy;
+	struct phy_provider *phy_provider;
+	struct device *dev = &pdev->dev;
+	const struct of_device_id *match;
+	struct resource *res;
+	int i;
+
+	sphy = devm_kzalloc(dev, sizeof(*sphy), GFP_KERNEL);
+	if (!sphy)
+		return -ENOMEM;
+
+	sphy->dev = dev;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "reg");
+	sphy->base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(sphy->base)) {
+		dev_err(dev, "missing \"reg\"\n");
+		return PTR_ERR(sphy->base);
+	}
+
+	/* Get init data for this PHY */
+	match = of_match_device(cdns_sierra_id_table, dev);
+	if (!match)
+		return -EINVAL;
+	sphy->init_data = (u32 *)match->data;
+
+	/* Check that PHY is present */
+	if  (sphy->init_data[0] != readl(sphy->base))
+		return -EINVAL;
+
+	platform_set_drvdata(pdev, sphy);
+
+	sphy->clk = devm_clk_get(dev, "phy_clk");
+	if (IS_ERR(sphy->clk)) {
+		dev_err(dev, "failed to get clock phy_clk\n");
+		return PTR_ERR(sphy->clk);
+	}
+
+	sphy->reset = devm_reset_control_get(dev, "sierra_reset");
+	if (IS_ERR(sphy->reset)) {
+		dev_err(dev, "failed to get reset\n");
+		return PTR_ERR(sphy->reset);
+	}
+
+	sphy->apb_reset = devm_reset_control_get(dev, "sierra_apb");
+	if (IS_ERR(sphy->apb_reset)) {
+		dev_err(dev, "failed to get apb reset\n");
+		return PTR_ERR(sphy->apb_reset);
+	}
+
+	sphy->phys[0].phy_type = PHY_TYPE_PCIE;
+	sphy->phys[1].phy_type = PHY_TYPE_USB3;
+	for (i = 0; i < SIERRA_PHYS_NUM; i++) {
+		struct phy *gphy = devm_phy_create(dev, NULL, &ops);
+
+		if (IS_ERR(gphy))
+			return PTR_ERR(gphy);
+		sphy->phys[i].phy = gphy;
+		sphy->phys[i].base = sphy->base;
+		phy_set_drvdata(gphy, &sphy->phys[i]);
+	}
+
+	pm_runtime_enable(dev);
+	phy_provider = devm_of_phy_provider_register(dev, cdns_sierra_xlate);
+	return PTR_ERR_OR_ZERO(phy_provider);
+}
+
+static int cdns_sierra_phy_remove(struct platform_device *pdev)
+{
+	pm_runtime_disable(&pdev->dev);
+
+	return 0;
+}
+
+static int cdns_map_sierra[] = {
+	0x00007364,
+};
+
+static const struct of_device_id cdns_sierra_id_table[] = {
+	{
+		.compatible = "cdns,sierra-phy",
+		.data = cdns_map_sierra,
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(of, cdns_sierra_id_table);
+
+static struct platform_driver cdns_sierra_driver = {
+	.probe		= cdns_sierra_phy_probe,
+	.remove		= cdns_sierra_phy_remove,
+	.driver		= {
+		.name	= "cdns-sierra-phy",
+		.of_match_table = cdns_sierra_id_table,
+	},
+};
+module_platform_driver(cdns_sierra_driver);
+
+MODULE_ALIAS("platform:cdns_sierra");
+MODULE_AUTHOR("Cadence Design Systems");
+MODULE_DESCRIPTION("CDNS sierra phy driver");
+MODULE_LICENSE("GPL v2");
-- 
1.9.0

