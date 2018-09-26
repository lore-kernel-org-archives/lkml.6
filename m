Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D8CC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 18:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B16221537
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 18:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="PiPbHXyg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B16221537
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbeI0A1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 20:27:35 -0400
Received: from mail-eopbgr720055.outbound.protection.outlook.com ([40.107.72.55]:54656
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726395AbeI0A1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 20:27:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifTdhn7stSnkiOmi8dlEO6iSODQ0W9jNfR3IYrq8DJw=;
 b=PiPbHXygEz7bcaKzni68fkXRqM93HOaaCWhOUKqHKewu0MqMZSxNiHKcYTeXVYU06M0dsGv5WaJ+NYaXm2MbaxWNjY9du37EJBa9y7Af2RqRF9a4HQ6ocUUivDLS/OHsFUr/CuWb2pGmQcHUIQh0Vimz35noIgbOzxxD7NghVKk=
Received: from BN7PR02CA0001.namprd02.prod.outlook.com (2603:10b6:408:20::14)
 by BYAPR02MB4760.namprd02.prod.outlook.com (2603:10b6:a03:4e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1164.20; Wed, 26 Sep
 2018 18:13:21 +0000
Received: from SN1NAM02FT057.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::207) by BN7PR02CA0001.outlook.office365.com
 (2603:10b6:408:20::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1164.20 via Frontend
 Transport; Wed, 26 Sep 2018 18:13:21 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT057.mail.protection.outlook.com (10.152.73.105) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1185.13
 via Frontend Transport; Wed, 26 Sep 2018 18:13:20 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1g5EJM-0005K2-GB; Wed, 26 Sep 2018 11:13:20 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1g5EJH-0001bP-CB; Wed, 26 Sep 2018 11:13:15 -0700
Received: from xsj-pvapsmtp01 (smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8QIDDN3020570;
        Wed, 26 Sep 2018 11:13:13 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1g5EJF-0001aj-Hr; Wed, 26 Sep 2018 11:13:13 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <olof@lixom.net>, <mturquette@baylibre.com>,
        <sboyd@codeaurora.org>, <michal.simek@xilinx.com>,
        <arm@kernel.org>, <linux-clk@vger.kernel.org>
CC:     <rajanv@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v3 1/4] Documentation: xilinx: Add documentation for eemi APIs
Date:   Wed, 26 Sep 2018 11:12:58 -0700
Message-ID: <1537985581-32164-2-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537985581-32164-1-git-send-email-jollys@xilinx.com>
References: <1537985581-32164-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(396003)(136003)(2980300002)(438002)(199004)(189003)(966005)(34290500001)(478600001)(7696005)(44832011)(486006)(9786002)(51416003)(76176011)(50226002)(6306002)(4326008)(47776003)(36386004)(107886003)(72206003)(6666003)(2201001)(305945005)(356003)(48376002)(77096007)(2616005)(186003)(50466002)(8936002)(316002)(8676002)(26005)(5660300001)(126002)(476003)(16586007)(81166006)(81156014)(11346002)(426003)(106002)(106466001)(446003)(63266004)(110136005)(36756003)(54906003)(2906002)(336012)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4760;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT057;1:utuqbNxS+RYqqB41iUAolfJPaBozhhG7SQwz0YXVjE63DbCSEOnO0bo0einZRpaFvDIG5yeKcVbMYFAvphaLsmT/cTzgl82Pt1FLujREMAK+0gKOxWUMgupTtA8i+ldX
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: caebfe34-5049-41b0-d695-08d623dbbe05
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BYAPR02MB4760;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4760;3:btbBc9zq7W/d4/bjuh6pbCQc+L8z5FMdcoRF5ovZlZHZ2QWPfMw7SdR9HcVaVFGmTeFAEDaHSkpv0op1PNQ36R9msq+aBza5Dqg9BYhZRHCVw7oVuUMuAwBNeleHwmLBLmiyUadmkc+v5FC180zTA79LgChhDjeWufxlohtd9yo1+hK6njxB09KvIFoqrzzkkx0M8oeE0b1VTOQJXEPq8ToHmTeA+/vY49rprF+PXpk73PsgV0ZdqTtHKljlF8o7+n4hwtUTubKD/hEN0jPW9ywradN7I4hKwaM4OiBUupGLtXOtj3Pz26kK3OF7ViBwhp3aBoscwnIKtWM2z0XB533aNGvX8BHpr9zT1W9klJY=;25:udakhCofuNawlo6+k79hGBW3WMWDO+LZf+PZ7y97wufA6i0odDbsssx53prKRv2TSX7/IPOFxDwN1p496YkEIe1rnpSyk9waY/sf2hMgz4KJTl8R9Dh0rNKIZIgmP8UYYmXSzG/Z4+tg0UM/Lhj/RRlKy4teee3t315uB//d+TUv165ItmML49zLXw8NYJ7Yqf+EzYlREzmnIpRkWUqZzFurXqjyAp5BrpF65eFQe+hkHPR2Sdq3LhEiC55y1f4KSC66U3OcEI9IxC/HI2CJeAGL7wQrexBJVhMXEP9TwtfucnlZ9H2dG5A0sI4bLeR6Zkqj1OlELrzs4tz1KPHjdg==
X-MS-TrafficTypeDiagnostic: BYAPR02MB4760:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4760;31:+wu9lTXOdBz/IWm1jkgrRGDezFQwbg33w1s+sVU2Z0snzyx5wypYH1a7Rd4E/FH/UW0w4bt4LVjvpnrIJkXV8SiwA46seb4QOFzv/I2ZtQSG5DhELf19xYwg53NiXlo8JG31vjfcbjekJFl4RKF138s+2BB6aTFIDbiEuxPL3m+Fmkrnj8DTj8mcYgOzZwDubnv9pWfwwlsQIKZgbrAhfJ5vO7vZG0QwvKKr9MOkLRg=;20:f1Mr/EPJNXJCy6XMotEKNnD+WWLLm21VB0zSRPubpJ6dxHOtCoEUpIR0I6izSPjsvpbMnZSCnABdoHB5OKhxVlsDqK/bpttkrmlUNE0faxbnEP6rBJKek/lAvIgOy6/W2ASF7HEADUI8fWzamGvCclzBEqlZpsdXBfW+aoOJatvHqL0IY3bHjx76x9sF6SE9UxaD9yjaOx3Kv9wQWqGWCTPcthFi6HLH0RSpjZwl3WEB2DsjwF+4R8z/yjMuojdoUgnw5+bJ4kWsL08BELMD8jBFC9Yl8EswxwJ6V9Z1tEemhAtEiQJWqjhkerZPZDsrfhluwlvZ3DznNzez9Qyb7obnp/pr1gh9mbGeOMD+8HMipOLisBoEgffmXBPLBt8o2zA4ov9kpar8Pba01WHj8623TUT5j+prBozX+ZDVy9z6Xlw8lBam/VG+x3E4gbAjPudcPM/CFFXSXRU7Bohb9rtCow+vYThT24fbAxBWBHbwO3blpp/Dg4HO5AOsxsf2
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB47609C0C9C962877F5814171B8150@BYAPR02MB4760.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592)(189271028609987);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93004095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201708071742011)(7699051);SRVR:BYAPR02MB4760;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB4760;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4760;4:VNDD7jDQGtY6iav99X4NsUzIIOO4iV/PpTMDjx8ri4oxSPNlAYNhhXGRcLGxwk72LI30vKD8UCzH9YvTNyY8Lmwu9AW7yorfvLazc5NcViZnVJZHvfKKwdjWVJPw+ChCOBMuGDQNPZH/Qam7o95hscifOl10z2TtaQfUlmTd88zsG00FoMB8LcrusQAI9uWPL4qKblbQ4HfpGdLpbUA3zunf3qLWF6K/RxynFCFV1bF/08y5hvvBrWBAuvzHp1Ek/vKQYy40ZIpKrgN6V+2fNXHvnH1vQhde2Q60/RlXtHS2LhDjvplzknXkiZnkCUTe7APRZwE51E0nQGfweeRAilXFIfoJwVFF/qBOX2GUDsE=
X-Forefront-PRVS: 08076ABC99
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB4760;23:ITAHFiHl7FiHTRINKwj9lerwZ8p74gRzEqyIgKoNq?=
 =?us-ascii?Q?JzGNjcTBkCTjt1jtBz9sL21pw+4BW6haakh2picOTZPDf9o/u3PfPMmXSXBx?=
 =?us-ascii?Q?dQM6pkesTDgPrMcfX08AI3NXBVzvtQeoFQzM8+Owk+Ddji0lvnm3ahm0OUSj?=
 =?us-ascii?Q?a2FsW51EInxRtsb98u2yWcCChp5X7+fsMDAPVYHAh2Q5nwWA5BRnjXgIf7TA?=
 =?us-ascii?Q?iWeapdC4SbC2n4/KhAeYS3iAQ1KikWeaFAzMVNiT/IHLor0lbdogBiGhu6WZ?=
 =?us-ascii?Q?bNvqds7Xzceyoqa+xgC8pPHoviy04GPc+9nnIM8yDHrXjtkID4XsmrHpZOEX?=
 =?us-ascii?Q?nH6s95SP9D0w9o7g6AuW7JLS1J0aHh6V1rZuuSl187cdipzEkkjXGd+DO8qM?=
 =?us-ascii?Q?EJO44jCWAKpl7XqaNOmQpi/OkkqkgXTKlagG2ju4VV1ShhiVd6yTcV3JuyVg?=
 =?us-ascii?Q?FH+P5wqP01A6eoMffoviuGOEZcqacaxAql592hLfUJj+dZUYYng1J5DFbkXf?=
 =?us-ascii?Q?DvJzG6De31NKChYIDrL3l/GMlbhwnIvfwQQYE2cvQdKHokKHdiZFJBQ4GuHw?=
 =?us-ascii?Q?AB5hEhLRaeRPCrqwaZHE4LeSdXOKxTLvoO+flD/G5kwdNj8SQv8E6tbwNXBf?=
 =?us-ascii?Q?0sMB/BPnTb629xWmwe+x3DfoLR2USuLB2lljpvt4N3v68N/oDQ05d5MpBO55?=
 =?us-ascii?Q?lfTiG4xnK5ZzOSqcp9ufn8R4s5P+Wig/p/0WoHgESI5Vif4lY2GZce1GKdZ2?=
 =?us-ascii?Q?c2Wm7Mz0ZLBeVB8Pj1rzbRFNJlMFC3sykrK1ehBVMzfJklk1qgcdxGaf/Ki2?=
 =?us-ascii?Q?ShGncLQtVd7EeHFBs7Ug1Vtd7ZEOCjph9hZzqquEw2gHxbRifFrVHDStyj0q?=
 =?us-ascii?Q?3mGh4cF+nO1oVpQ/XSsgNT1k4M1Oi+S7xJrmkl4Kq+HqMlLNQOyXRw5jLZTO?=
 =?us-ascii?Q?9OVYVFy2cXXDVLKLgLCJmJxHec3O1UEqmErZGfzrqF1a3Ov/EyDokK9nSpIr?=
 =?us-ascii?Q?2fAZvDYQDP9hOCYSTz8ewzmu0JdyQ6vNDNaiHEIuVCFoLydbko5id/ntjfW5?=
 =?us-ascii?Q?iCmRciCgJu5exbvqzs71BlZgT+iYjyYS60+XmornOF1m1qs6fYnJ5LYNlZ7G?=
 =?us-ascii?Q?MGBgJ+gsalaqWlYBV47LzDU3uGPWL6eUF/oFWAZ0yQwSFi0O1z7bAfkxJToH?=
 =?us-ascii?Q?87ouYkajwgQiP1zzpwCal4wdykvG7vTRrDBSCohp1R3jeqZ+9R7tGSHwA=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: eZNS2Gb1bvCX5URfSdLNZ670kpmcuXazf7ej/hwzO/yfllAysO16OLiF+kQwZbKdoJIZ21ntz02TrH80tA88CGz7SHSZBrT2UFze0WideqL+tJwo9cczCxmmsCfBZKilrU6zV4BW2HdytudIg9qpx4dNAK1QpTeUTxemQ8xjVJrjGsgQ6G3QkV3CW8UoTasLTY9oqXbyZO7Ly7+NxC5J4K0n0QCEWkxHAMxStww4jWb7VWCE3ouITlAaZsylp1ebZrs1UYo1bgp+TbmAEnOkz6zAACItkQQI7eI9NYET9tzFqAnh/2Vg6nF41979LVrwYgJ8DaIc6OgN7oj7qrahFErncVen4My/hsKfWPeCYVk=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4760;6:i5WCLJ+3GSvPMw/ZBvGa2bqHQzIGTQkWsymFDE7XjMN/wpJJlLfKOC/rNeq6fZo0D/WahY4aFELUt3fRutSE98gUgU+tYKnYXdnoIDfH5Ot2LwaLyRyh+Y0Uooazb45MHG5U0vwkZQqKoQoX5oy80NLCmI8CR+wjck/QdWol7Q8Kq5ALhwF6NnuKdxZdzYU/d2AcK5IMaOFU1EHbC5PQ57EtxxPX716Xi0+vSHmyQZR787YXZTFKH8ZK9OMaV9dQVI7aEhssr4WUlNzCiBDDnuv5rZBmHdanzzptV7bIxh3yGc1mj3oeOWlDtuFM23ZrOMfiK/tkI3UbboupTj8/HGvZHiN/lue8TLYd8kt+IXdINlvbh//hjbs1RCucAsGZhnAFJuUa7ojioJDmuyYHevYbtz1aU8MfR0y1UXMlVc2gJfy3s8nIUHWxyvU8VRTed6VGyXMsFKeKVYN7Rmll7A==;5:nJvvB/aa5DWMoqcbr0oV4kIZyBKAXew4rWGee57IkANHe+8D7J7h6zh9Oief3gbsJKflnnFl8bM+cHJHiSI/Ty27nUKCXSsyWu4KmWFFUNkBO+yAKSSo6LM0CTSmOkjInqaEe9jdXhQGC+zQUKUM03s1iVOJDjRGBqZDWZWHO+o=;7:0UwRnJtwDsjKtOfM4R7L/mU2GTWAH6Lc9sh/eF4OoakMMKM0meYApFX76KbUry0dX+Msz0yZQ0g8VoH9iAJy9yx6wu1cDwdYmalUI3ICIf0gjNq2ou0s8/2DzfaDZJ8StemlawJf4yXrWXTa7omkZ5o+VhlFthBQvPC8c0gpVu5WX6d4JhbS7Ph8ElsLpCDj1mDVaU25O3SOHTlad0sT/OSv5sE9oSmohvvXZY9pQdjHI3StWMvhkk+cF0r8OTBD
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2018 18:13:20.8773
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: caebfe34-5049-41b0-d695-08d623dbbe05
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4760
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Add documentation for embedded energy management interface (EEMI)
APIs. It includes information about eemi ops and how to use them.
It also includes API information and supported IOCTL IDs which can
be used for device and control configuration.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 Documentation/xilinx/eemi.txt | 67 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 Documentation/xilinx/eemi.txt

