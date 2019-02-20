Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8335C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 06:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B89C2086C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 06:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="znMXRpX2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbfBTG7K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 01:59:10 -0500
Received: from mail-eopbgr770041.outbound.protection.outlook.com ([40.107.77.41]:1324
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726082AbfBTG7J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 01:59:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DQQ2NiVfd+9uwDm9Fj6F74lep1RwzEZ/RjO2+K/hWMU=;
 b=znMXRpX2ww8BVPIuhsK7Q86UseN11ypP6Vu9uPIlt9RG0TuhTXEnUBBKNFEA1D2vkLs+8tsKJ/T5dpSiS9iIUFK+FMCzWn6uQgi4WR9uudTaPmyVamYjxMzjc8YNWNb/+FT/wzhk4L0r9lOegBrAex0jEGfOEnOfAIRwSEB6gcw=
Received: from MWHPR0201CA0086.namprd02.prod.outlook.com
 (2603:10b6:301:75::27) by BYAPR02MB4631.namprd02.prod.outlook.com
 (2603:10b6:a03:5f::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1622.19; Wed, 20 Feb
 2019 06:58:53 +0000
Received: from BL2NAM02FT019.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::203) by MWHPR0201CA0086.outlook.office365.com
 (2603:10b6:301:75::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1622.16 via Frontend
 Transport; Wed, 20 Feb 2019 06:58:52 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; lunn.ch; dkim=none (message not signed)
 header.d=none;lunn.ch; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT019.mail.protection.outlook.com (10.152.77.166) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1643.11
 via Frontend Transport; Wed, 20 Feb 2019 06:58:52 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gwLqF-00046G-QT; Tue, 19 Feb 2019 22:58:51 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gwLqA-00046V-NH; Tue, 19 Feb 2019 22:58:46 -0800
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x1K6wcqh015769;
        Tue, 19 Feb 2019 22:58:38 -0800
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1gwLq2-00045Z-3E; Tue, 19 Feb 2019 22:58:38 -0800
Subject: Re: [PATCH RESEND net] net: phy: xgmiitorgmii: Support generic PHY
 status read
To:     Andrew Lunn <andrew@lunn.ch>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
CC:     Florian Fainelli <f.fainelli@gmail.com>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Heiner Kallweit <hkallweit1@gmail.com>
References: <20190215163220.20041-1-paul.kocialkowski@bootlin.com>
 <387ed483-b205-beda-319d-6f2b8ea55601@gmail.com>
 <38f6708476e9beca4583ccc2a62e238a4981b735.camel@bootlin.com>
 <958bb823-3dc8-607f-3c38-3d902acb85a8@gmail.com>
 <b0f700f85cd35bf26a97280f3bef7c4e87102d63.camel@bootlin.com>
 <20190219172515.GC13075@lunn.ch>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <f0020e39-7ace-e1e0-e629-b84d6f92b841@xilinx.com>
Date:   Wed, 20 Feb 2019 07:58:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190219172515.GC13075@lunn.ch>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(346002)(136003)(396003)(2980300002)(199004)(61684003)(51914003)(189003)(64126003)(486006)(47776003)(126002)(50466002)(2616005)(336012)(316002)(446003)(58126008)(54906003)(476003)(106002)(2486003)(23676004)(31686004)(110136005)(106466001)(11346002)(5660300002)(356004)(76176011)(44832011)(26826003)(426003)(6666004)(2906002)(93886005)(36386004)(4744005)(36756003)(4326008)(63266004)(9786002)(8676002)(65826007)(305945005)(478600001)(6246003)(65806001)(77096007)(65956001)(26005)(81156014)(229853002)(186003)(31696002)(81166006)(8936002)(230700001)(217873002)(41533002)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4631;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ae90b0a-41bc-4a4a-4ff0-08d69700df8e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:BYAPR02MB4631;
X-MS-TrafficTypeDiagnostic: BYAPR02MB4631:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4631;20:ZYx6JwITW9UxgYkyWaD/Ky0O2Mdd7ah7ua7wCBcBG/kMM+gXd9lgVvu497JaBKarYvUtluDwmVsz/paLQvTPfICfe+8hO2Tf+KU3ecUikJorwPnqKtkRorOiv21AY66Blv8FBDh7s60oD3kseEXNZ6IFPGSzffbszmJc8x6xJ31vJjItEdmsXJg59xBklwBJUzAbpa5LHEmTtNq54Jt0w/I5BzFjl9vTkBlDtiGkWevE7TzEW93bhqURCKcQdbjTf4qLQbfZwncaH6S+nDu56YZZjp/7o6fZpDiw9XgPL/p9i6H5HCEzVoH2VNrGTbwli2yIR4KQFKzexZNYgzsr5cTe3tkLmmRzb93SyfAB46AO+I0rVJRXK+d9IX77jfqVyH0mtw/K/Vu5ZpFkB/OSp/E6heE3bRUtJd6cV870zvoTdS+UUk+3O7vYm5yTknrO/j87dDCPQvAKBnWI/8uWMID/xc5HDz9yk/+x4w98rQfnTltoK0VVbV7e9cQDhhUP
X-Microsoft-Antispam-PRVS: <BYAPR02MB46315089AF6949452ED2A022C67D0@BYAPR02MB4631.namprd02.prod.outlook.com>
X-Forefront-PRVS: 0954EE4910
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWUFQUjAyTUI0NjMxOzIzOjg4cDF2NGdsL0xkWCt1M0IybUZkMTdMTStO?=
 =?utf-8?B?UDVvQStNTUtvRWt6VlZKVTVjWmdmY1B4MUxmajF6dk82OWNzdFRjd3RDYStY?=
 =?utf-8?B?QUdDQ0RGdXlUZXdpSWpQdDYxektMQ3lLSzZRRzRZbWRXbHd6NnBWV010N1ZP?=
 =?utf-8?B?Q2RRRjNnUWxKQ0pvQmtyb0xsWEZERVJ5aWRjZ0VSYlRIQVkxZm93Q2I4NGpT?=
 =?utf-8?B?eDZZaktGYldYTGYyL3F2N0xQcUpoaUdJSjJBdDlzR3E4QlJ4RGNwMWRkMFRW?=
 =?utf-8?B?M3k1RVBrbDBxbnRjWWM0a1NQd3BDVnhpNk10NlllVUZWRmEranprL0w5YXk2?=
 =?utf-8?B?a25LNGhiRDUwaEg2Q1FUSEJaU2FUOTQ2VzVVbHFGb3VRU0tUWExPdmNrVi9D?=
 =?utf-8?B?eEVxeksyZFVaNnZ4YWpVMUNOK1hKUkpSc0ViMFlnWWpqSXpMUUFTdnJ1RFFT?=
 =?utf-8?B?Y3E0bStZM1YrQ0FQMGI4TUN0OFZXS0QwNzJnTmRUK3FiRGwxTXVpd2lyM2ZS?=
 =?utf-8?B?QlMwQ0NvaG9aSVRpYU96VGNiWUJkcXBLZ29jMmNJMlMwU1V2TVhIRXZWTDB5?=
 =?utf-8?B?WGtZbEFKT1NwaW12YStTSHUrWGU2VlByVWZmU0JKc3NDRjFUVmZMUE5iQmp3?=
 =?utf-8?B?UU5rQkhJNHBkVjRCMmJPQzVyREptMW1wejViWHIyVmsxaEJwMWNwSkNabnAy?=
 =?utf-8?B?R1NZNmFXV2o4bDFGZ3l1Z1hrNTBYYi91b29xdnN0aUpDdHpmTWI5bWRld1RY?=
 =?utf-8?B?QzJkUWl4MTNtOEZoNERnVlE0TXdnbVpsZXBmcG83VWYxU1kyTEdIVEtnc1pS?=
 =?utf-8?B?SXZRTkdVNVhyczU5WVBYNWpDMUdSVDdjanlSM1JWaDUwQ2tBU3JXd2xxd2NL?=
 =?utf-8?B?NU1XQmp3VnRMMkRrR2NUUDJQU0l2UDJsclh5M0crNDhPUXYxNHkwMFY4dTFy?=
 =?utf-8?B?eXFLVWNZcld2VWJEWXk5OUlyWk1SRXJ0V1o1OU15SjhiSFNMaVlvSGlZazEw?=
 =?utf-8?B?QWVxNzNsZTBYek1WMVlEOW93TGFDWGdXVEZtcjdlU0hiQlBrSFhqRFVYZ25y?=
 =?utf-8?B?OHJLSzNJdlFISXBHYkNtMHVNb3dwK2hreGJCSEsvL29lMS8wMmxXMTErVHZ5?=
 =?utf-8?B?aSt5OWkvN2lFN2hxOGppSEpDR3lsTm92QlR2aTJqZS9WOWFQMDRXMm1jQ041?=
 =?utf-8?B?SGkrV3VVQVhEdFRSMmlnQ2JRSmhoajhydnhORWxIR2pQbTZlNXNSRTdNK1hx?=
 =?utf-8?B?YWhZZ2NWTkJaaTVzR0YzQ0dYUVYyd1hTL2FYNnhSQnRncjBVVmhJKzJ0MGxv?=
 =?utf-8?B?cVBJRkZnNit4S2tMMFBtTnpSWHkyTllPOWdadGVTU2NXdkxpQ3FUN1pHNU9R?=
 =?utf-8?B?RTJ1ajA1c3Bmc0FDVFhZSHdHNjZ6Y05WOE1ZUXlhaFNEbTY2eXkxNi9QcHUx?=
 =?utf-8?B?bXlySmttL0trV1RBQjk1VnNmQTNRY0lxYXExemFBaUtKZTRPelNwWkZXSTAw?=
 =?utf-8?B?M0daNVM2eWpwUEJYYmdiN2Vrd242cEZoNHBpN1hENGJkMGFWQ09IK2xYcUx3?=
 =?utf-8?B?Q3ZRTW9NUGNmTVFYWm81eEl1OEYyZVRvbXRuV2ZzQWxPaWU3eUVrQmowNXRi?=
 =?utf-8?B?ZkJEazZDTmhvV3dpL1prbUdVZjVzam5qblE5RFdibUpscHRxYTd3VFRkbkFi?=
 =?utf-8?B?eGdTTlN2MEtBeEFDNCtXand1THZnSUJMRkJ2QWVUREZ6SlZlN2lJTEx6U3J4?=
 =?utf-8?B?TllWZXBYMXRpKyt6bDU1OTBiblkwMHI5QklsZUpoME02VHJ0VzYzV2xZdzZT?=
 =?utf-8?B?Y0k1ck5ERzkzbGp0ZVRRUk95eUY5Z0tmVThxdDhSM0xuOGtHNU1FVitKK3lZ?=
 =?utf-8?Q?UktGGbEPzs+aWsObcvptsxtrCWLy/q7w?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: sX+GSFV0Mb/uW46VrPqg2iCpPAI9X3nL5aVTMLIZ3PHRNjx1Uvze3HXCUfOijg3x9I8TIZTBdp3EVeeT6erC/RfVG9t2neft0WqUXPosdWMMElSPytZgnTqo/GgNmRPGsRkGh3btGaJy4+M3nRLOEHoBsYhNvJ4EFipg5BAC1jBV6nmY1QSGreHkWAy2sHuGMGQy7J6cSRb7Pd4dXZP8++Rk/AgDkBBLka7LmVHmZew7bkLmSiFy/gyTfreGO8aQEpTImL7Uceh85NORfcy5SpkspImKCE4GHxLEywJ2NmEItRUXu0iWDvDzOcD8QUVDYX/TAJvrEgHqFtA4pMLcd8ZLsblkJ4cIjSUtOssT2xQuYk5L8go2o5+ojl0FO/8Txm/WL0JnAzGXYXWptewMi9lmyS2THJYS6tv2v7AJ8vo=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2019 06:58:52.4192
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ae90b0a-41bc-4a4a-4ff0-08d69700df8e
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4631
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19. 02. 19 18:25, Andrew Lunn wrote:
>> Thanks for the suggestion! So I had a closer look at that driver to try
>> and see what could go wrong and it looks like I found a few things
>> there.
> 
> Hi Paul
> 
> Yes, this driver has issues. If i remember correctly, it got merged
> while i was on vacation. I pointed out a few issues, but the authors
> never responded. Feel free to fix it up.

Will be good to know who was that person.

I can't do much this week with this because responsible person for this
driver is out of office this week. That's why please give us some time
to get back to this.

Thanks,
Michal



