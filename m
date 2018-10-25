Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C36ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 06:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC9592083E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 06:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="jF6WiVYI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC9592083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbeJYOjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 10:39:39 -0400
Received: from mail-eopbgr700048.outbound.protection.outlook.com ([40.107.70.48]:31409
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727131AbeJYOji (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 10:39:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RrydX7w/R43HiIp1197Q+8fFrak3sf53/5bz4CiF1oI=;
 b=jF6WiVYIcPsGX/mfWeyfn2Br3h1wlKpb/AdIpjuFyk0urJ9i5aEVuiTznUBHiyrKtI4d6+mM89dpc5Ev9RjeqBe14DVzudlLgcmRazAj6jcnST6ZZ3o4d+O1Yw6+pRPEwwjIPFtdxzlykYItrW/UA0wOBI59m7t228/8Md+ABZc=
Received: from BYAPR02CA0020.namprd02.prod.outlook.com (2603:10b6:a02:ee::33)
 by SN4PR0201MB3517.namprd02.prod.outlook.com (2603:10b6:803:44::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1250.30; Thu, 25 Oct
 2018 06:07:39 +0000
Received: from BL2NAM02FT039.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::202) by BYAPR02CA0020.outlook.office365.com
 (2603:10b6:a02:ee::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1273.18 via Frontend
 Transport; Thu, 25 Oct 2018 06:07:39 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT039.mail.protection.outlook.com (10.152.77.152) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1273.13
 via Frontend Transport; Thu, 25 Oct 2018 06:07:38 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1gFYny-0001Hj-AT; Wed, 24 Oct 2018 23:07:38 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1gFYnt-00082B-6S; Wed, 24 Oct 2018 23:07:33 -0700
Received: from xsj-pvapsmtp01 (smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w9P67TJ5024444;
        Wed, 24 Oct 2018 23:07:30 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1gFYnp-00080s-EG; Wed, 24 Oct 2018 23:07:29 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 903031216D2; Thu, 25 Oct 2018 11:37:28 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <michal.simek@xilinx.com>, <bp@alien8.de>, <mchehab@kernel.org>,
        <manish.narani@xilinx.com>, <amit.kucheria@linaro.org>,
        <sudeep.holla@arm.com>, <leoyang.li@nxp.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>
Subject: [PATCH v10 3/6] edac: synopsys: Add macro defines for ZynqMP DDRC
Date:   Thu, 25 Oct 2018 11:36:58 +0530
Message-ID: <1540447621-22870-4-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1540447621-22870-1-git-send-email-manish.narani@xilinx.com>
References: <1540447621-22870-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(39860400002)(136003)(2980300002)(438002)(199004)(189003)(2616005)(2201001)(52956003)(6266002)(305945005)(48376002)(106002)(6666004)(8936002)(36756003)(72206003)(7416002)(50466002)(2906002)(36386004)(4326008)(103686004)(81156014)(478600001)(5660300001)(47776003)(8676002)(63266004)(186003)(50226002)(426003)(336012)(356004)(476003)(110136005)(81166006)(11346002)(446003)(106466001)(316002)(16586007)(76176011)(51416003)(486006)(54906003)(42186006)(44832011)(126002)(90966002)(26005)(107986001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN4PR0201MB3517;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT039;1:yeWVzySkzh6osOtDPsK4vXrZfx0eqBBLHQegm25NNvh1PfBcIh4rj1pUBMhSZDnYjnIp12qD96aKWCxE7gQyzhDA4jDKJ19k9qDEgQ2wvwqMaSi1J+p55F56caFV9Bpz
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e13413e3-1160-49c4-a79b-08d63a402adf
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:SN4PR0201MB3517;
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0201MB3517;3:MTxqtDAlkHPUHwsilYUeg2WSauHkX9gZsPlAKH7qO6s/UKWEK/Reeiid3PdV6ixdwCa1cLVPWvIbAIMVF2/NZi8ycqzZF9invBIIU/rCTUVL43lRx0db/AVEF7ygWynVdcNux7uK6vtyl8zUsF6xPG63gyBQiaKdDhjiWz9dR8+62HazAb9/TllVW9t8cbWswVLwMnEQxL9XB8NlKGWKkyqvfDk50DOIGHYvdSjcSQK87SmkHQuEm6BNRp8RHwKsPtO8gwLOb0fvuXo3HM1sgkw+pXQtPePAOyS7Eg0o9G/YmlbIif2rGWC7FVpmNBzxCwRtlTH1SxM7c4EPcBLDYrHPj/+P97mTFJr/mj7HmXE=;25:GCyk5ZPK4hUWpwc+9aAB0dI/GMhsSr358mqXcDfqto6iDoFmGgjGiv/xXpXec6g061Th3Ntzu3hb9kNQ7OZcvTIQIhBYyhp/QfzVkXCzw2K7h5HuQjTnz8TPmwBNfEN1YGZ55VWI1YMa+/hiUdZug8/L6k+mCz+195+CJTJ/KkBI1IYURCOLCBgoQBN8f7VU0tq1EaniULHsURpB8FIUkjn7oQc+nSzRSHAIlzeCqw2NshUIcpyZ4qUfWw4UR5CqqBSaW7Eh1mnNG//xU+d25XhuxxKf6kIWpLWTBKTOX9erSLIGfQcNR4b5SWhDjM+a8s9q5URNHSX6dK+mXDzcpA==
X-MS-TrafficTypeDiagnostic: SN4PR0201MB3517:
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0201MB3517;31:cqUKH1KXXqEYOaKwYYxBAmPoiPH464OYI4s/ZsSFFrk5DmWVuZbZZZm2n4pUtEOVfdX9otdRNGLe3wW5TU6mnEeCm8N7Dy/pNahG0Q07SB+dC3t+sY+pyP2dPWWp5tc5/VJEa7t4VmrQYa7H1XOJuLRT5BwKkSEk+/1AhK6OgApGjPbavhv3ccfLJjNJgU2P9Nxvg1ZUQjfZGJt6HcpftPm5IFl/pNwsd+N7RoT1bY4=;20:cQHSQHWPUZcjCOONEVYOKdmbIDdulwtU0/Gj+nfC30NR9uBvDXRYrVngYLdJ0dafxDHftuUZyw+cBfLUEvrgJOLzpFVEwwOlWqY/bESbxMTlc37A9QVa2S40GqfWcermubrSVykPGKQVS57XOPL4DMvlci2K17E5WLrAD/FO+sg9zySotSh61pBn1LtlW9LOp4ZH8HN3Gbt4oHhLf99+pCjM7BdjxHXISrrsaNL97IwIhp6Tqaam8rHlnhuOkda34on2GlEUcm9Gn6g2Q9BEb/cA6fCu6l+crG69O0LmWqA6XeUscUjHDnCU+Gpe79FGWR9XywSdnYrzL/kd03Wg2TALl0AhV3rR2zkHKJAnfc4B4VraM0sQKiUn7eKtdj8vrbhOg4FWEvVkT/A9JwT07grEsZH9zcxwH/nIRkzM9Ft96+iXY8UwmAdv6F/FlXWIEHejf7q8rotqvebf6rCD5NX2GUahfRfs7GVdtCnQh1SUtVedem4Kqg3J+Wc9gtSS
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN4PR0201MB35175C7BC44650371FD3849CC1F70@SN4PR0201MB3517.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592)(105169848403564);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231355)(944501410)(52105095)(93006095)(93004095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:SN4PR0201MB3517;BCL:0;PCL:0;RULEID:;SRVR:SN4PR0201MB3517;
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0201MB3517;4:AUM9bcTIMWwRyZEk2VFOoAsmjX/q9PxVJTQN01JIjtA4UCclKVlgKoT6OV4f/9Q8qc74RujOoELPJvVxdVQuPkPGn/vPgQjPS+GXDJwPAd+K8oViLursmUvqN75i/0+yRojv7Pk4MZhnNRhzIWPlbOFP9XEHa+ZZhJ/iR0gjKJsarlQV63MBn1lX1aicCi/hrmhJQFcH6lf0fRaXXLU7Kbisc5pEnYRLSM6z6vOPFqgaL9m2g7cbKsGEKQA+unm9HJd39sxmqwu/5T5opN3NgcQQJf6UWgd35ITa/FV6gk8s1iPsULnsxVlRTPPkczM4Wz/cSizGLj0jTcirSOmqLRb+FVaZdRrr2N8wY0KTJnI=
X-Forefront-PRVS: 083691450C
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN4PR0201MB3517;23:v6m5M3oCTnFNbURJeoXwk/PzrKvTCltqrBSUEUQ?=
 =?us-ascii?Q?rHyS3KXNUJBkVwsFQ3g6/puv2TVLtfTwfhlSCOkEiQ5VnQELBjRsw03QzvtD?=
 =?us-ascii?Q?GheQpAbxJ7L9dZQY8d9FAL9mLm1bQJ2/qZmQTIWQgCwslMhohaBvSd0/0Gkb?=
 =?us-ascii?Q?V0JFJUEq2m2Xia1n3AkC0rRda+InQbabjDK4518XWq6bJ+Dwwji5EX3riveJ?=
 =?us-ascii?Q?3x8JVnW+OLuTVeDQaB9A/h/7W4M7XpftSPErdmOtM/VntCKE8fjEKCVZY8Pv?=
 =?us-ascii?Q?M0i57rpXlLkfcnXwq4Z8IWXVIqxcPZjn/bGt3Dz3/M1ThaIMo3okhVJoYcRG?=
 =?us-ascii?Q?trShafBhV8PebKNXidW+GbmFXisH33kZcJX6i+06KqHSo2seCB9hdrKoW2kr?=
 =?us-ascii?Q?y+vcca5NmrhVmSs4jaB3/IQ/VtbAhmcEgKoVr4PLRVpmKyQ+5Y+LVRD9AKIF?=
 =?us-ascii?Q?BYJA8/ekbe5rHh+NO00OVGPxLkcrOr/a4jOxfYyhZW9NvQYjHzDJBA1I2lH/?=
 =?us-ascii?Q?SZENeORPhmePhScWO/ZkKSsMq0sOfVJzez3GFmwrKR8AB4hkKPjfynMUlzIM?=
 =?us-ascii?Q?zuTCYZ8wmqdgu5ieZt+F1BuAgfGkuW1oSF6YnLXpdDLj3RltV3T0yjAgBNte?=
 =?us-ascii?Q?nM5N7EH3+YapKZrcAufvtOzorAoYhS1gjDmKFvsdlM9XSwy5LHDvstBh11C8?=
 =?us-ascii?Q?3+7VoYYy8enf1VnarXOr7mCVbuCPD3bjGolz+K+JhLc3lMpuKucCxUQawOhc?=
 =?us-ascii?Q?3CsdKfUDqstIIt8ZACQWQ9rLjov22TXSDrZXMbasF71NyCxL5tKauAsozxLv?=
 =?us-ascii?Q?i/CgX3J392j/PGLqCPq+WxpkI7/9VpjEg2YbTcO6ApEVYamht6CvBWMgr+tZ?=
 =?us-ascii?Q?gvubHcDaFGmNhPr497Jk1eM8R6OFaCjnERuxp4gHeukHQl7QVqHfNZq9KPTH?=
 =?us-ascii?Q?+BpY9vQQGEsyvlcoHT4xFn3Q9OBFFzD4vvYvblUT10PmlX0ywC1Px3F+Ll2x?=
 =?us-ascii?Q?0YInwaDCRzaDmoZlRiauZ+LUTlXF0o2zFcvKbm6sUZDbJYFEFPkccgfgj9kE?=
 =?us-ascii?Q?iDsU40Af4Vb4pXu3iFQ23lukeysWh68RYjvevPZOCXtDfPDbVyRC1+BUpzrm?=
 =?us-ascii?Q?tLXgHkv26hpkFmR5twsgHVZvcr+RHOChWF9izyiZyGmjT3wni0OrhY9vjGDK?=
 =?us-ascii?Q?so/YPCEuH/u228k2SKdEaJShKc6z7ZvlErXkN2mR2hpTD64OBqFAUs6zUtg?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Antispam-Message-Info: 5awVB7Pe0HSoVedqPRdSTD/X13x/hSpXtQjzhKAxIqaOxRFlUA6QNL4XVm6TeOXuj96RkiaBUXBlwtMKAax6ZH5bbLMljZv64ihKZc3np6UkEwAyeI/XQEbieoN2yOMfDS+YDzjADj0ic9gtd+fsS6ox9gA1hku3TLshFTBDQ/h9xB7kaWP7Yff04z+vRBvwEIkjPDKY6IosZ9/t35wjvK/Vx053mDocAzZ3PvLmqWAkP6gLwNWNO3MImxQsLfE/YbxyltAu586hwUyoh6f4GOnfASVJ0FSwXaK9HIlKBVDP4ODrbOVYY2CxIcPq9EUjtUoDlljI9VzTmnJQjbna6ezIFHxJHebagKMDKCpBGnY=
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0201MB3517;6:GyB2AAiZUXarApMD77XEPePw0AZz0ZqB1WG2Q80gpTKyXEQ4LUTo4uLJVzP1Wa6ZXrWKZFCNMZf4CvCYdJ1nRfPkcIPr/svcnc0qZRJMvUdqpKivxuSk94564F/SRO/+xuUbTM8W89tdEcU3oyP5u5Rm4bz39/8TW8jD/KmdoYE/qSqF5VtYk9XX0lFnao5iWqG/+a5sekCkbTTJGqHcu6xo9QiQC6RBVzTSp+5uq/GH7xOLFE9eK+/qthTPLd6XZls6niWI9ReB94M2sCM3XHtqv0ms5QMZoQ0XiqTdH6pbbuTo1/yAjjrzGpk9XYHtYIddDIwOmqytQG5qR3AE1Ia1BmQsOLIodC1S6c6qlB12+do/klKn9SZkQJ3k395+88FuRgdksaKjdDP6eWh9S9jewM+uFVd+ERmGPNLdV/+rbpDfjBKadVjw8lwB/ZKLealfeBxV9buBqOaRvpTw6w==;5:8TrBVBSfmpL+3iLA7KI8tkY1xXUpahmCLtw4XqVNBxro0+wHpBhxzQdj94oRd3U3We+Pd0/lEz4GcN9IOj/o5ldRYU8gHzLwJOiTD5aXaSpPuFLQ4LabaDw6yr30VWfH3FNrsWLxFZAX92vlCJOWH8MYinXkabiSxBKQ4rwt6ec=;7:vmfE/NJkayKoQa+gT0G0mxfYSmdHbqcBZ/WzTvhwuIUXBtY4wVq5zHuCRqAXvYo3zMH/T3McszU3bTBdm91KB8tubf58HrEKh8VLRKe5Dbm/H9NnG5y1vReD+TKQsQ+qiMI7NXD935tTwSBdsdhiYW2RoVrVMW51oZk0iZE9AE7wEQJg50rLu1h+c/AN7LyO4wr9FF2RhLBgeW57W+JaKIaiorXp7En0QI40u7p1iRsdqCtHoCFGpxuiOJF0Ga6g
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2018 06:07:38.8778
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e13413e3-1160-49c4-a79b-08d63a402adf
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB3517
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add macro defines for ZynqMP DDR controller. These macros will be used
for ZynqMP ECC operations.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/edac/synopsys_edac.c | 168 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 168 insertions(+)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 0005ef3..d1999e0 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -97,6 +97,174 @@
 #define SCRUB_MODE_MASK			0x7
 #define SCRUB_MODE_SECDED		0x4
 
+/* DDR ECC Quirks */
+#define DDR_ECC_INTR_SUPPORT		BIT(0)
+#define DDR_ECC_DATA_POISON_SUPPORT	BIT(1)
+
+/* ZynqMP Enhanced DDR memory controller registers that are relevant to ECC */
+/* ECC Configuration Registers */
+#define ECC_CFG0_OFST			0x70
+#define ECC_CFG1_OFST			0x74
+
+/* ECC Status Register */
+#define ECC_STAT_OFST			0x78
+
+/* ECC Clear Register */
+#define ECC_CLR_OFST			0x7C
+
+/* ECC Error count Register */
+#define ECC_ERRCNT_OFST			0x80
+
+/* ECC Corrected Error Address Register */
+#define ECC_CEADDR0_OFST		0x84
+#define ECC_CEADDR1_OFST		0x88
+
+/* ECC Syndrome Registers */
+#define ECC_CSYND0_OFST			0x8C
+#define ECC_CSYND1_OFST			0x90
+#define ECC_CSYND2_OFST			0x94
+
+/* ECC Bit Mask0 Address Register */
+#define ECC_BITMASK0_OFST		0x98
+#define ECC_BITMASK1_OFST		0x9C
+#define ECC_BITMASK2_OFST		0xA0
+
+/* ECC UnCorrected Error Address Register */
+#define ECC_UEADDR0_OFST		0xA4
+#define ECC_UEADDR1_OFST		0xA8
+
+/* ECC Syndrome Registers */
+#define ECC_UESYND0_OFST		0xAC
+#define ECC_UESYND1_OFST		0xB0
+#define ECC_UESYND2_OFST		0xB4
+
+/* ECC Poison Address Reg */
+#define ECC_POISON0_OFST		0xB8
+#define ECC_POISON1_OFST		0xBC
+
+#define ECC_ADDRMAP0_OFFSET		0x200
+
+/* Control register bitfield definitions */
+#define ECC_CTRL_BUSWIDTH_MASK		0x3000
+#define ECC_CTRL_BUSWIDTH_SHIFT		12
+#define ECC_CTRL_CLR_CE_ERRCNT		BIT(2)
+#define ECC_CTRL_CLR_UE_ERRCNT		BIT(3)
+
+/* DDR Control Register width definitions  */
+#define DDRCTL_EWDTH_16			2
+#define DDRCTL_EWDTH_32			1
+#define DDRCTL_EWDTH_64			0
+
+/* ECC status register definitions */
+#define ECC_STAT_UECNT_MASK		0xF0000
+#define ECC_STAT_UECNT_SHIFT		16
+#define ECC_STAT_CECNT_MASK		0xF00
+#define ECC_STAT_CECNT_SHIFT		8
+#define ECC_STAT_BITNUM_MASK		0x7F
+
+/* DDR QOS Interrupt register definitions */
+#define DDR_QOS_IRQ_STAT_OFST		0x20200
+#define DDR_QOSUE_MASK			0x4
+#define	DDR_QOSCE_MASK			0x2
+#define	ECC_CE_UE_INTR_MASK		0x6
+#define DDR_QOS_IRQ_EN_OFST		0x20208
+#define DDR_QOS_IRQ_DB_OFST		0x2020C
+
+/* ECC Corrected Error Register Mask and Shifts*/
+#define ECC_CEADDR0_RW_MASK		0x3FFFF
+#define ECC_CEADDR0_RNK_MASK		BIT(24)
+#define ECC_CEADDR1_BNKGRP_MASK		0x3000000
+#define ECC_CEADDR1_BNKNR_MASK		0x70000
+#define ECC_CEADDR1_BLKNR_MASK		0xFFF
+#define ECC_CEADDR1_BNKGRP_SHIFT	24
+#define ECC_CEADDR1_BNKNR_SHIFT		16
+
+/* ECC Poison register shifts */
+#define ECC_POISON0_RANK_SHIFT		24
+#define ECC_POISON0_RANK_MASK		BIT(24)
+#define ECC_POISON0_COLUMN_SHIFT	0
+#define ECC_POISON0_COLUMN_MASK		0xFFF
+#define ECC_POISON1_BG_SHIFT		28
+#define ECC_POISON1_BG_MASK		0x30000000
+#define ECC_POISON1_BANKNR_SHIFT	24
+#define ECC_POISON1_BANKNR_MASK		0x7000000
+#define ECC_POISON1_ROW_SHIFT		0
+#define ECC_POISON1_ROW_MASK		0x3FFFF
+
+/* DDR Memory type defines */
+#define MEM_TYPE_DDR3			0x1
+#define MEM_TYPE_LPDDR3			0x8
+#define MEM_TYPE_DDR2			0x4
+#define MEM_TYPE_DDR4			0x10
+#define MEM_TYPE_LPDDR4			0x20
+
+/* DDRC Software control register */
+#define DDRC_SWCTL			0x320
+
+/* DDRC ECC CE & UE poison mask */
+#define ECC_CEPOISON_MASK		0x3
+#define ECC_UEPOISON_MASK		0x1
+
+/* DDRC Device config masks */
+#define DDRC_MSTR_CFG_MASK		0xC0000000
+#define DDRC_MSTR_CFG_SHIFT		30
+#define DDRC_MSTR_CFG_X4_MASK		0x0
+#define DDRC_MSTR_CFG_X8_MASK		0x1
+#define DDRC_MSTR_CFG_X16_MASK		0x2
+#define DDRC_MSTR_CFG_X32_MASK		0x3
+
+#define DDR_MAX_ROW_SHIFT		18
+#define DDR_MAX_COL_SHIFT		14
+#define DDR_MAX_BANK_SHIFT		3
+#define DDR_MAX_BANKGRP_SHIFT		2
+
+#define ROW_MAX_VAL_MASK		0xF
+#define COL_MAX_VAL_MASK		0xF
+#define BANK_MAX_VAL_MASK		0x1F
+#define BANKGRP_MAX_VAL_MASK		0x1F
+#define RANK_MAX_VAL_MASK		0x1F
+
+#define ROW_B0_BASE			6
+#define ROW_B1_BASE			7
+#define ROW_B2_BASE			8
+#define ROW_B3_BASE			9
+#define ROW_B4_BASE			10
+#define ROW_B5_BASE			11
+#define ROW_B6_BASE			12
+#define ROW_B7_BASE			13
+#define ROW_B8_BASE			14
+#define ROW_B9_BASE			15
+#define ROW_B10_BASE			16
+#define ROW_B11_BASE			17
+#define ROW_B12_BASE			18
+#define ROW_B13_BASE			19
+#define ROW_B14_BASE			20
+#define ROW_B15_BASE			21
+#define ROW_B16_BASE			22
+#define ROW_B17_BASE			23
+
+#define COL_B2_BASE			2
+#define COL_B3_BASE			3
+#define COL_B4_BASE			4
+#define COL_B5_BASE			5
+#define COL_B6_BASE			6
+#define COL_B7_BASE			7
+#define COL_B8_BASE			8
+#define COL_B9_BASE			9
+#define COL_B10_BASE			10
+#define COL_B11_BASE			11
+#define COL_B12_BASE			12
+#define COL_B13_BASE			13
+
+#define BANK_B0_BASE			2
+#define BANK_B1_BASE			3
+#define BANK_B2_BASE			4
+
+#define BANKGRP_B0_BASE			2
+#define BANKGRP_B1_BASE			3
+
+#define RANK_B0_BASE			6
+
 /**
  * struct ecc_error_info - ECC error log information.
  * @row:	Row number.
-- 
2.1.1

