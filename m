Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17162C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 07:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F3F1214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 07:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="NLAJm/Ko"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F3F1214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbeJJPFk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 11:05:40 -0400
Received: from mail-eopbgr680053.outbound.protection.outlook.com ([40.107.68.53]:54267
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725837AbeJJPFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 11:05:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2yoQTCm6UyTIqWNgMZ+Fvq1tLRDXYkU+S91T1rhcog=;
 b=NLAJm/KoU2ZWYPwcBFQDnkR7pMUoOwl+r4oBeOILHUf+Z2/iIQgbnbnlyUZSa5Nl8FNFbp2gISTGfMgr6yU7Ax+1V2k7jPnablr63uTHaQWTOkFZ82GXh6Q29w5OowF8XGtan5SJfz+oVB/1qhwYdowZJzIPD4C8kaj0rjjsZoI=
Received: from BYAPR02CA0069.namprd02.prod.outlook.com (2603:10b6:a03:54::46)
 by DM6PR02MB5228.namprd02.prod.outlook.com (2603:10b6:5:48::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1207.26; Wed, 10 Oct
 2018 07:40:37 +0000
Received: from SN1NAM02FT027.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::209) by BYAPR02CA0069.outlook.office365.com
 (2603:10b6:a03:54::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1228.23 via Frontend
 Transport; Wed, 10 Oct 2018 07:40:37 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT027.mail.protection.outlook.com (10.152.72.99) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1228.17
 via Frontend Transport; Wed, 10 Oct 2018 07:40:36 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:42540 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gA96h-0003jv-RW; Wed, 10 Oct 2018 00:40:35 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gA96c-0006xB-Nx; Wed, 10 Oct 2018 00:40:30 -0700
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w9A7eQKh009461;
        Wed, 10 Oct 2018 00:40:26 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1gA96Y-0006ub-9S; Wed, 10 Oct 2018 00:40:26 -0700
Subject: Re: [PATCH 6/6] arm64: dts: xilinx: ultra96: Standardize LED labels
 and triggers
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>
CC:     <robh+dt@kernel.org>, <heiko@sntech.de>, <ezequiel@collabora.com>,
        <xuwei5@hisilicon.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-rockchip@lists.infradead.org>, <daniel.thompson@linaro.org>,
        <amit.kucheria@linaro.org>, <linus.walleij@linaro.org>,
        <koen.kooi@linaro.org>
References: <20181009140522.6492-1-manivannan.sadhasivam@linaro.org>
 <20181009140522.6492-7-manivannan.sadhasivam@linaro.org>
 <7b94c09d-ecbd-e48e-6583-127566715a76@xilinx.com>
 <20181010073546.GA11462@mani>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <b35d87b8-b9f0-ead1-2755-0562fa1d7f3e@xilinx.com>
Date:   Wed, 10 Oct 2018 09:40:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181010073546.GA11462@mani>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(396003)(39860400002)(346002)(2980300002)(438002)(199004)(189003)(14444005)(426003)(110136005)(64126003)(316002)(31696002)(26005)(93886005)(65826007)(77096007)(50466002)(186003)(6666003)(8936002)(8676002)(65806001)(305945005)(81156014)(575784001)(81166006)(6246003)(106002)(336012)(65956001)(36756003)(9786002)(2486003)(47776003)(356003)(36386004)(106466001)(54906003)(11346002)(44832011)(486006)(63266004)(2616005)(76176011)(478600001)(476003)(7416002)(561944003)(4326008)(2906002)(229853002)(446003)(58126008)(31686004)(126002)(23676004)(230700001)(5660300001)(53546011)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB5228;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT027;1:6IVstITVEywo6byZWubGlXa75jPHAO9WJ9XxI9HuafS8utfiIcyzNRezFkklfywm6OQKvbCaD30QgYuObywqJMkeY/PjTybTzLV2S4Pvky44+Ox8CWE5sbIyo8Aba5Cu
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7fb04af-cbb2-4b5b-42f7-08d62e83ab40
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:DM6PR02MB5228;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB5228;3:G86q4thlkdAikENad256feY78DEgCNLQY7yftTf+p+WejM4+klsDWE0kQldIEEbdYfaWNciZsyxwfhJobbY5+fhYws32v79b4KBK3+lk+iXs1q6oc543njB3/QEDqRqlvbKN83e19hSVRVS4M7v2LF9YPxnhyoBKWixYmOHjpR2g0QKuYvaAcY3i1MKazj54LNwPGxa9oK+cu4dZ9PgPCNvYv5tNR5flPUjBTRLbCJWygtFZ3ms684BNkOyI/yUEcac60rF/RfN+/6Gv3qgNyhC9Fbg38kxc5QHcUYt/N1TeCYXqFotGreSe/W/jt6ZJ8Ua29AAwH+s2SwiMhaX5MHE7KOfEy3lHGEsBEGao3wg=;25:N0CvznXBjE9cDX+hX2ERYPkEf8E2iso+yuA+8HDDclweIHj7685AmZmd7yXs4ioxzOSNW2ufNdEM8mmWCMCKuXhlXU4KN7HZnqdidp9WgV9SUehxEEL72bAjiudyyElx+oY+XIjQSJ07JitsmToxwOdk6I/7mon5HKBJ+XdgiHiDF+VNoBbaKHqCShuNqeeKCJt7arxIh9lV0jEFcnMGoYtaYoKuhjqAPOFi3y0/RtZJVuFvTAVU9ZJ3ETESTaXFzj5c1susvhxxjS37GbGJdDvAgYIZa9pQY8GvC72HkFkoQy4V75DhTosMLao23fGc3Eg0vFExNTkz0azqgCfivA==
X-MS-TrafficTypeDiagnostic: DM6PR02MB5228:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB5228;31:/jYNfoQBnLBNKI6lqP7FYFaCkGvfH1TmMPdCSVzp7deVBROf/6EycRHv8wnOIh/ALbnM88FghMXGVzsxwG70a6C26aksdrmDrJu2t8XfzTOxvNbTsQFkNixaeob89cmeVftdhK7obpyx/SSzHF79o+p3mAW2uGH8J38mlQ+1K21h0tDTpyTxywoQoYfUsxw3AQ4j6IFBgwhus8eZl4BRU4+GfDKsfBut1du5bfgCGlg=;20:s4v3IUJxawXPEDVDeWB2lD3hjdsAbWGSAS8d102bbp5vYlqQWUhVREgWQ04K8Tg/GBfOCiNVGK4ktjxXme3LggpIzBhX91r7/6Cli5VOFwcyyZcTQh5hfmOTb7c/VpGndO4g89y/zFIvvZLBvSGfDERZsnF2zlKSnql82hcu7s2HgD3y9tlVOOAGQGsggCn0mw8n7/A3jt54WayEuYU7WQ+3uB3k+CGkKdStwqzwIB8+iW4pPj8DBOvaemXhZZjiAknTMSEDybOPTE+iaj3h8/MMOe2foSTPozoMJQmHY98fqYfyJElc8okVvwN+QZbsEW3l/ZUPxvqLgdbDr7aEZSkFxTQnumeIw/uZLzPEZdFVhvEqsJRwbW3aKvel4AclhD1Bfy/c+13lTyFryRZVVsSeprULc4vxDIkwiZ7dwSte3I10+hPUgsn0s2/wLjU06hvnPvcDYEuqaQE/yDuyrL1K7UzgWa5OT3CcrTH7NAQY4Re0QzSN240wgH+hcVjl
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB5228729AAA93DBB3B111EAC0C6E00@DM6PR02MB5228.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(93006095)(93004095)(3002001)(10201501046)(6055026)(149066)(150057)(6041310)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051);SRVR:DM6PR02MB5228;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB5228;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB5228;4:AuUs3C5xKh0Zelp+HSWVE3Ui5FgTJW3hw4lKeyGG5HpYorIsc7DcDjZ44e7vsruEr+W6QTG10ccJ/Yiod6A3iJuCkuQ0c/nO734dxUc1eEshI2G0v2AhBkd08xOjCYFsvbLY3NkL2KL2oskaN0s/v/zCVxSBYY2RFAfdW+aA/PwQLymzWFFOhLBIPjrflEgJH+f7NxfwDBB1uUC1A8uqeH6Zaqi/a9r1Q5gM++lojQsZINxQ064hiN4jXKsWz8TTfcuVJyS/Uf67OzkVyuUhoA==
X-Forefront-PRVS: 08213D42D3
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTZQUjAyTUI1MjI4OzIzOnVBYnB1U21SMGRZTlA4NDBmTTA4OVgwYmY3?=
 =?utf-8?B?SHM2S0gwRHlLeDgxdHJRMVpvU3NTYXkxSHcwVEl4a2Z5bWZtTHJYZG9QbHht?=
 =?utf-8?B?UVNJUGVZbFk1Z2hsV2tNSGQ3N3U1MW9uRkJVRHRFMDJ6a1BXcVpiNU9SUGg3?=
 =?utf-8?B?ZTBmZUpYTTVOZVNUR3p6WGxoRW9UKzU2YXlKcFNFckxCTlQ0anNVV01uaG80?=
 =?utf-8?B?UlpnbkUwVmk1K2YzYUlhMk9Jc0prT2kzcUNvdysvV3BlOFV3V3N0d08xd3Va?=
 =?utf-8?B?V2xWa2dzc3JvMENyVmM4MlJCa0g1TFAvcyt4dmJTc2ZLNGM5MlVGRmlqbHU0?=
 =?utf-8?B?ejJtVkt3NUJWcXpkT1MzV2dXazMrUHAxMEhoMnFDeWk1bGFiT3d5YWsvZDJB?=
 =?utf-8?B?aWNNcWtTdTF4TUU0QWp4R1Bwcml4YklZU2k3T3hRNVU5cXlyaEsrQkxtb2dv?=
 =?utf-8?B?RG5YU3h3VVdPVDlVRVl2T3RMaTJHbGtjWnVaMDAxVWFhdmRyMXlyMHFrakpr?=
 =?utf-8?B?Sm9DbXhDekR1elFnc3VIV3VLbzBBbkVBdTBqSGp0N2V6MjJUOER0M3BKLzJT?=
 =?utf-8?B?SGRDbHNUZkVIZkFlU01vNStxWGlpVUxpaXJ6UVZIM0xMam9TUGhxQmNOZ3Zw?=
 =?utf-8?B?OHkrTm5xenpRblZ4ZzhwVFBPVmtTQURXcmVzSW9GN3VHYWpvVUlaNkx2a2xT?=
 =?utf-8?B?elFxZ2h5cUxrTGtGSHdadzV4clRjcE42bW04bmtGM25rR3R4K282WXA0VkR3?=
 =?utf-8?B?Q1IwVjY1SzY5K1EvQWZHSGVBRmpVYjNrTVUxYzBiWStQazA5eGd6ZzhtZThL?=
 =?utf-8?B?cnpBdU9jOSsrcTF1QWNIK2l4MWFJbUI3QVA0TGgwclNLYUJDVi9UTklyd0Fo?=
 =?utf-8?B?R3poSCtDcFFveFdPd3lKbWVzM2JMOUxmajJJYVpCNXJEZGJEV2xKL1U2ZjBp?=
 =?utf-8?B?cTBWaWZuVGM0blkra09UVDB1eUVZWmlXRUFZa01hVTFOaGxnNzEwQWVoZ1JC?=
 =?utf-8?B?c1RJU3cwa2RCeGdKaTR1cWJObzI5NXFqelBhWFdNalhPL3FiWU1IejhObVFq?=
 =?utf-8?B?UUhWekJwVFdlbmM5dWZMeHJzSUI0ajZSeE5xcVUwTnN2bDlPSjdsTU1RR2w3?=
 =?utf-8?B?VGRVNkJFcnZYRVVqcElxNlo3V3ZCZnhtdGFLSHU2WHk2bUcvbS9NZllpenZu?=
 =?utf-8?B?anJkTXRiQWR0T1h4cmcxK21QOXVlRzZZamhEMnZYeVZ2bVZudHdJeUxqUG5R?=
 =?utf-8?B?SU5pYlFVWHdJbTBDVzNjeHRQRS85K3VjTktXTkZzUFJ6dWdKRDBLMXNjOWIz?=
 =?utf-8?B?Um4xKzA3SUVVelZ0VWxmQWE2anlsSDFWQXdtcVdCYWxKZE9nVm5TbGd5b0tr?=
 =?utf-8?B?QTk4VzNIbUJ3bzBwU1hCZTlnd2N4S3h4dVk2SWUwU0JReVBQR1ZVNm9vVGJT?=
 =?utf-8?B?SW9sa1JMY2pjRUFkZTNoM1BMdmV2VzNDRklpKytuM292ZzJKQ29jS256ZWY5?=
 =?utf-8?B?UDNHV0tMaU9TVlk4cktkYmFCUGRPRnVTSUxCa09keXlMWVVqWlBPWkthbG8y?=
 =?utf-8?B?eFFvRTE3dHpkYXdwS1NPRDNibGVkc1c4eXpCZHJUM054cmlHMGFBZ1pPUmlK?=
 =?utf-8?B?SGFvL2VZM2tQVklvM3MyQ1FreEdieVNmNkFJZXRmRE14eXNUdGFUdXZ2c0wx?=
 =?utf-8?B?RjJ1NUJmanVjTFFZV2NQMmpoR1ZSYmY1Q0pLMzNGeEN4OEJMWDlURzFNL0FT?=
 =?utf-8?B?QTlmT2Y5N01jRGw2a01UejZ6YWRmeWN2Q2ZGQVp0UHdjQUV3QkdXUUNZMFBM?=
 =?utf-8?B?SUdpQW55cXgrV0wwemZ0OEFKVEtwSWZ3ckxYNUJpdDlPQ3hpcHVPcGJCK2kr?=
 =?utf-8?B?ellJSHl2RnMySGVhT1BrUFJ0SzNKRkV1VjFLeTRIZ0s0OVFZTk52aFJDbkpZ?=
 =?utf-8?B?eDJ1eEhSejZBPT0=?=
X-Microsoft-Antispam-Message-Info: aDYFbuoXr8innLxLPEeNlthtIdSyU4I9GpckgrEpIM1TnIqoRGaHT6iP/R33NoRxc+Ia3aqvUcdwxIUNe7eCFdyQbavxGxDTuZSrzzZ7jogSnZZDO9VLJxX1PLQg7ox7MsqXQabNYdIFZZ1milNqpIreWg/WipL7XTD0UgSMGb0FRlMAYIBodJ7w01Fdw3tETFckHYmgvL51nwmOa/fUZaiK2uMgI6O6yDDBvN2Uaf6u0o8dGm2qO3emcxjDoGbEx+xhvX2UYAch8L6ySLvd3isMfJL4ANTEgtZipIEfh7AkNujXvNOFBf3pTNqU0Lszn7nMEKF3hcEoo7LHpOE+aR4P63nxzGfeUcqv8EoZHQ8=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB5228;6:+onV2eRj0QnIPZZraZWLW/3WypOR4QFbmBaj5qTObpSKx87fl/ntDfP8N2Ld+cgPlcm1Pw8PrN7vRaxLfzCMVIGumluW1yfRrrkxftw+SrPEArFvhLlI3MvZ2K5O/WcQLS8SLGt5yX6f/aZbP24Cc1nvip2qYiZ20zKvZi/HEQ3HCDLyabIOd94G4V7zNb70EJHbLVtJNsERkB15M8DTy4ZzlhWPiPJxi0MwCrEbVpEyhxPcoZhr0armgmgEV2cw19ncrP2h59sdCYmMraYR7vUYI09yhEjyITK34Hr/utLeKZPhNabFwjop22VFys05rvDVZaoeHuEQIlbD1aRlEH/dX3I7ww71C+3TwrVh/6yBNe6vSzJSfZhoXpPepb6U7y/eT+DkmLLifq2cz+/3vkSYIt4kgBCUtvTm9G+F1RB76yi9yP0igwrcpl//nJRA6SkLoDETUOUuuFwfhAVNDA==;5:JULGtq/xD9OISXHsmyq86CDmZoTlJ1gfSVkdetK6x1Wd4P1kTeGPNOddZVVP9NlqQ2h+STf0OiryKx14dVToY3+/l0KWO30z/6I+OMI89BAM5c0lnuY3tG64SUjWg7MY/OTx06o/+mcjo00Y7Cx+JBPnzGHLs7BevCDkGhLUIqQ=;7:Su6z0ckN50Y+yBEFYQDuUJ1+7My+q8iujPV/nd/uqChovVogcYE2i/ypcfoFU1deTwu25G7yO0aRx9sQpPuHwmdAbINuXNpjFmKkgFo9gH6q2m5auBKTPPWhQHkHhJ9q3DBopPwY7Bwn7MWPA/ie9kFMYOMRp4BKjWsjTuC7TlRjxWhhweU/HXEk7eMU3abPj7imEExSa7hpp0psFPy+8bagZSIxbOS/45/VD+ROGxw6r0d10mQw61FeW56sBNmh
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2018 07:40:36.2587
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7fb04af-cbb2-4b5b-42f7-08d62e83ab40
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5228
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.10.2018 09:35, Manivannan Sadhasivam wrote:
> Hi Michal,
> 
> On Wed, Oct 10, 2018 at 09:25:24AM +0200, Michal Simek wrote:
>> On 9.10.2018 16:05, Manivannan Sadhasivam wrote:
>>> For all 96Boards, the following standard is used for onboard LEDs.
>>>
>>> device-name:green:user1  default-trigger: heartbeat
>>> device-name:green:user2  default-trigger: mmc0/disk-activity
>>>                                           (onboard-storage)
>>> device-name:green:user3  default-trigger: mmc1 (SD-card)
>>> device-name:green:user4  default-trigger: none, panic-indicator
>>> device-name:yellow:wlan  default-trigger: phy0tx
>>> device-name:blue:bt      default-trigger: hci0-power
>>>
>>> So lets adopt the same for Ultra96, which is one of the 96Boards
>>> CE and AI platform. Since the WLAN and BT LEDs are hardwired onboard,
>>> consolidate only User LEDs.
>>>
>>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>>> ---
>>>  arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts | 15 ++++++++-------
>>>  1 file changed, 8 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
>>> index eb5e8bddb610..565ceb390f99 100644
>>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
>>> @@ -57,29 +57,30 @@
>>>  	leds {
>>>  		compatible = "gpio-leds";
>>>  		ds2 {
>>> -			label = "ds2";
>>> +			label = "zynqmp-zcu100-revC:green:user1";
>>
>> The purpose of this series should be standardize Led labels that's why I
>> would expect that leds will be called in the same way on all these
>> boards that's why I am not getting why there is board name.
>>
>> green:user1 or just user1 should be enough.
>>
> 
> Hmm. That's a good point. My proposal to standardize the labels is inspired from
> Dragonboard410c dts [1]. They had the device name in label and I decided to
> go with that. But as you said, the board name is not needed and just 
> `color:led-name` should be fine.
> 
> Will modify this in next interation.

The second part of this is that all current DTSes are using some names
and by changing it you will break compatibility which is something what
you should avoid.
That's why it is really a question if this change should be accepted.

Thanks,
Michal

