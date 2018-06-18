Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5253EC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA0DF208B3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="mpc9Qj2V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA0DF208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965135AbeFSF4C (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 01:56:02 -0400
Received: from mail-bl2nam02on0059.outbound.protection.outlook.com ([104.47.38.59]:4160
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751964AbeFSFz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 01:55:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gFI0Bb359RajYsl2LlY9a+iCpDcGa1wTgr1YH2H8PHI=;
 b=mpc9Qj2VsWsGgGq/QPfJ/8se9GFc+pxbv43/suLWne2cX5kIMIC6nkBcMKCkg2sNLyGTazS3BWDC4Lvm54PiZbm/rPtnsXU2CZfnTs5ttfbzj0x17+BQgkgiA1Jav6jU9EAXIKnI2s1Aacj67myxsdawBARQ0jG548PbrvLmeGA=
Received: from SN4PR0201CA0039.namprd02.prod.outlook.com
 (2603:10b6:803:2e::25) by DM6PR02MB4634.namprd02.prod.outlook.com
 (2603:10b6:5:21::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.19; Tue, 19 Jun
 2018 05:55:55 +0000
Received: from SN1NAM02FT013.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::203) by SN4PR0201CA0039.outlook.office365.com
 (2603:10b6:803:2e::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.863.17 via Frontend
 Transport; Tue, 19 Jun 2018 05:55:55 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT013.mail.protection.outlook.com (10.152.72.98) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.863.11
 via Frontend Transport; Tue, 19 Jun 2018 05:55:53 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:60978 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1fV9cO-0000Kk-9V; Mon, 18 Jun 2018 22:55:52 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1fV9cJ-0002dy-5m; Mon, 18 Jun 2018 22:55:47 -0700
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w5J5tkYm020559;
        Mon, 18 Jun 2018 22:55:46 -0700
Received: from [172.23.37.150] (helo=ubuntu)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radheys@ubuntu>)
        id 1fV9cI-0002dZ-5c; Mon, 18 Jun 2018 22:55:46 -0700
Received: by ubuntu (Postfix, from userid 13245)
        id 87BF53C7257; Mon, 18 Jun 2018 05:08:30 -0600 (MDT)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     <davem@davemloft.net>, <andrew@lunn.ch>, <michal.simek@xilinx.com>,
        <radhey.shyam.pandey@xilinx.com>
CC:     <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/5] net: emaclite: Balance braces in else statement
Date:   Mon, 18 Jun 2018 05:08:20 -0600
Message-ID: <1529320103-7711-3-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.4.4
In-Reply-To: <1529320103-7711-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1529320103-7711-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--7.993-7.0-31-1
X-imss-scan-details: No--7.993-7.0-31-1;No--7.993-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(346002)(376002)(396003)(2980300002)(438002)(199004)(189003)(6266002)(26005)(4326008)(63266004)(36756003)(186003)(356003)(106466001)(52956003)(103686004)(305945005)(50226002)(2906002)(2201001)(8936002)(478600001)(126002)(476003)(2616005)(11346002)(81156014)(5660300001)(336012)(51416003)(8676002)(81166006)(7049001)(426003)(48376002)(47776003)(486006)(446003)(50466002)(110136005)(106002)(54906003)(16586007)(42186006)(316002)(59450400001)(6666003)(90966002)(76176011)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4634;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT013;1:vIkdeh7cqKVGNWNnjkoKcqKUELKLzwwXYXPhKbw6i23hL1fd7AFeVfVlOrLKwxQe/DjD6b0SLZoqHZ3esSlJk4LSq6HXASy62lrcyAbtAWlmwXCb3aL7qoByjXu5mTxr
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25073b1a-9bf2-4b55-469c-08d5d5a95244
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(4608076)(2017052603328)(7153060);SRVR:DM6PR02MB4634;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4634;3:mVw2Dqh9+ak8PE7ocfwrQwVVum4sgtXnYq/0I2naAl0XBjVN37Q5gQBenL6memCxW00gMOoqJ4YkcbmHpJNwDnI6F2y0mRc0niLikwsornHv76f0oGC3tXjaqinQinKq2Li+X/fYCQ/09rmtG2KCZ6AvC83LbXcJ5qYSwX9E+U8pKauceXK740oUKId7mcrBdC5TfYnofQJh/5LzUgJS9Z6Usqq7tw88e+mGXZ2KPLpKajjaquu4VL3uOSWXgIT4Jmhrbs1aRlw/pEBHzlHI5KcylXHcrfkkQSfZhCXgoRP/jeoiZdGD2V4WJIj2mrP2S1tKwvX/x/j0DSIxp/YFaQ6t54Gu0/uZ+HF1Rbsy27c=;25:51RfVnyPzeZkyvVbATU2dV5VMjOjJcAzp3bbky5R7TyIHHBHozN/lW8frA/wsT80jYvCZfTXLGWljMoySColcYVjzAKTS/5KCVKo/d3gzWWmGjXQl+qf/1LkPVKmwfv9VlfSxcaXiQQTRYpGlIEqmvlwo3ByVM9JARyxz9EikGihQfwKKWlGdSqxwXLlq+nAA7Uj5XClkOl2AuSNSoIEOUBP5AKIGvoryEeXv52b8GXjH7q3GoQstIHYUTI83ugj8M4grqhREgojDwa4pYLw0TAEgzHb73CSjhPLzH1YU4jaj5SKwFBa+YsRLfc5/zFh3ahSqCM+quzj7bq1sb5BZw==
X-MS-TrafficTypeDiagnostic: DM6PR02MB4634:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4634;31:uifi7+xK4z6XC7eSCrMY26pgUJdQ2WPXUWzXGeQ0Dc/AONVGDFj/a5KPTilKuqh2Rp4FrO21Goa85GB5hnEMryO1oCFkN6aoJnhG001IusrgpEuBgb71IMPsUHD3ObQQ5tNShbyWTqAZVbJiJnfMy29DxqLqI3GpdYFTsUWeFQs2vv/PSchZ62GCO0b1bOg07dP5wvR3fRzS1U6rUyWGXp9GerA43RG3ptCmw+aLLsk=;20:9JmVCbBTs3xvEjoumf2nMkVW/ctz3T/h7SSJhrBecBbAhL5rqSN9nn/vAXfYkXNy3zvOIEcgGSDo5W2UjPGgTfptbJ9ytf7on4pyHQ4K96iUb6rMxtmOgYmPvOELtLxOxiuKhLt6KJgt1jUTdCPidVflIZrpMjXyXBNFQ9w8oIW3b6H06TT3pqh2tHAyapDJetChe7hQAgmdnZn4yNdM6s17LdOXsxclTjG+ODwyyVk6la0U9iHpwaKPtuRdBixuqrt6n0ZJ2yaKVWOc0nF/rx2xTThPoDTDwa27tljPPxNYNB6Pg5hWEHY0Dsr3y+ocIAIjMRIBRHfcqbEUQWNEnpTSjyuyUJlt90A+9a643M7VgMPUjTcfwoJDhuqj2e6ytBLNDJGmy0bJK05BMAVLtkWV/1Y9k4fyrWkfRmN6OurqWljhXB0MI6h+0Mjkd7HoYdc1wQRbU6He6k1S7rwpD5IdUYbhfQL8aRi4OfvXs1yd3t1TRW2qxCEIluzDTi7X
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB463434A5988D83AD58F85ABDC7700@DM6PR02MB4634.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93004095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DM6PR02MB4634;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4634;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4634;4:Uy/Qld3wEnOqhY9tzg3lVCSvEVCbpRmCb53SdbqoxI2gwLRCwDpAAkTAoPuwxASHi51soM46Ghjc2O28NvPhqYp72jIn9zykVxFNyRPmmj1Rgk1gfQb9Nl+4z6pM9HA6ZLA0iMk6QaYgoP+bcb8y9I6yX0H12NFFhSBC2ijFu9acCEbIc+746O/JHFQX3mYxvdGMgaiWJoEcTt6TQlnlStGWmUfzY1JBSuqdishiJrlxRWm42e8H40J42ulWPfcnU9erEykZgJF04TcQMUE8QLBYQcj7MWBwFYI2KL4xIskoTCNIjiCvF7XDTnh46UQV
X-Forefront-PRVS: 07083FF734
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR02MB4634;23:4jZYoh6mXA78hyNAWZvYqggdOTpVU7DvVMZwrk0+D?=
 =?us-ascii?Q?UtK47Xs4+RE/Wby8rykTiGAtwjXs59NVeBjpggbm7mmFBtM43zjszr8XDg/p?=
 =?us-ascii?Q?QQIy1Dp5wjZN0lUpqw7AHHdy0ayFUBsdsPuy/Vr6PoMifIxxIwdAudwq4LzQ?=
 =?us-ascii?Q?rHp1E3Qn/qftHE/mk/K+d+l2ng8PO4ktVN5j8rXG52bQOSbh7YTzIrD4n6Nf?=
 =?us-ascii?Q?Q3I5XXrWDQ6ui22L8yDHJ+W+R0VFMyb3//oWf8OzKVpiJir2CdiisuTh4ZSO?=
 =?us-ascii?Q?hGbVTUpdzIwvs4xrwsv1u1fbd+m/xIrBMHcOmgeZvmk0YAx877IVhL4t3/IP?=
 =?us-ascii?Q?xjjSyIfiaayAAQbch/B3WbcBGpfZZM2M88ykV1aIQNw2Uf9Ze2Gwo0bctBZ+?=
 =?us-ascii?Q?f/P0CtJ38Rh1VdzfhViAm6TiuFPx5a+yfrqbcktfC7X9scHGLUPwNEP+3SqV?=
 =?us-ascii?Q?u/HrgpRFfzjxYFturygpFShXgNwZ2QnwztKA7JUQqVWo+lRWbqkECkybn2l1?=
 =?us-ascii?Q?nKassrtQzBBP7VNozwuR2o3RtVyBp+awxJHqv9h+/ECPpxk5tDtFzF2m6TCb?=
 =?us-ascii?Q?4oAuSHHIjqvVXPpn+O7fYFKASyTCYoph1mRmbj+c7YnxxQFOdtVe5aKp84AJ?=
 =?us-ascii?Q?1miU994rBJSFjQxw1uqHA6G1E0AepjthMEgkAxd0Dv0CRxi0NQZgjtdvswIO?=
 =?us-ascii?Q?c/QgMQe7KWZN7ztwyoVJDmmH4aG7Aa6wUehQIrRHMPGhArLgcrjKbM7fxwyX?=
 =?us-ascii?Q?bKOflyFV4+7ZYuC6CZyRToJocvVv+/K23hXdiOuvUvcfNUUluSK2UOrIUIQs?=
 =?us-ascii?Q?G2T2Bmikk8APi6+UjVOZ30E0FrCZKmHFnWK476mj5O1d0PId/8jOzcugPWcx?=
 =?us-ascii?Q?Q98oFUf/TEF06sbRxovR9LZpwD2cvhBx/53smqC6McvUS1AogHN0xmvGJsAM?=
 =?us-ascii?Q?h/+FwD7SSrG52B8AvS/pMO2uikE2G9GC9N87IGyaOSW0VD9TuO4ulbX6bX/D?=
 =?us-ascii?Q?t7ZhRNgv2UVmDzRTo7suOp0V09qMBfoJ7EfF8BF9cWvzT+rmmc9gp5nqNDtA?=
 =?us-ascii?Q?4WmjyM7/H3FJf+CAoa4Op9ammX7dssdwtoOlQRN65W2addRYNakDE9qUOK5J?=
 =?us-ascii?Q?XoCXcyec3s2xiVY6XuUNg6k4W9Ww9bbJSs9Z84eNiob+cuz4OPt3xW5FFEv7?=
 =?us-ascii?Q?wfHNJH23BNDFElzwgwuwrueahZufuXwinP4?=
