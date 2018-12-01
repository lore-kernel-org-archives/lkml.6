Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D61BC64EB4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 11:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1F8A20868
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 11:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="UF0YUbqh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1F8A20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbeLAW0q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 17:26:46 -0500
Received: from mail-eopbgr780080.outbound.protection.outlook.com ([40.107.78.80]:42176
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726708AbeLAW0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 17:26:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hWqCA3lOXEItm038LpdbUJ6wLH4VhiDpOSgNvBvECZY=;
 b=UF0YUbqhi4f9YKpTDQLCIal3WziatP+4qaGbkGYiU6MpJEYUBigCdd7CaFSx6+E8FcXbZBcMVyfn1QfPNoqv3IT3NxegMj6LK061DPsSsPwtEVB/g9XH0P+DChkeFqbWpkKarMJUsIehwX/T7It1leKgVbT3pQ+8P8r52ab33Jk=
Received: from SN4PR0201CA0063.namprd02.prod.outlook.com
 (2603:10b6:803:20::25) by SN6PR02MB4334.namprd02.prod.outlook.com
 (2603:10b6:805:a4::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1382.22; Sat, 1 Dec
 2018 11:13:45 +0000
Received: from SN1NAM02FT046.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::205) by SN4PR0201CA0063.outlook.office365.com
 (2603:10b6:803:20::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1382.21 via Frontend
 Transport; Sat, 1 Dec 2018 11:13:45 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT046.mail.protection.outlook.com (10.152.72.191) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1382.18
 via Frontend Transport; Sat, 1 Dec 2018 11:13:44 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1gT3DU-0002W2-2e; Sat, 01 Dec 2018 03:13:44 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1gT3DO-0001kp-Vb; Sat, 01 Dec 2018 03:13:39 -0800
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id wB1BDX76003399;
        Sat, 1 Dec 2018 03:13:33 -0800
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1gT3DJ-0001ji-2x; Sat, 01 Dec 2018 03:13:33 -0800
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id 413D5604D5; Sat,  1 Dec 2018 16:43:32 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Johan Hovold <johan@kernel.org>,
        Jaejoong Kim <climbbb.kim@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Roger Quadros <rogerq@ti.com>,
        Manu Gautam <mgautam@codeaurora.org>,
        <martin.petersen@oracle.com>, Bart Van Assche <bvanassche@acm.org>,
        Mike Christie <mchristi@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Colin Ian King <colin.king@canonical.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <v.anuragkumar@gmail.com>, Thinh Nguyen <thinhn@synopsys.com>,
        Tejas Joglekar <tejas.joglekar@synopsys.com>,
        Ajay Yugalkishore Pandey <APANDEY@xilinx.com>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH v7 00/10] usb: dwc3: Fix broken BULK stream support to dwc3 gadget driver
Date:   Sat, 1 Dec 2018 16:43:21 +0530
Message-ID: <1543662811-5194-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(39850400004)(376002)(346002)(2980300002)(199004)(189003)(51416003)(356004)(186003)(551934003)(478600001)(6666004)(2906002)(48376002)(476003)(305945005)(486006)(50226002)(2616005)(126002)(36386004)(26005)(8676002)(426003)(4326008)(316002)(42186006)(107886003)(106466001)(36756003)(54906003)(81156014)(336012)(39060400002)(16586007)(106002)(90966002)(8936002)(110136005)(81166006)(63266004)(7416002)(103686004)(2171002)(5660300001)(14444005)(6266002)(47776003)(52956003)(50466002)(107986001)(921003)(83996005)(2101003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4334;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT046;1:MHU83GkrStIsasJE27XCvWINZ/TitfaSRZkBd1K4ubqjBabVyqD7z0UyuTkthzEbEc1udWap4g3O/zyw5DPjsRmvZIqmDIKfo2fLr6Sa1FPp1HVdT3yFA8BDaTYp7sNM
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9577a908-b197-47cc-990c-08d6577e0f40
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:SN6PR02MB4334;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4334;3:SjsSSvaFbAsBUCGzIjY2iNDeYlDOWHcQD1pmG7Xs77CtTdOrnSRabb5Q4u9H2/8yDxdLNbAqGnCiPKJf423GDKEwP9vTNKKlvaFs3EsmI3p+ngv/00Y45JwbsbtvCWBjJPr3aIikDAM3bZ3w7SrZN+Jk/+4Q9JeEiMCnDuP3JpSRbypNjx3PX0AXDW1ROMwGs9+xn3mbrAec9pBRf18RdVN00rYTpVNxqv+JjYVgItS502DCoOp7cdTDnkkdtsKBPFWEWoZstEJX9S60vn98YWmC7G5IFYUq1oStZOfQvqof9NqTsZbybor9omSpkqXlBTC7+w7kg1bRinUVE3WJBk3YY09lz9RWKdPfEobhsJk=;25:T5Z+9TGcsSrdWPZ9n16OvARTp3R+BibKvWVxYC5EG65W0JT56TvakEM2LgXvJ97fxTh6rokWo9ynbTw94Iku7MIWUkHQR10UgUnQyUdMObvxdBeit6oPHaps2DWnCPjXvzxyaDgQ25BcAMShJ/9HTykJZakRRHc2FxFTERb8v5PPbPsu6pS4wflNDBSoyXu6TaioMvOs5vXpRHJMKRWtepnHedt1T95TdIDmyYy+p5wVD1if6exrrH3xQAU2yRRiGz0tisL6Fu4E49P+dj92zx7ZJQN+YTqzgGBU90vpB8jqPxx8e15LqwB+/vIatzj2dOCjaIrntj6dNC/hrccKYA==
X-MS-TrafficTypeDiagnostic: SN6PR02MB4334:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4334;31:5Pt4oWmb3OVdqz1Zzw6XzUSoERfeqPcus9N51L5vq6cAgiyvvEIAaHQALCKm9ZS9twOB6+a1FVEpHGQAyJZrSjW/KTcsJrSE+6wNXH4eqU7B4jDUl4e7h23u12AWCao5V3eVgvW84lAxWzHO2at5AoKl22JYDvqgyYsBQRbu9maoYA2o9GIzu23lY9kNfUI5bL4iNT1PTkDP7pjg9AOYulIOBJcD6q1GMztrCQxTOAw=;20:58zR+Jvv5eSxOuZHSGKVi2dc0l6PWdIm1J5PrvVKW2HSZs17VvvyOhM5YYv8ZOklXfYXcNeZsmy4OfL98X2c2qIrmcIjiul25q6Q32jhaCfAwfMIkYqVk96MaQxsEodvSZiZgzsLtG7tRsWbo4R3ZLeAhpk6754LRuSKxZJfCTWqLskkgYlYBN8Aa0iTvnHQ1mZrekHfHLgf0SuO4MvidfRzjb5nyu4RS3/uKHSR+Yn8dXHk66+ObC7Hmz49JT30BccxA05yfgwwNTCM2bMdocDL9BXz378KO6c+VEJR94gMc/s4IG4C5l+FYNF49Ss58ViYEqdp68Dog13zL5/F1fkRlBUvvtR1ohdhEPTJ7FoS9ubJNRztdM1gOux2rzbCDxdevvfrw8z6A7lM6WJDbVlgyRnRrZUc+tOqeXFWC07jKpa/nxrBkbs+CsJ/POy67ijMBnQ8r52nbS5kIut/Gx86duEd2s97e4hAs5V36O0cDLfPHJD3WCRfmbqR3eEe
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN6PR02MB4334267F481E50BEF3243306A7AC0@SN6PR02MB4334.namprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231454)(999002)(944501475)(52105112)(93006095)(93004095)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:SN6PR02MB4334;BCL:0;PCL:0;RULEID:;SRVR:SN6PR02MB4334;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4334;4:qFxURIjnkHhtVqFc6Z5zQp8RHyb9iFyazrIkTd45UsKfKWD05Kyw/YJWZKhmON626ZH2KKxPVzRav6joCPE6lrn6tyffm3SbJczMohYVkhOlsS+1WaP3i1f9CB+30KJqtR0Q4zKyloYz2pt6LyuFrULFkKeuvAQv046LVf2izwzUlS7ak9c0fDX9I+IoFa1pPl390cp7iTqan+trkeNEEviDDav6Q5bYz0q+aFzZHsM6XGdR43dYolTLXT/3WFQ4tQKFJd/DTCq3kL/HHGGKzA==
X-Forefront-PRVS: 087396016C
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR02MB4334;23:4kZ15Pgcb9dC7Ql9EMmeGPGZ1HqLhGwUx9dxGK9T1?=
 =?us-ascii?Q?2g2VVUMtY101AF1oIQbVwTekGPLlWuRur8XNP89pCp8DzX6dlc8kUKOb8AvV?=
 =?us-ascii?Q?yd1uYV8angb6inhz5jn7HhS7qcNIFSPuMbbW4S1y/AmeR96GXBafJ8sEV8Rc?=
 =?us-ascii?Q?lJjrWisuQSo80Hz1ldvPLXMe6AjuYltf6fQVtNq58PYSrDiqYs1lq6yqQRH4?=
 =?us-ascii?Q?Szha/riqqJpCKKcLkCli6OEhezEpEzg+qCqklCsHaDTv5FsBVqF7la3tWLsM?=
 =?us-ascii?Q?D8TmzIs9HNx8FRFPdahgKdSybT6QeDutdXHkTLGhr4LBit57JR4Bh9v8QOda?=
 =?us-ascii?Q?U4uoaa+SmiK32VUzx9/WUatHtf+A4E2Ghm0m2SeX+QZpFq/nWFHnXtN1RpOU?=
 =?us-ascii?Q?kTsmnVMqwpdWxWIQiOAUJfRs1lhS55AwjuFxPR59h9bghl7JrTbRoQFJzgxg?=
 =?us-ascii?Q?ruADvcmLZq/IJJ5QvAegpqlXJpQiSFPrNbr7m+d4PSByaJ2xxjyVOdeQka2E?=
 =?us-ascii?Q?o3620eJZJfz4nRMdccdhS6Zvw88NL5pT5zsXUethWklpgGywiN8+ZrFFU6ah?=
 =?us-ascii?Q?bxpsP01YQUPDw2V+p3kZfWBzxsiIpw4MzE1afm1UB1JsWuSAtmbV4IfBopqB?=
 =?us-ascii?Q?RgdmKD7lo0RHyjadv5/zWjJYVdptO74fjw9gBxOE4xtEZF9MZZ5OOdPVlHeV?=
 =?us-ascii?Q?WvyHRcTnDXOdORf3zx5W28QYdnh6BQjB7IQrnJoKPZhDeAhbJ1K3SONSx4Lh?=
 =?us-ascii?Q?NUthmBkO35uQ4lx2ObSDEkdx8mhXtb+amnZ7JLg8yla/DL31v8OlwIwgEd1b?=
 =?us-ascii?Q?zR3eNox+NSwfsdBH6PL/PB5FXEPRxvyNRrYnpdlvLNKDIdLG8JeaHu2tx6J2?=
 =?us-ascii?Q?LKMgN8TLdgnSUg9REDuc8d10qLxWvrRmr5oN38FKsxPrzLMw7tpjp6s/NWTQ?=
 =?us-ascii?Q?XYmU8YvCBJsWLEjAh0JTKleY08nsUBgTOtv1YsRMbpjxX08xgGWhsUWAnXIG?=
 =?us-ascii?Q?V/w006Lrp73Ot3uQ0KUSwnjl8QG4CvylK4ExjPuIF6QOK2zFdpvmnrYJGHl2?=
 =?us-ascii?Q?vtT8qOOJbUfQUuXg3zqhjIDFpn2liPyqQ94LSlK25GE98vACrn9Aaa1s+MUX?=
 =?us-ascii?Q?68sA1wHxKL5Pno8XN/vZ2Hvte4S3EoVeJ3FPgXmgIydaI9ZM3EdLOnFfdvZ1?=
 =?us-ascii?Q?PPdIvOesXZxDXnHuaEUNMLZ+nMs97Yn2mE0AvR3MPItzZ6M+2s8fTcPtajxN?=
 =?us-ascii?Q?XfXhcJVAx/P+2F0g0F8abHrIMzSI58xzUdw5baG?=
X-Microsoft-Antispam-Message-Info: XWdkUj2NHwJWazfJhGgyxUKZJPK9SqEQb+GgF60iur9HpetgVWy3Aa9kEm1npJ2YoOsVSEgB0YHDN8SE1NGzLPNyvw17fk7DTAeBJ38dcmPw/gAX5Svwjd+sfwLI8i7F/MY91zIce36pI3FGvSkHphV6LLEDKZmdV7/3H45/sr1MTNlPde8YpKPQTS00bgGbIr3E6NRCb1mw25+XdNC7OKSp88yjTYvll9sJimG+fOYCpJ1950I2A/7jTqtQqxb4TfR25lWqxmu6y4wntpnjrCiHMKiTNgkqyPQAyCJW+8//dzK9frWkmsfvCJfjZo7QnbjMedFgJ2IaKa8IJczAeXkQ9xj6xiSHXEmANhIc3lE=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4334;6:hR4nS0XIpkEnb5T5KqiaY2KlC66wLav3SO7PL22H1+dHvpMgOprXO3Zo2vVOVCObtOjsZ+kqV1YoF2O2npLz6vzqeNJYRVoOTCr1MF9zqB306qBkFzjPAlN7kQ12xWmvUOjpVHbCm0aIs2iG83bpFLPzZSP0N4KJdbZzLa+sFVL3eJYU5MxN4VERembRX8KuMRmoix1QUIE5K2HUhhM7dLumV2alRW1/vqirI+FKXfMeGBehaT6Z17dnQ43khwLoMwaUbsb0u89x1G+Zy2scfC7PEym7GRxincMBIXm0L5BycRfMAPO1oUcuWy776qJfTHU+Uym6atR3Cxlt/AvPvLlTqFN8CkHTTY1+oWez97ec8xNcONH30u52hbBJPqcgVZtCz9Zf6N2/qNeW71fcznC1KgDnI69TVGzpaAo5StAbkV465mFhtS4JYbvnEaiv/8iE2Zparq3nWs0kLUFN0A==;5:aFpuPnusgeYbqkhSps14g+KnkeqZ0/kShGim42LdcvNeITuwEZScInZUx+fMySyBEPBZnmPXWcm8hdW2Zs/EJ0PTG5cd0IBuONpbapewMd0fZX8dbFABSbDgDeKZFXGQXPShmEH6t7VV7fZvvWT7HTNE4H/jGmY/XH/emVjsXUA=;7:zt5NmILXPk8Alqf7fcjKT0OEiCB5wBGrM08N2X2EOmFr1062/0P40VBog8UZ1TSG/N0ayETsKsLahPTNlkrTy9332Xd5u/pZhBEU9sX32O5B8SIiqrSY0t5C0PuBP2CpVBqykNyIV+923KBfjuKy+g==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2018 11:13:44.5391
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9577a908-b197-47cc-990c-08d6577e0f40
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4334
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series fixes the broken BULK streaming support in
dwc3 gadget driver and also adds timers in udc/core.c  for
the endpoints which may go out of sync with host and enter into
deadlock. For example when bulk streams are enabled for an
endpoint, there can be a condition where the gadget controller
waits for the host to issue prime transaction and the host
controller waits for the gadget to issue ERDY. This condition
could create a deadlock. To avoid such potential deadlocks, a
timer is started after queuing any request for the endpoint in
usb_ep_queue(). The gadget driver is expected to stop the timer
if a valid event is found (ex: stream event for stream capable
endpoints). If no valid event is found, the timer expires after
the programmed timeout value and a timeout callback function
registered would be called. This callback function dequeues the
request and re-queues it again, doing so makes the controller
restart the transfer, thus avoiding deadlocks.
 
This kind of behaviour is observed in dwc3 controller and expected
to be generic issue with other controllers supporting bulk streams.


Changes in v7:
	1. Added timer timeout handler into udc/core.c
	2. Started timer per request instead of per endpoint as suggested by
	   "Felipe Balbi"
	3. Added usb_ep_dequeue() & usb_ep_queue() logic into timeout handler
	   as suggested by "Felipe Balbi"

Changes in v6:
	1. Added timer into udc/core.c for stream capable endpoint
	   as suggested by "Felipe Balbi"

Changes in v5:
	1. Removed the dev_dbg prints as suggested bt "Thinh Nguyen"

Changes in v4:
	1. Corrected the commit message and stream timeout description
	   as suggested by "Thinh Nguyen"

Changes in v3:
	1. Added the changes suggested by "Thinh Nguyen"

Changes in v2:
	1. Added "usb: dwc3:" in subject heading

Anurag Kumar Vulisha (10):
  usb: gadget: udc: Add timer support for usb requests
  usb: gadget: function: tcm: Add timeout for stream capable endpoints
  usb: dwc3: gadget: handle stream events
  usb: dwc3: update stream id in depcmd
  usb: dwc3: make controller clear transfer resources after complete
  usb: dwc3: don't issue no-op trb for stream capable endpoints
  usb: dwc3: check for requests in started list for stream capable
    endpoints
  usb: dwc3: Correct the logic for checking TRB full in
    __dwc3_prepare_one_trb()
  usb: dwc3: Check for IOC/LST bit in both event->status and TRB->ctrl
    fields
  usb: dwc3: Check MISSED ISOC bit only for ISOC endpoints

 drivers/usb/dwc3/gadget.c           |  67 +++++++++++++++++---
 drivers/usb/gadget/function/f_tcm.c |  25 +++++---
 drivers/usb/gadget/udc/core.c       | 119 +++++++++++++++++++++++++++++++-----
 include/linux/usb/gadget.h          |  15 +++++
 4 files changed, 197 insertions(+), 29 deletions(-)

-- 
2.1.1

