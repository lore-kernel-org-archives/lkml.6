Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB40DC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 13:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6749C2173C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 13:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="sOuWLUn/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6749C2173C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753347AbeGDN0P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 09:26:15 -0400
Received: from mail-bn3nam01on0058.outbound.protection.outlook.com ([104.47.33.58]:41757
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752712AbeGDN0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 09:26:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AmBdIC5NbiLrEwQZ8GYx5Fy+saRlfIXJ30gtVmKuzvo=;
 b=sOuWLUn/RBNNWavYFmusKhsYXqgjo13SHmvON+j4PlD4b0hM4aMxYc+fZGIExtDIB9+fbD7k3OiJi4iUboMHLthfl/9agohyBCCMSA5FpjMRkf34hRtqJDKdKNZgb92ejFahwdMuQDWa8gH/+ZiAAdFbGawlHZKM01bLP1uMUEA=
Received: from BYAPR03CA0030.namprd03.prod.outlook.com (2603:10b6:a02:a8::43)
 by BY1PR0301MB1223.namprd03.prod.outlook.com (2a01:111:e400:510f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.26; Wed, 4 Jul
 2018 13:26:06 +0000
Received: from BL2FFO11FD012.protection.gbl (2a01:111:f400:7c09::172) by
 BYAPR03CA0030.outlook.office365.com (2603:10b6:a02:a8::43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.930.19 via Frontend Transport; Wed, 4 Jul 2018 13:26:06 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; davemloft.net; dkim=none (message not signed)
 header.d=none;davemloft.net; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta4.analog.com;
Received: from nwd2mta4.analog.com (137.71.25.57) by
 BL2FFO11FD012.mail.protection.outlook.com (10.173.161.18) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.906.21
 via Frontend Transport; Wed, 4 Jul 2018 13:26:05 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta4.analog.com (8.13.8/8.13.8) with ESMTP id w64DQ4q4018529
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK);
        Wed, 4 Jul 2018 06:26:04 -0700
Received: from NWD2MBX5.ad.analog.com ([fe80::49e:7a9f:284e:1a49]) by
 NWD2HUBCAS7.ad.analog.com ([fe80::595b:ced1:cc03:539d%12]) with mapi id
 14.03.0301.000; Wed, 4 Jul 2018 09:26:04 -0400
From:   "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>
To:     "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>
CC:     "vilhelm.gray@gmail.com" <vilhelm.gray@gmail.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "Ismail.Kose@maximintegrated.com" <Ismail.Kose@maximintegrated.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "lukas@wunner.de" <lukas@wunner.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "sean.nyekjaer@prevas.dk" <sean.nyekjaer@prevas.dk>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "pombredanne@nexb.com" <pombredanne@nexb.com>,
        "davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [PATCH v4 1/2] iio: dac: Add AD5758 support
Thread-Topic: [PATCH v4 1/2] iio: dac: Add AD5758 support
Thread-Index: AQHUD4SdtmmrFRMjSk29o+RVSwiTwqR5likAgAXC5gA=
Date:   Wed, 4 Jul 2018 13:26:03 +0000
Message-ID: <1530710748.2057.32.camel@analog.com>
References: <1530261516-21118-1-git-send-email-stefan.popa@analog.com>
         <CAHp75Vfb_b6FPpnhu4Z_=iBNovNubneCD3cRG9SawRmMCNOVjw@mail.gmail.com>
In-Reply-To: <CAHp75Vfb_b6FPpnhu4Z_=iBNovNubneCD3cRG9SawRmMCNOVjw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.50.1.113]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <F363A1B650D45549B1E9E20282A22169@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(39860400002)(136003)(2980300002)(438002)(199004)(189003)(3846002)(39060400002)(106002)(966005)(6306002)(4326008)(36756003)(246002)(478600001)(72206003)(6246003)(2351001)(1361003)(2501003)(316002)(5250100002)(86362001)(2906002)(229853002)(6116002)(14454004)(14444005)(5640700003)(54906003)(26005)(2900100001)(436003)(6916009)(102836004)(7416002)(106466001)(2616005)(336012)(8676002)(50466002)(5660300001)(11346002)(426003)(486006)(356003)(23676004)(126002)(446003)(7696005)(103116003)(7736002)(305945005)(8936002)(7636002)(53546011)(186003)(2486003)(476003)(47776003)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:BY1PR0301MB1223;H:nwd2mta4.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2FFO11FD012;1:g5Lmp1EjxpaDJ2zBqYRjS/oZQ7DfaHGKKg4c9tDPAAT+nzOGEjtVjbGTrUX7MurCtRDZ2WE+vvYsSSaRPZFXkzyLpdqID0bJx34hFyp/DbSOjDSTqiMMs+SqnsLtMNUZ
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08cf45e8-1fe1-454a-6900-08d5e1b1b24f
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BY1PR0301MB1223;
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0301MB1223;3:L6GWeWKreYQkLOEp5m1EtRXY8wk4/xMXAfzCiNm8908rzHr1TumeOjoHqzAVeb2gL3x8sYT/nnHMj1yzX49xI4A9tbrQOMPpkZHJFwt+8w1OnmbSedEMRKg4clf6YMjffMgD/B1fMT4J4WNmKl9qbriLswEPeUkkMfre/FiR8q/qULkf2j8oR8f68hS0yJ8u541+NYUTAIbPYSRhepS3dDd/44qKoCQek/Io3RIyqoEaOklLoFgxoWvK9tARdyYUY9hmg6H8uRJ09pZhqxp5mEOU919+qfojEE2H49KgxslE/iYRgfXcjPPA8estfx4PS8qGBhfg/Z906KBX/M1LFmc/tk33+J2sxem/RTL+qSM=;25:+tlyS0yTsrGsVnnTex+Vj//6XMFod+9Yayd9do7Cl0l8lx/mJk3GPMo2DH5zuZ3hBzeFq2zzHr9qGrOfJ2VvKRQSrFOC5TclVt4QYecdg3FAotyVc137KIZDfqh/czFOHGz4/d2VFHmAoW9/617cWGqT0w7sbb8nhpmp2z5d1+Rdvi0ef2r9yKNMx5TdKau3FtPwbss0wHiyMt9uNPEQ4xg8SoCocKpdftXQ2cECc+hwr0UBCq6tiaP23s+vKWNVVf3M7zNB3ymZODhPw67YyMfKzZZfKp1z3jGR9IzVOm9KOBEcX+O/w3lDp/TD06nA+cS/NPWQo/5khu9kFjQpxg==
X-MS-TrafficTypeDiagnostic: BY1PR0301MB1223:
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0301MB1223;31:4a0NzjgNWfc7rT3gwXH9Fwh0/RnkDqmhRr6PHBPnR7tvXbyA9zvhA+RN/LadKDBUCk1jOkuwpljKC8SG9/y/+SzJ84kyFisvSPehJM2G/ohWoT44Fsh78fJKCTGzZ+4BvVZ9PEJa5PGQM7gaK500tZMW16EE8I8/bqn846gdaMnLMCVgr4aNVi2DyOMObMd2hGIDriywHdpnu0HI7TjBlWxzNh8bxXnyJ/tBBoIoV8Q=;20:wdXAr6Pi/5QTlSgn/BLqYh1fRzrv9Ycl5fnGUCKAlICLsz+ZC45B7ctwGPu+ykIl7sbEyfscr58dIf7wI4vG3KOYBhWWe+nf54sq/7q9YYkPeV24eDZYYXCBxgj80poyBMPK8Db64DN3OUQUS8+o7cGXEBB28YXXL7MNsQd/ZRXlXv98pipw1DGby2YDFfj5FxDja017Quadld/iYXh+P+rXjxpNd0718B9lKmkCweg2PiXU/9vIKSXqoCOLXUIYV0qx3/9NWzZpNewLbXOxCdO5KOiUn6zwDOpiQyYDvsU//6gLJp8ps/jwoH3QjL4SxTa2DKYPJHM7Od1bp8BwKJ4CnbZw0uDjgL22/t5FT1gCUL+Xv3aV2FBvE5AGOo3Qm19pmRJZpqi9vp3biZnWyjDfnQqTWqSp9VWFBNxh12W0Ri89DC2PcUWqXwF5zSadu6EVtMqpx0Wiiu0cOTjm31X4z6hWuvKOuQ7apDHH4vv3y0CCLIxExa6kHeRvxoQ8
X-Microsoft-Antispam-PRVS: <BY1PR0301MB1223688A9A848934F15BA3849D410@BY1PR0301MB1223.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(270121546159015)(232431446821674);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93004095)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:BY1PR0301MB1223;BCL:0;PCL:0;RULEID:;SRVR:BY1PR0301MB1223;
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0301MB1223;4:NNKhEWDS9yJtKmXxzJe7n20EhwIfLXUCVhGzjCqRuc0yUuobAV0oB3Ily0ECq+a2G2Fb4hVPTDa8TRZkdYRA+pV/qyA2E3h4oPsJK6DIt1oM/wYUCr5hUIjBcXNBN5qFRAT5qOsjBTrt/8V2UBaJGT2YxFP9C0Nz+bhy3id7ci5pzMYlTHAVW6jlQOWGg6bgtT6rCtPDfeioJNvFUquUl6mfYVfeed1Wn+9LD81EQPII3AvmDl3HmyDSeybCSGSWMT2wJybFE7TtEOqhUim9nPdmV0HxsLi9m0OFSeH1CH/scKb+6gyhHCJtHoj9DF52Z3HPhN1xP2aRVOQ1f94sZLEeP7wufzuYuKwivJ0z/NA=
X-Forefront-PRVS: 0723A02764
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWTFQUjAzMDFNQjEyMjM7MjM6MzFsSnBNenROb3VwR25nUVJLb3lWL0Qw?=
 =?utf-8?B?NmlPT1Z0VDNuK1VnTlp6QUt5SFpaUGZDeUIrL2ZPZ2hHVkNXdGg0Q3M0WnVh?=
 =?utf-8?B?dVB6RWNZY2o2b2NhdlZDVy9PQ0RsYzZhN3hSV1g1ZHV4WDFCVjZQMUg0dW0v?=
 =?utf-8?B?V0o2TG5Jajg4ODdxRklCTTlpQ0VNYmo1Y1VvNzl0VTB5Z21MOXZGZy9nbE1L?=
 =?utf-8?B?MHZNbzZrYTExc1YvMUJoaTJKMjRUUE81QURLeklCR1dWQXBZaWtWV1BCUzJE?=
 =?utf-8?B?Ui9FQU42Zk9pNUNZSWlVVEpoeXFFVVNSWDRRcy91bTlOaUF4cXlYQndNWk95?=
 =?utf-8?B?VzVGckF5REJjV1lNSmhsOGwrbS8zVXJpR0Z2Vk8zRHpnUUxZeU1IbzVnbnRq?=
 =?utf-8?B?Sk5SSDJ6TkF0STZjTzdrR2lSdmkwTE42VmdWT1pxdkxlK1MyZ1FnTTlCaWF4?=
 =?utf-8?B?VXVwaFNEWFRYQmVGTmJqNUNJTlliWWxUTnh0Zy9JRUxsYXEvODdmRndrSTNs?=
 =?utf-8?B?VVM1U2NER3poY2x5c24wZytlelArOUtSYVFVUk1xdzNoZG5PUDYwMFdqNHM1?=
 =?utf-8?B?Z1pWTkRIOHZmdUMwL1RCTEZyRzZGOVp2VGRlVVhaUGFmNWtkN0hnVHpuZlYv?=
 =?utf-8?B?ZDdLUjlEZmlXTnI4bU1xb0VKaXJwTDB5dWdCZkp6N0pLbGxweTkrQUZaV3Fv?=
 =?utf-8?B?UlZMaU1valJyNEZCNndRc09ydWJDVjJVN2YrS0tvYm9jMlhyQmRtRS9Cd3ln?=
 =?utf-8?B?dGFVUkhXcVJNK0NNN2VqbHlVNjB4Nm90Y1ViVGJvVzVTNmNqSGdaQTZBNEFx?=
 =?utf-8?B?TVdqeDVlTUF5NDV0TjJ2YnVyM01rRDJHM3dvV1c5MDZJeDh6YXFvYk4yMktO?=
 =?utf-8?B?bW12Y2pQSVRjdWIvK0ZyQTJCTW5MYnpKVHdZMVdnakFzQmRReUp3Y2ZITVBi?=
 =?utf-8?B?WVgxMlo1UHRuQmpEOVNHeHg2bHJsZVAzVFdqTzJpdERvbFF0c2lXTk5CVVJs?=
 =?utf-8?B?WTdXQ1VuN3FTYkFjK1JuTXZsYnVQdFpQcDdGK3FTTktYMCtyWElIdWQzZUZK?=
 =?utf-8?B?SFo0T0ljQzBIMG54M0JQeXV5d1N3RTBTNENNKzZxYTFEYzc2Z0VobXR4VFhv?=
 =?utf-8?B?ZnNEVWZKcnErVXpYZ1ZqVGV1SEV1K3VRL0ZqSys4d1VaanNEQlNneXowdWVK?=
 =?utf-8?B?aGJFcHJZaEVXVC9UNTVKMWx4Zm42Q3ZCem5DUmE5NnYwYzcyTklTK29vYzBa?=
 =?utf-8?B?Sy9FTTlHWjVqR2dwKzVtaWtQZ2kvWUYvemE2WHpaR0RNTFNkdFZXQUxBTzBO?=
 =?utf-8?B?eTZiVWpZVnBWYktqQ09RU09BbC8xSUNHUkJMQmtiMUhBYno1VlZ3ejlqMXBk?=
 =?utf-8?B?TGFNYUdmYlltVW1HTTZWaVYxTGFTS3lGdDBuY3gvNGM3amlTMVd1M0FWVExo?=
 =?utf-8?B?eGNwTmptZjlJaGxJTHk2T001NVhLV2M5R2twcllodFhOdVNyRTFFNE9ZbGpP?=
 =?utf-8?B?ZUhMQXRnMVNkeW9PRlhlbUpNL0VhaUtJNWx3aXlIa0xiVDZQRFhUaDZYY1d1?=
 =?utf-8?B?dmttOFlxb0V0RUE0ZS9SZUxoTFhKWVhOUWI2RmxubnBidTh6blhyMHhmdWNI?=
 =?utf-8?B?SGhDTUhvd3pFSWtOYWZpMkVPcVBISHVEMVMzZHZkc3VLMlJqa2NPTzFqUWJL?=
 =?utf-8?B?SHJHc244MWljWDlnM0E3bFRKekxiOS83R2orUHJkaWlGeUt3dWcyM1VzQTR1?=
 =?utf-8?B?YXcrbjdDazZMd3prQmZUOFdhZEZtWG1oSWxsZFhEai9mZkFOS01FYUE5TGtQ?=
 =?utf-8?B?Nndhd1VhVDNzaG13RG9RZG16dXRSWDhUNG54RW16QlBZOVJEeEorbVNDZDhE?=
 =?utf-8?Q?O/pU87qcVXHh4=3D?=
