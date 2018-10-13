Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB1EC28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 13:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 920B92098A
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 13:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Vi2kpIHi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 920B92098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbeJMUwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 16:52:36 -0400
Received: from mail-co1nam03on0079.outbound.protection.outlook.com ([104.47.40.79]:32064
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726400AbeJMUwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 16:52:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pwO0gynIuiSeFOqpYikhwO8EgXv+TT0af0sAaaSb6Vs=;
 b=Vi2kpIHiE5iG23zjjEd+ONUdF/xoUiboTawwSLQbVwBwKirbJtEsJCOOnqgFjb7NJItSU1p+E5cJ0At1Uk3YqGdJvj7ooxRL8pyxx2ztjjePlKOIDjvPSXqg70/Y3amZthZ8VvaxOnxHon1MmQzTEH8McM5Hse5vr73lWwppTWw=
Received: from BL0PR02CA0023.namprd02.prod.outlook.com (2603:10b6:207:3c::36)
 by DM5PR0201MB3512.namprd02.prod.outlook.com (2603:10b6:4:77::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1228.22; Sat, 13 Oct
 2018 13:15:25 +0000
Received: from CY1NAM02FT038.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::207) by BL0PR02CA0023.outlook.office365.com
 (2603:10b6:207:3c::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1228.26 via Frontend
 Transport; Sat, 13 Oct 2018 13:15:25 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT038.mail.protection.outlook.com (10.152.74.217) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1250.11
 via Frontend Transport; Sat, 13 Oct 2018 13:15:19 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:58009 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1gBJlH-0001Ge-0K; Sat, 13 Oct 2018 06:15:19 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1gBJlB-0007wb-SO; Sat, 13 Oct 2018 06:15:13 -0700
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w9DDF8xa026442;
        Sat, 13 Oct 2018 06:15:08 -0700
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1gBJl5-0007q1-GF; Sat, 13 Oct 2018 06:15:08 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id 12D85604D5; Sat, 13 Oct 2018 18:45:07 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Johan Hovold <johan@kernel.org>,
        Jaejoong Kim <climbbb.kim@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Roger Quadros <rogerq@ti.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <v.anuragkumar@gmail.com>, Thinh Nguyen <thinhn@synopsys.com>,
        Tejas Joglekar <tejas.joglekar@synopsys.com>,
        Ajay Yugalkishore Pandey <APANDEY@xilinx.com>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH V6 08/10] usb: dwc3: Correct the logic for checking TRB full in __dwc3_prepare_one_trb()
Date:   Sat, 13 Oct 2018 18:44:56 +0530
Message-ID: <1539436498-24892-10-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1539436498-24892-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
References: <1539436498-24892-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(346002)(39850400004)(2980300002)(438002)(199004)(189003)(54906003)(305945005)(106466001)(2906002)(52956003)(478600001)(186003)(50226002)(63266004)(50466002)(107886003)(90966002)(48376002)(126002)(15760500003)(51416003)(81166006)(81156014)(110136005)(7416002)(2616005)(446003)(26005)(76176011)(476003)(336012)(106002)(42186006)(36756003)(47776003)(316002)(8676002)(426003)(5660300001)(11346002)(8936002)(486006)(16586007)(4326008)(356004)(6266002)(2171002)(39060400002)(36386004)(103686004)(6666004)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR0201MB3512;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT038;1:gTn47iWUBe2pY5X+1koJGyA6ysW9Nh+r3eapkHjcFMuX4aB8Kyp38oekvmkYRtXEZOqinTpJ5bnaU1rtqQUGZ89ga7IHnS1s4epG7EslGh6v1Vt8Qjmokd68347nvcjD
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 274fe942-6c7a-4cc9-9c0c-08d6310def97
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:DM5PR0201MB3512;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3512;3:kIMf0MWGPpV6AnAWls6Oh4/w9xoxeh0TiTD5Mkq4aT1uunkzj3jqqJLwN5MQ1DwNH9jpYnUE7odoYyyRJ/rofnW6ZzXl6dxk6kq6VhsGNcn2CwVyMyooXiYIVWRjz9f/BOnEMN6XFsdYJUf9fhbxRltMamIVWXu8qRBn67Pr91vHYsK51m0lZPb+Uef2af81VRsEsbr1tdycWqreIMI6kERFz9JeKUZM+Pg/j+TmSOLieAcG4LGPPz2LnUytn2+KENzLUKjKtXC6XIxLFOsTvqTB2iw/jHeD4p/scjJKuAQuzz/teed3edi0Av5m7xfdNzFuwZF6NL2GvrsZPt/9qiW99YoPyAYPnRD2hTiNrxU=;25:XQFTm7uHA4WwKqiAkAidmF/o7B0gZDWIGYvxQOByyyIVYH3UV9rIXW5S41SNE+8kfOrXJjnxex5fMTch/kt7heXGSlh03Y1ofn72r1yU7CmKPIFl6bVqbDtA4YC8OFZL1iQ8018eaPy2v8raUJ0O0Kbc4YyKqOMYWxNPUJilfz7NASkmhQ5spEcrj6RurVT387ICwat+Fc1JaSkvLU3cetDmMCdw3twJ1nJYQr92yapbVW/8lbOkiV9jp/xf9VTYfLJ/IwLEFLfGETmcIkDGF0TWjVAvKTD7uB48d88foa8wreT5q5IUYPu0bi+gQyvL0iNO5rIEQQ6rb8gJuwqqpg==
X-MS-TrafficTypeDiagnostic: DM5PR0201MB3512:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3512;31:Vggi19lY8RXBSZUal5jzv9uWYBta5eGilgUhDCtt81zpBH4wkfiWwR7ELg2Qq64RMYbbmWYRj8M3Vhv0/Ba+MDB12oNRKULiopjLPPJ6KAhVb/r+yBSOdSmAXBQVY8MnVgXcCSeunahHCQ361oH0U7V+mXJfkUV03kf2XI4ANcU8B4NF6QeGzKQFXjtkzNWKa6dewbOcpCWb0PTwnRNtfEqZCTTW7rW/QfFFVupwmGQ=;20:92W/cZ8ad8APPLn2q0hd+J2omgK1orzU7oug+M9Dyek/AKg92Jtg939SxYPKQS6g1lLQpgJWyh225vQ7azFFeIVNME+8VOrrK0q14DyOSTR1PBUGC1QJ5AULtzXzXkHUcYmE8BFbsEZShMFUPZkawFq+oyXziho7tiITfsuySnJXza4AKY0qeEYZz9kQf+Uqr9Myx9tsKhuULkPGi5mRWpkwtQBHvt3nf6P2jkp/wYunkltdBMdYTimRblChM4sPlsfR2mjCUysW+81ADUw7QQmOgOx01j3MYUR5MvXGwVPP99yM8YGiMZjjz4KYsZ+pRM2hiE00CxCzAAq6K3YS6uk+n5xn2A/3mXP/06kbak9a4olJ9/lO0z+isrJUoyeiqNfB6b0De2bzetqhpbLnN4RX0PO9kiUKcS0FD2zDnb9muwPzv3OjwCmsGHEFb8VKATc7DiBxCM3Iv6etDTsn478hdSIT2O6OLSnvzb1PThU4H2eQzyGphRIpNDaQhteQ
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM5PR0201MB3512DDB837A2DAA5A15EC39DA7E30@DM5PR0201MB3512.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93004095)(6055026)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991067);SRVR:DM5PR0201MB3512;BCL:0;PCL:0;RULEID:;SRVR:DM5PR0201MB3512;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3512;4:lBJGcjT9Ell1nYyZsHLfiZHS6RgrcM5ciUhgCbMkaz2NVEb2Rr6Hvb8iy2/FcnTsWKfKMzjXmmHVyTXBFLVibvdoVDl/1bPOyIQ3x4iAMQykxOFZSJO4pxd6+ledYdaYNrIuXT5tps9mNHv8XoMGCcwAy+FlHv4q6MT0phD3bAF8P26hg3Fw18oasLkI0z4odUXb1HWq4bs7KZCBbGVewgsbcIAMxsPGB90H7XbXD0737ec8htMQIALIZr1uKVA7pv7lLQino0fskw8OSzXGCHFJYp6k2n0MWTTvZQPmsVLBnpeBoxUVz9HxkkbBDhl+
X-Forefront-PRVS: 082465FB26
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR0201MB3512;23:jJen2c36xrqy/ACByEKZRfZ4wKO/cFFg6wFm1j8?=
 =?us-ascii?Q?0xrUp3UPz0ZSfV/Zr42oFERa98a+QWPPTRrLDoidWDdQo/Svvi2hPLcaSOpi?=
 =?us-ascii?Q?P3xjwThnufszT43Wzgoz/2ZWeCAOmtUytJ34rAysLwZtcUF6FX2/PUFeH4QA?=
 =?us-ascii?Q?ow6wxsV+JTIScJzlCIjvdfNC3IKHSpNHt6M5pSav0JxuO7GReokLtZvVSIUN?=
 =?us-ascii?Q?DT4/3FcglHf8EfA7+xjkicT6AnRvicbDlY2bAq9k5MPDuwc2lYYLft4HdyJS?=
 =?us-ascii?Q?j4kMjabuoO83EZ5vJtXW1UGMbaN5Lwsib/FdhS1vL7a93bOZycZkpviOt4bg?=
 =?us-ascii?Q?jzgLyhwiZdeOrlJBzY1J81GXow89tHu/XNgXkFX2hMgYoZJUrzLXBPGWt3Iu?=
 =?us-ascii?Q?Hr8hcMtIU0W2Hk1EbTaXu1sQD2dZyf5QJnN0zkai9qNACWni/9DAbLwIAQK7?=
 =?us-ascii?Q?30GZvYVk75SfK5ioMAzI1Lp1R7sS9XYafJh4KjF7a/hCMe5Jr2xM0sbdPnGi?=
 =?us-ascii?Q?l6T/ALY3N+37GIHcTMPQ+GyU6HhK8oGOaiRqAEwhZPfy3n8oKvEDUk2obAW0?=
 =?us-ascii?Q?gDYjvw8JqkYr3+CBSdM8yHXhSdK30LRezT5/oAAKCW9xMRWkHGWHV/Wy3NXf?=
 =?us-ascii?Q?Ygkroq2oMwyHxpwagsbb3TKX8CBA2zQyq2ys3UqtN6Mwq8zILltyGydUA/Hd?=
 =?us-ascii?Q?54htUGpSOHdHsAiMJezwR7sPE8uBmgjXpTQjoARlBHYSMESMw20QELdDYc+T?=
 =?us-ascii?Q?s5WqIwaZKcWXw3QCyDUDVaaXYyPBEDZPPodlA8RDIe4MxWlU+8IdHTt5Sw3I?=
 =?us-ascii?Q?MMUEaiizKRkTMxgmbWmiOIZYceMGkQo6i5vYtv38QtcqPXmd5xwDEXS5Hi9S?=
 =?us-ascii?Q?WMvk3Toncpl9uRV+jv2v7EkFwTurGELdpKImmHpZMQrEFR7tZDh000vRWlu2?=
 =?us-ascii?Q?BWGL5rcYxj2Ie/9piGYc+7MMai8HA+8qqKLgSTHiMKFayy3iXxgxxMu4Y5nb?=
 =?us-ascii?Q?rE9c2QpKK49AQPBqkrXU1cTYeCnpHGpCSyXPNK0e7/mzeF0gTptuNLVFr7RA?=
 =?us-ascii?Q?M/6Cx2MImLkKCiK+fBzL3XZfxZ25sJPB85/r78k8heI3EPw7NA45M8yhFpzv?=
 =?us-ascii?Q?qUapoMbq6XZN7LrcJsW2ZaYAnqkRQPLmURjxbG1w0imuWlxjmbpjoNspAzQg?=
 =?us-ascii?Q?NSbzH652q/Da1huT021NE3ti8FzrUIl3MjiBQBsrbCNi+AfSd8aEwDlFeeBn?=
 =?us-ascii?Q?LXiwiX39bFWsKHxI+j1FVndUHZ+6lU1poR6fSQDhA?=
