Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1797C64EB4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 11:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B4DC20868
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 11:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="WA5SlF1t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B4DC20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbeLAW0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 17:26:24 -0500
Received: from mail-eopbgr700083.outbound.protection.outlook.com ([40.107.70.83]:52078
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726736AbeLAW0R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 17:26:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9O/fkWXIvShko9wn5oCt8IYeGZavbYH55pp2ZrjJTN0=;
 b=WA5SlF1tTBOgL2Fz0ChvpeHXHbSkIrIAIuE27TumPysbe+jsr7/l4dVO3U0UI3d86tO9iFCQ9xCGWmv5w2sXP3mxFksh7NJBEXnMV98XexFSeJTq2/LReF+UX9HzJ8/MGpN12HDa9o9S+Yd0s5ZMZ0qBhVkj4zkuNVGCCHU+SrY=
Received: from BN6PR02CA0040.namprd02.prod.outlook.com (2603:10b6:404:5f::26)
 by SN6PR02MB4463.namprd02.prod.outlook.com (2603:10b6:805:a8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1382.18; Sat, 1 Dec
 2018 11:13:52 +0000
Received: from CY1NAM02FT049.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::206) by BN6PR02CA0040.outlook.office365.com
 (2603:10b6:404:5f::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1382.22 via Frontend
 Transport; Sat, 1 Dec 2018 11:13:46 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT049.mail.protection.outlook.com (10.152.75.83) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1382.18
 via Frontend Transport; Sat, 1 Dec 2018 11:13:44 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1gT3DT-0002W0-RA; Sat, 01 Dec 2018 03:13:43 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1gT3DO-0001kp-NN; Sat, 01 Dec 2018 03:13:38 -0800
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id wB1BDYMq003401;
        Sat, 1 Dec 2018 03:13:34 -0800
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1gT3DK-0001jm-0H; Sat, 01 Dec 2018 03:13:34 -0800
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id 34A1460504; Sat,  1 Dec 2018 16:43:33 +0530 (IST)
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
Subject: [PATCH v7 03/10] usb: dwc3: gadget: handle stream events
Date:   Sat, 1 Dec 2018 16:43:24 +0530
Message-ID: <1543662811-5194-4-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1543662811-5194-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
References: <1543662811-5194-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(346002)(376002)(39860400002)(2980300002)(189003)(199004)(26005)(186003)(51416003)(478600001)(476003)(126002)(106466001)(90966002)(52956003)(426003)(36386004)(336012)(2906002)(47776003)(7416002)(305945005)(76176011)(11346002)(446003)(486006)(2616005)(63266004)(14444005)(356004)(6666004)(48376002)(107886003)(4326008)(5660300001)(2171002)(110136005)(106002)(81166006)(6266002)(103686004)(54906003)(50226002)(8936002)(36756003)(81156014)(316002)(42186006)(16586007)(8676002)(50466002)(39060400002)(107986001)(921003)(83996005)(2101003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4463;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT049;1:shfDVG207dhnfnamBqKcZBMsSzvGgtwL1kSxXeiV8bgnqUpkAbjHNYCG6630DiI3Onq2ZLTqSVZVnVY4fAcYrdFHZy8P0eLOq4M8jPLj7G1RhqGtoNri1Gj2gnuuLzBb
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99784bdf-8ccc-4983-bf9d-08d6577e0fa4
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:SN6PR02MB4463;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4463;3:rn5NDDx1eJvnOdh7XYy6o0eTMyRoAV2dDVQNQ+/P2Ff57WJjxXyWc9kqh15ZM/9NH1Z40cK7eeKrjaR722QgXnB4pmAfKEx86AIx5mbQXqcQW1Bh2GjaI0HcLcyEI1hLjAatnRAGq7dzepLznLjRqbWjeatZhLtTNQAXEeAURItlQdKUA/UTwZ79izAPXeC3Dw84InGmsNJqAtgzERtLrYE03vQCgZdthnQzCktQ9GvNUXd/b5g9GnlirOM3D3s4HZ1EIzefc+8OuMfSC0exlji61cpta273coupy0/VZs8WVXs3H5xzPaq89AiNGUkT/KuL53cG8Nf2dtqHIgsrBOZv53m66nJQg/zcmBtG2LI=;25:lgj1yLYozU3J/n2IcAxniJQUneI3cDRj02kP4/pkXv2HvUGOpyZ4ghs5QC4czUWI8mB6/o414laE/yhlLlfyGzTM5SMBeBoGbQkd7sQ4WCqbJtuETo/0xeciK5OwEmpAQBcFTS8yi/uSH28NUFD7uZ/OQilPaTK2ZslQOcp+fUctUASr3sci25tS05v/EfIVodhRXg7NQzhs2x38qpNGoMHFPDo4HO8eMv4ZUUZIiubw+JRtKF3eVWDefsqb6lKMsUpJKkrfAEq5hoqjXpEwaambPBLokP4InIA0v6fmjGxYMsjqAmBmR5BRhkMltPXh4EuPIDlGcK8u3S8qNDTcWA==
X-MS-TrafficTypeDiagnostic: SN6PR02MB4463:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4463;31:qZSk1TPx8V3ieI7CyduLN4gvIGY1ydVKWJqhKH3oKY+gkCXHoAEdYdXQ1Vo6PtblxY2COOhqjVmcgS2rblvREmUWU3DQbVK9d64PIHbEyqM8Owq/nXEZdxXXBhd7/EiZ2dlelkDKp4BTHCRBHhxzUFJ/dWLC953bI03aYLhnImEw8iacW5dbb53tMKR6tHq7kjZFXYvO3dpowPDUJuVYuycmInsJp0l0e4396rfemxY=;20:ulPc2n2a25hNxkVW3ndf8SURU9nijal+qwWbXk0CRZWCc1QLhn/IfYno+EfUBImy8kRQHPz4BcbVuQ9nHUsBYQ73XlNTe3irryYGv/EfSUR7yGIkbkbs0Z7plEZw8wY2fWk4/DY6Yxtl6eofIgEYJrChNcfkFDk3cYWz5tNDejjpcdwOjKooXzoV9JSEEd2CRwbvFF1piji+Z8cIiDJXPuzLMH+Fik08Pgsum/duED8qWZPPiLRSMY3JR2M8i3ixj58QWVjjNfNKdqYNH1wz01fO+nlcvA+UTaE8QQfC7/hRSiXF5U2p7P0/pEEKPrJDRavI2jDD3za+f/kj8ZuEBjmfAsu6nCICn2JxjZIq6wcZEig8m5ZPo//nrswfPF3CSXWpiLDOOWdtyntaBWbb0v+3kL+wtNiEdMbeOG/JND0AZxRgYoOJZAtGNUxrPVPAVMRZb/kS8hd88muO0bp7uYtZpCLbxajmbFPn2mwhCAjryPO6V3iGxPMvUCpDJQmc
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN6PR02MB44637C3B1F5ABA7D318712FDA7AC0@SN6PR02MB4463.namprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(3002001)(10201501046)(3231454)(999002)(944501476)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:SN6PR02MB4463;BCL:0;PCL:0;RULEID:;SRVR:SN6PR02MB4463;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4463;4:/GyUqIC6o2/cQKubZacWH9geX4UbyDmuhcFwXGzEHWnmLVcPVoW0ZQxWcby7jNYfsWQOYZDQAPenCbpFtsbx/MU3ECoukk86GF3Qw6O9ijnN5YkxiYBYlWZgRfHwkSNkZRspnNuKe7X6IHfNk3LWanXibfPkaSEcZDc/exoFV4kwAL7hDhoaoRJwkROGsxMqzkQQRrDdT+xJYvOzU5pR8QCZU4X9LdwNl8cZ3GK4wN6/dvp8fdwbxvyWHX3y7bdOBAm12n8JN6I9dIFsc6OnNA==
X-Forefront-PRVS: 087396016C
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR02MB4463;23:lE9Yx6u2YKeYiddoV7g6gZxdHDvvnrSowh97IWXRC?=
 =?us-ascii?Q?trCYFqRa8C+qrHV24Efw+opM0S7pG+9jZaIND5Cp42xIVUE59js3e2rrmBs6?=
 =?us-ascii?Q?xaoOIdMQc+IjSO73OqNge68KCJFPCC7aPrfporLaFaJGNk6akvOvOtKXbwfz?=
 =?us-ascii?Q?OqIgzN4AxMYf7IPga68yVSy5AkzsIMWPSMLR5mSBVlg5zMRdNj5CXXsUA45o?=
 =?us-ascii?Q?Rvb56y+4HnxnymIYVIwbK2uexBzxIRdLtNT3DTOYT3+SQu2gWwkjP+U9KF2F?=
 =?us-ascii?Q?7SCZJs4dZLwaGOB/qLEAGqG9zPPytPHZV4LEHnnbRXHOVKV2qI4cych/qci/?=
 =?us-ascii?Q?wG8Gx4hktvqQyo5PzLISi5dAXp1NDdQ7/Ilr0XV5/CalSb1pPPRfOBGEG0Bn?=
 =?us-ascii?Q?+R+90OBy9p4DR5Q7+31felWa3wBt4zomNH4mraORAWy6c3MJ6W67UyfDOAVD?=
 =?us-ascii?Q?kmyf6pL0lGNqUilkFddwOLnja6xS7bRp4O6mSDlg2tGtftCLLCwK/V6LmOrS?=
 =?us-ascii?Q?kDTefyptsigTlNXVyaFcObWyPBT1kWlUWUZ90yYykFU53JN3gBMdOtsQQ7Zf?=
 =?us-ascii?Q?1NmzqebkJJh3wTD2U14lBlGutPO2k0RTQfg4kURKCezZBviM3FPKk4whZ1q+?=
 =?us-ascii?Q?ii9HLKM9sx3DCBbgYeSiZEgu4lpn7A7MKth4bjpZa8bZoEzVdOWv2+vv7DDJ?=
 =?us-ascii?Q?LRk863wY1d+Rl4ryJ56HEeBKAf0Dpe4Vt4oYKP0MKuGJd/vOVdiqjvb1U3gU?=
 =?us-ascii?Q?NZNo2Z3kMaMRXlLXk2cfVT3wLyNBx+NIyGEmA5FZk9884aJP/Wh4n2TnSutW?=
 =?us-ascii?Q?kaNV4KPE4FQWFZ+0Log9cp/3zuNlS7s9e3DTxlPNiaUNWiBGc66AHJ+iszyK?=
 =?us-ascii?Q?j2MfkGtMngnLpp8rLfm6+IvBL6WdUwBl1/ODY4R0ypIESpLgjGIIhft+HOM2?=
 =?us-ascii?Q?sHqOIvJ+lSqS8Z3N8dYqlFOMdgt8x6MhfxRDXgRgpJLhW9hYtrDjAiFQcfuN?=
 =?us-ascii?Q?IKqDdB8vvDlM+YDaCRawLWyrx6XUfM2Va5tnoBV0Ov177kjaus+1zxKadiOW?=
 =?us-ascii?Q?VizLQZ553knkrRYohXlRiQ9DSWv7i9zQDDLlIrzE3Zln5zUcpRsmE7dK+Fyj?=
 =?us-ascii?Q?05FIWnwGRuZW1TdKu+09KD1HKOPT7JQA4lg9o7p9I5TmXMp4OU10I1C5do8O?=
 =?us-ascii?Q?yAzkt8fjGcxfuR+7DPP2P/g1/+Wiqh060MnBdbFPTZYssjIv/YXy6CXcMnSp?=
 =?us-ascii?Q?d9/Jc3OjXIAg2bTzxn4FFbcPP6NSGkx2wUFI6Z6+TYX+cbBA6TMNBh0Ie468?=
 =?us-ascii?B?QT09?=
X-Microsoft-Antispam-Message-Info: MNYQvwgL/R25gZtgeY5fRg5dtl9oY0N7cLGrKMyvUya3nG9D30ryVhVx7r544gyXLGGmZNQabyo3KcUTmzpJDbqzrXmYx51o3w/KeFPCp2eAPig4dhQrU7FTN88+yCx0ADlqwdZrKrKyHFEAIyzO89pP8kFjUX9fIGz6Y+6ILHOAX60LnzvQCX/EXsEXB4W9vhpyiRQT2RZQZQARMBN3ml6nVTlZbaxCRtB9reoD4u55KXPeVfZyzwPM13xnYVIcjosAihhQ7Afxzk1T4boI3LFWXCnWzxNJyXCP/GRzHk+q3GceCM/dHWC4byCKJg6UsQY5ys8p5eH++mN9lt+a04lYphO2fLBB/D0ZFIySWRg=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4463;6:MRF9KYXDgvOJnl+PymMYbZtDkE43SJY/8X3bT0UZQf360HmSEqKZ/LF+h0oe8EtNe7dmLbk2F9S1QvWfEeqqzI9Qblh4nRnVQrwKYKGjRj9fDVQiBsbstaCQJzh6EzH15nkFupYpEsgyuIFN/WFWcgHa9D/2wE5a59hFa66OZxUNk+LMz7jWSbtC/jPlYIlmjp+vio9McRhN0gSjzJpYznyFN+MfhhRh1nggDjikwEF0mtDVMxkGFTUn04/yBqi7S+qIK/FhZ5sB2lnkjbCJTZibheb7kpK4/n5bBc7XzMkmLhBMB/bKiT0QAQ3tzRICuPImJqV4mctfJ2e75fk/3XMY78fyrYFYFCSV2EpCM8Xi2Nudh2A+kS2MvGvU7mR4UOtUDOpoHeRtOBO5nQKT1ELFp2nxxDsWdwdS5h+DwnRFUbo4MnhOI8lUI8ROCNwfG74mVpzhfFB/lLGHwQOEPw==;5:ThtPDR400NsSg0J/jSBOxR942fYilcao9ZnJSB63IDg4utrxbzZSNKt8tKQ33bhsDrecuWGnn5FZYSIsUxwREd5FPD6y3SRyCQybGuZC0Xwk9p4Ug1WAxAu0WwHr/UmqD0NPHFkENNwEoan2fZvtAsUm5oO0hARuS3oUUTlFHrI=;7:g818g84Pdg85Ds+HYi5DbZ8xzyp+mtOxGgWTZ9A3MgXffjJb/2kkHQGAR+HM6GBlZTVr3CUx+9JjD2+znFVYc4YGDQd3QGHRHoFRDbRieWT1SqxNilz0puLmamxJk058NrokceCCjDeXpOZubszwUw==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2018 11:13:44.8985
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99784bdf-8ccc-4983-bf9d-08d6577e0fa4
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4463
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When bulk streams are enabled, the udc/core.c starts
the timer for every request queued. This timer needs
to be deleted by the gadget driver when a valid stream
event is found. This is done to avoid the deadlock
situation which occurs when streams are enabled. This
patch modifies the code to delete the pending timer for
the request matching the streamid found in the event.

Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
---
 Changes in v7:
	1. This patch is newly added into this series
---
 drivers/usb/dwc3/gadget.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 9faad89..319a3ed 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2438,6 +2438,28 @@ static void dwc3_gadget_endpoint_transfer_not_ready(struct dwc3_ep *dep,
 	__dwc3_gadget_start_isoc(dep);
 }
 
+static void dwc3_endpoint_stream_event(struct dwc3 *dwc,
+				       const struct dwc3_event_depevt *event)
+{
+	struct dwc3_ep		*dep;
+	struct dwc3_request	*req;
+	u8			epnum = event->endpoint_number;
+	u8			stream_id;
+
+	dep = dwc->eps[epnum];
+
+	stream_id = event->parameters;
+
+	/* Check for request matching the streamid and delete the timer */
+	list_for_each_entry(req, &dep->started_list, list) {
+		if (req->request.stream_id == stream_id) {
+			if (timer_pending(&req->request.req_timeout_timer))
+				del_timer(&req->request.req_timeout_timer);
+			break;
+		}
+	}
+}
+
 static void dwc3_endpoint_interrupt(struct dwc3 *dwc,
 		const struct dwc3_event_depevt *event)
 {
@@ -2477,6 +2499,9 @@ static void dwc3_endpoint_interrupt(struct dwc3 *dwc,
 		}
 		break;
 	case DWC3_DEPEVT_STREAMEVT:
+		if (event->status == DEPEVT_STREAMEVT_FOUND)
+			dwc3_endpoint_stream_event(dwc, event);
+
 	case DWC3_DEPEVT_XFERCOMPLETE:
 	case DWC3_DEPEVT_RXTXFIFOEVT:
 		break;
-- 
2.1.1

