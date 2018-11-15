Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE75C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 08:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0225223CB
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 08:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="g69A/MCg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0225223CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728919AbeKOSXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 13:23:03 -0500
Received: from mail-eopbgr770042.outbound.protection.outlook.com ([40.107.77.42]:44523
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728388AbeKOSXC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 13:23:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jal9oMOOkdTdHSnBgd10i6Xep12syWklGPP2a1AsnYE=;
 b=g69A/MCgR3VRPwQ9mKZowtfULPtv/tkZ6YUNzUQXsAhG/O8Nx/9gCd8RPTHJ8GpPSOS/ic3rZ4Agv09IBFXow6uWxwIs+0B3JdnttVSPiU8iddj4K8xI7DfQM8HnL9m8vkGS8Gm1NtnCySXiuHuFouoz68nncEuFl3xV+R08Sbk=
Received: from MWHPR03CA0033.namprd03.prod.outlook.com (2603:10b6:301:3b::22)
 by MWHPR03MB3136.namprd03.prod.outlook.com (2603:10b6:301:3c::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1294.28; Thu, 15 Nov
 2018 08:16:05 +0000
Received: from BN1BFFO11FD019.protection.gbl (2a01:111:f400:7c10::1:101) by
 MWHPR03CA0033.outlook.office365.com (2603:10b6:301:3b::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1339.21 via Frontend Transport; Thu, 15 Nov 2018 08:16:05 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BN1BFFO11FD019.mail.protection.outlook.com (10.58.144.82) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1339.12
 via Frontend Transport; Thu, 15 Nov 2018 08:16:05 +0000
Received: from NWD2HUBCAS9.ad.analog.com (nwd2hubcas9.ad.analog.com [10.64.69.109])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id wAF8G2au007586
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 15 Nov 2018 00:16:04 -0800
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS9.ad.analog.com ([fe80::44a2:871b:49ab:ea47%12]) with mapi id
 14.03.0210.002; Thu, 15 Nov 2018 03:16:04 -0500
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "nishadkamdar@gmail.com" <nishadkamdar@gmail.com>,
        "jic23@kernel.org" <jic23@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 4/4] staging: iio: ad7816: Add device tree table.
Thread-Topic: [PATCH v4 4/4] staging: iio: ad7816: Add device tree table.
Thread-Index: AQHUfEH2MlT3tLnT4EKQohysVKiRJKVQ0jGA
Date:   Thu, 15 Nov 2018 08:16:03 +0000
Message-ID: <4abed67ee07c763151a76cf9e687b6edc6ced5c6.camel@analog.com>
References: <cover.1542215638.git.nishadkamdar@gmail.com>
         <d2df511b4a84b92925a39b5051932eef4426f18d.1542215638.git.nishadkamdar@gmail.com>
In-Reply-To: <d2df511b4a84b92925a39b5051932eef4426f18d.1542215638.git.nishadkamdar@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.50.1.244]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C67EB9B018E1F34FB544AA8CB7218D1B@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(39860400002)(376002)(396003)(346002)(2980300002)(438002)(199004)(189003)(118296001)(36756003)(23676004)(2616005)(426003)(86362001)(7696005)(2486003)(7736002)(106466001)(26005)(186003)(246002)(7636002)(4001150100001)(436003)(4326008)(76176011)(336012)(106002)(11346002)(126002)(446003)(476003)(2900100001)(39060400002)(102836004)(486006)(5660300001)(8936002)(478600001)(229853002)(8676002)(6246003)(316002)(110136005)(54906003)(3846002)(6116002)(50466002)(356004)(2501003)(305945005)(2906002)(14454004)(47776003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB3136;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11FD019;1:mj7XjyvHnS0/VEHBqYF2gljz5rh89OvrX8TDL/Wm9gBRt6hwCQIRejfRqIObIdnBDRUw5Y0PH0qUQfXcw3jNyxVQmhhp9x36JLUbfdfCbnLAiTFRmXvC0aqslpIB6L3M
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad6ecd56-c9fd-45f1-a28c-08d64ad296ca
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060)(7193020);SRVR:MWHPR03MB3136;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB3136;3:obBIt1VxZ2If6uYxthMYhSK59QHo6vMGfV6n+jINR8mgjOUXq+Dw8qPxCTp6AJeMsj/o6PPWnkaaLkFCM6sZQBRgk8I+LWJ3iRLCn9b7eRXat1vWtYt4pFQS9TmS895mU+Rz+AUaPknZ6Ch0vBfusQfVxempT4va5WG20eZewogsFtuGuGTpYEKWl74zw+gO3CfT3epRJK8HkLOMixRPboF1fYGZ+IwhkK55Yd366z1zZ4P2nKqUwru2BQabiIO85K7fqJ0odyYXNFK+8gdleqEPDX5H843oFJ+Fa0rj6COPQMNJxqlULdBhtwE4AambGYWwZVGlES/ViN5Vk7qbtV39BwRQ6D0VjnpeulDUL68=;25:HwxDUhiI3HTTNL3gOY6WmS/oIQ0LcChXUPBLxfzBYD5YM752M6iWa33KakcDdUQhLxI2ldjaTrs5j3hvePtGk8Zss6CfupCqylpJXVkWYfUkYzodI9XpgoMXR8aMPFR2nx/WOOltmVdXxQnSjoz0Iq+Zn7AtjIbGjBGEcviqgHUeEnGCLRmtsjfdsrOw5RiozbvVvLdYulAV+SbJ0wt9mVH5hNxZAXPq+cwAvU07G1sfvuZXQY6RRZdrDse7a915SZCy4goCp/tWW+DDny7RjyfOZ5bplV3/aAiVnm2eAWcjPlj17F3SPM9yCvCAAO2wqQwhqlLwxAa/aqtg9vhspw==
X-MS-TrafficTypeDiagnostic: MWHPR03MB3136:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB3136;31:pkeIDi9g+dXEEUNbEREzfX3EBl7kzoHDIjnTYcVztgx1fPbMltCa3Fbtj6/ekvwPeLwxczStibh7nQMjbf8ueq7vJ0fEnMC9/ELX8EbSGgLEP1NAExp5UupZKEr8wUx/DQwM0FPi3OmbzzcnBuG8XDFxoPqDd8kjimKcZFP6DtTJPTiHzykcNQILY+NrhkDjldTwEo13cJe0l/sC4Sd4EE2qeAy1NzoyjQFsBUbVWKc=;20:RGcii4IhWXN3jBZ4hjN7JELRL6JgG2e9h0G6oxmyWx3G9dRcDghL/ia39D8IKYqfhGPlHU+SCPD6sL9kZ0w2fLCqhh8ht7GHWkLqztorsoDwAJ7yOre314e4KLL4IDy/S27uTBSVLE44xW+Ogy89JVJJQ/6Ee9nsLsqbrOiT0KrpA8xjAUpTA2P5+QScfcE8knHnSsLbXtrolaxVaXzfmi8G+yPtXBrluP4Mn0LZDFW+nGdOgYaKoE5A/EuI1DgcgV+gVMKTcXboo/FT3AyJxWZnR4NS5yNJieFe6JMfd8J324KU0Lmx3PzyaEHE9ZnyYZtm+O5jMm9XUeMXFPIOJTcJd4zncNtUGzfDyrBOxqJ5yNxKUqEkzdPqPfDsI0/EAc6U0d7YSfLp6NK98iS+WUk55megyIV3K9SaYJV6P2+1l4Mplyo3Dc8eQ9X2bOJmE6XBA7R4LX8Q2bdQmvZh+Qvoq7hDRqEypNPSU150CFa69AFi8hSRNQkqkcLOapmA
X-Microsoft-Antispam-PRVS: <MWHPR03MB3136B95311C4441B833FD348F9DC0@MWHPR03MB3136.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231415)(944501410)(52105112)(10201501046)(3002001)(93006095)(93004095)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:MWHPR03MB3136;BCL:0;PCL:0;RULEID:;SRVR:MWHPR03MB3136;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB3136;4:BoRi3SKEHAOvq3FbcpVwEqEqnTioiiE05SnSkSC+OyLn2xK3bl5jom29fQaZqkd0iBe6v1mz78fIWN/frURKEfDAC5ns+I8ck/HblqwgJnGu8coAxrolLH5JVfotEyDkXprHoJvbF/s7Vfd4HZiE/9a/RF2A+JeSIvq0YBxMqHesGBwJy16y3BstmVqugwsTcqQvMnDRWpbYEDMH2eukPit42rIFD2cwbZ+5/AiYh4E8QeFjDfAg9rmETo4TDx7CQ6it9/CIQjGgSWasK+ujz4HW0BL/+1rOyhd2HZucsqhtyVlwcD9oE1E6ubBBLkAQ
X-Forefront-PRVS: 08572BD77F
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjAzTUIzMTM2OzIzOjVkYVZranNXSjg1VlBvNDVTSFRLdkdBU1pr?=
 =?utf-8?B?R2JiODRCUk1heXJPSDRoN0I0b1U2eklIR283WCs2cEFDWlZsMW9OaVlRbmRw?=
 =?utf-8?B?a0twMkNxRE5VNDRGQ1VTL2dhTzdueTJJVGdYVVFMc054VTI4d0xQYStzaVdz?=
 =?utf-8?B?YzIyYWpHci9YcUFGeFkvemVLQUlGSlZ0OHYrU2tnbWVwRkdXZHpCN3VOV0wx?=
 =?utf-8?B?NUpsdXZvcFpkWTNXTnZlaWlIc3JEbGw2aDh0b0VLMk5mQUV6ZlpvWktMMTVn?=
 =?utf-8?B?NzhLeU5hUTRSSnB3QS9UbXdWZ2ZLZExKMmQ1dWo2K084THFXV2JxdDB5cVhx?=
 =?utf-8?B?aS8zWjhOT2R3Y1d1TXR6UVR2U2oxdHIrTDFZOWVRYzBpTlB3N1hnaVlFOEQ2?=
 =?utf-8?B?VGx5MC9MUjRWajBqUk9STE1uSGp6L2wwamJ0RmtpUndUMmdsemxsTW9OR3JP?=
 =?utf-8?B?RDZtc0Zib3BKWFBELzYvaCt1ZGg0b1FsWkZaVTlFMldLdjZITzZ2LzZtZ05W?=
 =?utf-8?B?Y0dzdnZuMDdPY2plaVFOczErZE9CZWVZUlV3QThUUkpBcVlhUVpIL0h1TUdS?=
 =?utf-8?B?SjhQQjhWcDVwRm9oWUVycTNKM2J2S0hpb0pVeVluUTdtSXIwOTVOU3h5dlU0?=
 =?utf-8?B?ZlFiKzFlcTNNdm9LVjJDdVY0VktXMHNINVJWZTRBb3hMR0Q5Q254VUlGYzB3?=
 =?utf-8?B?cWJjWlMyL1BKZ2VPaHNJZXJaTDVUdFlmV1RrNE14cHJuSk9qUHZHNHRVbjYx?=
 =?utf-8?B?WXdWWG50TXNTVzNZS2pvbVpYb3BjOERGNk9GZ1BTSi9Kc1NpTlU3TnllWndD?=
 =?utf-8?B?Y3RRMjI0STRJdy9VWUpZcHVXaWhhQ1d3NVgxRXNSTEFZN1kyRzFxS1ZFUnpz?=
 =?utf-8?B?T1dkdE04RzFhMTlubVdRNVpFZlpJbzMyRGtUVE1WNU1OV1h0enFRdVNydmJa?=
 =?utf-8?B?cFJ6T1RQVmdMdzZvaXpqZkkzRi9GV09WN043ZUFSek5sdmdPTjB3WHgxOGdY?=
 =?utf-8?B?QjNnd0R6VHFzZkN5VDZoSnhvNUQ2Q3NDeEN2bTBqM3pndm5pN3AvSHYzUTJM?=
 =?utf-8?B?UGNZNGwybWxLVTVZMXRUSnJDcWlxdXRqNGh0Tzh3azYrYXlSb2xYVTZtREFh?=
 =?utf-8?B?K3M0aGUwUVJlMGlBTXFhVm9rR1JYNTJabmdyMWpYVS9qcjIydlQ2NlF0MVd4?=
 =?utf-8?B?NjV1cysvUVVqRHhVVHVoS2N1dENQWDFZYXZ4WkRyL0pMYkRCL1ZxQ3hVUDJk?=
 =?utf-8?B?cDdnTXZHT1M0cUQwRlVXRGZpaCtoWnFneEhDaEl5S095cE5vZDI1bDEwYXVx?=
 =?utf-8?B?ZHdGaWhPeTNWYUlFekZhVmx3MzkwUXBMQ1g1R2tXZmMyZDRFaGU2UGRuRm5n?=
 =?utf-8?B?OUFYblFlRkdJcFpWTmxQclY1Z2pZUVVoaTFFbHl5Ym90aDRjZWtYSm5xTzVS?=
 =?utf-8?B?RXpPcnV0TENTcjYyWXJOT2xDL1ltQnc3YXFhTU9XbVVmRHhzTnNFaEtDNTZw?=
 =?utf-8?B?eWNoRlk5YXlrc3hqWnRyczNyTGgrMkVlbURsODdmTktSc2ZDbWFOeGRldlJ0?=
 =?utf-8?B?dEQrbVVyNHBkVk9IVEVEb0hpSSthVk5OcWNLUnl2T0hQOUtwazlPZm03Rjdx?=
 =?utf-8?Q?IlYCHrJ6JKxAzCl4eOXm?=
