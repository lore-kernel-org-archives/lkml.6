Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5903C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D61C20693
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="I5UuCUKF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D61C20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965430AbeFSF4Z (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 01:56:25 -0400
Received: from mail-sn1nam01on0088.outbound.protection.outlook.com ([104.47.32.88]:24160
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965136AbeFSF4D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 01:56:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u68EaC/+Rf3BT1GMhpaBtVmLhkJFNvZ00jMaXBmW0DE=;
 b=I5UuCUKFgWQqaQQwTFc5FyL2n8WvA2FGjE+tuv3MFCwBS1i6SYxOe4HFALn6xuBqHtKjz2vd3a7vYb9v1HDhP/EME6K8FV+XFmEGvzCSWs4GfE9Db2uVa9nJKheFNaM6lcIN9pIc4cw9TvjAuRu6E1m25eNwAiK+FaX3CGWKV8c=
Received: from BN6PR02CA0092.namprd02.prod.outlook.com (2603:10b6:405:60::33)
 by BL0PR02MB4625.namprd02.prod.outlook.com (2603:10b6:208:4d::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.16; Tue, 19 Jun
 2018 05:55:55 +0000
Received: from SN1NAM02FT049.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::209) by BN6PR02CA0092.outlook.office365.com
 (2603:10b6:405:60::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.863.14 via Frontend
 Transport; Tue, 19 Jun 2018 05:55:55 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT049.mail.protection.outlook.com (10.152.72.166) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.863.11
 via Frontend Transport; Tue, 19 Jun 2018 05:55:52 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1fV9cO-0003YT-9R; Mon, 18 Jun 2018 22:55:52 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1fV9cJ-0002dz-5l; Mon, 18 Jun 2018 22:55:47 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w5J5tkXX020560;
        Mon, 18 Jun 2018 22:55:46 -0700
Received: from [172.23.37.150] (helo=ubuntu)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radheys@ubuntu>)
        id 1fV9cI-0002da-5h; Mon, 18 Jun 2018 22:55:46 -0700
Received: by ubuntu (Postfix, from userid 13245)
        id 8549A3C33FE; Mon, 18 Jun 2018 05:08:30 -0600 (MDT)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     <davem@davemloft.net>, <andrew@lunn.ch>, <michal.simek@xilinx.com>,
        <radhey.shyam.pandey@xilinx.com>
CC:     <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/5] net: emaclite: Use __func__ instead of hardcoded name
Date:   Mon, 18 Jun 2018 05:08:19 -0600
Message-ID: <1529320103-7711-2-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.4.4
In-Reply-To: <1529320103-7711-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1529320103-7711-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--5.591-7.0-31-1
X-imss-scan-details: No--5.591-7.0-31-1;No--5.591-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(2980300002)(438002)(189003)(199004)(63266004)(106466001)(426003)(11346002)(446003)(2616005)(476003)(8936002)(90966002)(126002)(336012)(486006)(7049001)(36756003)(305945005)(2906002)(498600001)(47776003)(48376002)(26005)(8676002)(356003)(50466002)(186003)(6666003)(81156014)(81166006)(4326008)(54906003)(59450400001)(51416003)(76176011)(6266002)(5660300001)(52956003)(575784001)(103686004)(50226002)(106002)(42186006)(110136005)(2201001)(16586007)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4625;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT049;1:ENtIdBOOhmJlezfMs7WeDzEPM2GodJBOerl2RVaAriThrna2ypnrhKuavXfTYlraiwtM9lBPiZkZAYcPv0ZFon8+FOmS2pDjH/0LI8eOMFlJURuC6mIZZemVoVas2LZ4
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d3c8c4d-3588-42d7-811d-08d5d5a95236
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(4608076)(2017052603328)(7153060);SRVR:BL0PR02MB4625;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4625;3:2OgKN15xrEzx+8NznBFqJr9HJg8wwsbuBrCu5xMN6SW6SWHr8xGKctoYZgNc1etw0xwqAEOKuvhEou2fintVoCZf6E1En152Dsr1jX4z8CkJAz/BBnKffukuOD0nYYFDdVCrEQ/M/XNX8zxDY5OC0yGpZiab++M7nU63DKL3kTVHHb2oIyf6Jih6mzVLSTg0cktCiPDB0UcU6ldT/kGEFnThWwIyyY4wrSFrwycLSmOIn7G5smemRPoy5VGgnGTlUE/zPks622C2nwwY8jADMNNOJwAkJYTEwtMWCMc8eXZ46FlCQ3uw9OJhQc8cWQ+H9/BPihJFbsjEi0/XNIPW7gM/rjLJvwuU5hFi4L+hBCk=;25:0XJNQMPz5G25mv0Q5xmKtlAEbyQgdR9R/3PnLxawU1UGfNOutJOVv27Ijz/1jEO1zUD7VdJkukCUmtrth2X7hXzx/RY5kvKlginFG5ji1y48q2cnwNlQ5BCYipPx3TkJ67s0dsXfTuSlr7iszF/Ei0Jg6jxTHOTe32l4YAcvPjhtz95Xkufi7Sxwt9l05wPoHtmvRrQBNmNBxWOnZzQmtvAi/90gBU0OfWOX0fTq2HM4L7OE0V0xV8hS98F0DP3RItbM9xtuRW21Ds6ApXWPzkqymq3qbLurtJEY8YI7iaLl9pJ+wQH37KGKme5nMrGv85VMHmueqppiADbu1KGeBA==
X-MS-TrafficTypeDiagnostic: BL0PR02MB4625:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4625;31:soRdmikyuGQ1cFmgvoTgkwKDNtFEZvQPGETGbiyFPUhmAAsweA2MtRAwJEa94i/zR51kp0CbGHcdGyONX+LnxcI4GAhGAC4wKBvo/qyORAU5BQfW45ZeW/4qeSmtyyR4gL+Lhi5EO8Fn2a1AI5f9RrVXZ72HtF4KbYvHOzSeV38gv7ML7iDJ8vmeq4wRs8ksxUvQSH0MWAx8s9RMmAGERzYJbQrrN0gvK5nnxFWmJ1Q=;20:hvc19qEPieOT0uRWlQ7cPbcH0K6A2nLDt+5MQshJawpfvtCM9tAfsSvWVYnV9hHI+SiYvEGEHZOxIR34BCcCg7slVj+OWycYFBL/yuFPX5YItk3rukZh7nb5rc/x6NFjR/onNH5xPuTTk1dhawcloHpQ3oZBAQMgI8EXF/pO2mC9D+s7s5TRkQ2R2zQSQOG1o6kCBWOFfdqDtdTZsQdC59KmplJg0LErxHpleTTuPZ3hT5IezcTHZA4xmU61NAxpCzh8qdZXcCZ/gb8Zbwn7J1dothDWonNnQRRAXGwrMHXo2nArIHwtHn5ranP/rlr6Lx8AV3+CXeTtyGOrRVzpbEb3etJgDfbEc2kcLN/skNOdvRj/AESJnto73d3YjU+nH/n9tXl6gb05VFJxi5nQDXhc8LAO8QTQpPSKc4Whzsn+GlAFtR/5OUYSpqMyGW+m1zi/PZSaSy1geTeuMcimnz2setDzHdmV10HDS/e0Z6suBI8hNtHHNywB9D/4itjT
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL0PR02MB462576AF0BAFA5A4FFC18C26C7700@BL0PR02MB4625.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93004095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201703061421075)(201703161042150)(20161123560045)(6072148)(6042181)(201708071742011)(7699016);SRVR:BL0PR02MB4625;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB4625;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4625;4:eJ+VB3v446GySoEslNvgwT7mNwr08MBS8wwR6NqKw9dg8GN4rCmXAbpJQqkYttyzHdFpY+/gDwOWQRxqLATqnJpydUv3pYcJpLedXYtfW18XSZmDsFfbIBrD1x7HveohBy5OiilT+WqXf3LsxEepjHT4nM29UiTQjXYGmozl3c3ORsSu4EhYJ5YxXQvrvDgLLQ6XQI4ix1MHDxpOuYXX6E3r2tXSZTn6WVyY4RxtQ1g+UndiXkACk08qUjeYoYovHeOrNmM0EY9v0GYJGzFcOlKBwfAJIbn2pRePmtCqS/EPLjIb/hz3BaVTMeyaOZ7P
X-Forefront-PRVS: 07083FF734
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR02MB4625;23:qnS0Ld4Hf7NfnNt5+Bv67QLsRBlPjcaDlL1HhYVtn?=
 =?us-ascii?Q?CWUBOJ7XezW9YgJsJZs5C60E06NnUscXbri/dFRUZObsY2R/DSCeelAG6GQX?=
 =?us-ascii?Q?CXqBYEIsLa0heSoVRzrt4PYvV5bY2Jbnk6iZUjznchfOk04/wpwfFHAg31jp?=
 =?us-ascii?Q?GFEQEK4+ORl4skRlN4UIzbESe5LICha6m3DuVME0V0HJ4EAjWYKh3MGSs+ya?=
 =?us-ascii?Q?5PJiuv5nDG/3Hz09HgDEJ4T5/nuRZLPTh/x+X0iIcEgZUQFsUNj0OPUdzLi0?=
 =?us-ascii?Q?ZYcdfvZTxyJyJ0an2bcQyUOwPeCyI5Kfx1AX1fKzKz0DiacfTY1W0BYqrGIi?=
 =?us-ascii?Q?lcGw5dzGQ7MlPUkiUDulXaaCPB+f3v9fWooJ6EfbsTo9g1crfH0O/1IOx4+D?=
 =?us-ascii?Q?bizdYEZYrN8pDb4c9DRpAiLOv858SIKK5aHiVN8bur9VFc/4kfbVhmiXZxvD?=
 =?us-ascii?Q?nC+0iH+5Fu7rZ81dm5yYki3j5oziUhoTyz+53lWEzaeKQiZWO+3/kLf/J2Y3?=
 =?us-ascii?Q?KXgqwkQrBWHuFvxxu07e+gDZGS5zjV3aMveGhE27wsjZSGmXFzr23YJHuTRZ?=
 =?us-ascii?Q?DY8SZNncpVcrp4eMswTUgOoQTh7xyZpBkzg/sivxod5Q0l/a63B0jvUmGgFx?=
 =?us-ascii?Q?DUJ5BWkJZp769S+tqq61+e4pMm8aZCgjpgbSV0i3evHz3/4qdpHpGWRh9hkH?=
 =?us-ascii?Q?fmromwJxMTlSGKkje3vLHtA2VaaC8+Ou9qa9U5dz6ZM08YUZpUaPYSoMM3hF?=
 =?us-ascii?Q?n0nRCLVzORBZeNYz96gfkGMGZHf3FV5U95tG8l/SFLvlzhSi9iDDhul084Zr?=
 =?us-ascii?Q?kAsGNvPigpw8XzGZWmVDPHexes9HYQtNWrnVfy4p5c/WkdOPF3D87eNxvgfp?=
 =?us-ascii?Q?OseHKUFGkdwCnFXH/YjHAtOtSchkPT7v01k9K+Bf2ONsAbyNVNPEpn5dUwLj?=
 =?us-ascii?Q?Zwcr3FzR8Z6hbZXidy7htDseFBdpLFT395GqxvhUVpxrHeOgXTd74B/8lRh0?=
 =?us-ascii?Q?B+FjwfowIcPpAz4KVakGXPojUz75UAX8PA8ml7whSTcDSvNPT0GiG1X9EmP7?=
 =?us-ascii?Q?Q+gXuO7I0C6NRPCa1SM5hrQVUh+df/vKT1+lf5uW52dAKROvw=3D=3D?=
