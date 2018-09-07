Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 704B1C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 13:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1175C20844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 13:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="2QXWCdAn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1175C20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbeIGRzz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 13:55:55 -0400
Received: from mail-bl2nam02on0067.outbound.protection.outlook.com ([104.47.38.67]:60888
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728918AbeIGRzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 13:55:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WBdQVqAOhfwLm7vK38TBj0g/sb046/txG60uXR/SF5E=;
 b=2QXWCdAneqaco7C5xElTgIT3DI8E13L3gDIn7cYzNTf3oMQ7CjCTTxucqyrdAq98V9UCOPaTRae9BHNCNRd9jZBoQrXW8+epFYVxdoKIf7gphpTLikH4HbjYVi42FfsAsJ7AsrtkI8H1x/MYd/mfaF9gBYuhDNFYBD//rGi47R0=
Received: from MWHPR0201CA0056.namprd02.prod.outlook.com
 (2603:10b6:301:73::33) by SN6PR02MB4941.namprd02.prod.outlook.com
 (2603:10b6:805:99::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.16; Fri, 7 Sep
 2018 13:14:22 +0000
Received: from CY1NAM02FT041.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::208) by MWHPR0201CA0056.outlook.office365.com
 (2603:10b6:301:73::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1122.15 via Frontend
 Transport; Fri, 7 Sep 2018 13:14:22 +0000
Authentication-Results: spf=temperror (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=temperror action=none
 header.from=xilinx.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of xilinx.com: DNS Timeout)
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT041.mail.protection.outlook.com (10.152.74.156) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1122.15
 via Frontend Transport; Fri, 7 Sep 2018 13:14:19 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fyGaZ-0000KT-DO; Fri, 07 Sep 2018 06:14:19 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fyGaU-0005mb-9g; Fri, 07 Sep 2018 06:14:14 -0700
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w87DE4tA019314;
        Fri, 7 Sep 2018 06:14:04 -0700
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1fyGaK-0005l1-3m; Fri, 07 Sep 2018 06:14:04 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id 2BDC260493; Fri,  7 Sep 2018 18:44:03 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Thinh.Nguyen@synopsys.com>, <v.anuragkumar@gmail.com>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH v3 0/8] usb: dwc3: Fix broken BULK stream support to dwc3 gadget driver
Date:   Fri, 7 Sep 2018 18:43:41 +0530
Message-ID: <1536326029-16327-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(136003)(346002)(2980300002)(199004)(189003)(106002)(106466001)(356003)(6266002)(305945005)(5660300001)(53936002)(2906002)(6666003)(316002)(16586007)(39060400002)(63266004)(52956003)(54906003)(110136005)(50226002)(486006)(476003)(2616005)(126002)(8936002)(426003)(42186006)(336012)(63350400001)(81156014)(4326008)(63370400001)(36756003)(51416003)(47776003)(107886003)(36386004)(48376002)(50466002)(26005)(478600001)(97736004)(90966002)(14444005)(103686004)(8676002)(186003)(81166006)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4941;H:xsj-pvapsmtpgw01;FPR:;SPF:TempError;LANG:en;PTR:ErrorRetry;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT041;1:b7zz8uLTV07UlSHvff+Sr1Y4aPUcxR3CSjaV/eK1O6XJV6Ai1UDbDLTmgSslpJv+6ijODo9sjJqMV72ryS8W+9iI1tlJjK3heq90P4wgZjSJg4O54B0nRZnv2DigHwRL
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b0c8319-2050-498f-d5b7-08d614c3d285
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060);SRVR:SN6PR02MB4941;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4941;3:7pK07RdUctLrktJf22l7Fq/6MD43nS+0clKxuqtRJqGqcvd0uFxb9BRm7F6fFS9wmdVR33/55NRwuF7jqvB/t9urQ8gfIzUpUHVYmmwI7nvyka4Ou1dbwxYwURE3dD9/RAqSeFfnfRoqpIdedtM/J6q5e5+HBLBF4okgvet87f7ePgMClxm8bIhNQAM30/bz8pKeHbDJSq4rw4F1J6yyET8c9tMf1YhiccJuYdNoZe2S4lsL15ywc+H6Gf9s1nOMjJb3lBZNE7/s8nVgQsqLtS7z4n4WafDUl/s3AVNWI247Cv2pyPlr1S53wNAJ942026N+5wc88WrlyVG5de1HAyDARoTpYsAxongD3b3btyg=;25:zWAO0AQU75W9kRvKEil4Oo1hOA6Pgn8e1nUAJ8QYwHyk2FdDdfxTTdurqvv2I/Xz9CeFbmdszlX3RSPYjfMOEy1iAR/QMmWjo4gCNUWszF6XUcS1ITiWCP1gomJOVL6JXtFUz4ko6+ckADspeFI2tgbV6sorvQ5suX9QOY4xry0f5UkFV49zfftTiH2/tz5/KOd4TdyAnTI52lh/EcJzgJQZqS97mQtVfAlyHkkPOQijX7Q5CuD2UP+D6hm6MvfF1MdJMdnDda/TnNOqrnN2BJw6lIPgUMBW+f8O3k6t2d8fXTenjLXSx64TyaEKYuN+Kr8/ndriaSIjcaRtrSFHrA==
X-MS-TrafficTypeDiagnostic: SN6PR02MB4941:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4941;31:1PJIOVucbNH7UOc7we6qp8EIqHYFRCIYkMB1TLJ3PVr0qMcOBDmShpp4ge6ZlUm3PvLAqh4Ir2ti0RrhSjOwJVqL8uTRLpzeEeuOSddNwoz9vnDaVkx/dY/cJEz7OaugBAVpJ0iyLTx5inQeFLTkQw4RPJx4ujHAteg45WK2S3NWOxEdWO3pDy1GkhEjsmVBjky04fumw4+KDKoQxgSt5jP2fVaWzdMlCAmu2RKUUG4=;20:5zHSupR7r27pWz4CDVfBv9+igZpmi8t0aHWcOJbfg88qwSy7syJfHGDCIPCzbyGtNhRtcBAnEOPPfqmlKhUjjoDkHTSJ/qtvA2N31ho8YZQd5FVSdwGvmJxPpmfWX51UGg7y40N/hLkJroU5bgaPyeoGpTLUZybR4IsO4X8dJiD+P+kLvtVAOB7LzRNFXUevPKu0q+mqrM1uFvXBNnpZMVUwUM9WDiFFoGsC/citabVnFueyAjn7y//2g4t2BICpp/GgJjK10v1dGToS6TOto2qUqeKU7Bmas6uqwMSy8tYbW09F1zRLOR7FPZI9h6vJJzi8hDN4g4gND47qHnJ6quPRtpt4xIhbn7flvoT2AKPYSPZ/pwTY6cwv3+1of+KcnMtNiibi7bbJsvdoaqoU8v2ZgOxfEkrEzruOvFyrl3jX+c1/4HhcZx8KlrLlNVN2E3P+cxU7Zg7vQKa4Dfkp3bR9Ck8gdzovtyzva99RKxEba5xrSDGMlhGwFd2uPerm
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN6PR02MB4941F681CC856645C4E5175AA7000@SN6PR02MB4941.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699050);SRVR:SN6PR02MB4941;BCL:0;PCL:0;RULEID:;SRVR:SN6PR02MB4941;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4941;4:O4st/jx9IWbXbYeA+nwSMChBdSWA5IVIInJJEkJEabHFn9ajHdcXxjbuBNu/IpSCpZ2iM/63KE2IZATiV+UxiPVq8ApddZtOEQ3/XshCl6C+QptP+a8OVkKp3zRKJoKdY75AwYSAA/RgrSRhLcusVRF65b4WH8AChVgeal51aABQcQG0d/zvAA7RFcyqFNC3l6Wvhcs0TFLeJNwJCadAbwnvzVHaEyidCNVWPZ6CLZSfdue191f/1HtmVFo0UIufIkgJRPMM4WI03fDnBslvkw==
X-Forefront-PRVS: 07880C4932
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR02MB4941;23:Zm2nbw+Xdyd0dJtyjLbPlUGNn3cHio7Iebj7lYGUt?=
 =?us-ascii?Q?G79pG5m0mGbnxGyLVg5r+8h+zqlpH7+zCTe1Xk5f9cutIPWCicTRb+2t3QtT?=
 =?us-ascii?Q?ykdptZlu73sElluI7zTzH5sQMcXEmk/Jo19iDeiJh1hIvPbFMv8Yln6QmxMn?=
 =?us-ascii?Q?BBii0E37UTRO3dCl4o1EW3zt99fXJOzxJ1RRLmJC1CcuJqwS9PLnvK4boo08?=
 =?us-ascii?Q?wesWpmELLXAwG/J0E62kLzJISoXlrarjKsg52yHM0Ufl0FVt1QAQ9cSvX1b4?=
 =?us-ascii?Q?r98Zcad4n7uu1qLtFP/8JEHYLgSK69NKcAeIhgGtSX9Cisz76y06J9GyyAJS?=
 =?us-ascii?Q?+AlbQeBd3juG94ZWCrR37dSIY1BQW2y/Q8FpyU8VwaLkY/qP0eVpDOgIrl6G?=
 =?us-ascii?Q?quu4+92GY/Vvv8X7Fy69H0vim5YVGWUKyA/GslVmZdmFpNnWwdhOepPX3aW0?=
 =?us-ascii?Q?1BqHgPT10eGF+ODA6PEj/UBXyfvSLI7Iv8PWFtzuPn4Krden/GTbZWyMEglR?=
 =?us-ascii?Q?o5l7V23qz2uTBMgZ9Yv3M1ZSK6seRK6neJGaTk2QN0v5lSjuHB5iyww20mDa?=
 =?us-ascii?Q?hjVQvfBTeyXEkzr9L3/xZoaT9fGJryK603XDM6mgjFr8QI+xWRUh6RSpK4FV?=
 =?us-ascii?Q?oAkVIyu2WxiNw5NgE9GggWzvLlYLNt0bPArqWsiLcFdRud0Q88Hf5JVnnZ6A?=
 =?us-ascii?Q?U1yhMvGQ0hdbs4Uphc8nMYINCZWZhpRtJqQYHBe0vhETalvisjK8ZtPaA9gE?=
 =?us-ascii?Q?jCUUgAwgRIq/3FCLdc4qBAFed7joTU7vEoEDcm3jAjYGJfV1rexGFdeAlyQ6?=
 =?us-ascii?Q?uXlnQ3SsL1h/dIKQPPUAGkAgqRNyBMVAhcjWVDrM3geHnwtTfr/8PPRnRGzp?=
 =?us-ascii?Q?vl0aaGqA0FLHoZR5Rlj7yV64ZgOPSFw6S9sGfNnhPvtByNBV63igxAB72/o9?=
 =?us-ascii?Q?YcmlKzqoxQpNM9O3yQTQc/bSbUJplkAVrVaX7z2YxSDTMkKMqlfniSOxfnUn?=
 =?us-ascii?Q?BqSM5y5QEYexgFLItt0ijw32eOkXltvTMBiNb/lxjI9AMCBCEQDfTz7/tkqj?=
 =?us-ascii?Q?AI/AxVfTjlIfmNi7bDC9FyA48FlnHzIcrbZiL8btMUljZ8SYjyxBCCXRY5P/?=
 =?us-ascii?Q?M8e4PZqhTyjOoRzBHhdbsdi8Oiq+eyccSUvlew8Bp9H2oHs5PcjFTJBPf2Ug?=
 =?us-ascii?Q?Wo9TNmAI/55cjQb836X0sEhksb/m6Qeyvmc0/FfSWOV0MbsGagw7Chndg=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: r/Yu5Llz3q43ifosY3qNvnaHi/AaXVE0+XsqhX7kLKB3pYTEOheff5p3UjCdPG9f7P4Q+5zSK9rYaoIKxhZjCrXxKp+MzoiZdnYDioP8Vp2x/guYJoGOyy+UXuGWYU/12GGFePSKGPQKS8+/pFkBLzo5UxQ89TXz6uJKtIIhT4EaBCPlrQgfo6paAue48ypXOuuTxK5CkgMz1RqBFyTozC5S70gHMhktvvg2RRJW3MCbtGkIQ3sVD1XwjV5b3liKvNXL4R+IDVVoKrLR8h5Q2uyJA2snxkrKHSv14RQhKcHa3fJdTw2GcjrzgRs3g88t4jnNQUAxhu3GyTr4JCc4MRhGULu4v9wjdIHBFZ9DmCc=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4941;6:1SuWgdpEgzOPcT4pYJmehjxsTcuH3xMbkKqT8k48tsc7Ej7lOzNxg7nA7MAAFxOrYQNnrC3uQ4uhIFK0JMRPgsFnmhWXOxcnV7/mAQpWygezEM2y8eiW4h+9Ff6IZPQ+Mw3nMjBHoTjLSGHbsd+ROsBWTkSBl1J9VGUs8IRGRBvD00loQBQQFnxZ3fgZ38oU8/SHUpxDre/TtTEd8ub3FMyM3foJNh4jZAQw2G9OHgFtfQYuaiIg+WLPrqpsd4LOsNiZtRtYNX5s4xOMO0kznWXkW6s/cukMwmQiFFYWKXNtLmHNFSfAB1z7jD4eBesPXlPK676JtTvOzr4FetVJa1s45IQ+eq5GmswGi1TlxUGBmkjlDcJen81hEBWH0lAc4DkazmqSKKs2c/rR6kiwg//JX7TzyKC7RVZWo0G0hYr9Qt9Z1A5Ojwhgf5wfHcGEA4s7dGeYya18WRU5N3h4GQ==;5:+Sy/ckfq9+Pqiq49ryg8DyDohtoZHweDYze4TBlu2ItlB10x2QxHR1khmQnt4N9hKRaAyh+9Ca88JObOVAc8nAb2Ig4MiTYQuUXZP1zyQq65UPxu30OiYpaAo1d13gn0+/kLbUzE5VddL9rka8AuFdE2kzwImgZfHHEmgYSKhVo=;7:SelK/est2J1pXb5CEhymngCJ+KO3MSCfzw+Bh0rwuAoZKkSe7r2m+E8A4ZTbiHvoZWjosLwib0nRXChOcX7ULyCf+UcqhHx9C9ICJr/yY59mCI1YbWBRaI9jR6v7XXAnAQzvqjrcWdZF6Rgwtele3+z0Lx+VswV1dr4bFnpccUrf6HOGBdNx5q1qSLfKTqwnV2xWXdjq96V8dQIZvrC8BJGr4XiVboI4EhWErqjMJ2+X/M7iX4OWrAy+3koByFhy
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2018 13:14:19.9074
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b0c8319-2050-498f-d5b7-08d614c3d285
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4941
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patch series fixes the broken BULK streaming support in
dwc3 gadget driver.

Changes in v3:
	1. Added the changes suggested by "Thinh Nguyen"

Changes in v2:
	1. Added "usb: dwc3:" in subject heading

Anurag Kumar Vulisha (8):
  usb: dwc3: Correct the logic for checking TRB full in
    __dwc3_prepare_one_trb()
  usb: dwc3: update stream id in depcmd
  usb: dwc3: make controller clear transfer resources after complete
  usb: dwc3: implement stream transfer timeout
  usb: dwc3: don't issue no-op trb for stream capable endpoints
  usb: dwc3: check for requests in started list for stream capable
    endpoints
  usb: dwc3: Check for IOC/LST bit in both event->status and TRB->ctrl
    fields
  usb: dwc3: Check MISSED ISOC bit only for ISOC endpoints

 drivers/usb/dwc3/core.h   |  7 +++++
 drivers/usb/dwc3/gadget.c | 78 ++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 77 insertions(+), 8 deletions(-)

-- 
2.1.1