X-Microsoft-Antispam-Message-Info: HNCCXfl5w+GgOyuiJt2TShiXqyfmrgSHXNoQ599wnN3e7NL4h6zBHpp4nKF3F8oZqFlmcrufQN1uwp4Vp78VDGcDViMooEVzGSjJhISCdjloI4pqrYhID9/Jvn2M4FRXzLag2JJyOIZcWw7yIE86p5uj1R/KfjgouzCZJ2GquNh7mJFUf0WZu7HXcVMdyHMJQ2876kssne8JT/CfLX59X0j+VmbsS520deFf0W5DaTqwqIwt8UuGpooNB6Wb6qqKoNktEGLanW21MiVd2kiZaU9sUSVf6FrFOBcypsB6mF7Qj6yv5IoO21tK0ejwFJMfWknYg62bEtdGK6BGPCpBfm7FWGcIha1cnC1lWK09yXg=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3512;6:mPfKu4oKf1DPoBvs4fi44GzISAvusxSaOnE+pa6VD92xBVNtXN6hjfI3vcSIXZkv1bOK6kvcDEL1foqg7sUE0zqPbMpOKxnqveQL9b3q+SM0Ajs3Nk5K3wFFh61OdELjtM0PKL4H2GkJeqr2UgY6NhKMKew6Ae6bEX1HdqrnfWkoNByXyw1dK4G7FQVfNtrjV6y5Il6Kou0OFzrELyYEtcE9cpps6P2dD0gsCKkuvg8tgNQKglg5RARlLRFgmaudC9EbiaBJoe8JgJCtUm7PgKO47SW9wKVxrEhKoqZRkb2OkXa+/surdHq6m7lnxFgo+PS4haVwVsFN47jmml6p9JA8uhBQfg8CE5ISewwc0YnXtych+8wts9VIChaJjeUhcDfcIM+PirmLn4+ESyvqLUzRYtja5lFP4OZQxBrtAy7aXS0z1PJ9+PpwFZCCXo850Y7vjZIwZJqBgi+rwAfc9A==;5:sPzfT5BsXFjiEWA/guUselqhUr21af/SKC/VNWWlJyIO4DIGtJa0Pweyzm/CblE2oK/1P2rHywqvSIRvhVMONpt/sZ7YA7VWmt1JC9Bu6vk3W/wmCVxeQmINQDeYG07ubkDyfyomU6d295IjWEMgxNT1rC/uFLnyO2PRsER3IRI=;7:yH4MwkGJ9y5ZAdXfWTHgS2AkGRxLg/JlBA2lK4rkjAsA2zg7fYOucdBIKZ0jJsLCbwSgUwhtbpMVX02t1V8ijUl4PLIrC/WymtDXf0nJG7Ge7ED+o74R4Hp1eQoGJLhjA1H6SmR9Ug9I95FnAZzC7YITPFQSunPvwPe5GS61KZnpRdHS7ZzDesXn4atxA5D1lU6T0IfhGwe5BI5/PiJmbLdDR9kkT37VzKJOXyLdzHVX9oLkK/WiDHKjh8xDqczo
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2018 13:15:19.8989
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 274fe942-6c7a-4cc9-9c0c-08d6310def97
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0201MB3512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Availability of TRB's is calculated using dwc3_calc_trbs_left(), which
determines total available TRB's based on the HWO bit set in a TRB.

