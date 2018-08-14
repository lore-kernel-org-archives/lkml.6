Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F0AAC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 12:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 173F421756
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 12:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="UWL0IdLc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 173F421756
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732563AbeHNPBc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 11:01:32 -0400
Received: from mail-by2nam03on0079.outbound.protection.outlook.com ([104.47.42.79]:10368
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730825AbeHNPBb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 11:01:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=brwYmH5xBR5xey1SknR9Dnu24LfwnUYokTdDvMCqK5E=;
 b=UWL0IdLco1v5HzxUDxPgPtbKvx2JP7SBEix3M4AS8lP9IP5vicRBCLuBXnT6+jKQvMl1J0DpvgBosOv0HlMPHnleYD7PmgV9XtYiD/68v7fjaE+XNRTEVbG4MQDXQ9Ng6yTphXUg0DOxtXDfLCZ561wUsoOvAXzpXVVpFGzi6EM=
Received: from MWHPR03CA0025.namprd03.prod.outlook.com (2603:10b6:301:3b::14)
 by CY4PR03MB3125.namprd03.prod.outlook.com (2603:10b6:910:53::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1038.23; Tue, 14 Aug
 2018 12:14:33 +0000
Received: from BY2FFO11FD029.protection.gbl (2a01:111:f400:7c0c::159) by
 MWHPR03CA0025.outlook.office365.com (2603:10b6:301:3b::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1038.19 via Frontend Transport; Tue, 14 Aug 2018 12:14:33 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BY2FFO11FD029.mail.protection.outlook.com (10.1.14.212) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1059.14
 via Frontend Transport; Tue, 14 Aug 2018 12:14:33 +0000
Received: from NWD2HUBCAS8.ad.analog.com (nwd2hubcas8.ad.analog.com [10.64.69.108])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id w7ECEWe3029535
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
        Tue, 14 Aug 2018 05:14:32 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by NWD2HUBCAS8.ad.analog.com
 (10.64.69.108) with Microsoft SMTP Server id 14.3.301.0; Tue, 14 Aug 2018
 08:14:32 -0400
Received: from localhost.localdomain ([10.44.3.40])     by zeus.spd.analog.com
 (8.15.1/8.15.1) with ESMTP id w7ECET0X001075;  Tue, 14 Aug 2018 08:14:30 -0400
From:   <michael.hennerich@analog.com>
To:     <linux@roeck-us.net>, <jdelvare@suse.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <corbet@lwn.net>
CC:     <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Michael Hennerich" <michael.hennerich@analog.com>
Subject: [PATCH] drivers: hwmon: pmbus: ltc2978: Add support for LTM4686 uModule
Date:   Tue, 14 Aug 2018 14:18:28 +0200
Message-ID: <1534249108-29765-1-git-send-email-michael.hennerich@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(376002)(346002)(39860400002)(2980300002)(438002)(189003)(199004)(4326008)(110136005)(316002)(50466002)(426003)(336012)(2616005)(478600001)(54906003)(2876002)(49486002)(106002)(6306002)(107886003)(1720100001)(5660300001)(86362001)(50226002)(86152003)(72206003)(966005)(8936002)(5820100001)(106466001)(23676004)(2906002)(36756003)(476003)(8676002)(47776003)(126002)(2870700001)(246002)(356003)(186003)(486006)(1857600001)(305945005)(26005)(7636002)(77096007)(2004002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR03MB3125;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11FD029;1:MoE3j0p03mK0le9ISAg890c/aL4d+Ufh7hoDzFdQB7IlXHExvw8bwjQP3Y9ttogeSge+qStd4j494u8IG30zWMpeVK0GZcbwtSh3tDiIoJgzeNzL0p1xoosnYU2kx0X/
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 795f9b4c-78bf-4bbf-c63f-08d601df7eb9
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:CY4PR03MB3125;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB3125;3:34/22/z8ycxcjp54LGEI/mo5Q839Eu5NciKCkac64z3Q3stLD9slJlXL6JS1Co/u2fVuHJ9TLmXewaeXMWqxeOuh0k8esWX4wsse4+9x7rCLujTE6Cp4a6eja/6zQCcx9HLGTzaF8ue6PD5rAp7AZUPoQmmJIyfySrCTBQgPuL2ln8QNnWlAs/6SbUClfNTTiBPdASG+0n4kAytT6ur/XsaTF9y5xBx/KyFAoJ2zyeSH6Xgw7fjphkuvo8ieh5K8lkR31qJnDmfVwp5JyhKGegquJ1Qmw07waZt+k8UfknJ6QbKefO4KoN2ysXKUVs9GQLBsfuKAFXd8uQWqZRq/exarTjVI0X9lvGryMFGcyLo=;25:6OAADP3wYXS1PYMPcENiXvEhWQqxHiIVz/N0ykpu5t/fvtEcYQ0r4YGDuIKaLyaOQqTmfXRzrvU1Ga4k6EjP4Fi/8IyIexUGBbWjwtog2srtvz5cS02IxocFyPz4/S4h2QnID3/v5HXJ7hzRQLdUlAtp7Mv57XGc5JfPM9dUmq0AOxej6eBH9gnG/SblAKzkhVXnkfSrs8XEexERLIckcm/tAbF08PHX2CXqRkNwwCmtPoxhnP4vxjtE8vtpDxSCCTXmnMClZv1ciVRBkwpKTEyMggiv6NniH9vwk9ZOp/DYQSbK/Ncc6qWtv021t2MHiajNh+G11elzo5K9odSdUQ==
X-MS-TrafficTypeDiagnostic: CY4PR03MB3125:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB3125;31:ciPr+Sn6jCblIGNfLPIOAs5LXzaF/5bnZbDVPVQiEjY5QwDKpJTGbB4/wqMOYwESQV+UZJ2GpN71yLQMyXf0RRwXGMWnn4ly5fprQ2nwNkMp7qHIL9UQx4HLzHSYbudQhEtBNmceYhPPdO9xitDNfdNjW//VzK4e/RE3IVQgtaS8dlVhsiK9C1HJv9RREs1cq20nrlWawPUhFSeDdBQXn8Pige8h9oIv59/ZP8UuX6o=;20:em8x1kiSndZdjzxVhBQrNvKyZpWl7WSlBhOlHB/fMbuO6NYdNq+9pCz4JvF8R7LCXB+7m4kM2p4/F4UrraCmWVcDtESYFVHvhCQZ4D6cdbBy9pUWe93Xo5ze114Q7jqTpD9OJXSdfrHKyUixKqVLr4cKj8hMQIMIeABR0lWJ4UVOb24VuzW4TIauuMQYz3nDSV+STChGiSuVoOP8mDt7mp3HkXbiNC8wHens3wpL2HsymwXO8Digj9Feg5+Jf73C04AModVtD1ha0SxCgU4YjC91HvMc/kyDlPTWxj2r0DNFSOXiJ2EcLaIazf0M+sX43S3qZU1zXe24IYcWBCRJGFchJPbwys0j707OGZssAr3gEJdRWoscQuHesSfmk3ORu8fFnI3V6gUeU63V8YhH7XN6G5ZMLNcMQjsUhkzVGeWKf965ztODvqRU9RShlCDSHI/KaJnHE5jUWh/XrHzJ6G3aZtCyxVwDFD7N26cSnl576jzfaZEoqeanj1DBjSf2
X-Microsoft-Antispam-PRVS: <CY4PR03MB3125536112E9A0F421C189E18E380@CY4PR03MB3125.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(270121546159015)(232431446821674)(112613623882745);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(3231311)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:CY4PR03MB3125;BCL:0;PCL:0;RULEID:;SRVR:CY4PR03MB3125;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB3125;4:iaQi5sUb0LwKUWhobIdJ/kVEW554OvxMZ8llOptaf00Vyi2RMksHxkP8nBFZoFkBX3xEmHBXvHJZArfQmb0003KYQ3fWVyWNntKb4tCOWGVFjr+yYPxzQE4kVPjbfD7I7Ap8iGzh7RmxNMeG1gfAiTmOipRSGcqFo/Ld3qYocsX8ObAlq++UXP9EL+zEHYTf0o6kLPdJg7EYU2jZnZC84mAvlpXjvejvQ8JZcH4R/mPfQfJ2TbEfD6efcyEfpTWd6A8KHDAlk3C1/FmWG+9qqZGXLuxsRJ/XzkuITrGBJcCyBcH2DjlTv1hP0GMRxcA5WbaCEsuWAZbj+JEHqu4I7czt1Ip0A4LEprgAQH7kDVyoBv/QMPJAtRGrDQpXPPAP
X-Forefront-PRVS: 0764C4A8CD
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjAzTUIzMTI1OzIzOkpnM3VWRkh2MURqZ21QdytuU1BzcXhESC9Z?=
 =?utf-8?B?R2UyeVdPRzd2ZjlvNEI2T0xOa2ZqTlMrT0FWREJHTFdTZ1FXZVR1NXg2Z21u?=
 =?utf-8?B?c2Q5VkcyaURRUklOUjNqNjh0ZWYzUmk5TmRFNllQaXEwSkVKWm9aemlKMG5i?=
 =?utf-8?B?TUQ0cTJsd2tUTUpHYStOc29lRHdCWkRGaXNFUnpLYXR0clBOdkRuRm9wNUdR?=
 =?utf-8?B?VFNvcVNnMWQ2T0VOcWJHOGk1aGNVNTE4Q0RERitkeEJIL0NBRlZUSkZzL0g1?=
 =?utf-8?B?bVJIR1FMNVpiTFRvT2diTEYvNW40dUpickNadkE0Z0FDbjRad2pkK28xVnl1?=
 =?utf-8?B?Q0s0cEVWWE9OYWE3Q0xJNjBibEdLaTNjOTJaN0R3Wlc3RkJsZFA3WjZPSkdo?=
 =?utf-8?B?aTlVR0hqOUtTM0ErZHgyYzdrZmViaDF2QXZqd0VQNzE1Z25oSjJQeXZBVkx5?=
 =?utf-8?B?WGpUcDJ1cDJDRDRqc0tvQ0Z2UkFuVFlacGRQNUVVWHE3YmNEeUJMTFEvZzgx?=
 =?utf-8?B?b0VRYmVkWTA5eEFiemtZNXRJdTE3TDd4MGFRWGxUckVJWnRMMTJHbGRwaTl4?=
 =?utf-8?B?TU1MK09GOCt5UDAyWnlxM0RhVFV5bkc0ZDRQRWVCRlNCdWlkOHB6a2JseGlj?=
 =?utf-8?B?SHBVb1JzbXdzWDR1YWloZmkycis4bmQyb0M5bUxqQUoxQTBUeW94UHZHR2hB?=
 =?utf-8?B?N0RvWGxya0g0ZW5ETUdaL0YzVHVKczhBa0VMMElhcWhkdVpidm5USCtyVHpo?=
 =?utf-8?B?MjRYTjdBcVFNWjZtUlVaTUhoV3hUcnJSYkZveDVlOHByUzZMTTRqUWEyamNI?=
 =?utf-8?B?bHd5UTRBNld2aDIyc0t2WHFCSGM4NmhuTEJZLytUbHZ1MVpnYmtzZWl1LzU2?=
 =?utf-8?B?dHAxSU56eEV1ZUdLcTZUZkFBTzZQVW01cDZyVWZsMDhXS1VqMGw2UVVEaGwr?=
 =?utf-8?B?aG44Z0NRZkJNQXErYzVUSEZJUVRTL3M0aHNpL1hZU0pheTM3WWlRU25pbDlo?=
 =?utf-8?B?M04wT3VBTUozYUVDYmZ3NytscWtRYTJIVkRVM29GNDVmdmtRWmwydHN1Sko4?=
 =?utf-8?B?Y1ZpbXQ5VkphMVFLUHFYNHdmV0dPbWZnWEVaTkM3VjBpWDN3THBGVUo1QkU2?=
 =?utf-8?B?UTNDMVV5a0JVU2VyQmpVMnBtcEpWd1BmSnZ3S0szK3NqYklyb0VDWlA4TlRT?=
 =?utf-8?B?WGlTajNIYVNYalRGTFErNW5ZZlVXSWRwMyt1YWpQSmpCRWF2OXZtZVYrREdI?=
 =?utf-8?B?RnVPMGlJY2QxcnRyR0l1cTZ0UzVNZDRlcThyR0ZZL2hiWkVzcTlvRk1qVDgr?=
 =?utf-8?B?TWJIUlJwdHF2czV0bkdqNjUyNzJqck9xTEZrbFVEY2NzSmRBOThyMjRoS2lm?=
 =?utf-8?B?ZUhxNGY1NEhEZEZjVy9SRVFzdWFmTXJvc2xWN2hiUWZYK0hhajZoZnpGaWQ3?=
 =?utf-8?B?dHh0aE1jTUg5SDA5U0FOZm9qRjg2MVgwRERuRlRaSUltRU1MVjdpWHp4MzZS?=
 =?utf-8?Q?PhgyKmCK9SD6oh0h9+TmAC2bwM5NnlI7P2XMt0fq7ZLcsf?=
X-Microsoft-Antispam-Message-Info: Zh0vKQO/B5mWfOEkA1r2y786lhJVy/26ZULyoiTkbuYm/3lh2av7d18pBzrz/VjNQBWG1dLnGwQhsHm3Qf8kgB+i2ozHK5oGk1F+aB+NY1k5vmMTIX/qob9M4fE3Bt1v9HKVDjwkSe9OfL6Edb5GfL3pLyr47gqTtiY2ewnRbcbsiS3VK2aQ5MUb5q+iBdI9PWotTLBuBqOqGbw7UVf5wY5iFNGyOc4JmxQKNHWT35hZtyxt12g6PM4Vc5hEEcHwyuQor5Y2vTRH49tU8RmnvjSj/vsozWukCxrEN7Ec/kHd+en91DIlW4I0Yh2mLNVIOE3uH1Ir+s/tZPbvZUtbYpaYhC6DXfah68GfEgt270I=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB3125;6:zsovs8Wf9OKN8x9oeo0HuZzVRsTUgErKZNIzor6z9BnTInzBh2Fo8/qVUuyPDzruPx4DYyeGQWfusTM0ds5oEwFCXuqLT2YgN1gPfn7+rU92LTe011ifF0CQK8UQAOPYfS3ZhcO6x/MzMr3XfYNb3oyxayTiEHgqCYWKD8OIjUNZoX9/rY7HHo4wN7qZKlL3JyasgplDNuFo+fKSNvugVbGAGtnf/ZnO3h7+2TYpYsCl+0+YOCR0Rk1vJMKcMzus38Ly7J3eXK/5+p6sDmUVHTcB5onu13S8Fq3QgPuCAnRLZ6mbCje2/NAbAfNfzvCuwuq1ZDd4yiAzyoqd3dqki0VkqNCdboqx97yfs/4qe8axezhDSdwyoKFhwqzWt7B0qo+j0VlXPPIUqsJawZ6tp7GD5z3I7Fuf5zEpwF9eCC+bGkUC6rtGWfmfooCOv7pivyMUfBSnicA+qwIMij66Og==;5:tdIALiv3xNRy6TPgdyD5Y5BadDkd7C4lMS9eBoBTfZpaDPJ8M2DxsbwpdGsuMVnJWTpyzIV4S6TLCPy+3m2UDAURcc8ODfwLu3TGMrm1/Yd/VfucNfQGN3ncmhiZoBN8oPBTEzyoH6OeJnAHu1OW5otwhwyl71GS0jZZedOgreM=;7:ifWQ84QpZbFs81qxWYzC++HKRoQ+XvSp/SlusTKoK6z0QBQpMTB2D3FuEYAwXEInuQzOTcFt+yDO5ixI6OrGsXx3cXTqh9ajz1Kgwryuw/P7iTnaXZf/jwfkcSV6KRqYKqLhoxJcyRpUol/ms62E8IRl8RqgaQjoMsASZ+/m6YPp7fCNbHETjwX7D056obci5nWv0Owx1oigYwkWUB/dtRf6nT8/0Yz7DKTZtu8uTB2ZEHgxSr0P1DB47JtzWQmP
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2018 12:14:33.1973
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 795f9b4c-78bf-4bbf-c63f-08d601df7eb9
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB3125
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Hennerich <michael.hennerich@analog.com>

This patch adds support for LTM4686 Ultrathin Dual 10A or
Single 20A uModule Regulator with Digital Power System Management.

Datasheet: http://www.analog.com/ltm4686


Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 Documentation/devicetree/bindings/hwmon/ltc2978.txt | 2 ++
 Documentation/hwmon/ltc2978                         | 5 +++++
 drivers/hwmon/pmbus/Kconfig                         | 3 ++-
 drivers/hwmon/pmbus/ltc2978.c                       | 9 ++++++++-
 4 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/hwmon/ltc2978.txt b/Documentation/devicetree/bindings/hwmon/ltc2978.txt
index bf2a47b..b428a70 100644
--- a/Documentation/devicetree/bindings/hwmon/ltc2978.txt
+++ b/Documentation/devicetree/bindings/hwmon/ltc2978.txt
@@ -15,6 +15,7 @@ Required properties:
   * "lltc,ltm2987"
   * "lltc,ltm4675"
   * "lltc,ltm4676"
+  * "lltc,ltm4686"
 - reg: I2C slave address
 
 Optional properties:
@@ -30,6 +31,7 @@ Valid names of regulators depend on number of supplies supported per device:
   * ltc3880, ltc3882, ltc3886 : vout0 - vout1
   * ltc3883 : vout0
   * ltm4676 : vout0 - vout1
+  * ltm4686 : vout0 - vout1
 
 Example:
 ltc2978@5e {
diff --git a/Documentation/hwmon/ltc2978 b/Documentation/hwmon/ltc2978
index 9a49d3c..dfb2caa 100644
--- a/Documentation/hwmon/ltc2978
+++ b/Documentation/hwmon/ltc2978
@@ -55,6 +55,10 @@ Supported chips:
     Prefix: 'ltm4676'
     Addresses scanned: -
     Datasheet: http://www.linear.com/product/ltm4676
+  * Analog Devices LTM4686
+    Prefix: 'ltm4686'
+    Addresses scanned: -
+    Datasheet: http://www.analog.com/ltm4686
 
 Author: Guenter Roeck <linux@roeck-us.net>
 
@@ -76,6 +80,7 @@ additional components on a single die. The chip is instantiated and reported
 as two separate chips on two different I2C bus addresses.
 LTM4675 is a dual 9A or single 18A μModule regulator
 LTM4676 is a dual 13A or single 26A uModule regulator.
+LTM4686 is a dual 10A or single 20A uModule regulator.
 
 
 Usage Notes
diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index e71aec6..28279a8 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -83,7 +83,8 @@ config SENSORS_LTC2978_REGULATOR
 	depends on SENSORS_LTC2978 && REGULATOR
 	help
 	  If you say yes here you get regulator support for Linear
-	  Technology LTC2974, LTC2977, LTC2978, LTC3880, LTC3883, and LTM4676.
+	  Technology LTC2974, LTC2977, LTC2978, LTC3880, LTC3883, LTM4676
+	  and LTM4686.
 
 config SENSORS_LTC3815
 	tristate "Linear Technologies LTC3815"
diff --git a/drivers/hwmon/pmbus/ltc2978.c b/drivers/hwmon/pmbus/ltc2978.c
index 58b789c..07afb92 100644
--- a/drivers/hwmon/pmbus/ltc2978.c
+++ b/drivers/hwmon/pmbus/ltc2978.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2011 Ericsson AB.
  * Copyright (c) 2013, 2014, 2015 Guenter Roeck
  * Copyright (c) 2015 Linear Technology
+ * Copyright (c) 2018 Analog Devices Inc.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -28,7 +29,7 @@
 #include "pmbus.h"
 
 enum chips { ltc2974, ltc2975, ltc2977, ltc2978, ltc2980, ltc3880, ltc3882,
-	ltc3883, ltc3886, ltc3887, ltm2987, ltm4675, ltm4676 };
+	ltc3883, ltc3886, ltc3887, ltm2987, ltm4675, ltm4676, ltm4686 };
 
 /* Common for all chips */
 #define LTC2978_MFR_VOUT_PEAK		0xdd
@@ -81,6 +82,7 @@ enum chips { ltc2974, ltc2975, ltc2977, ltc2978, ltc2980, ltc3880, ltc3882,
 #define LTM4676_ID_REV1			0x4400
 #define LTM4676_ID_REV2			0x4480
 #define LTM4676A_ID			0x47e0
+#define LTM4686_ID			0x4770
 
 #define LTC2974_NUM_PAGES		4
 #define LTC2978_NUM_PAGES		8
@@ -512,6 +514,7 @@ static const struct i2c_device_id ltc2978_id[] = {
 	{"ltm2987", ltm2987},
 	{"ltm4675", ltm4675},
 	{"ltm4676", ltm4676},
+	{"ltm4686", ltm4686},
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, ltc2978_id);
@@ -588,6 +591,8 @@ static int ltc2978_get_id(struct i2c_client *client)
 	else if (chip_id == LTM4676_ID_REV1 || chip_id == LTM4676_ID_REV2 ||
 		 chip_id == LTM4676A_ID)
 		return ltm4676;
+	else if (chip_id == LTM4686_ID)
+		return ltm4686;
 
 	dev_err(&client->dev, "Unsupported chip ID 0x%x\n", chip_id);
 	return -ENODEV;
@@ -684,6 +689,7 @@ static int ltc2978_probe(struct i2c_client *client,
 	case ltc3887:
 	case ltm4675:
 	case ltm4676:
+	case ltm4686:
 		data->features |= FEAT_CLEAR_PEAKS | FEAT_NEEDS_POLLING;
 		info->read_word_data = ltc3880_read_word_data;
 		info->pages = LTC3880_NUM_PAGES;
@@ -770,6 +776,7 @@ static const struct of_device_id ltc2978_of_match[] = {
 	{ .compatible = "lltc,ltm2987" },
 	{ .compatible = "lltc,ltm4675" },
 	{ .compatible = "lltc,ltm4676" },
+	{ .compatible = "lltc,ltm4686" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ltc2978_of_match);
-- 
2.7.4

