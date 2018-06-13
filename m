Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B0BC9C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 07:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5271520891
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 07:35:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="kynFH3gO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5271520891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934787AbeFMHfd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 03:35:33 -0400
Received: from mail-eopbgr710085.outbound.protection.outlook.com ([40.107.71.85]:60514
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754469AbeFMHfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 03:35:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M0GiOHrYUdTKGhsPvkpda3cJkkZKABcDxcFIvJWC8pY=;
 b=kynFH3gOm3MMCoXAGJgStUotQWxrFLZo0NDu9QimonjKPFrZXY0TdYouYKEH5VmorXIp0NS3Sn81p+lnSmOm7qu4p3ODmgXlFcxtlwaa//ebeqtwAZYhrLtBZWXGr2qTyZzIM9wuu269rFacx3ue7PAoXPhEos/Rv8pJh38EaIw=
Received: from BN7PR02CA0016.namprd02.prod.outlook.com (2603:10b6:408:20::29)
 by DM6PR02MB4954.namprd02.prod.outlook.com (2603:10b6:5:11::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.841.18; Wed, 13 Jun
 2018 07:35:24 +0000
Received: from BL2NAM02FT012.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::203) by BN7PR02CA0016.outlook.office365.com
 (2603:10b6:408:20::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.841.15 via Frontend
 Transport; Wed, 13 Jun 2018 07:35:23 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT012.mail.protection.outlook.com (10.152.77.27) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.863.11
 via Frontend Transport; Wed, 13 Jun 2018 07:35:23 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1fT0JP-0007z9-0m; Wed, 13 Jun 2018 00:35:23 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1fT0JJ-0003Ht-Tz; Wed, 13 Jun 2018 00:35:17 -0700
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w5D7ZCEM014897;
        Wed, 13 Jun 2018 00:35:12 -0700
Received: from [172.23.37.80] (helo=xhd-paegbuild40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radheys@xilinx.com>)
        id 1fT0JE-0003Gk-GS; Wed, 13 Jun 2018 00:35:12 -0700
Received: by xhd-paegbuild40.xilinx.com (Postfix, from userid 13245)
        id AD511B2098A; Wed, 13 Jun 2018 13:05:11 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <michal.simek@xilinx.com>, <dan.j.williams@intel.com>,
        <appana.durga.rao@xilinx.com>, <lars@metafoo.de>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Subject: [PATCH 2/2] dmaengine: xilinx_dma: Enable VDMA S2MM vertical flip support
Date:   Wed, 13 Jun 2018 13:04:48 +0530
Message-ID: <1528875288-9140-3-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.4.4
In-Reply-To: <1528875288-9140-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1528875288-9140-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(39380400002)(39860400002)(396003)(2980300002)(438002)(189003)(199004)(426003)(446003)(51416003)(6266002)(48376002)(478600001)(50226002)(63266004)(186003)(106466001)(26005)(76176011)(90966002)(11346002)(50466002)(2616005)(54906003)(36756003)(110136005)(356003)(16586007)(42186006)(5660300001)(486006)(47776003)(476003)(6666003)(2906002)(8676002)(2201001)(52956003)(81156014)(81166006)(103686004)(8936002)(305945005)(316002)(4326008)(107886003)(106002)(126002)(36386004)(336012)(107986001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4954;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT012;1:k1vIJFTV7u7X6Zqo3RWHQXXxpwKm2EKwVywok3+Il+U8/RRI4VONm1gR5hZizpLz6IH7NqZZ28A80lr+NU6E0CK61hrDFECkYlSzKsOL9D3ye6JNs/GuvnMpFyw5zHPh
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ae8c1cc-2a3a-42d9-9ed3-08d5d1003992
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:DM6PR02MB4954;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4954;3:KN1HuTKAgFFir0cBB5vyE94uAb3fmu7U63eQkl0qqidbZ5afJDqpTvgd76LSCSj/lQtI4f+wbMO1cfZmi0AlG9yYfuYVF3H5AJOAh+3u+VqmBlMlsPwbQVfKz1e5Dpf6C67y58LqSyQ+KiSDcS04a3ye7Exl8C34D9Gj9+bVxrM1ScDcHX4FPBB4AQWCAWNSL0qYe9fuDQsB8chFxW+B2lHywaTMtRdYfB5GFdJjm3khMwSqc+epb1qyQB361JW21U46dETYbkFndb293RDYwTfMmn/A+8bL+mfFJo2op/Oe2Xs0j+k3MhRz5D/gX0Qn5gLOD7fya69BDUzFG/Hn6cDSvxqD9F0OBJL7tFsXaNU=;25:9BW8amI1uDvpOu3G1GRgP2KRlTfqt0/Do/uUAJO8dmtD+fa3eg/JwsHSRGKl0ZYf3arlP1u8fpVnhsrsV33IRpLN0u2hpb/Fmge58bHg8AK/8tBnLnC7Laj6jXYvnmsEqjGwuHuqGUbb7E0RCJ44o4QIcBDTdxY5jxJ3aC4ECYE8B7UwY5qrkKP9ofb2S3zzTuoE6cqTqQ2SMNnOtWYhYZWVfkeSY/KQZ4gkgWVjzyQ1OCdYiRuh2Hxkum272tQdGNEwm5wHO6aD/m8n8bfDD9pKLor0Mvc6BD15tFsH6y5ZgLSbYuF91Eks/g4b6oQRgbGwlBJxAlfZ9RdNKgj73Q==
X-MS-TrafficTypeDiagnostic: DM6PR02MB4954:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4954;31:4ZXBAqzTqWo2FsEWg5oxxnh28OEqVFsHQ7NhLV9xgoMVpKMKzMSWrAl9v5F26RESXM/ZzLoMO73BvVHz4Mqe1BxsS2JNMQJG4SBGZlGwn8UDPCfczcCroKSghUlmI4zGhufUaUrXaiyVR3V6cY6rCXCRN3Ll6zjOxiapbcCFJmmT7medU6BufdfnuKYwh7sK1hoxX7NO5DSZ0t2GMPOzzLiP36zt/jHjm5OoVU5LP4Y=;20:FnDs2fn6PniVEdI3jzxCFV+uoIn8B6VcQwgduLxhIocUBsIc3qGgIqUAYGgddZqjs3AUDJALqAsmDwpW5DMM7sokUDxtQNmOV7JFC05BiMwzXYFXWsZYoRDZ0Q9gqfIebx1y7ewldymviFPCgAgjx+486IdlNUM6dgvFs7RqueXKE5CyjgYaWyTkgFcKWTeITlRIpWUEbCYs42WKCd5IZmwZMbbrHNMgqJuKi3Zu7cg9nYZNC/0KYWCfiwYKgoCLr/q+Vn51MNqSNpdkJ2WAUXE/dxO/1ucosxtjLtwUHun2pFtUjUzox8FcKfAZ/gAthPfaOpCVXgcZARn83SYehoA9I5QYh+gKanmVyUz/6xn3M0vPSkHrIE9GXS2KtuhUbNQ2/QkBKWlGQNtF95ziJy72dnLDJnMSyXPIJX0kssUbbBkAwjBwcbzqiaxFvv1F3jXsrpqP3SEGVrInVRJQgBFu5ZS1x42kkth3/DGuv7Q8E3FPrc/v6hwlB+dc7HSG
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB49540E9F26E6E1B4DD25490FC77E0@DM6PR02MB4954.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93004095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DM6PR02MB4954;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4954;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4954;4:dagl0H6emeM2D44zrBme2Zi9B26LH36kCprur1VgVpuRlEwHMVIkeCHBc0CqCGMmvRAlPh91pOfSNHjDJuGup0CvEPhP6JH6KBLaVrZe2eu/IyZSqeXauKnx89+4jvsIzUW64wQRXzPxRd7KIyhD8YG7YB50mIiRH4ZIzw3Ix8Wepoq+fxA9BTMxGaDMz10pXVF/iDuD9Yk5pdefs6KhIrcYJKQeA4U+B0J3CyhMIz/dbz1lZVArdlAqF6qiBc7+5eJinqZNSUBHhfzgEIfrJMIZb/yTTxztwcPiYzMKgzUVqxthCgF+FE1fENI5QNZV
X-Forefront-PRVS: 07025866F6
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR02MB4954;23:/7i1US49Q5pF3rgErQFzrZeVCSSKzveGEqydoiBy8?=
 =?us-ascii?Q?5SaHAg5/dA1GYyle09vYrk3RVn8obPBCW3wx2fvzCprUwFHEFeypFIVmwV3P?=
 =?us-ascii?Q?/y4Rga6kzKYvFkCAojDj/oe3kOvrHuO8VzygEvYQL9EkEGWrsy6J+d2EZCjc?=
 =?us-ascii?Q?qcc6ys6Sn9xpvzPtv416TOMACwjU5dz4c+bS+bweasrVpnhIDrLJn3zcH/XR?=
 =?us-ascii?Q?4Z5kItrcga6nYLU5LwIMOutU1LKr7XH94ESqDSOFrfWex5L3szwNBQwDTOTR?=
 =?us-ascii?Q?pSKpeMx48Yuq0wHKJ8wIyNMZ3YK9KzESQMGKxpyaG4sraH1idAvQCTf6BEse?=
 =?us-ascii?Q?qcYHzESlMwZ7TLm6euV+90XX5DfzbtY8qLdDt2SjkA5FbwDxexjb9p87GWc9?=
 =?us-ascii?Q?UA9iK9czMPQ2t3w+tjWSgd3Jpt9LBSdDaZx8CUucP1WEbwxjbXrfydIpZDJV?=
 =?us-ascii?Q?Si4K18fAzbLJMYM+ODNkX8PQhqaPTf6Aol2aOwKDBgYYr8DFwXD53QlAoJCS?=
 =?us-ascii?Q?trI2fJ4R7AcMxdrI//kuN3Iip77gklE/706wnNBslBGdBtSAm3/LIE00Ca8c?=
 =?us-ascii?Q?CJMAmC6DuE7yEnkNHW/E00dutAAMPTIEzY90xisgu6VixxnRUZgHRnHyJ4wd?=
 =?us-ascii?Q?4+7Ey0MvJ2rzXkZjhlAjN5GWq40MxllMXKy/T5T4v20L7xRSGty8V9TAy4H7?=
 =?us-ascii?Q?xzFVOFYK6XjZAa7wu8U/C/vUDJ0V+b+FcgMGhBxHoTpnMKPvEf5tvW6IRvVb?=
 =?us-ascii?Q?V2TDjDroKk9jcLTY0WYhPn4QHb7+GZO6keXC4BXV4kuQOY1kSvSrqCkZdH9y?=
 =?us-ascii?Q?d9uvs7krS1n3HDR2naCuvoWzjhcAPIE1S8jozgfWoulUzqsys9zsZ1JahZLw?=
 =?us-ascii?Q?qT9zD+ARnTxzrNrxz31GzJSb3/wxLW9LvGJzMULpeHHeSykPQb8NqXwkGnMA?=
 =?us-ascii?Q?Nke7bveAK6VI1Wn9GEldHobjAxwKHCSgWjwPAZQuALVkHLFimhP103kKicI8?=
 =?us-ascii?Q?9IRpcFuQ5GBmEKBkLDra/8Xmp03flgO3ReFaY0d5V8UNYjhy81jvTovF2Uck?=
 =?us-ascii?Q?AaGFda30jZ0BLGASGyioCV5W+2HJ02MmahaFDJI8F6PozD+suhcUhjLmDSTm?=
 =?us-ascii?Q?9JCpfs69Zrx4VpOSo5nq4ftWsear3r4kbzSBH5fJOzUF0mPZfnP3rZ9zCVTT?=
 =?us-ascii?Q?2BXmbLyh7A3M44nNKieRm/WsrZNagyhlI3j?=
X-Microsoft-Antispam-Message-Info: UVOcqMJDN03TnNTLsKUh/G1TUalXfGBFyHQGh9R2n7mXzVLjsazcvW9FwTPzoteT78aBMJbUuzcwFYvVEeegJRxOeq/V7Vck4kPTSIzhl2AFAUfPFyz7IZrJ42kuJcAMrqf86HooiFXljsCDDNU9hhI6zvomwIAGsmPqQg5K60yD1FWVhvM/cnfaKMzzOZLJ
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4954;6:k53NMn/Dy8A+NZhECV5796BfK7P4eqMvBRLPkartX+0WXFMY4XeorQxgrP/rQ1rR07jP39wVgVrglOOG7VsHqit7FcuZUbWFCL4Gn2rmpjw4S9q4XrhYgWzSBurdADwgAsIWTqdFuDK3d6DxSmmtLfmsPjmP6EPAWJYmJsmqFVlShuSzQdUzs2aoswf0BzyBAunZDM+LU/dTRIx8DB6KHkRCw2uwz/TRsDUip65w5SwLy8L5H+hmqMhysA2RbNIXmqCBdqG+W2Ot1hj3DYM9Fvk4IiiXJVdSAOAY8AwlqneeR/Ho8Gvdjv05WCx1VZtdRxHe7KPUu6vEyTEIa2lpLML4Oq68axMEcuBrLccYKV45LfDkKXG07jvlH66QB83lN6s4xd2B2xtJn9+Glx5dwwn2lBTqdwqk1/C0KDs0FfOXG2SAx3AI2fXBWTrAUjPbpt7J91R5vAC4e/tPly26nQ==;5:7w56OHbx/G6cISnlsLyrRv3YevTEYDD+UIx8+cAbG30JcbcDZ/jHod5boSN590sViIM1LhjipZ0xarGoYPBIPQg23c7b7+ktgAVkRersqtgwNqAwKbnhEgj5K0xPG1iBuNEJNQuUXDMzQ2hkhNrhMvCgaWutLjny4cw7b8hDNKs=;24:Yren6YbjihORQcFCL7rJ1ItE8QIPzATkmbcPbzvSasMXYDXX1dUFLxsKJl7skA4L3HKB46ggOKdCGpd49n2fB987QQlMrVAT3mjh11vgVII=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4954;7:98zgT0FCo/zRq77EuhR/VWlahRKWbLKwiOI+CfjYp1+qCM0FaddUaniPfiwE6Pj4xt9nlzHQNemjeHZuH0fVAwdoIRkCbUAQ4iEB0LbQW3sKsug2E22wJ9rAOdcGLARVeZcyf85EcD58yulgAXDvY5498UYAlaH9uIe1+4BdHK95729U6UDV43sFXBqigAJfGilyeRaNaGzOXhB5O/75wjNJN9F6PwUK/LecLCa3YWd0AarSkllgHGTrs+ANrg9v
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2018 07:35:23.6408
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ae8c1cc-2a3a-42d9-9ed3-08d5d1003992
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4954
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vertical flip state is exported in xilinx_vdma_config and depending
on IP configuration(c_enable_vert_flip) vertical flip state is
programmed in hardware.

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
 drivers/dma/xilinx/xilinx_dma.c |   22 ++++++++++++++++++++++
 include/linux/dma/xilinx_dma.h  |    2 ++
 2 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 27b5235..c124423 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -115,6 +115,9 @@
 #define XILINX_VDMA_REG_START_ADDRESS(n)	(0x000c + 4 * (n))
 #define XILINX_VDMA_REG_START_ADDRESS_64(n)	(0x000c + 8 * (n))
 
+#define XILINX_VDMA_REG_ENABLE_VERTICAL_FLIP	0x00ec
+#define XILINX_VDMA_ENABLE_VERTICAL_FLIP	BIT(0)
+
 /* HW specific definitions */
 #define XILINX_DMA_MAX_CHANS_PER_DEVICE	0x20
 
@@ -340,6 +343,7 @@ struct xilinx_dma_tx_descriptor {
  * @start_transfer: Differentiate b/w DMA IP's transfer
  * @stop_transfer: Differentiate b/w DMA IP's quiesce
  * @tdest: TDEST value for mcdma
+ * @has_vflip: S2MM vertical flip
  */
 struct xilinx_dma_chan {
 	struct xilinx_dma_device *xdev;
@@ -376,6 +380,7 @@ struct xilinx_dma_chan {
 	void (*start_transfer)(struct xilinx_dma_chan *chan);
 	int (*stop_transfer)(struct xilinx_dma_chan *chan);
 	u16 tdest;
+	bool has_vflip;
 };
 
 /**
@@ -1092,6 +1097,14 @@ static void xilinx_vdma_start_transfer(struct xilinx_dma_chan *chan)
 				desc->async_tx.phys);
 
 	/* Configure the hardware using info in the config structure */
+	if (chan->has_vflip) {
+		reg = dma_read(chan, XILINX_VDMA_REG_ENABLE_VERTICAL_FLIP);
+		reg &= ~XILINX_VDMA_ENABLE_VERTICAL_FLIP;
+		reg |= config->vflip_en;
+		dma_write(chan, XILINX_VDMA_REG_ENABLE_VERTICAL_FLIP,
+			  reg);
+	}
+
 	reg = dma_ctrl_read(chan, XILINX_DMA_REG_DMACR);
 
 	if (config->frm_cnt_en)
@@ -2105,6 +2118,8 @@ int xilinx_vdma_channel_set_config(struct dma_chan *dchan,
 	}
 
 	chan->config.frm_cnt_en = cfg->frm_cnt_en;
+	chan->config.vflip_en = cfg->vflip_en;
+
 	if (cfg->park)
 		chan->config.park_frm = cfg->park_frm;
 	else
@@ -2428,6 +2443,13 @@ static int xilinx_dma_chan_probe(struct xilinx_dma_device *xdev,
 		chan->direction = DMA_DEV_TO_MEM;
 		chan->id = chan_id;
 		chan->tdest = chan_id - xdev->nr_channels;
+		chan->has_vflip = of_property_read_bool(node,
+					"xlnx,enable-vert-flip");
+		if (chan->has_vflip) {
+			chan->config.vflip_en = dma_read(chan,
+				XILINX_VDMA_REG_ENABLE_VERTICAL_FLIP) &
+				XILINX_VDMA_ENABLE_VERTICAL_FLIP;
+		}
 
 		chan->ctrl_offset = XILINX_DMA_S2MM_CTRL_OFFSET;
 		if (xdev->dma_config->dmatype == XDMA_TYPE_VDMA) {
diff --git a/include/linux/dma/xilinx_dma.h b/include/linux/dma/xilinx_dma.h
index 34b98f2..5b6e61e 100644
--- a/include/linux/dma/xilinx_dma.h
+++ b/include/linux/dma/xilinx_dma.h
@@ -27,6 +27,7 @@
  * @delay: Delay counter
  * @reset: Reset Channel
  * @ext_fsync: External Frame Sync source
+ * @vflip_en:  Vertical Flip enable
  */
 struct xilinx_vdma_config {
 	int frm_dly;
@@ -39,6 +40,7 @@ struct xilinx_vdma_config {
 	int delay;
 	int reset;
 	int ext_fsync;
+	bool vflip_en;
 };
 
 int xilinx_vdma_channel_set_config(struct dma_chan *dchan,
-- 
1.7.1

