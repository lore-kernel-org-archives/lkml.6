Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2464C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 07:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E4EF214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 07:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="SIO/Ohv1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E4EF214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbeJJOkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 10:40:52 -0400
Received: from mail-by2nam01on0062.outbound.protection.outlook.com ([104.47.34.62]:31611
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726488AbeJJOkv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 10:40:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1LGPYVsI9enDAM66TIB1TMNtZGXEOsGtxJ8CzxsEZbY=;
 b=SIO/Ohv1gwEac4ARVTvK84opyLqKEmbhtzprNiRL9t6Osmot2PpikhIK2Ihy66LuMi+7Zyx+F9uCt8prssGYlo9xsvoXsenihnhOvibfMrmELTkD6rJzsN1h3ei9hcOKzMwKSEkf4mipx1j7Szlze+0i2t/TcOoEBFQQwmFK+7A=
Received: from SN4PR0201CA0040.namprd02.prod.outlook.com
 (2603:10b6:803:2e::26) by BYAPR02MB5221.namprd02.prod.outlook.com
 (2603:10b6:a03:68::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1228.23; Wed, 10 Oct
 2018 07:18:52 +0000
Received: from CY1NAM02FT030.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::207) by SN4PR0201CA0040.outlook.office365.com
 (2603:10b6:803:2e::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1228.23 via Frontend
 Transport; Wed, 10 Oct 2018 07:18:52 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT030.mail.protection.outlook.com (10.152.75.163) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1228.17
 via Frontend Transport; Wed, 10 Oct 2018 07:18:51 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <wendy.liang@xilinx.com>)
        id 1gA8lf-00051g-9q; Wed, 10 Oct 2018 00:18:51 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <wendy.liang@xilinx.com>)
        id 1gA8la-0001CM-6E; Wed, 10 Oct 2018 00:18:46 -0700
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w9A7IfTN031593;
        Wed, 10 Oct 2018 00:18:41 -0700
Received: from [172.19.2.167] (helo=xsjjliang50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <wendy.liang@xilinx.com>)
        id 1gA8lV-0001AF-KQ; Wed, 10 Oct 2018 00:18:41 -0700
