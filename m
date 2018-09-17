Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6882ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6918F214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="L58t7IqY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6918F214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbeIQTxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 15:53:38 -0400
Received: from mail-dm3nam03on0047.outbound.protection.outlook.com ([104.47.41.47]:36846
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728838AbeIQTxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 15:53:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZ3NeCBybdN9/05ncCfixJY8fgpgVOMpej2+0X+NoZM=;
 b=L58t7IqYmwZLgzotKWB1KJqVQer9cEA2bPJ3hetWX6mwwgJKGhqtvhkTHT+ZG7d99qIoMTATMMkaBQM7G74/2LNvB/6Hxaebm9SGGgcUryLWn00nOPB9pLoel9Uu1TucJBS0dnF8KY/4VFN39IaxHOGmqJlMS7OW1NEBTnRcsxU=
Received: from CY4PR02CA0031.namprd02.prod.outlook.com (2603:10b6:903:117::17)
 by BL0PR02MB4756.namprd02.prod.outlook.com (2603:10b6:208:5d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.15; Mon, 17 Sep
 2018 14:25:42 +0000
Received: from CY1NAM02FT036.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::207) by CY4PR02CA0031.outlook.office365.com
 (2603:10b6:903:117::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1143.15 via Frontend
 Transport; Mon, 17 Sep 2018 14:25:42 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT036.mail.protection.outlook.com (10.152.75.124) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1164.13
 via Frontend Transport; Mon, 17 Sep 2018 14:25:40 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:36885 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1g1uT6-0000sX-Da; Mon, 17 Sep 2018 07:25:40 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1g1uT1-0005Mt-A4; Mon, 17 Sep 2018 07:25:35 -0700
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8HEPRKD003541;
        Mon, 17 Sep 2018 07:25:27 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1g1uSs-0005La-Gu; Mon, 17 Sep 2018 07:25:26 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 2CF12121463; Mon, 17 Sep 2018 19:55:26 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>, <bp@alien8.de>,
        <mchehab@kernel.org>, <michal.simek@xilinx.com>,
        <manish.narani@xilinx.com>, <leoyang.li@nxp.com>,
        <sudeep.holla@arm.com>, <amit.kucheria@linaro.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-edac@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v7 7/7] edac: synopsys: Add Error Injection support for ZynqMP DDRC
Date:   Mon, 17 Sep 2018 19:55:05 +0530
Message-ID: <1537194305-9243-8-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1537194305-9243-1-git-send-email-manish.narani@xilinx.com>
References: <1537194305-9243-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(396003)(346002)(136003)(2980300002)(438002)(199004)(189003)(426003)(476003)(5660300001)(50226002)(2906002)(486006)(2201001)(6666003)(36756003)(52956003)(446003)(11346002)(106002)(63266004)(6266002)(8936002)(81166006)(81156014)(126002)(2616005)(51416003)(103686004)(478600001)(72206003)(106466001)(26005)(44832011)(305945005)(110136005)(7416002)(54906003)(186003)(50466002)(42186006)(14444005)(16586007)(8676002)(90966002)(316002)(47776003)(356003)(336012)(76176011)(36386004)(4326008)(48376002)(107986001)(5001870100001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4756;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT036;1:rUR6nVWWK0QJH76PDLDgbgD5eHW5xK2WQlG8DZplcP8y46HT2q4WHbazO9rDWON6guE5l7mnDt67g21dV/pk7LECQrzTP9vjz6DVYWZ4IH8pnTqN0k8qcKQAGKPM6Oq0
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1218df5a-ac2b-4ffa-70db-08d61ca972bd
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BL0PR02MB4756;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4756;3:tpp2XI/nEkj9xWDnBM8RKwNyBUn5v/SlWO3TU6Dhf1/J/MNxJgYTh2SQ/HbpjFaerZ8VtyntsesDzcbLxKipNwDiyy80jkgIEHw8duwj9dE5qxicnhtxa/rX6YXibCeIHdYFhJSWLwMaMmP0VMxuIgSLvUJwt6r5gKb3LfuKpP5b9kP48TfvuHrFT+cSQV2fkteo5ENRFdaz2ny3SwQrIPl9sAx6vaet4MbkIdvJ4fKCWNtNoUZf0oAz0AQY2t57Kfg8TiX31kohfcPoDgICBPclP9sjlNBcYEtToMQ56SFE8DrjKC7dsh8nbcSesdpkRh5k2YG9uRawGGu1+c83H4X3shuu6xrFmvUVJ/w16bY=;25:BaoGd4h9vrK60jAYpsWu3XLRRtC14IzxXTxhH4vyJXix+t/h1E4C0bHHWK0GP71K4LsDaXTUPy4YYwATbjtjN3FEFISWWDWm59jVysFMwc4aiD1L1MFZyWqohU4hfXq/kWDNw+fumeJesIZ3m5Jk0yFvG/uGqRUEP3hHo0IXwUXucHpj0p8Zrvn+aNOAxmt7b6FXWr5EjKCT9ST1svcYnf+DdV0hASgC7gNiJbXGyvF0FEUd8f4V7y9SWeU1h4NCP7ld2zBNaxXz0GkrwT4oRvyiMugYTMS71kqSO17Zl8kesgaSXbt392waEAc1R56Nk5ktt4JKqX/Bat1jDwT4yA==
X-MS-TrafficTypeDiagnostic: BL0PR02MB4756:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4756;31:u+WXrF593epNdwbIXYNN1SI0IwbJBF+7r23x1W3/3ysf790EP+ucbc+ccKmK8LjFyhJ37n1rkKgjYk+29FaovnIstBjtGrev6i5eZz1jTAPub8IAPV1/pYRzic1+0vezCutx1zgkRCpdz1q+u1CII6xXIFsCSsQ3adJeDEQBIv8m+Cm73InTAcHiUuGbHS3POwaZDsbL0kPdmMtJJRosILG5b6mg4gzT8/sDz5wrAoQ=;20:XsZCV+mbGoMd3qYx9wHhFr38BDOfiWJCcAQ3HQJ5A05E9Bm3v2zjAmrCNt13icD19tGc4gkrMdzbNsyAcwvrR8gO+7Ux0ghLea91/c7LpkuvjPhkv8hzvHE5Kcb0WLHQy95A6o9xxPgugcpgV8aSf2j+B7j7SX/7BSXTNz/g/p1+slNCVQVV3xT7lYiXdExVRw3pv5Zn8E/YSE/0pYxLXf1o3qfIQwn3ruWW4M411xCQFnEWxoVtKaNVUoAkGzy6Zr0AE5WJukgjcEBCPc9/5cDhpJBdkl4/h2p6ETaCYYlcubBrSLdJbfA0VXtEXaMQvZgCvrCyktpUpiHUJH3Eaf3YDcFDRiYGQLCv3u+2gKectCJXJzcquU0kDY0/SzOwOIE88JC1+CymOST4Kn4P5uqoc2BtQJtINc8B4V0p87PH8OBoJvrmlJ241qroqmEccVs1H/JRQeke/7cl6cEv4jMV6aG7xJUl8Sij3DNfUgZuDnPpalaKuBVkCEvJsO6P
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL0PR02MB4756E058511D0C72B698F438C11E0@BL0PR02MB4756.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592)(105169848403564);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(10201501046)(93006095)(93004095)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050);SRVR:BL0PR02MB4756;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB4756;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4756;4:q1QffTnv+c/FPxA2XFz5m5OIr+U+ArbUo8DhGjJafSRlJy5eA0fjcUVc/s72m5YXlxru8pAkfaeSfV+ZAXMXTPn7ej3ri+U46c/mN8tj3md2X1PLi65IBNFgd3hhJmhkuNiOXJNyCttDjz8ueYke75DV7PmpBK2/q1kr/H9vVyny9BpqbBVxzhPCAINM4SEeHnedA2v6DCY+8apIkfw26tYnVUVqf0lEvTeV5C7Uv5zPl28mJ4Yhdxo0uuF+Jasf4vyMj5qvk+7YedA4+a2n6C96LnU85+bCqcccyfxxL6FbqDAR6sXr0j7cvKLeLjhTMg323S0/wSu/cfZaeLHfhI/15wwxbZ9ptDEsA+Osbpw=
X-Forefront-PRVS: 0798146F16
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR02MB4756;23:EdYccz3uvAxtceYpWBKoHAMZScRIcghaGn2kzLalO?=
 =?us-ascii?Q?ulgYwZjyYBZQ9nzKc6tUhGD1DVsiC0ur3qYFFJ02dKiqz6xY+b0P5ZJFOWOu?=
 =?us-ascii?Q?YXeQwqGu7V+EI5OCyGnprHjxQgyFZ26cO7PG7zMQSIJEMLV0i/FcrfIghUY7?=
 =?us-ascii?Q?05ZWGt2GS8UJfVOTmApavFpSRv7fGz8q1HKfcZNwHDPpLgG/2OjqnsQD2mTY?=
 =?us-ascii?Q?XUlPYlJnsWsbcApovoQjEXo00ryZ9QAcJuUKYOcH3kRI+p3r7F7bCZ2u3hx6?=
 =?us-ascii?Q?KU7UhvDw18J4Ngi5jDvue0PJSkBKOrIkOkwlq+BfPkvY+CA6Bq2G5Pk5BWqE?=
 =?us-ascii?Q?QP3ZMKTn0KgrSeCYX4Z/UdHnFEz9E9g92/6JBEy2xX+tJRgZ6CnyuI4GfiN5?=
 =?us-ascii?Q?vbpGulqFHVmwF4KdYMp27i4zUdVD9cF9Zcdyk+lbX0Jcv9WVxMgnZbrrrvo8?=
 =?us-ascii?Q?107smMN9JSPowUqU/kYP4fxWG5dOBhXFQSD/oHn42l5FYWyrdvZ4LikK02Ym?=
 =?us-ascii?Q?EZQc1jJbC44ZUCX9xr4yHwHTWZDqQk3D6pqbJ5bkfWIYesLg34nEfCd4LI7e?=
 =?us-ascii?Q?6Kzgzg9jHJNOuDpXUUgmx4IR88oB5FiAolPPKLL7knMcGfXWNKEKyk5Rdi5V?=
 =?us-ascii?Q?lOAsY3Pu88+oBnapSmBIXu8Fqxfb0mr+jiLdIISdro0teVmFOMTLol7m7brH?=
 =?us-ascii?Q?ZBs4ACRqRjj7p6+oIYyzu/P2tS3ibCvlBsASq1tvQV7gPn7cAHb/HEdQQjfz?=
 =?us-ascii?Q?CF0XX0TNpnxRrVdX0VMoyfHhQthdPmO0atPikUXNOm7x7ad2jPCKDUCFOQNk?=
 =?us-ascii?Q?dCzCWLDQBM5OPaKMUqr/umWTuXuC/s1qQSCCn/lC1zTadXzrFw3XiaY/2utb?=
 =?us-ascii?Q?8SJI/hFrAa36IXHnvG9Teej1lHy0GVDQcd2ZGYQwSfrTxvvMkdcluOdufP2v?=
 =?us-ascii?Q?8toA87b97rrsSRo2tDH57FNZ0R0Q+ZOhBsjhTswTcOK++e6QLjbuM/IfVXDH?=
 =?us-ascii?Q?oRuFOR4KMdRelvAxof5sm4waeX1hrJV/ZIIzYUf5iIJ8Na/OCPtzo4H4cM7/?=
 =?us-ascii?Q?NHWS7LGYrGsEE0IV4fVQf1WT3ksbHvv83j3G0GEQ3RJNp4lda4SCqe1tsK7F?=
 =?us-ascii?Q?DmdMH8IF9ooB1OgTPo2gdkLy9xz6U8KTN+oxQziRpsaM3GK4CCm4Tzau/RZf?=
 =?us-ascii?Q?8v5DcIEVogfRB0dGdnOmTy3ukuXUfosD8PzkCD3UZNP56f8C+Awbg+FYaEsk?=
 =?us-ascii?Q?8z6MUxL3bKZL6Dx8BYngJ8jCtZTF1kim6gvQ7DG?=