In the present code, __dwc3_prepare_one_trb() is called with a TRB which
needs to be prepared for transfer. This __dwc3_prepare_one_trb() calls
dwc3_calc_trbs_left() to determine total available TRBs and set IOC bit
if the total available TRBs are zero. Since the present working TRB (which
is passed as an argument to __dwc3_prepare_one_trb() )  doesn't yet have
the HWO bit set before calling dwc3_calc_trbs_left(), there are chances
that dwc3_calc_trbs_left() wrongly calculates this present working TRB
as free(since the HWO bit is not yet set) and returns the total available
TRBs as greater than zero (including the present working TRB). This could
be a problem.

This patch corrects the above mentioned problem in __dwc3_prepare_one_trb()
by increementing the dep->trb_enqueue at the last (after preparing the TRB)
instead of increementing at the start and setting the IOC bit only if the
total available TRBs returned by dwc3_calc_trbs_left() is 1 . Since we are
increementing the dep->trb_enqueue at the last, the present working TRB is
also considered as available by dwc3_calc_trbs_left() and non zero value is
returned . So, according to the modified logic, when the total available
TRBs is equal to 1 that means the total available TRBs in the pool are 0.

Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Reviewed-by: Thinh Nguyen <thinhn@synopsys.com>
Tested-By: Tejas Joglekar <tejas.joglekar@synopsys.com>
---
 Changes in v6:
	1. None

 Changes in v5:
	1. None

 Changes in v4:
	1. Corrected the commit message as suggested by "Thinh Nguyen"

 Changes in v3:
	1. Corrected the logic for setting HWO bit as suggested by "Thinh Nguyen"

 Changes in v2:
	1. Changed the commit message
