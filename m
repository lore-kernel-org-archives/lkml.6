Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C5CEC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 21:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB0362087D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 21:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="zDLiNIJg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB0362087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbeJEETl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 00:19:41 -0400
Received: from mail-bl2nam02on0077.outbound.protection.outlook.com ([104.47.38.77]:22955
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726570AbeJEETZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 00:19:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LQUAg2zEnhJHhxj56+Qf30lNEYmBi97e55gUiTkzj0s=;
 b=zDLiNIJgj2wyjQUbmZnd+G/acmXzPIMqCU/wAp0r++/mLRKqnyiFaBrFXVOxkbmL5E7LizXeA//HH4NvqoIAE5pHHJmvRB47cid3++8xD5GEhMOVACzyDquQRlXBXGB5Dec7mYZYXzNVoKQA38FwnE1CJkK4bDOUBwfUBFnn2sc=
Received: from MWHPR0201CA0088.namprd02.prod.outlook.com
 (2603:10b6:301:75::29) by BYAPR02MB4757.namprd02.prod.outlook.com
 (2603:10b6:a03:4e::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1185.22; Thu, 4 Oct
 2018 21:24:06 +0000
Received: from BL2NAM02FT062.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::206) by MWHPR0201CA0088.outlook.office365.com
 (2603:10b6:301:75::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1207.21 via Frontend
 Transport; Thu, 4 Oct 2018 21:24:06 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT062.mail.protection.outlook.com (10.152.77.57) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1207.19
 via Frontend Transport; Thu, 4 Oct 2018 21:24:04 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:48244 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1g8B6K-0004fA-4W; Thu, 04 Oct 2018 14:24:04 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1g8B6F-0001wm-0T; Thu, 04 Oct 2018 14:23:59 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w94LNujB006252;
        Thu, 4 Oct 2018 14:23:57 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1g8B6C-0001w6-PR; Thu, 04 Oct 2018 14:23:56 -0700
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
Subject: [PATCH v3 2/4] firmware: xilinx: Add APIs to control node status/power
Date:   Thu, 4 Oct 2018 14:23:39 -0700
Message-ID: <1538688221-9823-3-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538688221-9823-1-git-send-email-jollys@xilinx.com>
References: <1538688221-9823-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(136003)(39850400004)(2980300002)(438002)(189003)(199004)(110136005)(4326008)(16586007)(26005)(36386004)(106466001)(47776003)(316002)(2906002)(107886003)(39060400002)(63266004)(186003)(11346002)(7416002)(76176011)(77096007)(486006)(44832011)(51416003)(305945005)(2616005)(36756003)(8676002)(7696005)(476003)(126002)(2201001)(48376002)(336012)(50226002)(5660300001)(9786002)(72206003)(81166006)(81156014)(8936002)(6666003)(356003)(50466002)(106002)(426003)(14444005)(446003)(54906003)(478600001)(107986001)(921003)(2101003)(5001870100001)(1121003)(83996005);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4757;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT062;1:yLOfmo53v1+dWxlRp+2AZ5uwzyZyetRiiGoppnhWFwrxpOZfbJHI+5s2Ep+4BtnrVNL9vC4C4EvmRBmTFxaKkKAAcfr6yd51hB0frsBHXU9AX7MBiMEyfon8CRFCBBUc
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 202cfb3f-f42b-4a26-f16c-08d62a3fb6eb
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:BYAPR02MB4757;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4757;3:HYxWaUx10qeEVg90rV+LZlo8Puo1slbxU5INCDxRyM5bVDQx2rlpCqzrflNmaPoAzHoxBlyjGdpoI8u9aEmuAeQkyKSEN/+P5syouK4tZOsR/0BDrykmcmozKha168yPk4p6rhZcxlZ4AFcMe8vH+DtZbuhItrozd0ckG7cjrFBCPZg+fklzy33sC05zUaQwAqNE1mSQzcV+mmx0g6rd5OaoaDEkVZX35BjiYrU/jdGlA7UUJiJ/wsAIcICZFySTFLJhNhLXZYO3UUyMsfFvLMLIQbYmVHdRf/Gjc7qEDe6avHlxCdLiO5RaaFx2/SMPw6lHIR2dhu8AtYa20JM6WjvB7OgWrUw9pe7ldEN88qk=;25:BCs1STq7vWdoyelivcnt5eyjLsE9IGN8nvTJSQ70iP/ilirwqNrHOXGbzXu/DngOvRYyGlnjF3Gmt2NFi2yQbKeFpsyraNeQJVvCe7sxreuD+WxETQ94yg/QvQDrRuUG5BuyJyoaQQ/fl5E93KhQ8E5Ayfzgq+4IVhqq6LN5iNtEaTWDDVteSfAf8+NZ7r6ZkmfS7Qq/D2L9QNLTcdcOBUreK0faFXulBu0zAVdsc3kCIGL0iNZr5jyMZLr1wpNxysG+F32woYVnwtV4sfSVFOv5tNxdBEeKJ395T+M6w0oQ2cstIJ1R27d+5FBckoAJrrMIyebQuaa70Sqmbt1iWQ==
X-MS-TrafficTypeDiagnostic: BYAPR02MB4757:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4757;31:2jlvkQ1DxjrkrZ4e5PWtoI7l1OoKwYmsN/cZubbUHJDYP1UmDtEHImn0uu8TwUjXola2R4OauSA0rI9SP7ZPTUGPo+1xnJ+iUoLvqfQBhRc6cwcakU1LFHYm+7CDAfO37Vg5U7/JbwcZNfd13bwb6KD4wN1EHdVgS9YvABXakgHXuQ9Oo5UATesh3C1ZVAyNSu89bzYWR6GIGoHd6AarviU5uI7j5bqxwMCawYG58JY=;20:3DkubFmc80pHc9S7HozS07qE4RHV+fRQ2BJCWICDu99fwRActnIwofTV4gmf0WkWPFgcOGtoq48c7Rc37QQOv2gbDCt8VGiNuzsvKR5HAsDbhaCcHEDkfsiab5RbOns/plkwNvRzLRn/vPX2fK/0vZ5iyBGsLAsFWjcfTqSJ1KzWfwNB3/FWRE+X3B7gbaIjkEg9Zx229CU+2KOXrEX5vhySUIiJkAZPWB/UPgn9yHc02JqNbywh65f/wxikVdB3nyJE1uTk0zg9JCWbt7coQUhwMOHeRclIdTgcVyeXkg67o1xf1sRqiNW8dGooDdQ4HHG6GdwbqvLDhwW8dRJ7rP9sxUgMxnDxMCuO01MZpD1mHwVEQ3OY0yROY4Cdyxng4LLXlmStwbtV/XqCyLA3EweFql30Qh4MCHzyxunbikGXdu5oel9snCGtKbUi7dmccXtec9ohkLVBe61OqyD/sGexxtSjEYETwwVd2C/A2geri43nzMgD3+7bG6vzli3N
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB4757BE2D591CC0AB56468716B8EA0@BYAPR02MB4757.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592)(269456686620040);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(3231355)(944501410)(52105095)(10201501046)(3002001)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:BYAPR02MB4757;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB4757;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4757;4:7sDOLna4VGst4zYysl5Xymb5edvKpwLYmS72fIyHy1G8cTcIX0GWkZJDwRCG520Ufib6Cx2wml//wHR5Q8k7lsKBDA0fH6t42Dv9N0/EatBg62yZKcRRCLcKoRA4IIALKnqR4Qg31r3Ez4WNDrNoD4FjUZiy4BKw6YXV9klr1gZHFRx6CalNsGNbcrWhZv8CIyXQInesjqnd8RgDiic+stL8ZsHZbkaaU/foccFhbhlEYbGWOUEjDCPop97+/E1G3ClUqSkgDczfVwyKY/cP2WfsdYpLimGkPuAR+nTcYlErD4BhsYj61udDfRXM0RDu4r8vT9jzDsrb+2Dq5mLSVYDJLQYkkjDr/EEeRwNk6p4=
X-Forefront-PRVS: 0815F8251E
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB4757;23:FjZ6PDD2ishLFbzheEbNpZylUB+F4Sj53y8ja7iD7?=
 =?us-ascii?Q?aQaeHvzXaPU8yqiLbxbJe6zUaPuwBxKTzF+YK/FFv04ufrDd9aysoyw/QBMh?=
 =?us-ascii?Q?8boS0GJF+DjP9no+fJXoR+tCTBx7spJ+0/tZ1nymhG8vYzKB8KadxBjKqsKX?=
 =?us-ascii?Q?3vEsIVB4zXBcd9rGGXOdO/Rd4wjHGww8ng8QekQ4fXvZSv8H07Av5dx9KzE5?=
 =?us-ascii?Q?thR9Wmk4fdfZqb348cT3qrErHnl2DkcyvsPlx1e37gpfsRM2a66mBtsLFcbM?=
 =?us-ascii?Q?v9Iq7SJgJu4X+t51Osn6YUinwI6HIuY0aQs88yAflKntyJUkkY0Gvdxnxe0L?=
 =?us-ascii?Q?KclnXNHjw5mE7OZEBkPRDDkl+Wz28z1Ts34nfxJtDyYuMqK66USRcn0FWi5y?=
 =?us-ascii?Q?jH/Hqze3GHP560CKIIL50V9+Fi21qFrbAcwgUiblzpgI+uAUMh2K3QPEZtXB?=
 =?us-ascii?Q?REYS0s6kR+Me1/80ZgLJsdnbNVTFXU2oRORhnwhbwjUdFtOiOi1kQ0bmIo4v?=
 =?us-ascii?Q?dHh9uy5oN3rQ0YVQ1zaE2UWhu6zq5dL60gzlqHwgcC8s5mbWe7cmseVOWIQp?=
 =?us-ascii?Q?Ry4YSXqPF3Fxuu/teztcXTJiNYursUqIpnXT8f5SrgHpLd+WxlffIroHweS8?=
 =?us-ascii?Q?Lw8sDMQZfwCRlmVIdzwISp/BhR+Oal/P9SdMEVcmOmTdspzawZfK/t7TSK3/?=
 =?us-ascii?Q?lPTJKtcMK8JkhbyT4NPNhuHHGVOtfWkGsdmiGMNNEdO9ij8DpdnfRtXVf9Tp?=
 =?us-ascii?Q?BcChTaOFqQqEmagdseJB8VTefMsRJtzex3qF9OvB6mY9RXqSX2QzLStEY5H+?=
 =?us-ascii?Q?MO7aUfpO7V616WTxGt/qJ1V3a0oT626I94XQ8g2qEv3HcUSQx2RVQ+z2aeGh?=
 =?us-ascii?Q?w5klltfZ12YmL0rvwRq8iCcUT5F11TBYGbsDEHR0AbaxOf2C2HbdkYFJk+XR?=
 =?us-ascii?Q?lPAmNrCOz6Ya7NneLcJlf+PEu5Kgq06NARGOFWoDefX93HHZ6PYxj3hmYYlB?=
 =?us-ascii?Q?IhcrKwrrNgyAFnuUFfYn5hEDoFTbZEMtkpARlqyh8rbONEW9cw1nc7yjVbyu?=
 =?us-ascii?Q?5ZxoVry+7oHWngUCg0QVkzdY4njAylR5Fcduozdtu4Fox0F/M5jyAEtTbL8Z?=
 =?us-ascii?Q?0h/W5FFzUXj8FAk2ZNndXVpsMdRAnKb2kL4EuMLRKZ8Z7py8C+ZzxPpZO4uc?=
 =?us-ascii?Q?OuxRHauwcgQiheM1ZcE9rEEcFleFiwbvbMO1kFDPCkGpfo0x2fIweTOL1RDQ?=
 =?us-ascii?Q?3Pljg7k9I4VGp4nAbrZjp2sfKnAygqF68I6pOxBghL9m2M1kUpNZasXubGSO?=
 =?us-ascii?Q?V7/buwjMlkL/yaK2e/1Q3cwqFyJiNwUnOnxBY05OzAS?=
X-Microsoft-Antispam-Message-Info: zYstvwPjIsG5LLYNAchWL4eQUOdJNNUwz823KH2uhqTesgC8Cw98W5Hm0teIa52PfZG9l90otfXf7LBnlD1NTy4SNCHmtGJ9xBayZGF3U3J4QzQ3oxyUKB+GPFkNZKHpAuXBjBC0rY+gr/Oc1ZeUlLKpYX0Vd+itL3mWpwrMYq73bxzUI0DFLy7/7WOtHKFQpP9iGBVPCS/qWGsib0JFc2+518I3MOFOWSYjC506U7rKphknuPWwbx5sekQz3iAxoKqwCRndITm8JOo/JiOcpqkOFYygI4mtY8JJpIBSRW+KVAFRtE5xp5HaxXtJeNlTZglMMyS62EIqDEDguDevPid99ZAououFt6IIzVpeHbw=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4757;6:3xttu3sZIUwfFmWW5jE+yXJaupgvjzrQ3ASA5SZZHq3BdrjdP7lhgDliy+dpfV0QhA6rUH6z18FOXwvjdA+2t40cER/YVPA2ZJDl/w4xrfqdwaCBkP5TBl8ITYY8JNmsw1xpYC7Z+W4LzuVtKF0eIQO4N7HQA/z0Go53LRst1OLWwqMsBD1GEhS1KJ0l52DmA1QRrXuShWfnpoJWZ4Z4URMxh72QT2jaqEHp+Er1qec2UMbP2k2UPZwQqkHxi7fqLqhfRqcY1u0lZM2IB/IxFsBWYItN6WQeRwWK03l2iKjA8CGOh0Or0Ec+8tET5B5kTrxNOnec0wo16s2tsdzFbzLL3L/GGIbcHpBeCD897Zsycglfb0UzQrkyRLO0NgEER94Eu26MW6eFDWViV1bzTZRoPuiAXWVp/2+YtXsbCtJFgqPzEeJxrl311Bz6FBkB2Z1IWJOw+07BBtAwdh/3EQ==;5:fN/lsXsgouu/4Jft43WssJpHEwGsc2LjAFn2sIPpuxgYkE9f7JSkNgWjWukq8PoAuPXsAIWo+cZymjzRuCilsV2l3+buOaQL/ssHTnzT1HYDx9iP37fA77+A6MAXn5JtajuYyCCkJA/oOEn25TCvQn+kCdLBxCNjTziay/XRybk=;7:FpgoP+ARllTLgg06BiYb7h/iEq1b2FEEuP38ND+eLVeJs7iFvoFSjSqf9xtX7eDihW7ZA5qLR597iYWEFkOulIFgZxa+4aE4v5nReBsO7gy6Yg55pHj1tyqdHzshxGKyBCtNNj1IilrHhCpQGGglT4VlbRrdjGWBdIWyBKlqyhHe5ZAyfj3H0V9x4y/eHPi/JVzvaA5FX1qSe55QNZlxEcFHX/TGEDylrnUMjbZw0UJTPrmGWj3U9VijiWnnywph
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2018 21:24:04.8788
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 202cfb3f-f42b-4a26-f16c-08d62a3fb6eb
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4757
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Add Xilinx ZynqMP firmware APIs to control node status
and power. These APIs allows turning on/off power domain
and setting capabilities of devices present in power domain.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp.c     | 58 ++++++++++++++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h | 26 ++++++++++++++++
 2 files changed, 84 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 9a1c72a..faf6a52 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -469,6 +469,61 @@ static int zynqmp_pm_ioctl(u32 node_id, u32 ioctl_id, u32 arg1, u32 arg2,
 				   arg1, arg2, out);
 }
 