diff --git a/Documentation/xilinx/eemi.txt b/Documentation/xilinx/eemi.txt
new file mode 100644
index 0000000..0ab686c
--- /dev/null
+++ b/Documentation/xilinx/eemi.txt
@@ -0,0 +1,67 @@
+---------------------------------------------------------------------
+Xilinx Zynq MPSoC EEMI Documentation
+---------------------------------------------------------------------
+
+Xilinx Zynq MPSoC Firmware Interface
+-------------------------------------
+The zynqmp-firmware node describes the interface to platform firmware.
+ZynqMP has an interface to communicate with secure firmware. Firmware
+driver provides an interface to firmware APIs. Interface APIs can be
+used by any driver to communicate with PMC(Platform Management Controller).
+
+Embedded Energy Management Interface (EEMI)
+----------------------------------------------
+The embedded energy management interface is used to allow software
+components running across different processing clusters on a chip or
+device to communicate with a power management controller (PMC) on a
+device to issue or respond to power management requests.
+
+EEMI ops is a structure containing all eemi APIs supported by Zynq MPSoC.
+The zynqmp-firmware driver maintain all EEMI APIs in zynqmp_eemi_ops
+structure. Any driver who want to communicate with PMC using EEMI APIs
+can call zynqmp_pm_get_eemi_ops().
+
+Example of EEMI ops:
+
+	/* zynqmp-firmware driver maintain all EEMI APIs */
+	struct zynqmp_eemi_ops {
+		int (*get_api_version)(u32 *version);
+		int (*query_data)(struct zynqmp_pm_query_data qdata, u32 *out);
+	};
+
+	static const struct zynqmp_eemi_ops eemi_ops = {
+		.get_api_version = zynqmp_pm_get_api_version,
+		.query_data = zynqmp_pm_query_data,
+	};
+
+Example of EEMI ops usage:
+
+	static const struct zynqmp_eemi_ops *eemi_ops;
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	eemi_ops = zynqmp_pm_get_eemi_ops();
+	if (!eemi_ops)
+		return -ENXIO;
+
+	ret = eemi_ops->query_data(qdata, ret_payload);
+
+IOCTL
+------
+IOCTL API is for device control and configuration. It is not a system
+IOCTL but it is an EEMI API. This API can be used by master to control
+any device specific configuration. IOCTL definitions can be platform
+specific. This API also manage shared device configuration.
+
+The following IOCTL IDs are valid for device control:
+- IOCTL_SET_PLL_FRAC_MODE	8
+- IOCTL_GET_PLL_FRAC_MODE	9
+- IOCTL_SET_PLL_FRAC_DATA	10
+- IOCTL_GET_PLL_FRAC_DATA	11
+
+Refer EEMI API guide [0] for IOCTL specific parameters and other EEMI APIs.
+
+References
+----------
+[0] Embedded Energy Management Interface (EEMI) API guide:
+    https://www.xilinx.com/support/documentation/user_guides/ug1200-eemi-api.pdf
-- 
2.7.4

