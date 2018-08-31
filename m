Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A7BC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 13:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DCCE2077C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 13:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="f+GcAQHg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DCCE2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbeHaRf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 13:35:58 -0400
Received: from mail-bn3nam01on0053.outbound.protection.outlook.com ([104.47.33.53]:1189
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727406AbeHaRf6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 13:35:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5bC8ThV+wCzyb44ewFbIB3OwKh8VR3dWq6/IJRnaKZ8=;
 b=f+GcAQHg4RT6kBZCZsKVI0K+VE0vGm4Y1eNPmnR4n+4bAO/6oxX1/BjGzPkYqRQ/B13NKHl7IbR6S1WopsxsRvmSwLABOt+jSc8ELUcQWm3TahCgJFwTEu2zpgpsfvjVSDL2xsoIgg/C+FzQHNPJobt35OMr2cK1EYISWIe6UnM=
Received: from MWHPR0201CA0089.namprd02.prod.outlook.com
 (2603:10b6:301:75::30) by SN6PR02MB4942.namprd02.prod.outlook.com
 (2603:10b6:805:99::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.15; Fri, 31 Aug
 2018 13:28:24 +0000
Received: from SN1NAM02FT062.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::208) by MWHPR0201CA0089.outlook.office365.com
 (2603:10b6:301:75::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1101.16 via Frontend
 Transport; Fri, 31 Aug 2018 13:28:24 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT062.mail.protection.outlook.com (10.152.72.208) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1101.10
 via Frontend Transport; Fri, 31 Aug 2018 13:28:23 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1fvjTK-0001Hk-T1; Fri, 31 Aug 2018 06:28:22 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1fvjTF-0000Ak-Ot; Fri, 31 Aug 2018 06:28:17 -0700
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w7VDS9OY024490;
        Fri, 31 Aug 2018 06:28:09 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1fvjT6-00008s-RM; Fri, 31 Aug 2018 06:28:09 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 001271213EC; Fri, 31 Aug 2018 18:58:07 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <michal.simek@xilinx.com>, <bp@alien8.de>, <mchehab@kernel.org>,
        <manish.narani@xilinx.com>, <leoyang.li@nxp.com>,
        <amit.kucheria@linaro.org>, <olof@lixom.net>
CC:     <sgoud@xilinx.com>, <anirudh@xilinx.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>
Subject: [PATCH v5 0/4] EDAC: Enhancements to Synopsys EDAC driver
Date:   Fri, 31 Aug 2018 18:57:46 +0530
Message-ID: <1535722070-10394-1-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(39860400002)(136003)(2980300002)(438002)(199004)(189003)(72206003)(48376002)(106466001)(47776003)(6666003)(90966002)(36386004)(50466002)(42186006)(6266002)(54906003)(316002)(2906002)(51416003)(356003)(110136005)(16586007)(106002)(305945005)(52956003)(5660300001)(36756003)(50226002)(81156014)(4326008)(7416002)(486006)(8936002)(2616005)(426003)(103686004)(476003)(126002)(8676002)(63266004)(478600001)(26005)(81166006)(336012)(2201001)(186003)(44832011)(107986001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4942;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT062;1:l2hBju2fylBZShVNG8wJ8mrY7yvmsUT5rJxsFxKZMuyZDxQ2iye1DbKPpa9owlqBe+IY8wpQqpA76GyOGBncU86dIY6ZUNPkrcvM9A1O0MmzaXmf6gGuADzWYRtrmwzp
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8506d9a1-2ea5-48ba-765b-08d60f45a068
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:SN6PR02MB4942;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4942;3:SxsEwlGC4gaKZRgpTJ11lyVipH+Xvsx2qcaa13JhUZZpbpyGq9GOxW1LyAsxpaG1PjJJ0B5UNMElPXzPqk4IDS20rNoLAScwB1Hj/vgYW+Z4Ijk8Zxs5EbocllZL1SwzAW6T3n3t45COr5Jv4SQ4Nk3JETuZvQFIq2YMIjJhfLYxuTCBb97mRu9G/Vdhm7nJfMHVZ/G9RY10/o2EBHFB0XbC8I5BmYVfou+ukbA9muG3UepHyiOStWS/tImzbk5rNK0QPgHuT0YX4Camv5TdEezYPtv3mXCxVDafWHe7Td9EIeShefetuaBboUWwY0twLBkzqCz9POGuvDJzvCxFeDAQcTpheIl34mdippBK7KY=;25:3EOSHwXPfZ/UCEAFkxEBEqCCmRv6o1QP8ZgQxRgAmLxk89gmNKjDd7N55Apgt4dELZVN/puWKVf0fTPZzk6PGNcxPGaaVqozTFPlyscPRIFYO2W0vh5E64srCFZB+iiPOvyaOUn381iavSAKp/WkxZX20zg6RLgPR1yCviF//WXrNssqq0iydgUeMyt9qmMxiy3qgIHlqe9x6Vfgx2vdlD24y3K/m9RUFPcOdC/vON4DBLe8qbUOoAe5bmteY8cl8FEjEeJco1MKHiWKQBV9F1oMIYSap1x9e49sF3vPyqR6LoMaonbwIR+DRLRItzkMsejd9vtyU7RlfC7phhxTQw==
X-MS-TrafficTypeDiagnostic: SN6PR02MB4942:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4942;31:WzLAf4bgHVjDj1aALmSLnqN0rWAGbR/3zCqIE6w8AC1GflsjxGO2f1BTTy95wGhnfzpief86XnjiCaBd2DMxGsSkM7+ryxvI6tn3yU8woSo7XRXslRqVsmwBPLbwYQkCy3mUCHoSJH2R9tIVXmnR8yLhO75PFs1HVHIiG0i44lO1d9vKUhGjyP1q6KYLyU15DMDqKN9p19EUhcb2Grvg50IHkDObCPFnwwm07ZHGRHI=;20:dibWq+yayAcAP94s7+/4TzwlnOaMz0DmZ/5+6E370jI/pxDxfGWzuc9YU1uB4jxLR+0M3kzFB3aaPFE+J+9JGOft+66AJ86FcYhVJ0tMdO0o+haU2g/evzuus/A3k9FUAVlBCPLVX7kshIJoPbpquO7gYyWd0TxpnP5o36V0ioWhOYjaJmk4ioEWvHILssFcZ+j7cJG5lL05M0tDjEaUHGcFjUePpVHvueitKtg0vk63ExIT7ndHpCcvhcXvVSgb6Tzk0eX7EU7aizyoki3XXfjff49odjc36RcLf/UcQvw2tkVNGI5XiJZCYS8OQ1SdlKcAgikgDIK9PQNOZen/091Az2R/2xqlbip4o3zG28lHQfl+Z7KwHKrsqLRxGjz+ZVYS7DSskgVW0sq6UCm2Kaha0q5tc6B8+aVG/Ova/aeGONc9WuRpokoLNdCL8u2ki/G9Xn7iPhuJNHZfVYbgW1Xr1D+n015L3dL8+qpyaGhLnAqH/I6AoDKtBC8z3SUX
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN6PR02MB4942E17F0AB789A3C19AA89AC10F0@SN6PR02MB4942.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93004095)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699016);SRVR:SN6PR02MB4942;BCL:0;PCL:0;RULEID:;SRVR:SN6PR02MB4942;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4942;4:NueJMnyOdnfdOmAMiGI6tnoRZ4/lvjOJTqwojOSJiUuZH9lHNI/98AEJ+V5EdtYUOZkgHEBivGmfIXBjx8Xb4ZvKwhiJK6HSTzEILJwjkY71d7asY0GLnZJixpdZUsqI51rT0ZBK0LNj1lHmoPAMK/uyIiBpEzijnC1Uo/pCFT1UXWsKlLOaQHCcijKpmrCd5yZHSDiLgQmB6aA2V5N+BMytdjvJRQw1opS+/SCzh4iBx4FspOY+T+wPLOpHeZJqGDvcBGw9cn+2zdLnDo5teQ==
X-Forefront-PRVS: 07817FCC2D
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR02MB4942;23:6dcxXpvRRlvbK8WvTxuf5fU5K8/LIJ+GslRR66Viz?=
 =?us-ascii?Q?T7dxS+x+KR1zXaqk6mmQvVIlDmE6ViFQq6gl9eI9y1tTdQUfPvDQHTkaYYdC?=
 =?us-ascii?Q?yblfmeCV0LPDy1+9AC+dhtCzOA5povr6YmftSZx2AndbH/GFphlnbc9GyorC?=
 =?us-ascii?Q?SdWmryg36WO5wygcrAKfNwXfzunBCdrjNN/e0b0MAQriAyHQTWvDCwLRjaD4?=
 =?us-ascii?Q?RQXXTUQFJNyIu4kzA1cHxy1vhcnpKI4RF5i14ZwW7PzSuZOfYcpfSEh+f9QN?=
 =?us-ascii?Q?UNs22YQPLOOx0WnqCEg2M+zsUVC5F61XAfXP5wKQpeMRS7zhNI5XHMI/UGHD?=
 =?us-ascii?Q?HbWuc/l7Xp/+NG6LmQxVS5FiEKbch8jdWl0NxiX7i8T+kp6stdD6Xu0bqd9m?=
 =?us-ascii?Q?yHEGsvjILhT5xt2jngv7K0oz6jgaNHv8FbdPYH2LgK8/GjKOU/tw8Ys4fxy2?=
 =?us-ascii?Q?25wjVNcdwfHAun/lt7+t8dTdyFhBPUBAzdeSgeoJutHsxgl41iDZg30U6Y4E?=
 =?us-ascii?Q?e9aLn/dIKqzl2PxUr70FdhjG+EeZEZiAIfWXHFvPsF2rfz8wYzoIMkArO0iH?=
 =?us-ascii?Q?l73LxVa02psjYcmHDH/oAALeoKhiJePKYFs902v81bFSiX2LgupHHy3aCeGC?=
 =?us-ascii?Q?Z7+9W2VPQevkMb/ir3/aeLhgSfhyHDE+wgwIs0lVg/B1utwYSYlAkifO5IV2?=
 =?us-ascii?Q?Yg6GBnCQaSp61cF6ED03LNu00mCJamh2TE3qyr2dQmTpf09EuSteiQ5JB1VY?=
 =?us-ascii?Q?vkDC/KT8JgDrl2kajFzq1yktu/fpAvUc1bsuvn1eJnQK9Ak1VN2ERN86+5YY?=
 =?us-ascii?Q?k2KF1pK4uwOu+XhsdFc4mf/xHno1ohLcve8DaC/pJ7WFU34UmRuf61HOywLl?=
 =?us-ascii?Q?F/ZV2DFdJKxxl/kX1JsdmI28r5yVSxQ/dOftg2AJorREyFKcyEPzWaRUGxbS?=
 =?us-ascii?Q?EHNToWCcWbS+XUXIkzWwlGQi2dLSlb6CydI+b7GyEBhKbCsqY3DmNVJE42KD?=
 =?us-ascii?Q?ohvk7Iwf8WCVGWtQPk6pM22Uh9kdk9mucaYPKFBLzs9WVzFJQfRD8M68QCS9?=
 =?us-ascii?Q?V2W2b6IVcJHcKonbNgiTjysNVAkO/0CfLxbZxl2bRdQeyoUErvHgFh8L3lV5?=
 =?us-ascii?Q?UNLZUkReluzOkw8YGJw5wxr0/J3QjkCcqBEFxkhjbOjlE4EGGX9OQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: Z68NjVgoTKyUIH0qXmhQYg5sqr2PTx0vTBN17ZPBNC0cabz/WUwhPK0kkCmUkVdWgWybF/LkCvYlzS7rDOaP+TveMQXJb0gCVZ+goAjlPRvRhHk7Gy2zC1dkwBE5F7a6E71KP/xWeWEIrunBp8PrOnbqjmBESVWVm3InJF+Vk8dUjCSUg4tZ0vqaL7RkLQEAuofc7g8JQ372BInIqhoXvAy19Ywxo5AooeSWC8BKVPHKEnpARkZdR4NTWM1OgeOBI7sz0Sqko9xCkY1pGKSr9YPtxWiib2QxyR1hmLxrJFZybShybqLNsLsxZa3iNVguCbHKmcaTtGLZ4GdX2aos8FBGe6sTbRph5RGJiUnpVxY=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4942;6:2UOJiZslI0v8h1IjWgqBkYEzvBe/axXQa1rDJ/Uhehnbqzplg6s6EdAi/lFKbIpG3IsIKy85MLXxOulCUhmsynUHHEhbyp8IFzvW68bto9QBEQayA/mPpCH/Ahkoru7e3RD6QxC6gPG33DqWnzzNkbhZc0oisVtrWz1E3EM3l5VeTQCpCK1vJpuboC4FlGszXGbY7JQwp4eUiNkWE+c2z3qPnk8vVThMQtMZE3wYJ5RYryAQE+ja7FJ9+75UbG26E4aWWu+6SQ8nlslpANAdDrzCJOXLBLjNC+m7RiCd3g6kPmjRV3ggkMS0yLy+mDR3p9YjXijgKyViVriycqpsVzz6tOOaX1VsLRgWUMrqdLJlvmxyomioTDe6x7G/fash+IlrrX/Vl+L6BZcuk4gdC4+nXc1P8MRNA/ms3gKEcshKZSwf1M5pDM4dVnwspEesINU+qPR3zd1uhQVSHFhmlQ==;5:eEzL6MUrzdcYLa4wNJeGDXzsEaXuOY6TDwS0VaNseq37wb/yK9dD64Dk5XbJ5/diwrBQgingxl+AIOJyQfLozDczNSdrqtDWokekX5Xidx+ryqRMDtLMzQ+28dEOMxN/M9S21KKrYzxfM1tAnzRypz2Epe4Dtsxx6KvXoqYK+8Y=;7:N0d9XKa6fZPoLdsCMlFiBBdeEU9tePm3UOmNkAfD0yJqDrCjBaICXQMEI0VpkXYm4nkolxRAWAWWifdffdHqRR+QQ+Lm7OinBItEttLWLNqovzvgRLUB9UcGbKkccNcTi9i7NYfUvKZYd5ojhD25DG34S+swmYXLXw6JnqeTadaIZgPNYR97DqNL/Z32xVLTboFXaRjlGPjmMOG1KkuqkdyFcEeuar+nZu/O07hF/fpxCqYF5PL8WLExLK2AgxcA
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2018 13:28:23.2395
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8506d9a1-2ea5-48ba-765b-08d60f45a068
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4942
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series enhances the current EDAC driver to support different
platforms. This series adds support for ZynqMP DDRC controller in synopsys
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

Changes in v4:
	- Updated the commit message in (1/4)
	- Renamed function pointer names removing 'synps_' in (1/4)
	- Shortened unnecessary long lines as per the review comment on (1/4)

Changes in v5:
	- Updated the commit message in (2/4) and (4/4).
	- Removed the unnecessary check for match data in probe() in (1/4)
	- Some Indentation changes for better readability in (1/4) and (3/4)
	- Removed repeated code in (3/4)
	- Used 'zynq' and 'zynqmp' instead of 'synps_enh_edac' in function names

Manish Narani (4):
  edac: synps: Add platform specific structures for ddrc controller
  dt: bindings: Document ZynqMP DDRC in Synopsys documentation
  edac: synopsys: Add EDAC ECC support for ZynqMP DDRC
  arm64: zynqmp: Add DDRC node

 .../bindings/memory-controllers/synopsys.txt       |   27 +-
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi             |    7 +
 drivers/edac/Kconfig                               |    2 +-
 drivers/edac/synopsys_edac.c                       | 1086 ++++++++++++++++++--
 4 files changed, 1002 insertions(+), 120 deletions(-)

-- 
2.1.1