+/**
+ * zynqmp_pm_request_node() - Request a node with specific capabilities
+ * @node:		Node ID of the slave
+ * @capabilities:	Requested capabilities of the slave
+ * @qos:		Quality of service (not supported)
+ * @ack:		Flag to specify whether acknowledge is requested
+ *
+ * This function is used by master to request particular node from firmware.
+ * Every master must request node before using it.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_request_node(const u32 node, const u32 capabilities,
+				  const u32 qos,
+				  const enum zynqmp_pm_request_ack ack)
+{
+	return zynqmp_pm_invoke_fn(PM_REQUEST_NODE, node, capabilities,
+				   qos, ack, NULL);
+}
+
+/**
+ * zynqmp_pm_release_node() - Release a node
+ * @node:	Node ID of the slave
+ *
+ * This function is used by master to inform firmware that master
+ * has released node. Once released, master must not use that node
+ * without re-request.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_release_node(const u32 node)
+{
+	return zynqmp_pm_invoke_fn(PM_RELEASE_NODE, node, 0, 0, 0, NULL);
+}
+
+/**
+ * zynqmp_pm_set_requirement() - PM call to set requirement for PM slaves
+ * @node:		Node ID of the slave
+ * @capabilities:	Requested capabilities of the slave
+ * @qos:		Quality of service (not supported)
+ * @ack:		Flag to specify whether acknowledge is requested
+ *
+ * This API function is to be used for slaves a PU already has requested
+ * to change its capabilities.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_set_requirement(const u32 node, const u32 capabilities,
+				     const u32 qos,
+				     const enum zynqmp_pm_request_ack ack)
+{
+	return zynqmp_pm_invoke_fn(PM_SET_REQUIREMENT, node, capabilities,
+				   qos, ack, NULL);
+}
+
 static const struct zynqmp_eemi_ops eemi_ops = {
 	.get_api_version = zynqmp_pm_get_api_version,
 	.query_data = zynqmp_pm_query_data,
@@ -482,6 +537,9 @@ static const struct zynqmp_eemi_ops eemi_ops = {
 	.clock_setparent = zynqmp_pm_clock_setparent,
 	.clock_getparent = zynqmp_pm_clock_getparent,
 	.ioctl = zynqmp_pm_ioctl,
+	.request_node = zynqmp_pm_request_node,
+	.release_node = zynqmp_pm_release_node,
+	.set_requirement = zynqmp_pm_set_requirement,
 };
 
 /**
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 3c3c28e..6998f7d 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -32,8 +32,19 @@
 /* Number of 32bits values in payload */
 #define PAYLOAD_ARG_CNT	4U
 
