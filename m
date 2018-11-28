Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C0DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 06:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EB642082F
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 06:16:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="e9yDlIRv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EB642082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=live.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbeK1RQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 12:16:42 -0500
Received: from mail-oln040092007087.outbound.protection.outlook.com ([40.92.7.87]:11438
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727209AbeK1RQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 12:16:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QPN1Pl0loR+houYqxUQMvj1lUL6z7c5Tu9fpIqoVfCU=;
 b=e9yDlIRvTrOr6YqTCD1W8iBOHoj1T6wnkA3yFEOak1HszjgkP8563rm/hdD425u0t4Tf4l5WMaN8acJcdoQAoAnBBetKvZr5DIh8QmgNethmMIE47CjWSWFFVVve2MZpZlLpiTqhiJFoCDdrTh8MGPUzxqaU6SoH92BOW5tPkBLZgyDIacOETtfHhbyNvr6Rbm0voxxoTZzham9cw4N/hP/IS693b0Te5XAI/XY9g4WjQQis1QnIDla+ey2n/Deya3bV9BrRw0MoKDCVBLFdM/dtnaQyR6CjIU0dc9GhodE+JQfWz3xkr4BboMJ2zQ/BtrOZF0BKMw8bka+ybDXMWw==
Received: from BY2NAM03FT023.eop-NAM03.prod.protection.outlook.com
 (10.152.84.55) by BY2NAM03HT048.eop-NAM03.prod.protection.outlook.com
 (10.152.85.215) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1339.10; Wed, 28 Nov
 2018 06:16:10 +0000
Received: from BLUPR13MB0289.namprd13.prod.outlook.com (10.152.84.59) by
 BY2NAM03FT023.mail.protection.outlook.com (10.152.84.226) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1339.10 via Frontend Transport; Wed, 28 Nov 2018 06:16:10 +0000
Received: from BLUPR13MB0289.namprd13.prod.outlook.com
 ([fe80::eccf:c550:ed97:f1e7]) by BLUPR13MB0289.namprd13.prod.outlook.com
 ([fe80::eccf:c550:ed97:f1e7%7]) with mapi id 15.20.1382.012; Wed, 28 Nov 2018
 06:16:10 +0000
From:   Yueyi Li <liyueyi@live.com>
To:     Willy Tarreau <w@1wt.eu>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "donb@securitymouse.com" <donb@securitymouse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lzo: fix ip overrun during compress.
Thread-Topic: [PATCH] lzo: fix ip overrun during compress.
Thread-Index: AQHUhjzFV7dxiksDcEGXoSZcs8ZKe6Vkk4UAgAAjrQA=
Date:   Wed, 28 Nov 2018 06:16:10 +0000
Message-ID: <BLUPR13MB0289DF5EA12E2D27D7908CF7DFD10@BLUPR13MB0289.namprd13.prod.outlook.com>
References: <BLUPR13MB0289FB16D885625827E8DD27DFD00@BLUPR13MB0289.namprd13.prod.outlook.com>
 <20181128040820.GC19711@1wt.eu>
In-Reply-To: <20181128040820.GC19711@1wt.eu>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR03CA0087.apcprd03.prod.outlook.com
 (2603:1096:203:72::27) To BLUPR13MB0289.namprd13.prod.outlook.com
 (2a01:111:e400:5951::22)
x-incomingtopheadermarker: OriginalChecksum:B0F91FE8B32C90A6E41C2A517E3F6AA1F94F84FCA3518A6929B59924E5BCDF15;UpperCasedChecksum:E33A3F7004EFBC633B3D865296A2AF6B57E2646F933481DB1859B0E73F39C2F7;SizeAsReceived:7606;Count:50
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [dLWNZb/rXNBlIccn9wJNVabO7aZJ023R]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2NAM03HT048;6:m8HvjhWAOLTTGW5Y+UyLUu00SPdc9gKyCXSKTQ8JJcxhPHSdQ8JhsSNtttqLxov28mlbmDbzP3K7GnOCWWj4OB/BDBslkzvYIHXy9oEByRNPi1H7PSpiNr6jTsT3nAtG8wQrQPzjM+xuFIoZUAA8FVCJ5G+B8H0O+5LNnF+qyNZQU05idq9jhZmFGg2HMI1Zh8RVDy6C9mhtPH7bWHdZHT+R7/iJeaHSDdveycKoALBNdp6UIBYryiMJaEjdU8UXP6sI11Bov3lhh3J8AmqAsjA+4CMs0A1bode6beJ0q23vl7TURYPiJAs0Q1jGK+30vUW2VtcbTIsloS1Cf3RkKUSXYQpNxVEdIlQbPPyY6grAAdYxu5k3tG3C1vCIJLIfvgxTog+yRjRFv7JctYOGxW99lXusJknY5vK0EgzfbYRyrlGBSfF7+X3rIiKwvgAuNtzZ4bvelFiuSR2sGkEJyg==;5:M3xF9NGRv37bDNzphdsMdsW7ZJN5PPpj/98Q243OuBL75UWlTmKiK6VMfNG+0CChYnpAtHga/hvlm0jmxicyazauI3X5ItTWXYmrAiShN1kDOiEGReBzcQVU8f6NIdMCQ1fUY0ZxulKpLY/Cy7pwSdwTj99fgjHRQPFJsP1yYsc=;7:Arnxx2t5F8fBI4t4TffNHm+x2AXsMgI+h6MgTrxR7J5PkzMPlRgs5HyoUr2rK8jGM9bzXFdHF0ojhvVLOQPY7aoBgpdL7rUCYDWinOPwjjAWVVY3hMwDCWf3KRvhlhHnd1EzeoOBqHljCoYe2p3mIg==
x-incomingheadercount: 50
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031324274)(2017031323274)(2017031322404)(1603101475)(1601125500)(1701031045);SRVR:BY2NAM03HT048;
x-ms-traffictypediagnostic: BY2NAM03HT048:
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(4566010)(82015058);SRVR:BY2NAM03HT048;BCL:0;PCL:0;RULEID:;SRVR:BY2NAM03HT048;
x-microsoft-antispam-message-info: rwzGcp+3j4nz67LhN09gH8VzhbvaFKu4qJlFVVlMGk9zVmhXEK4b3jIwgZAiZyQm
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <5BABA93CE16A6A4B8652EC85464CC7B5@namprd13.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: live.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: f12efbb0-867f-4c93-8261-502eceebfafa
X-MS-Exchange-CrossTenant-Network-Message-Id: a618ba1d-b12d-49ee-5ecc-08d654f8fd6f
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: f12efbb0-867f-4c93-8261-502eceebfafa
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2018 06:16:10.7116
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2NAM03HT048
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Willy,