From:   Wendy Liang <wendy.liang@xilinx.com>
To:     <jassisinghbrar@gmail.com>, <michal.simek@xilinx.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, Wendy Liang <wendy.liang@xilinx.com>
Subject: [PATCH v4 1/2] mailbox: ZynqMP IPI mailbox controller
Date:   Wed, 10 Oct 2018 00:18:31 -0700
Message-ID: <1539155912-29760-2-git-send-email-wendy.liang@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539155912-29760-1-git-send-email-wendy.liang@xilinx.com>
References: <1539155912-29760-1-git-send-email-wendy.liang@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(979002)(396003)(346002)(376002)(136003)(39850400004)(2980300002)(438002)(189003)(199004)(305945005)(51416003)(486006)(107886003)(7696005)(126002)(106466001)(110136005)(54906003)(39060400002)(77096007)(575784001)(36386004)(446003)(476003)(11346002)(2616005)(356003)(4744004)(4326008)(44832011)(76176011)(106002)(47776003)(316002)(426003)(16586007)(8676002)(6666003)(5660300001)(36756003)(81156014)(81166006)(14444005)(50226002)(9786002)(186003)(50466002)(48376002)(8936002)(2906002)(15650500001)(336012)(26005)(478600001)(63266004)(107986001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB5221;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT030;1:e++q/Gegqm/9C2OuIhtH+QR+9dFaOEE/5yrJHVMagJmwVh8EZxstwrfvYPAlen7rAgKutv2CQ1IXSuurJRIHrhJa1zBmGFXwmLY4ob1g6/33vmRc9IT50/3NL9Ho0F19
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c0617de-29d1-48b4-b564-08d62e80a193
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BYAPR02MB5221;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB5221;3:jG26tQ8VzazmLZmL4CRGR/jHXewariC7KVB0jRgHWKj8l7uB04kFotzdnroG0+v04fr2b2go5jJS2hci9h30Fcl3LNzc9ftxeMUCTGL9ZSLV5dguKK4z2d6b8ANpSyKq4CnFrof+C+Xpdy+3645WxynAo2Vh6n/iWjVyFCBJp8LOzHCHT9la4uANBDmvsYrDIvcr++pBRy9m5wZNb1bZFA/hyA7YgwfrgPf85ekZ7rfBGHaXNpEwMDTppD+lkylmMlq9UhOYbF7eETU9HnIvjCwbf/mB/W/2iCgWueAmaTPg0gfWTdUBevFYzPmcK8Gz1aJ7xfpJlJui/IIccJAgkRhLQPj8bM3vFnomTOTIQ7Q=;25:08+TmNXsuH+BCHFEqhQz5mFtYMHh6zPLgaj9vAu78DDwzE2v9X0qiZw4TkaeAyfmr2SvutXsVoizXwGjGtJbF8Oa7icYoceGN/jgz68A/IqJfOalBHAa/vcSSViJs/Y8Cz4XAbUGeIT2AMaG3BVh2xFbdD2YkioRnZw0LjMYXO1txmWAPTNNTsYQrdo0GWsgJfVnxRE54HTaV8Re70AsR2o2ys5KHi8BLVnV4bVAF6xOm9AkulSxr4W3sclyrZitmgZNz/2KVtBEfJ4cmD1ZD2tmtx7Iuu5xYZaLdlqyC/67H22UxjBlAcI74fw2xbdyxpDQoeSE3koedqAmic+sPw==
X-MS-TrafficTypeDiagnostic: BYAPR02MB5221:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB5221;31:F5OeBscOCz9meAcgZlpMa4Eo8Y4ZRjZeVGyw3RLGiolYkQZ/CcDydm6fTGAOZSFjXjKitrXSravN9rHxjczG2klWXTE/Jharye50EcohLc04fCXds/md4kOXFJ9SC51v/dKQNyJCdiExOVJs7fdy0OKGANUKU2rZh0DQqvJ/qXMxol/QagBED3ibgOPIIPqkA34QxaajyLRmF1nhEykT/DViW9eoWhM0zHpEtjHSFa4=;20:1Z1C9eAQIx+RciFdEBVkqu/kFnqPVeErkprqjxI33PbJQbSUJs+nwEv7+yM/Cvithgrre6AJILK3E9TSqOLWX01Dokne4szWYstU4XutUIFF5N9AVdgau3jgVuG04vvfYR7ZIAIueHd7uzWCUTlwM80yYnOMPB5kgsJyPSDrjkO5JFBEVGOMZtwvGzbm55xj0JGQDv+tICdBPcVPM5TjXeFHIStmrRpDkIjYspGKS9T2q7ifpwAPFpaucHkDkGyKtqdAyfzr5TUkFnaEO2G1i+hc3efe1zRKcYFo9hnGsFUI0qivDazqzGvwi1J+hQFikNIK1iqUOB5Ypkuz08nSdUh3/BbtM3yYq424pAnFEom7cAIl92BRNd6G0Kq/wtjjrJKjG/mBlxdxX2/JxpN2BqK8BzZ5o253XXLb0P0ECbs6vsPBs4yzSngMxNEk/GF84cba7GcRzdwQ7gHjZjAN08mCLoVC9OSoXofK2DlkMmtU5fCkVqM+hlraCRkHvZWp
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB5221E6A1FA7B5F3BB138C3FAB0E00@BYAPR02MB5221.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(93006095)(93004095)(10201501046)(6055026)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991055);SRVR:BYAPR02MB5221;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB5221;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB5221;4:BXxQJfScT54ui4VP9lR3w69c/wHzL2HHE7iGxw710rzezd1k8l2O3QT695lYaqrZ2oB1wodr0tUL27zPR6/ZGSeggvHnMSmzeAjt3Jf7nErg2khGcjW2ruCxppuRl2Hg94vWWhmtN2u+OKaJE1VCdCf92V+OEbl1ctRoxnaGjKWP+2nzgWo65MFbDVWc6p5xZAxe7wJKJILkpDZQPccLcS4ra6jwiSE3E+xZUJ19SQKO+I8ZGwaRI71dPYBdYHSqD7vktzI9AnjwWoPaiMf9PnphbFHjj8rhLj0DCThjDr4yRok3iq8MrjYTdbZS/WDh
X-Forefront-PRVS: 08213D42D3
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB5221;23:PlPWdTpxDzVFrDz/DWzyapljhzuk7h9SRsCT46nIA?=
 =?us-ascii?Q?RGnZsGMHrWdcUnWSakM5efIopQfpObbjVBSTzKLMGEHi6HAF3Cq5TRH6sniw?=
 =?us-ascii?Q?6E6Uf3A9h/kHf6h3o15GqpXysDa3qljWpc6/rcmOQEXWj/UQMXirSIT2YHzD?=
 =?us-ascii?Q?lFCmQo/XJEgMv79DZO/qNQX7xnGNHm8cRPMwUtA+N81TfIbAccIhQkCej9Ly?=
 =?us-ascii?Q?pRX05LWtzfq/YHzXHD38W1SP+Ma9eyY2dfzLqv3rAU8vTZuFb0Akh3SFwVRD?=
 =?us-ascii?Q?WVSej+yOQ+OCaT6IjtdRZafinQ0Tz8ka1xXJmQca2LXk4xAJuVELEm8DS8V8?=
 =?us-ascii?Q?OcEQ/3i6s2euciAM2vwYgB1DPl78UXeaKxXhJoDLs5AbTlm48gF/dsmxd6tK?=
 =?us-ascii?Q?ugdO4Rl/yl8R0e802vTMtcQ6fhj4frJKRR3UHwrnq+TKRaLOrnNKTTsbqTZj?=
 =?us-ascii?Q?dbPXqaem06njWrnVxFdqOkUA4tEejWdpQlI7ew8sNgbxCL9vGDpdugL7iHWS?=
 =?us-ascii?Q?AlKUOdYQCXgPKou/QHyCDwxukF9w2jorHV3SpQ+XdycIDqMIJuOoGVKCcCIS?=
 =?us-ascii?Q?y7bneAvCwOF1ZT95m1CVPzeij2PhNjaLzP93/nBJy+rzrhRb8KjtuKVIU5uP?=
 =?us-ascii?Q?+nkHspzqcZjaOaX67tZOsxMS5LwgvJc+jJrZZOs0/+X4LysS0H89graeXWcK?=
 =?us-ascii?Q?2Vp8PJ1pFsReWi1Pvo7qWBnITVIe62+f+vGEiNUiiHe2SE5FlFaSGxPn6ogw?=
 =?us-ascii?Q?0TPiNzAk1aPaAD0YpU9IWoL5/gWxcZVWJSZg4sTlodbOAzFw56SLt+G8tLoz?=
 =?us-ascii?Q?eweZnL1138QV6qF2lzX2rl9fxFtDBkiqIGbKUOElbgGEPgOAwe8wb/2alNW0?=
 =?us-ascii?Q?AmCq3zc9ZeAkOClSDjjJwKiezKI6JeYXKj6yIH71RiWXzcC8fLcpb6S8cwAM?=
 =?us-ascii?Q?/3DdsmiCs7Ekf3U7Ar5s8qSNUvGtida9aqRvMfM0x6c5Otd6nliiCEcifcFx?=
 =?us-ascii?Q?gE0D39cr0yFJmlUYXTk4//I9OrzmL0EjXNp7QmroBO4oTVaEc2zFefOlneif?=
 =?us-ascii?Q?Tl2C9hvG2eTeNY58q6QLcvdikGJM2Q+pq7FfDWhAJzEEK3dPMxrU61HjZh2t?=
 =?us-ascii?Q?v9305xSN7DmqX55B+7tptdm+KYv0VHltJlrkHN8Y/aOtxfVVwov/Y/vo9qmG?=
 =?us-ascii?Q?6cy+RQIilLA6EJZR756c/nlAiZUi0Ila6Z4nNAdX9SP7zSF5rulaVxcqaS0B?=
 =?us-ascii?Q?TeNEoR4cN3LVf0aIKEQr2Vz1W6cnrEkTL3UjnPKbw4gPThywLlX4gr6ZlnJz?=
 =?us-ascii?Q?E3vsJ5jhQduE6n+1mXlo+UdgXc8JocFCLhYSagPS3d9?=