X-Microsoft-Antispam-Message-Info: eY/b/opfvS1WX95QpXZLlMgNX5cbpQ9Fh1TW0jeDgT1i86ECq6YKMJw9GYwCCi3Z3D8PTA7GDdocMt7vU/oHiAsk1SJvzVVnyaLlJMiuzbsPxwGFyEfqkjFpGOo1BAdZkn/M/HuZAxwLva9Z/3tVPMD3sQdUjkZ0vlm0jEaDDW94H4HvmwCOvLF1MTLEhRE+hqQfM51ti/TKMvcAtMtdLYqDbOrJwQir/CBEB/A0cNsgluE17/HfNNO56Xia+24kntRnednI8NNM27CY54aIp4fS0CBmWhVu2sel+8+DatlSYvUofRmBX8LvGXz1Zu3hCrtxNSP7DDHC4MXnCVbzCQ==
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4625;6:MdqQ3HexWwbsCZl8bZGS5CnVLQArZGifMjTVzpBjR4aJt4300iGclMdEESu2sErYy3yqY3aW4s81WLVmImPU1C8T+e9GA1qyBVINZQHwYOn8bX8Ucn4aCl841tdP6hh2bUd1fpoYhNWifgAet0pfIZBzE/D1PYwK/vS4XHlkEq5S8uCj0PK2pMEGlzONFTZIDfQ9nm0FF66g0cZSn+/UZFK0gKDLDP5C8NLSCuDltBnlaie+Lp91HKTyM6/WnO67yrawwwjpWR+CXD3HG5DhGI6AvJPuyKI4HFxnAcD/hc3rmhrqzgRN8KqNUsQ6J0l4Kj7CdeawNgdxe34kxoUcSovVX0sb1Qj7t2aN5fmJOVxqLG5Sr6AcSt/pmmcyNt1I/F6U4qi9D6sZC6c5zjp72WRv+9f6+OAEX2XW3KBdDu1K4UE7GJXNhudn9sI3BmqMytNcsbeulxW6vPOODjr2UQ==;5:qnsyUI02DR2HvmwxAPAvLHnoanZN65iFjk37fJD79zGyiTK5Ifq6VJpnx7SFJBEkPPl5qaXkat7YSCByUtzX16RSOdh99AkAJJFWJkOFqdln6LtSFR6zDJB8zMHNVFGP2LS5d1ncMVDt6Noh1SYM8jYgNLAUPZxitDCBavu3MzE=;24:vkWP6v/Na9ruhni+HLEclXcuoohghoF/C9+NUrPtVvkucT9+1xD7yP9v/BlVer5A7Kk9gUk24KQZHuZkwsDWOPaOtk7AzuvAIuLyklgWwJw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4625;7:EV0uupAWH0fMfjEwFMxuYQDPOPU/oxT4lYbcqlGikWqG+uObkEo/9XmYAyU+MBK9aQFHB7gfUZFTxd1mNPf5y5VqTQ0cvQpZ4Fqj6ADORhh1/ALFOuJhKTM6BDu/Hy0S/kyK1YHpvQ+KY11LHRG3YycQLfz+S+JozkzGwo87qH+a6CaMg4jG+EBcz0Tzuy+zDFPadfRAdzjPLJ9HfBglmNXdzaf2I8kLA9/GmzPU0n0OXnGrGK2lY5aNAzfR9XVE
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2018 05:55:52.9535
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d3c8c4d-3588-42d7-811d-08d5d5a95236
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4625
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch hardcoded function name with a reference to __func__ making
the code more maintainable. Address below checkpatch warning:

