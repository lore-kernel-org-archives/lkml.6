Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BBD6C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C59D12147A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:04:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="v+DN51/+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbfBULEK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 06:04:10 -0500
Received: from mail-eopbgr780050.outbound.protection.outlook.com ([40.107.78.50]:53696
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725814AbfBULEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 06:04:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/BJbr189PoLNGcQQcKXmbfFwB2vHh7CNLcKCMX2W4M=;
 b=v+DN51/+BA7RKohNDd+ZxFRquOpDMh76PdbYRPyoXWLy4EBjs7NLociJhQuHgLG3/pnidJGGvsOmCsJzotC9W0tXctuw5Oh00PRYiN76l5eOXgT5+7dqp8WTFH1dd5ox6AEcDM40/iSrkj/Os8AW/DT9B+DVUKuMaAd12rSYM9M=
Received: from BYAPR02CA0046.namprd02.prod.outlook.com (2603:10b6:a03:54::23)
 by SN6PR02MB4637.namprd02.prod.outlook.com (2603:10b6:805:b1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1643.16; Thu, 21 Feb
 2019 11:03:58 +0000
Received: from CY1NAM02FT025.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::207) by BYAPR02CA0046.outlook.office365.com
 (2603:10b6:a03:54::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1643.15 via Frontend
 Transport; Thu, 21 Feb 2019 11:03:57 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; bootlin.com; dkim=none (message not signed)
 header.d=none;bootlin.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT025.mail.protection.outlook.com (10.152.75.148) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1643.11
 via Frontend Transport; Thu, 21 Feb 2019 11:03:56 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gwm8y-00013P-Dc; Thu, 21 Feb 2019 03:03:56 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gwm8t-0007Z4-9o; Thu, 21 Feb 2019 03:03:51 -0800
Received: from xsj-pvapsmtp01 (xsj-pvapsmtp01.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x1LB3lDv005669;
        Thu, 21 Feb 2019 03:03:47 -0800
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1gwm8p-0007YT-AN; Thu, 21 Feb 2019 03:03:47 -0800
Subject: Re: [PATCH RESEND net] net: phy: xgmiitorgmii: Support generic PHY
 status read
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Andrew Lunn <andrew@lunn.ch>
CC:     Florian Fainelli <f.fainelli@gmail.com>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Heiner Kallweit <hkallweit1@gmail.com>
References: <20190215163220.20041-1-paul.kocialkowski@bootlin.com>
 <387ed483-b205-beda-319d-6f2b8ea55601@gmail.com>
 <38f6708476e9beca4583ccc2a62e238a4981b735.camel@bootlin.com>
 <958bb823-3dc8-607f-3c38-3d902acb85a8@gmail.com>
 <b0f700f85cd35bf26a97280f3bef7c4e87102d63.camel@bootlin.com>
 <20190219172515.GC13075@lunn.ch>
 <f0020e39-7ace-e1e0-e629-b84d6f92b841@xilinx.com>
 <adbb183836e22dfc4558beaa818677c24bacf3a8.camel@bootlin.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <9cb2f7a8-a8cf-ef80-d260-cc67c072b5c5@xilinx.com>
Date:   Thu, 21 Feb 2019 12:03:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <adbb183836e22dfc4558beaa818677c24bacf3a8.camel@bootlin.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(396003)(39850400004)(136003)(346002)(2980300002)(51914003)(54094003)(199004)(189003)(61684003)(31686004)(64126003)(8936002)(65826007)(81166006)(106466001)(8676002)(81156014)(356004)(5660300002)(5024004)(4326008)(47776003)(2486003)(65806001)(31696002)(9786002)(76176011)(65956001)(23676004)(63266004)(6666004)(6246003)(126002)(44832011)(2616005)(2906002)(446003)(426003)(476003)(336012)(36386004)(486006)(77096007)(229853002)(106002)(186003)(11346002)(26005)(230700001)(93886005)(50466002)(305945005)(478600001)(316002)(110136005)(58126008)(54906003)(36756003)(41533002)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4637;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5fd57116-b6b3-4609-d9ee-08d697ec46be
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:SN6PR02MB4637;
X-MS-TrafficTypeDiagnostic: SN6PR02MB4637:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4637;20:uXHEKPWmcvIznQ3oSELQ+Jc2jaELdgeOnrzxaKPGxEsOrKCJLu0rZHTyHJj/c/qRAcfQ0xQBED20X3Hudq5OCmA20LAmjsOAH6j/BATeHZ36DZayE3hcASBnp+ycKLM78cMaBI6f7PQDTfYYjeSmjiGEc6qg9GxSOSXyuMvykeU3p0RGkgZgE9K5pwrLhASOuS5ZFLUGxhJkfaTEiQI+5/zaCgdoVXUyOJOg5rp08Sv+LRzmgZ4GwZXAqQ0//btmgbmFmIWVjGmCMUzt0GiFMvDy9xB9QHxkQEoB+/HMuHcbZIb8+pkP/VjHSrr12r6U+udsO2WnOUi15v06AVXJ/7e1k8jkmv0qtSWsEAsVJfrGEG8pQAU1z83twzeCI3RauNV/QPBZvaqNN1FMdPjviFqadxW8RCaQKNROvr3Yix51/E4BFSSuaQ6nNxnrxXyiLYHOSt6n58HHVVpIfag47O+f7fON1bv3c0VeY3eyjMpX4f2KGESxsurQYG1sglOb
X-Microsoft-Antispam-PRVS: <SN6PR02MB4637DB4C7BF34C91AE011320C67E0@SN6PR02MB4637.namprd02.prod.outlook.com>
X-Forefront-PRVS: 09555FB1AD
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjZQUjAyTUI0NjM3OzIzOlA2TWtUT1RXVW85UkZrZDJKaG9CRVpUVytl?=
 =?utf-8?B?dzZWSUNUWWIyajNHdW1aVXAzWXBwNkNFMmw1N25SMzFqQTRZb3h4Y1VTaXEz?=
 =?utf-8?B?T0tVTFAvWjJmZklwTSsyUWNBYy9vSXFZVm8ya2Z0WUk5MW84dGRzdENJNFNF?=
 =?utf-8?B?emlrTFBSZzRkaUJ5Vis3OENNQ04ySk9XaVlsYkZPMEs0eXdPR2JYQk9hQVZP?=
 =?utf-8?B?QUlvckJOR0VLTjNUMDJIVWdvQmlHS2o5Ni9EZU4yc2NJQnB6Q1RqV01DcXIr?=
 =?utf-8?B?YzVDeGNKUFdBWnBxRVNudnNZaDh3eDVWck1ReTlFNFBiNEJSTWJDRkVwNW9G?=
 =?utf-8?B?am5tWEptWHFNMlc1WVR1VCsxSlNHUXY4V0xmeGJ4WWl4NWVveWQ4TTdrY1BR?=
 =?utf-8?B?bFMwYnJsL3A0NS9RNGJma2NHSEpvWWxaSkdGVmx6clNmemg5NzJOcFZHdlg3?=
 =?utf-8?B?d1pUdU94eWlsVmphNWlmaUd3eWdLQWloMDhyWG5UUWxnTlVnOG9IUDRIN0NY?=
 =?utf-8?B?Y0JnYWJTbjYxdCtKN3NaU3NwNWtoVStaM2VsYmdBVXV6aW9pWU1xVVNJa2lS?=
 =?utf-8?B?Rk5hakdHTHllcmNFSWtyZmdYN29jcjVkeHFuZ2czRmEyRlhoU05HdUp2cTZG?=
 =?utf-8?B?UmZEMWNJdHBRRkxsZnE1cXNHdVVCeEFHMWNMUHRJcitGd1pBNnlnbVV4RzNi?=
 =?utf-8?B?Z0xPWmFXSDVXbUhDQVJET0NLdXQ0MFY1UUgyYnJMTTQvcHg5UERzaTZ6MW01?=
 =?utf-8?B?ZEwzU0ZaNm9udXNoWUVBQ1UvejdkMVFhcWlOdDhQU0R4QjI1ZVJ4MEdkQXdE?=
 =?utf-8?B?bURoZVJZUThPTDJVRGVSZ2lTdE81c1BhUnJKV2NuRHZ4THBaNkpneGYyMklN?=
 =?utf-8?B?ZnVxVGt0TENvWFdZZFJQa1Q4WTdTbkJ2M2dNUUlCQVpwUjFhKzNlZCtyaXg0?=
 =?utf-8?B?Z2M2cGRVMDhNRmtOejRySkhEMEtRNWJJRmEvMzJpNGxVMXg1bjJvRER4UWcy?=
 =?utf-8?B?TUxXZ1BmSW1OLy9pdFJrWitUMEF0dk5DUnNic2lCaUgxRmpkMksrL1U2d0c5?=
 =?utf-8?B?cHpTemY5Q2ZDcXFRenhoQTY2bTJSQ2xvbDZHT0R5QXlsS0RwS2V3Mlh2VjdF?=
 =?utf-8?B?Zi84L2dGQjZWZkhkVmRhaEdTelJlSW1tVHNrMzEvUTFENmxtZ3g1WnhYVHht?=
 =?utf-8?B?NUl3OEhMcXNTRERrcWdSQ1VmdktKRlhVMXRycEx2L2FydXVLT0FjQXlJdGty?=
 =?utf-8?B?R0tjN2pQd1g0NFUreUVkN0x0ZG5IcFJsUFI3VXBTZVdsN21mSXFVT2JmNkFv?=
 =?utf-8?B?V0l0NmNlRkFxNDhqQjhOa2hKVEIvMXd0L290UWREWm1sUTdVTDBOQkRWb3JP?=
 =?utf-8?B?YjFocEZYcklsaXBOMk5PNXorUlJGaUtiaDF4WnJUUHM1WWJ2aVRtMEpvTFJW?=
 =?utf-8?B?Qm9WdEpDQzE0QzlJUDRiN05ZdWMwem55aWpLMXBMTXljdC9MZS9URTRJSHp6?=
 =?utf-8?B?WW8wbXhzVnBlZ0RUbDhiUldVcU4yU002YXl0RTJ4QzN5NEl4MU1oRXoxdHZk?=
 =?utf-8?B?am1uS1FadXd3bWUvU1Yzb1BjeWFONjBvNjFRZjhLZUdDZndnSzcvaTAva294?=
 =?utf-8?B?VE8wbHpML0lTaUc2d3N6OHVheVF4ZlYrZ0NxSWhvR0plY29QejVoT2lCcWV1?=
 =?utf-8?B?clFFUVF2eFNldmtWZktCMXR2empuY0YyYzkwdWk0alQwRkRKVTlVbklta0Nw?=
 =?utf-8?B?Z29WU01BbkFMYWliS1F5b1k3RGV5MWdVdVNWNWRKWWVHcVFvSGJZUzFPVHVh?=
 =?utf-8?B?V0FNTFhmWGNuU2Z0YjhlRXc5SXhLd1RENGhTdWxYSHRsc0pTSVRUVjlILyt6?=
 =?utf-8?Q?QkChAgQGKow=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 8eW2xK7mLQsV71/5CYPYjDLxxleU+fu+1JcypZmJfw09XT1XiJ/GrR6FLLDTiEbSf4dO631e+GXwqe+iA/K1iu+VDaDtArkoXLtfWR+j9lpty5fcY6jg6eC78ahuFE7BTYszH+/vfjUrh8AMfEkpGT+AXuOY8JmF1C/1Rmf5uc+goPplN9jVByxxoYZ5idokbIX+Revmq24NtHBWKf3d7e7vaPwEi3y1uwWa0Rg+Koxxuue9w9vAXdQKQtodvyRsS5F7rw84xsASgadzyxJiqN1JkrEKKdEwloEkO+MDB6JX2v0dO1MOSNkyJWruK3vHadKMJJG3/Oyw/VQIkMEcVWxrFhxnty3Vg0VU6MVF6Dc4oamt3xo+TxKrtQ/CcJvUQlFX+bATLLWPP7jLJl6cB+aS6RXtKrgC84ejRnQwLXQ=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2019 11:03:56.9013
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fd57116-b6b3-4609-d9ee-08d697ec46be
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4637
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21. 02. 19 11:24, Paul Kocialkowski wrote:
> Hi,
> 
> On Wed, 2019-02-20 at 07:58 +0100, Michal Simek wrote:
>> Hi,
>>
>> On 19. 02. 19 18:25, Andrew Lunn wrote:
>>>> Thanks for the suggestion! So I had a closer look at that driver to try
>>>> and see what could go wrong and it looks like I found a few things
>>>> there.
>>>
>>> Hi Paul
>>>
>>> Yes, this driver has issues. If i remember correctly, it got merged
>>> while i was on vacation. I pointed out a few issues, but the authors
>>> never responded. Feel free to fix it up.
>>
>> Will be good to know who was that person.
>>
>> I can't do much this week with this because responsible person for this
>> driver is out of office this week. That's why please give us some time
>> to get back to this.
> 
> Understood. I think we need to start a discussion about how the general
> design of this driver can be improved.
> 
> In particular, I wonder if it could work better to make this driver a
> PHY driver that just redirects all its ops to the actual PHY driver,
> except for read_status where it should also add some code.

I didn't take a look at Linux driver but it should work in a way that it
checks description (more below) and then wait for attached phy to do its
work and on the way back just setup this bridge based on that.

> Maybe we could also manage to expose a RGMII PHY mode to the actual PHY
> this way. Currently, the PHY mode has to be set to GMII for the MAC to
> be configured correctly, but the PHY also gets this information while
> it should be told that RGMII is in use. This doesn't seem to play a big
> role in PHY configuration though, but it's still inadequate.
> 
> What do you think?

I stop the driver to be applied to u-boot because exactly this
gmii/rgmii configuration. There is a need that mac is configured to gmii
and this needs to be checked but to phy rgmii needs to be exposed.
I was trying to find out hardware design and board where I can do some
experiments but didn't find out. That's why I need to wait for
colleagues to point me to that.

Thanks,
Michal