X-Microsoft-Antispam-Message-Info: fLrJ4/P4uVW47DbNvV3GDjjB/LDM6BMxT/Rgj0xeiWzBTvZrfYyfNT5B/liolXHIt7G7wIyDYvSUDT4+Wt/Q26XNxdNE6+z9dZICwbDd5AXxiqfxDKPrV2PIh0NOllO/5aeFbyRP78/84DN+pQWCQVQ9GqoxQ31IhkFxt8Asq7kkaEYNvqy5OT4xDbyj3ZQXPd+3koe6nFTskj/GtraRD6F8HiY0hMfHl5ygT3UK7c4YG6iUmeKrjBD1Rhlq99xkyaCVHUP0x3xhmyjnIMGatOfkD8+Ukrb42/Cslom5LLXYOWiJ8xsgY4zjgghmCeSm/BIHFk9GGdNRyf/wlPgAmA==
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4634;6:AepM+hCiEx2GqzhG2Pl5u/fcEOGyNunYt8CWyc8lNqjJj1VM47T/boKJHRT+rSazgYT4W0YNbzjxMTDY6Zjje0af+pOowX1m2alNKIS/CZio6RzRKcD0D21GbOzW45dho1Hkl67Bee15rh6SS0C0eHTutiAWIZKXF99M9kqMtDZpjUvdkkwB805w64aqqkhCNuY3loboSEjh227kTlEvIcr2rYS5Iq739scP2fkNxB2K3hydb2KiO8Cx8xBgI4ipD3tNwl4O8JgioKU6yFDfRwFJKQFHl0oRRlApOTdu4DOFfH/S9U3dW33N/ycaSBMqigib23z+fQZUmY5tk+VsluQo2G/XFCfjiIHOrTJ87NNifdbSH1lfHMHDdB9xSVvUzSL/B93U144mQBVlIIkqoPCBP8TyH8KDBPFd8EetECzQ3epGTgysVFyUGDC4LnJa5A2Qf/vxu9kmeOF+oY9Bog==;5:a7hbJElEc7olkZqqkUQNd40+DVpBaL1k8/iy915dFDmUewBTcuYsu20/q7zfu4D9bKN7/cJys68/mTE0rGINjyFs2qM5/THwTBhVZBSv5yNCIJfAePMZTU3dZkpV3GGNigkuQKZs0UMst9qE08Re0wAi8U+uTfePxqs0e2e9Jp0=;24:truuI/rtOGERQB+cNlPUMrW4RhMG6HaDQ+c1KOn+DfG9F2f+EaJLwD39e916kPtV7j0P1JauN0eOEziwqjaKEV/y5cXA7/OaM22lFvr/3no=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4634;7:ZZIX1EJ9Jxye/1zjV5jQMP/p/VpH7L0IXFhvDAklMVmZSdev6oBUuX13doBpgrEBTEGTbzgR6dUoar/SEine8yV8coOrgtP2DnoeRHjs9KXoWxZGeajEN/qcIS2U10IP7hPjhSqq086Wwi7qMvW+wduPb0sgh4kEtGI+nPWZkPdKZwrUmnTaiDaB2yLT3UVbsz5sG8nKRsXDCuWd3xwp13DhkMblbZXc1d0e/g8ZwwAyNU/jixQHol1TgX6cd3Sr
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2018 05:55:53.0438
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25073b1a-9bf2-4b55-469c-08d5d5a95244
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4634
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove else as it is not required with if doing a return.
Fixes below checkpatch warning.