X-Microsoft-Antispam-Message-Info: qmzOEh+R/M3nFYIIPTxQi6U8Mrn0PPF4hkCKzKXMZ+UyG6oeZBaOVfxoeT/yV1+vP/gL4FVAFP/IlOC3EB2XT76t3WBs5ksMjV6Xg2s3QEyHK04+S4cWwG/RtSgeJ4EuSQ+BG7TOuWWlkhUHCZkOe4d1TEUINA2y6WvUqNo9G1uHwIF17szfdhTcXR+78UK8pbmKQQK1jLMGvYVY3YCQlXJehP1s3FwR6ojba2ZwCu2oxZ4aMJ46QhEE+KoaOdCX1izcpwTLnL8llUZmr62HDVa5+kU2wd1ly5iTOjmk6bHBFdYdnz+F+TA1H/mJsmSwgn7IqDqlnwfwJenlCioiXUJ2XK5yH17GSzvqux3bhM4=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4756;6:w81FirT33DptTarWNS2mOeRNP+6hbuAIVaseCXC4/Tr7CUDYlgW4L1L+DI2Y0R9TDlm4iFyljWlDY/etEbIAkdkwqiqefUtNrECbfPb/EaMy5hgr8kXLJOdZC0X3NfKB0nD91ZYXOWHZnofZLjWj6H9PO5xqp36vmiVGg799MFfirR5+vqLNaVMj/rksDaOg9yZyD8tLRP+XlU0XaZb0vuRIGnIeriLhr6dBstLtToM7z9r+63fn7pEog1nzkDGlzwN+bIum5Fr1w8EQMsAbzmx0kH1CeOaBvxFGyLvOQZxtR/sX9Ga9zJVzZ+ZBcswzP2Vx7IT7de0Ebbw+ftXxDm4MDt2HpRkDbuIuRCAlnKpKKd0El/i/6yVIE844iPLY8YqidCo+yHRAT/BoVq5deb8hJZTi3Z/1It7BKKlSGbLDCK93l8LeBN9OvTpK478Fb/loVD2EIZYIl5dNYtU/rw==;5:GCL1h3iRGcX+DUiox1lBXyvJpQOKkX/SZSV2j8XamvkIL1C+V+Md/BLdBmVzEd98Bay9btT2rcXbpaSgu7PJSc3wm/3zRniGdd5145xZ/8uysTFQQjZwvGUCw87a1C6nG2aQQpKRt6ZA1vvI6bkA7NCLxPsQkYL2Ex1ckk8aDqU=;7:6catcl3C3iRg0/tFbaWRmXbJpuvM6jN538gAtjXiwu684LEV0t0rIug3e9YsK/a4UtNpi9nI0rrGjS+cq3Ei6uN/xhMQS3dk6w/oZOeIEddJgXmTf7Gxr2eCUK7xfwQBaVa/mbAJG0EpzHG++XvgnuuWJ1VFig9zWlZqEsmgoVPko8DXfJwkfWKzBGLNcWPOSivHCj5InZGMQdMDZg0wERLLtMvf0vgS+8Wtm3okSKOiqtPQFVUAu72BJiZd2O2u
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2018 14:25:40.8322
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1218df5a-ac2b-4ffa-70db-08d61ca972bd
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4756
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Error Injection for ZynqMP DDRC IP. For injecting
errors, the Row, Column, Bank, Bank Group and Rank bits positions are
determined via Address Map registers of Synopsys DDRC.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/edac/synopsys_edac.c | 423 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 417 insertions(+), 6 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 7ab5b9a..177b5c3 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -302,12 +302,18 @@ struct synps_ecc_status {
 
 /**
  * struct synps_edac_priv - DDR memory controller private instance data.
- * @baseaddr:	Base address of the DDR controller.
- * @message:	Buffer for framing the event specific info.
- * @stat:	ECC status information.
- * @p_data:	Platform data
- * @ce_cnt:	Correctable Error count.
- * @ue_cnt:	Uncorrectable Error count.
+ * @baseaddr:		Base address of the DDR controller.
+ * @message:		Buffer for framing the event specific info.
+ * @stat:		ECC status information.
+ * @p_data:		Platform data
+ * @ce_cnt:		Correctable Error count.
+ * @ue_cnt:		Uncorrectable Error count.
+ * @poison_addr:	Data poison address.
+ * @row_shift:		Bit shifts for row bit.
+ * @col_shift:		Bit shifts for column bit.
+ * @bank_shift:		Bit shifts for bank bit.
+ * @bankgrp_shift:	Bit shifts for bank group bit.
+ * @rank_shift:		Bit shifts for rank bit.
  */
 struct synps_edac_priv {
 	void __iomem *baseaddr;
@@ -316,6 +322,14 @@ struct synps_edac_priv {
 	const struct synps_platform_data *p_data;
 	u32 ce_cnt;
 	u32 ue_cnt;
+#ifdef CONFIG_EDAC_DEBUG
+	ulong poison_addr;
+	u32 row_shift[18];
+	u32 col_shift[14];
+	u32 bank_shift[3];
+	u32 bankgrp_shift[2];
+	u32 rank_shift[1];
+#endif
 };
 
 /**
@@ -842,7 +856,12 @@ static const struct synps_platform_data zynqmp_edac_def = {
 	.get_mtype	= zynqmp_get_mtype,
 	.get_dtype	= zynqmp_get_dtype,
 	.get_eccstate	= zynqmp_get_eccstate,
+#ifdef CONFIG_EDAC_DEBUG
+	.quirks		= (DDR_ECC_INTR_SUPPORT |
+			   DDR_ECC_DATA_POISON_SUPPORT),
+#else
 	.quirks		= DDR_ECC_INTR_SUPPORT,
+#endif
 };
 
 static const struct of_device_id synps_edac_match[] = {
@@ -861,6 +880,380 @@ static const struct of_device_id synps_edac_match[] = {
 
 MODULE_DEVICE_TABLE(of, synps_edac_match);
 
+#ifdef CONFIG_EDAC_DEBUG
+#define to_mci(k) container_of(k, struct mem_ctl_info, dev)
+
+/**
+ * ddr_poison_setup -	Update poison registers.
+ * @priv:		DDR memory controller private instance data.
+ *
+ * Update poison registers as per DDR mapping.
+ * Return: none.
+ */
+static void ddr_poison_setup(struct synps_edac_priv *priv)
+{
+	int col = 0, row = 0, bank = 0, bankgrp = 0, rank = 0, regval;
+	int index;
+	ulong hif_addr = 0;
+
+	hif_addr = priv->poison_addr >> 3;
+
+	for (index = 0; index < DDR_MAX_ROW_SHIFT; index++) {
+		if (priv->row_shift[index])
+			row |= (((hif_addr >> priv->row_shift[index]) &
+						BIT(0)) << index);
+		else
+			break;
+	}
+
+	for (index = 0; index < DDR_MAX_COL_SHIFT; index++) {
+		if (priv->col_shift[index] || index < 3)
+			col |= (((hif_addr >> priv->col_shift[index]) &
+						BIT(0)) << index);
+		else
+			break;
+	}
+
+	for (index = 0; index < DDR_MAX_BANK_SHIFT; index++) {
+		if (priv->bank_shift[index])
+			bank |= (((hif_addr >> priv->bank_shift[index]) &
+						BIT(0)) << index);
+		else
+			break;
+	}
+
+	for (index = 0; index < DDR_MAX_BANKGRP_SHIFT; index++) {
+		if (priv->bankgrp_shift[index])
+			bankgrp |= (((hif_addr >> priv->bankgrp_shift[index])
+						& BIT(0)) << index);
+		else
+			break;
+	}
+
+	if (priv->rank_shift[0])
+		rank = (hif_addr >> priv->rank_shift[0]) & BIT(0);
+
+	regval = (rank << ECC_POISON0_RANK_SHIFT) & ECC_POISON0_RANK_MASK;
+	regval |= (col << ECC_POISON0_COLUMN_SHIFT) & ECC_POISON0_COLUMN_MASK;
+	writel(regval, priv->baseaddr + ECC_POISON0_OFST);
+
+	regval = (bankgrp << ECC_POISON1_BG_SHIFT) & ECC_POISON1_BG_MASK;
+	regval |= (bank << ECC_POISON1_BANKNR_SHIFT) & ECC_POISON1_BANKNR_MASK;
+	regval |= (row << ECC_POISON1_ROW_SHIFT) & ECC_POISON1_ROW_MASK;
+	writel(regval, priv->baseaddr + ECC_POISON1_OFST);
+}
+
+static ssize_t inject_data_error_show(struct device *dev,
+				      struct device_attribute *mattr,
+				      char *data)
+{
+	struct mem_ctl_info *mci = to_mci(dev);
+	struct synps_edac_priv *priv = mci->pvt_info;
+
+	return sprintf(data, "Poison0 Addr: 0x%08x\n\rPoison1 Addr: 0x%08x\n\r"
+			"Error injection Address: 0x%lx\n\r",
+			readl(priv->baseaddr + ECC_POISON0_OFST),
+			readl(priv->baseaddr + ECC_POISON1_OFST),
+			priv->poison_addr);
+}
+
+static ssize_t inject_data_error_store(struct device *dev,
+				       struct device_attribute *mattr,
+				       const char *data, size_t count)
+{
+	struct mem_ctl_info *mci = to_mci(dev);
+	struct synps_edac_priv *priv = mci->pvt_info;
+
+	if (kstrtoul(data, 0, &priv->poison_addr))
+		return -EINVAL;
+
+	ddr_poison_setup(priv);
+
+	return count;
+}
+
+static ssize_t inject_data_poison_show(struct device *dev,
+				       struct device_attribute *mattr,
+				       char *data)
+{
+	struct mem_ctl_info *mci = to_mci(dev);
+	struct synps_edac_priv *priv = mci->pvt_info;
+
+	return sprintf(data, "Data Poisoning: %s\n\r",
+			(((readl(priv->baseaddr + ECC_CFG1_OFST)) & 0x3) == 0x3)
+			? ("Correctable Error") : ("UnCorrectable Error"));
+}
+
+static ssize_t inject_data_poison_store(struct device *dev,
+					struct device_attribute *mattr,
+					const char *data, size_t count)
+{
+	struct mem_ctl_info *mci = to_mci(dev);
+	struct synps_edac_priv *priv = mci->pvt_info;
+
+	writel(0, priv->baseaddr + DDRC_SWCTL);
+	if (strncmp(data, "CE", 2) == 0)
+		writel(ECC_CEPOISON_MASK, priv->baseaddr + ECC_CFG1_OFST);
+	else
+		writel(ECC_UEPOISON_MASK, priv->baseaddr + ECC_CFG1_OFST);
+	writel(1, priv->baseaddr + DDRC_SWCTL);
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(inject_data_error);
+static DEVICE_ATTR_RW(inject_data_poison);
+
+static int synps_edac_create_sysfs_attributes(struct mem_ctl_info *mci)
+{
+	int rc;
+
+	rc = device_create_file(&mci->dev, &dev_attr_inject_data_error);
+	if (rc < 0)
+		return rc;
+	rc = device_create_file(&mci->dev, &dev_attr_inject_data_poison);
+	if (rc < 0)
+		return rc;
+	return 0;
+}
+
+static void synps_edac_remove_sysfs_attributes(struct mem_ctl_info *mci)
+{
+	device_remove_file(&mci->dev, &dev_attr_inject_data_error);
+	device_remove_file(&mci->dev, &dev_attr_inject_data_poison);
+}
+
+static void setup_row_address_map(struct synps_edac_priv *priv, u32 *addrmap)
+{
+	u32 addrmap_row_b2_10;
+	int index;
+
+	priv->row_shift[0] = (addrmap[5] & ROW_MAX_VAL_MASK) + ROW_B0_BASE;
+	priv->row_shift[1] = ((addrmap[5] >> 8) &
+			ROW_MAX_VAL_MASK) + ROW_B1_BASE;
+
+	addrmap_row_b2_10 = (addrmap[5] >> 16) & ROW_MAX_VAL_MASK;
+	if (addrmap_row_b2_10 != ROW_MAX_VAL_MASK) {
+		for (index = 2; index < 11; index++)
+			priv->row_shift[index] = addrmap_row_b2_10 +
+				index + ROW_B0_BASE;
+
+	} else {
+		priv->row_shift[2] = (addrmap[9] &
+				ROW_MAX_VAL_MASK) + ROW_B2_BASE;
+		priv->row_shift[3] = ((addrmap[9] >> 8) &
+				ROW_MAX_VAL_MASK) + ROW_B3_BASE;
+		priv->row_shift[4] = ((addrmap[9] >> 16) &
+				ROW_MAX_VAL_MASK) + ROW_B4_BASE;
+		priv->row_shift[5] = ((addrmap[9] >> 24) &
+				ROW_MAX_VAL_MASK) + ROW_B5_BASE;
+		priv->row_shift[6] = (addrmap[10] &
+				ROW_MAX_VAL_MASK) + ROW_B6_BASE;
+		priv->row_shift[7] = ((addrmap[10] >> 8) &
+				ROW_MAX_VAL_MASK) + ROW_B7_BASE;
+		priv->row_shift[8] = ((addrmap[10] >> 16) &
+				ROW_MAX_VAL_MASK) + ROW_B8_BASE;
+		priv->row_shift[9] = ((addrmap[10] >> 24) &
+				ROW_MAX_VAL_MASK) + ROW_B9_BASE;
+		priv->row_shift[10] = (addrmap[11] &
+				ROW_MAX_VAL_MASK) + ROW_B10_BASE;
+	}
+
+	priv->row_shift[11] = (((addrmap[5] >> 24) & ROW_MAX_VAL_MASK) ==
+				ROW_MAX_VAL_MASK) ? 0 : (((addrmap[5] >> 24) &
+				ROW_MAX_VAL_MASK) + ROW_B11_BASE);
+	priv->row_shift[12] = ((addrmap[6] & ROW_MAX_VAL_MASK) ==
+				ROW_MAX_VAL_MASK) ? 0 : ((addrmap[6] &
+				ROW_MAX_VAL_MASK) + ROW_B12_BASE);
+	priv->row_shift[13] = (((addrmap[6] >> 8) & ROW_MAX_VAL_MASK) ==
+				ROW_MAX_VAL_MASK) ? 0 : (((addrmap[6] >> 8) &
+				ROW_MAX_VAL_MASK) + ROW_B13_BASE);
+	priv->row_shift[14] = (((addrmap[6] >> 16) & ROW_MAX_VAL_MASK) ==
+				ROW_MAX_VAL_MASK) ? 0 : (((addrmap[6] >> 16) &
+				ROW_MAX_VAL_MASK) + ROW_B14_BASE);
+	priv->row_shift[15] = (((addrmap[6] >> 24) & ROW_MAX_VAL_MASK) ==
+				ROW_MAX_VAL_MASK) ? 0 : (((addrmap[6] >> 24) &
+				ROW_MAX_VAL_MASK) + ROW_B15_BASE);
+	priv->row_shift[16] = ((addrmap[7] & ROW_MAX_VAL_MASK) ==
+				ROW_MAX_VAL_MASK) ? 0 : ((addrmap[7] &
+				ROW_MAX_VAL_MASK) + ROW_B16_BASE);
+	priv->row_shift[17] = (((addrmap[7] >> 8) & ROW_MAX_VAL_MASK) ==
+				ROW_MAX_VAL_MASK) ? 0 : (((addrmap[7] >> 8) &
+				ROW_MAX_VAL_MASK) + ROW_B17_BASE);
+}
+
+static void setup_column_address_map(struct synps_edac_priv *priv, u32 *addrmap)
+{
+	u32 width, memtype;
+	int index;
+
+	memtype = readl(priv->baseaddr + CTRL_OFST);
+	width = (memtype & ECC_CTRL_BUSWIDTH_MASK) >> ECC_CTRL_BUSWIDTH_SHIFT;
+
+	priv->col_shift[0] = 0;
+	priv->col_shift[1] = 1;
+	priv->col_shift[2] = (addrmap[2] & COL_MAX_VAL_MASK) + COL_B2_BASE;
+	priv->col_shift[3] = ((addrmap[2] >> 8) &
+			COL_MAX_VAL_MASK) + COL_B3_BASE;
+	priv->col_shift[4] = (((addrmap[2] >> 16) & COL_MAX_VAL_MASK) ==
+			COL_MAX_VAL_MASK) ? 0 : (((addrmap[2] >> 16) &
+					COL_MAX_VAL_MASK) + COL_B4_BASE);
+	priv->col_shift[5] = (((addrmap[2] >> 24) & COL_MAX_VAL_MASK) ==
+			COL_MAX_VAL_MASK) ? 0 : (((addrmap[2] >> 24) &
+					COL_MAX_VAL_MASK) + COL_B5_BASE);
+	priv->col_shift[6] = ((addrmap[3] & COL_MAX_VAL_MASK) ==
+			COL_MAX_VAL_MASK) ? 0 : ((addrmap[3] &
+					COL_MAX_VAL_MASK) + COL_B6_BASE);
+	priv->col_shift[7] = (((addrmap[3] >> 8) & COL_MAX_VAL_MASK) ==
+			COL_MAX_VAL_MASK) ? 0 : (((addrmap[3] >> 8) &
+					COL_MAX_VAL_MASK) + COL_B7_BASE);
+	priv->col_shift[8] = (((addrmap[3] >> 16) & COL_MAX_VAL_MASK) ==
+			COL_MAX_VAL_MASK) ? 0 : (((addrmap[3] >> 16) &
+					COL_MAX_VAL_MASK) + COL_B8_BASE);
+	priv->col_shift[9] = (((addrmap[3] >> 24) & COL_MAX_VAL_MASK) ==
+			COL_MAX_VAL_MASK) ? 0 : (((addrmap[3] >> 24) &
+					COL_MAX_VAL_MASK) + COL_B9_BASE);
+	if (width == DDRCTL_EWDTH_64) {
+		if (memtype & MEM_TYPE_LPDDR3) {
+			priv->col_shift[10] = ((addrmap[4] &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				((addrmap[4] & COL_MAX_VAL_MASK) +
+				 COL_B10_BASE);
+			priv->col_shift[11] = (((addrmap[4] >> 8) &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				(((addrmap[4] >> 8) & COL_MAX_VAL_MASK) +
+				 COL_B11_BASE);
+		} else {
+			priv->col_shift[11] = ((addrmap[4] &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				((addrmap[4] & COL_MAX_VAL_MASK) +
+				 COL_B10_BASE);
+			priv->col_shift[13] = (((addrmap[4] >> 8) &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				(((addrmap[4] >> 8) & COL_MAX_VAL_MASK) +
+				 COL_B11_BASE);
+		}
+	} else if (width == DDRCTL_EWDTH_32) {
+		if (memtype & MEM_TYPE_LPDDR3) {
+			priv->col_shift[10] = (((addrmap[3] >> 24) &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				(((addrmap[3] >> 24) & COL_MAX_VAL_MASK) +
+				 COL_B9_BASE);
+			priv->col_shift[11] = ((addrmap[4] &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				((addrmap[4] & COL_MAX_VAL_MASK) +
+				 COL_B10_BASE);
+		} else {
+			priv->col_shift[11] = (((addrmap[3] >> 24) &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				(((addrmap[3] >> 24) & COL_MAX_VAL_MASK) +
+				 COL_B9_BASE);
+			priv->col_shift[13] = ((addrmap[4] &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				((addrmap[4] & COL_MAX_VAL_MASK) +
+				 COL_B10_BASE);
+		}
+	} else {
+		if (memtype & MEM_TYPE_LPDDR3) {
+			priv->col_shift[10] = (((addrmap[3] >> 16) &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				(((addrmap[3] >> 16) & COL_MAX_VAL_MASK) +
+				 COL_B8_BASE);
+			priv->col_shift[11] = (((addrmap[3] >> 24) &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				(((addrmap[3] >> 24) & COL_MAX_VAL_MASK) +
+				 COL_B9_BASE);
+			priv->col_shift[13] = ((addrmap[4] &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				((addrmap[4] & COL_MAX_VAL_MASK) +
+				 COL_B10_BASE);
+		} else {
+			priv->col_shift[11] = (((addrmap[3] >> 16) &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				(((addrmap[3] >> 16) & COL_MAX_VAL_MASK) +
+				 COL_B8_BASE);
+			priv->col_shift[13] = (((addrmap[3] >> 24) &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				(((addrmap[3] >> 24) & COL_MAX_VAL_MASK) +
+				 COL_B9_BASE);
+		}
+	}
+
+	if (width) {
+		for (index = 9; index > width; index--) {
+			priv->col_shift[index] = priv->col_shift[index - width];
+			priv->col_shift[index - width] = 0;
+		}
+	}
+
+}
+
+static void setup_bank_address_map(struct synps_edac_priv *priv, u32 *addrmap)
+{
+	priv->bank_shift[0] = (addrmap[1] & BANK_MAX_VAL_MASK) + BANK_B0_BASE;
+	priv->bank_shift[1] = ((addrmap[1] >> 8) &
+				BANK_MAX_VAL_MASK) + BANK_B1_BASE;
+	priv->bank_shift[2] = (((addrmap[1] >> 16) &
+				BANK_MAX_VAL_MASK) == BANK_MAX_VAL_MASK) ? 0 :
+				(((addrmap[1] >> 16) & BANK_MAX_VAL_MASK) +
+				 BANK_B2_BASE);
+
+}
+
+static void setup_bg_address_map(struct synps_edac_priv *priv, u32 *addrmap)
+{
+	priv->bankgrp_shift[0] = (addrmap[8] &
+				BANKGRP_MAX_VAL_MASK) + BANKGRP_B0_BASE;
+	priv->bankgrp_shift[1] = (((addrmap[8] >> 8) & BANKGRP_MAX_VAL_MASK) ==
+				BANKGRP_MAX_VAL_MASK) ? 0 : (((addrmap[8] >> 8)
+				& BANKGRP_MAX_VAL_MASK) + BANKGRP_B1_BASE);
+
+}
+
+static void setup_rank_address_map(struct synps_edac_priv *priv, u32 *addrmap)
+{
+	priv->rank_shift[0] = ((addrmap[0] & RANK_MAX_VAL_MASK) ==
+				RANK_MAX_VAL_MASK) ? 0 : ((addrmap[0] &
+				RANK_MAX_VAL_MASK) + RANK_B0_BASE);
+}
+
+/**
+ * setup_address_map -	Set Address Map by querying ADDRMAP registers.
+ * @priv:		DDR memory controller private instance data.
+ *
+ * Set Address Map by querying ADDRMAP registers.
+ *
+ * Return: none.
+ */
+static void setup_address_map(struct synps_edac_priv *priv)
+{
+	u32 addrmap[12];
+	int index;
+
+	for (index = 0; index < 12; index++) {
+		u32 addrmap_offset;
+
+		addrmap_offset = ECC_ADDRMAP0_OFFSET + (index * 4);
+		addrmap[index] = readl(priv->baseaddr + addrmap_offset);
+	}
+
+	/* Set Row Address Map */
+	setup_row_address_map(priv, addrmap);
+
+	/* Set Column Address Map */
+	setup_column_address_map(priv, addrmap);
+
+	/* Set Bank Address Map */
+	setup_bank_address_map(priv, addrmap);
+
+	/* Set Bank Group Address Map */
+	setup_bg_address_map(priv, addrmap);
+
+	/* Set Rank Address Map */
+	setup_rank_address_map(priv, addrmap);
+}
+#endif /* CONFIG_EDAC_DEBUG */
+
 /**
  * synps_edac_mc_probe - Check controller and bind driver.
  * @pdev:	platform_device struct.
@@ -941,6 +1334,20 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
 		goto free_edac_mc;
 	}
 
+#ifdef CONFIG_EDAC_DEBUG
+	if (priv->p_data->quirks & DDR_ECC_DATA_POISON_SUPPORT) {
+		if (synps_edac_create_sysfs_attributes(mci)) {
+			edac_printk(KERN_ERR, EDAC_MC,
+					"Failed to create sysfs entries\n");
+			goto free_edac_mc;
+		}
+	}
+
+	if (of_device_is_compatible(pdev->dev.of_node,
+				    "xlnx,zynqmp-ddrc-2.40a"))
+		setup_address_map(priv);
+#endif
+
 	/*
 	 * Start capturing the correctable and uncorrectable errors. A write of
 	 * 0 starts the counters.
@@ -972,6 +1379,10 @@ static int synps_edac_mc_remove(struct platform_device *pdev)
 		writel((DDR_QOSUE_MASK | DDR_QOSCE_MASK),
 			priv->baseaddr + DDR_QOS_IRQ_DB_OFST);
 	edac_mc_del_mc(&pdev->dev);
+#ifdef CONFIG_EDAC_DEBUG
+	if (priv->p_data->quirks & DDR_ECC_DATA_POISON_SUPPORT)
+		synps_edac_remove_sysfs_attributes(mci);
+#endif
 	edac_mc_free(mci);
 
 	return 0;
-- 
2.1.1

