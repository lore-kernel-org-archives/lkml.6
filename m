Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 7A42FC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 06:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C0CB208AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 06:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="2YAKZhEV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C0CB208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934194AbeFMGhP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 02:37:15 -0400
Received: from mail-cys01nam02on0056.outbound.protection.outlook.com ([104.47.37.56]:57322
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754487AbeFMGgG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 02:36:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=18N/ye4wiiO4w6PZcfTEoF0yZo3r4wLlU0we5e2zF3M=;
 b=2YAKZhEVE96qA/QNA2GSFMAMEVreQMmtD3AHelQRn4eyxnNA1hhdKF/LPx8MbfPflTLhk4wN4lwGCALR4GGHt2lBK9Cbs8Gy+z0FZw0V/9NIKFfK5kevVQOOM7CK0nBoYPaq2uwWGnE+sKZgcD4ZYNRxJvsC4uWPP3u74JJIau0=
Received: from MWHPR0201CA0023.namprd02.prod.outlook.com
 (2603:10b6:301:74::36) by BL0PR02MB4945.namprd02.prod.outlook.com
 (2603:10b6:208:53::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.14; Wed, 13 Jun
 2018 06:36:03 +0000
Received: from BL2NAM02FT047.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::200) by MWHPR0201CA0023.outlook.office365.com
 (2603:10b6:301:74::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.841.14 via Frontend
 Transport; Wed, 13 Jun 2018 06:36:03 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT047.mail.protection.outlook.com (10.152.77.9) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.863.11
 via Frontend Transport; Wed, 13 Jun 2018 06:36:02 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1fSzNx-0005SF-Nk; Tue, 12 Jun 2018 23:36:01 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1fSzNs-0001Z5-LR; Tue, 12 Jun 2018 23:35:56 -0700
Received: from xsj-pvapsmtp01 (smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w5D6ZsPD031117;
        Tue, 12 Jun 2018 23:35:55 -0700
Received: from [172.23.37.80] (helo=xhd-paegbuild40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radheys@xilinx.com>)
        id 1fSzNq-0001Yj-LN; Tue, 12 Jun 2018 23:35:54 -0700
Received: by xhd-paegbuild40.xilinx.com (Postfix, from userid 13245)
        id 25974B20953; Wed, 13 Jun 2018 12:05:53 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     <davem@davemloft.net>, <michal.simek@xilinx.com>,
        <radhey.shyam.pandey@xilinx.com>
CC:     <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/4] net: emaclite: Remove unused 'has_mdio' flag.
Date:   Wed, 13 Jun 2018 12:05:18 +0530
Message-ID: <1528871719-1681-4-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.4.4
In-Reply-To: <1528871719-1681-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1528871719-1681-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(39380400002)(376002)(2980300002)(438002)(189003)(199004)(106002)(305945005)(186003)(16586007)(26005)(126002)(478600001)(356003)(90966002)(8936002)(446003)(11346002)(6266002)(426003)(48376002)(2616005)(476003)(52956003)(50466002)(6666003)(2201001)(4326008)(336012)(106466001)(103686004)(54906003)(2906002)(63266004)(47776003)(81156014)(8676002)(81166006)(5660300001)(50226002)(36756003)(42186006)(316002)(36386004)(7049001)(110136005)(486006)(51416003)(76176011)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4945;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT047;1:vn5oRzShBU/SaRzXLdvGN2TOj3HZz4+YMfOFwvP28WVwQSzK31aFu7um0XXZATH1DKlU9TsxN7Iwu9fykOlntxgkoWmUUiHsatKxESvhNlXpcJ0DqKyX7D6+Fs1SGeuN
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47b449ba-0a68-45dc-d7ae-08d5d0f7eed8
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:BL0PR02MB4945;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4945;3:/9faqPe50OCdMtqaxRlxibTdDZXZLOQFQ1rSR6OgJriXi1wzWZW88UnZb6R+B+Nmp9454cbiAkiMOaVDwqQESMZyAD0nhmvRNX5D1YAZHXmQGOJKsT0Y09vsR1tBeQZYRjLNdKC2V8ffQZ0nsnUKyvQg4fG1vSoSJKljg1MZV19RtAvjeALXc0llTVzVDphpAXjtjhsccBM25twyCSRtuvtY1HdF25KXzDnLpM0b4amScsn8piPI3yNRE4njrRT9rliwr6G1/D+9kfg8jGGWuYApfP8fmVj6Lsagi+uaHrdRwBZZs+pZeKpRLuA2+/L9vxe53UF3YPzMA8bYGH7gkPGj2J2IoD1gXchq+/tLI6w=;25:4RrZay3QZdH8pGUnlo/w0h21dy01K3HJfUq4UKdCNf/fDUiw61NVX1CJhR2lPnUWru4RR8o1PIec9jJFKEv0VZaZ3oqYzdIOOaXkO9GdWRJqVoeV9vQ7OuaWJFPWKLSl1vzJ1Lz4jrzLbvOI0Kx5URYrpRcAy6yo14euU1j+jlIZNVLWalCI7gQKSgoNbBU9bqIbpEd981EMAeru1xXrpZ0K1bWgHb1Hu4MJTkNtNyFwdfoIN8D9ruT6HOs9AqWVb5QOiNWA6eIHlGufTlwpRKUG+qDD7eMBMn8mZtLbX0BlRE1HqxVbl/tyoKdy6LKGjd/9qclmg+difrEDKf8Q9g==
X-MS-TrafficTypeDiagnostic: BL0PR02MB4945:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4945;31:aroJzyO0noYg0AxYkxUSkZQci4jZes5XH9Tyw6peo10wng35XN1lqwt3htOm1TZd5NWTVenNMAQ9kqAr+RltGxHiq5ptIafEiPFrTvTr8UrAILoHm4yHUG98UfndpSZpTx5IH5lxee3ZTMeIhZfWLTL6H4mfM7SnOpdRvfl8h5opeAY0iw0nGbf6qijS9R86gw0CIx2qXGVPWORxg+M32fzcpaTp7OyVhJSxjdFBEV0=;20:1R19puS7qtfYGjBpNIJ8GwZY/NXmacdy6kODMlPAJhXo/i359MOHpmm3WmfHCFCqWKwqIy7pa5InutBvBjVNFIYmj/mcbItdkip69czk6GX55stTShIVjYmvKZeRFRhjjC6FSgKL6s5ujQre7MaD6/h7b+F8wC9LQhsTXYJzSULTr15JUFC+RdGWQq2nILCaNsXq3pb9DIAQXUaD7MsDU8JwzzWynaPvsD3hFIy+jBeOdEsQtavODli8G+2hpcINksS+HEtivdcHNT7HrLHHDb15GYBzzlddifvE/d3+Fi3WKHsPbqqWJR+lTlCKYAj9nz5ghqDWsAJRJ9eulmObgEENd/N3UZSb/CdPtTzhsQLmKsC5qN6dNEEd/5e/YSBvI3msEiCD5ok08Pme+i6AIvaVuB7rBLkMMY6PLtCv6jSaDPpg5cBwVwvletkKNvlbZhHVcjIxvjq3nlhgNOjBfZHeEdMGVtcop3Y3Kjd/NBNPgneN933hoGZcOkA0Gkbu
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL0PR02MB4945BBD3C6B6C42B2A33C90DC77E0@BL0PR02MB4945.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231254)(944501410)(52105095)(93006095)(93004095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BL0PR02MB4945;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB4945;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4945;4:LQbg4oYXk/GO7XmY6rSHK5S+uw4VLaZAkP4Z6Bx49RkrQBmkQ5otZcqfI3WBKbYa5+N2sORcEkRKKOJFugS+tOxsFiIEx8w+VGx1prwcl/VGF+3JMBn9LtRFL/Tbu+OQS9UVV2FaBKbrtmeWlwb5yz1FaQcU0Ht6Km7cRnBL1zHQ+jqak4BbG2FYYAtdBQX3AZXA3SPCOCwFLLbvqerrAkdQO40G1GM83t1uyOIDpIa4QYLOTzrAOzQCoI4e7BFmFk+cnotevcLYsyWieEv6j5Xcr7k6xV7oYoOuRzTKKJwHuEgxV0cpTdg7g455LqJ9
X-Forefront-PRVS: 07025866F6
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR02MB4945;23:lTOt8D1wC6fn7ZacSDB63DSAWHOrsdcakl4FxambO?=
 =?us-ascii?Q?Xs2bzCKtrjZCuAuasx6RwVH8h2Rn+Nq4Z1zY1xOMF+DGCqMV9boXVPgREnjV?=
 =?us-ascii?Q?hvR55JTsZ8FQ8MEBfR20WGqibbjYqtUpXGHi8xwIvUr8P59i6e+31D6Kler1?=
 =?us-ascii?Q?4vvq9lEKQv+By0f4Oy/Ri0GrPiKfEfTz4ZDys6kU0sFfi2qCU/GBIqhvgUjU?=
 =?us-ascii?Q?O+V+tkR/2+s87m61wNqLF7ofE+RqjbrsziFogBlqXwJPdgo2aR5YJr+yp6Hv?=
 =?us-ascii?Q?2qtlnrlYh+PiNarw68KT0bevwiwta6ejmkLFt8qY0gkiU87pAKR8zuh0s61O?=
 =?us-ascii?Q?8HkAC7oAubh0Gxbv065KrKrsy8bTRb6oQkBFOworNnO5APZe1EuYW8t85Cgo?=
 =?us-ascii?Q?/7vF8Q9ZpqOBjB/uPKoGWhnE6/qqfPzNgE5c7WaLwAVgaLuPAuiJs/Wp53iS?=
 =?us-ascii?Q?yj1VQvv1yvxqarMJwWPKRtWlaDBBOtYW7O3lMsBkvZhLHFM6tEVDwa32oWuT?=
 =?us-ascii?Q?77wWBrw/CcYXu9CPtvtaMtueGbE5bnQl27/mkgeG9PpKSxyRee1vJLudTUpX?=
 =?us-ascii?Q?4cnqT8BKSZ7FRNX0aOnR+1XSAh5iR1E87PhxqtOiEW7SVcJcF0LWQ4YSfIy4?=
 =?us-ascii?Q?/edVxeXGI1zfHXv7b7Re0y1WGqtEnw2/EZ6/Iw2rzlq4138vaPdYZyblzCVu?=
 =?us-ascii?Q?YJnzAAlO2IKJAUK+r3Gvo5K+42Y8qXgYYqXzN1STLoHDIRmeDGI8EIE0o6d1?=
 =?us-ascii?Q?8mdfAuxvJ9ixcuR7d2DBIuSbtIswHv9EwElxiul+C0UcSXi3reL7ef6VBWLe?=
 =?us-ascii?Q?LGn7u2kUr8UU9v3t+z/vCKkbYPffNP2CVCJExBtl4UA6Hb5xV5q9nEIgY+D3?=
 =?us-ascii?Q?r1Jxnqau2maWOv9AWDeLeRXrwLa6GcjF0PdDG41appn6vOrsvsNzBaOXA08S?=
 =?us-ascii?Q?P/OINjcQYDb49/jNRdx3kn8xEjyPe96/G0tDuTPb3Al6TtAVI/C3FpcoeEYE?=
 =?us-ascii?Q?OAaXDYqCg1N0yFbRlvGb4sFrld4oaTX/GOo//yATCXUMmXLt4HyEMrkpKYRm?=
 =?us-ascii?Q?wG+NcN7nJaUDlfszxD9iZxlXGtF0Y3ziRPNsBCwn5dJSw5Qx49N43BB+ywnw?=
 =?us-ascii?Q?TusPOtLaNqA7nu2VGE4zzre2R2uopemEjREKo2370V7Zkci8pFynlpmR1JMw?=
 =?us-ascii?Q?5hVHrbNZ5OPgy4=3D?=
X-Microsoft-Antispam-Message-Info: LBPFt8vmFo9u1w1/rqXgyzAySM8jPUSr/yJVtkbR3YIxtMmb+B2kdCB9EwTfqqTTILY+UrK6/AAOR+2vWMVEuxxEvkE/k9OaBaVnzKHuZSx+dJX0FlnvCcLeGjvMVj7bLoX0aA+/Q6q7+G7u4HxoMIIBQOGQYZOuqc7JkCgJCtXEHIRR3n4nIpFH2aMqMO03
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4945;6:Q4WVt6pfTQPD38qNH6YtrHtRomVXGttyaz64T9tvSxn6E8+PcxC2QHA6wIS4Jy94X7Pc/c6IMnPJtXXKfchlkWcm2uU+ceQktmUHgbb0TL16/xeU403MhbYYoaws9GsuzSUF3bTSK6BD9vhrdGvFzWcR593I9yOAE5jiGGYAt3aLy1bZbmc2lh9BR64Pk5q0f5jbptGAefP76/Ah3Ffn90/6CnPG+0hNzuZmEXIpKslgFx8+CbDrwohD246Tlqnt9nDX8PKPBB7pql7zT+L1JE99xliaVe0bSaPiWIThCguTpTbWnZP5exIs0u2C7oN/sGkqXOXPGa37lCgOk1SuaJpgOxN9z1IEfeAVvWjPIlHV/mFvOsZnC9gZxhIhRaIj28bhr7cve6tsn33a4r4iovPTejYrtaschPpZbdg9YHozrtrv7zwVxTNGQbHeek7EZV7oJUZ20CKjbXr5JAdx5Q==;5:SGSHoJiYwVparssOqBklhTW9sDkYMvCc6sGYGTD7Ptgwp+eb7i9tA6oFRY1f+7JvhZgn69oxP4Yg0UK6VPqIfISxxn18FXtay6L6lg7TMqrki1XeuVo/P+52ed6wW6le0wZfpzEQA0mGfeoCKl6fsOkdHz7UdXqCNSU0NPdwS3M=;24:AIGmvPcdz60naD8PZhpZSObh3eqE/E8LaBARs9Waiv1i372QmGgZhD2vifmrJUGgNy2xchyz5I9+pyvv4qn/AwCwPl/So89lAlDT6l2l92g=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4945;7:knDVax+wnSlxo28XfCqqtoAMZRwlWIJ0Undw78EA3z5ZYRbfolucdqoHkeGpSShqemC/169TAQOo8oTsk13rqdfPqvygctaxj9UHgLDPZC7x4y3JDcBnkgKFQMjntoO4PQGkIT4mUoMfgrhAbzSoKoq0NP2wALTloDCGmFl/IpS4mpobFccTw4Nel5MAH74PpkHdFDhjovDfQyd6PxqL5V1KC5WooaeDaq3AymsTWTXTnqEsS09udfi8Mo7tjHYm
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2018 06:36:02.3606
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47b449ba-0a68-45dc-d7ae-08d5d0f7eed8
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4945
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused 'has_mdio' flag.

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
 drivers/net/ethernet/xilinx/xilinx_emaclite.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_emaclite.c b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
index 06eb6c8..ec4608e 100644
--- a/drivers/net/ethernet/xilinx/xilinx_emaclite.c
+++ b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
@@ -123,7 +123,6 @@
  * @phy_node:		pointer to the PHY device node
  * @mii_bus:		pointer to the MII bus
  * @last_link:		last link status
- * @has_mdio:		indicates whether MDIO is included in the HW
  */
 struct net_local {
 
@@ -144,7 +143,6 @@ struct net_local {
 	struct mii_bus *mii_bus;
 
 	int last_link;
-	bool has_mdio;
 };
 
 
-- 
1.7.1

