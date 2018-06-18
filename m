Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E5A5C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 11:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4592208A5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 11:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="eFtu9Dz4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4592208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934694AbeFRLwK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 07:52:10 -0400
Received: from mail-eopbgr720062.outbound.protection.outlook.com ([40.107.72.62]:58688
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933651AbeFRLu2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 07:50:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8RxUSiSJ5MvZkW2EBnr57KQte9xHDwI+CM+W5koJQAo=;
 b=eFtu9Dz4VpDzNrtggQzd9zNMeDZVfkVf5c/fiv40eoWbKFM+DgsfgpFUBCDN8ISbxh571V9U2sjrwPis44tc2qHmfUChsD8gfharQh4WMyX2nEAd8cWUYfiRThDgOH4pOF1SfWY54CiV/k6gemfgh4XCy+JmoehrIXvtZIJwNzU=
Received: from SN6PR02CA0010.namprd02.prod.outlook.com (2603:10b6:805:a2::23)
 by MWHPR02MB2238.namprd02.prod.outlook.com (2603:10b6:300:5a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.19; Mon, 18 Jun
 2018 11:50:26 +0000
Received: from BL2NAM02FT016.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::205) by SN6PR02CA0010.outlook.office365.com
 (2603:10b6:805:a2::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.863.16 via Frontend
 Transport; Mon, 18 Jun 2018 11:50:25 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT016.mail.protection.outlook.com (10.152.77.171) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.863.11
 via Frontend Transport; Mon, 18 Jun 2018 11:50:25 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:36363 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1fUsfw-0002rv-Rw; Mon, 18 Jun 2018 04:50:24 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1fUsfr-0000Qd-P7; Mon, 18 Jun 2018 04:50:19 -0700
Received: from xsj-pvapsmtp01 (xsj-pvapsmtp01.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w5IBoEJJ006557;
        Mon, 18 Jun 2018 04:50:14 -0700
Received: from [172.23.37.80] (helo=xhd-paegbuild40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radheys@xilinx.com>)
        id 1fUsfm-0000LD-16; Mon, 18 Jun 2018 04:50:14 -0700
Received: by xhd-paegbuild40.xilinx.com (Postfix, from userid 13245)
        id 35525B209A8; Mon, 18 Jun 2018 17:20:12 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     <davem@davemloft.net>, <andrew@lunn.ch>, <michal.simek@xilinx.com>,
        <radhey.shyam.pandey@xilinx.com>
CC:     <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/5] net: emaclite: Remove unnecessary spaces
Date:   Mon, 18 Jun 2018 17:20:10 +0530
Message-ID: <1529322610-27215-6-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.4.4
In-Reply-To: <1529322610-27215-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1529322610-27215-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39380400002)(39860400002)(376002)(346002)(2980300002)(438002)(189003)(199004)(106002)(103686004)(110136005)(5660300001)(2201001)(90966002)(26005)(305945005)(54906003)(36386004)(2616005)(186003)(52956003)(426003)(76176011)(51416003)(126002)(356003)(476003)(16586007)(478600001)(59450400001)(336012)(486006)(11346002)(446003)(63266004)(106466001)(4326008)(50466002)(2906002)(8936002)(42186006)(316002)(8676002)(48376002)(81156014)(81166006)(50226002)(6266002)(47776003)(7049001)(36756003)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB2238;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT016;1:GOYevAYr3IZv39atDoe6b5Lp7VScmWV3iBwu0kUHm7+96Nm0eotT0CjQ9T4hfRmR3Lzs6ndkmS78fClobquJ+WjWBhFXV1q7IpTnbv8Z6Gtc49XXW+3Xd6F8YW2pNeN6
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a08c108d-1424-4079-36ff-08d5d511ae44
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(4608076)(2017052603328)(7153060);SRVR:MWHPR02MB2238;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2238;3:MLwcWZsjS7igAQ5fZVbJL+hiirc9UoxciIpT+qf8J047V8eB+rQ1hSFbkH1OBOhMYIkDBM5dSt6Hba5piTSh+GKTJqePgdTcq4Zf5Du4Ak0SIR7g3T5jdUvbL3SAsTfOKURYLcx/jM3Bf5x9QQPdTU1ieN3aIDWunXxdHj7oCxuhCBv+2b8yB1Bv0IkFg0mPk1x9nWk/dV5Pk6BVQjHiarjfepOpzwcPXJfkiqZL6LLqgnFGXM6FHmYvryZFZoT3NhThkzMxFAPNFuwf+Has7XuTEt28tTqdfFlgb5/fIZ4WLtzxJ+NXjpwWJAL+ifUZ+UQ7Gpfq8/Zq7a8yCxCeee+xVC/zCedhil+IwHFRs4E=;25:frFMZ8sV4Z5dyMJvA4XnacGj6UD7PUcK1mh3hd3K9KzKlc/3/uCdpY7TAAuEhCfwFy9xN7gQenrfRBpK6nfXNSiWy0mEOB2ahlDUPI40PU/HSVc16UOeul5YD6LvQ19b3Ool7d/5EZkddk1ck+Mp1IDCCotAerD6f3YqkVruR6uGUBzAbfstpn4MG+aA94aVhsviUsW4qGQczDTleEwY+Qv7he6IGREXkh0lapf7FzAy6zxcK3GRBmjqCwsbfsOlUNyJ0lxzwWKEcPDBytImvvtR8RiulaJD0HVWlxMwjUnulpc/h4+lqzkZ/Aq8vCL/yqcnoKJLFRgCDp3QPG1ZeA==
X-MS-TrafficTypeDiagnostic: MWHPR02MB2238:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2238;31:NzeYi9PbFyZMDnUJ2/ikDpOfaNSVQ/txzLRdEGUIc2FZIBsRZBxjRn63YFOCTQdUldjpozb/D9DS1yCM/6RONyi8C0GWWE7PdO35iYCczSUp5JMQN2Zrxfq3d0UwcS+mzn1autAqmxGdanu7d8pIk6+XjJMOASlJUZzkU1idB2FltVcqHs7rOi0zHRiZADANIQHwqp4h7gcUYA507SqsItNhsixbuTT73tst+rae1+o=;20:JuWjCRo5Yo7jxS2S4v2u6kyk5VWF5rkA/hbhZAkZvSyQpzGdWPVh0FWOfO1n3jebRIZ95buexYJjaAfuLvlygd5jSKj5OwBuvxqIEEF9X/nR92ICDUL9A7XaC6+1CPbY/clM6IFo4m1OE8J9f7SQkXZJnfjeiG/E35wC1pVIu/ZEMj3El6sVI46bb4q/cbfHpDN825Wzl8+7dzhcB/q3tBxpBHJ9cpr7EIOA21XVPPMBOGJ3X6GHgM6PlKGqRpZbiUBsuUHNV5MLpMnDrQllN97PcRgUXZEz2jzX0m1VPr+5vnyLztvh+V8pj+hu9ncZOHpxgPyVD8jn6QuNzKyAWhSJOnh+iXoBSQFhPaP/7Rh1VCgy7Hdt/a5SJcp6ztRlz93DR6SY9Vfqd8AZPoDiF0Yii0vLGqK2PNMF/w5T7Plj910rbwPQapBcCsQnrWUh8mRqpz3W1ZR1PIIvW3x4kfc6VSRbIvydRGYv9FEGolfkynBxEJDfdqFmGWcr/Wa3
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <MWHPR02MB2238C488A8634E192D4617F4C7710@MWHPR02MB2238.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93004095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:MWHPR02MB2238;BCL:0;PCL:0;RULEID:;SRVR:MWHPR02MB2238;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2238;4:SbpyVCG/lg6zhadYJuOR6fp1GgaXUdoeMU0eUaEkj9RgWhmx3TOup3Ayt0DA2evJlX5AuFg/i7BHDDpzyooJvtr1d/+PxmXpowlzkLHo8tZ9/CmIF0hOvbygsMP+HM62elW2chQ/E4516Yf+qID/YOjFHrfR7a6gDLt4FxDUG1zza3+AsUxHX7zNb4zB3yKhrDvTq3yA35ConxZQU2rHaE84Kc3WAnBPtZDBYC2YBEYbaFpQGas/kVcvSjySAr7OyQicv9SEK0bULYB1cHtrbPwZyVoARZimwVllzY6iynfmdzFk/v9I6Yw5m3juYAsL
X-Forefront-PRVS: 0707248B64
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR02MB2238;23:8iGEg1Z0d2MBwL/+7MShFfs2m9g+g7SndxGLN0ORT?=
 =?us-ascii?Q?TAH/DNv8oVKIyHJzmTkIrwyDoMkQOScXw8n573k7gif2XrVMCrB84NXs9pgC?=
 =?us-ascii?Q?f+HXs8L+qmGA6rb3UkQpWuPFr3xufHeuG/ADFMsGsiFXZgEEhslL+u4973k2?=
 =?us-ascii?Q?kzmQlxuYSNesczd/J6j4BWRxjjZy7SJRaYu04qtd7SxMRuAdgbIh4EL3yljm?=
 =?us-ascii?Q?Uzl/AKnbjKcFUsmj/KGyZ5sokOTfSxZkzSeRh2t1XTzsK+aM2Wy6dMZdrpRk?=
 =?us-ascii?Q?zfGL8wFz1zqkEbWKLSZrZBY7YIOr7tzEjsPAv544WkNOSk3uSiG1arQNPi1x?=
 =?us-ascii?Q?7iLZ15iGJdMexEwaWBXTtDC6HptcZbGoHSuoIQZnBck/C2RwQhF5jrWqxJAb?=
 =?us-ascii?Q?uYCTbhZLyqfgAxU0JhyVXMCa+Eo6bqw7/yVANckk+jvJNvd17gxwc7070uzR?=
 =?us-ascii?Q?/pYDoBA75WdnPJ5n+zvx2yNJhjnRjtObB9eTnU7H1cZ3aqTbFtnvJV7YIHqR?=
 =?us-ascii?Q?EqP4SSfDf9/Taw3Bu15Qudk9IYmxF0ByNmujt9mObZMplOmE3A6xJFXPKauK?=
 =?us-ascii?Q?GjVc7XCmygw/jHEZ+3c5GpIKc+bUxAr0Go9GAdc9nPKu4pNrirmS2Zlzdr4x?=
 =?us-ascii?Q?ql8pUl6/1xMbRbCC8raWpMFd1LEvThc+A9sHg3eX0yWea1b38v3yXH28Titq?=
 =?us-ascii?Q?uiTUcH0t/i+5t1r7lC154yvHdx/ggePpqUtYlztJgO5UTD2asp2FvzXlgf+y?=
 =?us-ascii?Q?UyN/bHka8A0CyOgj7fAPTBBJOCqqwtjeEHqp/19VRDDY5xc5gr+EUVLVINvj?=
 =?us-ascii?Q?dq1UWF6rksyRQxrbLePNLRFzcA/601ZJiQ3jX5PdNhiR9GskvkE1twhj4FXS?=
 =?us-ascii?Q?7+NFa6FX6DphPlx5JtMUu+j2rjWd7yLtOBtlw01PCz2lnf5aMVkn8gz3x2af?=
 =?us-ascii?Q?EOTYPE5lKjnALSKldXSOe2+iOHdoLWvx4fpfVQ2srYlHGxwC11XA41y7zSXD?=
 =?us-ascii?Q?CoaNMwcu+dYahjHwPxYd3gsYwGQ7IsfVCldVUCRk+Up+HbzCDAPGxHItyDj3?=
 =?us-ascii?Q?VChJut0uLttha4bDA0oTGI6dpC4vd0X8i2GNEblJb10hih8xn3SlZO7HCkva?=
 =?us-ascii?Q?dVkR4UlKLXf8MRFHObw7AH2HZyvBpKW/mSADsl7Wpgn0BqjmK3CAA8gRQukY?=
 =?us-ascii?Q?3axNC8hyTbwEHj4t0mWVywKK++2KMivZW/RbEq4yVGFEQioAVeFO4RaGw=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: mvkmeLWvXGYaTYMLd9FBFX8aicf9rWn0yJrcwPOtuU0cYM3aeBQJiN1d1RukxnVqizEqyoKVOxfjIktf2FSpTJywDVx1I46UBleTgJ5eG9vDKDCCj70Q8p3xP7zr9YsR6fDaa4wAgTUI09CZo0ZCkKJuwx0WK+BfgrHzF/FTJQhGQqvo1JAhwbsMUFhmKUqxc/lPQaRlsa85+DNXK0EYPt7H1b5IwN7nkpOAGKwZDc6NTRDXd7v1y+ZBzoPX2hoOiB8z4XrROr/N1wsW0nBZNW7ChIGwIRJnAQSwljBQMwezWwgIDm8hOFz6SkU870bY
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2238;6:iPtmZOi8jFzmdiMy37nvfWJxhIQKKsuWls+PMLVdeI9YDuvB/iXnl5FTAPE3ZwNhIwdDe4rM2gtj1uqRevemzZ45rFfVy7Zq9xP85oW8JI9noeVeo8wb2NNaTzr9vqqnrorAUdZMTLl3UvwOwwzX/E4JAopEFTkM0RecK48ZxJHj+OZfUjGAx458YW915mjIMCQxpMqjtpFPYbRLC/rrh0q3QcioF+HYkCplzdzU68ixkdqDExtmQO7otD1Q1tjMVKDyt9UZ8CXTnKw36rmIigvb9NCUCV+mfl4woLVHPvImjcopGjN1q5+EWpC4XtMiUSsXhr3eeYdNUL0saD8MIrKrIYRzIyVJy3m7JVzPeVyJVYYDycgEt+6YYi4dvGSI3nai3TUBWsQ88Me08SK9BiI0yngtjGg4/ewTSlI8Re95R3iRAuBfBFYLWcipsKwkGHuniD4XtOz9BMSxLOhpwg==;5:84CxsWyl7QmGuODUvIQnR5D4dVYsb5NIYGCSQ2Gk7eQ0fcN4AvT+0VINFpvA7ll+MXHM1s+2NuUa9xI+9g3sa8aYkqDsp5IXCE5xFjYnAfCqCb99kScoTLPhxPrAiCEokexxCIRuy/4do0ei7Blxsb7Tv/DspGnWqXbvvLwhANE=;24:9TmNDz55K3/Maw5CaAMxaN2qXkQdoVukf8i2lDL9JrpbWDMsqLMhmafxfNKb7IFMAOOFh/bAM88OaHppRY1KzKew29GBov3Ahwva2gHL98o=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2238;7:D4TZ+8HbElqWsm2TNwN7xbkB4EHes+lk0Amqqn8Nl1q7JlKem5EPAiqFlfl7Kj4mdBrBsgUPXyWXLrPHO1uuKVUqnZTucZXZ2v9yHZgx7GlvXdK1/MXZ3VRqlJi+sAg93bE+0RJEdsbYlSeRW0bjbs1UkhFQ9UK3nxMLkein44WKMEvaAvX/IUFScmQJ97c7L2QrSVxSMIjBn8uw3PmwntIYKbeXPuGmjhKdU/ItcxyR5GEpasvl7r/I6Wdmq3Yo
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2018 11:50:25.5003
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a08c108d-1424-4079-36ff-08d5d511ae44
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2238
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes below checkpatch checks-

CHECK: spaces preferred around that '*' (ctx:VxV)
CHECK: No space is necessary after a cast

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
 drivers/net/ethernet/xilinx/xilinx_emaclite.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_emaclite.c b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
index e8bb7b3..f62e4b6 100644
--- a/drivers/net/ethernet/xilinx/xilinx_emaclite.c
+++ b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
@@ -95,11 +95,11 @@
 
 
 
-#define TX_TIMEOUT		(60*HZ)		/* Tx timeout is 60 seconds. */
+#define TX_TIMEOUT		(60 * HZ)	/* Tx timeout is 60 seconds. */
 #define ALIGNMENT		4
 
 /* BUFFER_ALIGN(adr) calculates the number of bytes to the next alignment. */
-#define BUFFER_ALIGN(adr) ((ALIGNMENT - ((u32) adr)) % ALIGNMENT)
+#define BUFFER_ALIGN(adr) ((ALIGNMENT - ((u32)adr)) % ALIGNMENT)
 
 #ifdef __BIG_ENDIAN
 #define xemaclite_readl		ioread32be
@@ -239,8 +239,8 @@ static void xemaclite_aligned_write(void *src_ptr, u32 *dest_ptr,
 
 		/* Set up to output the remaining data */
 		align_buffer = 0;
-		to_u8_ptr = (u8 *) &align_buffer;
-		from_u8_ptr = (u8 *) from_u16_ptr;
+		to_u8_ptr = (u8 *)&align_buffer;
+		from_u8_ptr = (u8 *)from_u16_ptr;
 
 		/* Output the remaining data */
 		for (; length > 0; length--)
@@ -273,7 +273,7 @@ static void xemaclite_aligned_read(u32 *src_ptr, u8 *dest_ptr,
 	u32 align_buffer;
 
 	from_u32_ptr = src_ptr;
-	to_u16_ptr = (u16 *) dest_ptr;
+	to_u16_ptr = (u16 *)dest_ptr;
 
 	for (; length > 3; length -= 4) {
 		/* Copy each word into the temporary buffer */
@@ -289,9 +289,9 @@ static void xemaclite_aligned_read(u32 *src_ptr, u8 *dest_ptr,
 		u8 *to_u8_ptr, *from_u8_ptr;
 
 		/* Set up to read the remaining data */
-		to_u8_ptr = (u8 *) to_u16_ptr;
+		to_u8_ptr = (u8 *)to_u16_ptr;
 		align_buffer = *from_u32_ptr++;
-		from_u8_ptr = (u8 *) &align_buffer;
+		from_u8_ptr = (u8 *)&align_buffer;
 
 		/* Read the remaining data */
 		for (; length > 0; length--)
@@ -351,7 +351,7 @@ static int xemaclite_send_data(struct net_local *drvdata, u8 *data,
 		return -1; /* Buffer was full, return failure */
 
 	/* Write the frame to the buffer */
-	xemaclite_aligned_write(data, (u32 __force *) addr, byte_count);
+	xemaclite_aligned_write(data, (u32 __force *)addr, byte_count);
 
 	xemaclite_writel((byte_count & XEL_TPLR_LENGTH_MASK),
 			 addr + XEL_TPLR_OFFSET);
@@ -448,7 +448,7 @@ static u16 xemaclite_recv_data(struct net_local *drvdata, u8 *data, int maxlen)
 		length = maxlen;
 
 	/* Read from the EmacLite device */
-	xemaclite_aligned_read((u32 __force *) (addr + XEL_RXBUFF_OFFSET),
+	xemaclite_aligned_read((u32 __force *)(addr + XEL_RXBUFF_OFFSET),
 				data, length);
 
 	/* Acknowledge the frame */
@@ -479,7 +479,7 @@ static void xemaclite_update_address(struct net_local *drvdata,
 	/* Determine the expected Tx buffer address */
 	addr = drvdata->base_addr + drvdata->next_tx_buf_to_use;
 
-	xemaclite_aligned_write(address_ptr, (u32 __force *) addr, ETH_ALEN);
+	xemaclite_aligned_write(address_ptr, (u32 __force *)addr, ETH_ALEN);
 
 	xemaclite_writel(ETH_ALEN, addr + XEL_TPLR_OFFSET);
 
@@ -574,7 +574,7 @@ static void xemaclite_tx_handler(struct net_device *dev)
 	dev->stats.tx_packets++;
 	if (lp->deferred_skb) {
 		if (xemaclite_send_data(lp,
-					(u8 *) lp->deferred_skb->data,
+					(u8 *)lp->deferred_skb->data,
 					lp->deferred_skb->len) != 0)
 			return;
 		dev->stats.tx_bytes += lp->deferred_skb->len;
@@ -619,7 +619,7 @@ static void xemaclite_rx_handler(struct net_device *dev)
 
 	skb_reserve(skb, 2);
 
-	len = xemaclite_recv_data(lp, (u8 *) skb->data, len);
+	len = xemaclite_recv_data(lp, (u8 *)skb->data, len);
 
 	if (!len) {
 		dev->stats.rx_errors++;
@@ -1032,7 +1032,7 @@ static int xemaclite_send(struct sk_buff *orig_skb, struct net_device *dev)
 	new_skb = orig_skb;
 
 	spin_lock_irqsave(&lp->reset_lock, flags);
-	if (xemaclite_send_data(lp, (u8 *) new_skb->data, len) != 0) {
+	if (xemaclite_send_data(lp, (u8 *)new_skb->data, len) != 0) {
 		/* If the Emaclite Tx buffer is busy, stop the Tx queue and
 		 * defer the skb for transmission during the ISR, after the
 		 * current transmission is complete
-- 
2.7.4

