Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F41C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 18:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AF26217A2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 18:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="dq4snkg/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AF26217A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730070AbeHCUGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 16:06:39 -0400
Received: from mail-by2nam03on0062.outbound.protection.outlook.com ([104.47.42.62]:23648
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727356AbeHCUGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 16:06:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VE114//YUPYxbjun3uPhuQH8U38wde77z/JGyfmsCXc=;
 b=dq4snkg/uWEhhWRPXKPKRnkIcixnBBHL/oVun5zYPSScd7KwwifYQYPfhcb5F8QGbTRW3YANoVjYtFcZam+jmRITITCMN6nixJSuGD58PO++dabE+ZO5nUDkzlcP5imKo5LzoqYenyl5ZeG8e7gWVpgcKDlzEgbFZEwG7ygB330=
Received: from CY4PR02CA0004.namprd02.prod.outlook.com (2603:10b6:903:18::14)
 by MWHPR0201MB3514.namprd02.prod.outlook.com (2603:10b6:301:77::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.14; Fri, 3 Aug
 2018 17:53:54 +0000
Received: from CY1NAM02FT024.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::207) by CY4PR02CA0004.outlook.office365.com
 (2603:10b6:903:18::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1017.15 via Frontend
 Transport; Fri, 3 Aug 2018 17:53:54 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT024.mail.protection.outlook.com (10.152.74.210) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1038.3
 via Frontend Transport; Fri, 3 Aug 2018 17:53:53 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fleGu-0004fl-Qj; Fri, 03 Aug 2018 10:53:52 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fleGp-0007cn-N0; Fri, 03 Aug 2018 10:53:47 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1fleGl-0007bh-Gc; Fri, 03 Aug 2018 10:53:43 -0700
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
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v11 06/11] firmware: xilinx: Add debugfs interface
Date:   Fri, 3 Aug 2018 10:53:23 -0700
Message-ID: <1533318808-10781-7-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533318808-10781-1-git-send-email-jollys@xilinx.com>
References: <1533318808-10781-1-git-send-email-jollys@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(136003)(396003)(2980300002)(438002)(189003)(199004)(63266004)(72206003)(16586007)(14444005)(54906003)(110136005)(2201001)(36386004)(9786002)(478600001)(50226002)(4326008)(316002)(47776003)(7416002)(966005)(6666003)(39060400002)(107886003)(6306002)(106002)(2906002)(186003)(336012)(126002)(26005)(44832011)(106466001)(36756003)(51416003)(476003)(426003)(77096007)(76176011)(11346002)(7696005)(446003)(5660300001)(356003)(305945005)(2616005)(486006)(8676002)(48376002)(50466002)(8936002)(81156014)(81166006)(107986001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR0201MB3514;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT024;1:XJtp6mPeAEQzxSzqta74Rf02P94NT3NgcfhV+Ycor8oeXTmBrcMBNt3vLIuJw9viC1xla7+ljFaT82kV3FRpZm4WO8igxlIHKxyr/dbBx6sz5SFqITX4iUW9MbwzBzJG
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f1cf7f5-c927-43d7-edf8-08d5f96a1431
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:MWHPR0201MB3514;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3514;3:gWfRNCiVxx6krfkpYUQ4cnxzfyusc7U4ga1svGYbU6p696pzaZ1w5Uaxj3FieLruw17UnPwa/jwT2IHNz5rOSXNXgNMLzHBRtSMqPlX3Vn/WpUFkKOnTFiB5yAXfTfZNcET2O82CxdOsavOjI4kcvnlzClMvpJGUqQBXnlr0slClJyEbKg23qM+IypZJn6vQFt0orFmMeHWMeYF8zkh1HS3EXFg59u8QbhZwkvL4vwwfVtYAu5jcRienQ27qFRLrS7r+Mfu3A2Wzm1ACekZcJnAtFFICN/+jbN5lLRF4yXhZx7qru7v5eF5mrywSRogXrufB9/xQ3eR/P4aETYWdYFD2dN6K/BgKljvEEUs+pPo=;25:IkAkf+HiFbH4CNWRXZix02t8Pyr+ZRXgeOp7c0hj/pz0PlYENWYb0yxcWCik7aaZXWepn79QIU9K+qj8gUpB49dPpWws3Jp8hT+G+1rNJJUJMyyjLaVpwwxhFBvEgKsnNBIeNxlZbU0/QHGXorPPAZNWRPVFNPmOqgJwSE8Ye0j92tuEy8XRJtVA8irQ3arCYaVS1KxBTHSbMNWjDBMENVVZt6bz+nqLPXJjW1Q2dAKkxb0J+OmzuMIN5gfw3GsxbW+pyNKgG8meZrL9/ViAGGKDAyPkSjosMcRM0iIEV0IXvg9EmieBxFTJC6rtdMn3FJ8TdRQ6Y5me6Z2pKZrO0Q==
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3514:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3514;31:Ox2hgllmWiSeAw49wA7h47mGeYvw0MsA9g08QTq7pSS4iCNYwf+l66ELs2n3aYAQAfqNVCeP4AF768gpjgqJrdoDeSSbjKWcUClmLzKEzUZJ2hMZ62gr1GsVnXK5FKY7q2zMcAJ1vNKwQWH4n6COaaJ6kw/MhiXF1qCcmDB0XEh5P3XYy51lH9+N8JSz6xo+Q4xt78m5mu/9cKJKbidMMaeeJYFQQfPtQvJeub0u8Gs=;20:ejEtRfxhPUE4SJRt/Qz4uOHchvN2NgqzC9tzRCcjwfUUALDDL+s+oys/PfqCkt7/4DPWJSUv6JVB8N4k2jUV9ZJgK31zgLbQ8562iPQsd3ZfLlztXQcczhddk9kD8RhfY5zcyhY+IdlSWYadc9U/gOWhks+IKlewxR7ETyOkYQq955zCzGisVbBUsNBLpRilzDOq9tRRaS+iLzckxPbAgPd8QPT7kEt7nK/HFXVtXSr7dEaTYUkzPxnq0UNJjK0bzMUVwdfN91dtjYLwDxNEjiFsWaAHz7kuOshfa0vfmWcwPnkcivtW5K0l2r/b2mcL//ZJ40VFzM/sA0CdR993knaX9IGzA+b7NxJWa6m8g4TEvLBGbfhsX99KiHAg+LYts2UJlnNcwa0K4aIjpXB0Dhkooqh5/JSTWOMyaQe3jn5wdIKQOHxCCgqK4QA/CgTjkwxrFfiMEahPzFFTv9LlIA1VjcuTEkkYCrkXsW1ghsK4o6ASAg/sc7Phlr85KqvR
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <MWHPR0201MB3514F1A156385FD474D4E190B8230@MWHPR0201MB3514.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592)(189271028609987);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93004095)(3002001)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:MWHPR0201MB3514;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0201MB3514;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3514;4:iv2luY/31yBDz008ORw8GHI2Vz7FdH6vSANVDPIycHRkJvz6usFK7+oXF5VhMfI7DyHY5nhm/IrAEr0+7I37TuUrjkdBFUHrYEMr6dS+RE55S2KlSCWmgQa5DKI5eZ71PX7M1fCx4FdQ46TL5Du0HbtPLyghKkdSUQJRh9n7q7FdLKNKZKQNICp6HBhWRiZCtXWiLexZ8KbngRyEBZCHQYj67yYW8G+Cv2NZ+vi4gU1x3b8kV5CLs23ntu1nyzMTrR0jZ3Lnf7Eut9UOE3ic66OyqMzaSHXAQCBbZgxBBMyC0urnxd6bTL9YjllkrcHoFIwe6RZWRQssuaN4V9Qn2A==
X-Forefront-PRVS: 0753EA505A
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR0201MB3514;23:UT97DfX0QbKmM0nXFp8S2qrIykkIbib9Jknwhgm?=
 =?us-ascii?Q?D93UQ7kEWyeUDp4Q0fjoD5xLKs0vCTqpuxKyoBvtBB5puXRHbEgMR5Shyphy?=
 =?us-ascii?Q?kZpJS+BA72QVEsddyB98r7sxEPS3xMJP7i6esgKNmrca8Q+odNj0qREFJtoT?=
 =?us-ascii?Q?XunOSPZdlsrS7B5UoRVokNaKrnuRk7u/8kDZqFSA8TkvGXmUMCW+tFkpcvzj?=
 =?us-ascii?Q?CzQlYmyugfmcwecmfHX1+MtKq66uNTm3xtPTx+KGeS85uLwMYLBn3Kb0f210?=
 =?us-ascii?Q?HS0FscrvM+oJ4GerLTpjr48o5VULUxYYbqvr3zvLBEGVC2oPRh43fbWzL9zW?=
 =?us-ascii?Q?RIr3DJyU5aQXb3fEQJTSsEOr7NTYCIaxBEn+eofxDmyDRQJMNwzKFNCEYU/a?=
 =?us-ascii?Q?msIYB7Hx4DXFdbVO3TYJMLpqeD6BysQ23GwKHHjubAEkECeR+BUzYsMmIWHW?=
 =?us-ascii?Q?7Putdjhb7UFuYdB/2rSJf3hhhQR7Ml15Gtkey3pWLMxJute93ovcFbAN1dYM?=
 =?us-ascii?Q?3vrI4LIYZsOZkXMi7GtTxJWiBx0nOmmN+E0mkVts6GYm13aUZdn1cmxUcgBo?=
 =?us-ascii?Q?4wR+WwyE0Wvnh5DUEqCw58Ed+QtBFvL6V64RE/M/iGEX7c02oxeaARnNh81e?=
 =?us-ascii?Q?41fFh8dsAlXw7wibFDM8mHErBIFKCVr8oMyHobkadSld/dUkDHOoPVQOK3tI?=
 =?us-ascii?Q?RuumEHhVFE+YmShXZD30AyKjfqfr4TLzLURe41SnOuewqu39dhYQvqfw5xib?=
 =?us-ascii?Q?dGRRF/XsAtgCUrn3qyf98+1A83wjKhFqT1cHD5s6pzZ4MGPCojPumo1EvRr8?=
 =?us-ascii?Q?eu2nIYNqDoP6+bzqVFPBaki2s+Yv6XC4VyVjSku+42FH6o2HlOz+lgX6bPCt?=
 =?us-ascii?Q?OyXtAcU27O+79G0WHkm91AE+DCSTzb8v/ZvORCGwAjd90FUvS0tpScq2wShe?=
 =?us-ascii?Q?Mi7H+ITyIyGS/sLRgKAleJPxLytKqQP7N1oQLHNLoSq1A6TgAuRelehHvoBw?=
 =?us-ascii?Q?6aLNgZxtybsy/ZRIXqQOaCgkEsx6ykoyS4Jc/gKO2qsxJlFIPQEz/lgEynKw?=
 =?us-ascii?Q?jy8NU5KeDns7erET/yaA07S40qAbQFD6iNnQMAZ8R+wS3+pJ8YQb+kr+awJ6?=
 =?us-ascii?Q?GuQmuojsFYLNW1zjF9amsyvgIvq0GNsN8N2sQboH1YZGZDb3fTmuT3JCZA0F?=
 =?us-ascii?Q?6hcy+3W8/2+VSbiwvQjQXMVDMfsEhdPgj1A98SDCCD/8z/levNWxGkRFxEyM?=
 =?us-ascii?Q?gG7gdx319nyfiqZGqsO2fJD4p/5s8hRNAqt5HB7Q3/r0NJib/wY+pfGxLXSR?=
 =?us-ascii?Q?VkA=3D=3D?=