WARNING: else is not generally useful after a break or return

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
 drivers/net/ethernet/xilinx/xilinx_emaclite.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_emaclite.c b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
index 0544134..8d84f58 100644
--- a/drivers/net/ethernet/xilinx/xilinx_emaclite.c
+++ b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
@@ -569,13 +569,11 @@ static void xemaclite_tx_handler(struct net_device *dev)
 					(u8 *) lp->deferred_skb->data,
 					lp->deferred_skb->len) != 0)
 			return;
-		else {
-			dev->stats.tx_bytes += lp->deferred_skb->len;
-			dev_kfree_skb_irq(lp->deferred_skb);
-			lp->deferred_skb = NULL;
-			netif_trans_update(dev); /* prevent tx timeout */
-			netif_wake_queue(dev);
-		}
+		dev->stats.tx_bytes += lp->deferred_skb->len;
+		dev_kfree_skb_irq(lp->deferred_skb);
+		lp->deferred_skb = NULL;
+		netif_trans_update(dev); /* prevent tx timeout */
+		netif_wake_queue(dev);
 	}
 }
 
@@ -1052,13 +1050,13 @@ static bool get_bool(struct platform_device *ofdev, const char *s)
 {
 	u32 *p = (u32 *)of_get_property(ofdev->dev.of_node, s, NULL);
 
-	if (p) {
+	if (p)
 		return (bool)*p;
-	} else {
-		dev_warn(&ofdev->dev, "Parameter %s not found,"
+
+	dev_warn(&ofdev->dev, "Parameter %s not found,"
 			"defaulting to false\n", s);
-		return false;
-	}
+
+	return false;
 }
 
 static const struct net_device_ops xemaclite_netdev_ops;
-- 
2.7.4