+#define ZYNQMP_PM_MAX_QOS	100U
+
+/* Node capabilities */
+#define	ZYNQMP_PM_CAPABILITY_ACCESS	0x1U
+#define	ZYNQMP_PM_CAPABILITY_CONTEXT	0x2U
+#define	ZYNQMP_PM_CAPABILITY_WAKEUP	0x4U
+#define	ZYNQMP_PM_CAPABILITY_POWER	0x8U
+
 enum pm_api_id {
 	PM_GET_API_VERSION = 1,
+	PM_REQUEST_NODE = 13,
+	PM_RELEASE_NODE,
+	PM_SET_REQUIREMENT,
 	PM_IOCTL = 34,
 	PM_QUERY_DATA,
 	PM_CLOCK_ENABLE,
@@ -75,6 +86,12 @@ enum pm_query_id {
 	PM_QID_CLOCK_GET_NUM_CLOCKS = 12,
 };
 
+enum zynqmp_pm_request_ack {
+	ZYNQMP_PM_REQUEST_ACK_NO = 1,
+	ZYNQMP_PM_REQUEST_ACK_BLOCKING,
+	ZYNQMP_PM_REQUEST_ACK_NON_BLOCKING,
+};
+
 /**
  * struct zynqmp_pm_query_data - PM query data
  * @qid:	query ID
@@ -102,6 +119,15 @@ struct zynqmp_eemi_ops {
 	int (*clock_setparent)(u32 clock_id, u32 parent_id);
 	int (*clock_getparent)(u32 clock_id, u32 *parent_id);
 	int (*ioctl)(u32 node_id, u32 ioctl_id, u32 arg1, u32 arg2, u32 *out);
+	int (*request_node)(const u32 node,
+			    const u32 capabilities,
+			    const u32 qos,
+			    const enum zynqmp_pm_request_ack ack);
+	int (*release_node)(const u32 node);
+	int (*set_requirement)(const u32 node,
+			       const u32 capabilities,
+			       const u32 qos,
+			       const enum zynqmp_pm_request_ack ack);
 };
 
 #if IS_REACHABLE(CONFIG_ARCH_ZYNQMP)
-- 
2.7.4

