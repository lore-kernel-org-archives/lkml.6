Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C624BC0044B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 13:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7710320684
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 13:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="SoYNpAV8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7710320684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729433AbeJATzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 15:55:38 -0400
Received: from mail-eopbgr730040.outbound.protection.outlook.com ([40.107.73.40]:45782
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729277AbeJATzi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 15:55:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8vD4Qog6JxJVXE+eLJoYrubjAM1oQUL2LNxd5A4lOs=;
 b=SoYNpAV8w2gg9vkUly2vSqDcLSOnFjHnCumkKz8JzjqUU+qK4o2XWlGFgLGZY9Z1Ts41OhA8P5ayDu+OYwsIptCcNBhhafQOdeBW+CSRIzQpG5UJpw5TkL2ZeK7UgKOBpUMG3ASZYaVe4rey1rxu3qKZvKIK4Mao1gGY0q5rKkk=
Received: from SN4PR0201CA0011.namprd02.prod.outlook.com
 (2603:10b6:803:2b::21) by SN6PR02MB4478.namprd02.prod.outlook.com
 (2603:10b6:805:af::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1185.25; Mon, 1 Oct
 2018 13:17:47 +0000
Received: from BL2NAM02FT059.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::208) by SN4PR0201CA0011.outlook.office365.com
 (2603:10b6:803:2b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1185.20 via Frontend
 Transport; Mon, 1 Oct 2018 13:17:46 +0000
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT059.mail.protection.outlook.com (10.152.76.247) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1185.13
 via Frontend Transport; Mon, 1 Oct 2018 13:17:46 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:35867 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1g6y53-00007f-VB; Mon, 01 Oct 2018 06:17:45 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1g6y4y-0004H0-RS; Mon, 01 Oct 2018 06:17:40 -0700
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w91DHVRH014329;
        Mon, 1 Oct 2018 06:17:31 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1g6y4p-0004F0-2C; Mon, 01 Oct 2018 06:17:31 -0700
Subject: Re: [PATCH v3 2/4] firmware: xilinx: Add zynqmp IOCTL API for device
 control
To:     Olof Johansson <olof@lixom.net>, Jolly Shah <JOLLYS@xilinx.com>
CC:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        ARM-SoC Maintainers <arm@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Rajan Vaja <RAJANV@xilinx.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1537985581-32164-1-git-send-email-jollys@xilinx.com>
 <1537985581-32164-3-git-send-email-jollys@xilinx.com>
 <CAOesGMhEcMB4caAPtCSq-m5zQBDc-8Z4f_xAkomnEwVaHyX2Mw@mail.gmail.com>
 <BL2PR02MB21308D0B6AF76A8094E70863B8EC0@BL2PR02MB2130.namprd02.prod.outlook.com>
 <CAOesGMiUnVrnW1VDh1CKRKGpkwAC9G8tiHjpb+7bss6LpPWU-A@mail.gmail.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <2350f5c3-b59e-b37b-c679-5b0a36f9a79c@xilinx.com>
Date:   Mon, 1 Oct 2018 15:17:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAOesGMiUnVrnW1VDh1CKRKGpkwAC9G8tiHjpb+7bss6LpPWU-A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(39850400004)(396003)(2980300002)(438002)(199004)(189003)(51914003)(229853002)(316002)(110136005)(76176011)(50466002)(9786002)(58126008)(106002)(53546011)(93886005)(4326008)(54906003)(446003)(217873002)(36756003)(2906002)(36386004)(6666003)(6636002)(230700001)(23676004)(2486003)(34290500001)(14444005)(31696002)(8936002)(305945005)(126002)(44832011)(6246003)(65956001)(65806001)(77096007)(65826007)(47776003)(6346003)(476003)(186003)(26005)(11346002)(2616005)(106466001)(8676002)(356003)(81166006)(426003)(31686004)(5660300001)(64126003)(81156014)(63266004)(478600001)(336012)(486006)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4478;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT059;1:fMKQ7LfwF/Z+Nxxejd4q//5A6WPjkfgQScwAZgF2bV0KXEUr+JERhjsVP5KxiPXcvpDhC1G9sRtLDiZxSB6/1mtgbHMMH7YnrsWU9Gfq18ZuJZgyY6KNDUm23cQ1P/3l
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6de09478-89b9-4288-f9e1-08d627a04777
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:SN6PR02MB4478;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4478;3:Wc6SQwzY+RwqIBEYhV+ZnALP5m4hcNSkU413+bedEZoy+lBTpmZ5mQnTFagfF8V2fUpejysub+DrtHnCc+FfWZpI2a3+wlmFTxSIQ/x1pl8OcV6FIju3Sdh7yx6zjXRO4k2vLVwNTFX9vjj+V9bO5Z+xXJHPd8RFkj4XeTC6D1GtZpcXkCg+fUIi6ZiiBE6uGJgL57qtbgHr5zLEWbA7K7pIOEEIo8wEKNmyUhwsOQxCQZfpSEdXDmT0jUJXI8fYbtWwuMzjx+Tn1yD4j1UnYHfnyo8FIYi1CL1CBueo7qB+zT2izd3HrjKnvh9AyVwgNE7ycn4n90xvpCYeJOmuHTnqRhw/ceb0c0769TVwIMw=;25:lsPCM6k/OkLXQy8wEuybKMADCetAYZckRtWj1Jqxf6crVNyMMYusI6lzq/A2GU1BtAj+2buapqGwJAzF5RYd6rlaqMW26NqBApnjPj21BoAVvVAzE+6JiwnlIIQgmCXPKuira5t+e012FEjbFhdu9qnY4PyGV6bJP8ECeC9bg5XaMhc06pQxpLPpg0j9qR4sXENpFivdxyFgbSHm6FDZ6l6HZbDxJITPCbGRrxhda2UcvMiL5MoC/FixbMO50h9TYaieKwfVWC9otGVCjvsws7pZhk4w/vJjAOYgqXJKd7OxmCyRQ3C7I4yZvs+jihEGMx5Bsmjf5+ExfGRc1JuEmw==
X-MS-TrafficTypeDiagnostic: SN6PR02MB4478:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4478;31:pMtmrwSKFgxxiHe49RF0w1pUfILRy9eiJsRwTWd1wN2EbtWZ5AoOHyA7fR95IGxFHx5TOkQX62k6D/VHnzOnMv+cE/DN0N8kVjbd0xs4kUusOEZl/ucxwcP5uf5zqi39F1f9vSKurd58HVrIvyDRdYmeYzfGj+0heB1zALWocmA2hiSfdRbL9OsLt2CEUCmRnH4cqyBmdbkWAUSdKz9h8oWZJ/CZqySA68otR4YTgSo=;20:0CXMUtHGGBSY3LChBh1u1L3jBp99TcfT+sP9Bzx8T86N3FCWuxh25qc95UGNpwFmVPR6bh6/nontHzH5eF1v31RGaTXZl4fBKadKnf/2AeQuJUb1WK7X8EwmwWYZDDRcX/uTK4n415ff/3kZrz6R0S0oC4IgWx0Z5pkrySmFNaP9uaKyfqzY0qdmH5dkI/Zmfnd/PCDPGX1TfXqlxiAUphL/8FxLO5it71rtleO5V46JNgKc0xKhzhGCPxAaYGXTS9oecBPhqSpLNOt0UIxA1gWBjf4STLd+yiMlk48NyR3yOSva0jk3uEr/K+LECu22lwpFJhmwIGtfzItCf3Ff0ySeO8fh81NmyzqA7fZnAffisYKUaKZO/fUXju1I05hZ953QGx+UcM1GHgTD7FLUpW5DjyUBRyHIV/g9bczj8FSya6jjqzqmBZIMl4qO5YH/hsLhbTlRfZM6s+vMdOFVzt5zWWhqpqQShYr4+hVJyWNcY92w6+pNo4RYI2xxu08O
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN6PR02MB44789FEF2D6260BC55D51E78C6EF0@SN6PR02MB4478.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93004095)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:SN6PR02MB4478;BCL:0;PCL:0;RULEID:;SRVR:SN6PR02MB4478;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4478;4:C/NLV4IaGfDQL3G4rW4cfFm/SK35U8ddjuIrzt5sA8AmM+Afb3iDoOWJj2x1fnvkPucZS0Yb9dzTPjpE7mUu6F40diN9iPFybPoBCRGY+OKdVnKt2cLHUhGjOHq3HpvB8YcQX8PJ0Bj2DW7Y4WTz1+WY0L5Gr13JG5H9qeBGuLs6gr7uTnJFhPpjcgyTjA3y6el1XtKMZn+3PcsdUn99Jk+0htiEYH6uY/ntCaN1ApfRIn3X+ferIuIigscD5EUVp1LpZ0Xy5fAecj2Iqyop24PUeKGLYmml9GeA245byFyRf8QGxAqmC2z2Dp3As4u5
X-Forefront-PRVS: 0812095267
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjZQUjAyTUI0NDc4OzIzOklHRzlzMEJORkhEODlyVlpCTjVWTFE0Wml5?=
 =?utf-8?B?d3hzRWJKQ1kvV0cydlE4VEdSdG14S0kreDlvRm5PN04zTzFDZHR0Nkwwd2E4?=
 =?utf-8?B?MGY3WXVsQUxLWUxpZFRTckJPZThFZENvRGsvOGhYeTlRbmhRT1ZZVjIvOEpp?=
 =?utf-8?B?VCt5bklscmtuV2M2VzdDNmNFLzFTQlZtbTlSaEFHQzU1YlB2TThPak94UDJX?=
 =?utf-8?B?WlB5TCtuV3RNZHZacjNIaHIyc1kvaVhGck02b0VoQUFjQUU4Z3BuOWcrRXZp?=
 =?utf-8?B?R2ZxdDZaRFVyL2Y1OGtPVThVQ3ozeG11MDVjMnpIa2ZveWx2aGVRMCs1MFJM?=
 =?utf-8?B?dmE5Qlc1ekxlK3hwaXJPMXhIamp5ditMSmlOTWIyTTJFMG5XT2hScElrS0JO?=
 =?utf-8?B?b2RNMXRoRTlkM2tHN1VXa3JTVzl4RWhneEU4SmFCV2htK2dJcjQ1eTU0czZw?=
 =?utf-8?B?SWh2NDFCcVI2VVM5cUxScWw3b3BXTXNmYyt2VFBPOTJkUS9PbkxLelU0M2JX?=
 =?utf-8?B?SUJFRXpQNlBGVzZKL25sUGVEVU5nejhhc1lOUU9FUWc1SnBjdHJ4UVFEVDdp?=
 =?utf-8?B?bERVT2xac0MvdVREWE9FZTF0MGxnZForc3ZNYnByM2N0VmRoaW1DZHF2bWNp?=
 =?utf-8?B?VUZwUHF1UXpOVEhxYndYTVpXY1h6bkFxWUllMFFkUFdMcnhWUVBEOU42RVc5?=
 =?utf-8?B?ZlhEVHN5R0RBQUN0QW1xYmNWNnhCbEVIWTVYNmtxd3RuVFVaUmhsUm9oNUR3?=
 =?utf-8?B?UlJNUGQ1S09SWmdCYTZqV00yb0J0UkJyMlNyRG9DZ3A1ZU5HV0VORVUxU0Vx?=
 =?utf-8?B?QkF3VHNmc0UrQmh6Zjc0emNSeGgzNUY5czRVZnZBL0pQY2k3dkRCK01zalUz?=
 =?utf-8?B?TVVSb2tseHRxYlZMaFAyYVdycXpNU05SdFdoQTlTREZYeFNNY0Y2T0VqcFlD?=
 =?utf-8?B?a25XOG1WRll0eFRDeG9qWkVZRVhBQ3BKbXM3M3dTUjMxVEliVWdJVVpaWnZ0?=
 =?utf-8?B?SlNyY0FvenJybHkxSlJ2NE9yWk9TTmtOdTdLeUMrNVptdUwzOVpLT0p2NDdH?=
 =?utf-8?B?OGZaa1ZJOXAzd0t5ZDZza0R2M2NNZWRYVW1kYXlZTzFoOS9ydlEydVl5U3ZJ?=
 =?utf-8?B?UjV0d2F3aHI1L3dqWndWZk1HeDRtYUk1cnJrdUwyTWF5TzM4dWppM1ZPWkFh?=
 =?utf-8?B?SEY3R01VL1ZINlRvT09WVXhrUTk2OFZyUHJvZDl1bExnOUxNVWJ4bHBKOHpp?=
 =?utf-8?B?TkJ6c2VEVjZHYWxnRW9oOGtwdGJFNyswaXM2ZGJYTDRrTmVlN204RTdkRVUy?=
 =?utf-8?B?WXBzU2JBb3RVSWU0YmorRVlPYituWjNqZG4xTTBVc2lDZFY5N0o1czZPdGln?=
 =?utf-8?B?dEw1aFhjcTl6WU1qNitqZWR0ZDVObjdIMENDc1NTWFlHbzdJajU1cDZCV2xQ?=
 =?utf-8?B?OXFmR2JWVmVCVFY2ZGlJd0hHVXQzdEdVOXRkWW9La2MyZGtFMG91UVZvaitY?=
 =?utf-8?B?eFRWSDcvUnJvVkRNOVU2c1hCMEFZUzgwaU1qcUQ5Q2VkbWtMRWZLYVl3K29t?=
 =?utf-8?B?U0p1NjJiYXA2aWRlTnZYaEpEYlJwUWhOTTY1UlR4eGM3MVZWbVVzQTVqamRV?=
 =?utf-8?B?ZjVKRHZOSDk2ZUx4RG52R1lqeC9EcHFyS3MyRGRuUFlhN1Z0eUdYWUhjeU1n?=
 =?utf-8?B?S2VQTTZnM0RWQTdhYk5ibWtPNjdPRy85RmlMcldIZnB6anJ3ZjlhM3BUdlBT?=
 =?utf-8?B?NTZZMTEzcGVKNUpPZ3lNT01qYks0ZmxnL3NndkRMUmtWMWhQb3BnOFMrNXZ0?=
 =?utf-8?B?aWQzZ2lpVEE1ODVvcDdUc05SM1poYWE3bGIvaTk2eG8xS2JxalVIbHVBRkpv?=
 =?utf-8?B?TllyVnVYSkFUZEl0QkswWWlWblc1ajg2NGRwL0srMGdUcFJMZjNXRFRhbGVp?=
 =?utf-8?B?a2hVQlUyUjA3UWU2RWd2RHRUTHBUdUhtUE9pa3A5RjM4YUtmTW9QOTJtT1FC?=
 =?utf-8?Q?MAg1Ps?=
X-Microsoft-Antispam-Message-Info: z+oVkttTMXgI+lVkG/n2D7wWk2/Ej9HRZ8r/ODxO1KYNHTlCRy74wbRDE8mdSGi4x9KNmlebV9l/k0NzkqITjrV5T641HWhnqWoqL7DgvBap/3Mkb3jvVPyj0ebBjPvFS/Vjaajq3fzzKxUcASPnsHvgCkDUmdrOrvRwFdJ6x08gz1QKGOL/KU25jWewtM+AOeLK9TNM/NwtNtc3N1xTlx8KgwaOaBNOP3xBn61Ybd6rxZaTSwPMTkUk7kVlg9W7p1F9hrzhqXKaQEZxz2GWHkEQuVdd9Cag8gbAlzxCKYdZPCrWcZzbcNsfjFByHYtaLvhnnsJ+qSozHWbbaO07nw4j1MDfbQbFShmNnG5GKr4=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4478;6:sz6PMYL9PQiD3RMYdXKj2RccovTc8hbLKrVK1BI4YRFATM87fsDgl1Yvz161/m8hbZeXHpDDaXp7V71gXTwdNOaZe9/2+4gUnTWB26PejCggZCkXvyuBie0GrEFqOMKNFRY7YIRZCx+MHN5ZnCPF5UsuVRMVOOvQ3vg27jwe2o4webjsPJgdRapoiQkBTrfaDsXyf9B7EAMrM5ZBwuwfjlRXVSDAjAtZ3fAIyU2O8uYJ+yUfjxOWMBqtn1Rj/WYjGKTqLxYAASSFzUqQWLhcltqF+08LC7f50wW0VsEK5iEP6dpleIg01f9GgxzAfX1vfWr63Bg6kRVQy0mv6eAkH99VeYRRQfoAt78VXCC3zFazkYzugNAcaCQz5ctQ3J3H0N00XKTX4fP+GqhmM3yuRzK+8ngWWjNiDFyVKx5cPgceLoW+5LL0GiGrrTYlVeB2i+LScfpSOqKV4JPsdtB36g==;5:dkr+9woAXV42Z+JV+A0uuuTHmUCZBzwy3qJlgKoemtoCf+u5SByxUUpLkGdasRj8CfZgwmVkUa9BKH3INs9hU131P9IlidXGXadQ63NQ7EoqILd28jLASCkgs6kZrKBjQJFZ8f06BA7U8wt1F3jOJqDU2nVmt92Ihq1rptIVUW0=;7:4Os3tKnRhcbpIaq02kQeZ5l5CMyXGuwXPRJ0LRI8TXd4Alg1LVd2E0uTHRrL/O7tvGmhoFsGQPbV+ncybcmIFb7Wnmif85sy8QxBkxLFd3Zcr+vbm5MpjXaoBO7uANdq7HKEsAkqc6WhiMZeFKoofMQIgOGDWFx901M7y3Fxiqh5Q1CoO5D3JHpYMfUh7vEqFEDhaHhRRBkOTamfaZwcMkX1dNFIMxmBaKnjjw+N6FZAvdsivT+sT5EUyO09RTVZ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2018 13:17:46.4924
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6de09478-89b9-4288-f9e1-08d627a04777
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4478
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 28.9.2018 23:12, Olof Johansson wrote:
> On Fri, Sep 28, 2018 at 10:15 AM Jolly Shah <JOLLYS@xilinx.com> wrote:
>>
>> Hi Olof,
>>
>> Thanks for the review. Pushed v4 with suggested fixes. Let us know if series looks good and we can create pull request for same.
>>
>> Thanks,
>> Jolly Shah
> 
> I'm happy with this one, thanks for revising the patchset with the fixes.
> 
> Feel free to add:
> 
> Acked-by: Olof Johansson <olof@lixom.net>
> 
> to the patches.

Just for clarification. I have checked driver/clk and patches should
still go via Michael or Stephen.
Firmware code is already in arm-soc tree that's why I would expect
Michael/Stephen should review it and then it shouldn't be a problem to
take this via arm-soc tree.

Olof: Please correct me if I am wrong and you are happy to take it via
arm-soc directly.

Thanks,
Michal


