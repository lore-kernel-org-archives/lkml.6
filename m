Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B6DECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 983C32098A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="dM5Y4kIO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 983C32098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbeIQTQh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 15:16:37 -0400
Received: from mail-eopbgr720057.outbound.protection.outlook.com ([40.107.72.57]:41184
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728638AbeIQTQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 15:16:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wxYznD8722s7a2M8FIzPk7h2tOrvoGk+tafkb7UnGyg=;
 b=dM5Y4kIOHg8a59cdaVE3xCfIFHXKpVxUhPLU97OcY4z/+A49SJs43IxyBt+OaWXUXrGc5gB8NJDJB2LSQ/uDU7fQZ8gUvGteYXh/tWgIE/8IE4910IbRtfuGCvHmRz0OuD2d78+D7CJbgQnAu2pOVV6MOh03CAWsPfLgKyLfLak=
Received: from BL0PR02CA0013.namprd02.prod.outlook.com (2603:10b6:207:3c::26)
 by SN6PR02MB5118.namprd02.prod.outlook.com (2603:10b6:805:68::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.15; Mon, 17 Sep
 2018 13:45:04 +0000
Received: from SN1NAM02FT011.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::202) by BL0PR02CA0013.outlook.office365.com
 (2603:10b6:207:3c::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1101.16 via Frontend
 Transport; Mon, 17 Sep 2018 13:45:04 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT011.mail.protection.outlook.com (10.152.72.82) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1164.13
 via Frontend Transport; Mon, 17 Sep 2018 13:45:03 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1g1tpn-0004kQ-4Y; Mon, 17 Sep 2018 06:45:03 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1g1tpi-00057c-1H; Mon, 17 Sep 2018 06:44:58 -0700
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8HDioWr028483;
        Mon, 17 Sep 2018 06:44:50 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1g1tpZ-00056s-HN; Mon, 17 Sep 2018 06:44:49 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id B81CE12142C; Mon, 17 Sep 2018 19:14:48 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>, <bp@alien8.de>,
        <mchehab@kernel.org>, <michal.simek@xilinx.com>,
        <manish.narani@xilinx.com>
CC:     <sgoud@xilinx.com>, <anirudh@xilinx.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-edac@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v6 4/6] edac: synopsys: Add macro defines for ZynqMP DDRC
Date:   Mon, 17 Sep 2018 19:14:31 +0530
Message-ID: <1537191873-6582-5-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1537191873-6582-1-git-send-email-manish.narani@xilinx.com>
References: <1537191873-6582-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(979002)(376002)(396003)(346002)(136003)(39850400004)(2980300002)(438002)(199004)(189003)(106002)(336012)(63266004)(316002)(51416003)(76176011)(42186006)(2906002)(16586007)(44832011)(11346002)(446003)(6666003)(5660300001)(48376002)(90966002)(103686004)(8676002)(126002)(2616005)(50466002)(7049001)(186003)(110136005)(486006)(54906003)(36386004)(2201001)(52956003)(106466001)(476003)(305945005)(72206003)(356003)(4326008)(36756003)(426003)(6266002)(81156014)(8936002)(50226002)(47776003)(26005)(81166006)(478600001)(107986001)(2101003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB5118;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT011;1:wQUaTwXxfADZZRVuuaWfkCOpzUFletLxnNTIntH82bU7+Ia+N8ChVHnh/VCwVpJv4+AnN34C9m/F1fpRZ/Igd2BXyslTI/5jviDJhklERcnfnuAeo9vdrP9+AJPWBMzl
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec86615b-c121-48d2-1c0b-08d61ca3c58f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:SN6PR02MB5118;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB5118;3:3XinfavKKx2e9lgFJzL7h1PYE56t8mJcE4vvjZMW1lcmXjmDNiiRUvtf+3BKEhFVb4aLxhR+mXqlQ4CkWoXdAB+C9TR0A1BNzy56nnVe5nvvL9VnO+GW9SRezAvsBGzPJCMCih72VTDtVBHaAYV9y46fiPsahhyn1rDtcJV4/nGdgHSq9a0U2UbrPfNdCYHZ12EtSlcPPudq6c+w8B2WNHdl13qTh24w4+8o2JimnrAUlORr241nFOVsvi0t3ydHMFCOx90o1r1t4Y+DefyfWy95c+ruz0P04a5a2Q8ODvHMe8n2f7nlD3/Mr405w43RZxABccmh1M/s/yvpDwxcfv2hh3X+CsqLszFLrlyHpcM=;25:aOcfb/jmTAPedZFIZBBHs+OJ/YMUwbAaOufUaUjV5BoMcwdA7l+IbdrNNPZFCuLt7iYbkaC61DrzNi9eYNYDyezBHBWzVUPA8JKCJHmPdHvS6ebVEiVbJNyUHEZ/hR5WAX/7EzonRWF2leT4liqn+/D5wHRNN8JuuVoYgaX2heCz9wq07ZicfW5siqFUzUrxG/VIrAD2j0A87Jc0rsh1+shaLAHjOWFfSB/k4P6KTHx5zGaabwH/dCrseUBTxmKya6wnYSEWceqNPi+D2VHXpD2zeHqZUnbWOf3+82JuRiqG8Hmoa5gtQ2RRQeG7cEuK9funQoq4Dg54WkOLlDVHFQ==
X-MS-TrafficTypeDiagnostic: SN6PR02MB5118:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB5118;31:ghhCvR7UJZ28u9yO/rXQjYx9d8HKju8DmZRYmx5ZrDx0pvcmVirIdHhzgVe4rgn67ZPrR2JYGiUUa19IUEU/PXaLeoAcVlAjt3AmeFy0ez+5jXrrSiApSwbNJ3kmn9E+/mW8YvwaHrIyb/0+XT5BfUvEb5fkgxg86gKlsDmD90wPgOrmyszVPItUfUjzhK/IRTz+1rBJFyeaSTsuwWxshxnYhRBHyfxWqPqy/gw9EdQ=;20:gnNFgzR9F51YMpy+P5niIJkW+hFK8T84gZxlgbJWGij+E9p1UW3nL1J6qMl3H1frb1XOyGkGXzTohTJCeVAaoLKjv5RwY8BGlpwksiY/z+jpJBDBXTmbh84XbsPAvwQCp34/z1AupRGphTTwWa+4GXNR4Vuy+ttRGQ2KBC4+WPTf4mj1NinuOLOrp6ipmcuNGceJoTvsEU5LygaDQWyspY3pM6Lc861dRiE2z2Y/YjpQarAsCFTGV0jXx2AuRfnZm7BA5WYV30wyE3Usn4mb2aCrQUb9Bvqya8urkHYIS6tdt/92KyRwgyx07xSk17DNcmvsM6r8NSfwJcgEDJ1VnrJIp8jtr17MvqJRNIHXSrkM5GxpugjPOxLxpMuN+xc4P1vFpSzZjyEp6zMGgY8Dp1WksG3ocn+Cb5zR9sEJK7DBYxoXHpKFogUfq4RHsISDvOUVkywt/90weq27QNZ3H1OjGySVudgLUsMK3SUi+0Fk9cVzbSxrg+4CWBnuDWTe
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN6PR02MB5118BD56E3D48F5D671D47D4C11E0@SN6PR02MB5118.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592)(105169848403564);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(93006095)(93004095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050);SRVR:SN6PR02MB5118;BCL:0;PCL:0;RULEID:;SRVR:SN6PR02MB5118;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB5118;4:mZHD1dHdpcNXmI3R4wTnrtrhEmJXZv6OEJ6w5cAjYYlWyV+lev9As/v82pbIxWN9S0hwxvugDGSq4ZxjmsHF+S2Na8YzUe/jlasu13cbPY2HwJORwLZfmvhWuugHOS7wh48Aw56Mq0JaDtTGOyCkT8C63LRlV5e8nV7IBJgADVKJd8G/LA7sOwYEOE2hjPIs9jLlAUYQARPOERukDcvp5Dedzh8tP6Vt6botCIAzUkVUH2quUWeM+nq93gyL6qfhJCytuwrX5S5bAv0BmhWMXsXhL1o913VkArIXqhsJ4f7XqlQndnRixXVyaKrLR6aFYD5/O4pH/Xk84QHRJUkMsPvdCWALqmZThONDyEh8AiI=
X-Forefront-PRVS: 0798146F16
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR02MB5118;23:uGRuLiR7XPELK6D5tapBMATn7ng2w9usKEmDIj0xH?=
 =?us-ascii?Q?3HBgSFAwL+Br0XVhAUr/cKYSOR0zhhVq+DkU5OPrkUSk0SFWsjaUDh/YCBni?=
 =?us-ascii?Q?dRJBe6NIQ2gs9lGIY0XgZjyhy3r0YTBeqcI75uAtAIxon8DQ9xRunFsMftpk?=
 =?us-ascii?Q?Xx58eQn9c/Xnc+sdCc40NQ+/9D9kaBhuH6BX65uDSprVehfnx4wwvIqVT6Hr?=
 =?us-ascii?Q?cefyTc6t1vnOX8PNtDscwZP7ZuWAsthba3QfTMiVpxuHr0dL0/3mrlsNfS/y?=
 =?us-ascii?Q?q0Hlfl7mtRqmiKtPXXU7z9Er2dYMgA5B6wq0SB7CwgIDWUcZqVpmNEqR2Du0?=
 =?us-ascii?Q?MxqsbWlorbg1Z3jTU4himx0em3Z2oaFn1ysGviDM8pYHyac6AcbBGYnTRBFN?=
 =?us-ascii?Q?qwfCH8beTrBJ8p77LHnJQvweqx4ws7pIEfdsBb4QQCBznGRGu4PtXCUdmSTD?=
 =?us-ascii?Q?ZltPriUUr/PWQD13+Qs+WbtjwTD1mcVbztpsJYo6haJNPgJJkG3oQo2W7jL3?=
 =?us-ascii?Q?gHp6GNcfaK2qNRMFnjzAVsGWzRU1I5GbD3Pd8gMfL37wmMrkXQ8SxIMvTW/D?=
 =?us-ascii?Q?EHtXHmKfopbhBIH5jFmzvLG8UP2ajBtlx1OwW27j4Wi6+qEUsmjdgK7hHdAL?=
 =?us-ascii?Q?gF+S7vXgmgY6w8k5a6T8gWTbFY0FxoelbJ1jAt/1V75cNyIpXZdNHYdJb9UT?=
 =?us-ascii?Q?IWc3EnGNJTVB/ZnoKjyRBBr1Rq1ouN5EbEKByThmEiKB1jOCbtXtbD6UmDBe?=
 =?us-ascii?Q?e/7jfYp81N5xLQlVjDldjc4k/ZTYBzZ865xk7all5VMCFdQE3IMjkJnTcXjT?=
 =?us-ascii?Q?du++AghuV9Wr3tGiamnHZ8PYdE+Hisn9cxHhvEZPvZCMDVLU50iPNgb6nis3?=
 =?us-ascii?Q?I0JeL9V0z4z9ZK7zgQCHMbBny6GNcGhuwzozYdvMZ2k/f6IZ9t0FTO6vQd+Q?=
 =?us-ascii?Q?iHxHDjCkqYqystQdTDKx5Xa2q5WZKo/scZyxDKIM97vciAJZt72FzIiqc4Fr?=
 =?us-ascii?Q?fOl9QCEVTBNQKEUqNfxwUhP4yTe+269lHthCKzmNLNKcuFJGzH1ThJdqqzYa?=
 =?us-ascii?Q?mhR9oSik9KOf2kJN1pT8DdR54v7W+9C30m1IpMtEyOcRJBo2T9g/DA2+7+ub?=
 =?us-ascii?Q?YY7XzIowh8ObLMB9sIuA6VKdA3jbY1bc8aowVYV4qE9FyHzwvtcTdlzpYwqo?=
 =?us-ascii?Q?pykAK+kerDHw99ZNoOIgFcgRhhyRKZTaiG53gwsCzd37a50qvdn0UaUFUoF4?=
 =?us-ascii?Q?rK2a5u6pyutyeZCtNxZJO5WI6w+d0gO9Rg9bAFewBt0UIpPgh63RBb67epme?=
 =?us-ascii?Q?hkjaZALa8eGLY3LVq27y8Rvv6QUKKk2s0gNU6ospZgb?=
X-Microsoft-Antispam-Message-Info: vyUZudv4iWec2zgFvlKFk8ksb3u0imyTSgxLdDvaKcxu4ixPBdk6yU/7r9n3I8SLpo2r9gOLAHByVWJH6CL3MXongNZFmP+jOGG8Ee7z8uJ6ughy6I73tU6Uk0ZVs2wHyFMl1NtyWDd6txmdy2I6QbCSSlvPycj71ESf/JLXsFqYDjOmY6li+xOV0Y9td3HpeSL/xbKH7uHI5qUqn2QXtDdcerNr+m6Y6dXyc5pJhddih8dLsaD/ZYWNQd+t/+nXyaINvYPkptREHTbbyiXOP6F/UhacGQFT9AAr0g7eGcKHH9gGzcPB04NdwkPCto1+C3dcDY3VC7f+cyXYD7ZXK1zow7e+E2vInhiFbAE6m7c=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB5118;6:OhFNBxm3QCGuNXy2yNLhhqM/rMZAdqq1v5/FaVjfcmtZGv9yP5Sz95wnjwQE9bT/zayDv2uoNJxKDeEOJRxOSa4uZb6PX1ICU7kh9p6/4/ao79umck2uXpd2nn9StuhLavHsVo9f1zBHfRxy/CKBjz8WuU1u6cP99JPkMz8ix0N4Hlzt2ExZiTG9Z2nS3B7C6JUaC25q2N2fcAW3eVo8vsIcdwZcvSu9Z9utmXUkpT6gMR8bvOdBqaDLY9IqDNbw+mjH8a0iZdDjB99ARWdKWhzGxK6Mor7ozvGOzW4JTW03tQNq00uKpRKUiSL7zLHQbgbJebsuVqb72JAYUbPo5bBPyG2xmtQhNPf2NITtvOQAH6apiWIhiizYrjZwK6EmTHl+Hh9heIMQnJbYVs/tt6lIhGK+IVVg7kdpqbv+QQdKv2AOHPKBjR+uK9nQNs+s878LZN5Sv2k4mdjKoR5WHA==;5:JObmaKgoEe2tx42P2TuW+R51+NsFa1T8njoEyriL77Raw5w9z404RXK2UmENbVPTz1rFvAatpB9A899VQ18qlo254EeAlyirNhjYwH3FWCn48GoBguHKrDIFe6/Kyv8Omb8lWy+mZEqGeZENkVDkzOJrd7OXYGfHU0WzxZlrNd0=;7:UlaP1na1UMa3gBcwmpz6xhif3tPDTKJBbxJle4lFEnN4AjY7BzxAcZTZWOtczlS+xbse3hE9DtQVvfqEHQBH3l7NiRuIJwi06yCeEI/fBcQHkYiED7wOtMgPQU7nHGTjhH7OTsYxGPq4hWMlHrqWQXFoJ1mcARKkXaEBh+6azNLWZojgLgoH6OSW24J5RgvgFYitJ7HRa9aQNm2eAHWDmrmnzUlAdt+1W/QUIfV3o2l3DPZycTxldvDXZRQBTTQh
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2018 13:45:03.5647
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec86615b-c121-48d2-1c0b-08d61ca3c58f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5118
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add macro defines for ZynqMP DDR controller. These macros will be used
for ZyqnMP ECC operations.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/edac/synopsys_edac.c | 168 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 168 insertions(+)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index eb458e5..6bf7959 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -97,6 +97,174 @@
 #define SCRUB_MODE_MASK		0x7
 #define SCRUB_MODE_SECDED	0x4
 
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