---
 drivers/usb/dwc3/gadget.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 9bf1688..2d4b184 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -913,8 +913,6 @@ static void __dwc3_prepare_one_trb(struct dwc3_ep *dep, struct dwc3_trb *trb,
 	struct usb_gadget	*gadget = &dwc->gadget;
 	enum usb_device_speed	speed = gadget->speed;
 
-	dwc3_ep_inc_enq(dep);
-
 	trb->size = DWC3_TRB_SIZE_LENGTH(length);
 	trb->bpl = lower_32_bits(dma);
 	trb->bph = upper_32_bits(dma);
@@ -993,7 +991,7 @@ static void __dwc3_prepare_one_trb(struct dwc3_ep *dep, struct dwc3_trb *trb,
 	}
 
 	if ((!no_interrupt && !chain) ||
-			(dwc3_calc_trbs_left(dep) == 0))
+			(dwc3_calc_trbs_left(dep) == 1))
 		trb->ctrl |= DWC3_TRB_CTRL_IOC;
 
 	if (chain)
@@ -1014,6 +1012,8 @@ static void __dwc3_prepare_one_trb(struct dwc3_ep *dep, struct dwc3_trb *trb,
 
 	trb->ctrl |= DWC3_TRB_CTRL_HWO;
 
+	dwc3_ep_inc_enq(dep);
+
 	trace_dwc3_prepare_trb(dep, trb);
 }
 
-- 
2.1.1