X-Microsoft-Antispam-Message-Info: NfW6uI57pDT5sdpv/+tcWrWD20sp/nypPYcBYRbbEwGIiQZ51MorUF9VWU/IEu7fmDzo4yEdmlEJB1DkMmBcZjIk5wsbkObXuTgVPqqSXpmQMbdH07WHhMfzlHFlDoEWxs4NCGHdQszNJn3tkd5mO+8D/t6f/hVFvve/S7FzwviscX6ErKXxwKufJXRyR06Vuh8wsb6DT7xOWK0M/jUZkPMoLcq/JfVUajjXYuq3JKE5KX1VK5gSKkQo0bp1zDUafztQB4bYoQPxKwdnJahB171w+AyzW4Cty8AGLGOjB/Wl1ePRcYGzs8kZFl5k4iFcilVwUvF1gBom7silLqzs6VZ6wTXV/SUYqkBZ/0Fjtnw=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3514;6:zgEz8LeKTh/l1XUu/5+jVJqOcQWWgI92BXjoMc7n74Xq9BSvewzVz/Ju4hwe7s7qs+LSyTSs2l0ss6e4/ukw9nfW0QWXS4ixV0sTrIOb3rLF/8/GC6A5my1hzi0Ql1Shlz98IW0iDmRIajp9GGXp4S+LTadHlBn87THRDUVfcFjLaP2BIx5+ilkmc+J1BWvPeB4+/TiW5NxO7m+9h0lebOfPEsuI1aRkpMiCimn9LFFmhAqkKaus4NqqIaxaKHyxH9DT48PX9ftSlEBu83kwORXMmc86vNav5W7agH5wcf4JWB7rhs6Ilb/QHJREGr1prfgZCbbIGymGgFqaYW7MxPEAcrvy7HNIR7p6p8OrJStPwa6gdJLmfewJ58uhECi6LHpe96UoFXe6xV0g1LminYtd1v0E8IWVg8C11U3+2aT2s/Lob3FutXllOavrUtwtmTVGUqTLNmk/IewxMAvefw==;5:kqpBuNN0jMQLX4JukacwSnruLLAHNyUPNzuibKBoJVDUV7lTHOgGcJQmdcbhnikuPg/3ojrLboGx4nZaUtN3Gy7/gHhSgEcDbWAuqBOnT9dzG/Ue/KGJgxMlKTrjVbeyD9+kzXk/O8KvKoiawPq0oFRDBzT3SY11PTuOpVj95tY=;7:3q5YG446HT0tyNhVkZLO4Ct0aMHkqUkQnwqbqlm1VJqI7Hy71127B4vYrFU5f7rJRqjCSO5xqAeq1dpYx8lLx4esJuqYqeUanY02mDAim5uPnwIAqfrzj7BcEwNcHrwQLVszFIVgdyhcNRdOTlltM5sYJlFJZFKcNs4ZKcK/y5J56JzIE8rXJ9cwnnB+q3oREMEh/kGqDE3fyJ0tK+mXn0W9AVhjxDvzRMaWzMlk29IzMHzSjinQV5OpfpRCxnJl
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2018 17:53:53.3302
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f1cf7f5-c927-43d7-edf8-08d5f96a1431
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3514
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajanv@xilinx.com>

