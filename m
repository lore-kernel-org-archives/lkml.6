Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42594C04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 11:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9A392082F
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 11:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="B+VpVtOb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9A392082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbeLAW0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 17:26:07 -0500
Received: from mail-eopbgr790081.outbound.protection.outlook.com ([40.107.79.81]:18388
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726684AbeLAW0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 17:26:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RthYfyL+Wv/A3PuUiQjo6hxjcZxZ2Ezat6Ijp11YREA=;
 b=B+VpVtObMThG1awMt3BCoqAkT7QDz6/ndl5GefuOL26y+CGV4MC2sn4EC6PJ2t9mX934ve14caY9kKfFeGYQU3IOJAg4ESHro6SbxvyR6wnogNb/hW/ASVSOBp0rT1B929IJvk9G0sMn35dg7h+BQ0YZKAuqX0IQOh5ftxsncQ0=
Received: from MWHPR0201CA0055.namprd02.prod.outlook.com
 (2603:10b6:301:73::32) by CY4PR0201MB3508.namprd02.prod.outlook.com
 (2603:10b6:910:95::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1361.16; Sat, 1 Dec
 2018 11:13:45 +0000
Received: from BL2NAM02FT003.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::203) by MWHPR0201CA0055.outlook.office365.com
 (2603:10b6:301:73::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1382.18 via Frontend
 Transport; Sat, 1 Dec 2018 11:13:45 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT003.mail.protection.outlook.com (10.152.76.204) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1382.18
 via Frontend Transport; Sat, 1 Dec 2018 11:13:45 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1gT3DU-0002W4-Ch; Sat, 01 Dec 2018 03:13:44 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1gT3DP-0001kp-96; Sat, 01 Dec 2018 03:13:39 -0800
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id wB1BDZNw015269;
        Sat, 1 Dec 2018 03:13:35 -0800
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1gT3DL-0001k5-3f; Sat, 01 Dec 2018 03:13:35 -0800
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id 5089160503; Sat,  1 Dec 2018 16:43:34 +0530 (IST)
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
Subject: [PATCH v7 09/10] usb: dwc3: Check for IOC/LST bit in both event->status and TRB->ctrl fields
Date:   Sat, 1 Dec 2018 16:43:30 +0530
Message-ID: <1543662811-5194-10-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1543662811-5194-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
References: <1543662811-5194-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(136003)(346002)(396003)(2980300002)(199004)(189003)(8936002)(76176011)(51416003)(446003)(426003)(48376002)(336012)(106002)(356004)(6666004)(47776003)(16586007)(316002)(110136005)(54906003)(42186006)(36386004)(50466002)(14444005)(8676002)(486006)(2906002)(103686004)(39060400002)(36756003)(4326008)(106466001)(5660300001)(186003)(81166006)(81156014)(26005)(90966002)(478600001)(52956003)(50226002)(11346002)(63266004)(476003)(126002)(2616005)(7416002)(107886003)(6266002)(2171002)(305945005)(107986001)(921003)(1121003)(83996005)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR0201MB3508;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT003;1:w7b5PvGNRqsiJ2TczozfyaFFkbWubZTkHN+H52qJwg/JXkNasc8YZLO24jtV8ettnpOFhwz6ImWzU/N0xVK0FsMrFBR5NPFoHaga5bn2bZXBqUL8igJkpIh1clysVzwK
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 858c1e0f-079b-4145-59f0-08d6577e0f47
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:CY4PR0201MB3508;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR0201MB3508;3:vFjOCd2aQ2aF2UW3Q9SlukxuBJpYFwoo+YphGCSHk2c8hnCM7EL4iUKB35nkvgwvzvmoh5A0P+ntUAMYzF897iqu0+050uGqSm2YcPmspqk+1RgcKuVJbSquzeKs56Djjln3DK3Mw1pFdAnFXLF/oE6+Q8Ew4c/8/sSYtZlJZF/pkDPb/HhwaVqXPmnnGD2HzpZYCcMBxALdzIrPAZrc2mT95Ggjqs1UaKqxzv41/kub4rscmjhdd5J8S2TWVaRd2lI6k+xfdTZaeMmS3TQKVMn3BlisakXv5gYncNyhmksX/vAM9UcktfcK25X/6VA04UQyFtvDDba192p4jkN5iUAZxMrL1Y+R3vx/FY9aYCY=;25:UAAbXcKcdkHODBjIZ/aGM7E3dVzzVz09ZhEaesiIm0vk1iVA5SKmipVDHOCq1PYW8alNihckS/503LM10xeoXXX0Fg3dc33/uMO1riE0a8TwmQjZ0xS33lgMMg9TLEvm5I61u8ZoH8g5QTJKNIV682gmySg/fylOcyXQ1m7EFaIj7WrJWjukHAussgE4+L9rLcWR65H2dp3YLLMNHmhIOJR8OhbHWTJUcwyUd8jFlJzHhtYQeQunlMiQiyL2QB8a8S4DuA65gUITyCoKUZSDHzTOiMYmvWIZhOiCZ+fbGFbWtauPBxNGJ3nuqOqkswspje8giulwbU1c3xIbUf2Dzg==
X-MS-TrafficTypeDiagnostic: CY4PR0201MB3508:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR0201MB3508;31:nFevXvRlQzyTjyolCWlb3eV2rKpkwZTA/Uf3jmIMcuWvCiWBb8jOM/8Oh1hmT3N3tL62IX63eLDblyG/UznYFJgQC5H3HxVFYYWyuywEJlyQTwiNkhA6Nn/ohYLhgSrw3V8LC+cNy7sPrvP1ZTaie3kBEbJQVLzB02Z5jF7a6687+8gB5in1xG2GNvRu+zimbJT2WiaS0UH8EqiX00zziqkpel0FUEKag5BqbgLVaiM=;20:iNBkPH9cyD9B0r2b4s3l0lC3m2TLqNpd1Lr2fiKGTPpEoEUeg80buap3PS+tWJtJT4ZJKlOtEweaHMuyzeM4uVhNzDdtdfgjjtYpdMe4WvkgS+Q210tO96+J/maBy3Z2CJ0slUyHelUILsgNv3/PeuZrVacU7w6xJtLfK5MhRSnaE050nNC825U7cha0mnVdrTY39gKR7q5TE8QA5+lD9Q3VCF8ZJ7We7r7A3TB3ErBKrgfEAZf6vYzdd0hQdmfsRMcAz3D3kxFqx3Npk7QjceDxD81KIRD3cqdz2RXW+BCkwSw64CkHdCcayt8i+ul7/q9bJg3PMQzyE8ag1l6GeybkSG0c47HMcAmuo22AMROhZylYuvClOL0AiqKq+/QUE53RcQDhiAh7PvqCLIUuebx7VT20phSWxVcCC3KEHOnDWtkpyHfAiQ6YV9sk1zC8iDJXEN/77VeDF/A5l4c4VW1e38asyexcmlJyxKqtXxg+Fmtl9a3TbPPFFfW/qf04
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <CY4PR0201MB3508E9162CEAE3C337707F71A7AC0@CY4PR0201MB3508.namprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93004095)(3231454)(999002)(944501476)(52105112)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:CY4PR0201MB3508;BCL:0;PCL:0;RULEID:;SRVR:CY4PR0201MB3508;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR0201MB3508;4:6OXr+esmj+0bFxwVPPMzPahCKtkjF2Rnx7+c2Y0gDD9vueaYrCPkW56TaBhwNLjnNboXi0lLMLyHxQ0PiLbMcRWRjVhk0O3iWXA1bFdnBotQYm0e0dAhcS5PIprvDVPbOT/FWkLUHWIgjWgCWtvoVuwqHzd9SCVX4fSzdEzLevCSE3vd5GG9wei+kaeNibdTKARqwPipWTMZAWgLjZOxLsnm7j/i0gqt1s4q7vSGElcRTPVCDfIljJL6SqWr6a2n6TA7xEpPVEigAqCeKNCKEg==
X-Forefront-PRVS: 087396016C
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR0201MB3508;23:WbD3YXeyivFdC5ebgehUjl56eIhRFzVOqye+6Pu?=
 =?us-ascii?Q?ePoVn+QlEyNVGRUVde/58wrTW7cd9qsU35hjvCoxcl8/iHgrZSjc5kzFyjZS?=
 =?us-ascii?Q?kLuSZhXW5adfDWv0hgEjLuSCQgAO6HoA8frcrAx8F0o9SurAd9pU5VdDoJlW?=
 =?us-ascii?Q?IO1gYzYYbfhmfNMwUHPPT9jR5PGsEVFqCEvgbLn1j7JgMfHCKGZCul8qOEIy?=
 =?us-ascii?Q?Scahk4GVImXDP1zs8zqr16E85WNkMlLYES0rTSj9VIj1SGMfmAHyri2yi+w9?=
 =?us-ascii?Q?6I8RjKC/2wZ6AbrqR55n6oBqIy1AfbNnFrWDtI1yNxDo3RIOjoazbQI6qhhV?=
 =?us-ascii?Q?4CvysvSwtJQkdcv4TmWhtUjdAywL+VHXgoC2jEA8Cetu5C20tMTmUyziOgmO?=
 =?us-ascii?Q?0WwnhwVYWGSMYqZl0NE4ag4/hT32sHu8cOx3vCoDsBz+vuTmYCY2nKVGUnyj?=
 =?us-ascii?Q?3FB9yGlYMSNzJL0bWAXZNV2We8dsKWXnv+KUMEOsPdZ64O9oxn13CVmUQrdp?=
 =?us-ascii?Q?gjfqpiXh/Fk6B1avqqwDpKu+kPHBH0ujycZqte9/NGs6uGQbGpVaZYXXz6X8?=
 =?us-ascii?Q?zb5ciHwYPFbJAIOEdUfSva5pgJO+d7Ia+sJ37t8XlVhnLC9JF+NJT5WXmph/?=
 =?us-ascii?Q?Adg/nuOa+AcMOvjP03sCocxJdcGFKauNMsc+N6C8qfk9Ku4zs/AeXfkKUx2U?=
 =?us-ascii?Q?STZWGyTCAFTb/Y0+oXwNu/YyGlCFBorB66gJCLzD85xiyHkYKGjOPLuUcFea?=
 =?us-ascii?Q?STeL6oRUqp+JZ0Cdv7lmPcAiabHG/DVqKt3/R+bA30Byzk+3fzDDA/KCMsjX?=
 =?us-ascii?Q?odiubE4zpmoLooPNVRGlGOYIZofdpAtwYM2H7bmUL587qf/K0o+vrfvLfcEJ?=
 =?us-ascii?Q?ntBs4iN+cq2rbHGrq4KwGELahAckRzyKeYxBtvvz33WJ++iGwbHHrBZHI/Ui?=
 =?us-ascii?Q?6L2UedXfxIe+qAm8lNb+zZ1SZ3DcaYcR1L57gAvfrWY1PPXrLuUeLvUqPmYW?=
 =?us-ascii?Q?SwLVGBUhvQ5zRbrTJHJcrzJWxYSdPdfuD3qtPuk50LrONGte7YNrzgfGz5Zj?=
 =?us-ascii?Q?BrrPl9c5xvBzNbSd2T8lsa0Y+6hHVC0sDGpGIvL/LLi/7DIrj8MZBmKK+Y79?=
 =?us-ascii?Q?dULu4CPNsNyshIGjwfftxT+8vOnh77SVdQuGXf53NqnA3RS+wgg/orvwPdKR?=
 =?us-ascii?Q?+6TF5X5qBGfK7o80H3m8di2410yLsKjBBF1loReCCnWGhWXJ+oaaBjkyftzF?=
 =?us-ascii?Q?whzagl9gn7bTA6BJbn+slzlbjbxhK9a8exijIqbrwRK2q7RUze8elOw5pbkK?=
 =?us-ascii?Q?cOA=3D=3D?=
X-Microsoft-Antispam-Message-Info: NGbEj41km51EQlCGwptjVW/JFmBcYUEXzHXMeWX7eZay8tVR3/FLotYvmebBWmGYUaaYWp29NFjxcQtMYyFNcatSthXotlJuwEC8E8n2QBgDOWC4DscEpbM7Cl+9q2mtwMz60lGi5MiLrin5Q2oSpstEbOGiiN0xDFrTixeA4BO1c95sNhpPKukGQ9QvRKRzuuNWbY4rFsI2GC7OC9l6CCGmKTBZKu/jtpudqwCtnj+/j/BogrDmyNuGfPVM2iX9YHwNbYzfEZrc7b/c0EqmI5plbHO5H4Nz2lUOKrVUDoeYXdrzhx0dfs3QSHDJICXqGPl/coGWM8bSNnnD8H6HRKoL7MfSc7c20W7sZpazKvM=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR0201MB3508;6:9xsQ/nvEYZlcW0ky17sG0vGtOkcyk+Y6laVOhEuiZGvpZRCK1qRkx/kHumc5yj2qrQi01IUw0qKvLg88/Iv1DAfD0NbcxrirIg50bhaB+x9POnKEHj3cPZB/HgsM87UPr0OsP6nM6rdCzYqSk9/fn41oFAGmKmlj8ZsGBoiVmoos1H2Q4wEaL/XQ1A07aN735xq8ivLPqver/KY6AWqZtgzz10weQfPddm+gq0FkCSIP/aL39CqJwobDs8ZRz3d2R5hwmSThri8ISvbcjzntgQQXpLjkrzrKuKLBQcOvyyjf5pxG7xYm4IthV9gzSSK41CFputPS9evEmmh20R2ZiNO6AzXj9SRjCJ7byB0I/w/zZxGG4mS1KGN51f8y8BhAUkr3k03zV/m02aPSY30mvAJ4w190pnkrdKMDa1HVAfjxVKqhTF1jVYVr6HvenmGZJdxnRUsVm1KHZZKHrPeHew==;5:GPZ5gCI+YVK2isFFFJbXWipBSJ+id6Nq8sdY56BwiyDR6u2sVVHb43UoTrd10HlPEfoT22SQR8dZMPfS+ywHQVK1XxbUFZD7CepEcAdPUdPSNGSt0GaB9qgjVCUECzR77u97lHHJmH1zX3r297l+b9Yx0B2AUThR2EL7+DJHoG4=;7:K1+d0Ssc6g2oGY0oDw8dQcsBF4+9ZYfj6fhXcMczlgHqoutej09/5TkQ6WQ3FPPMumz/WNtA3hgGrg9D0HMgZGlrp2ajyA6kTj2rFSXYxZoLQ1CA5t7EjG4QxxpY7T37EyjeAMignl8pYHFMcfSuZQ==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2018 11:13:45.0833
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 858c1e0f-079b-4145-59f0-08d6577e0f47
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0201MB3508
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The present code in dwc3_gadget_ep_reclaim_completed_trb() will check
for IOC/LST bit in the event->status and returns if IOC/LST bit is
set. This logic doesn't work if multiple TRBs are queued per
request and the IOC/LST bit is set on the last TRB of that request.
Consider an example where a queued request has multiple queued TRBs
and IOC/LST bit is set only for the last TRB. In this case, the Core
generates XferComplete/XferInProgress events only for the last TRB
(since IOC/LST are set only for the last TRB). As per the logic in
dwc3_gadget_ep_reclaim_completed_trb() event->status is checked for
IOC/LST bit and returns on the first TRB. This makes the remaining
TRBs left unhandled.
To aviod this, changed the code to check for IOC/LST bits in both
event->status & TRB->ctrl. This patch does the same.

Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Reviewed-by: Thinh Nguyen <thinhn@synopsys.com>
Tested-by: Tejas Joglekar <tejas.joglekar@synopsys.com>
---
 Changes in v7:
	1. None

 Changes in v6:
	1. None

 Changes in v5:
	1. None

 Changes in v4:
	1. None

 Changes in v3:
	1. None

 Changes in v2:
	1. None
---
 drivers/usb/dwc3/gadget.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 9ddc9fd..216179e 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2286,7 +2286,12 @@ static int dwc3_gadget_ep_reclaim_completed_trb(struct dwc3_ep *dep,
 	if (event->status & DEPEVT_STATUS_SHORT && !chain)
 		return 1;
 
-	if (event->status & (DEPEVT_STATUS_IOC | DEPEVT_STATUS_LST))
+	if ((event->status & DEPEVT_STATUS_IOC) &&
+	    (trb->ctrl & DWC3_TRB_CTRL_IOC))
+		return 1;
+
+	if ((event->status & DEPEVT_STATUS_LST) &&
+	    (trb->ctrl & DWC3_TRB_CTRL_LST))
 		return 1;
 
 	return 0;
-- 
2.1.1

