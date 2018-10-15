Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FDDEC28CF8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 05:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC92A2087D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 05:30:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="my0doo7Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC92A2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbeJONOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 09:14:01 -0400
Received: from mail-by2nam03on0047.outbound.protection.outlook.com ([104.47.42.47]:43331
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726368AbeJONOB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 09:14:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h7OaV90NIkPexgtCjhLKxAMAqJPwYkLB2Af92+ZiuZQ=;
 b=my0doo7ZVGz/iy25it+dwVPN34NaC1NekQ+YJGGFlMTWM624HqWCKWbLXqUSgk3zxYDFPwxhdrWbLNrPURbG6hqHqP2C9+ayLzR+F3gCT0MJcauMiin3+CMg/cEYkr7aC+H/hyZ2I1mAemrdIVuMBMpnf+7dKRAxBUShfv/7Ikg=
Received: from SN4PR0201CA0043.namprd02.prod.outlook.com
 (2603:10b6:803:2e::29) by SN6PR02MB4334.namprd02.prod.outlook.com
 (2603:10b6:805:a4::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1228.25; Mon, 15 Oct
 2018 05:30:19 +0000
Received: from SN1NAM02FT029.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::209) by SN4PR0201CA0043.outlook.office365.com
 (2603:10b6:803:2e::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1228.24 via Frontend
 Transport; Mon, 15 Oct 2018 05:30:18 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT029.mail.protection.outlook.com (10.152.72.110) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1250.11
 via Frontend Transport; Mon, 15 Oct 2018 05:30:14 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1gBvSH-0004Xp-OS; Sun, 14 Oct 2018 22:30:13 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1gBvSC-0001yJ-C0; Sun, 14 Oct 2018 22:30:08 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w9F5Tvof015043;
        Sun, 14 Oct 2018 22:29:58 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1gBvS1-0001dp-LE; Sun, 14 Oct 2018 22:29:57 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id B70EE121624; Mon, 15 Oct 2018 10:59:56 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <michal.simek@xilinx.com>, <bp@alien8.de>, <mchehab@kernel.org>,
        <manish.narani@xilinx.com>, <amit.kucheria@linaro.org>,
        <sudeep.holla@arm.com>, <olof@lixom.net>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>
Subject: [PATCH v9 0/6] EDAC: Enhancements to Synopsys EDAC driver
Date:   Mon, 15 Oct 2018 10:59:42 +0530
Message-ID: <1539581388-23963-1-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(39860400002)(346002)(136003)(2980300002)(438002)(189003)(199004)(110136005)(305945005)(2906002)(103686004)(6306002)(26005)(36386004)(36756003)(54906003)(8936002)(6266002)(63266004)(4326008)(5660300001)(316002)(81156014)(81166006)(478600001)(476003)(126002)(51416003)(44832011)(966005)(6666004)(356004)(336012)(72206003)(486006)(426003)(42186006)(2616005)(16586007)(47776003)(106002)(90966002)(2201001)(186003)(106466001)(8676002)(50466002)(50226002)(48376002)(7416002)(52956003)(107986001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4334;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT029;1:k3Oxc/YjiW9fxZSP5NEkPf/Pd8C8eVBRUPJDNHQbGKQ+YN1U6WdZBecqfdiXYX5vCpG950+exzxUR7P1XlXjX1hQn24rBg+ztsA4WaN6w7v0GtBTYuXN71OlzrGHv1Ci
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d75e6694-7900-4a87-beff-08d6325f4b3a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:SN6PR02MB4334;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4334;3:CFcvP3b7G37b2T5SJ/P1QG9uKJgIJqBKgLBBGHBnRJHp1HTS32X8mPwANtDh4TIxxh4GktU4Nh3PNlPoiTJ2MPB5H0/UlBuNvAlmBSCf8dQsVpbZHmWU811o2+DWlSC5mr0CPhID2XRlkkpltSzrfoPaYzuo7IE30w/eQJw/xyDYa552+JCKI+ANvvX9B5TjP3Q4hYfWeUQdLE/NZuun0k5pdIJCk+39O2e3BdfTty/CFxoLdqrcGuVBc2sI9nLb47vJeeos/KhSE4FaLH7e6iAypubt2k63Hr0PR5ScArcJtpIUu7tp6QGOTqf4WgJPmzaAA9R+hOfnN2Jd9iN+1SiQvEHLFXfYTnPUzOrHOzk=;25:V52cpHfTZuxhqlaq+IxYN2LNN0DN/iPPNAaimEaHciMavOYs2xWV8g0ugCH2xO4/hEVKJ2O4dPtclILC/3JF5sQKh2aJwO2SikFUU4AdG1JEnUdzUPJWmEczhtkek4Uw3gzHk5yzULJG5zOkOO6FI4JZb8y/PJ3h+1QMtRX4lmI8SNnhRn1U0o60e+RbdXjmpAoej6dBulXAgNwZkC2IsyGBeFOZM/Lpq1EAZXnmgrBsrq28lR+QQZJALqjXHSrMwR+IJ4iCd/iZZp7qII37v4tdMzKE29O+gv+vol1w6OytIh7hieSuNreTwm6ga+eUbBwnsOD13XhaawlbO7tc2A==
X-MS-TrafficTypeDiagnostic: SN6PR02MB4334:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4334;31:YjxCZr0723B/3ZDlWEotaGJ29wkDVdLsY7+UZO203miP1RMdBeN7bCSIx6y1ZHOWPwOEP0YtT/Lwyyq00po84pJffB37Fdqnpawo5Gza1Yn96cKJkjeb5XAs9bncYABmgz+sRRyUUvvD8UY0u4XUYrLLCHF2UGaAV99cFgda2XwDmXeB/mdkB0iHcIfBxTEb91qWMETQsFJHX9ML0Dxc3BtoZXlBky5RUH3F15hTK2g=;20:0v3vc7MpV8h9UOkcGRhLWSSGc3dl8jYTsA5nwPNjPd/9hTriYxsJwEPovtiIkytzz6wcjPX/mSgd+IRJRDDkU4GmjuEy0uZ6S1BFxLIwMqCJNpCLtL0jE/vFEdfIbQWxZJUzI2+6mjGiGCvPk+xKNGxZxXQ+yh/UEZGnTptbOFPVxfMdvx86PF+wTOGUJ5vtY33l+Spmxo5NobmjNy2kkyPK0xCVnb0nny3HZTZB5SSd5X9nzP3LA4VTPCco5JCZQSeh3A4w4VFi5R8UkwuHN8ZpJkGk6gIplFNf6RcQSM1WFCJxHbGYX015QmObGTxM9mFd5KBBUJKuhDpSPWms8SHL9+VP94jo5tORLFU9xKbblNcS9EnG+H6x7uFZ+TXUL7gcR6ntOAG8G3bx5O8sRxvZScIOo2rg1JN9uonoysSs+E/r/9n83/iSHE+ewucAUwj31PeVOxNQgTKwVyeNm8ZKePbpN/JShuUcxVFxGH35ZpyRGql2ZAE+WekIHYVe
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN6PR02MB43346AFB6ECF8F98CEF895D8C1FD0@SN6PR02MB4334.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(84791874153150);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(10201501046)(3231355)(944501410)(52105095)(3002001)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991067);SRVR:SN6PR02MB4334;BCL:0;PCL:0;RULEID:;SRVR:SN6PR02MB4334;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4334;4:HNdZtGTZkHxVf++QACjsF7+xtotu6/b0HcEbkJJmv7esMi0Vhrg2VAXAkLdZnJ4uafQ4I4sxhKaxAvP2Q5TRqiHNM7KVqaZwhFaVJpIaqu5cTbV89BlJVeFpwKoRbj4a0e8YO1Y+T3St0GOTxYwz+OtJ5elY2f/aRjOajSLqPlPlQRrORHsdm6bxq7MAxCDvXUzx4WosOUxobQ+NCDyt2oarf/OoFp+iedk2DslJsrCXmiF0sBRnKjgMGvbuBXVaQv+itw6aodNbK2815kqex58iWOVwqFEWJwqaXHIwcfmtKt5mAtE45HYtGGqzTLoj
X-Forefront-PRVS: 0826B2F01B
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR02MB4334;23:e5WMdk7mlppQ2WdwLqpOW6OtrCcZpUFJYKGrnXY1W?=
 =?us-ascii?Q?KOmltYaYe/vB+PFHNphQgDP3IrLhI+clBU/1pr313be6bUDHlyUKts+Hc/Wf?=
 =?us-ascii?Q?DstNt0PO8Ha0q0RRz8SmcWpRDHn3nTfxggMpA9eH1VGhHCF7VVTinrtVO39m?=
 =?us-ascii?Q?FkWVBsXRWv602zzuMteTQ+IKb5nW9jG7yzUop2nnlELKFvkNzLQpRJxkk68F?=
 =?us-ascii?Q?UUzMFwqrdP33VOfMljKV60/GJq7x6oyO4vspj3dySeJjpaEnNtJeTm2Ga8ea?=
 =?us-ascii?Q?qTRFNBsnqAV0pEpY5pSSlkrkpZdOeVXgkA6a3S+d/jYIS2FkjxhpxJMgUnMw?=
 =?us-ascii?Q?5qY+VOlr3026kmuSTY5D13GyqOZCk2w+327J5YTN9tv9qNSli86JIhe52tZ3?=
 =?us-ascii?Q?58U0INnRwRtjoYtvmOLSZvGXPyyFEoTDI6bL46jFoYUkzf4Pc7X/Jr9EQsi/?=
 =?us-ascii?Q?vem3MnbgBuA28IwsPj2h7zRFc3szc0ShaifzmkR3sy/afiGlIROdowgDf5gj?=
 =?us-ascii?Q?R0jOP+2/iF0zE/TiMlbXTfNAjopRGjI12m9urD/Ke5CWXJmCgR0WpTZA7QWQ?=
 =?us-ascii?Q?NbOAH2mRrOJPr/tn47c6fzAHeV+5nkrozLxJk4QR48lBHfvnDgy0lK79M3bq?=
 =?us-ascii?Q?rhrkMER7J7Z2EK9VaGwq/a8clZZ8VrMJ+gfmiAc+ySUgIA8d0O7j+LiZmyL5?=
 =?us-ascii?Q?anADQIXvY/IvC4YmNndegv/r55/JAaxXIMP3KA4AU7Fim5p9vdbpMzYIzq8P?=
 =?us-ascii?Q?oYuff3lD7euTd7VLeq/lwNTp/OV1ym57XyLqrz9Dxs/ZijqqdlSo4WT+yMLR?=
 =?us-ascii?Q?GWoaKPxpwKSGTpzm52eihunlWjOswkHP7D8AP88JowJ9mH00rh6J3CN41uA2?=
 =?us-ascii?Q?HckmRZk7U4GCllGTMhWysWxSmlybuU7Y7IJD+k+QD/UPAo4UdkLRsoteIqEB?=
 =?us-ascii?Q?MC5u9GTnU/zukAsFm2HDygeGQo7R3rcricMc9oPGNm0lgkw50ooh3XDcc17i?=
 =?us-ascii?Q?1GhOybNLr05BmCA44YdeVxG7NeIiNxPWG7mwyNjhggxqMrrRc7lGnc13GYOx?=
 =?us-ascii?Q?q/1YaQ/31yK6gnTcojU/ckvKhtV1TKuyA+Yql5Ax/Yq3ljbkMlJmYmmUX9YJ?=
 =?us-ascii?Q?cbvbMKW2Ul+Jq2OgWUFnH9EJHH00Kh8p9AgHp0P4iWfEZglt1Q3KY3LP1jkV?=
 =?us-ascii?Q?xLg0P4MeoqF2gFPQkdm6pwZbYtfN0AbWtib?=
X-Microsoft-Antispam-Message-Info: Zce4eikFG51xqmoa45alXQwECVOUWhcVPVusIKwKijO8MDC95SDjUmTkq0VWAaFg3barA/9kLJ2O4pJ6lC7EPpsHrARmaEteqYwtO8iKPoRXCR3opI51VQwskgEV3G/lg9vRJj8gFGN++Sf2F9YcLmGXEGbkI2op5JCOZILTHgPGXuaYX0tJxmaGPcdgBNorYAmFDWRCuxbZh337O4vN8QGl+KSXhjxlLZBElBrgoAh5Eafb5iRK62AkVtNhGcJmeWN0mqa1aXL624YXJ2h6E0oAcz0zyj1jC2weshpkcoxWFV4uSX6BuDSxvIQVnx+QHcHZocu7MLfEH0RXLQF7t1ixUbfMYO63RaprBgWe4PY=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4334;6:huHqMNVcYyKJLyURnGP2mjaqcXxpEG0dPO+hnI3pp2s620RX/wtQizqdBss8SbzwUo+9vLxkfJUyPXQSqMI+beN45q3SclB3ErvW4hGTiMcfKh9JtKIByvMSrmnENClzmlPlfbXtHPaBW0dTZv3PiWlivsFi3paRAbfVHErO0I/prjljVApuHZ3LGAfcRyByzgQCktGE43mVsyKBIZZoDwO7RVpqLCWA9lg78uUmaqmiwiGIK2j3L31ZsO/bPmc6lB0EYOKjQ4b9T0a1UpNKHeErtFyUMtqcARwnEW+n8ckvacfHjtucsWpsahbH2l9N7gK+rZ4mWgW7kG4aITdX3O0eBShi8Xp3gOen3RDTgWLq1/b8mHwUwUKDEQwYvqTXEniYeyavLghAAPrak+uhbIbQftsuvHeMkSaJ1GOUXlZfcRl2MAFsO1z7iuf1wd8OqQkM4jCxkwv9GCO+/n8NXg==;5:vbnA7fwkys4jCAT8Nh+PbuLMrvOUxoi38weGMe0GBnAAnMuUd5n9e84z9UJrJaRfB44yf+lSLcJdiuB3DAIbm7h98CwgD210YeaW9D+Ae3JDx9fuu19zCMaw+EH98fM1uyhjMHSkqvOFiXmUIX+9QNI5Xzobtmr4fPatnxbLHzA=;7:0wyxSh3E8zhkV7xbzKW9zdXb8AtQ0O+k5OoIjzTtqeo4HqJNdGE+YnC5SbOXri24WvLCGJNgt3R1mz9NKVwku0D1p0MSqFYL1ZBliMoLLWm0WCyafL6l1oyl3UecdUhzTis/HVh25HEA4LUktL8gU9YxzYXJum25uz9ZyePErxx1PGK8CEzdfb7uKxVqN3rUvp3idWEpbigkRD6bEqR5JvTA5flCws1o3XtV2jKOqBQATl6MmKNZd8rNT9pRI5Z+
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2018 05:30:14.4298
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d75e6694-7900-4a87-beff-08d6325f4b3a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4334
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

Changes in v6:
	- Splitted the patches according to functionalities
	- Addressed code style comments from v5 review
	- Moved the Error Injection to CONFIG_EDAC_DEBUG mode

Changes in v7:
	- Included DTS patch (6/7) which was missed in v6 patch set

Changes in v8:
	- patch (1/7) from v7 is split in to 3 different logically different patches
		1. functional changes like code cleanup
		2. functions renaming
		3. comments cleanup
	- Added a separate patch (4) for making always successful functions as void
	- Corrected 'Too many parentheses' review comment in patch (5)
	- Corrected comments as per the v7 review feedback
	- Made dedicated functions for IRQ setup, IRQ enable and IRQ disable in patch (8)
	- Addressed review comments in patch (10)

Changes in v9:
	- Added check for return value of of_device_get_match_data() function
	  in (1/6).
	- From v8 the first 5 patches are removed in this series as they are
	  applied on:
		https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/?h=edac-for-4.20-synps
	- Updated Kconfig to check for ARCH_ZYNQMP instead of ARM64

Manish Narani (6):
  edac: synopsys: Add error handling for NULL in probe()
  dt: bindings: Document ZynqMP DDRC in Synopsys documentation
  edac: synopsys: Add macro defines for ZynqMP DDRC
  edac: synopsys: Add EDAC ECC support for ZynqMP DDRC
  arm64: zynqmp: Add DDRC node
  edac: synopsys: Add Error Injection support for ZynqMP DDRC

 .../bindings/memory-controllers/synopsys.txt       |  27 +-
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi             |   7 +
 drivers/edac/Kconfig                               |   2 +-
 drivers/edac/synopsys_edac.c                       | 913 ++++++++++++++++++++-
 4 files changed, 920 insertions(+), 29 deletions(-)

-- 
2.1.1