WARNING: Prefer using '"%s...", __func__' to using 'xemaclite_mdio_read',
this function's name, in a string
+               "xemaclite_mdio_read(phy_id=%i, reg=%x) == %x\n",

WARNING: Prefer using '"%s...", __func__' to using 'xemaclite_mdio_write',
this function's name, in a string
+               "xemaclite_mdio_write(phy_id=%i, reg=%x, val=%x)\n",

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
 drivers/net/ethernet/xilinx/xilinx_emaclite.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_emaclite.c b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
index 2a0c06e..0544134 100644
--- a/drivers/net/ethernet/xilinx/xilinx_emaclite.c
+++ b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
@@ -757,7 +757,7 @@ static int xemaclite_mdio_read(struct mii_bus *bus, int phy_id, int reg)
 	rc = xemaclite_readl(lp->base_addr + XEL_MDIORD_OFFSET);
 
 	dev_dbg(&lp->ndev->dev,
-		"xemaclite_mdio_read(phy_id=%i, reg=%x) == %x\n",
+		"%s(phy_id=%i, reg=%x) == %x\n", __func__,
 		phy_id, reg, rc);
 
 	return rc;
@@ -780,7 +780,7 @@ static int xemaclite_mdio_write(struct mii_bus *bus, int phy_id, int reg,
 	u32 ctrl_reg;
 
 	dev_dbg(&lp->ndev->dev,
-		"xemaclite_mdio_write(phy_id=%i, reg=%x, val=%x)\n",
+		"%s(phy_id=%i, reg=%x, val=%x)\n", __func__,
 		phy_id, reg, val);
 
 	if (xemaclite_mdio_wait(lp))
-- 
2.7.4