X-Microsoft-Antispam-Message-Info: wQXZ/rRfbl+sMJf686Ned7kkqLbI/iOLtIL8nP9Ak+gKNp40kkTI1sT74gXIsaoqgWLn/vx7IYUxspNgR20H1ZieJOZDqK2vxRZ2sNoujyG9awLYZeXflEcVCxAeY0aeSk0AKtG8Y65iyLQ4Yk1GTkkVO0Jy5E6a4tmJUt/nIiYt+2a3E4ryCC8fkx2PDZDCGwdCCgzEIcKQWwqDY+t7g5n9N8grVyQQbyrOakmwG3sZVWQxomUavvIM5hxeWi1RLcRj8xIVRnVGHPTkG68CXqmpUCQRwt8ymbwV6HAq3TaOvk3Rr3Umz2EwtkQBykk1x7TKDZBH+50i98GrhOsBYK2rUkAiG3wpUAQJaJvnjHc=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB5221;6:wg8c4BiJWj331HDYZt9MNFzdVaYvUvYuVfuPYHLc+wl/6NXKs1NrBZSCSJnkSWDZiY9wEpLsnLaU6ThlIjtGzaFYStwymmxzYA7kbUnHEx7K7eF7Qe21+72nHO9mImN+blyhcrVTScrRyiKJbl9Q0IVhqMjYu5T/wJy4s1w6mrElontW/+9VlpDALilwUJHvHMMTLzV8WV/Ik+VYsKw4PFgBAz3OFp9uwRJmnNlucwRO1O3tZrMeFSyXjPc1k9urYUYR3wloQNY08ZAMhoZFY0QuPht4r+O90VlB3yyJeCf7tO52vjDhkR7unrzwkkqaxfDiYcxZmbcHUNOokka5YrPjbCoohTJFXaGkE08WV4MsU+kGxjwBnEFq+bGUcZy/VQC8R8c5VXTDLv9tB5dbBd3vYF7e8PtLNaL6KTw84jxwH2ahR8iydc7f6npbIlzwWJbXTGOXw8vOBOW0u/IFRg==;5:1EP6BCwR7gVc9YtQ8rW2KS/TouhQFodDaBF6Ge1OMUld7gIBpExbCVWeMB9VZbdsdhBrkE91rf0j+T5rL4URzo+RxSF6hPFrSqfutdD3JNhew/DJtpDF3j7RI4N8kZLuePW0coYKRWK6DF0YtUiXsdfqBP8qaMv0IhbKNfKeIwc=;7:0UQV2gDJkVGnhGli7ik2O84eYDSoXZQjHIVKWqelir1KM1EsmO1q6JfCkbFFsOkwsJ599fUV3y5HK2KfQUKaZ2mHigLAhBUqqvHuAArjgYL9S3oSp7E4fW4zG5hzxXaJHq+syGioqArLWRfiF3h8c5sqM6u5NyY52ngnDHipV0XShix6p0bfHNeo9wziRb8i2wy2TfgLr8ZJG655JgwVMPvkj6ONH/CgO+97D6JQyOCFFgyexvUBWUUmzYQz+IkR
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2018 07:18:51.7257
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c0617de-29d1-48b4-b564-08d62e80a193
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5221
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is to introduce ZynqMP IPI mailbox controller driver
to use the ZynqMP IPI block as mailboxes.

Signed-off-by: Wendy Liang <wendy.liang@xilinx.com>
---
 drivers/mailbox/Kconfig                    |   8 +
 drivers/mailbox/Makefile                   |   2 +
 drivers/mailbox/zynqmp-ipi-mailbox.c       | 762 +++++++++++++++++++++++++++++
 include/linux/mailbox/zynqmp-ipi-message.h |  24 +
 4 files changed, 796 insertions(+)
 create mode 100644 drivers/mailbox/zynqmp-ipi-mailbox.c
 create mode 100644 include/linux/mailbox/zynqmp-ipi-message.h

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index 841c005..b1a006b 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -205,4 +205,12 @@ config MTK_CMDQ_MBOX
 	  mailbox driver. The CMDQ is used to help read/write registers with
 	  critical time limitation, such as updating display configuration
 	  during the vblank.
+
+config ZYNQMP_IPI_MBOX
+	tristate "Xilinx ZynqMP IPI Mailbox"
+	depends on ARCH_ZYNQMP && OF
+	help
+	  Mailbox implementation for Xilinx ZynqMP IPI. It is used to send
+	  notification or short message between processors with Xilinx
+	  ZynqMP IPI.
 endif
diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
index c818b5d..bb3d604 100644
--- a/drivers/mailbox/Makefile
+++ b/drivers/mailbox/Makefile
@@ -44,3 +44,5 @@ obj-$(CONFIG_TEGRA_HSP_MBOX)	+= tegra-hsp.o
 obj-$(CONFIG_STM32_IPCC) 	+= stm32-ipcc.o
 
 obj-$(CONFIG_MTK_CMDQ_MBOX)	+= mtk-cmdq-mailbox.o
