Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C539EC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AAD621501
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="mEgUyB+3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AAD621501
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387512AbeHBOnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 10:43:24 -0400
Received: from mail-eopbgr720061.outbound.protection.outlook.com ([40.107.72.61]:57072
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387413AbeHBOnX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 10:43:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dwdLYzS14lHZ+n/PkTMp6RZfb9Pc/zl/GGMcWr3nJwE=;
 b=mEgUyB+3W//DYk0JJc+6UG3hARURJR2lcjQi6Ys4x1x12KzTsEqBGpoaz85viZkpAPYPIGNfKpZnzaMR2McJnecev8qH41/hkcKK4ivwgxbbjQSCZc9wOSgDn4GIEqFtsBBWoNRuempBsBalITNrwqU2JbTUrSrScdvLy9dmksA=
Received: from BL0PR02CA0049.namprd02.prod.outlook.com (2603:10b6:207:3d::26)
 by DM5PR0201MB3511.namprd02.prod.outlook.com (2603:10b6:4:77::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.20; Thu, 2 Aug
 2018 12:52:09 +0000
Received: from BL2NAM02FT023.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::205) by BL0PR02CA0049.outlook.office365.com
 (2603:10b6:207:3d::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1017.15 via Frontend
 Transport; Thu, 2 Aug 2018 12:52:08 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT023.mail.protection.outlook.com (10.152.77.72) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1038.3
 via Frontend Transport; Thu, 2 Aug 2018 12:52:03 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:50917 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1flD5G-0001t5-Pd; Thu, 02 Aug 2018 05:52:02 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1flD5B-0002WF-Lg; Thu, 02 Aug 2018 05:51:57 -0700
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w72CpqDi011578;
        Thu, 2 Aug 2018 05:51:52 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1flD55-0002Vd-O1; Thu, 02 Aug 2018 05:51:51 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id E40B81213E2; Thu,  2 Aug 2018 18:21:50 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <michal.simek@xilinx.com>, <bp@alien8.de>, <mchehab@kernel.org>,
        <mdf@kernel.org>, <edgar.iglesias@xilinx.com>,
        <shubhrajyoti.datta@xilinx.com>,
        <naga.sureshkumar.relli@xilinx.com>,
        <bharat.kumar.gogada@xilinx.com>, <stefan.krsmanovic@aggios.com>
CC:     <sgoud@xilinx.com>, <anirudh@xilinx.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>,
        Manish Narani <manish.narani@xilinx.com>
Subject: [PATCH v3 0/4] EDAC: Enhancements to Synopsys EDAC driver
Date:   Thu, 2 Aug 2018 18:21:18 +0530
Message-ID: <1533214282-9977-1-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(136003)(39860400002)(2980300002)(438002)(199004)(189003)(90966002)(47776003)(107886003)(4326008)(6266002)(106466001)(50226002)(2201001)(63266004)(103686004)(2906002)(5660300001)(26005)(110136005)(426003)(50466002)(6666003)(356003)(305945005)(486006)(186003)(81156014)(336012)(8936002)(316002)(81166006)(51416003)(48376002)(2616005)(106002)(8676002)(7416002)(126002)(36386004)(72206003)(478600001)(476003)(16586007)(44832011)(36756003)(42186006)(52956003)(54906003)(107986001)(921003)(5001870100001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR0201MB3511;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT023;1:r+mDQA25zdbAdIDaSWpH/F8IgxgaRiwLD94GaOqGhn798qNIIeo+AoyhwdNIn96gFZjvv6stU7zPFONPIK0umURT2Q51r/Odo2fkfwgVOmGAfo+Py1d41ck7zuX02uYR
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d35b352-9303-4843-6f80-08d5f876c1ba
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:DM5PR0201MB3511;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3511;3:JztoKVTOEXusgbtSxDStFsq7sJTB/175AzxSGTvcYaCuWO/Jc8BYG309jB4VhwYc172AKcsSaC7Y8R0XILcqrREzdFI8GoILTIvI+a2ZKfZr2A0TdqvgjeBNuy+iLl3ER0Wzs//cFilgkHKWOIZKwjSkJEEnq/Ot3YC1J10CEa7mIM8o1mQMUMb4BFs95sgIKndYvfCyNxc3zt8hD4J3wlCRhfA70VuLfizzlF5pM05KIQU7zddjKdpJl2OwnmEa8Dt72O+ozIqeliY8GMj4TiphtNJ8B5048pJm97VSFSAGmML5bL502kHiYBByf1RwVyjDGLoxDk1kZ0ZB+L3PvjwCLcz9IveFcheeRsG1a4Q=;25:qUw9qgt0pwmOeyxhgZWjjLQs2rkANuxxNJvG0dEcouYhR26LTvtmyvPtNcWT/XYo38nvWWyUom9/PALNVPWh5CgyOz/k2KRWnOkKd/QpREmkn1xoV/rj51goKj7NkTSFDSP4d5vuxe4oDHd+VEGa3Cm9v2SNcetA2BItkTD4g6uJ1kfjMAvgzrJO0VqFWb0j7oW1PAtYIFaGwQpNt4axDCQczAwCp+wAGIq4IjG5ghTpy8UwjT56rMDLPaUx2bOu6lY3b+XSdELYbyD5GrqEunYGho6ZUKte8DKzyvEeHngT/sP1EF7rd47RVH1EPN7Ah9MYBG2RLf+WlL5G4KsP3A==
X-MS-TrafficTypeDiagnostic: DM5PR0201MB3511:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3511;31:4a6PCXJBPjFp9RHzvMfYdRBRCFfzQOSse8oT1d1IHaXKaBSVbQ82SktnBMPqakiWderBiVJYSxZwgouN9itA5BlMD5w06n9+I9hjpDGIVemz52bW9cm5L548Vz33R52wulH9mqSz2kVFbVkWfckC6WN0Yde+KS1GpLHkO9cgnd8fplnkmI3R6a9Ctf5AkDs33PYsNvR2uMYEIlvba/8JyxLzl3Y4rL61eTPO7Pxp2ZI=;20:N7Xw+0VfXd88nrMe62amVWcR1E0qmUErhXDNSJXIF87yKufrL5Ftf5UwudVKh+Qt7I4kSG6+3kX9TA8oAUXXcRt6Ox/DFPplpbGEsVwUgx5p3mQACFI4KdUCaLkMWSIfq8vDHFCjX6e2bZAxSPUWao3gDlJky86+CQwQqNbTzn+HIXa7LgGP82CEqa5MYMo+Kldkn/rhALKwZEjfLE8CIwZeM8fBE1cMw5A41ElWtIZERPFlP/l+JuYTMVz5sZ6zgkeM+WuseJwxx1iR8VJJuiaqCoYima6JoER8XB5g60IvCzvOStJIZCerxqGly3ZxdIeon/sTeb1u0vV9gbIk3RaznYee/6GW1EzUOxeIlB80ey7iQLTzuResjq8k2r32EthtT8iLv98m4bDIRoK5yomfIBod0hV5lROHEfVsSo1uxYXNU8yLjW7GUzjB6dxEP5Yw7FY54oanE5iPdgeoAeJKDhmM4Y4yjCDPaWEQnxFcYSiI4kzigFJXGqZAQijb
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM5PR0201MB3511E4F3FB0DA367503BC43DC12C0@DM5PR0201MB3511.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(10201501046)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DM5PR0201MB3511;BCL:0;PCL:0;RULEID:;SRVR:DM5PR0201MB3511;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3511;4:YB4inLcbmKbqeoxGlcTfq5jp6Y0Mp7q5nrxz4yIhRFSOOUozlqDEhMwTw/zECth5h8xR3zYzKEPMa4TMtUVuO4kTawqHw3AmIXTMJN/oZJvdnffBFk/+Bii9yySkRvODBi5tBKy9ZlF966yvm1oyarbqlVAqmRPupxwAwYkspxbFtaGngvv6N5SUNymepAj8YEstT8cJVyrAcV9mGEXWBzpcnHAXWq1/gErTbUze/kOKvp2YnyPRhMPXL2FN3klikSmjpqIPfkze1DE+QjbO1g==
X-Forefront-PRVS: 07521929C1
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR0201MB3511;23:bwzOGJemLK51EEeQCbYvp5thVtHF32AEWuByJwk?=
 =?us-ascii?Q?LIERaTMPs09Eap1+WHYyQcE+uJe/RJySYyjttb1YqqirZFF5px7aiOISOQDq?=
 =?us-ascii?Q?51aiNq288AypBb6SE8+Xk0nuRTWby2M0ztqb9zjzoY7V6et9dBMLv2Euosuu?=
 =?us-ascii?Q?+acOjW0dfjxJBgrmKUub1ziu1i9t5v6/T2BBtBmt5Yww+Y1QCm9ymjNkSfJZ?=
 =?us-ascii?Q?Vrwoio3U89sdPBExWN/pXxxlhen29DqWRafgXT8YbrPFn/TfkkSnL688grEG?=
 =?us-ascii?Q?98XYHQVPejuS23zDsvICI/I/n6RosdkBEQ8EZmGZqT6oV2yU8kNQTlfdG8vs?=
 =?us-ascii?Q?nUKbXgOWrPNZFOO2u7PL0kQQ1q0FqHlv7QTGskKZE9ICgvqJFinm10UrkusP?=
 =?us-ascii?Q?XsApNaxL8wh46YGnj+riS9VeBCQx+vJF8lDeCKpkJbKJct0IkraTLr57O4mH?=
 =?us-ascii?Q?uhmlH/2XqejPTw2lB92ir03SkypZtVY0oQ8vUKNYVZqxsIp3+j8BYtyR6UJN?=
 =?us-ascii?Q?Gc4OpY2w4EfY2GTIavM5OC8QEJtdRDZBXjbAA8w9BFf5a70Nc6emMTxW+zGf?=
 =?us-ascii?Q?vZjRj2KJ+XIdvvY8DFbGly2Sq4uP2VrWNaPxkuYlm3LHSGE95H1UgKPbl4os?=
 =?us-ascii?Q?y5Pc+Dm91HfbHC1GeDS/ZmWjWK0iQ/CwpdQkg42Qzq3CClvlf9OKecvBuTdy?=
 =?us-ascii?Q?B69lSVoDGPmpeM3sYQA77FDy2iNJeSygh5TMiZE0mtvzgvTphGX/lg8RbqOr?=
 =?us-ascii?Q?fcj0V9fM5NhDdAgRpSwUC1jF8vlBx4OSSxQj/JUEolWqZPwy7aFg1rGcndvs?=
 =?us-ascii?Q?T1l57PP/4KZFCzg4LAcUlNnHuZZIaxqyFGrYyyEAUKkHK5kQ5oVwPhksHK4P?=
 =?us-ascii?Q?npiTUJlC5yD6uh145x7JfQaK1bw8Kyl81RbHdrnuWQ1mSAlOas+Rj/VUXXrT?=
 =?us-ascii?Q?eHyuzDDGWtcgaOFg/+ow9ohEItQKp5WRSNHde5Xkgk0/ElQhf4Ls79YMOtb7?=
 =?us-ascii?Q?bbyWgP62RyBKCI1H+mjcn36iEtuojb4ltftJdGfVKm/YO3Gav/3n98lxR2/E?=
 =?us-ascii?Q?Ng83jvqQZzMZOrEkcQj9n3ltf7JzWO62R2Sz4BVZFRjccYedWIgMhN/uwN/a?=
 =?us-ascii?Q?semwHNRVtnknTcKu9l7GATKW58hyfWZ5w4qvtjtHTJKortV7BwEg0n02Vq68?=
 =?us-ascii?Q?5RbEg89rWqNlzMtm8i7MaJWqAbXE9if5ZhZ8Y4ucUaLperOfoIc34DMvUKtR?=
 =?us-ascii?Q?1Pj0pkYwz9VPDzxX788o=3D?=
X-Microsoft-Antispam-Message-Info: Qk/qXioaA+sf89QzRvqdZs9M8GZxkRv0dIcrpOGOAv3nPsvYYF62vFI0/uA1D6RQ9NWYadEgM/tEAqLB1gi4zPcuzHYq0d1yjcgj7b8bvlNIx67b5lGN07LfAOUHnvY2FiTySSVEuggU0hItmgRsUWgzBIjGy3Gm5Pz7AK+sYlv/KwPlluP4zVwZ+Xw0oofEYy7vnoEHWf1+KevyafcaNy9NkA1cSZ0kZbGbPqby5hnGr1QQ9YezZhKUVjlkmpGKoTZCXGF8/UhOBNDAqBYhdShub2uYZHIH0xT2YXQFY9dvO6F3f9btuy9tDUkCUtpFREjYhPcdqVJjMQGYUm9/8EySmzWvfGVNPN2YwUibXw4=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3511;6:vEF+nd50hDQIVh2lkwIuuN8D5fvsKd3449M2jIcv+OXGRulvEuFLji0IzOkbla2JLjyF9480pFesuN5bjU4laf9jFKPqEEU5jrKtnKGHXpDsEVhHe4+KGOrfQt0h6F/wQ3/7SpHVQe0kCtTLhYXa41fiWvihu4ZOsLmbtaf2BWf22+ZO7NezQP5JBTIRyfKQ+YDOK6VAUHaYelPfKcnAecl0G2uu3VTgaPMw5nnZIQYNcVgPGL+rc7yKPdrnkxa5HJGWa67dM86eO98a0GGEViqKMwirwAVvWipgm9m3y6WOm50U75brc3/FK4M9+UDWQ85wPXQSDYdWQcYCf9R9iLyv9L+iEsXTH1O8AN0NQTRcB2EMvYLFriaSWIi2hiD4YaRvkxscqvG3ejY/uRivB3IRCrvWUzJNwZjM6rR/MJUxdIozbY1pUWt85aDPG/tLuiarmntqysAQT4AlLgureQ==;5:HeHpCEx+3jlVivmT1otBT15VhiyyY7HWUuE2cBijd/SxidUU/x6WytQgm9+CmnHYyxvvGhvxBrhtyIS5KWFEU7X0NxkFm5zQO1/XW3dCXN70xHWKMkdDID1f9VMz3uecVrGnTea7ptnf1UCIq5WUj1hPxFk3Pt3USRC8SWRyAW0=;7:7yWq6PNHkQoY4/Ts12ifCHfFnm2NAwQZX7b0Bssh1Qcbs5lYnQYst2qxeU0W8XDxJceHiEjHIBeE3/QAHag4VAYXhcDLiMtY5Qn+BQvLMuJ/orwAyw1CojCohWglrnzrwhPvAW2Lly6y82tIfSf7DE6qPj0xf/uwiUrfx3QZcuVlXGog/xyra1r+euADlFmMIZ2LzNET5v/Pdfp1x4YY1zMHN8jb6uP3zE31AKLcpIOi38UhYbVaiMOlkVadeo0R
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2018 12:52:03.8309
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d35b352-9303-4843-6f80-08d5f876c1ba
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0201MB3511
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series enhances the current EDAC driver to support different
platforms.This series adds support for ZynqMP DDRC controller in synopsys
EDAC driver. This series also adds Device tree properties and relevant
binding documentation.

Changes in v2:
	- Moved checking of DDR_ECC_INTR_SUPPORT from (1/4) to (3/4) as it is
	  a feature of ZynqMP DDRC
	- The Binding Documentation in (2/4) is modified as per the review
	  comments

Changes in v3:
	- The commit message in (2/4) is modified (Synopsys EDAC Driver -->
	  ZynqMP DDRC)

Manish Narani (4):
  edac: synps: Add platform specific structures for ddrc controller
  dt: bindings: Document ZynqMP DDRC in Synopsys documentation
  edac: synopsys: Add EDAC ECC support for ZynqMP DDRC
  arm64: zynqmp: Add DDRC node

 .../bindings/memory-controllers/synopsys.txt       |  27 +-
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi             |   7 +
 drivers/edac/Kconfig                               |   2 +-
 drivers/edac/synopsys_edac.c                       | 919 ++++++++++++++++++++-
 4 files changed, 922 insertions(+), 33 deletions(-)

-- 
2.1.1

