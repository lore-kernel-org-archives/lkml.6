Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1ADC46470
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81FA0217CE
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="prKqnkAk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81FA0217CE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbeHDL0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 07:26:14 -0400
Received: from mail-eopbgr690084.outbound.protection.outlook.com ([40.107.69.84]:13952
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726448AbeHDL0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 07:26:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bh5y8q99RpMlGNFdkZguc0ti0xJYgcPsjLj5JU18m1Y=;
 b=prKqnkAkJB6y08KkxRYig6B+7mKwdNdTEHzokS27pYcw/1kOx1AqQ8Pm/a22/SybnL+LMDHWhGYBulYYG7fhRmY7ORC3H3fk8VrUDGtPNCKi2NZMipzhYcDtcrh47n1oANR5pUPWqzdHKVoIVJE8ye7THE+6nIc9i+bN5o+z0FE=
Received: from SN6PR02CA0031.namprd02.prod.outlook.com (2603:10b6:805:a2::44)
 by SN4PR0201MB3520.namprd02.prod.outlook.com (2603:10b6:803:44::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.15; Sat, 4 Aug
 2018 09:26:05 +0000
Received: from CY1NAM02FT024.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::205) by SN6PR02CA0031.outlook.office365.com
 (2603:10b6:805:a2::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1017.15 via Frontend
 Transport; Sat, 4 Aug 2018 09:26:05 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT024.mail.protection.outlook.com (10.152.74.210) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1038.3
 via Frontend Transport; Sat, 4 Aug 2018 09:26:04 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:45586 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1flsp1-0000S8-JM; Sat, 04 Aug 2018 02:26:03 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1flsow-0002IL-Fv; Sat, 04 Aug 2018 02:25:58 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w749PnjR013725;
        Sat, 4 Aug 2018 02:25:49 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1flsom-0002Gy-Oz; Sat, 04 Aug 2018 02:25:49 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 0E3661214D0; Sat,  4 Aug 2018 14:55:48 +0530 (IST)
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
Subject: [PATCH v4 0/4] EDAC: Enhancements to Synopsys EDAC driver
Date:   Sat, 4 Aug 2018 14:55:31 +0530
Message-ID: <1533374735-16662-1-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(979002)(136003)(39850400004)(396003)(376002)(346002)(2980300002)(438002)(189003)(199004)(478600001)(336012)(4326008)(48376002)(51416003)(486006)(50226002)(2616005)(476003)(316002)(426003)(6266002)(44832011)(7416002)(8936002)(186003)(2201001)(5660300001)(26005)(42186006)(126002)(72206003)(2906002)(16586007)(90966002)(52956003)(110136005)(54906003)(103686004)(6666003)(356003)(8676002)(81166006)(36386004)(106002)(81156014)(305945005)(36756003)(50466002)(47776003)(107886003)(106466001)(63266004)(921003)(107986001)(1121003)(5001870100001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN4PR0201MB3520;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT024;1:LcP6rMmL/X8Sr6xnmmUuoOOFb/PsDq4DuzFg3GehgHBVFCNVbWNlZfRb9o6TmUlq0m8VfTSeRPd+rpz7I3qDI0gVb1mnr4bvZMPW0uV7xPYJm3hkSl/ZAsLbnacVRqJl
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ab1897a-54cd-4c85-5dd3-08d5f9ec4d58
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:SN4PR0201MB3520;
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0201MB3520;3:E9Z8cnQfDoEkOcuyVNDuRYqsB6AOg6krdfH5vpS3QkHGDl/iqjZD22kzrqDL4vRpLV73AVk7ED9OcH0VMw/M7vEStqsoXeEL8lAKi7QHYpo0swA851u769BBynDvrv82jqGa+UAqCzJthGxJtNa7lEc240PhgOBVKxDKsPFivI5WLMwwhg5fGGbEbMPxj1ckMKqcZDJ5shZYwQjIFDLOQbhRUD7GqPKU1xVykenuLiN/eP5aup8aFkl3kAXjYbn7tMMR3E0aNQWrwOtB2u5XQ4/00KfzAvxenV/wTR4ePKoyR45OXDu2r4OWUqkcxm+PGOgQjDjvPoBxE0fi4Tkp4HXm32hRyUOD5tCNUcrrjh0=;25:+dil6zavuHe+zEMUyEos999ME3KzmqH9D3SjibXYZ7ja48kspjYZ5+L627NLEZc0F6kHCZViAOvu31At6JH+d5/OzLdrNbtlFs5Tkyit1CRhhkKqF/q5JewkexMjK7RplsQK4ZE7gDZyNh1LYSnF0LAkPHolTEXX9bMVq2glokk4/aFKlMIb7JyZAOngJBw6LXtlyZIZBSwTn0Y1HacY1S2GexE31ivE52f9E0Mgem7NLi7sd5vUfR//XoKnW59qGWs28kGuBgDCDrNGb+QKkUfOnABDWgjFcu5ZWdDSMoG1F1SiJ6+sOhy477TKKtAI0s0atjTlEhuzB8vTehDKWg==
X-MS-TrafficTypeDiagnostic: SN4PR0201MB3520:
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0201MB3520;31:QJ6aFlSVb94xJ4IHX8lnW0RnHu+NWoQdjrSOcRwnmmmJczVAgHAaTcXxqSaNtBwPYuMpPCKbUaRFxApGPs+RUFR94oeuD8kw4cvopwvlwfhUI23RO5c5DmjwO++4rfQh3+GRdBK22O4bQGH+G8RRDamuSgvuL1S3mMjStYbtr1uGOFwyZVy/KATAIv8Jk49Avq3rxGBNsBDW0F9XwCuPFddTlZjNPwiRnx71Vxs2eb4=;20:+efPropIPIzDSFSritv1Rk/qg0g9xONC3jDqLjeqceG/KpqU5oRSIU2kIt7q3jkJaOFVRfyPNarzb+QoYq7VFKtv/icGsJAFihYwT+4NICANyZX0o2cVQ9dSlKXEk/4fMg6IGnv3mY2wm3uI+5LCYxg9YrTb4MNRrB+7LenukXo4aJ1Au0pSnv2M4NSUMXE2ilxuYOXMqTPmI4DeW+lshnVH5CzlCbQbdwwgGs09XwrpubZ3QVqre98JqqUink8Pc2PXBVb0cQMBK857OxAidb+bTPYSq0RFaw8+nFMmqVhLr71W4dex6tN3un9T7/v4pgucuZdAjHTVVZZL/Z5e7EawvAfCu7qh8I3BCxH0KdxxX3n9kgAkzMaYx+PnssvXTBTW2RnRbSl4lw8tDVR+7khypA28EIhM27HwB7Dik5SIk7vKmSjrGZ3HBFquD4gLAmX5WbPN1bnUjMkVOTCjuARfQBJ26NInUXDztvtJ7+Qw1aVtgkHmcEdXxSQ1SJ6o
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN4PR0201MB352036731D76DA1F3C192306C1220@SN4PR0201MB3520.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93004095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:SN4PR0201MB3520;BCL:0;PCL:0;RULEID:;SRVR:SN4PR0201MB3520;
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0201MB3520;4:SpOIbuXMXFg7SnViYc4wPXVawMA1ZVuHqHj94U14BpdnabcBviunYzxCxMdWwLc6afTXN4y6FTb/M63qXrY7+Fs7kOTGvyxjDZeeqfcF8kfqDlgUAKTmNcZEa78AzBHkY6GQkPhscVclhs9E68M3tsK/zqVGFyS8a/zYgrPxJ3WKe+eA3I8aet6vwzpyscvy82UYSj3wNtvVDWyabttiBmlua60guzzutJmk+cqu11btCVM3HsuTxyb4NMmlfSyoqB9v43+aFaKwqSJyPjj+DQ==
X-Forefront-PRVS: 0754F7E325
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN4PR0201MB3520;23:l7NLoP7NKdUS6Whj5MALMd7bc1y69Dz/+1JCy0N?=
 =?us-ascii?Q?opkPS0D1d57WBQyqxPesDfadawn5ySk0D7Hac5y/+3FAZn1yJ0i17ypF4X9Q?=
 =?us-ascii?Q?AbDFuYBFslAxp89mq7KswRzlzFD114nqUH++kWfbjoTS6kiPWmwlSJMSLSl0?=
 =?us-ascii?Q?MPGpf/7QQ3FBV6i9Zq2eHX4qN00vOoyWZd1hd/nlxU8vg9hfUdZzBhXGuMIR?=
 =?us-ascii?Q?mzLGuHKeKidAq5lgpmhGjqpLaAk/RqWnAOr7JngIcGJdY+lcgiKLt0+ZpEHJ?=
 =?us-ascii?Q?whPVfQIbA5W6NBf5NP7ufkx0KJGfzsm/uPExN7TyvIlvp4I0GqG/e+HT3s5K?=
 =?us-ascii?Q?LYTVWPoOoST65pI64NW/SjPZ/OB+nbytghIr6nZB/arLKJy5YlWHKFkc23Xz?=
 =?us-ascii?Q?jk7VpWTlGIiEBjn2ttwi8zxLLxfiRTRPTYZsZxkikGhHVSyZIxa++WtyWeDN?=
 =?us-ascii?Q?2dbrJEVitmrOx5AU3Fyu1JZpOy7Wd0Iin6tHJDA8N7MHcHojYeOI5ezWqC+e?=
 =?us-ascii?Q?C2iyqV1jiIlKF+YTkqfliwp37m4A0qVm7+HfcwLFRPcN8YNqmyH0J9fFwWV/?=
 =?us-ascii?Q?NLMRkWR4glF/vLHnPbZyAIUl/Y2Ni+HmPFS9GckSVX2hewpM/r5v/uuAjef9?=
 =?us-ascii?Q?Hz8EiwP6vLT3RkBYSUTYX8Kjzl/GpXi93HsRgnXn71TEBeT7pu/o3p6h18SO?=
 =?us-ascii?Q?fqnjv3aEfAzU6jC92X4hMcm7i0FHcGvrAhgUasMx+tGje0unMm1+Nf10Yq05?=
 =?us-ascii?Q?C3fViEDb+mhhoa/Nb/xAToO9/cEsr+LdwSmZljsM6rruacs2hnoimS3aLkWx?=
 =?us-ascii?Q?EDvWnCdliRPzzooy8cXVk9DKY15x7vWP+tbzQPmJNsNDMQhJdgVSJDRah6t3?=
 =?us-ascii?Q?SGMMcTW7xZCy+0poexQ/PGK2UW26viJGfN+yzGkssUSZNJb442euQHDP0UT7?=
 =?us-ascii?Q?EwvMZyqujAIPyjjxOK3RaeIJDpJ0NCRTQiKFjNuBFeDzYiQq3OaMMnILeMDa?=
 =?us-ascii?Q?D9N7hcuySlaFfMGtSdUvW7W+YhFG3crFrk5gni6xyraoSRZigmFSVFzm6Ve3?=
 =?us-ascii?Q?nZvGvq+Q4Wd6qVQpUZGEVJvssx5E45SKZwN81dQcjPDABVbKT/Oi1vpEMWVY?=
 =?us-ascii?Q?YBr/VP/9/7GWvsgf3rrGZ8PGvsQTEVJEuFISgt0WKqChVdCt9tvkWUjUPT/J?=
 =?us-ascii?Q?3xOTUIQ64nQlHjbPR+3wwYB9dADA6iMkBhiw7VfRZ1oAXKgcjL3vBbsl2BAi?=
 =?us-ascii?Q?Klt/vzy3X/QNp1vZSBWmyWIHHEtxPRrot2DC6ekoe75FbRul34k1iqsH6sAn?=
 =?us-ascii?Q?uCHFZfIE0L3s5Dy216sbuingmAuLj6CCc2I4PqsnDxlA2?=
X-Microsoft-Antispam-Message-Info: v8LlIjQwCiw8u7WfmABLj9BmFaUzSWnbLryEy/EfXo6Lpv+EYQmlD1bV3nwkV0dkbPvxJmQBkMgOnEudu4neKtjVrR1/I3aiEuVOgxsj66lX0AAqwvtsyKobrYlsFl4wfrL8mXSQ2qnjt4qanl5WB+RZeU+ZyD4QPOCiFSa2UuW6Bcv6e+3kqt3Qw2uyoK3HVEsCt4EeZpEkfbkriewfmidIGBUJCUnVlzVtkDeAQmp8Huk+j1AkIsOiZoK2cDwCFr9Q0m01I8QxAS6YU9uSGNKTF8NQzY9jYdG2vZGUBXd2152b/LDAYUw+FSoSyUdau1WKDqn+nFv+NfKjmusev/vQTGaVYchsWn7JZqNo8U0=
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0201MB3520;6:tle/38s5t8cjzN8yqX/UadJgo9AefWIo9rJW5scK8NqSp/9bTCuIlC8HFjGQxUD9UpFXJ1mWJ481Dtb0zgxHIMHNIGThd30bL9E8jxOcULTmv3YvLmt1sNS0g8QMBnWEHFoN6+/tONUkR5HJZQi57uj4DMqaLEqZ9zKr0udgCXbZ8LFkBK2TZ7B3YkBmUGKvMZ9cGh3yUx4tf0fZbUoCMaGa7AyVUPs72sIHr+80AL7XXHLelax5FtfGjCroNURjIWtsN4NoZooCtVTxpTUQ/W4JltFrv9jHHAHErL8adkkJ7waXYXv6MGIgQ7d3k1qWwusWPKqjBN5jeK5RycgnKXTMd8JdVfej/6tQONqooZSANoeg/Xi9pxzTTaQbPpGdWDYfBfJv2VMR93squZQHPPBGcXkUDODUIh28tFmC70/3GGRwyPXnpd51KlGYIIG53vymahW4d+rfP2R/jszuyQ==;5:9Vuc9oXCNo/1mdsXUuH8KrFbvbHWubiyFRmOgj+rONmJSoFCOuQ5Z9RR9q8hYghokFR+ZPpHyx+iKYOzXeWaT5ECXiVC1wAz2lctR2Mxk8k5XCIP7dB/Dt+sp+ErTwAI+7QXxBp+Me+hT0rVFZhLs06dM0ezuqAk66+XxRjDNk4=;7:Mw17OrIuqkDwyNCNRQKabp/aOYW2Zk/OXtd5r/djkUDzUxxvs/ObEpIOZ6jHyxbmj5MqLg8Co9zbSDESz7sATAFeZWok9Jjq3PRIfuj9Nh65NtJiUIpco4DYx7RE6Rfa4lN57NBEIi/4Lg4hXRMc6GeP8sWL8QNzlBPVwGjbzLkT48p8FyUhscF/ax23CkVxkpNZW12cizQh0JNjbLupWm18XuS+gMoJbnocOvYAdsU2ZY6BvqhyI9zAw3+xaBbn
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2018 09:26:04.1152
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ab1897a-54cd-4c85-5dd3-08d5f9ec4d58
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB3520
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

Changes in v4:
	- Updated the commit message in (1/4)
	- Renamed function pointer names removing 'synps_' in (1/4)
	- Shortened unnecessary long lines as per the review comment on (1/4)

Manish Narani (4):
  edac: synps: Add platform specific structures for ddrc controller
  dt: bindings: Document ZynqMP DDRC in Synopsys documentation
  edac: synopsys: Add EDAC ECC support for ZynqMP DDRC
  arm64: zynqmp: Add DDRC node

 .../bindings/memory-controllers/synopsys.txt       |  27 +-
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi             |   7 +
 drivers/edac/Kconfig                               |   2 +-
 drivers/edac/synopsys_edac.c                       | 945 ++++++++++++++++++++-
 4 files changed, 941 insertions(+), 40 deletions(-)

-- 
2.1.1

