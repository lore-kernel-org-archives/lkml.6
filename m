Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D03DAECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 775A42098A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:25:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="DkDcXWTp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 775A42098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbeIQTxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 15:53:19 -0400
Received: from mail-by2nam01on0082.outbound.protection.outlook.com ([104.47.34.82]:53120
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728065AbeIQTxS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 15:53:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LPlgHWwxxGeMmES3iC9R2B0x0FGDcuWpvXvIdyeQU0I=;
 b=DkDcXWTpNc/f+y4jSXjL3kc6Ku8bwGGNG/DHtRp7qSpzvZIm+di6IH3OB/0ByuUJtXw8Pb/PJZTynRb3wkOt87uOEuYznnhzQvzLIy6hRRmupSigfGX2/e6Jdu8CsP0XYXnWsROYghomF4pb2+wLu9YsRRwh/77YmMi7f1N7Se4=
Received: from SN6PR02CA0030.namprd02.prod.outlook.com (2603:10b6:805:a2::43)
 by BYAPR02MB5109.namprd02.prod.outlook.com (2603:10b6:a03:70::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.15; Mon, 17 Sep
 2018 14:25:42 +0000
Received: from CY1NAM02FT039.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::207) by SN6PR02CA0030.outlook.office365.com
 (2603:10b6:805:a2::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1143.15 via Frontend
 Transport; Mon, 17 Sep 2018 14:25:41 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT039.mail.protection.outlook.com (10.152.75.140) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1164.13
 via Frontend Transport; Mon, 17 Sep 2018 14:25:40 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1g1uT6-00056S-5r; Mon, 17 Sep 2018 07:25:40 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1g1uT1-0005Mt-2W; Mon, 17 Sep 2018 07:25:35 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8HEPOVC003529;
        Mon, 17 Sep 2018 07:25:24 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1g1uSp-0005LN-VC; Mon, 17 Sep 2018 07:25:24 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 23BC51214B4; Mon, 17 Sep 2018 19:55:23 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>, <bp@alien8.de>,
        <mchehab@kernel.org>, <michal.simek@xilinx.com>,
        <manish.narani@xilinx.com>, <leoyang.li@nxp.com>,
        <sudeep.holla@arm.com>, <amit.kucheria@linaro.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-edac@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v7 3/7] dt: bindings: Document ZynqMP DDRC in Synopsys documentation
Date:   Mon, 17 Sep 2018 19:55:01 +0530
Message-ID: <1537194305-9243-4-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1537194305-9243-1-git-send-email-manish.narani@xilinx.com>
References: <1537194305-9243-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(979002)(346002)(376002)(396003)(39850400004)(136003)(2980300002)(438002)(199004)(189003)(90966002)(81156014)(7416002)(106466001)(48376002)(54906003)(76176011)(51416003)(50466002)(106002)(316002)(50226002)(110136005)(42186006)(63266004)(8936002)(16586007)(5660300001)(478600001)(6666003)(72206003)(81166006)(336012)(356003)(47776003)(103686004)(486006)(2616005)(44832011)(36386004)(426003)(14444005)(11346002)(26005)(446003)(52956003)(4326008)(36756003)(476003)(8676002)(186003)(2906002)(2201001)(126002)(6266002)(305945005)(107986001)(2101003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB5109;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT039;1:ofnh19/48ArLhcY4DRVmyZ4oV/gXATk0kROM5b24g0ljYIX/ZciqDjOf8wz0zT6IuY6/1oodBjH+vgobHOcUfEkC4n45fg3FxlH89MAU0If5kuiMzFRBoT6cMEupym8m
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1973761-a8db-438e-1b99-08d61ca97262
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BYAPR02MB5109;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB5109;3:3p9YOH7/PJBUI3qVKBkM+zrK41WDmwJjdMOM0oz8dsf439UHxpd4AhuHEHVWmfkerx3Ft1MKVA5apGBc0vhvHpCWGpGFPE2EMNRAXi7OEKBjJD6DxROMgWIw8rZgQIj7bHXPayFZjoc+emQYCYWPqVRx6voTiaJRmzHnslOntz4GdMBHAlAtAPpvgYJPXlH76jQyd8gMZHYDPfS8x/B/A4MgVwb0TbSsJczqtN42iHbiuGVPQsy+5TMnUsxcwcjK/l/AUtJ9exzbYqs03yqKIda/9bCRAHIy80sSIaxFG2+to3nVTZXTVyxBWIwB0pF5fn45SL2XcpsmffPhBQYE0hd6DuvzjEyEv4aOezKi9e0=;25:tpSlWO8mN6ib6BBtcmH9hk/exhf3rYLEVmEzLk8RdkolICRCQPMZBwOOxyfKS3P++oBEnF/I1+lYUJb94kAAhrSwb4FPOvuliEAdmm6ZZetKBgpE+BIYtSh4sRlh0c+PGXkZobhzYqSMWc51bzBg5t9VAp3YqucA1660MaUYxkR7DQgbrbXsOMYcM2G/yUoPpP4ZSKWOx5zR0lDDR6L3oBCnWVmpPyaSjL53YA5FIkTygeyQiuNjJWmZwKVFQ+yNJVeFuBbwPM8luqVEoV8UNNWm1/ncU32M/nNpstRCnplodksdCsewzLpPte+90CO3Gq1xzyYhN1BRedyLf3ylQA==
X-MS-TrafficTypeDiagnostic: BYAPR02MB5109:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB5109;31:ozC17uV4dWy8LcAWXIR6tY4FHQsNNBb7aR6a2rf6GsYdjEv5CMi6yav+jGI8p5qezxbuVh5y8xaSyzG/1VBREPrIYVxUun/7KDjGUK/XsoxlPU30ggTt0o1ARHtVVdYZGfmaJQKNJldLSuPxguLbxgPcjH6OsQFU2Du9hSN84kFDtvMgefN+poug99nNbjV/zrSmiRBDlp1UUptvCzlcCGmBl5t4D+jPNekrJ6irjd8=;20:zm24XLLt1SuhM/corsKk6qJKQSJLuCDkd+yHH5nqfU9mNpR/Rx0LGsIjQb7a6waGq24oh61utR0DR7Nw77hfAQoE2mroE+iPZgE8ic2op43jVItx6O+ntqZ1fzLaQvwNrynw6zbZZFW13U7lw6b6gnqx7BOjE+6k/FdFWnZNkmK7SmY7rw7JIbGTzhAPXXFYlLJy3NO4VIlxWn1Xc7yr4HvsxHmHoa/i2WKryRz6bgdMsk21lB6hGlf0rnezZ0KF9/EV/eX9BpDSK663gscVhZkLU0Y6xTQwLXz2OPeZUIz9CrXiutqVmaMB3+CNIvc5pzuGNqkc7SUvteocdfsGFTWAFnbLFedVageWWdx2ifMXVfR/KOrkUhtA8lWFGi/nyVlAyGR0l3iSD+5CeYiswMQ95pGXTz2jPMVpfCKGaKIimt6Mqt/hEFU6vgER1AL9aoLp/Hv39+dnwI0+IvV41cH53hCwhMvlDb86Q50mks+K0WALUmZyRIXZfT8Jgiwj
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB51092249EB5102A18DC9154CC11E0@BYAPR02MB5109.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(20558992708506)(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699050);SRVR:BYAPR02MB5109;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB5109;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB5109;4:8/ffKC0FsOdsDCnuMS01dMCIFWVK0l8W6//NwjQINSSP1m9n317tLcrtE4Srj+t6WeaXRrK79oka3Gcp1hQuWeyVCvv9KEy5H536rxKjdCcOxQrkfLYBwgBXJaZWAd116an7+qOcG+yWR7mc5qVwZkmjHyHt3S3HUTTARj621BrpRM46B1Ww1mYnWaCptplZwf72Tc6jbFTh+oRzZxs2pAnsCZQ6EupcFhIUamVlkqfbiuJQfBFV3ScpoEd8gA5Sm35+aRNmVYyIbJuhFw5o+gcuCxqA26IDTimrmZxT9gcYqiwRW9zqrBuVG6Kvtz3nxXyK8PJMSRVERYlz0RfDKBYBnIuKBldY48/nZ3q5db4=
X-Forefront-PRVS: 0798146F16
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB5109;23:PoCqqEpWVTAB7Cblcioj79XXMMda6l6qBKVkdIqXz?=
 =?us-ascii?Q?RtpPX65PsKBw7nCRyg3kqV93IQXbcgROq50r+fglWRZYe3l2/F3KBH1hZ9TI?=
 =?us-ascii?Q?zFxzoexwXT4SnqFjtTqteXFLvuoTd3a4ycJzo8Uzp/0L3E0KnljlhOXiKg0D?=
 =?us-ascii?Q?jOf2FrKFokiT4/YptPGcYtuzK0TXAG7CbOahZj6cMmbQxDjzVi81wSu6b6wj?=
 =?us-ascii?Q?2MQCoh5yGieYC0wEfRo4Cik/kDDf2MOSX0ytI8AtZJNjzXcZvIDeXfgBZdiN?=
 =?us-ascii?Q?k3KHMw+VuM1hemRl686SzV7fA1kaNnFw+OBBTijuZ0J6/0zouNYRhqJu+Xl1?=
 =?us-ascii?Q?xetOd+WCxKLx7jocv7/dgaEfpdGjmunmt5SY7qB0U/3WgoyqevjbwYO8HbWQ?=
 =?us-ascii?Q?oqbgCrFV5Etx6YXXvDAOSPz8X/nyKNR4fn5Fx5L+0PZJ8qpoOkMlGLUm6krz?=
 =?us-ascii?Q?eOefFJyn38ZduslV9BqCcJqtA074V0XvZK24TUeYpIwcxI00anEEQIFNM2Gd?=
 =?us-ascii?Q?dxGYnwVnwL9AB8fFIxK6i8MBw3zWyJYhVfvFyHVlUgNo5p1euBIY8JjTCta6?=
 =?us-ascii?Q?fnyCxCL6E0koWBjgNOm+ojL6CL25jXTsZ878OOIXdfYcVqGGLcrYNj6XNVKX?=
 =?us-ascii?Q?ZQ0+6N9uEpXzyPD3zqqyGg7lOP4yGRhjas5mQ/mvofNOJxvI7LZc8QwNCOVV?=
 =?us-ascii?Q?hwWnQm0rhWFIDvoLUSu0CCiB+8gwFcdvYdlIVTsNrz6NF2vjeuQLwcyyRdFq?=
 =?us-ascii?Q?PTAEo0qWzabxF/lB13DhKLnGcIf7MOwxpD3xm6br+dAbLydRC82aowiwDktz?=
 =?us-ascii?Q?4CB/SzENYn+n66yoBbTsEoF3M/tmK1pqFJDBNwWplHk89J3BnKbd+8bdcddS?=
 =?us-ascii?Q?u2MfWVGC520EGgRzVbPGSbZGcdfLbUPMCU0y2Lgxv4JNBywvF1pmz8vuHWOT?=
 =?us-ascii?Q?hx4ij5xJp0WDNDq6zJ/G5WdFQAbo+XAaJBWJqmmmMndmIa5L4iKg+4k6DJmb?=
 =?us-ascii?Q?ACERdG0BP14/sH04d/hGBMrpdMwH2VHbtkESkBAyt06GHgRSywrAx16TkpZr?=
 =?us-ascii?Q?7LXlxX39QLdisFE0nbQ035szM6Zu278yDhcf1xpldYPzW6EUjkF2NB1KuM/Q?=
 =?us-ascii?Q?cEbLeVfZUQ52MIHzlXRo169ac3Y/jGoYyXm5UzbKGO54ML7K1lkDjxixHFTh?=
 =?us-ascii?Q?GWuJjajfIC2gk5mGWqSsY9pOxKGGWUal06Iza3p09x5yXCmowx8d/XTqrclQ?=
 =?us-ascii?Q?lez9IcGXprR2xZgpPc9Ui3dFrJO/fUuyVTZviniDouglxpULW027XZDSa5zr?=
 =?us-ascii?Q?5//WVBzBBGe36vGS1qJY2hWnpahR+aFHDBe/c21NPEy?=
X-Microsoft-Antispam-Message-Info: k7tkyAht1hNFfAmisWu5r+D4q6S+wVO64hLtc/1WVnMs7CKiAy6LMjsDXPjXFsCHTXgBFffnm0sTSiVQZcc5KbAaVDPZ7Y/M7Wdc/wj2SFEJOz9UYD3hYNls+BNw49kquHpNvVMB05OwIjbp/YoJrEzYPK1HoqsMOrtKrkc4Bcbp93/E2yjUWUTYHKL4UuR9A9pekYFtOYwLpodLoRAJzMEeH8rehgFY0zVvGpTqKpLAULHDmqf1p8zjNJabsezNllqj5/AMCACWHcDZiRwlBXdELsWn80ojr5tLLWrvJK55zOPj30G1f3dHqLU/WiVxTRx+fX5ERhhuFC+HdplSdcCzDeI4+EsLe9HAQJBW+lo=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB5109;6:eTBEYsc9KROX8+dCIY9w2XkGTGHJ8ERjjxDw+7iWT2cWkhSgZ8FUuCRoI39rFm2HdbacamiqNfDB936UTQK89NpK+AbxS6lWlSYCKlRlWFdYW3vygajPno6/tYASCRr52ylcKGV1QF5nruVBnYCVGnc0gIBv6N9fBDXhkRXcc8WEzfRF8lln2iKCFrIR6nrVtJehObB9+UpCjQ2CdHCt9OzxQHD7VsQQFxpSC1D1gyN6VxG6aJU9V3Wkj+a+Y5Ku1XEm0QUZeRgg0g1SwDtKpK+Doli0/e7st4MRvFA6wopYz2Zx/s7Kl6JD3mHqL7L7AlenIxzeM1nl3wcvxP1S/4bcYPuWDvrImbb8QZs5y5MSBevWSkMeAVcbfjwXhX3DTdJsExbOGb76Z6hXitpAVkuSM/9tsZ7bukTB7w3vTQ7PDyHf2eX+KhjjNdyFbQfDmPU78UfPwnVL0XLqgFkjFQ==;5:zpd7wf30GSygwe5BYZdtM9C19hgJm/1lWWLeAi+geyhAm8AX4JRuhmlZigAa54VvR0RlXZsy7avE4YhScDORPGnQXoHd3O1Gr5M8683Cer+zXo8TRGiKopb/ZZlsunuDyKPhRr+QFjAraVeWCMVI4fa/sVIRLwYqi4B05MmfAvc=;7:3zDRluceSI1CllXBENNvkcNHsQFPo9KW+wGbnyyEwBCSMW9eqSmEmKtHDIEw6GwpfCv1EkrPXrpklbTDUQg+fWmFHUYOihJmh0CzbvSuOGYK6KlflRTGWGTM4xWgdHAQpRrKC/RcbXeE86F7Va+M1uZEyTE8ssw3KAuX4ZN/S0BLVEYWeJ6o0PRTpOppW0EI93cxU0PGITeLXGVoY1r/fk+ZuSJX/Zt0nEyZZDpZ2UuEqYDkYHu67qGnHnObR3pg
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2018 14:25:40.6711
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1973761-a8db-438e-1b99-08d61ca97262
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add information of ZynqMP DDRC which reports the single bit errors that
are corrected and the double bit errors that are detected.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/memory-controllers/synopsys.txt       | 27 ++++++++++++++++++----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/synopsys.txt b/Documentation/devicetree/bindings/memory-controllers/synopsys.txt
index a43d26d..9d32762 100644
--- a/Documentation/devicetree/bindings/memory-controllers/synopsys.txt
+++ b/Documentation/devicetree/bindings/memory-controllers/synopsys.txt
@@ -1,15 +1,32 @@
 Binding for Synopsys IntelliDDR Multi Protocol Memory Controller
 
-This controller has an optional ECC support in half-bus width (16-bit)
-configuration. The ECC controller corrects one bit error and detects
-two bit errors.
+The ZynqMP DDR ECC controller has an optional ECC support in 64-bit and 32-bit
+bus width configurations.
+
+The Zynq DDR ECC controller has an optional ECC support in half-bus width
+(16-bit) configuration.
+
+These both ECC controllers correct single bit ECC errors and detect double bit
+ECC errors.
 
 Required properties:
- - compatible: Should be 'xlnx,zynq-ddrc-a05'
- - reg: Base address and size of the controllers memory area
+ - compatible: One of:
+	- 'xlnx,zynq-ddrc-a05' : Zynq DDR ECC controller
+	- 'xlnx,zynqmp-ddrc-2.40a' : ZynqMP DDR ECC controller
+ - reg: Should contain DDR controller registers location and length.
+
+Required properties for "xlnx,zynqmp-ddrc-2.40a":
+ - interrupts: Property with a value describing the interrupt number.
 
 Example:
 	memory-controller@f8006000 {
 		compatible = "xlnx,zynq-ddrc-a05";
 		reg = <0xf8006000 0x1000>;
 	};
+
+	mc: memory-controller@fd070000 {
+		compatible = "xlnx,zynqmp-ddrc-2.40a";
+		reg = <0x0 0xfd070000 0x0 0x30000>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 112 4>;
+	};
-- 
2.1.1