+
+obj-$(CONFIG_ZYNQMP_IPI_MBOX)  += zynqmp-ipi-mailbox.o
diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/zynqmp-ipi-mailbox.c
new file mode 100644
index 0000000..6a2e0fc
--- /dev/null
+++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
@@ -0,0 +1,762 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Inter Processor Interrupt(IPI) Mailbox Driver
+ *
+ * Copyright (C) 2018 Xilinx Inc.
+ *
+ */
+
+#include <linux/arm-smccc.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/mailbox_controller.h>
+#include <linux/mailbox/zynqmp-ipi-message.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/of_irq.h>
+#include <linux/platform_device.h>
+
+/* IPI agent ID any */
+#define IPI_ID_ANY 0xFFUL
+
+/* indicate if ZynqMP IPI mailbox driver uses SMC calls or HVC calls */
+#define USE_SMC 0
+#define USE_HVC 1
+
+/* Default IPI SMC function IDs */
+#define SMC_IPI_MAILBOX_OPEN            0x82001000U
+#define SMC_IPI_MAILBOX_RELEASE         0x82001001U
+#define SMC_IPI_MAILBOX_STATUS_ENQUIRY  0x82001002U
+#define SMC_IPI_MAILBOX_NOTIFY          0x82001003U
+#define SMC_IPI_MAILBOX_ACK             0x82001004U
+#define SMC_IPI_MAILBOX_ENABLE_IRQ      0x82001005U
+#define SMC_IPI_MAILBOX_DISABLE_IRQ     0x82001006U
+
+/* IPI SMC Macros */
+#define IPI_SMC_OPEN_IRQ_MASK		0x00000001UL /* IRQ enable bit in IPI
+						      * open SMC call
+						      */
+#define IPI_SMC_NOTIFY_BLOCK_MASK	0x00000001UL /* Flag to indicate if
+						      * IPI notification needs
+						      * to be blocking.
+						      */
+#define IPI_SMC_ENQUIRY_DIRQ_MASK       0x00000001UL /* Flag to indicate if
+						      * notification interrupt
+						      * to be disabled.
+						      */
+#define IPI_SMC_ACK_EIRQ_MASK           0x00000001UL /* Flag to indicate if
+						      * notification interrupt
+						      * to be enabled.
+						      */
+
+/* IPI mailbox status */
+#define IPI_MB_STATUS_IDLE              0
+#define IPI_MB_STATUS_SEND_PENDING      1
+#define IPI_MB_STATUS_RECV_PENDING      2
+
+#define IPI_MB_CHNL_TX 0 /* IPI mailbox TX channel */
+#define IPI_MB_CHNL_RX 1 /* IPI mailbox RX channel */
+
+/**
+ * struct zynqmp_ipi_mchan - Description of a Xilinx ZynqMP IPI mailbox channel
+ * @is_opened: indicate if the IPI channel is opened
+ * @req_buf: local to remote request buffer start address
+ * @resp_buf: local to remote response buffer start address
+ * @req_buf_size: request buffer size
+ * @resp_buf_size: response buffer size
+ * @rx_buf: receive buffer to pass received message to client
+ * @chan_type: channel type
+ */
+struct zynqmp_ipi_mchan {
+	int is_opened;
+	void __iomem *req_buf;
+	void __iomem *resp_buf;
+	void *rx_buf;
+	size_t req_buf_size;
+	size_t resp_buf_size;
+	unsigned int chan_type;
+};
+
+/**
+ * struct zynqmp_ipi_mbox - Description of a ZynqMP IPI mailbox
+ *                          platform data.
+ * @pdata:		  pointer to the IPI private data
+ * @dev:                  device pointer corresponding to the Xilinx ZynqMP
+ *                        IPI mailbox
+ * @remote_id:            remote IPI agent ID
+ * @mbox:                 mailbox Controller
+ * @mchans:               array for channels, tx channel and rx channel.
+ * @irq:                  IPI agent interrupt ID
+ */
+struct zynqmp_ipi_mbox {
+	struct zynqmp_ipi_pdata *pdata;
+	struct device dev;
+	u32 remote_id;
+	struct mbox_controller mbox;
+	struct zynqmp_ipi_mchan mchans[2];
+};
+
+/**
+ * struct zynqmp_ipi_pdata - Description of z ZynqMP IPI agent platform data.
+ *
+ * @dev:                  device pointer corresponding to the Xilinx ZynqMP
+ *                        IPI agent
+ * @irq:                  IPI agent interrupt ID
+ * @method:               IPI SMC or HVC is going to be used
+ * @local_id:             local IPI agent ID
+ * @ipi_mboxes:           IPI mailboxes of this IPI agent
+ */
+struct zynqmp_ipi_pdata {
+	struct device *dev;
+	int irq;
+	unsigned int method;
+	u32 local_id;
+	int num_mboxes;
+	struct zynqmp_ipi_mbox *ipi_mboxes;
+};
+
+static struct device_driver zynqmp_ipi_mbox_driver = {
+	.owner = THIS_MODULE,
+	.name = "zynqmp-ipi-mbox",
+};
+
+static void zynqmp_ipi_fw_call(struct zynqmp_ipi_mbox *ipi_mbox,
+			       unsigned long a0, unsigned long a3,
+			       unsigned long a4, unsigned long a5,
+			       unsigned long a6, unsigned long a7,
+			       struct arm_smccc_res *res)
+{
+	struct zynqmp_ipi_pdata *pdata = ipi_mbox->pdata;
+	unsigned long a1, a2;
+
+	a1 = pdata->local_id;
+	a2 = ipi_mbox->remote_id;
+	if (pdata->method == USE_SMC)
+		arm_smccc_smc(a0, a1, a2, a3, a4, a5, a6, a7, res);
+	else
+		arm_smccc_hvc(a0, a1, a2, a3, a4, a5, a6, a7, res);
+}
+
+/**
+ * zynqmp_ipi_interrupt - Interrupt handler for IPI notification
+ *
+ * @irq:  Interrupt number
+ * @data: ZynqMP IPI mailbox platform data.
+ *
+ * Return: -EINVAL if there is no instance
+ * IRQ_NONE if the interrupt is not ours.
+ * IRQ_HANDLED if the rx interrupt was successfully handled.
+ */
+static irqreturn_t zynqmp_ipi_interrupt(int irq, void *data)
+{
+	struct zynqmp_ipi_pdata *pdata = data;
+	struct mbox_chan *chan;
+	struct zynqmp_ipi_mbox *ipi_mbox;
+	struct zynqmp_ipi_mchan *mchan;
+	struct zynqmp_ipi_message *msg;
+	u64 arg0, arg3;
+	struct arm_smccc_res res;
+	int ret, i;
+
+	arg0 = SMC_IPI_MAILBOX_STATUS_ENQUIRY;
+	arg3 = IPI_SMC_ENQUIRY_DIRQ_MASK;
+	for (i = 0; i < pdata->num_mboxes; i++) {
+		ipi_mbox = &pdata->ipi_mboxes[i];
+		mchan = &ipi_mbox->mchans[IPI_MB_CHNL_RX];
+		chan = &ipi_mbox->mbox.chans[IPI_MB_CHNL_RX];
+		zynqmp_ipi_fw_call(ipi_mbox, arg0, arg3, 0, 0, 0, 0, &res);
+		ret = (int)(res.a0 & 0xFFFFFFFF);
+		if (ret > 0 && ret & IPI_MB_STATUS_RECV_PENDING) {
+			if (mchan->is_opened) {
+				msg = mchan->rx_buf;
+				msg->len = mchan->req_buf_size;
+				memcpy_fromio(msg->data, mchan->req_buf,
+					      msg->len);
+				mbox_chan_received_data(chan, (void *)msg);
+				return IRQ_HANDLED;
+			}
+		}
+	}
+	return IRQ_NONE;
+}
+
+/**
+ * zynqmp_ipi_peek_data - Peek to see if there are any rx messages.
+ *
+ * @chan: Channel Pointer
+ *
+ * Return: 'true' if there is pending rx data, 'false' if there is none.
+ */
+static bool zynqmp_ipi_peek_data(struct mbox_chan *chan)
+{
+	struct device *dev = chan->mbox->dev;
+	struct zynqmp_ipi_mbox *ipi_mbox = dev_get_drvdata(dev);
+	struct zynqmp_ipi_mchan *mchan = chan->con_priv;
+	int ret;
+	u64 arg0;
+	struct arm_smccc_res res;
+
+	if (WARN_ON(!ipi_mbox)) {
+		dev_err(dev, "no platform drv data??\n");
+		return false;
+	}
+
+	arg0 = SMC_IPI_MAILBOX_STATUS_ENQUIRY;
+	zynqmp_ipi_fw_call(ipi_mbox, arg0, 0, 0, 0, 0, 0, &res);
+	ret = (int)(res.a0 & 0xFFFFFFFF);
+
+	if (mchan->chan_type == IPI_MB_CHNL_TX) {
+		/* TX channel, check if the message has been acked
+		 * by the remote, if yes, response is available.
+		 */
+		if (ret < 0 || ret & IPI_MB_STATUS_SEND_PENDING)
+			return false;
+		else
+			return true;
+	} else if (ret > 0 && ret & IPI_MB_STATUS_RECV_PENDING) {
+		/* RX channel, check if there is message arrived. */
+		return true;
+	}
+	return false;
+}
+
+/**
+ * zynqmp_ipi_last_tx_done - See if the last tx message is sent
+ *
+ * @chan: Channel pointer
+ *
+ * Return: 'true' is no pending tx data, 'false' if there are any.
+ */
+static bool zynqmp_ipi_last_tx_done(struct mbox_chan *chan)
+{
+	struct device *dev = chan->mbox->dev;
+	struct zynqmp_ipi_mbox *ipi_mbox = dev_get_drvdata(dev);
+	struct zynqmp_ipi_mchan *mchan = chan->con_priv;
+	int ret;
+	u64 arg0;
+	struct arm_smccc_res res;
+	struct zynqmp_ipi_message *msg;
+
+	if (WARN_ON(!ipi_mbox)) {
+		dev_err(dev, "no platform drv data??\n");
+		return false;
+	}
+
+	if (mchan->chan_type == IPI_MB_CHNL_TX) {
+		/* We only need to check if the message been taken
+		 * by the remote in the TX channel
+		 */
+		arg0 = SMC_IPI_MAILBOX_STATUS_ENQUIRY;
+		zynqmp_ipi_fw_call(ipi_mbox, arg0, 0, 0, 0, 0, 0, &res);
+		/* Check the SMC call status, a0 of the result */
+		ret = (int)(res.a0 & 0xFFFFFFFF);
+		if (ret < 0 || ret & IPI_MB_STATUS_SEND_PENDING)
+			return false;
+
+		msg = mchan->rx_buf;
+		msg->len = mchan->resp_buf_size;
+		memcpy_fromio(msg->data, mchan->resp_buf, msg->len);
+		mbox_chan_received_data(chan, (void *)msg);
+		return true;
+	}
+	/* Always true for the response message in RX channel */
+	return true;
+}
+
+/**
+ * zynqmp_ipi_send_data - Send data
+ *
+ * @chan: Channel Pointer
+ * @data: Message Pointer
+ *
+ * Return: 0 if all goes good, else appropriate error messages.
+ */
+static int zynqmp_ipi_send_data(struct mbox_chan *chan, void *data)
+{
+	struct device *dev = chan->mbox->dev;
+	struct zynqmp_ipi_mbox *ipi_mbox = dev_get_drvdata(dev);
+	struct zynqmp_ipi_mchan *mchan = chan->con_priv;
+	struct zynqmp_ipi_message *msg = data;
+	u64 arg0;
+	struct arm_smccc_res res;
+	u32 timeout;
+	int ret;
+
+	if (WARN_ON(!ipi_mbox)) {
+		dev_err(dev, "no platform drv data??\n");
+		return -EINVAL;
+	}
+
+	if (mchan->chan_type == IPI_MB_CHNL_TX) {
+		/* Send request message */
+		if (msg && msg->len > mchan->req_buf_size) {
+			dev_err(dev, "channel %d message length %u > max %lu\n",
+				mchan->chan_type, (unsigned int)msg->len,
+				mchan->req_buf_size);
+			return -EINVAL;
+		}
+		/* Enquire if the mailbox is free to send message */
+		arg0 = SMC_IPI_MAILBOX_STATUS_ENQUIRY;
+		timeout = 10;
+		if (msg && msg->len) {
+			timeout = 10;
+			do {
+				zynqmp_ipi_fw_call(ipi_mbox, arg0,
+						   0, 0, 0, 0, 0, &res);
+				ret = res.a0 & 0xFFFFFFFF;
+				if (ret >= 0 &&
+				    !(ret & IPI_MB_STATUS_SEND_PENDING))
+					break;
+				usleep_range(1, 2);
+				timeout--;
+			} while (timeout);
+			if (!timeout) {
+				dev_warn(dev, "chan %d sending msg timeout.\n",
+					 ipi_mbox->remote_id);
+				return -ETIME;
+			}
+			memcpy_toio(mchan->req_buf, msg->data, msg->len);
+		}
+		/* Kick IPI mailbox to send message */
+		arg0 = SMC_IPI_MAILBOX_NOTIFY;
+		zynqmp_ipi_fw_call(ipi_mbox, arg0, 0, 0, 0, 0, 0, &res);
+	} else {
+		/* Send response message */
+		if (msg && msg->len > mchan->resp_buf_size) {
+			dev_err(dev, "channel %d message length %u > max %lu\n",
+				mchan->chan_type, (unsigned int)msg->len,
+				mchan->resp_buf_size);
+			return -EINVAL;
+		}
+		if (msg && msg->len)
+			memcpy(mchan->resp_buf, msg->data, msg->len);
+		arg0 = SMC_IPI_MAILBOX_NOTIFY;
+		arg0 = SMC_IPI_MAILBOX_ACK;
+		zynqmp_ipi_fw_call(ipi_mbox, arg0, IPI_SMC_ACK_EIRQ_MASK,
+				   0, 0, 0, 0, &res);
+	}
+	return 0;
+}
+
+/**
+ * zynqmp_ipi_startup - Startup the IPI channel
+ *
+ * @chan: Channel pointer
+ *
+ * Return: 0 if all goes good, else return corresponding error message
+ */
+static int zynqmp_ipi_startup(struct mbox_chan *chan)
+{
+	struct device *dev = chan->mbox->dev;
+	struct zynqmp_ipi_mbox *ipi_mbox = dev_get_drvdata(dev);
+	struct zynqmp_ipi_mchan *mchan = chan->con_priv;
+	u64 arg0;
+	struct arm_smccc_res res;
+	int ret = 0;
+	unsigned int nchan_type;
+
+	if (mchan->is_opened)
+		return 0;
+
+	/* If no channel has been opened, open the IPI mailbox */
+	nchan_type = (mchan->chan_type + 1) % 2;
+	if (!ipi_mbox->mchans[nchan_type].is_opened) {
+		arg0 = SMC_IPI_MAILBOX_OPEN;
+		zynqmp_ipi_fw_call(ipi_mbox, arg0, 0, 0, 0, 0, 0, &res);
+		/* Check the SMC call status, a0 of the result */
+		ret = (int)(res.a0 | 0xFFFFFFFF);
+		if (res.a0 < 0) {
+			dev_err(dev, "SMC to open the IPI channel failed.\n");
+			ret = res.a0;
+			return ret;
+		}
+		ret = 0;
+	}
+
+	/* If it is RX channel, enable the IPI notification interrupt */
+	if (mchan->chan_type == IPI_MB_CHNL_RX) {
+		arg0 = SMC_IPI_MAILBOX_ENABLE_IRQ;
+		zynqmp_ipi_fw_call(ipi_mbox, arg0, 0, 0, 0, 0, 0, &res);
+	}
+	mchan->is_opened = 1;
+
+	return ret;
+}
+
+/**
+ * zynqmp_ipi_shutdown - Shutdown the IPI channel
+ *
+ * @chan: Channel pointer
+ */
+static void zynqmp_ipi_shutdown(struct mbox_chan *chan)
+{
+	struct device *dev = chan->mbox->dev;
+	struct zynqmp_ipi_mbox *ipi_mbox = dev_get_drvdata(dev);
+	struct zynqmp_ipi_mchan *mchan = chan->con_priv;
+	u64 arg0;
+	struct arm_smccc_res res;
+	unsigned int chan_type;
+
+	if (!mchan->is_opened)
+		return;
+
+	/* If it is RX channel, disable notification interrupt */
+	chan_type = mchan->chan_type;
+	if (chan_type == IPI_MB_CHNL_RX) {
+		arg0 = SMC_IPI_MAILBOX_DISABLE_IRQ;
+		zynqmp_ipi_fw_call(ipi_mbox, arg0, 0, 0, 0, 0, 0, &res);
+	}
+	/* Release IPI mailbox if no other channel is opened */
+	chan_type = (chan_type + 1) % 2;
+	if (!ipi_mbox->mchans[chan_type].is_opened) {
+		arg0 = SMC_IPI_MAILBOX_RELEASE;
+		zynqmp_ipi_fw_call(ipi_mbox, arg0, 0, 0, 0, 0, 0, &res);
+	}
+
+	mchan->is_opened = 0;
+}
+
+/* ZynqMP IPI mailbox operations */
+static const struct mbox_chan_ops zynqmp_ipi_chan_ops = {
+	.startup = zynqmp_ipi_startup,
+	.shutdown = zynqmp_ipi_shutdown,
+	.peek_data = zynqmp_ipi_peek_data,
+	.last_tx_done = zynqmp_ipi_last_tx_done,
+	.send_data = zynqmp_ipi_send_data,
+};
+
+/**
+ * zynqmp_ipi_of_xlate - Translate of phandle to IPI mailbox channel
+ *
+ * @mbox: mailbox controller pointer
+ * @p:    phandle pointer
+ *
+ * Return: Mailbox channel, else return error pointer.
+ */
+static struct mbox_chan *zynqmp_ipi_of_xlate(struct mbox_controller *mbox,
+					     const struct of_phandle_args *p)
+{
+	struct mbox_chan *chan;
+	struct device *dev = mbox->dev;
+	unsigned int chan_type;
+
+	/* Only supports TX and RX channels */
+	chan_type = p->args[0];
+	if (chan_type != IPI_MB_CHNL_TX && chan_type != IPI_MB_CHNL_RX) {
+		dev_err(dev, "req chnl failure: invalid chnl type %u.\n",
+			chan_type);
+		return ERR_PTR(-EINVAL);
+	}
+	chan = &mbox->chans[chan_type];
+	return chan;
+}
+
+static const struct of_device_id zynqmp_ipi_of_match[] = {
+	{.compatible = "xlnx,zynqmp-ipi-mailbox"},
+};
+MODULE_DEVICE_TABLE(of, zynqmp_ipi_of_match);
+
+/**
+ * zynqmp_ipi_mbox_get_buf_res - Get buffer resource from the IPI dev node
+ *
+ * @node: IPI mbox device child node
+ * @name: name of the IPI buffer
+ * @res: pointer to where the resource information will be stored.
+ *
+ * Return: 0 for success, negative value for failure
+ */
+static int zynqmp_ipi_mbox_get_buf_res(struct device_node *node,
+				       const char *name,
+				       struct resource *res)
+{
+	int ret, index;
+
+	index = of_property_match_string(node, "reg-names", name);
+	if (index >= 0) {
+		ret = of_address_to_resource(node, index, res);
+		if (ret < 0)
+			return -EINVAL;
+		return 0;
+	}
+	return -ENODEV;
+}
+
+/**
+ * zynqmp_ipi_mbox_dev_release() - release the existence of a ipi mbox dev
+ *
+ * This is to avoid the no device release() function kernel warning.
+ *
+ * @dev: the ipi mailbox device
+ */
+static void zynqmp_ipi_mbox_dev_release(struct device *dev)
+{
+	(void)dev;
+}
+
+/**
+ * zynqmp_ipi_mbox_probe - probe IPI mailbox resource from device node
+ *
+ * @ipi_mbox: pointer to IPI mailbox private data structure
+ * @node: IPI mailbox device node
+ *
+ * Return: 0 for success, negative value for failure
+ */
+static int zynqmp_ipi_mbox_probe(struct zynqmp_ipi_mbox *ipi_mbox,
+				 struct device_node *node)
+{
+	struct zynqmp_ipi_mchan *mchan;
+	struct mbox_chan *chans;
+	struct mbox_controller *mbox;
+	struct resource res;
+	struct device *dev, *mdev;
+	const char *name;
+	int ret;
+
+	dev = ipi_mbox->pdata->dev;
+	/* Initialize dev for IPI mailbox */
+	ipi_mbox->dev.parent = dev;
+	ipi_mbox->dev.release = NULL;
+	ipi_mbox->dev.of_node = node;
+	dev_set_name(&ipi_mbox->dev, "%s", of_node_full_name(node));
+	dev_set_drvdata(&ipi_mbox->dev, ipi_mbox);
+	ipi_mbox->dev.release = zynqmp_ipi_mbox_dev_release;
+	ipi_mbox->dev.driver = &zynqmp_ipi_mbox_driver;
+	ret = device_register(&ipi_mbox->dev);
+	if (ret) {
+		dev_err(dev, "Failed to register ipi mbox dev.\n");
+		return ret;
+	}
+	mdev = &ipi_mbox->dev;
+
+	mchan = &ipi_mbox->mchans[IPI_MB_CHNL_TX];
+	name = "local_request_region";
+	ret = zynqmp_ipi_mbox_get_buf_res(node, name, &res);
+	if (!ret) {
+		mchan->req_buf_size = resource_size(&res);
+		mchan->req_buf = devm_ioremap(mdev, res.start,
+					      mchan->req_buf_size);
+		if (IS_ERR(mchan->req_buf)) {
+			dev_err(dev, "Unable to map IPI buffer I/O memory\n");
+			ret = PTR_ERR(mchan->req_buf);
+			return ret;
+		}
+	} else if (ret != -ENODEV) {
+		dev_err(mdev, "Unmatched resource %s, %d.\n", name, ret);
+		return ret;
+	}
+
+	name = "remote_response_region";
+	ret = zynqmp_ipi_mbox_get_buf_res(node, name, &res);
+	if (!ret) {
+		mchan->resp_buf_size = resource_size(&res);
+		mchan->resp_buf = devm_ioremap(mdev, res.start,
+					       mchan->resp_buf_size);
+		if (IS_ERR(mchan->resp_buf)) {
+			dev_err(mdev, "Unable to map IPI buffer I/O memory\n");
+			ret = PTR_ERR(mchan->resp_buf);
+			return ret;
+		}
+	} else if (ret != -ENODEV) {
+		dev_err(mdev, "Unmatched resource %s.\n", name);
+		return ret;
+	}
+	mchan->rx_buf = devm_kzalloc(mdev,
+				     mchan->resp_buf_size +
+				     sizeof(struct zynqmp_ipi_message),
+				     GFP_KERNEL);
+	if (!mchan->rx_buf)
+		return -ENOMEM;
+
+	mchan = &ipi_mbox->mchans[IPI_MB_CHNL_RX];
+	name = "remote_request_region";
+	ret = zynqmp_ipi_mbox_get_buf_res(node, name, &res);
+	if (!ret) {
+		mchan->req_buf_size = resource_size(&res);
+		mchan->req_buf = devm_ioremap(mdev, res.start,
+					      mchan->req_buf_size);
+		if (IS_ERR(mchan->req_buf)) {
+			dev_err(mdev, "Unable to map IPI buffer I/O memory\n");
+			ret = PTR_ERR(mchan->req_buf);
+			return ret;
+		}
+	} else if (ret != -ENODEV) {
+		dev_err(mdev, "Unmatched resource %s.\n", name);
+		return ret;
+	}
+
+	name = "local_response_region";
+	ret = zynqmp_ipi_mbox_get_buf_res(node, name, &res);
+	if (!ret) {
+		mchan->resp_buf_size = resource_size(&res);
+		mchan->resp_buf = devm_ioremap(mdev, res.start,
+					       mchan->resp_buf_size);
+		if (IS_ERR(mchan->resp_buf)) {
+			dev_err(mdev, "Unable to map IPI buffer I/O memory\n");
+			ret = PTR_ERR(mchan->resp_buf);
+			return ret;
+		}
+	} else if (ret != -ENODEV) {
+		dev_err(mdev, "Unmatched resource %s.\n", name);
+		return ret;
+	}
+	mchan->rx_buf = devm_kzalloc(mdev,
+				     mchan->resp_buf_size +
+				     sizeof(struct zynqmp_ipi_message),
+				     GFP_KERNEL);
+	if (!mchan->rx_buf)
+		return -ENOMEM;
+
+	/* Get the IPI remote agent ID */
+	ret = of_property_read_u32(node, "xlnx,ipi-id", &ipi_mbox->remote_id);
+	if (ret < 0) {
+		dev_err(dev, "No IPI remote ID is specified.\n");
+		return ret;
+	}
+
+	mbox = &ipi_mbox->mbox;
+	mbox->dev = mdev;
+	mbox->ops = &zynqmp_ipi_chan_ops;
+	mbox->num_chans = 2;
+	mbox->txdone_irq = false;
+	mbox->txdone_poll = true;
+	mbox->txpoll_period = 5;
+	mbox->of_xlate = zynqmp_ipi_of_xlate;
+	chans = devm_kzalloc(mdev, 2 * sizeof(*chans), GFP_KERNEL);
+	if (!chans)
+		return -ENOMEM;
+	mbox->chans = chans;
+	chans[IPI_MB_CHNL_TX].con_priv = &ipi_mbox->mchans[IPI_MB_CHNL_TX];
+	chans[IPI_MB_CHNL_RX].con_priv = &ipi_mbox->mchans[IPI_MB_CHNL_RX];
+	ipi_mbox->mchans[IPI_MB_CHNL_TX].chan_type = IPI_MB_CHNL_TX;
+	ipi_mbox->mchans[IPI_MB_CHNL_RX].chan_type = IPI_MB_CHNL_RX;
+	ret = mbox_controller_register(mbox);
+	if (ret)
+		dev_err(mdev,
+			"Failed to register mbox_controller(%d)\n", ret);
+	else
+		dev_info(mdev, "Probed ZynqMP IPI Mailbox driver.\n");
+	return ret;
+}
+
+/**
+ * zynqmp_ipi_free_mboxes - Free IPI mailboxes devices
+ *
+ * @pdata: IPI private data
+ */
+static void zynqmp_ipi_free_mboxes(struct zynqmp_ipi_pdata *pdata)
+{
+	struct zynqmp_ipi_mbox *ipi_mbox;
+	int i;
+
+	i = pdata->num_mboxes;
+	for (; i >= 0; i--) {
+		ipi_mbox = &pdata->ipi_mboxes[i];
+		if (ipi_mbox->dev.parent) {
+			mbox_controller_unregister(&ipi_mbox->mbox);
+			device_unregister(&ipi_mbox->dev);
+		}
+	}
+}
+
+static int zynqmp_ipi_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *nc, *np = pdev->dev.of_node;
+	struct zynqmp_ipi_pdata *pdata;
+	struct zynqmp_ipi_mbox *mbox;
+	int i, ret = -EINVAL;
+
+	i = 0;
+	for_each_available_child_of_node(np, nc)
+		i++;
+	pdata = devm_kzalloc(dev, sizeof(*pdata) + (i * sizeof(*mbox)),
+			     GFP_KERNEL);
+	if (!pdata)
+		return -ENOMEM;
+	pdata->dev = dev;
+
+	/* Get the IPI local agents ID */
+	ret = of_property_read_u32(np, "xlnx,ipi-id", &pdata->local_id);
+	if (ret < 0) {
+		dev_err(dev, "No IPI local ID is specified.\n");
+		return ret;
+	}
+
+	pdata->num_mboxes = i;
+	pdata->ipi_mboxes = (struct zynqmp_ipi_mbox *)
+			    ((char *)pdata + sizeof(*pdata));
+
+	mbox = pdata->ipi_mboxes;
+	for_each_available_child_of_node(np, nc) {
+		mbox->pdata = pdata;
+		ret = zynqmp_ipi_mbox_probe(mbox, nc);
+		if (ret) {
+			dev_err(dev, "failed to probe subdev.\n");
+			ret = -EINVAL;
+			goto free_mbox_dev;
+		}
+		mbox++;
+	}
+
+	/* IPI IRQ */
+	ret = platform_get_irq(pdev, 0);
+	if (ret < 0) {
+		dev_err(dev, "unable to find IPI IRQ.\n");
+		goto free_mbox_dev;
+	}
+	pdata->irq = ret;
+	ret = devm_request_irq(dev, pdata->irq, zynqmp_ipi_interrupt,
+			       IRQF_SHARED, dev_name(dev), pdata);
+	if (ret) {
+		dev_err(dev, "IRQ %d is not requested successfully.\n",
+			pdata->irq);
+		goto free_mbox_dev;
+	}
+
+	platform_set_drvdata(pdev, pdata);
+	return ret;
+
+free_mbox_dev:
+	zynqmp_ipi_free_mboxes(pdata);
+	return ret;
+}
+
+static int zynqmp_ipi_remove(struct platform_device *pdev)
+{
+	struct zynqmp_ipi_pdata *pdata;
+
+	pdata = platform_get_drvdata(pdev);
+	zynqmp_ipi_free_mboxes(pdata);
+
+	return 0;
+}
+
+static struct platform_driver zynqmp_ipi_driver = {
+	.probe = zynqmp_ipi_probe,
+	.remove = zynqmp_ipi_remove,
+	.driver = {
+		   .name = "zynqmp-ipi",
+		   .of_match_table = of_match_ptr(zynqmp_ipi_of_match),
+	},
+};
+
+static int __init zynqmp_ipi_init(void)
+{
+	return platform_driver_register(&zynqmp_ipi_driver);
+}
+subsys_initcall(zynqmp_ipi_init);
+
+static void __exit zynqmp_ipi_exit(void)
+{
+	platform_driver_unregister(&zynqmp_ipi_driver);
+}
+module_exit(zynqmp_ipi_exit);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Xilinx ZynqMP IPI Mailbox driver");
+MODULE_AUTHOR("Xilinx Inc.");
diff --git a/include/linux/mailbox/zynqmp-ipi-message.h b/include/linux/mailbox/zynqmp-ipi-message.h
new file mode 100644
index 0000000..72a9d9d
--- /dev/null
+++ b/include/linux/mailbox/zynqmp-ipi-message.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ *  Copyright (C) 2017 Xilinx Inc.
+ *
+ */
+
+#ifndef _LINUX_ZYNQMP_IPI_MESSAGE_H_
+#define _LINUX_ZYNQMP_IPI_MESSAGE_H_
+
+/**
+ * struct zynqmp_ipi_message - ZynqMP IPI message structure
+ * @len:  Length of the request message
+ * @data: Request message
+ *
+ * This is the structure for data used in mbox_send_message
+ * the maximum length of data buffer is fixed to 12 bytes.
+ * Client is supposed to be aware of this.
+ */
+struct zynqmp_ipi_message {
+	size_t len;
+	u8 data[0];
+};
+
+#endif /* _LINUX_ZYNQMP_IPI_MESSAGE_H_ */
-- 
2.7.4