X-Microsoft-Antispam-Message-Info: Q8YkSl4om1tcr0P+wOFkG4sYdqObXi+fTA8TUMZ6Uov6LnNVgGCW+Ybiqbs0rT6oWVslUkEPIX9BUU5pNoEaoBrl5WSDmjNlyK/nLnagzlHXV2j/0dMD4sSc5ndgnHdtARZFd4+8yVDooPoHshS2CS5AI2bddOF+qgvgiHT68w3C1WDnARi6l4OcOcNTkC4keiMCD09TmlQGFRcoum97EZNXCevfs424CCXKMCelkML9pa5UartR8JL/RNnrqnpLoVgkX22oVYVQsu1W5aUZ0lEMxdNQXDR5fVEYsDnZ/KleZmS7ydyJu4OJGuQATJWqe5kzx4DFm65AJTFh4WDCK0bxxHMCfKw+q9uhIPz5Wh4=
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0301MB1223;6:6MxnfeDS6Rpq/7FzzfotC0mZ/UnQINRcA/teL/pWtdz7g9Gnxnxbn6uSXiVwBBQWmaGkWOpG22YiDy/uWbQcxtxCT7lXdZbDa3tleYoY93q6PtBbCA6QVwcDK2XF5T8XiVMKXFb9j3gnfkzEyX2QQToh4vVkefNOHhMdrqDsCI0inUwxR5/VtH0oYtV5CR3hMOFMloLcvvOmE26KM2rjOnrIMrZdM0iWd8n24yX85egv3yPzOBrJSU+/nZLvi1LjDFsJn7Q8J/AeyOFUN8WVK8CJOa89NEf8jhiZBIp2K2VT/ZcKlFQT63pgAekDuJGkbGAuBb0ADyS3OeVaU9gpa4POBUX12dT6omgOmm2m8EuurBs9qaVFMVwZVWSonV7z0Cffp0By2lTWIfSIHkGC4S1ZV07k376MTl9weg6VrpyYTU5HiRfpOXMICr+6CCl7JA3SkU/10k0GKC4Z5hos/Q==;5:YBFxIEYmdmNme+ib0DPf2tnZH1u2SD+nVRsLdXKtJbTQSn7702SDjEixZxcXiX26IW1SOBaXlLz/P5Kq2PkTzTBqCjfe/rCdQj6Gh2O5bU1kn9zYbkwZ0foHV+vtLmvNiyTScFeSYk/6c/Bsf2nkPnrW4SajIK7kzuDpcROfgs0=;24:Nt94TPj+Nef7ZFPt11ens/1WRHvZKaxpgDhEXdpAXVrbCB6gv7kFbpbr/tRsrk3eHY24yNJMMiHzqVsaGFFrrfixdm4HFV00ahNHm2T3FuY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0301MB1223;7:rQuLfWJnN8IPiFlPn9CjWNgjZM6BlcUtfu3MvUlj/v072KxXPKgRhxnk9OIASE6G5EAI21/2CRLnzq/Mj4Y1XOxIdJ3tP8dvo03/PAepf2cVSXVUdWZf0I1HQFw0yYRKr13WncD/zIKtiOBzCCnrh/mvFhCcGnCF4L5BooTAUF1cnLAwup/mzWVw1y9E7I2e/8DGcACLd/+gBAM+ReLdMPXWMpLcJv4U2ZzhaXNFjKYGp1KR9pXwE+xIGbNBKyWd
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2018 13:26:05.8709
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08cf45e8-1fe1-454a-6900-08d5e1b1b24f
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR0301MB1223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRHUsIDIwMTgtMDctMDEgYXQgMDA6MjYgKzAzMDAsIEFuZHkgU2hldmNoZW5rbyB3cm90ZToN
Cj4gT24gRnJpLCBKdW4gMjksIDIwMTggYXQgMTE6MzggQU0sIFN0ZWZhbiBQb3BhIDxzdGVmYW4u
cG9wYUBhbmFsb2cuY29tPiB3cm90ZToNCj4gPiANCj4gPiBUaGUgQUQ1NzU4IGlzIGEgc2luZ2xl
IGNoYW5uZWwgREFDIHdpdGggMTYtYml0IHByZWNpc2lvbiB3aGljaCB1c2VzIHRoZQ0KPiA+IFNQ
SSBpbnRlcmZhY2UgdGhhdCBvcGVyYXRlcyBhdCBjbG9jayByYXRlcyB1cCB0byA1ME1Iei4NCj4g
PiANCj4gPiBUaGUgb3V0cHV0IGNhbiBiZSBjb25maWd1cmVkIGFzIHZvbHRhZ2Ugb3IgY3VycmVu
dCBhbmQgaXMgYXZhaWxhYmxlIG9uIGENCj4gPiBzaW5nbGUgdGVybWluYWwuDQo+ID4gDQo+ID4g
RGF0YXNoZWV0Og0KPiA+IGh0dHA6Ly93d3cuYW5hbG9nLmNvbS9tZWRpYS9lbi90ZWNobmljYWwt
ZG9jdW1lbnRhdGlvbi9kYXRhLXNoZWV0cy9hZDU3NTgucGRmDQo+IFRoYW5rcyBmb3IgYW4gdXBk
YXRlLg0KPiBGZXcgY29tbWVudHMgYmVsb3cuDQo+IA0KPiA+IA0KPiA+ICsjaW5jbHVkZSANCj4g
PiArI2luY2x1ZGUgDQo+ID4gKyNpbmNsdWRlIA0KPiA+ICsjaW5jbHVkZSANCj4gPiArI2luY2x1
ZGUgDQo+ID4gKyNpbmNsdWRlIA0KPiBQZXJoYXBzIGtlZXAgdGhlbSBvcmRlcmVkPw0KPiANCj4g
PiANCj4gPiArDQo+ID4gKyNpbmNsdWRlIA0KPiA+ICsjaW5jbHVkZSANCj4gPiArDQo+ID4gDQo+
ID4gKyNpbmNsdWRlIA0KPiBBU00/IEhtbS4uLg0KPiANCj4gPiANCj4gPiArc3RhdGljIGludCBj
bXBmdW5jKGNvbnN0IHZvaWQgKmEsIGNvbnN0IHZvaWQgKmIpDQo+ID4gK3sNCj4gPiArwqDCoMKg
wqDCoMKgwqByZXR1cm4gKCooaW50ICopYSAtICooaW50ICopYik7DQo+IFN1cnJvdW5kaW5nIHBh
cmVucyBhcmUgbm90IG5lZWRlZC4NCj4gDQo+ID4gDQo+ID4gK30NCj4gPiArDQo+ID4gDQo+ID4g
K3N0YXRpYyBpbnQgYWQ1NzU4X2ZpbmRfY2xvc2VzdF9tYXRjaChjb25zdCBpbnQgKmFycmF5LA0K
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqB1bnNpZ25lZCBpbnQgc2l6ZSwgaW50IHZhbCkNCj4gPiArew0K
PiA+ICvCoMKgwqDCoMKgwqDCoGludCBpOw0KPiA+ICsNCj4gPiArwqDCoMKgwqDCoMKgwqBmb3Ig
KGkgPSAwOyBpIDwgc2l6ZTsgaSsrKSB7DQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoGlmICh2YWwgPD0gYXJyYXlbaV0pDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gaTsNCj4gPiArwqDCoMKgwqDCoMKgwqB9DQo+ID4g
Kw0KPiA+ICvCoMKgwqDCoMKgwqDCoHJldHVybiBzaXplIC0gMTsNCj4gPiArfQ0KPiBJc24ndCBp
dCB3aGF0IGJzZWFyY2goKSBjb3ZlcnMgYXMgd2VsbD8NCj4gDQoNCmJzZWFyY2goKSBsb29rcyBm
b3IgYW4gaXRlbSBpbiBhbiBhcnJheSBhbmQgcmV0dXJucyBOVUxMIGlmIGl0IGlzIG5vdCBmb3Vu
ZC4NClRoaXMgZnVuY3Rpb24gcmV0dXJucyB0aGUgaW5kZXggb2YgdGhlIGNsb3Nlc3QgdmFsdWUg
dG8gdmFsIGV2ZW4gaWYgdGhlcmUgaXPCoA0Kbm8gZXhhY3QgbWF0Y2guDQoNCj4gPiANCj4gPiAr
wqDCoMKgwqDCoMKgwqBkbyB7DQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJl
dCA9IGFkNTc1OF9zcGlfcmVnX3JlYWQoc3QsIHJlZyk7DQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoGlmIChyZXQgPCAwKQ0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIHJldDsNCj4gPiArDQo+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoGlmICghKHJldCAmIG1hc2spKQ0KPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIDA7DQo+ID4gKw0KPiA+IA0K
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB1ZGVsYXkoMTAwKTsNCj4gSWYgaXQn
cyBub3QgY2FsbGVkIGZyb20gYXRvbWljIGNvbnRleHQsIHBlcmhhcHMgc3dpdGNoIHRvIHVzbGVl
cF9yYW5nZSgpID8NCj4gDQo+ID4gDQo+ID4gK8KgwqDCoMKgwqDCoMKgfSB3aGlsZSAoLS10aW1l
b3V0KTsNCj4gDQo+ID4gDQo+ID4gK3N0YXRpYyBpbnQgYWQ1NzU4X3NvZnRfcmVzZXQoc3RydWN0
IGFkNTc1OF9zdGF0ZSAqc3QpDQo+ID4gK3sNCj4gPiArwqDCoMKgwqDCoMKgwqBpbnQgcmV0Ow0K
PiA+ICsNCj4gPiArwqDCoMKgwqDCoMKgwqByZXQgPSBhZDU3NThfc3BpX3JlZ193cml0ZShzdCwg
QUQ1NzU4X0tFWSwgQUQ1NzU4X0tFWV9DT0RFX1JFU0VUXzEpOw0KPiA+ICvCoMKgwqDCoMKgwqDC
oGlmIChyZXQgPCAwKQ0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4g
cmV0Ow0KPiA+ICsNCj4gPiArwqDCoMKgwqDCoMKgwqByZXQgPSBhZDU3NThfc3BpX3JlZ193cml0
ZShzdCwgQUQ1NzU4X0tFWSwgQUQ1NzU4X0tFWV9DT0RFX1JFU0VUXzIpOw0KPiA+ICsNCj4gPiAN
Cj4gPiArwqDCoMKgwqDCoMKgwqAvKiBQZXJmb3JtIGEgc29mdHdhcmUgcmVzZXQgYW5kIHdhaXQg
MTAwdXMgKi8NCj4gPiArwqDCoMKgwqDCoMKgwqB1ZGVsYXkoMTAwKTsNCj4gRGl0dG8uDQo+IA0K
PiA+IA0KPiA+ICsNCj4gPiArwqDCoMKgwqDCoMKgwqByZXR1cm4gcmV0Ow0KPiA+ICt9DQo+ID4g
DQo+ID4gK3N0YXRpYyBpbnQgYWQ1NzU4X2ZpbmRfb3V0X3JhbmdlKHN0cnVjdCBhZDU3NThfc3Rh
dGUgKnN0LA0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgY29uc3Qgc3RydWN0IGFkNTc1OF9yYW5nZSAqcmFuZ2UsDQo+
ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqB1bnNpZ25lZCBpbnQgc2l6ZSwNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGludCBtaW4sIGludCBt
YXgpDQo+ID4gK3sNCj4gPiArwqDCoMKgwqDCoMKgwqBpbnQgaTsNCj4gPiArDQo+ID4gK8KgwqDC
oMKgwqDCoMKgZm9yIChpID0gMDsgaSA8IHNpemU7IGkrKykgew0KPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBpZiAoKG1pbiA9PSByYW5nZVtpXS5taW4pICYmIChtYXggPT0gcmFu
Z2VbaV0ubWF4KSkgew0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgc3QtPm91dF9yYW5nZS5yZWcgPSByYW5nZVtpXS5yZWc7DQo+ID4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzdC0+b3V0X3JhbmdlLm1pbiA9
IHJhbmdlW2ldLm1pbjsNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoHN0LT5vdXRfcmFuZ2UubWF4ID0gcmFuZ2VbaV0ubWF4Ow0KPiA+ICsNCj4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiAwOw0K
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9DQo+ID4gK8KgwqDCoMKgwqDCoMKg
fQ0KPiBPbmUgbW9yZSBjYW5kaWRhdGUgdG8gdXNlIGJzZWFyY2goKS4NCj4gDQoNCkkgYW0gbm90
IHN1cmUgaWYgYnNlYXJjaCgpIHdpbGwgd29yayBpbiB0aGlzIGNhc2Ugc2luY2UgaXQgcmVxdWly
ZXMgdGhhdCB0aGUgZ2l2ZW7CoA0KYXJyYXkgaXMgc29ydGVkLiBNb3Jlb3ZlciwgYm90aMKgYWQ1
NzU4X3ZvbHRhZ2VfcmFuZ2VbXSBhbmTCoGFkNTc1OF9jdXJyZW50X3JhbmdlW13CoA0KY29udGFp
biBkdXBsaWNhdGUgZWxlbWVudHMuDQoNCj4gPiANCj4gPiArDQo+ID4gK8KgwqDCoMKgwqDCoMKg
cmV0dXJuIC1FSU5WQUw7DQo+ID4gK30NCj4gPiANCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgaW5kZXggPSAoaW50ICopIGJzZWFyY2goJnRtcCwgYWQ1NzU4X2RjX2RjX2lsaW0s
DQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoEFSUkFZX1NJWkUoYWQ1NzU4X2RjX2RjX2lsaW0p
LA0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzaXplb2YoaW50KSwgY21wZnVuYyk7DQo+IEkn
bSBub3Qgc3VyZSB5b3UgbmVlZCB0aGF0IGNhc3RpbmcuDQo+IA==