Firmware-debug provides debugfs interface to all APIs.
Debugfs can be used to call firmware APIs with required
parameters.

Usage:
* Calling firmware API through debugfs:
  # echo "<api-name> <arg1> .. <argn>" > /sys/.../zynqmp-firmware/pm

* Read output of last called firmware API:
  # cat /sys/.../zynqmp-firmware/pm

Refer ug1200 for more information on these APIs:
  * https://www.xilinx.com/support/documentation/user_guides/ug1200-eemi-api.pdf

Add basic debugfs file to get API version.

Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 drivers/firmware/xilinx/Kconfig        |   7 ++
 drivers/firmware/xilinx/Makefile       |   1 +
 drivers/firmware/xilinx/zynqmp-debug.c | 212 +++++++++++++++++++++++++++++++++
 drivers/firmware/xilinx/zynqmp-debug.h |  22 ++++
 drivers/firmware/xilinx/zynqmp.c       |   9 ++
 5 files changed, 251 insertions(+)
 create mode 100644 drivers/firmware/xilinx/zynqmp-debug.c
 create mode 100644 drivers/firmware/xilinx/zynqmp-debug.h

diff --git a/drivers/firmware/xilinx/Kconfig b/drivers/firmware/xilinx/Kconfig
index 64d976e..8f44b9c 100644
--- a/drivers/firmware/xilinx/Kconfig
+++ b/drivers/firmware/xilinx/Kconfig
@@ -13,4 +13,11 @@ config ZYNQMP_FIRMWARE
 	  Say yes to enable ZynqMP firmware interface driver.
 	  If in doubt, say N.
 
