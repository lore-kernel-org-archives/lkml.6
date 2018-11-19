Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C7CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 08:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 036A520823
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 08:09:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="u2vTgzPN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 036A520823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbeKSScV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 13:32:21 -0500
Received: from mail-eopbgr680049.outbound.protection.outlook.com ([40.107.68.49]:19296
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726348AbeKSScT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 13:32:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AdXn858etSyQtHYMv6XXSTLB7l5JYT8yDzawHcVpdeg=;
 b=u2vTgzPN78etKNBTcIiLkQfKuYiZJ2UkN8BJzX2N92jp56rnSef7RkExtLk1CqGM/nV0SejzQR0N3u+Qg3f015icFrt4CQI4lDBqd7F6R0ht2KqVQ8AHLpaU46WhyadsJ9p6l70Wd0MePrY6V0WVlPC7mKRunFJtMeGznCnb7Cw=
Received: from BN6PR03CA0064.namprd03.prod.outlook.com (2603:10b6:404:4c::26)
 by DM6PR03MB4459.namprd03.prod.outlook.com (2603:10b6:5:107::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1339.23; Mon, 19 Nov
 2018 08:09:24 +0000
Received: from BL2FFO11FD017.protection.gbl (2a01:111:f400:7c09::139) by
 BN6PR03CA0064.outlook.office365.com (2603:10b6:404:4c::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1339.20 via Frontend Transport; Mon, 19 Nov 2018 08:09:23 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2FFO11FD017.mail.protection.outlook.com (10.173.161.35) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1339.12
 via Frontend Transport; Mon, 19 Nov 2018 08:09:23 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id wAJ89MHF017062
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Mon, 19 Nov 2018 00:09:22 -0800
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS7.ad.analog.com ([fe80::595b:ced1:cc03:539d%12]) with mapi id
 14.03.0301.000; Mon, 19 Nov 2018 03:09:22 -0500
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "lars@metafoo.de" <lars@metafoo.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "matheus.bernardino@usp.br" <matheus.bernardino@usp.br>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "victorcolombo@gmail.com" <victorcolombo@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "kernel-usp@googlegroups.com" <kernel-usp@googlegroups.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 1/7] staging:iio:ad2s90: Add device tree support
Thread-Topic: [PATCH v2 1/7] staging:iio:ad2s90: Add device tree support
Thread-Index: AQHUfvbaf+iWkZ/dsUKO77yV/kumhKVXFDuA
Date:   Mon, 19 Nov 2018 08:09:21 +0000
Message-ID: <f250fa3a01b51d59979e7a2e3e42cc34d02aa52e.camel@analog.com>
References: <20181118042540.12697-1-matheus.bernardino@usp.br>
         <20181118042540.12697-2-matheus.bernardino@usp.br>
In-Reply-To: <20181118042540.12697-2-matheus.bernardino@usp.br>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.50.1.244]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <72787C8E45BB364DBADA0C540E2B13A0@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(396003)(136003)(2980300002)(438002)(199004)(189003)(76176011)(110136005)(118296001)(4326008)(7696005)(39060400002)(23676004)(2486003)(316002)(14454004)(356004)(2900100001)(106466001)(126002)(54906003)(486006)(6246003)(2616005)(476003)(336012)(11346002)(436003)(47776003)(426003)(446003)(5660300001)(8676002)(229853002)(246002)(8936002)(4001150100001)(7416002)(2201001)(2501003)(7636002)(7736002)(305945005)(6306002)(966005)(478600001)(106002)(6116002)(3846002)(102836004)(86362001)(50466002)(186003)(26005)(2906002)(36756003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB4459;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2FFO11FD017;1:kTHGZvauPldYMNEC0pEmGp0ewcP1Yx25jRHNCyXPqPUAaj07+6m2Dras/dr0OC5VWreib8Qp2470jFjjmZ6zHqGn1tuqLiMF7nJjBmVzQntZwAT1QnJtsBvQrXFgup/d
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 188444c3-d781-42eb-3936-08d64df6511f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060)(7193020);SRVR:DM6PR03MB4459;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR03MB4459;3:Fq3r2C6apRnIul1Ct9EGBpkhrIZ9rW9B/hm/xTGKdb/stFusDWfNojTyqrbft3r67KBulfEjm9qYBYyXMCcfGxGzRgDYBqoDO0UFIE+kYryzqKE9Q/nw7GzkPwZly+REBeB+jpjWbsnYFYC762XJFQq1r7Lsnf8sxSzOwEibYXsr1rn/p80De3GecVcSAgsAcAvwy2XhlXcHSX7+qveIqGJWZl2NoOxr16TUWixyBHC8Z0midDw8I/IAVHV2FJEae3p+JJi8Ag9YygiSVyI1dv24U60cS/eYsCTKUha4ve7Ngb0x55gTCqwNe9tr6BA0vIzfyDrTZzo6+LrkAJdWCpen6KlTVxelyYeN9nJtZeQ=;25:0llOgn366M7glseHuk+rn/m/+YCYottm9KCqZ5HgqbwXfCl4R3EN/pCv1a7LA/IO+3oBYcrCh95Qj2dx3diue/p2CojrSLa3lyMjly1nE7Z5Sf7KiWcoTXjvu5vejRqkA8fbgzYs1EcCRBiQ+oB9XSS+jnzvqJw3puT4wjltDnMeXhUxiaON+H10BIcXrDmyE9i7T3MYEezn4O4aZUr+jrqfPV5rXXmsbKSyzbhYx84iBZ8PU8qpUV3XahX/uU3+0FkQeHvXbsKkftdwi5fb78T3QrMr29iAK8+E1RCRNIPXmgWn2pQuDkURilZ1E+jbsgaF35/XBLg4vCwxcvK51A==
X-MS-TrafficTypeDiagnostic: DM6PR03MB4459:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR03MB4459;31:YMzItfrKDLVqHHlRlM2ImuNPxDJgMGUhZO5XXwHk0ruSkT8Mp3fiX1sh1EuAqqqZSATevgxVDqcPN30yT8ghxGPKnMZkX8NdOojlrCIueVjatqbguno9YUhxKcawDcnrystepWCutEzdNby++SgGpzO4Jn7snJMTqpB1MR381qhb9EU8f9B8u2jacS1OwHtnsfL6Yr2Im/rbzFWGe5VLgw31Bv+pYxwppyJVrPWQ03M=;20:+v5qeu1SUH1Ws6GE1tHLpsC5BpoYv/qJ5TzyfOo+pLpOe4Gjp+/eIe0ulJU/dbAIkerdktPpTrG+le/4h9/hSMPOPpbucG/V7HNIvURzVFDVrv9yPGaSjhAD/RXC12H+To4UYENaot53RbyfCJbLTEv+S6uD5WnzKF1i53K50FIfpxkIk7tvqbFFuXMztHGYmZhF38bIpMEDpriRqnyYFCgSE3HiFzy2AAhpPdhmmFvJ2Bn6NlEpV7j27TRwoQnrvbt+gmXa/fxUF+2WosLQE40laM96ciWp0aEVnggRMEEnaEMKk/E3y8+xfoulHkQNnlBxTQS3A4/3RBKrCv5VYGYTpCIUjA8yFFnNReh2JybYbQWZjWdqupXbRt9crYXiZHKm+tr8BcD18WbLxnFXs4qrnX8JOfwcYQbWOejFkxWgIFAi0P4bjwOCRlSJiRQlQZlJ1oza+zXW4Lczpn6rMCCJMlnY0k0nzalAuMAoke3/Gy6NoxfMi6FTl6OYd9TD
X-Microsoft-Antispam-PRVS: <DM6PR03MB4459CEF9561B05360A57FD70F9D80@DM6PR03MB4459.namprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93004095)(10201501046)(3231415)(944501410)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DM6PR03MB4459;BCL:0;PCL:0;RULEID:;SRVR:DM6PR03MB4459;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR03MB4459;4:9LQg2L6hdyzsg05QTU6/qmOyQf0Vyh/UBmvzAorIRQcdr8uKCsJt9uG0fOefygRwcxBhCSUdEzj8I5hxmoWcgmqUYA0FRy9nZeGzmQ9+o+ULPLlDS3+ddmpxfA1u2255Eri0XYlRPaOxKUH63qYpvYku2+m+JWiYwcw/waaF7wo0Fb7efq6tpQIAXRJs1KiV+ifVDPa28Nn8+luvsyLtmNnTqpHmvXUfYtUZ9r2xEM3yjxhst/YSFhLNZyZbrsjKQtSLwM4X+xE4OT2CB8edwQ==
X-Forefront-PRVS: 08617F610C
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTZQUjAzTUI0NDU5OzIzOjNvanBUVzJMS0c3cjNFR09zaG1EOGZIMEpW?=
 =?utf-8?B?MGpYTkVWM080bU5BNjMwcHNwVzdPa3FZZlNNN2lLSzI2eEY3bWNiQ1lhK3lr?=
 =?utf-8?B?K2NMM085RS9HS3R1MU5RNFJ0OU9XNUM3OHA2ZHorWGZUL0tNYWlJRUQyaUph?=
 =?utf-8?B?em5MYjJwSUREcHJsR1d2SG12OEZwVXJLZktqV3BEMjYxcnpwSUdvRnY4M3d2?=
 =?utf-8?B?NWtNUjBqWVZVSFNhWHJORWV6VytvSXJyalhTcEgrV0RpWFZ0YTRaRG9lc3I5?=
 =?utf-8?B?NGpoMVNjZWNqVW5oODVNeHRWVENjNlFERHRiTjVqcTZKNmF1OEVla3BZYjdD?=
 =?utf-8?B?aVhZVVAwY0I1RUliVDJzaUVJTVF5cGRIY0dWZmxpRnlsOXdkRGMwbnNxNFBj?=
 =?utf-8?B?UWxyTFlGSzZuMlcyNFY5WHYzQ1l3eS9nSnU1U0FGWmczMmYrTXA4cm53TEdE?=
 =?utf-8?B?MWQ4bStxaTRZNU5INk5oZXl1TXlzVEVtdWNTZ0NjRFFMWThKRGJjZGFYa0ps?=
 =?utf-8?B?dnNZZGdZa0ozWXpYZ3l1SFpiMHhqMG5XeWd4QUlqejFpUVBCb2xRSzcxUXds?=
 =?utf-8?B?YzNiS3JDY1hCL2YyQnlPMWlsY1RKT3VIWWhZMW1Ub2kxSUhhdGpCZ2RCcTF5?=
 =?utf-8?B?N2R6aU5HV21yWUFuRUlCT3RXOCsvWUlrOVBKWlU3NWtIbzY1M1YvdDUzVFlk?=
 =?utf-8?B?TjAxeDRLSSttSG9zeDVNR2tjV2Z6NExxRjRiKy9BYTdQWW9vV3JTQXI0cnBs?=
 =?utf-8?B?dW0zRzlCcm4vNmxlS1hySUc3UDJwL3VROURoR3BOMnlxSjVWMmc4S25kdUtK?=
 =?utf-8?B?cU9LcWNzeE9MM25maEgxVFpOdXpDSklFM2hHNEljMDBqNFR6bU5WbG9VMWJr?=
 =?utf-8?B?Q1ZMK0x1WmxVbXBOR243eDBvMVdCcWptdzNDbW9vejUybUo2eklTV1FUK1V2?=
 =?utf-8?B?RTNlSy9ubnIxYzA2N0REWWRBV1RtRjlFZEZ1TlNLY1dPaVBZRUFPMlFRYzRY?=
 =?utf-8?B?Y3o5Y2xTTE9XeGxORFdwbGlSVExvU3BvNk9OVGJ1TWZndkI4MVVXSHZuMDJz?=
 =?utf-8?B?WTRQMkNRY3UzeC9zSlZxYkF1Mmx2cXA1NFkyUEVUMGtJUGlsbWJJR2x1QzBM?=
 =?utf-8?B?Z1Z4YXZSREhjbWREOHFhd1V0YW1yZkpKZk4zOHJESXIyS2pXaFRRdE1hYWQv?=
 =?utf-8?B?N2V0dDBpZFF4cVR1NkhtVm4zaXVLc0l0VFVYbUdGbjZIM21QaU9nUFN4MUlm?=
 =?utf-8?B?QjNGV05BYTNBeUJWejZIOGVwSHl4STJPVVo1R1RmRzArTlc4OVlQLzBvZG8v?=
 =?utf-8?B?T0FkRzBlekJvejd4WDFuZGcwdVVZbzhiWi93cEFDbkY2cDB0NytPcjVkSXM1?=
 =?utf-8?B?ZVNCSDdZL0pkTm04MG1BRi9nS3RtYk5yQ3RjWkJxamRDVU1BZE9Xc3Q4VFM4?=
 =?utf-8?B?azFpLy92Y2Y0OXdObW5lYzJpMzFOcnpWMnVRWGx3Uy9iRkVQZUZ6bnBYQWhM?=
 =?utf-8?B?cVQvUnljZU1SM0hXeFNpeHM4OElKaFZ0bVI1VUJqTE4zMHVEUUpXaWFWcGlW?=
 =?utf-8?B?YmROclVvZ2kzS1dmREQrT2dSQ2J2R0RGZDQ4ajJuWlB1K2RBNEdTbHZEQWxx?=
 =?utf-8?B?bVlQdXBmR2d6MGlTejYwQUs3dHh5Y2FoK1FBcUxUbVFZZ3hGVzBlcENteHR0?=
 =?utf-8?B?c2MrY0NiWUozVFo1TjdZUlQ5dEx3eUZXRi9kM0htb0xtQm5FczlLREVuM2Q4?=
 =?utf-8?Q?QtBGqRsQ93hCdipuCQeeJ84uDA6hObWcadeOs=3D?=
