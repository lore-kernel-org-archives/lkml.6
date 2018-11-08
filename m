Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E36A0C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 07:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F4C220827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 07:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="XfP4snA7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F4C220827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbeKHRTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 12:19:47 -0500
Received: from mail-cys01nam02on0088.outbound.protection.outlook.com ([104.47.37.88]:61664
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726162AbeKHRTr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 12:19:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=piRWYQnqaeirdnavCsAM8oIMBRfWsnZnj4cLVDwfZxA=;
 b=XfP4snA7YQJRKufE3izu2hk1mNOZ34ZC+drpSW2xYfSZCOckOVYP6IVX0ljHBTqpOIH1SZ7JZONltjVRbaWGcvnE3radj0HObdXaPHRu2M2WNXiO7/I3agRBTeygb3qiClzWjomFUBnJja6QNxhEgnyp5cMdQJLxMRwnQq8+Ri0=
Received: from BN6PR03CA0073.namprd03.prod.outlook.com (2603:10b6:405:6f::11)
 by DM5PR03MB3130.namprd03.prod.outlook.com (2603:10b6:4:3c::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1294.30; Thu, 8 Nov
 2018 07:45:27 +0000
Received: from BN1BFFO11FD002.protection.gbl (2a01:111:f400:7c10::1:175) by
 BN6PR03CA0073.outlook.office365.com (2603:10b6:405:6f::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.25 via Frontend Transport; Thu, 8 Nov 2018 07:45:26 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; googlegroups.com; dkim=none (message not signed)
 header.d=none;googlegroups.com; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BN1BFFO11FD002.mail.protection.outlook.com (10.58.144.65) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1294.14
 via Frontend Transport; Thu, 8 Nov 2018 07:45:26 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id wA87jQM6004909
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 7 Nov 2018 23:45:26 -0800
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS7.ad.analog.com ([fe80::595b:ced1:cc03:539d%12]) with mapi id
 14.03.0301.000; Thu, 8 Nov 2018 02:45:26 -0500
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "lars@metafoo.de" <lars@metafoo.de>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "renatogeh@gmail.com" <renatogeh@gmail.com>,
        "giuliano.belinassi@gmail.com" <giuliano.belinassi@gmail.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "kernel-usp@googlegroups.com" <kernel-usp@googlegroups.com>
Subject: Re: [PATCH 3/3] staging: iio: ad7780: generates pattern_mask from
 PAT bits
Thread-Topic: [PATCH 3/3] staging: iio: ad7780: generates pattern_mask from
 PAT bits
Thread-Index: AQHUdsrWXPOyVMJ4X0S4Sdp2uNsC9KVF1D0A
Date:   Thu, 8 Nov 2018 07:45:25 +0000
Message-ID: <75e7843ec80a3adc9f4b7ea0a7f0b33c3d518093.camel@analog.com>
References: <cover.1541615978.git.giuliano.belinassi@usp.br>
         <f7925df556f37f48ae0b1707239aff5a108fea1d.1541615978.git.giuliano.belinassi@usp.br>
In-Reply-To: <f7925df556f37f48ae0b1707239aff5a108fea1d.1541615978.git.giuliano.belinassi@usp.br>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.50.1.244]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <531BA28F46F78B4AAD67E5AD1AE7BAB5@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(346002)(376002)(2980300002)(438002)(199004)(189003)(106466001)(14454004)(186003)(8676002)(356004)(26005)(229853002)(2201001)(246002)(102836004)(2906002)(316002)(2900100001)(86362001)(47776003)(118296001)(50466002)(5660300001)(7736002)(7636002)(36756003)(8936002)(336012)(3846002)(6116002)(305945005)(14444005)(106002)(6246003)(39060400002)(436003)(2486003)(54906003)(7416002)(23676004)(426003)(110136005)(11346002)(446003)(7696005)(486006)(2501003)(126002)(478600001)(476003)(76176011)(4326008)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB3130;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11FD002;1:pQf2O3xvI4kdcB1t3U8UNvdmyi6eB4aQg80OQGxhWOpun5H6F67+5jgImk1rMYXO5h+9ow4jW3qYQaSUdvrHRxIR++vd/EPtNtVWe4KFVe4YVWtnLO+Tm1rDWz3WwFNq
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28644a0c-5d66-4fbb-07f9-08d6454e260b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060)(7193020);SRVR:DM5PR03MB3130;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3130;3:hay/dPAwL/G9/irnOSf+mwjutNxQaQprxrZniVz9hTxk4kIwuUo6cIw6FwTBmSCQojSlQkbJcs2bM6fnQCerJ1RMXzeGvolsaZVrCU96cCaP/ucJNnAiOde/POlXIjwCcqFFfr3kErpPvIV9Kky7y19bkpIcTj2DXmCAr5EzEzAlHUatAkXWcTduzbs5UjgdZ2fCH0ihkBrcncSP9GH4PyAzxlCJ2bMWApV2/bdyJHovmpIAA8TmmeVE2vXZbD+axr7Kc3gAORNuRFqLe59BxMUDCBfPJe/84oPnMlKLc1Rp5w/33a21XZY+di8cz03Ja7kCj2GsiBncXDGbaXhE73p+vKXknkIhIKmd+poRD5Y=;25:dFLg3ztlN//juQ0VUINh5/IuGycE588TeQ6Qr+Y7J08u8tYsmwBrDc0LI6nNEKgcq/0SL+llZ+0qm3b3/aBxki1zBaEKJs37C77GXrqKPJSuXYo7aFN2sYbkNNAVLlkGJGM8Jrtg4h351LbjUZ6oaKFCQlHzRwJ1Fsuj5ekwG94DKhs+dGG42vemStg5szlcljW5SH/0jTJIrVKxpJDdjCPKzllaDezPzqTNScSRw3Q/9mSNCGYiamXuCUxlmvbzcSHprR/lPX6WMqmPf6K32jwiSDv7bi0VhitbqlpLTIThnIu7XlvwB38iNF9FehNKQoMYjeMNkRSaVDQ0A0Sc+A==
X-MS-TrafficTypeDiagnostic: DM5PR03MB3130:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3130;31:CM/3E9bDKWSi3wFrYluhjwaUZhHkTiWTdAUf3X8uPSXfdphpoTxfVytRS79dXdezybw9VpAQJOrZfkRhs3EF26xmkumz1qTaeui1hmNEmQVe43IbRi48FwdNkRu5aZEWWl0GUY1Z/fba3qXfd6MmdAUq8MF5bx7rbVHucHyut73HucEYT+oi45yf4LIqUEL4vb2mCifKDnggnuaNoj7T+SAkCTiKPVYVszL9NxHQaCk=;20:2JqFv8Mwpv/321bjCG9pEExEVrgB0GlMReN7ecFQJ3YzkeqjOwyJedMuxxcnWAYK93RSPOB8pMz3WjzalBh0LjeebWGMXEGK8GeFOxisjG5nc3dceNxp10taB0an28lzK/ZPXR/5Ds9uoSzXq+5vW2jik5hY7tep+9AZ7Rf6Zug78AQRNo0dO/Py4cB+m5DqoemR2nwFaGDRtZzb54UEduxnT0cmzgk9DmT0sr30JRx3nXbFAyZ8WJW4ihNtorFE21bbA4KpbOh11YIZuspiYXECxojV+uygZirIkgbkyWc26LwF0kfu0+uLpQ3jvkQTPxb50IWiNCsv227ytFPb91olxQHSw0RAFlam8LrCoHQRALPQryospTCEAAerubdd+6MoEmj+xdcg0dZYSD+mn625smnzBpaqm+xqed1XOG/X7zRclFAyAMzLKyKfdaHSrFf3fNdfcMr4Hv9/OkxiZllmOeN1vmvQEkOxhXgksYeAno0kTL2u9wP3uORekxL8
X-Microsoft-Antispam-PRVS: <DM5PR03MB31305B977184B339747B5427F9C50@DM5PR03MB3130.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(10201501046)(3002001)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DM5PR03MB3130;BCL:0;PCL:0;RULEID:;SRVR:DM5PR03MB3130;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3130;4:UCVoJKTCbxGAw1nEh1ByvbDDmrizI8z/zQArvV0C+eYdCSxfcQPkHrwIdRo4XJMfsAlej6FbN9z1xGNwh7rsDQ54h8P2Pl27BzVRFDRztc4W8fhaLzkmaWtNSL0UjOINlJmjaFujdgS/TqPFcZCbSTzNJeWMB5JIMyEj61iK6ZRS8FfJYpU5+HGuE9BI4IcBkXb/nveE51PHeOhsbaW/b/j/XpYWLVz63NrTKvHiPPrkagbWgs3aLIeeST+4vhp6kMLJrpOWmYhnkNoD7PFO3A==
X-Forefront-PRVS: 0850800A29
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjAzTUIzMTMwOzIzOmE0a1FNb3pTazMvUTZsZkpnZHNTN09STVJt?=
 =?utf-8?B?Zk53WUt0WnBsMFRucjBCd2l6dTVteTQyc2tTZjM0Vy8zSng2TUlVcnY2eXo2?=
 =?utf-8?B?NGNjeEx3QmJXTVJCRlVDUUhmdkw0K2tiTHdHYXpWUE0rMXRCZ0ZmbFJHRUxl?=
 =?utf-8?B?ZUF6TUwvZkdxRWZjb2c5ZmtyNEN6Ty9obnRTTGI3d3pha0VEeHN3dVZ6S1d3?=
 =?utf-8?B?UVpYZ1k2Tm91bkJnelNJQXRGU0hOVE1HSDVRZ01JK3I3MHpBN1dLa0JoU1hk?=
 =?utf-8?B?WWdENjRFSWNPUVBzVVFxMFgyN2JVQ0ZyeXZmQmtPM3pBcFJXSDlsUjRySEgw?=
 =?utf-8?B?bXNoaSs0YlNIOHFuNVp2TFZtdXBvTmRaT0lsU3FXUXBmcndZK2JoRFJ2OEda?=
 =?utf-8?B?WEg3WTBTMGtuWnlSc0dSRmd0elk4Rll6WEdVdW56Z0wwVDJ3REJGS1p4QTRO?=
 =?utf-8?B?QjhjeWxFL0N2UlVETzZyVStYQlRoeDZtUmlsRU1idDlGRy9VNytRbWQyN0Za?=
 =?utf-8?B?aHJpNTdOVWp5TkJPdHE0eWtRWE0xcnlud0RqbnZHWlI0TVF0QXl6Tzkrbmc4?=
 =?utf-8?B?ZjhTOUtoRnFuTFRQNkt1TkVsRmduRHpxc2twNjZhMVJlMS9EOFJiNnhBYmVl?=
 =?utf-8?B?a3dPRXZCRWh5dVNlaEgyWjhod3FWdzVJa3RwVThqdnA1eEZibUY2RmRsN2I5?=
 =?utf-8?B?bCt0d1ppN0RBcU9zVkRhdnlxZFhjVUlKK1VCS2lDTVk3ZFd0WktSU2g3MGNt?=
 =?utf-8?B?RG5vaGkyN1ljZGphcmpTRGM5Z01FRkNLRWZheTQyV2dab0JCWXpiT2JBT1JT?=
 =?utf-8?B?dE1HZExhd0dNVTdiRlZ0aHV2c05BMkNaZm52eXFSdjBCYWdXdDNhY2FkRmFJ?=
 =?utf-8?B?Q1R2eDcwVGphUFB4QXhyVTc3aEtmZ3d0S25mUys1RVNkSUVFRTB4ajdYYmtI?=
 =?utf-8?B?TG1xQkdhUnRTWk4wczN5TGU0Mjl5N1RSNUZzQUdPdWJJZmxDMUROWHFiZVdQ?=
 =?utf-8?B?ZTV2VmlYODBvcVY2MHR0MGVvRnhjRTRhcUNISmZmN1VMc09IRDJvOHBHLzUw?=
 =?utf-8?B?VVNRYWE3TXhOYWxheG0yQytWL01jbG9ETHQ2TFlvSTVMZnNGWWhtd2RiZHFQ?=
 =?utf-8?B?aFR6c01neGR2Zlc3elRub2R4VXcrMHJVaElRempHZFprQWxiUXl3WHRTMlQr?=
 =?utf-8?B?TGU3emVtZHZPaU9NY2NNTkRzUksxRi9saGxLQ2FzeDI4RnAzQ1BGVnY0Rms5?=
 =?utf-8?B?Rk05MmQ3UVJrSDJmYUwrTFBqYXVHaTIvRkE3eWNhdGxrWnJIZDlXNVYzZE42?=
 =?utf-8?B?VkprUzhjWnVZWXAzb08xK1V6M1hoU0o1Ty9RWCtDMyt5L1N5L2hkNThaNWtt?=
 =?utf-8?B?amk5aGpxdkh6Uk1NVVgrenBYZ1EwRTVBblV3U3hvS09Wc0lTdFY1Yy92VktZ?=
 =?utf-8?B?dndiaGdUeWpheU03djdrSVc0MkxEVlJYYzliZlAyMi9vcWFsSDhIekhuSlJp?=
 =?utf-8?B?L3AvdmNaWExHaWJWOERJeFdOUjBNRDBiN0tBQlE3Y3BneWxoT3kxYm1EK1dR?=
 =?utf-8?B?eER2M0RGNm4yTWRnaFNQN3dsd1gwd1Q5bzA0Vlp2VThyaDhJMFQvWUVPNGFl?=
 =?utf-8?B?YzNyYjlCYk5ndkpFdWl1Sk9QSUhYSHpoSEJQdG1SZUhhTmU0T3BDQ0p3PT0=?=
X-Microsoft-Antispam-Message-Info: Z8trMUXun/jfeQw/XsKookrZDMX6tYSHw1MNYMaCJA2LAC7lwOxDbknQkB4F07K77hEDqVEKP3I1w9dgASx+Utsc/3KTWlTkFuB85Rwq7GAUR0Nop91PmFWiFBlmPNLaykGoG0POspiW78k5DMi2PfMaeT0AQPgygwO2I3QQgO7Vmb2Mn2YnIWKLGuFh5ERyaPm8UrCthjlYVOn+xkBVhV9E4p0bAS1f/e+eeDbACBwRA4DzTlINoCods7html2W9Ncobuy0UwTEXtBrgFHcGQtaLdG56cNHLNVaFiS6IIa81+E3vUYzUHCLXaXmya9MelI2JyHTq0U31GXOdIxYlAkX03yNjvi5xixrf21P4eY=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3130;6:hq6+8NEi2uNSsSnTdpBxK//lz67HN6h4UXnuIE49cPaZjOjsrwXCBn6ccPDzzYIcNUw34W+uZsECUOaMJbKojfuexbqqhCdAkHiaJ4JFxZ4JTtSDBCiX7Qlz1pIJPfCONC8ng0zJN+8TW1NKyx2gfdFPXMtJaunpR+k0cY2cArHF9UUOAfVFV0+5JK6gkM/EitM6s3XLh7angdsrY62k4cxVd1IfUhLfMIXh8OulpGIyAv++ul68hIbpbg7iRieYv2GMVYY2WuJDShACL5kHrajXi7y0M4eu1mWpZHBgpd1QBWXwz4ICtiLpYTgrZyp0JKBJxL/8EqupEY8zZvXqXGHlzVv12IGQBnkt3JvGfP7/LT+RTKjFCJsV3AiopjMYhHyTL7X41u7Sby8GJPBk8qavwrbPjIkmJQ82jTFaZ+8V/y1Df5SSfXi4CCjP/Yo46V7WM5pXjq4+yHtgZlI4wg==;5:IverGe9qQQuvP3hLe49WS90DCuPBQ+GKM/3qdEEQsn/23gbhvV4cZGdNpTwz+rc0COKV/x6//Y9e28xJ1zaKrZX0vCtJsD59t/yCGbpRNSx/Yb6qgUfmFeTdtUEKGQ1NCZnkhYKeryZAPK27FH2JlbW4ynnzVI21/2WCsRYQ9i4=;7:gtr/Xq8TEFBDIr7um7J2j5AFbi/McsvskkCB9xnyWK70ZP0+ie43DD4hSiybVU5pP2fCaY3R/ljblhWkBbqeyZiHPUT6LrSvQ1+TV4XhjBoas1455frc755SwyRe2B9oj+3BW8j0Kbxq+CcouOUArQ==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2018 07:45:26.6120
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28644a0c-5d66-4fbb-07f9-08d6454e260b
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB3130
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE4LTExLTA3IGF0IDE2OjUwIC0wMjAwLCBHaXVsaWFubyBCZWxpbmFzc2kgd3Jv
dGU6DQo+IFByZXZpb3VzbHksIGFsbCBwYXR0ZXJuX21hc2tzIGluIHRoZSBjaGlwX2luZm8gdGFi
bGUgd2VyZSBoYXJkY29kZWQuIE5vdw0KPiB0aGV5DQo+IGFyZSBnZW5lcmF0ZWQgdXNpbmcgdGhl
IFBBVCBtYWNyb3MsIGFzIGRlc2NyaWJlZCBpbiB0aGUgZGF0YXNoZWV0cy4NCj4gDQoNCkkgbGlr
ZSB0aGlzIGNoYW5nZSA6KQ0KSSBvbmx5IGhhdmUgbml0cGlja3MuDQpTZWUgaW5saW5lLg0KDQoN
Cj4gU2lnbmVkLW9mZi1ieTogR2l1bGlhbm8gQmVsaW5hc3NpIDxnaXVsaWFuby5iZWxpbmFzc2lA
dXNwLmJyPg0KPiAtLS0NCj4gIGRyaXZlcnMvc3RhZ2luZy9paW8vYWRjL2FkNzc4MC5jIHwgMTAg
KysrKysrLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlv
bnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3N0YWdpbmcvaWlvL2FkYy9hZDc3ODAu
Yw0KPiBiL2RyaXZlcnMvc3RhZ2luZy9paW8vYWRjL2FkNzc4MC5jDQo+IGluZGV4IDBhNDczYWFl
NTJmMi4uZmE5ZTA0N2I1MTkxIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3N0YWdpbmcvaWlvL2Fk
Yy9hZDc3ODAuYw0KPiArKysgYi9kcml2ZXJzL3N0YWdpbmcvaWlvL2FkYy9hZDc3ODAuYw0KPiBA
QCAtMzEsNiArMzEsOCBAQA0KPiAgI2RlZmluZSBBRDc3ODBfUEFUMQlCSVQoMSkNCj4gICNkZWZp
bmUgQUQ3NzgwX1BBVDAJQklUKDApDQo+ICANCj4gKyNkZWZpbmUgQUQ3MTcwX1BBVDIJQklUKDIp
DQo+ICsNCj4gIHN0cnVjdCBhZDc3ODBfY2hpcF9pbmZvIHsNCj4gIAlzdHJ1Y3QgaWlvX2NoYW5f
c3BlYwljaGFubmVsOw0KPiAgCXVuc2lnbmVkIGludAkJcGF0dGVybl9tYXNrOw0KPiBAQCAtMTM3
LDI1ICsxMzksMjUgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBhZDc3ODBfY2hpcF9pbmZvDQo+IGFk
Nzc4MF9jaGlwX2luZm9fdGJsW10gPSB7DQo+ICAJW0lEX0FENzE3MF0gPSB7DQo+ICAJCS5jaGFu
bmVsID0gQUQ3NzgwX0NIQU5ORUwoMTIsIDI0KSwNCj4gIAkJLnBhdHRlcm4gPSAweDUsDQo+IC0J
CS5wYXR0ZXJuX21hc2sgPSAweDcsDQo+ICsJCS5wYXR0ZXJuX21hc2sgPSBBRDc3ODBfUEFUMCB8
IEFENzc4MF9QQVQxIHwgQUQ3MTcwX1BBVDIsDQoNCklmIHlvdSBhcmUgdXBkYXRpbmcgdGhlc2Ug
cGF0dGVybiBtYXNrcywgeW91IHNob3VsZCB1cGRhdGUgdGhlIGRlZmF1bHQNCnBhdHRlcm5zIGFz
IHdlbGwgd2l0aCB0aGUgbWFjcm9zIHRvIGJlIGNvbnNpc3RlbnQuDQoNCkFuZCB0byBiZSBhIGJp
dCBtb3JlIGNvbXBhY3QsIHlvdSBjb3VsZCBkZWZpbmU6DQoNCiNkZWZpbmUgQUQ3MTcwX1BBVFRF
Uk5fTUFTSwkoQUQ3NzgwX1BBVDAgfCBBRDc3ODBfUEFUMSB8IEFENzE3MF9QQVQyKQ0KI2QNCmVm
aW5lIEFENzc4MF9QQVRURVJOX01BU0sJKEFENzc4MF9QQVQwIHwgQUQ3NzgwX1BBVDEpDQoNCiNk
ZWZpbmUgQUQ3MTcwX1BBVFRFUk4JCShBRDc3ODBfUEFUMSB8IEFENzE3MF9QQVQyKQ0KI2RlZmlu
ZSBBRDc3ODBfUEFUVEVSTgkJKEFENzc4MF9QQVQwKQ0KDQpUaGVuIHlvdSBjYW4gYXNzaWduIEFE
NzE3MF9QQVRURVJOW19NQVNLXSB0byBBRDcxNzAvQUQ3MTcxICYgDQpBRDc3ODBfUEFUVEVSTltf
TUFTS10gdG8gQUQ3NzgwL0FENzc4MS4NCg0KPiAgCQkuaXNfYWQ3Nzh4ID0gZmFsc2UsDQo+ICAJ
fSwNCj4gIAlbSURfQUQ3MTcxXSA9IHsNCj4gIAkJLmNoYW5uZWwgPSBBRDc3ODBfQ0hBTk5FTCgx
NiwgMjQpLA0KPiAgCQkucGF0dGVybiA9IDB4NSwNCj4gLQkJLnBhdHRlcm5fbWFzayA9IDB4NywN
Cj4gKwkJLnBhdHRlcm5fbWFzayA9IEFENzc4MF9QQVQwIHwgQUQ3NzgwX1BBVDEgfCBBRDcxNzBf
UEFUMiwNCj4gIAkJLmlzX2FkNzc4eCA9IGZhbHNlLA0KPiAgCX0sDQo+ICAJW0lEX0FENzc4MF0g
PSB7DQo+ICAJCS5jaGFubmVsID0gQUQ3NzgwX0NIQU5ORUwoMjQsIDMyKSwNCj4gIAkJLnBhdHRl
cm4gPSAweDEsDQo+IC0JCS5wYXR0ZXJuX21hc2sgPSAweDMsDQo+ICsJCS5wYXR0ZXJuX21hc2sg
PSBBRDc3ODBfUEFUMCB8IEFENzc4MF9QQVQxLA0KPiAgCQkuaXNfYWQ3Nzh4ID0gdHJ1ZSwNCj4g
IAl9LA0KPiAgCVtJRF9BRDc3ODFdID0gew0KPiAgCQkuY2hhbm5lbCA9IEFENzc4MF9DSEFOTkVM
KDIwLCAzMiksDQo+ICAJCS5wYXR0ZXJuID0gMHgxLA0KPiAtCQkucGF0dGVybl9tYXNrID0gMHgz
LA0KPiArCQkucGF0dGVybl9tYXNrID0gQUQ3NzgwX1BBVDAgfCBBRDc3ODBfUEFUMSwNCj4gIAkJ
LmlzX2FkNzc4eCA9IHRydWUsDQo+ICAJfSwNCj4gIH07DQo=