+config ZYNQMP_FIRMWARE_DEBUG
+	bool "Enable Xilinx Zynq MPSoC firmware debug APIs"
+	depends on ZYNQMP_FIRMWARE && DEBUG_FS
+	help
+	  Say yes to enable ZynqMP firmware interface debug APIs.
+	  If in doubt, say N.
+
 endmenu
diff --git a/drivers/firmware/xilinx/Makefile b/drivers/firmware/xilinx/Makefile
index 29f7bf2..875a537 100644
--- a/drivers/firmware/xilinx/Makefile
+++ b/drivers/firmware/xilinx/Makefile
@@ -2,3 +2,4 @@
 # Makefile for Xilinx firmwares
 
 obj-$(CONFIG_ZYNQMP_FIRMWARE) += zynqmp.o
+obj-$(CONFIG_ZYNQMP_FIRMWARE_DEBUG) += zynqmp-debug.o
diff --git a/drivers/firmware/xilinx/zynqmp-debug.c b/drivers/firmware/xilinx/zynqmp-debug.c
new file mode 100644
index 0000000..fcbdd6e
--- /dev/null
+++ b/drivers/firmware/xilinx/zynqmp-debug.c
@@ -0,0 +1,212 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Zynq MPSoC Firmware layer for debugfs APIs
+ *
+ *  Copyright (C) 2014-2018 Xilinx, Inc.
+ *
+ *  Michal Simek <michal.simek@xilinx.com>
+ *  Davorin Mista <davorin.mista@aggios.com>
+ *  Jolly Shah <jollys@xilinx.com>
+ *  Rajan Vaja <rajanv@xilinx.com>
+ */
+
+#include <linux/compiler.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/debugfs.h>
+#include <linux/uaccess.h>
+
+#include <linux/firmware/xlnx-zynqmp.h>
+#include "zynqmp-debug.h"
+
+#define PM_API_NAME_LEN			50
+
+struct pm_api_info {
+	u32 api_id;
+	char api_name[PM_API_NAME_LEN];
+	char api_name_len;
+};
+
+static char debugfs_buf[PAGE_SIZE];
+
+#define PM_API(id)		 {id, #id, strlen(#id)}
+static struct pm_api_info pm_api_list[] = {
+	PM_API(PM_GET_API_VERSION),
+};
+
+/**
+ * zynqmp_pm_argument_value() - Extract argument value from a PM-API request
+ * @arg:	Entered PM-API argument in string format
+ *
+ * Return: Argument value in unsigned integer format on success
+ *	   0 otherwise
+ */
+static u64 zynqmp_pm_argument_value(char *arg)
+{
+	u64 value;
+
+	if (!arg)
+		return 0;
+
+	if (!kstrtou64(arg, 0, &value))
+		return value;
+
+	return 0;
+}
+
+/**
+ * get_pm_api_id() - Extract API-ID from a PM-API request
+ * @pm_api_req:		Entered PM-API argument in string format
+ * @pm_id:		API-ID
+ *
+ * Return: 0 on success else error code
+ */
+static int get_pm_api_id(char *pm_api_req, u32 *pm_id)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(pm_api_list) ; i++) {
+		if (!strncasecmp(pm_api_req, pm_api_list[i].api_name,
+				 pm_api_list[i].api_name_len)) {
+			*pm_id = pm_api_list[i].api_id;
+			break;
+		}
+	}
+
+	/* If no name was entered look for PM-API ID instead */
+	if (i == ARRAY_SIZE(pm_api_list) && kstrtouint(pm_api_req, 10, pm_id))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int process_api_request(u32 pm_id, u64 *pm_api_arg, u32 *pm_api_ret)
+{
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+	u32 pm_api_version;
+	int ret;
+
+	if (!eemi_ops)
+		return -ENXIO;
+
+	switch (pm_id) {
+	case PM_GET_API_VERSION:
+		ret = eemi_ops->get_api_version(&pm_api_version);
+		sprintf(debugfs_buf, "PM-API Version = %d.%d\n",
+			pm_api_version >> 16, pm_api_version & 0xffff);
+		break;
+	default:
+		sprintf(debugfs_buf, "Unsupported PM-API request\n");
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+/**
+ * zynqmp_pm_debugfs_api_write() - debugfs write function
+ * @file:	User file
+ * @ptr:	User entered PM-API string
+ * @len:	Length of the userspace buffer
+ * @off:	Offset within the file
+ *
+ * Used for triggering pm api functions by writing
+ * echo <pm_api_id>	> /sys/kernel/debug/zynqmp_pm/power or
+ * echo <pm_api_name>	> /sys/kernel/debug/zynqmp_pm/power
+ *
+ * Return: Number of bytes copied if PM-API request succeeds,
+ *	   the corresponding error code otherwise
+ */
+static ssize_t zynqmp_pm_debugfs_api_write(struct file *file,
+					   const char __user *ptr, size_t len,
+					   loff_t *off)
+{
+	char *kern_buff, *tmp_buff;
+	char *pm_api_req;
+	u32 pm_id = 0;
+	u64 pm_api_arg[4] = {0, 0, 0, 0};
+	/* Return values from PM APIs calls */
+	u32 pm_api_ret[4] = {0, 0, 0, 0};
+
+	int ret;
+	int i = 0;
+
+	strcpy(debugfs_buf, "");
+
+	if (*off != 0 || len == 0)
+		return -EINVAL;
+
+	kern_buff = kzalloc(len, GFP_KERNEL);
+	if (!kern_buff)
+		return -ENOMEM;
+
+	tmp_buff = kern_buff;
+
+	ret = strncpy_from_user(kern_buff, ptr, len);
+	if (ret < 0) {
+		ret = -EFAULT;
+		goto err;
+	}
+
+	/* Read the API name from a user request */
+	pm_api_req = strsep(&kern_buff, " ");
+
+	ret = get_pm_api_id(pm_api_req, &pm_id);
+	if (ret < 0)
+		goto err;
+
+	/* Read node_id and arguments from the PM-API request */
+	pm_api_req = strsep(&kern_buff, " ");
+	while ((i < ARRAY_SIZE(pm_api_arg)) && pm_api_req) {
+		pm_api_arg[i++] = zynqmp_pm_argument_value(pm_api_req);
+		pm_api_req = strsep(&kern_buff, " ");
+	}
+
+	ret = process_api_request(pm_id, pm_api_arg, pm_api_ret);
+
+err:
+	kfree(tmp_buff);
+	if (ret)
+		return ret;
+
+	return len;
+}
+
+/**
+ * zynqmp_pm_debugfs_api_read() - debugfs read function
+ * @file:	User file
+ * @ptr:	Requested pm_api_version string
+ * @len:	Length of the userspace buffer
+ * @off:	Offset within the file
+ *
+ * Return: Length of the version string on success
+ *	   else error code
+ */
+static ssize_t zynqmp_pm_debugfs_api_read(struct file *file, char __user *ptr,
+					  size_t len, loff_t *off)
+{
+	return simple_read_from_buffer(ptr, len, off, debugfs_buf,
+				       strlen(debugfs_buf));
+}
+
+/* Setup debugfs fops */
+static const struct file_operations fops_zynqmp_pm_dbgfs = {
+	.owner = THIS_MODULE,
+	.write = zynqmp_pm_debugfs_api_write,
+	.read = zynqmp_pm_debugfs_api_read,
+};
+
+/**
+ * zynqmp_pm_api_debugfs_init - Initialize debugfs interface
+ *
+ * Return:	None
+ */
+void zynqmp_pm_api_debugfs_init(void)
+{
+	struct dentry *root_dir;
+
+	/* Initialize debugfs interface */
+	root_dir = debugfs_create_dir("zynqmp-firmware", NULL);
+	debugfs_create_file("pm", 0660, root_dir, NULL,
+			    &fops_zynqmp_pm_dbgfs);
+}
diff --git a/drivers/firmware/xilinx/zynqmp-debug.h b/drivers/firmware/xilinx/zynqmp-debug.h
new file mode 100644
index 0000000..3303b37
--- /dev/null
+++ b/drivers/firmware/xilinx/zynqmp-debug.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Xilinx Zynq MPSoC Firmware layer
+ *
+ *  Copyright (C) 2014-2018 Xilinx
+ *
+ *  Michal Simek <michal.simek@xilinx.com>
+ *  Davorin Mista <davorin.mista@aggios.com>
+ *  Jolly Shah <jollys@xilinx.com>
+ *  Rajan Vaja <rajanv@xilinx.com>
+ */
+
+#ifndef __FIRMWARE_ZYNQMP_DEBUG_H__
+#define __FIRMWARE_ZYNQMP_DEBUG_H__
+
+#if IS_REACHABLE(CONFIG_ZYNQMP_FIRMWARE_DEBUG)
+void zynqmp_pm_api_debugfs_init(void);
+#else
+static inline void zynqmp_pm_api_debugfs_init(void) { }
+#endif
+
+#endif /* __FIRMWARE_ZYNQMP_DEBUG_H__ */
diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 41ed800..7ccedf0 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -21,6 +21,7 @@
 #include <linux/uaccess.h>
 
 #include <linux/firmware/xlnx-zynqmp.h>
+#include "zynqmp-debug.h"
 
 /**
  * zynqmp_pm_ret_code() - Convert PMU-FW error codes to Linux error codes
@@ -551,3 +552,11 @@ static int __init zynqmp_plat_init(void)
 	return ret;
 }
 early_initcall(zynqmp_plat_init);
+
+static int zynqmp_firmware_init(void)
+{
+	zynqmp_pm_api_debugfs_init();
+
+	return 0;
+}
+device_initcall(zynqmp_firmware_init);
-- 
2.7.4

