Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC93C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 11:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE5F320850
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 11:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="1EzOeW++"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE5F320850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933994AbeFRLua (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 07:50:30 -0400
Received: from mail-eopbgr720062.outbound.protection.outlook.com ([40.107.72.62]:58688
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933134AbeFRLu1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 07:50:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OgMI5AEffghCo7GW+04zjnGO+Dt0FPSlVOsgwM5wIwE=;
 b=1EzOeW++rpG1JAes37EjxFGtU+IvNYwJrvflX9qK7JCPdsIgsX7F2SVWaFcljcIVqC19Bg1oAyGca4PIUHAs4Amk2wcZRGQe3rTs20FFQWehOU/Uh37YKxTrXVkr/ta6QK9lFYjmuzNyLTt2GQdaL97PSEdx0fQIEE7phKGDWlo=
Received: from MWHPR0201CA0066.namprd02.prod.outlook.com
 (2603:10b6:301:73::43) by MWHPR02MB2238.namprd02.prod.outlook.com
 (2603:10b6:300:5a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.19; Mon, 18 Jun
 2018 11:50:26 +0000
Received: from BL2NAM02FT049.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::204) by MWHPR0201CA0066.outlook.office365.com
 (2603:10b6:301:73::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.863.16 via Frontend
 Transport; Mon, 18 Jun 2018 11:50:26 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT049.mail.protection.outlook.com (10.152.77.118) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.863.11
 via Frontend Transport; Mon, 18 Jun 2018 11:50:25 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1fUsfw-0005mQ-Gv; Mon, 18 Jun 2018 04:50:24 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1fUsfr-0000Qd-ER; Mon, 18 Jun 2018 04:50:19 -0700
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w5IBoD2g006503;
        Mon, 18 Jun 2018 04:50:13 -0700
Received: from [172.23.37.80] (helo=xhd-paegbuild40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radheys@xilinx.com>)
        id 1fUsfk-0000Jo-Sc; Mon, 18 Jun 2018 04:50:13 -0700
Received: by xhd-paegbuild40.xilinx.com (Postfix, from userid 13245)
        id 0374EB2074B; Mon, 18 Jun 2018 17:20:11 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     <davem@davemloft.net>, <andrew@lunn.ch>, <michal.simek@xilinx.com>,
        <radhey.shyam.pandey@xilinx.com>
CC:     <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/5]  Fixes coding style in xilinx_emaclite.c
Date:   Mon, 18 Jun 2018 17:20:05 +0530
Message-ID: <1529322610-27215-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.4.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39380400002)(39860400002)(376002)(346002)(2980300002)(438002)(189003)(199004)(106002)(103686004)(110136005)(5660300001)(2201001)(90966002)(26005)(305945005)(54906003)(36386004)(2616005)(186003)(52956003)(426003)(51416003)(126002)(356003)(476003)(16586007)(478600001)(59450400001)(336012)(486006)(63266004)(106466001)(4326008)(50466002)(2906002)(8936002)(42186006)(316002)(8676002)(48376002)(81156014)(81166006)(50226002)(6266002)(47776003)(6666003)(7049001)(36756003)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB2238;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT049;1:sMFFVCBj3kvwyP9nZTdO6JVeMbgjRQpQy7Pm0A0T2ICrGFnKsGF1+wvHbYTTytCImx/rLlgFWtBz37y1J/dkQIGSDkwnOhKCcY3Mm+gkbAL5ZhQMMH6Jx97pccyS+cRP
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df4e92cb-b0ca-4fca-3d92-08d5d511adf9
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(4608076)(2017052603328)(7153060);SRVR:MWHPR02MB2238;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2238;3:NBJz5oWVGLBhZlPJVVc95Su/lw84IbTjI6zQ09VDUN1yCY/O/RC16zbttLR2C48NVQrWzJajtVr/BW/k5hdW7tvsdTYw9ItvQLAlg6pYKIyGP2y+nrm7To7uNKr+VoZjFtzFgI0px9Ugdk1VmSKoCeRlZdvUykMPoZm2NJ67ur1cCKSwBgPVcOb4+bmpFjncC98WjA1/oP1bQwiQvu0ZT26Gc1IYW1ay37fJEz5MjLK/m61C6tDX1Wwl5wQu4x/FFtWDr8ijaR0fLEh0FwNFPXpCCdHBbFXpFNk4PzSTcnJkFgEEiiKqR65cz2k1R4uc74NuPs0kx/6A4TuaABVoZNHRpzOLEUbKOQwS57zBf9w=;25:Dg2CkOOIeVct0nGXgn0ks5UZ4PISKsE0rdWZYufYYTCGG1iLrMRhsgVxEO20vfVlQl0Y0JRHRJM6Lg1OKsDBQAmqc4/DfG6I3Zwd4xx5pMgChHxpPtHY7MR8RUJ7MpSvzQvZ9yAmKnFPeWbQ49gqXcpqvicV6HURdeHBSpcwGdzPVR+ZfuI+ToV1/ZBd6dOxjDD9JvNtGxSjJqC0rXIbBI1XfsMFmy60ZUpF7hcRqpofYtVrU/+LPHa7ctYya8+COwrhcyNOPrG8IS9D98ASUKo5IN7qVIuA0ddBMPuUsT5A9bbYzUe0+sJfNQVnqGNAyJiGHYHvE3Ht9+wqHMNhcA==
X-MS-TrafficTypeDiagnostic: MWHPR02MB2238:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2238;31:Ve9aPqd7bKKL3cNoorWxl1oaqXC93HUL4PDgOLW4cxA3eyJjxbHkGQ5jxKFrYsWh/b9G4FzDSEfxYQnBkAK4ayY20pJ3pMWpnHPR1f62fVHqGZHNsW9n6PfihqtL8L5gXmFqildHP8N7yDufkbdH0hUE2HNP7HW6vhy0Wxd5DlnrfEz51iBb5IgMSUQhLyGLOgmmN8lsnEa4ZaTeWXDQJLVNWUNtEzrFCusz7aRKvW0=;20:H66tMV7MVhktUHwYYhJIeeBuwdPrQ0k1oLX8S4vjQDdKckRa1gv8J+P4XyvqnFoea1SQIHDGIyyZW7RcP8uBVYpfIKTXyXWvw23o4GuDWT793AxAE4JsIIFlej9My2XQdOYYD/AzxZXwYobbJFkN0GD9F2fLyKAtxmZ5MPlR9yf9jrq1ICgetFqF8OyFKcsJg1zW1QAmnFkEzMepBAFvSiKhdLWjSXpCuhPsVZJB3FNPWKMEiumLbVtoZ0bjrpx8b1Qq5VoL9eiwaUtMC8FhJOINHnHFzx+Qb3yQ/UZEgWhVPab8ur/9hgUSsL4SIFpxqZPLapX8Z2AY8nZsuibHU9dka5WN+XAycImzJ+DD9yPm3X7i8TqzaMNfkQbWe3vyojztBLTJMHwl8pylgIhOTRE6dB4J8hIdzZFa4ntEyUJ17Fx7FgXbWm+sjYQ+Tjv2SXyrrAdqHrcfNCkSHyW6iJypU7EZssmsD8+21TJvZYDOMFxxI1pATKq13m4oIDZ/
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <MWHPR02MB223866C051DA452301B3A991C7710@MWHPR02MB2238.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93004095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:MWHPR02MB2238;BCL:0;PCL:0;RULEID:;SRVR:MWHPR02MB2238;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2238;4:GggP8379eviecrjlMzxYFyYfOwn8lM1InQ1hyjQ57M7gZbFcFTOkKmgXlmGknoZcGUkagjjTEb7UoK6Wn3eb7dL77ctdCuU6YUVzYCdsiHCDBhfT02jxmVc0q4t7s687mHx5DKxLOBKolLvZsMqoxYs6wpmMnm4f9FmB4BSbLMFGNZfMK/angIYUQdr1cvFzZ/ED2Kd9v6K7voJmBfW++sKxkyLDsGSDrv55txtq3U8h6DH8QYvoBPHQnVx0mc/3XubuHZWFWz7aPyOijAOSYA==
X-Forefront-PRVS: 0707248B64
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR02MB2238;23:QnAbJM7f407SKthrwxIa7ivmYl650QllBWk6g6OVH?=
 =?us-ascii?Q?tCsSiBsSI5IsAmt3RYKiwSRqi1VWVn57+cHSMb5mnm+kGsNGNIsNzgHET9ua?=
 =?us-ascii?Q?4vk6fAWggzQymnvimcU82ZcHbIgKSQRxuFVFgA+jpw9lQnMI+t8eKdulkmsH?=
 =?us-ascii?Q?dlqZfK3DpjfG1xFVnMdrr4PA9NLIWcb4px3k8TmPKx7931WG/uS/Yw4eXGh3?=
 =?us-ascii?Q?C2xxoDKaXg/3Em8irju/lrBS+oydmO+gQxBnH/BWT0oJ44qEt2XMhw1p66cx?=
 =?us-ascii?Q?vldR2/ZCaf2jtnzNLQGb6n4bHGkTPExuVYrLhPs3zmqgpJ3DIKMR+7TSBrRx?=
 =?us-ascii?Q?KJu4mWLdQE6iawJEtObgysmVvyW9d/anioa3sdWP+jaD27TyOx4IH7dFrckS?=
 =?us-ascii?Q?aXfbNvHXgDciWapWUxkEUeejfPed9K26/W8IIrXFqTssRTMlmt24SnsfQa4/?=
 =?us-ascii?Q?GAwFHj29GXnPCfjz6VlLbhVwwa/oEQ3dzkkL1f+dQn7eolxZ8UOpnhJHycDm?=
 =?us-ascii?Q?cWxVUAtN3spRD/ouzB3vR16QV5DtHYvDsn7X++VZZbqqBr7/tJtM6i1fcHFq?=
 =?us-ascii?Q?CCc/Uwyg9+lgBxYQ9u83nhtzN4zHeOZsZ8rUyIq9FieBAMk7Z+U/vj9FYfFC?=
 =?us-ascii?Q?vUvROlAwrpVph9ILexzuRp03BX9Z0E57C6zME26YjB3eP9w6yWumwJ0NsvlT?=
 =?us-ascii?Q?/AwdnEVe++RVTHS+U8ArRiNnzDkN9vfZdD9aqwdQ6EqtkUGvAsERLslmzsWT?=
 =?us-ascii?Q?8+qp6CZy0xtHHrp9VcNlhXJSMMxIK84KXq+EafwIZAbRwhuZ8WrDic9n9JE2?=
 =?us-ascii?Q?n3Sq3yT5oNsRW1pSq4rHrWBW3AwA1U79e4zmAjkQq/bJSo9H5zpBOU/QVjPK?=
 =?us-ascii?Q?LjpKwahFYKht84y/5tn0T1uOhLXbR9AoVvsU/qJuo7ip1SCJama9G/V3+slQ?=
 =?us-ascii?Q?3yrI+DBCC7AHxBI57Ve3kSZhwlnCT+iyfs7bQfg9/w082oCLifVVcFd4HG5D?=
 =?us-ascii?Q?68qWesrpJYv09rY42aw4GmOOtAdgNsoRaJHjZy3fmhairAmXyWWqrt023xdl?=
 =?us-ascii?Q?0cCiQdinQhrskR1i5tgUfvB0RsjLTai8C91+JRZPee2306w+nqhbCPWjguDO?=
 =?us-ascii?Q?wGODCnoRtVc7h350QKw+3bGMUH1M5yC?=
X-Microsoft-Antispam-Message-Info: qvNjdPD4SJ+KAHeFjsTjP2DnOIQlLfJvxUuTnXQ5SINNwH8/4Jp/UB2XrErgtEfeqjsK3PBvQo88giUdDLqdmdvrhawIxvUrCbOiE1oJd30ItzoqmDBKPvo7Zod/VJld7QrShtzFFxB93OZQ08beZAOgsILRkUqacFXHNZyuVhsb/B9gWMXBnXZ5Z6wT62eZHjWBiMdboT9ncNq6fE+9YlipNWAvaOLbRPe6+ZgbQVxKGpXIPRc++RhbyR104Y3NLNxdUWupW9+WrJDtYOxQdFz8MUVs569KDmJuNqUFaCbfnTpJyeqYzHjtCR9DWCDl
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2238;6:TsDZ+oRY+3QzAUtDhcrnyoE495+8CZO5hHcXCTzLE0o7RCNUy77NSq0zbxd0oqhq5Sliw39POd5BO9Bf9LCneLcXXuFvJUWL4hb5UU8qFVeQOx7+g7kWlqnl1Rc5N8BWqkWgVDqMtO5RfnkaS6qb6JdSAHkopunW4WeDQqeIr40tcggbpR9Fs6dYy2g1zfjEOAxzO1It6xc6iejC0/T2ww5OlP231ky60v1sAC+t2umkn71LtRlH3fOJr8w4vVA3s0luSh6JI7dWEaU5e824lcZ/faWfKvQPl09qSFZv9fP1rBay+YhKIAoVYgNgMica4xSfWvsrIF87ewbv36EjOv39dQg/DWWOECklTLOwOxvAmO8fH/ltxEpdjyngq+b4Bh+wxMZifWF4UspMQsNWgvaZIlxWKl9NJ+rS06DtZWg2p2J4n4/LmG+s8m0PjSaNfouhV9BW4P3SkkTJmYoyJA==;5:d53ZOSPJXWD5DgwTvtxdOaAVV/I8EuGbzB5V1oHGm53VsEnG5+HvUM0jbX0wJb3HLkNurg40AdYvAALiWZhSwm8hdy1RZDBs1PqcpYQhDIrDHCfGH1Ytsx6lajh6LHNAu3rZG46NgqYi1DyNQU2ylZxbDihzXb45C1vbj+ljqSU=;24:Tewy2l9udDPRIOPsBn1Jqbxp7hZOu1f2h5CgZIbZaOnUvRYTy3yI3tFZcnK/TAVOoB8Lq/r1AHHxdXpznBQj/zz4qcZd943B1CP8Aj71z1E=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2238;7:kvM+9clOyKNS2AUYwTGt19y+HaRIiPsBWGuNWsExmPi9ZbPstZoDPaGgTQ4J+B9zpuf8pyWuwvkehf1qzYtIgqlpFYr/bzGb5JEQNuHadpmz15TxgH3upM5EWFOxjm0QPU1aYg6oAJWHLY+McP+D3Wn7CT4MGtxUQdGJm+OBJfxsC6Jr23X6mq8Jw4x6/fIBcLBr4DcxK0FhQitJMgdKzW4BYsEHwedFlhAQs/hxDQfIybJzmY+OiAnEJMAdZa50
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2018 11:50:25.0871
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df4e92cb-b0ca-4fca-3d92-08d5d511adf9
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2238
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes checkpatch and kernel-doc warnings in
xilinx emaclite driver. No functional change.

Radhey Shyam Pandey (5):
  net: emaclite: Use __func__ instead of hardcoded name
  net: emaclite: Balance braces in else statement
  net: emaclite: update kernel-doc comments
  net: emaclite: Fix block comments style
  net: emaclite: Remove unnecessary spaces

 drivers/net/ethernet/xilinx/xilinx_emaclite.c | 101 +++++++++++++++-----------
 1 file changed, 58 insertions(+), 43 deletions(-)

-- 
2.7.4