X-Microsoft-Antispam-Message-Info: VyDIPM0S5XssBqGEOp8njb0MPK+a6w4saBYrz3/e3+PX8wyWakvJdesgqx3qAKyyk40HxG8+cAgFLKT7DouIDakxfbfNYFsHTf/7elbRceYtQ5kktbw00i/vv+nJNNwUe9MCuLmskOeIBhSoFCdQCJE4THv6OaOGnLYZMF/qgvPg/pLoTL7imnG23BHJYGe4qrljf8wRx146o0lnjv6zpYCF/vLiOzcRpvhSB4C60HWZgovOhOadTyw6res6+S5D/5OJoBLDDZvJOxWWsCuRdRScz6zVJj3Oy2BrfJhZgS2mbfBU05N6YJAtNt6etfvcJffKntdexG2iRsCp+WVCzPx6/yLOLXGIx/bTelHEOU4=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR03MB4459;6:2t9Oey89GCqptUQPZQ3qmKnqEYUf4BrsfDil/ZfzTgo4AdweUaKDHROt+rPs1mEB4fxSwHUH4cS3NN5/TB61NTeBBWYa6yDH2rY9ZgJFNlAhl2pHHianKv4MekM94Mlbk0axGwh9U+iF6bIIixS7t15JtTAieGohkmM7hIfdMyjMBEC7dNSyFH/tkoEibA5yG6A0T/dPVh7C6Zac8Opgs5IGuqj4exMFOGVbQ+4MYlRueDdwbur1erQiF1oGvEwduQ8hf2pQJU9L7UYFBocfa2NdqgoAJg80QryxBT5OfYYDXbucn2f6WZddaOMwzuhLan7O5E9PVOhaTKmezYMx7ApC7cCNZaGIg5iMnvfzkzeniCtVruTlUXbxMYRlECwr+OOttaHWv6CK4JXFiwP/l4SwJzGFKau/9yriVuh3O4JlnBlCDm8pKx/fdt2ojfePQpWLuic/h7U0KT7pVBY+PA==;5:WFDCgyKOKYTan/em6PPDHd5ZuZjDCPwCFRDH1sxJiDT/x2FJggyX5UmciwBCGSMrHyIFNcYNqSdPPnkc/jxpI5/7nC75ao7TUxV3Nc49OiUTzm0Cm9sHl5nzOp8r+Ubp+b28V+/pjrArU10nz/ZUuy1pnytIxjMrE/Tl0ya6bgA=;7:ZVvBu91NSGGuqnwFf5Ds+a/88D9M/ccLQJSfm/w50CdjXcOLqg3bhlW5iRDjIZl+YZW8/KFyKIl67n/sviPAZcF1WE5sq6f8kVj6g7qtdm532XkKp/+DNYsM2vo2zu/xbx1q/COC1tIDtlZyixzv1g==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2018 08:09:23.6704
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 188444c3-d781-42eb-3936-08d64df6511f
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4459
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCAyMDE4LTExLTE4IGF0IDAyOjI1IC0wMjAwLCBNYXRoZXVzIFRhdmFyZXMgd3JvdGU6
DQo+IFRoaXMgcGF0Y2ggYWRkcyBkZXZpY2UgdHJlZSBzdXBwb3J0IHRvIGFkMnM5MCB3aXRoIHN0
YW5kYXJkDQo+IGRldmljZSB0cmVlIGlkIHRhYmxlLg0KPiANCg0KSGV5LA0KDQpDb21tZW50IGlu
bGluZQ0KDQo+IFNpZ25lZC1vZmYtYnk6IE1hdGhldXMgVGF2YXJlcyA8bWF0aGV1cy5iZXJuYXJk
aW5vQHVzcC5icj4NCj4gLS0tDQo+IENoYW5nZXMgaW4gdjI6DQo+ICAtIG5vbmUNCj4gDQo+ICBk
cml2ZXJzL3N0YWdpbmcvaWlvL3Jlc29sdmVyL2FkMnM5MC5jIHwgNyArKysrKysrDQo+ICAxIGZp
bGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9z
dGFnaW5nL2lpby9yZXNvbHZlci9hZDJzOTAuYw0KPiBiL2RyaXZlcnMvc3RhZ2luZy9paW8vcmVz
b2x2ZXIvYWQyczkwLmMNCj4gaW5kZXggM2UyNTdhYzQ2ZjdhLi42ZmZiYWM2NmI4MzcgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvc3RhZ2luZy9paW8vcmVzb2x2ZXIvYWQyczkwLmMNCj4gKysrIGIv
ZHJpdmVycy9zdGFnaW5nL2lpby9yZXNvbHZlci9hZDJzOTAuYw0KPiBAQCAtMTA3LDYgKzEwNywx
MiBAQCBzdGF0aWMgaW50IGFkMnM5MF9wcm9iZShzdHJ1Y3Qgc3BpX2RldmljZSAqc3BpKQ0KPiAg
CXJldHVybiBkZXZtX2lpb19kZXZpY2VfcmVnaXN0ZXIoaW5kaW9fZGV2LT5kZXYucGFyZW50LCBp
bmRpb19kZXYpOw0KPiAgfQ0KPiAgDQo+ICtzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9p
ZCBhZDJzOTBfb2ZfbWF0Y2hbXSA9IHsNCj4gKwl7IC5jb21wYXRpYmxlID0gImFkaSxhZDJzOTAi
LCB9LA0KPiArCXt9DQo+ICt9Ow0KPiArTU9EVUxFX0RFVklDRV9UQUJMRShvZiwgYWQyczkwX29m
X21hdGNoKTsNCj4gKw0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBzcGlfZGV2aWNlX2lkIGFkMnM5
MF9pZFtdID0gew0KPiAgCXsgImFkMnM5MCIgfSwNCj4gIAl7fQ0KPiBAQCAtMTE2LDYgKzEyMiw3
IEBAIE1PRFVMRV9ERVZJQ0VfVEFCTEUoc3BpLCBhZDJzOTBfaWQpOw0KPiAgc3RhdGljIHN0cnVj
dCBzcGlfZHJpdmVyIGFkMnM5MF9kcml2ZXIgPSB7DQo+ICAJLmRyaXZlciA9IHsNCj4gIAkJLm5h
bWUgPSAiYWQyczkwIiwNCj4gKwkJLm9mX21hdGNoX3RhYmxlID0gb2ZfbWF0Y2hfcHRyKGFkMnM5
MF9vZl9tYXRjaCksDQoNCkkgdGhpbmsgeW91IG5lZWQgdG8gcmVtb3ZlIHRoZSBvZl9tYXRjaF9w
dHIoKS4NClRoZXJlIHdhcyBhIGNvbW1lbnQgZnJvbSBKb25hdGhhbiBvbiBhbm90aGVyIHRocmVh
ZCBhYm91dCB0aGlzLg0KU2VlOg0KICAgaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRj
aC8xMDY4Mjk2My8NCg0KU28sIA0KKwkJLm9mX21hdGNoX3RhYmxlID0gb2ZfbWF0Y2hfcHRyKGFk
MnM5MF9vZl9tYXRjaCksDQoNCmJlY29tZXMNCj4gKwkJLm9mX21hdGNoX3RhYmxlID0gYWQyczkw
X29mX21hdGNoLA0KDQo+ICAJfSwNCj4gIAkucHJvYmUgPSBhZDJzOTBfcHJvYmUsDQo+ICAJLmlk
X3RhYmxlID0gYWQyczkwX2lkLA0K
