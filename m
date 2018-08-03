Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C191BC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 17:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 353792177F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 17:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="DVbqTpiA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 353792177F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731503AbeHCTv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 15:51:26 -0400
Received: from mail-by2nam03on0086.outbound.protection.outlook.com ([104.47.42.86]:53408
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727829AbeHCTvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 15:51:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HocsRqPj2eQGjE2XVpEC9FN28XayA3mpJe4M6gte33A=;
 b=DVbqTpiA2yXpnQWWPpVJftOa3sDdxP2UsgIvh36sh/022OZPb/2EBvsnOiNqrkkzTEIizFi0jwUEOhnjZTn1QBRwplEsD2CJ8uXcok/IVmB41NKj7jm8hVYKn4MPSUVwh9E8E8QqFObEm4DtZTOnie0kisAvjy+z5odvapQNCuA=
Received: from DM6PR02CA0009.namprd02.prod.outlook.com (2603:10b6:5:1c::22) by
 DM5PR0201MB3512.namprd02.prod.outlook.com (2603:10b6:4:77::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Fri, 3 Aug 2018 17:53:53 +0000
Received: from CY1NAM02FT049.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::200) by DM6PR02CA0009.outlook.office365.com
 (2603:10b6:5:1c::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1017.14 via Frontend
 Transport; Fri, 3 Aug 2018 17:53:53 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT049.mail.protection.outlook.com (10.152.75.83) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1038.3
 via Frontend Transport; Fri, 3 Aug 2018 17:53:52 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fleGu-0004fe-0k; Fri, 03 Aug 2018 10:53:52 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fleGo-0007cn-Tn; Fri, 03 Aug 2018 10:53:46 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1fleGl-0007bh-UD; Fri, 03 Aug 2018 10:53:43 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <ard.biesheuvel@linaro.org>, <mingo@kernel.org>,
        <gregkh@linuxfoundation.org>, <matt@codeblueprint.co.uk>,
        <sudeep.holla@arm.com>, <hkallweit1@gmail.com>,
        <keescook@chromium.org>, <dmitry.torokhov@gmail.com>,
        <mturquette@baylibre.com>, <sboyd@codeaurora.org>,
        <michal.simek@xilinx.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-clk@vger.kernel.org>
CC:     <rajanv@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v11 11/11] firmware: xilinx: Replace init call with probe method
Date:   Fri, 3 Aug 2018 10:53:28 -0700
Message-ID: <1533318808-10781-12-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533318808-10781-1-git-send-email-jollys@xilinx.com>
References: <1533318808-10781-1-git-send-email-jollys@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(136003)(396003)(2980300002)(438002)(189003)(199004)(81156014)(48376002)(9786002)(5660300001)(107886003)(81166006)(50226002)(106002)(77096007)(16586007)(8676002)(186003)(110136005)(2906002)(6666003)(50466002)(316002)(44832011)(426003)(39060400002)(47776003)(8936002)(478600001)(4326008)(54906003)(486006)(7696005)(336012)(36386004)(11346002)(26005)(126002)(51416003)(476003)(63266004)(106466001)(356003)(76176011)(36756003)(72206003)(446003)(2201001)(305945005)(7416002)(2616005)(107986001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR0201MB3512;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT049;1:Q3IxXRPxJrM39CbL4CERPcH1cxfk1IJkfmcqlkuiAYmyqmzmWXxBSOugUpiPScw3yqROTSsHMBCCLPu2aYih9HcwIVnE9dbiwZv5YTDUkJYU8+bzHCl3ZtAXvefIVJGw
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0045d393-b7d0-410b-a885-08d5f96a13aa
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:DM5PR0201MB3512;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3512;3:XuI9a6OU+Wix++X/W4xHpGLHgfrayqtIftW9xwgVabOIZThZL3AJjSrhF8y3EzUe7yPqJVAVf5/1ibvprgN39lOTsOjRab4GJyn/7Z97ZzOjlYMfXcrSu251wFqIhZNFxprkY6nohxGbCqh7PKUq0Hs/1C00Z8XhLT9e03DJC3lYJt8yZV7xJQWsMrheCinyD7wwwswauzy7+DUdIOI6XVrJ0pavF4U9lr3EViPi9G0zq6rcJRLbS1WOOsMafeRsKx5ZFOk4KJxVyoIT+llGcCxEEmzaMAzsFcemh4O0A5HSUSsIefplelPhqq2z1YaRVoGSRr6/aB7SNfKS73qVtMr+DopKEOPgU5qsRlgb1sQ=;25:gysTljDxV5yUd4qWs+8GiPCacf+WxzTD0KkPv8TTXIkE7ENdj7dJZjZJBhUTj8AYYdnBNb+5WbViDUJZeY8ilJ3v5RpNNYmmHqhY3inMp405adRuhVLXPfwkRKzf7jhyagbj7rz7TZ1XXL5bV0epyg/rDKlHOtLXVni5tfzCu/WWdxNsp72B6BBbs/qRTTBA7aA5ucho/Pd0wFKxWO6wJ0OFlugwlcEvI3zHKL7a1/utFp+9UA0H7Ei0smzMOP3jocu6NfwOzWV34VNN7NOfP3xCMbIdv492RcYZXuRzYYNpUZn82+xVIhbj2y6FeyyxSfEpUEzg2/OBHTMREU226w==
X-MS-TrafficTypeDiagnostic: DM5PR0201MB3512:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3512;31:m+GVFACqJrapL5HOpRPocBLFk4ZbV5+J7il/XZiG+65XMR/Rtw3MZEM+SbgFRX484g5X5xpqQHIQIWEPye4HWKWN9hGB8Wq1J2Mgo27fBSMCLg/jns3IOQs29Ey1MyrBbEH84gv4FDRrYxY2gRrrWmlJyp2sGGGeNFY5bvW1IF6Xq//ZXgCV/D+EjKhIu+EJa17PSlyuKufhhGr9XJJ9jSU+/EG4CkcRVlEbPZOp/sM=;20:cL3VcjGdsjeFPiv/AalGXMQBhvGzW7f7pePV/oAYht9i2zTvTVGUMehKQUojvGmXd3c3IhRlaIVMwVWu669YzdEfaQbY0/VlNo4LEhZC2sDV3R4zXCCkPI5DnY+Okxf8xbrtvVsdmbf28ekzWC71QXKC5tMgecldR2biwrPxpkB9/MvWolJLcgep6v2waxW5E4XfsZCRZANWW9HjaScIBT/MGJqMzg4mUxuqmrRTlsv7xaMEAebxDDKT1thUAVR0WIfuhOOApMlZsNTKDgm5870gC8dS8swG4Fr9VYzApkYL6a50LxMhVVZkBXXJpmKwzYPYzV/ay7HAn6Em9uL7We7EQW/dEJHubnh4+j5zQYMlyNBU7ZI3gHPvV3SKBbSRlzeAOJosWvzQWVhhivYbGTWaHoTHP+JbVCGArx4d68zIG5DOBtPPIE4BZsKeaJ8U2xhohSCtyaZSMgh+OqQpD4WLzceDlvJW9A2LXUxQolDkem7TQC8p0I4DgEGMR0R6
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM5PR0201MB3512F241C094A9CBED8F2272B8230@DM5PR0201MB3512.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089)(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(10201501046)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DM5PR0201MB3512;BCL:0;PCL:0;RULEID:;SRVR:DM5PR0201MB3512;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3512;4:0l/Jv9e1lvDhvWIGk/ia9KFrX1twnlhZ76AohX/jm3f6Xh9XFgZ2S7wMJt+nvRd/Ib5wPCNU/Qzz3nbyWCEUi/8bw3uJWshcREy2YMtOZNnN36vgS671yuWxEg1ACQnNfVlyJ+Qe4NXX+rXbEwOGiTsWdEKW+DND2tEvmsPYppLg+BS1j+2PmKZr9UAM2Dknm9gMq45UsN2bW9Tg1ARkd0sE0josKC+LmsRUwjkLuMf34CIshUL7/IV+xRrAEXBXgOgIh/+CVFCCqu4HGnZZPT0itExttJGvC9kUvXoMtjJTX9PoLd+IvrotXSa8glKK5YnIZ2RHLtVc2cz+tFNr3w==
X-Forefront-PRVS: 0753EA505A
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR0201MB3512;23:omq/hhH3pNMVCBhAnCz9tF3e7JVKzbi18jEm/z8?=
 =?us-ascii?Q?jIlLu6OT02UXNvQtzoR9LV7LHHvsEOjGFylznycJXeBY1UI7JqCJhWyR/s5y?=
 =?us-ascii?Q?rVPPfHiNTEGq3El2JgFhnwy23zXyPabYWUQ6cQhu9bwc3rxGYpdF/PSbfIDL?=
 =?us-ascii?Q?gxb1yce/Kt4G1GWIhPo5ag/87tDYzJBQz5FllJEm3aqIB87riGEjWMxR+5Uq?=
 =?us-ascii?Q?2YXz8wBfb4R/6Ieu4JGmmB68MMYYUWkbLbcT8ntvMRaH/GJoJjvEnARtXiq+?=
 =?us-ascii?Q?rK07a9aXF9ef5oSfxDTJ6t1ivD1n65ELnPN4bfWhOOJGqX7pgy+/e5l4Gw7N?=
 =?us-ascii?Q?0P8MCe5zggv72MS9KIZ5qqjz8mdP63AvKboW4SKhn3M5Lt2dpvTxHW2sppZL?=
 =?us-ascii?Q?Q2+XuyR9Kf3BIviwcxgoxLYVSr1Yp4G6VTcqRsu7EPE5w33LTZyr1n3i+T/C?=
 =?us-ascii?Q?q8fmAW7GqLT/hB4M+UXq9ofiOgAu6oqZZuiyzk1yVdhQhCvuMK7qMt09KeTK?=
 =?us-ascii?Q?A3GE1PH7fjQKbTIP5bmL3VkNQf9WrN9zlGhT9M3PWNMTUx86LyBmbxKrQP/a?=
 =?us-ascii?Q?l6iabmClurKjdnCGSxGithQ31eoeW2Z8cLT3vtyKi8UF79FBm4lVfK8gF5U6?=
 =?us-ascii?Q?SBHb1xlNiHug7QUaGKQCd9Ue62xTf1Dq8NDXnra8mTf+BnwDiuF6Uw/thLWw?=
 =?us-ascii?Q?KkX8ZovB7r1IxdT46TlMMWtVFun5GEV+LKU3D3YWwWHNxzL/MyG4x5ZbPkEN?=
 =?us-ascii?Q?vj9NR63rFhdV+f9qD6LCY9al3HMwmdeJNvEDfBa8EF+YLUUZVgwUCr9JQf9U?=
 =?us-ascii?Q?utQ6fffEYKJeRjTlmuDczITziqjePpjjCVYoEpR0AlCeDiQjg/b5MdD0HAf1?=
 =?us-ascii?Q?exlS8NFey1LWSqyi08VhvupekVK6If6eqwMeW+NFdE3EiUqrN0mWtA1Mf7hB?=
 =?us-ascii?Q?69VY+TlX+QHhBqHQUKhIdVk3w1pJ2Q5LJw2lJPjD2eqKiyGO1nr41OYlsBsn?=
 =?us-ascii?Q?YTgA1lk0UImYLkJvaZF7taJp8YM01HuEqDXOcv0eGAm6KNmxCRNyzHPXTtW1?=
 =?us-ascii?Q?OC9DWEX/qM8rzXO8BKKXSz+YTRrlIHb6cSFliY02OCo2eFduIftx2Mctsu5+?=
 =?us-ascii?Q?O4mIFPJBCXriudnYQoQ05V/s8kJKVi6UYAD8/dWU0YstWIqNuHjh6WBlWfE7?=
 =?us-ascii?Q?zqgna0uzHpQyIY+FUta8PMmpmSBLr3jjG5dnzjNX2JhsNtsLj87qzswzKjmg?=
 =?us-ascii?Q?U1Av6wcI+yEtsgA2hKhI=3D?=
X-Microsoft-Antispam-Message-Info: he/DjG338vKuajrgDZYI7EwJ8Q6KUQQKX+oeKYnClkaH/ghslFgICr73cmv4e2msKjLmU2aa0Q2usW+CpWEvrUYJ91ccdmZK9V9tIg+gDGZPgY3+EH1D+23OK833ydfBm1VOQ9Cgo8HO5likY/fVqLCq+EwcfSsmb7butphGyDbhaONBoCdMwmsc1/cYZxLkuIwnEBaP4VcgN05mjuLgUUssiYcLQxUBjiXixr4pHTRsb05kCmzrmE5VlcoSWhLjKEE/W9+tR1dmBC9Qu1eRL+M6WdemvRntKLlpK1pxanDUV8ZkDNIckn5x473PJMS2KCaHxHwB/oyeIrN5CiBQYceYfpqeX/7p1rCWY+oYP8s=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3512;6:aVC82kKHgujRRXR+zVcGqq+dEeufOqubZ1w4mewPXJWhgsy+P1ZoC+GQQ3Wlmv4IMrzt7mKRXXYbzmXr0K9yt3V9yflqDkOGroQF1k7s3+fVrJS6cJrCwjIsljvI2UMxRbxTFlrRs8AJWzwLdeyZnVoGYwpOFJd9QAlSQlnzKAbzUFVczaqTE/NF8cTdoX8QoQLVy5pQmleovFy9MQnnUWwrHLw3WG6AA8jJm6nr19if8Vh0grKf4zpnezrIjVR+UlD0G4ERewRu4AFh0DukfQlyVxMVCLHvsTlEbCIupYws2Olywmt8/CtqDwsTP6HZ5QHx+DeE9d9H1/ZcBd4LOPMjsNPWnNS3k5Khf4ihGvN0MPqtz4ciOFWf9oNQR6fJdFQI2RJOhvECM1RHy7eC0TI72g4CtYP3NFZ1SfYoZrYqcC5WzP8ROgfi0rYD4Z8J35dnl0UiTRTEoOMbIabm/w==;5:jPCXQGaMLKfaV5O43CLVmcJPLLHrSzyZBmhT+foS+PxamKpNbxdMv2wDs64/CC+qxjSVv+pB0szK4NFEP+C7RWQgCOiXVN27ZQGstzLjUZaMdurrheZ1N3rv/pqpb4HbfGadkLXsi5YenEVYk38C4G3wIw/RhNj8cYbwSHulIXw=;7:FSqZFJEiFryyrWsIwcicTfWFBrVNmeEVQWc4TcIrYOTGfyyYlilGQI3hqVFSCyoMNN9WLjzP/ayDDZdetAQPqbb2DiHNAkFI+fm/5xu/lL5KiAVAY4N1EGCHwcDfh2nDcdX2BlZJ0HW6cyHbEKCeaEPwxm4p4lN6EFrDVIDcQLIanqJnMC79O+dPlAQlwQwpo8m6zq8fZuO3IppSFtaDd7E36BxkwQlFPz/mZbfwcjm2m4U2HROhb44cloqPMsKI
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2018 17:53:52.5062
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0045d393-b7d0-410b-a885-08d5f96a13aa
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0201MB3512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

As of all of child of ZynqMP firmware are platform
driver, there is no need of init call in firmware
driver. Earlier clock driver was init method so
firmware driver had to use init call to make sure
firmware init is done in early stage.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp.c | 63 ++++++++++++----------------------------
 1 file changed, 18 insertions(+), 45 deletions(-)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 7ccedf0..ce6c746 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -476,50 +476,17 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_get_eemi_ops);
 static int zynqmp_firmware_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-
-	return of_platform_populate(dev->of_node, NULL, NULL, dev);
-}
-
-static const struct of_device_id zynqmp_firmware_of_match[] = {
-	{.compatible = "xlnx,zynqmp-firmware"},
-	{},
-};
-MODULE_DEVICE_TABLE(of, zynqmp_firmware_of_match);
-
-static struct platform_driver zynqmp_firmware_driver = {
-	.driver = {
-		.name = "zynqmp_firmware",
-		.of_match_table = zynqmp_firmware_of_match,
-	},
-	.probe = zynqmp_firmware_probe,
-};
-module_platform_driver(zynqmp_firmware_driver);
-
-static int __init zynqmp_plat_init(void)
-{
-	int ret;
 	struct device_node *np;
+	int ret;
 
 	np = of_find_compatible_node(NULL, NULL, "xlnx,zynqmp");
 	if (!np)
 		return 0;
 	of_node_put(np);
 
-	/*
-	 * We're running on a ZynqMP machine,
-	 * the zynqmp-firmware node is mandatory.
-	 */
-	np = of_find_compatible_node(NULL, NULL, "xlnx,zynqmp-firmware");
-	if (!np) {
-		pr_warn("%s: zynqmp-firmware node not found\n", __func__);
-		return -ENXIO;
-	}
-
-	ret = get_set_conduit_method(np);
-	if (ret) {
-		of_node_put(np);
+	ret = get_set_conduit_method(dev->of_node);
+	if (ret)
 		return ret;
-	}
 
 	/* Check PM API version number */
 	zynqmp_pm_get_api_version(&pm_api_version);
@@ -547,16 +514,22 @@ static int __init zynqmp_plat_init(void)
 	pr_info("%s Trustzone version v%d.%d\n", __func__,
 		pm_tz_version >> 16, pm_tz_version & 0xFFFF);
 
-	of_node_put(np);
+	zynqmp_pm_api_debugfs_init();
 
-	return ret;
+	return of_platform_populate(dev->of_node, NULL, NULL, dev);
 }
-early_initcall(zynqmp_plat_init);
 
-static int zynqmp_firmware_init(void)
-{
-	zynqmp_pm_api_debugfs_init();
+static const struct of_device_id zynqmp_firmware_of_match[] = {
+	{.compatible = "xlnx,zynqmp-firmware"},
+	{},
+};
+MODULE_DEVICE_TABLE(of, zynqmp_firmware_of_match);
 
-	return 0;
-}
-device_initcall(zynqmp_firmware_init);
+static struct platform_driver zynqmp_firmware_driver = {
+	.driver = {
+		.name = "zynqmp_firmware",
+		.of_match_table = zynqmp_firmware_of_match,
+	},
+	.probe = zynqmp_firmware_probe,
+};
+module_platform_driver(zynqmp_firmware_driver);
-- 
2.7.4

