Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0350FC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 19:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CFB82147A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 19:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="i4h4JPSV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CFB82147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbeHPWW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 18:22:27 -0400
Received: from mail-eopbgr720078.outbound.protection.outlook.com ([40.107.72.78]:64192
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726016AbeHPWW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 18:22:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pfLcw2e0ApDIPHs8ILsNkSjPcH7L3ncuq8/dk3Zg5Mc=;
 b=i4h4JPSV4nq5JBaAWnDKW8OvNNmn/f9qoOQnK6T0pM2tNiREnQsAjPWoQuFNGgT50hXv7J2e5wwLjshjSTsZFzhDvA9xFcdQpFxuN2wrzmROypBbaHWWjZy9vRHvX5+UBUDoRbKDAyTMOZ/BHhpTg5PfOND89ApheNpc91Lo8gE=
Received: from SN4PR0201CA0008.namprd02.prod.outlook.com
 (2603:10b6:803:2b::18) by BYAPR02MB4455.namprd02.prod.outlook.com
 (2603:10b6:a03:57::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1038.25; Thu, 16 Aug
 2018 19:22:00 +0000
Received: from BL2NAM02FT062.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::207) by SN4PR0201CA0008.outlook.office365.com
 (2603:10b6:803:2b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1059.20 via Frontend
 Transport; Thu, 16 Aug 2018 19:21:59 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT062.mail.protection.outlook.com (10.152.77.57) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1059.14
 via Frontend Transport; Thu, 16 Aug 2018 19:21:59 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fqNqI-0005jt-RC; Thu, 16 Aug 2018 12:21:58 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fqNqD-0007wo-LA; Thu, 16 Aug 2018 12:21:53 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w7GJLoaZ021520;
        Thu, 16 Aug 2018 12:21:50 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1fqNqA-0007vv-0M; Thu, 16 Aug 2018 12:21:50 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <matthias.bgg@gmail.com>, <andy.gross@linaro.org>,
        <shawnguo@kernel.org>, <geert+renesas@glider.be>,
        <bjorn.andersson@linaro.org>, <sean.wang@mediatek.com>,
        <m.szyprowski@samsung.com>, <michal.simek@xilinx.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <rajanv@xilinx.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v2 1/3] dt-bindings: power: Add ZynqMP power domain bindings
Date:   Thu, 16 Aug 2018 12:21:42 -0700
Message-ID: <1534447304-12919-2-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534447304-12919-1-git-send-email-jollys@xilinx.com>
References: <1534447304-12919-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(346002)(376002)(2980300002)(438002)(199004)(189003)(50226002)(110136005)(186003)(316002)(356003)(11346002)(106002)(72206003)(446003)(48376002)(8676002)(77096007)(36386004)(2906002)(476003)(426003)(336012)(50466002)(478600001)(36756003)(305945005)(26005)(486006)(81166006)(81156014)(16586007)(8936002)(2616005)(54906003)(9786002)(126002)(2201001)(76176011)(7696005)(7416002)(39060400002)(106466001)(107886003)(44832011)(51416003)(47776003)(5660300001)(63266004)(6666003)(4326008)(921003)(107986001)(83996005)(1121003)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4455;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT062;1:fz3qC0kOgTL41+2paMC7wMyVnpI9gK2lo9nwni01NQ4u4dTl2CVmKVIwtvM6qT7RY2H/LLoTfwQd7TOvIcVlqd/rdAzArbD2ahTiamLTFLZrDsv0O2EN7XJhBFgq/Mmt
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f50c531-c3b4-4734-a30a-08d603ad89d4
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BYAPR02MB4455;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4455;3:Fo6DotdGUhdNT6xxowV4zIyDAaafVpjfTPOQvNSbNdW/Q9E6jb7ovhsgiwm52b95MGVxHOV1pRLOEl0tDI9/U3wsHvMwi2L/WFSl6IpIRKjpCrVwx5Sdlcu8ROtbeRdIWE899+lnGrHctaJVEBuhSCw2l7ruQX7MrqdoNC3OXklmNnRxxW2Gglycz6c5GY5poAgkwNfos7n/eUaV0b1SOuksk3jDZDtywpaZ2f1BrXzMQFHdBWh81AZ7vLN+2VGoZ2pcT/X7bbYUiJPvmcPTCtmI1rcGE28sr2PPGbg225jh+yfF8x2YBun3Wvuqm8gPzKjC7NP8kWCWZOGLcZJ+lM4Z2vdwLU+na+hQzQymo7A=;25:bG74AAvdwwpe5hoyGgPKK92k9PObIsRFl1GsGIl2AawW53CuSoxOKFfmf3FbsWINi7WNI7ENuqku9WdEoXqTdvCJFtyaG64ky72/e/WnN94Dhp/5FODdluDE1QuoF1G24ThDPMbLHs1PeISMnYH+C8nDkjNaAfraRXx4a1YA+lbiiZrDUfKYH3Nti1A5hlu0WfeRgoM+7++71UnFPtPgvvvzochDpJqlsTcVrJNEt/fhWFb2gQKiEjshRnKoPmC5fsuSkA3ZEhDcO5y3r8gfAi7gcYmBsiqVOXMr0+/1RJAw3ox4vwyFWd40HiTWH6SfSPE+MKsXxGxoZi7QmlU2PA==
X-MS-TrafficTypeDiagnostic: BYAPR02MB4455:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4455;31:6b3FlSe0yv35755gHE6XMJtyZjLsCTQVmhvOVLkxbOTK8giUAnn/9vdYBrMjRQ0WcG5NGu7UNjunAbuYmT/5ZnCMC3nf8Uwt910dk2oILaSxW+R73LCHDBViBPAzS3Jgd7Ng8oSQ47NoSQbxSDvHNbJ1/wiVfGo8TQHABhQbrxU3w/hPCmFQ6FawioN6Vepy7gPfNsaS5PCkom4NSHsW7Z9CVVvRViJ0lVq4V+tNlNY=;20:b/wCG/2UgQB6eCBAok4MXlsIIsyT4zDSNkG4AbTwGrWzHOIUGOxXolad2/bGQjBejFNoUkUN63MC2ETYJ7spQWxJ8SzTL0S8Hrj8pXO+DU0zQgh7fYWcq3Z9/Sl129Vc6THv32rXzQvFjy1YX80JNzE7LZslYmAB94v9jejg9AxNrn5nHSrpk1jpbMlMLMaFK1NYTH3MN9qZoT4UZZmOF0edbMJlajN8RrIE35G8s+lyqM/tEwkedTWPyFNN3Wz8l+nRkgGTp+QMbLedKmeP0diL7pq0aeaUJ2esNY2ldknF9MkXcoT7KU58Ndtd4+T9oxMERLyHPkMFPo6v4Y2DlCgulyOVnns9mVp8NNN+dAdROG/r2GTud4RR0XNKn2zN6XBL8rQ76fVolyByvj/c5Y675Nnb0v4wb3ovxyg4hmo15JfYKyGFRegpeSkVSnxSas9CPWYm6E2FWyLStVxtNykeA/lzvuUtK6V2m9v40xmr75Pn8h8FN3GQcYdRHoxr
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB445520BD832A5BC8B85C4B48B83E0@BYAPR02MB4455.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(944501410)(52105095)(10201501046)(93006095)(93004095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(201708071742011)(7699016);SRVR:BYAPR02MB4455;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB4455;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4455;4:tSOAUbb9nWGKLf7TE26jZB7nY8jxGjnmUBPacs+ZjGYbuSsIvX/FNdZfaedG/C36IkUtdpyH2BArzctR1FfRto4rbBCaPPVMgN57wFTlGiWMhNVCkJheD8V74lQzILWTglZlzRnpCaXNPNz2ZB3HWXIPUiW3lOgXfjS0O/LvxMbwwbDpUkGNuFXBuk1Ehf31dsfY/EP8mQs7AvShQv86quehn783wtwhxNRBgW7KTfic2TeHkVbGVVKDQWvSs4c7oKaTwktUf9mmYWaAmYIYtKGyuHekDKv3SKkuFYKwHMwAMIyiXOGvQdsiLG57v2EC
X-Forefront-PRVS: 07665BE9D1
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB4455;23:lB8rR/rioQatnVq8AIKt2U7f1sveDbvfpTDevn40Y?=
 =?us-ascii?Q?qKhUKEIr+AmhfKPiy6R0ZZtg64Qt2VxoXfRhDJKCGn6yJQlq4vWiduoaEQj+?=
 =?us-ascii?Q?1oIi8Cc07UzWAbCOYRmmNHvidTXDC1MjHPG7DH3XDBT/XKBCbjIRyN0zzC6A?=
 =?us-ascii?Q?ZPipRZg9UyKL5DIcQFU6RsX+BHbhxyu+WH6B3Rmfl/AmarS9zIb6DAhD2BGF?=
 =?us-ascii?Q?6QsCsYFBsVI+MJlTDfKakz75Jpu6Msj4q978xpBr+5s2T68hePyqJLZoZewP?=
 =?us-ascii?Q?RcuAdUegLa/YHevUjWByv3IFW5jVArXtBxyE3MTp6tUBWzOYHWaUk+dpSsJI?=
 =?us-ascii?Q?35hK7Gj4BmffeDXlpqeH3hj0azDM0zq6YbcFQ77mxf1doadw7Yq3DzFi2ks4?=
 =?us-ascii?Q?agAehiZblN550p2PRG4xPg0dclE5FfZfNSZ/Bhj7qzHNMB76UnvW1HUi4dmK?=
 =?us-ascii?Q?x5D825qdZ63ryJxLF5YCuTbPzkqb4NxIGYeYlcy0OmboR3CKY5PfbmuJ+k8L?=
 =?us-ascii?Q?RY8MPlz91Lnv7tFBRBuDRr9NmYyiS6F8tAKIhCSPdtKIRukXhlm1aJmH+iBe?=
 =?us-ascii?Q?tpbKtkt1Z16BRuS2L12i1mA2nTRwp4I1kq7Ob57XvpqGQbA/e/HutZr6VVV5?=
 =?us-ascii?Q?TFxY0w0j7MmCxBIz6Lwg4KoA+hdGaVSoq82BTjVO4oTS5wMdE8tFq6RGCFH+?=
 =?us-ascii?Q?fRUQ2lQfs7n8F5BOnhBZudvEXeeaHB/KmEya6varyqMj7fbRM1ZvjyJUpvQ8?=
 =?us-ascii?Q?p6N8vZmyATqA5DXk+Ub30PV34L+yWbT5FZnU4ZAWxMjQ5Wlja+g8jWzg4P7t?=
 =?us-ascii?Q?+S7EvGePZuXVWiQlkUbMfyvC06qM6f/JrkVCKT1LIoU5cn3YNx3HBvyUzFbP?=
 =?us-ascii?Q?hMzkyTEPwznd2FWXGuyRWjL8IAIXYc+qsQA9C93DP/Ou+uKspT2TMEXOlXOL?=
 =?us-ascii?Q?2ixqXZR/A2ehRHhMp0MPJe44vocTYBevce8FcxHW1zheohRVPFVsgY+WhBiM?=
 =?us-ascii?Q?otuL9Um9Y8ifarYnKwBNow7ZzPEKI8T+hzoryhZ2TXRbrvOnKsyUrDnvQk/+?=
 =?us-ascii?Q?0EqB2JZwfywtLV8Vt0mSPS8fb4+TmJnMuFv7aO0kYlgpU4XtXNQ3GtY/YR0q?=
 =?us-ascii?Q?+Rfx2r+rR/TeBr9XcrCw5KAA8XPuSFQ1AGH/0HVNTlyYGXYOqw767xg8/q/P?=
 =?us-ascii?Q?yoewAAFKwxLSZ7FSooSaRlcyP19X6InPFTyd/V+/Cbxdgw4oKBx+S1gYnCGW?=
 =?us-ascii?Q?nq244umfrebG1+iXHVGrSHILKjwSOwnixb7QHa66haOghhQNZCQzfL7KwLLd?=
 =?us-ascii?B?Zz09?=
X-Microsoft-Antispam-Message-Info: mTgW7jaDsKcYcYtYfIzLe8ZyADFC52LSPlPlZfph6OufXcv/Lor4uNyjZ+yEBOeyPT5er+4aPdE7uRBOhszl6KNBoscQMC8uK+fOZKwSnUkMnfSH/81bhwXvrFo9pR6diHz5nyNEl5cMtP999Ex/NAVG1gZWfMygSW79ZEP1ivTdvlyboiTOrThPNylEYmhPT0ofjcf/UfaJAOSn5Col0g8rkqvVZpq1WtrZCAEih81a40/6gPeX4VhhXY5XRdY7GKbMJHYNKdVXzoIGI+F/x308IszMztCHaCmNPCm5I2dFfW8PkFGdt0+wnArvBJkXUJZ5wewHU5OaRXycc8iKhp/VBX4NqimPoLVgjMwQjzI=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4455;6:bt/amV7qXKgibDQe9LE0NSCSnmQhMaU6slvWpDX7QeiQxIRhhcB+nS5gFDQPvJa8IjpRBDZRkMOKO5+1DLBkHDGyMa4u+EwROyr/iCLp9IkKv71GjKqFmBURuZHgZsVql9lTb5mqxM8Zf3xNCeFSrlT02A7FIIjL3kPHhoegmCtnV2j9L8aZ1t98hmxnCBj5fHmF1AmyRQ2A2mxggkMNZII/lIh5kReRRFpRzTUhDGwSCmKvFnDz1UTAiRAfdZgz3xF8p/E4LKCTaG/pmsO0GU/njZX1t4CmiybRXiHTqCaEY4pCzmz2UvCr+0WnyCaH/CF78pheQksiuo3Aua+oKInrM0Zh6h150+o1WznZS456Y62Kn1iNrZ5lMW+37Ruo34kR6m4wbazhnVzn4KK+XKPCsZCZrTqecPu/unIGPnkf2+VajbyzcMz6aEQ9ieGvAocgD7hF0U/9r2ftS//Rsg==;5:jHiOZ9Ky2cxhzxQyw8W6amTqV9YAOyXqEbfA/Ils9JWsNHvZRLh/OjnKWMJlpg/uNrkB+vq2OfcIU4ftO670pVIU91isq6PiMvcB8G2vFEdBYEKflCRpWD+e2KYHcv757nLUxe+urfYkJLTITvNE72kGaGdfSdCp9yVaxSDYeLk=;7:HkRRPRyTi4IJLPyF7jazhgpLAz/sAOFea/3BsW4tU7bEdObsf2QjdGRWdXkT6qzi7GyKLhxK2A2Qt6sw4UjrjAQ8xntroyvmuFIaA/BJK55LtRqIFqKqxwJGZuEi8V9ZluDJ9xDcbmUrLVrza0r0xq+kSAujf+iVS8E2Y/ObkBX0bseQ2JZOjQrtQGqRHXmqst6jHp+jReZn0R/ut+SLgYo/OOc3XU/QvwbNOZraKpsp6P1gqhfh4sOaPpe4B98F
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2018 19:21:59.4424
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f50c531-c3b4-4734-a30a-08d603ad89d4
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4455
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Add documentation to describe ZynqMP power domain bindings.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 .../firmware/xilinx/xlnx,zynqmp-firmware.txt       | 47 ++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
index d215d15..5fa10a0 100644
--- a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
+++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
@@ -64,6 +64,29 @@ Output clocks are registered based on clock information received
 from firmware. Output clocks indexes are mentioned in
 include/dt-bindings/clock/xlnx,zynqmp-clk.h.
 
+-----------------------------------------------------------
+Device Tree Bindings for the Xilinx Zynq MPSoC PM domains
+-----------------------------------------------------------
+The binding for zynqmp-power-controller follow the common
+generic PM domain binding[1].
+
+[1] Documentation/devicetree/bindings/power/power_domain.txt
+
+== Zynq MPSoC Generic PM Domain Node ==
+
+Required properties:
+ - compatible:	Must be: "xlnx,zynqmp-power-controller"
+
+This node contains a number of subnodes, each representing a single PM domain
+that PM domain consumer devices reference.
+
+== PM Domain Nodes ==
+
+Required properties:
+ - #power-domain-cells:	Number of cells in a PM domain specifier. Must be 0.
+ - pd-id:		Domain identifier as defined by platform firmware.
+			This identifier is passed to the PM firmware.
+
 -------
 Example
 -------
@@ -78,5 +101,29 @@ firmware {
 			clocks = <&pss_ref_clk>, <&video_clk>, <&pss_alt_ref_clk>, <&aux_ref_clk>, <&gt_crx_ref_clk>;
 			clock-names = "pss_ref_clk", "video_clk", "pss_alt_ref_clk","aux_ref_clk", "gt_crx_ref_clk";
 		};
+		zynqmp-power-controller {
+			compatible = "xlnx,zynqmp-power-controller";
+
+			pd_usb0: pd-usb0 {
+				pd-id = <22>;
+				#power-domain-cells = <0>;
+			};
+
+			pd_sata: pd-sata {
+				pd-id = <28>;
+				#power-domain-cells = <0>;
+			};
+
+			pd_gpu : pd-gpu {
+				pd-id = <58 20 21>;
+				#power-domain-cells = <0>;
+			};
+		};
 	};
 };
+
+sata0: ahci@SATA_AHCI_HBA {
+	...
+	power-domains = <&pd_sata>;
+	...
+};
-- 
2.7.4

