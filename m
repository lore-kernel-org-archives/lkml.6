Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36261C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 13:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8F0A20895
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 13:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="3Cdn1DMF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8F0A20895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbeJMUwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 16:52:38 -0400
Received: from mail-cys01nam02on0054.outbound.protection.outlook.com ([104.47.37.54]:4848
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726663AbeJMUwh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 16:52:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=acO2AGPMrFZvyMYZscgXE09LCT6kDLNIW3xqPZ+zvi4=;
 b=3Cdn1DMFMtWfJzq0KgQ5kWpn+ImQXOoAC7ND6ruVosQKINTeHjoNlFOUsLiNBehtitFzi/W2wVR3GC2qYPHzlvqIlIQuoH4Hp3gYANRUA3bbrNnRqojmRM5rHI6G8QqrgFxDNfOr6kPFboG1HWWxxWvNLvkXmLmbI1RhTk7tObE=
Received: from MWHPR02CA0046.namprd02.prod.outlook.com (2603:10b6:301:60::35)
 by BYAPR02MB4326.namprd02.prod.outlook.com (2603:10b6:a03:56::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1207.28; Sat, 13 Oct
 2018 13:15:26 +0000
Received: from BL2NAM02FT037.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::200) by MWHPR02CA0046.outlook.office365.com
 (2603:10b6:301:60::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1228.24 via Frontend
 Transport; Sat, 13 Oct 2018 13:15:26 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT037.mail.protection.outlook.com (10.152.77.11) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1250.11
 via Frontend Transport; Sat, 13 Oct 2018 13:15:21 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1gBJlI-00068j-51; Sat, 13 Oct 2018 06:15:20 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1gBJlD-0007wb-08; Sat, 13 Oct 2018 06:15:15 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w9DDF8k4019394;
        Sat, 13 Oct 2018 06:15:09 -0700
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1gBJl6-0007om-GQ; Sat, 13 Oct 2018 06:15:08 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id 13DA6604E9; Sat, 13 Oct 2018 18:45:08 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Johan Hovold <johan@kernel.org>,
        Jaejoong Kim <climbbb.kim@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Roger Quadros <rogerq@ti.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <v.anuragkumar@gmail.com>, Thinh Nguyen <thinhn@synopsys.com>,
        Tejas Joglekar <tejas.joglekar@synopsys.com>,
        Ajay Yugalkishore Pandey <APANDEY@xilinx.com>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH V6 10/10] usb: dwc3: Check MISSED ISOC bit only for ISOC endpoints
Date:   Sat, 13 Oct 2018 18:44:58 +0530
Message-ID: <1539436498-24892-12-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1539436498-24892-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
References: <1539436498-24892-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(376002)(39860400002)(2980300002)(438002)(189003)(199004)(426003)(2906002)(5660300001)(486006)(2616005)(7416002)(446003)(11346002)(51416003)(126002)(76176011)(336012)(36386004)(90966002)(305945005)(26005)(476003)(52956003)(110136005)(2171002)(54906003)(103686004)(4326008)(47776003)(186003)(8936002)(6266002)(50226002)(8676002)(217873002)(106002)(81156014)(106466001)(39060400002)(16586007)(316002)(6666004)(478600001)(48376002)(63266004)(42186006)(107886003)(36756003)(81166006)(50466002)(14444005)(356004)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4326;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT037;1:dfqRNQPSQsmEU5KUloyrcybCtaqrc7INDkveLJpwTMWjeIe87b80/hmri8QPB8bmlPZ+rSwQ2hNAV27UfO0KijTXJMX/Ref5cZ5oswTgCZp3n19gpcpD4os5WOgLBX9x
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9332a06-2324-4830-4adc-08d6310df051
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BYAPR02MB4326;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4326;3:CupKHAbTcfDYxxwBdveGDqKexEKLjTv+ZJFwP7TZGpSIpzLNONepvaaGjnx+MjyBwwOLS6MeaneT09zxydC83lXYDUMQfpvY0jOl/lh8j4paBrf+UEOdcQ/cAkMhsxC63PeRhRlR1VsVs7WQofzQgPols9mIxC5ObiC7/jtWddhsMmp9uZDdEwHyOvdyJTuRF2RxMXQPmFRnOkRDh2juGkVwKi+wyvdzSP7NuxzAOu7v9Ua4G6VecC+L/6fwXKSkVm9XoD58btijQirszgLObWMzzRjCHTIzYaqVsY6DNonk784KJxTKaJApxW6/SRnfSqE1z1jTLTGDu5KFOqSFeskywrNIwopdYMEv8zyWLyA=;25:uE5yMzoLm96650wd/wWjWFCn6GEUpYT3sjkLVKa3d/yuDVX9EMUdZyM6dfatL3hLB7w4a2HngG1NPJh90cY86C90AZIERsrPbo+t5SPcxhNsynottiVbW11agVdr805j68dhghme554lgcYdVVUEs1CWM1tRuTPZLQ/4P0aNeckhRRolBdP2IFBauoKvfHwgTqu/Dhpw3Dnx8TIT8Y/TKROOWyLFJDY4lLqdD/K1HRRbSJ/go9wM3mVAfa902nTdjNbjNeLT4IX+NCXXFugCxI8HQjb+JyOIOPJm8WaiAAUlQIbTRcxkR5eDdkKgF7G5n6PWL684ZQ6aAa9f+SAlDA==
X-MS-TrafficTypeDiagnostic: BYAPR02MB4326:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4326;31:LNCQ1CB7z6HUJqrwyJrSPI0kCVvDwLZbDt8stjaB08sAFP5m+nhVh8o3LSq6phWXcoeBrrbhEzQvfCbqCOh+Lw6P4PLigTQzI6MYWzOL4Uposcu1kmnEMldAp8cTo3InYDe5fM6QJ88kdhkLG1a1fpReEdM/EvyPpEXVgnOTUhmb91h2x9Cj/fBCV1a0uhVEK0/VQu3nl8rmQcszu56+ezOHKP6Nqget5gD8OwX5n+o=;20:sE7Job6LB1Ip4l+x0nYnvTXVzjW4eV0/l7FOc1PdVyCAjS0IT7ztfz4OnfI2V0dmKaxJP7pTI1pf7qCszP0g/lFlnf1j/QbzntSvASKCYa2m1j/8dXvgR1V5/D4+NMSjrX3lPD4pTRxyQrrGEKU5j8TigbdA+nZ8RdAUFazYvi6BIJFxOfi5Gr3d/8gDh5HdGHWu2tXGLHPUbrMWOEwzPNrKW2glyURUaVKTJ/pQ+qS9tVnU/B1o51qgnksA2u0nmr5d8uvdIXZQtYjPazTPHzbq839vRo2UbB4jAqCFDYtz+X4IJoc3dyj+E5fQSsGzZwZX1TGXDeGy/lKpTZ327KrfSpf0xAY5NjWJ0t+T7eABGiI8XjqM8F8RS48MwS8Sp7eq6udR97iq+XYYYQt/EaCabQbH7gSXH1gKlpWEhFkZ0tF3BBGeJ10hqr49d+izh7ytiW4yTCUV22wOAhLRMaTm6QVbpNGBn9VDFXnmistxXgZ3JdyK9MU/PXt32bip
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB4326E087DEFAFE4096ED7C97A7E30@BYAPR02MB4326.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93004095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:BYAPR02MB4326;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB4326;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4326;4:8pCmYraSOW5PmokLdbgRp1gQ4HuIYNN2vwXGtxlNe1arq4P50JmSG4bfPxrtsPEqrHdDiTdfUzeyvRdSyV3uBrU9obHg5IHisNyEBluEwVKiGNcjsOImK5k3q2GpMlWtuYClWegvlrXctS2WLHgsDe2Z6MuPm/gNpBp3riEA6WnXf5skQWFYvRuGpIYPOBf9OkxSeE+xq7EQoS/wvcTGLEz9PB3zzXqMs81cdwGIEwzey9VP68IDhSfiSczvtLZqm8u8qEPC3APhoRyl6/lntmRVj2ZxP/V3nw803CrNbHZeqFWpbcQqF53OmzpWSKbi
X-Forefront-PRVS: 082465FB26
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB4326;23:fd/OjZQcZUj7dFMCb0P+2yMBiw8wJb6XLzX6FKj14?=
 =?us-ascii?Q?QPDilFfNy3p87zhKkKC5CjMCdO0ZwcV6c6U3mJ2Yt44saI5nojzZc+em4qI2?=
 =?us-ascii?Q?lNPcbkuT2crBlvPs5lD08hMdm9L0v/JZ0cI5S5nBcQ7RubrBh195XEa3Kdtn?=
 =?us-ascii?Q?P4bLw42UF+eQ9ZlZXxrLCv/VNf/bI4njcOlhH/aXdVQuQFH7gin9M93mqCVj?=
 =?us-ascii?Q?W/UkVE5jZ19iUFHmQ1eF5v/KSqbMl5WdgGn8yUZD3WXpysYXRedHV/8fRfX3?=
 =?us-ascii?Q?slXnPwZWi77ifTOcDJUuxJzZgSaDwhGIEme0s7paK8UGsfa7tLgvaVilBeyD?=
 =?us-ascii?Q?t1K5kEjklJCvIN+/uR8syAiPo4sbUQD2o1djbfBewLYdS1C2QLKLEUAwoIYG?=
 =?us-ascii?Q?BmJ0NohmEwhK+muQL7yUvyRnNEKXzZYh7y8ArdtIVXo6e/zbvHmMYd27pXHJ?=
 =?us-ascii?Q?h8pZp8xyj8ouXuqEqgTt2ZsKOwtpzBttuPt83Q4+QEwlK+8suW+1QO2HW5Ke?=
 =?us-ascii?Q?wD1xiaIsbLxsXivR9gjQw4eOXvpAjUH9+fm8j9EqYf+tm1p1palLxBLjJHpI?=
 =?us-ascii?Q?Xu7dNpwAjVSgnHzk6hn4y5CqlyxyI/IEGe3LXgjiTiWQqkjeK9QoyeHPbBB5?=
 =?us-ascii?Q?l7nuWQgEck2hpYCiiGzbAn9Xek+Ux33grtTnhS0O1eES0Jcelp/xMutaijHD?=
 =?us-ascii?Q?BDa6Ya2gJCbHDqlyU6IafZn+vy+nGaRniHwOEtZgkaTLllKIQUOyDqwlQbw/?=
 =?us-ascii?Q?H96yy5zO6isC1cXOVK3B6NFZanxbiay9f/w8Imzta6dGOAsXFKdv/Wr4fNUn?=
 =?us-ascii?Q?FUvq/nMv//FMy8L9UTf+75xNmDCu7pxkgO3vniMxm3ebtorbGriXrDI7Q2nQ?=
 =?us-ascii?Q?wEYMJjAcuaqrV7UuQx/RxExDMjqCZCOKQGCuWyj3zNMDOhZbYP/5yigiAvBE?=
 =?us-ascii?Q?3Mcoh4w7PiuK7d9PTpK1Mv1qjF3gjKbPHj1hvZ6kDwDhrtKwef7IDU6RvEsJ?=
 =?us-ascii?Q?MsNq/+k2A/s+Q0yl2QWchn1SOwWRgfKBr9sHpZOqzWNPQzodml5MxEpU45Ii?=
 =?us-ascii?Q?gDXFvuWlYZKNitKPWJqHtgrUwxnUo+aWk4shRoV2Rr4CCl0TZDn1Bu/TaleZ?=
 =?us-ascii?Q?dSsDem3X2y7IvLSjokuZZDMtj6L+nZBhNZ4Kl+ESaTRsJVKx3l4l9LK6VuPI?=
 =?us-ascii?Q?eTDgjBg0oGUdVxzMacMkjsZ6aYMsSorEgr0Oe/vzKFrCDfXINa9DbfwEtXZj?=
 =?us-ascii?Q?+dZMMN75TrlYKilWx0=3D?=
X-Microsoft-Antispam-Message-Info: 0T74VzUEVMCbsJHzvneeB93gYJG5Zmaf9OVkZMesjgyOmTgbCtjLBGiH/LJ2TqQ1wU+YFZojnT1Zea1aooEKUP1YcNRB7hPFMx405sxF+hZZVXJpDKytriX4eV79gJuQ5FeWcfMJWufunaBeR7FOqH9B6ONg5pWUUaYTsSq5ssUHTRsCyHPjaDnZ8zP/yHwcPCiZzyenCOlKAPhdsR1UU2Dl4HDMx9WzO50uNyjlUyOXuIxZV+whRbyrC6k3rFeqyuOczFlQC24GpMm9a5rxW0eSteLxc/OapBmuqu8YQsu5e4MEvmoCR6KBoCqluHMEblBw5Oxo/fla8OTrcpDs6l6xdYoGLplamUP0Ihz44H0=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4326;6:Tx0Rl5ykGfGd8FCNmyaUS750fk/dez0H/jfCAmAfvG76qd2ZrJO0Z4iSxSdfdtwlUPFKxUYSqMTGq2dzKzdV6xP2asXgIsEF7DrFQ4THz88DrS16e7Erx72ywyzqnlwUjl67NDHK545Wx4wqpOemhes/FbxXbf+56NpCpqh153hav054p//FKBaZ3tqHQhtcNoKCc8jKq4eW3jdAcaJBOL3Kb4keFFrAC8usMn1NmZDuDH0vOW100nFAXD1rjpZEOOJBabh6xGeO55h4jl1vffXZWERhx2vt31XY+4tou1xBO2fgoz2UMWxQXZpxSht5lcgIDKcFm/vswDu3lsF3pvcplHmkw4No012QxBHoQiU5mf54Zfw3uOG4A4xoLcEkfedDKOzsVeEMLh/tLZ500klL1m7DDl+WoFemOtDwJG9sZHBHLOzDw+HaZhqSpAkRq3NmCGWtpABpKL8//wbsdw==;5:jvSIbFCXhH3k/x2715+a6RpYKtJ5W8aVBelxgtWMgWUWNJfl5miPJE3UYrOJP6Ca1tzwGCkbr7LFoXs1wOWDyvqNLHQGwKW7v4I09Su6qpX6KsqnG3F07K6GaS9IkrYUfEe6qQ7MWPYCGySvmBZhZJuJDfoSx9gjipnD1Sj2jk8=;7:AAaAAnhZE6PKFKfMA3HAnv0zopFO9yqguDgAgANmQ7bGZSwJixEnshJqgGIbsi9Xr31+JaF7S4Cpu9uvU9/fzecIH0zmpdOc/ZM2dXmIDR1IarSvFtZs1CeTrWD5HB+PSZY/IJPd5gzwZzsxKzpe5qvcrkRAODuaV/ks/7KV2qOt9kjwgEWjA2/Y67dkpvkY/esALj2ikHBjuFfo2XRnlDT74QsLa1PrVFfKtS7EI1GLLnZxQs8jsOZZg9TLt6BL
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2018 13:15:21.1007
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9332a06-2324-4830-4adc-08d6310df051
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4326
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When streaming is enabled on BULK endpoints and LST bit is set
observed MISSED ISOC bit set in event->status for BULK ep. Since
this bit is only valid for isocronous endpoints, changed the code
to check for isocrnous endpoints when MISSED ISOC bit is set.

Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Reviewed-by: Thinh Nguyen <thinhn@synopsys.com>
Tested-By: Tejas Joglekar <tejas.joglekar@synopsys.com>
---
 Chnages in v6:
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
 drivers/usb/dwc3/gadget.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index f54de80..5bc37dd 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2416,7 +2416,8 @@ static void dwc3_gadget_endpoint_transfer_in_progress(struct dwc3_ep *dep,
 	if (event->status & DEPEVT_STATUS_BUSERR)
 		status = -ECONNRESET;
 
-	if (event->status & DEPEVT_STATUS_MISSED_ISOC) {
+	if ((event->status & DEPEVT_STATUS_MISSED_ISOC) &&
+	    usb_endpoint_xfer_isoc(dep->endpoint.desc)) {
 		status = -EXDEV;
 
 		if (list_empty(&dep->started_list))
-- 
2.1.1