X-Microsoft-Antispam-Message-Info: loiDieFbUln6nZqQYRGwX3weeIs8KmeObSss9p3WCbkIxiWgVQORnZmtuzi5HD8jE10NbuvLNMp6FEhCkPqzLxe6avm/rui+8iDYiS5XddaqD9zKzRIEfqVR2eqLjoIBZxCU6cftV5V7blG4m2kxmDEkIbAFHekqAQkU41p+DewhhP9TaLIX2UM/lr7K+8f/UR5kiJy39RJkauPjuzZBF6x6pgsuu1L6Ued5H//WfzdXJq+/PHtL1UwtCfPfbkPZZDC4QaCe98DLiEJCHl44vJGXyXwPrTFPAs5YofeheyaHzYm/MlgdnKSTJaf2WV95AVxoOPMGfRYyQ5+VTE8wzLFt6jWQpZ4qw805pAlU7Z4=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB3136;6:n0ERMxaM3oiQBelItiAyHSxAFkeDh4KU33kOZslTAEyGiGNYPA4NZoLUclsxn+fR3jchInJ6id0bJlj79BEMc9YQ3uElp0ov4WACJeYv7OIYV3awzkZdmtLc+D3W8gFdESGfKnQqVGPa/s4WOgoMMgUl2O5n7TBst1v2hgoLy4Qennzr7Ba1/LygGearduwe9iYrvys0Dh8BIZV8c+e4dolZd4hf2D0E7L/TshEFiO9RbXquC+H1G1Oit13CCdAFuuXAM6cbLbc3qMQ/D46OejeBdTn4RXGlLZ41J73p4TQ46Yeiqn72jjrijnnyb45ZzWLqhlVQV0ii8vrq5rQXgPw2iGIRloLkeAPjxUEkmCyoQRK10nlRYgS1GUTB1scywj7wNmlQQ/6KYWmVfgzK7ACqjwqaBtVSx0GVpWPdVPKcGnefHh7sMvhW/PyUawoQB/nqETeyNy6XNFatKbCX3A==;5:la9bqdOllItej9ucOKcgIzPnIwXVzLjYmEYv7MaPQ6KNs/RZco3gwa7ktoEiY3LP4aaoYeidlPdlNzKUhmfNhFXWGDvEuEKptO9EnmucsCYEx4LjtQSGUYzpn7IEkrnGXcH+3+M024u26VyGOnQdorQQny5JGm9HQ0qPO8HjSzI=;7:Ztbi7Jc8qCjRbol3jBM7BRoo041+qaEX49yDNvMBNW6gE+XyROmzBB6CIhVq9GM2TNlQAjiGTcjhJs9rTgly0//VXoTdA/kqFQEb1JYRT1zH0U8guB5kpNN/4Mn5asZawHx/Tftodkn3C+1Z2mBDnA==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2018 08:16:05.1704
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad6ecd56-c9fd-45f1-a28c-08d64ad296ca
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB3136
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE4LTExLTE0IGF0IDIzOjE2ICswNTMwLCBOaXNoYWQgS2FtZGFyIHdyb3RlOg0K
PiBBZGQgZGV2aWNlIHRyZWUgdGFibGUgZm9yIG1hdGNoaW5nIHZlbmRvciBJRC4NCj4gDQoNClRo
aXMgY291bGQgaGF2ZSBiZWVuIGp1c3Qgb25lIHBhdGNoLg0KU29tZXRoaW5nIGxpa2UgDQogICBb
UEFUQ0ggdjRdIHN0YWdpbmc6IGlpbzogYWQ3ODE2OiBBZGQgZGV2aWNlIHRyZWUgdGFibGUuDQoN
Ckl0J3Mgbm8gbG9uZ2VyIGEgc2VyaWVzLCBiZWNhdXNlIHRoZSBvdGhlciBwYXRjaGVzIHdlcmUg
YXBwbGllZCBhbHJlYWR5Lg0KDQpJIGRvbid0IHRoaW5rIHlvdSBuZWVkIHRvIHJlLXNwaW4gdGhp
cyBbaXQncyB1cCB0byBKb25hdGhhbiB0aG91Z2hdLg0KDQpJdCdzIGp1c3Qgc29tZXRoaW5nIHRv
IGtlZXAgaW4gbWluZCBmb3IgbGF0ZXIgd2hlbiByZS1zcGlubmluZyBwYXRjaGVzIG9yDQpzZXJp
ZXMgb2YgcGF0Y2hlcy4NCg0KQWxleA0KDQo+IFNpZ25lZC1vZmYtYnk6IE5pc2hhZCBLYW1kYXIg
PG5pc2hhZGthbWRhckBnbWFpbC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9zdGFnaW5nL2lpby9h
ZGMvYWQ3ODE2LmMgfCA5ICsrKysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9u
cygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc3RhZ2luZy9paW8vYWRjL2FkNzgxNi5j
DQo+IGIvZHJpdmVycy9zdGFnaW5nL2lpby9hZGMvYWQ3ODE2LmMNCj4gaW5kZXggYTJmZWFkODVj
ZDQ2Li45MjVmNzA4NmJjMDcgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvc3RhZ2luZy9paW8vYWRj
L2FkNzgxNi5jDQo+ICsrKyBiL2RyaXZlcnMvc3RhZ2luZy9paW8vYWRjL2FkNzgxNi5jDQo+IEBA
IC00MjIsNiArNDIyLDE0IEBAIHN0YXRpYyBpbnQgYWQ3ODE2X3Byb2JlKHN0cnVjdCBzcGlfZGV2
aWNlICpzcGlfZGV2KQ0KPiAgCXJldHVybiAwOw0KPiAgfQ0KPiAgDQo+ICtzdGF0aWMgY29uc3Qg
c3RydWN0IG9mX2RldmljZV9pZCBhZDc4MTZfb2ZfbWF0Y2hbXSA9IHsNCj4gKwl7IC5jb21wYXRp
YmxlID0gImFkaSxhZDc4MTYiLCB9LA0KPiArCXsgLmNvbXBhdGlibGUgPSAiYWRpLGFkNzgxNyIs
IH0sDQo+ICsJeyAuY29tcGF0aWJsZSA9ICJhZGksYWQ3ODE4IiwgfSwNCj4gKwl7IH0NCj4gK307
DQo+ICtNT0RVTEVfREVWSUNFX1RBQkxFKG9mLCBhZDc4MTZfb2ZfbWF0Y2gpOw0KPiArDQo+ICBz
dGF0aWMgY29uc3Qgc3RydWN0IHNwaV9kZXZpY2VfaWQgYWQ3ODE2X2lkW10gPSB7DQo+ICAJeyAi
YWQ3ODE2IiwgSURfQUQ3ODE2IH0sDQo+ICAJeyAiYWQ3ODE3IiwgSURfQUQ3ODE3IH0sDQo+IEBA
IC00MzQsNiArNDQyLDcgQEAgTU9EVUxFX0RFVklDRV9UQUJMRShzcGksIGFkNzgxNl9pZCk7DQo+
ICBzdGF0aWMgc3RydWN0IHNwaV9kcml2ZXIgYWQ3ODE2X2RyaXZlciA9IHsNCj4gIAkuZHJpdmVy
ID0gew0KPiAgCQkubmFtZSA9ICJhZDc4MTYiLA0KPiArCQkub2ZfbWF0Y2hfdGFibGUgPSBvZl9t
YXRjaF9wdHIoYWQ3ODE2X29mX21hdGNoKSwNCj4gIAl9LA0KPiAgCS5wcm9iZSA9IGFkNzgxNl9w
cm9iZSwNCj4gIAkuaWRfdGFibGUgPSBhZDc4MTZfaWQsDQo=