On 2018/11/28 12:08, Willy Tarreau wrote:
> Hi Yueyi,
>
> On Tue, Nov 27, 2018 at 10:34:26AM +0000, Yueyi Li wrote:
>> It`s possible ip overrun in lzo1x_1_do_compress() when compressed page i=
s
>> point to the end of memory and which virtual address is 0xfffffffffffff0=
00.
>> Leading to a NULL pointer access during the get_unaligned_le32(ip).
> Thanks for this report.
>
> (...)
>> diff --git a/lib/lzo/lzo1x_compress.c b/lib/lzo/lzo1x_compress.c
>> index 236eb21..a0265a6 100644
>> --- a/lib/lzo/lzo1x_compress.c
>> +++ b/lib/lzo/lzo1x_compress.c
>> @@ -17,6 +17,9 @@
>>   #include <linux/lzo.h>
>>   #include "lzodefs.h"
>>  =20
>> +#define OVERFLOW_ADD_CHECK(a, b)  \
>> +	((size_t)~0 - (size_t)(a) < (size_t)(b) ? true : false)
>> +
> I think the test would be easier to grasp this way :
>
> #define OVERFLOW_ADD_CHECK(a, b)  \
> 	((size_t)(b) >=3D (size_t)((void*)0 - (void *)(a)))
>
> But the following should be more efficient since we build with
> -fno-strict-overflow :
>
> #define OVERFLOW_ADD_CHECK(a, b)  \
> 	(((a) + (b)) < (a))
Thanks for the suggestion,  I will change it in next version.
> Could you please recheck ?
>
> Thanks,
> Willy

Thanks,
Yueyi
