Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B2AC71124
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 13:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8ECD2098A
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 13:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="N9jhhi3L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8ECD2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbeJMUwh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 16:52:37 -0400
Received: from mail-bn3nam01on0055.outbound.protection.outlook.com ([104.47.33.55]:16423
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726399AbeJMUwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 16:52:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kgATM7XGbplgbuwG34JbP2Ejn/5gltqNAqxxY4XzxoA=;
 b=N9jhhi3LcOTBsAK4C1Vb7fWu78EW+0VqLLpINMpvNezkb6nYsdPUhPHcHS67gSVX5LUgNepjzi+Ay8SWYmKuow2Syt5LO6v+mVGNdT4uctH0Q+GP+vwYodVeaCX3m3ka8Swk58LSh2c6mcpXxbV0kgdFjcIW51U7RNxVT6d7ck0=
Received: from MWHPR02CA0015.namprd02.prod.outlook.com (2603:10b6:300:4b::25)
 by SN6PR02MB4461.namprd02.prod.outlook.com (2603:10b6:805:a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1228.24; Sat, 13 Oct
 2018 13:15:25 +0000
Received: from SN1NAM02FT025.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::203) by MWHPR02CA0015.outlook.office365.com
 (2603:10b6:300:4b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1228.24 via Frontend
 Transport; Sat, 13 Oct 2018 13:15:25 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT025.mail.protection.outlook.com (10.152.72.87) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1250.11
 via Frontend Transport; Sat, 13 Oct 2018 13:15:20 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:58079 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1gBJlH-0001Gi-Qo; Sat, 13 Oct 2018 06:15:19 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1gBJlC-0007wb-Is; Sat, 13 Oct 2018 06:15:14 -0700
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w9DDF6J6026418;
        Sat, 13 Oct 2018 06:15:06 -0700
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1gBJl4-0007q1-71; Sat, 13 Oct 2018 06:15:06 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id 41193604D5; Sat, 13 Oct 2018 18:45:05 +0530 (IST)
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
Subject: [PATCH V6 05/10] usb: dwc3: make controller clear transfer resources after complete
Date:   Sat, 13 Oct 2018 18:44:52 +0530
Message-ID: <1539436498-24892-6-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1539436498-24892-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
References: <1539436498-24892-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(39860400002)(136003)(2980300002)(438002)(199004)(189003)(107886003)(47776003)(186003)(336012)(26005)(36756003)(426003)(446003)(81166006)(81156014)(8676002)(356004)(52956003)(106002)(103686004)(6666004)(14444005)(39060400002)(476003)(126002)(486006)(4326008)(11346002)(76176011)(2616005)(51416003)(478600001)(90966002)(106466001)(305945005)(6266002)(2171002)(54906003)(5660300001)(42186006)(16586007)(50226002)(63266004)(7416002)(110136005)(316002)(8936002)(2906002)(48376002)(50466002)(36386004)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4461;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT025;1:rHOAoFNFGR2Dxvl/9U8SqqXXazIF43MFsKx6ClbyvfeLxJIN0LwN6VWwr1WYhbSo87WdKqIXsRfEGGNue2xWQl+wQ77B5k/aLueJ789rMsVq32saM7q4OG0Tsu85ZFJa
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 060e57a2-5294-4f45-1b13-08d6310deff8
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:SN6PR02MB4461;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4461;3:cHorNF5mX2fho87PgVFK+FpcLiCRsDIfMhsjgw+YLGRpmQZ01eC7pks2wWNrPPu5IJI1k/hrel8bnUE+ULccfy1VeTKmMfvEq646u2kaZknCcuj4hGQfh0erCf+G77/7pL6+qSRpZbcCLWPAKnDN/r9GNA03V32zaCrijWwl/EIzr7oJnIbr45hljavThmObUVqhhfGxyxy3rIt5eH9zjqWXDWY2RkU2Rn2889+VatvEoSTJSKglv+r6FVGNER/YHpyY7En1AVINoPCVJP03+rWIL9UIDcF+6Y3h6O7vdCHPgnsWGLK38YCj6HIo3J5/aR6VWPTSM0+znCtUEs4Y7YTmOEGUIrgBfBTMdREo0ME=;25:Vjkd6ZX/fj7jboBDxxxA/ukoWv1lGV6SzJA3WOOrmUqgGIcJT0PGdheldbFNDcfAH+DUYMSojx2r4MXuGhQtKux3zPvlOz/mwEVaQFuLUz4XL5w2eo0qtb69V4g6m3zmvp6QYtsJejp+EUlXvTBlKtV42Fjup56Q1GAxS7yFDeeBLAKwHgnRquhD5riG/Ct8S2/ZjFU3Q44CsEQzM51N4bHo857Bjn/jcG9QQTticlHE3AleQTdnI/Cwc2+Wy+7TXayHasdP5VV+/JizUD5hGznCGhBY0e5lxKIKjqXFWmXrOtens0sYfAcD8X4I6ef16VrrSXvChPfhxm4+6dBLPA==
X-MS-TrafficTypeDiagnostic: SN6PR02MB4461:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4461;31:vuvuGV9dYiDp5CfXQWiTQs2G5rhdHsXBFH4tZP4MbjgzySAagVM0TJffL+sP0e7KqW8jTJGos9WH7csC12Nt+i/XkfzSpcKrZ5uaAYRV5OCy5sgRRERuyfM42F24piTB5C+vL794VEPsiYlXpzvYrrJOaiVGlCQedJ+RmyTfwbJppBGsdVLB5InOGFHIPraLq6NDNhALMjJVakXi/zZfJ363rIwhPdeiXrSzG9CidVc=;20:kKqiNtEaPOJgTIXJOCixMqpbOOI6LmEwH5Q07kgphp1KScPDwKGDb1QznFwRoh+yaxhcjOAoMZx3jineoWPFY9jAkzBc94IF2MuGmynST4sILe0cG+KHg7+dPWlG+CVhUb6FfxX18f3H5EPCfdl+Qhi0/pAwNIvm0H6PG6Rjc2MB2dIkUeqxoAM3L6XVrpisb85elQHcw6B2hLV1q6MBc3IKu6ZZN0wGNfnMU8ricWY479BT1xQez3ElfK5ZqYveqN/ovkCtjK9snC4p/JpaH8jSbm9LXl4/0OHJBE9f0Wk1lmh3fsh7njco/x4y3esPmT/Nqz65JTgtgpo8Nw11xckpj3DQhgH7wqHCHknGtcu1GJ/V/lWT9V/W0sA5rDXI1a4IwEOn/gVmjaEgw9TjUK0j7PQnW9jYPgJtgP9bX+mPZQBSncRjdIv9fX8MZMFu9fPn95inm3PdW50qa0/6PaxaZ6tYui9K3XppxdVxnCk2upvCdqFsrrxtqoKCKAxh
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN6PR02MB4461D138C8B8A6F3C31C27E7A7E30@SN6PR02MB4461.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(10201501046)(3231355)(944501410)(52105095)(3002001)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:SN6PR02MB4461;BCL:0;PCL:0;RULEID:;SRVR:SN6PR02MB4461;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4461;4:SlS101YTOo/n32PU4fAgCLCHVVk7zfzWalPyrbgEfHCroNToWGxcS7tUxwA86vvNIpBKOCUeYZnn2qnUiWIgPkepOlPPKnCAq6/zjpYFF9uCfRLOySyPk9Ni3gIr9Fk65cUI2U4dIebSVqZEavaAFOv6fcQUinOFOtJXRkSyiKz8etK/4tBVimirkOJb5eFHzFK3g9N3OLaFJ2I/IAAZIwkSrIDzRpuehj0L7rEP6lEx6rmEk3PyVwGAbexNbhs9Bqqh+hh5I4U912vWMB7KP2i+JWTe2op6J1wxml4QzyncyJYtYLeJOTL0PihKjAFK
X-Forefront-PRVS: 082465FB26
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR02MB4461;23:1CRnLNcz/SFr2wkq29NH+C6SHX9Jjqv/octb+80A4?=
 =?us-ascii?Q?TcSfsQwF0H1QkyS3YzoU07DPAaigs/V9PKHFWxLBJ1yU1prrB0D0tH3ABNns?=
 =?us-ascii?Q?K/Wwc5hbjdXZfPUOwAV/jW8cVs9yDuUloUtC+h4RKbeGvY1w/Kf2Rz4i7AYZ?=
 =?us-ascii?Q?lJ2uwESpukusljCxio+ma+muk2g1wgajBtNlksQDJDBQFLcgLiXapd+cP/VF?=
 =?us-ascii?Q?VUgaTiQ/oE3fza70/rmban5H6d1Odfjg2aCrIh/iiGrjlF8YSlv7fjhfRrGe?=
 =?us-ascii?Q?wM1EF3gyAF6+jNxiWPXgJBSBDaoWxptmEvlflJWE1uSjay0Y2qroQWYNg3em?=
 =?us-ascii?Q?byI8t4Js0PbG/YICrpshcquYUwMpn39y40gE8KRQfqeiaLualzsS4+WAqN4t?=
 =?us-ascii?Q?2gNx+uh3Dg0fSegYC0GkuA6upS1ABFlxLBz5M7SZGmYuZhCl3SKAC2IPr0hi?=
 =?us-ascii?Q?CcyQy+YJFzdtr7TpCETDZfHjjwmAQGScCHeuzw++mjXfV/cA3ts9SXpGwTg2?=
 =?us-ascii?Q?wIOzc+EhMs6JKDn5BQo0bwFKQKYLYplIQAAJ4jDN7GcOv0Tmp0wOVCLfPHnC?=
 =?us-ascii?Q?pYnU7YolrfCereqY3T7B9ptDuJr1pP4gNf4yj6JANNKurj6lKvV930fWZkMj?=
 =?us-ascii?Q?i0OeSxFq1cKxk8deVsEYyhQTmcp7MDTgzz5kEsxpfIytaC7+VHdwgVasE5xD?=
 =?us-ascii?Q?00v2r0pt0MuU4/0nZ/knepj784IpuMgzxA3i2D9vP1Ut/vjhOG3xi8Qprkg5?=
 =?us-ascii?Q?Z1OBAm0VNr9ym3+6T+o48ofy8SarlxV0LbUMe/uas4waZoZvofh2T7KRin0H?=
 =?us-ascii?Q?1zaBreYh1Z2+1E6K2ZsH3cXobbkpXLqPOZGEGJKPD2OCEUmim67Sd3u1A+ZD?=
 =?us-ascii?Q?BPM8chKu8CLsGM93hXl8p5KRpVJoKSiZmPcp9jCyUE7mH/8VbpRItvIA01AN?=
 =?us-ascii?Q?D1lKmQ4ANE+901hmFaGV7yRhZovItCVqdqBdkFd+RpRMGXoOdWl+ig5B8bfB?=
 =?us-ascii?Q?MuufFwKBh8dKl9o9DJ1vgQXVwXP3DyTRQxqUwX9JXZkVvc6rDeu6hK425H0X?=
 =?us-ascii?Q?oE5thwuEM5v9pqo1p9BCew/MFH/5KmJ+ix7ceFHpQZMdtmLEAqhbRjuMUkY4?=
 =?us-ascii?Q?2tKXRCmwRmbvo5XV2WBzdLS1M0Gzu+VZlK0y7+HtW+MXQf2nUvGRBx9uPlea?=
 =?us-ascii?Q?UBloUUogx2u0wz2AMXOsC05zYeXIw1ktlhy8EzvcouIiDkP2EXp7LrkhA6+n?=
 =?us-ascii?Q?htckTwiMcJeebgoGq/dFo6qxa12rdVL++0dr7pm?=
X-Microsoft-Antispam-Message-Info: hntjH+ukvQs6B3q8yNM81PCK4zJoMuaSeD2hjLwlGjMHmmaLvEE1HLZ7ZRqK+DXNP7D2d+st7c0kb2IQVvur+nwrsKsyvYydxIMzMsIblko8hUJx7S1op1wgsuiqvnAjRU5vwTiSByie7I40hRpT12M6wjcreDhuf1a/SoXnqiCNTjf42j4HqHfeB66f0v1bjqgQ7bdzRIfiHv7525fbCWf8XShds4lTAzL9V6/MNfCuPgFLZaHOdcCL7PXFBrd2kb17r1oW2V/olxIeiN0N9sW4WwJC2zSdtKCLYYYRnRGDjNZgGn61+ZMabhl2XhnJz9fPbQHs15vxSmOBJISyEQ6C9HXNW/dN1CGVuhzzqTE=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4461;6:AQTPaEPHCVe7J2oxeHtqpsCXrD6ZmtUY6/hBCIUtRzyF9MnKWIUdu5276+Z6/CHWZWCJvY2bCUW0G8TlaVN6SHQ67YtqBYj9y1acSvW6j81ZUrxCllvG8k+ir3xB+AgC9zyOMz3jn69ZjXUGXXkrpy1aUa+is3Bu2sxK2vT/2YHa2qHtRqdZx5xMCV7/hpJNYF6S3qGBAIx2K0AYWOzTLYsiFK8ZXtSxCCuIPiYgQt6Zyvi4WhBHuqPvPPBNvMCypI8Wer5ZuBPTiiWwMBTwTJha0AN4DhTUJU5U7WcA8qKY0HbxeczmnIHmrMbORUQfIz/3l17qLhD5KajsvqLKQAK3XbO24/RFVRnr2RFUGJGoT2PbYXX/3fkxrk8IjxyR9Ved/134R7Ly7nXF7ehLFj56DudOu4Ib4Lupwn5N4KjXoZXpoAkyyzFdrC1u1xh9+jngt9AIfs2Kw2Zaj9/F4g==;5:GDeoIXdrcVifDojkP7Fjli12E617S7YMR2GpwPptPO/dYCi6ucJibJ/RGIK9NUdRcdXZOwtwdk6v86qQKEzQSKJlhkB7tt4NJ3tuNUYpzXlaLGsoWpMRW2Z52CA9zgap6GKS1yGT3/JCJ5Ehu21IwNynHP+3YFCupOg/jFLu5wM=;7:Cm7wJFhvfZd1kN5Ng+8ulRUpSSDe/BRfpppHerkT/SdcYSlDoV5o61fawk65+btDtXoLlEFyzMxYR1p939Kr/Q7chkHciIoDLgmIS6R0ofZqTkK5N98yE/TyZfa+C44ITDILK207M6BJyZgh9HisZy0V58cxqpBkXIbaARjvkcBSQ4IxqU1DWgo6/mHK6ijhx313AfMW4uAlUpkQe0JYYSbpePE5mL+wU25x3K0jI7q4FjADCCAwOuA/81Y6xNoD
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2018 13:15:20.5635
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 060e57a2-5294-4f45-1b13-08d6310deff8
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4461
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To start transfer with another stream id, controller needs to free
previously allocated transfer resource. This will be automatically
done by the controller at the time of XferComplete Event. This
patch updates the code to issue XferComplete event once all transfers
are done by setting LST bit in the ctrl field of the last TRB.

Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
---
 Changes in v6:
	1. Used dep->endpoint.stream_capable instead of dep->stream_capable
	   flag

 Changes in v5:
	1. None

 Changes in v4:
	1. None

 Changes in v3:
	1. Added the changes suggested by "Thinh Nguyen"

 Changes in v2:
	1. None
---
 drivers/usb/dwc3/gadget.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 862ec5a..b58cd69 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -571,7 +571,9 @@ static int dwc3_gadget_set_ep_config(struct dwc3_ep *dep, unsigned int action)
 
 	if (usb_ss_max_streams(comp_desc) && usb_endpoint_xfer_bulk(desc)) {
 		params.param1 |= DWC3_DEPCFG_STREAM_CAPABLE
-			| DWC3_DEPCFG_STREAM_EVENT_EN;
+			| DWC3_DEPCFG_STREAM_EVENT_EN
+			| DWC3_DEPCFG_XFER_COMPLETE_EN;
+
 		dep->endpoint.stream_capable = true;
 	}
 
@@ -997,6 +999,15 @@ static void __dwc3_prepare_one_trb(struct dwc3_ep *dep, struct dwc3_trb *trb,
 	if (chain)
 		trb->ctrl |= DWC3_TRB_CTRL_CHN;
 
+	/*
+	 * To issue start transfer on another stream, controller need to free
+	 * previously acquired transfer resource. Setting the LST bit in
+	 * last TRB makes the controller clear transfer resource for that
+	 * endpoint, allowing to start another stream on that endpoint.
+	 */
+	else if (dep->endpoint.stream_capable)
+		trb->ctrl |= DWC3_TRB_CTRL_LST;
+
 	if (usb_endpoint_xfer_bulk(dep->endpoint.desc) &&
 	    dep->endpoint.stream_capable)
 		trb->ctrl |= DWC3_TRB_CTRL_SID_SOFN(stream_id);
@@ -2282,7 +2293,7 @@ static int dwc3_gadget_ep_reclaim_completed_trb(struct dwc3_ep *dep,
 	if (event->status & DEPEVT_STATUS_SHORT && !chain)
 		return 1;
 
-	if (event->status & DEPEVT_STATUS_IOC)
+	if (event->status & (DEPEVT_STATUS_IOC | DEPEVT_STATUS_LST))
 		return 1;
 
 	return 0;
@@ -2471,6 +2482,11 @@ static void dwc3_endpoint_interrupt(struct dwc3 *dwc,
 	}
 
 	switch (event->endpoint_event) {
+	case DWC3_DEPEVT_XFERCOMPLETE:
+		if (!dep->endpoint.stream_capable)
+			break;
+		dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
+		/* Fall Through */
 	case DWC3_DEPEVT_XFERINPROGRESS:
 		dwc3_gadget_endpoint_transfer_in_progress(dep, event);
 		break;
@@ -2490,7 +2506,6 @@ static void dwc3_endpoint_interrupt(struct dwc3 *dwc,
 			timer_pending(&dep->endpoint.stream_timeout_timer))
 			del_timer(&dep->endpoint.stream_timeout_timer);
 
-	case DWC3_DEPEVT_XFERCOMPLETE:
 	case DWC3_DEPEVT_RXTXFIFOEVT:
 		break;
 	}
-- 
2.1.1

