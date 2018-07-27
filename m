Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D29C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 06:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3FFE20862
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 06:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="LslJpv66"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3FFE20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729442AbeG0IAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 04:00:06 -0400
Received: from mail-bl2nam02on0077.outbound.protection.outlook.com ([104.47.38.77]:47716
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725988AbeG0IAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 04:00:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wpjLhD2kkn1K3E5fstUF5M0xiVCruW9vRsFyQYjIwg4=;
 b=LslJpv66t8ONLHugPaYKGUsQQI8gydnz3md0GvXfNnGnQD7pXW6odRx8xThwdKnmR3UaMys2cSjABfZckjN6URw3q9RWl99Dx8CjyQegAAFctA2srD1K3syzfd/NHOyZ77lOtqZOQUMkWKzFueXbiYR7E3ubO+jl3q1t1oSl3M8=
Received: from BN6PR03CA0078.namprd03.prod.outlook.com (2603:10b6:405:6f::16)
 by BY2PR03MB553.namprd03.prod.outlook.com (2a01:111:e400:2c38::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.16; Fri, 27 Jul
 2018 06:39:38 +0000
Received: from BN1BFFO11FD008.protection.gbl (2a01:111:f400:7c10::1:106) by
 BN6PR03CA0078.outlook.office365.com (2603:10b6:405:6f::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.995.17 via Frontend Transport; Fri, 27 Jul 2018 06:39:37 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta4.analog.com;
Received: from nwd2mta4.analog.com (137.71.25.57) by
 BN1BFFO11FD008.mail.protection.outlook.com (10.58.144.71) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.995.16
 via Frontend Transport; Fri, 27 Jul 2018 06:39:37 +0000
Received: from NWD2HUBCAS8.ad.analog.com (nwd2hubcas8.ad.analog.com [10.64.69.108])
        by nwd2mta4.analog.com (8.13.8/8.13.8) with ESMTP id w6R6dbq7022143
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK);
        Thu, 26 Jul 2018 23:39:37 -0700
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS8.ad.analog.com ([fe80::90a0:b93e:53c6:afee%12]) with mapi id
 14.03.0301.000; Fri, 27 Jul 2018 02:39:37 -0400
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "hofrat@osadl.org" <hofrat@osadl.org>,
        "lars@metafoo.de" <lars@metafoo.de>
CC:     "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: ad_sigma_delta: use unsigned long for timeout
Thread-Topic: [PATCH] iio: ad_sigma_delta: use unsigned long for timeout
Thread-Index: AQHUImaGVASRMJSXGk6/BjK902lb0KShqmqAgAE8/4A=
Date:   Fri, 27 Jul 2018 06:39:25 +0000
Message-ID: <1284099be1e67ef443e7b7f0370db0a6b70cb48e.camel@analog.com>
References: <1532337518-30085-1-git-send-email-hofrat@osadl.org>
         <c07f288a40a3626d79a1b57173fa1a340afd3180.camel@analog.com>
In-Reply-To: <c07f288a40a3626d79a1b57173fa1a340afd3180.camel@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.50.1.244]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <8C0D13346F59A042AD19CF463CFF4C41@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(136003)(376002)(396003)(2980300002)(438002)(189003)(199004)(3846002)(436003)(4326008)(426003)(446003)(86362001)(2900100001)(6116002)(336012)(5660300001)(23676004)(2486003)(36756003)(6666003)(7696005)(76176011)(102836004)(6246003)(26005)(5250100002)(229853002)(186003)(316002)(478600001)(2501003)(2906002)(110136005)(54906003)(106002)(50466002)(47776003)(246002)(11346002)(486006)(7736002)(14454004)(2616005)(476003)(305945005)(356003)(106466001)(118296001)(126002)(7636002)(8676002)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR03MB553;H:nwd2mta4.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11FD008;1:uYefiiB7FdIwhY5q2PghDUe6DqoEGXPYt4te66XZBG+pWgk9FdwbaNEo1652b+LbAAxIWBk9lbMI+dNNu9jzaBLdZfQeVp5Z6Kwwf2qZpeO+px0O6brkTVULZysyBl3v
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1023ef1b-9ca2-4136-47a2-08d5f38bb946
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BY2PR03MB553;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB553;3:JRO1iZ8qP4WsKW91zyxpwiDoPuWlQhp1lPnCh3sWlvAj4daacK22otNkzRoeaG+AFvd4vZczb/n9ev4EIvxXjE16zKV1kUKW+fGpnka216xfV+psFnUBARVF4Ei7OuoePMJhKO0TS2OAa0HdF64EcD2BX93tn/shAoYtMpm+mKVEeoSNlZ7QRKqVndPy3TbQzT5BGjKwNvKRM1Ubo+KLufIuTokFBM04rpUZ7OpdJLx3LTARbBQqGSvGYDIaGsp6xaNpzZqiHZlZcY5MEzfAZuswCQI81o7UnU4G/UUop9bSkUL1um4uFmdP0yKnoP5ic41gTsNF06qLVJTiGJvpfQVKuNjaOnD6q1MCL369XbI=;25:U0lvRcC9f6YKrrk324SQn4TjhAekMs6V/4H0HNrH7zoG+9AcRTqEQcu/8N+BlOGYnxWyNU5kYnzRwU/Izb3W6W/cEfG24ul9ckxXVTiYOEab5FJXd3uupKP5fJ4/Ld/LODa895PxnIueQfn7iqtH3ZKj0ceMPEJYPqGTO1bptP3F89wLeaFzec6tDkSNyQ/g3J/uqoQYn9vZkfY1DF7z4BwLMnxjUpiGVLsR5PAFqjGxAaVCMCNE3NbOTyxZkX5YIdoXkHYiq86kM4BFoYGgjbOkZ/X91cwqepo6AGz4pHSSWbxo8XJO4/VaVRAbPBsk+YsIZs5J/lIN1Dy3pfic2A==
X-MS-TrafficTypeDiagnostic: BY2PR03MB553:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB553;31:8svuGIDqpp1qUmJulozSHMwzy/hHdnzF4khCHxmLjkYyJr//kMsw8YF32uwPlNGP1anmfY8H/g1tl2wdYtPiXG/WAl8sduKkExniFnKGPqbAdlRHYwMe7sYop+pL8jurAUraTwPjV1OX0XfkaLKD8d1k1k+8IT1klhttrBSq2Jali80Bezvz9Fv6MbTYdPTv/NkdqcqoMcrtHmPLao8vRmRqieV8TCLgwDroELPVPtA=;20:nHCZNf7XCYim4NLEuBrbPCOEb0yorxpxY2DgR9Ig6rx2ACEctcITwJdE/rrvNBRWFGYe2vfNkGxsQUTbIMsM2ZfV4/hsrGN5xlupbJ1SbR2zpfFqkDBfRfF8+L26vRrPZ3K/WkgQhGd6wnyuIAVn6xjcAUKJNGjkUMTa2hsir6RO22Wbua5G6k9bu6tnXUOoZ8XBEr1nmc5j4HGEVQYpojdu6p3Oo9sdYXsm1NIo2evpUAL6qJEX3BOwA2Ecv4A/3TT3RUqw3nwahplLUBqDMBDPUPd322in9ouhEb5gNOavZjjYzBkaU2jL4PK6+c1QcIxXniBx+byV1JUslOG2pUtN6JDSsOcQj4BNqy8FutPjFYbUb+v1Mr2Vq4DHiSJw0qzeI9xGsL/um8KaPzn8VV35d2rjdcWLlFW4w/LQ72SFqj6g1I8pfAbq2hn1oWCj7XU571b6fc2+jCQenmsHHixOr8rXyKte/lqGbcjDeFdEMkTctIswZY/JG/tVBQ43
X-Microsoft-Antispam-PRVS: <BY2PR03MB5534B5089ED749FA404672DF92A0@BY2PR03MB553.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(232431446821674);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93004095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:BY2PR03MB553;BCL:0;PCL:0;RULEID:;SRVR:BY2PR03MB553;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB553;4:gOI7MlCz4yLcg9xnJvEfwxMvJdX5DPeoLHODOIbMbCXJl1qfAfgmkAZ/Mbat13ot3syl6ep4ytea+8oj/GZFsoRrMX+slxPFSfiY/7UPsamhTBfuI1WvmKcy2II8sptDHQN7FjZw3Dq84iodBfkwiog+OdfvVdLvFGw1d+NGTxxatES8XyISB1lZrSkAGdRwIul+Q3Ax9MS+Cw/KGtHsQeg4LMsEPkKlrdragiv6GqCpArJZp5drWT8Rif87W+hG0N8kzVJckZht37wt6ULAgv8NLtc7RcxDEJt8T0n0WUe7auPcwSrRl4LI2Gn1MmEX
X-Forefront-PRVS: 07467C4D33
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWTJQUjAzTUI1NTM7MjM6NlM4dWIzV0Y3WTMzVXFld2p1bExKQjZ4blBT?=
 =?utf-8?B?cUNrU1hxaklXM3U0cXBCNHlMVGc3UHZ3RVJVcHQ1OTlReDcrRjUraVdmNzhy?=
 =?utf-8?B?aDVqSHA4bWRSQ3E2TEhoeklsSHpNL2F3bFA2dk1meVJuYlByRVg5Z1hSL3R1?=
 =?utf-8?B?Z2FtWmJUUVRUc1ZwUmlRVHJ0UG83SkE0ekRTYythaDFqR3NyanBnY3pZTWFF?=
 =?utf-8?B?QXFON2tYY0RHWW5neVR4OVphV0ZCUTRMOHZNL0tMaEZRREt5STh0Uy9XUml2?=
 =?utf-8?B?eHN2b2VPdVNSTld1dnJMNHp2YjJuNHc1L2p2cDJMcnRwQ0JLTzZ0eVBCT3Uz?=
 =?utf-8?B?dWpsVi8wVzlrRFFxRHIyTDRseEtKRkM2TzhpVTdGa1dqY2gwVGNtWGlSVnd1?=
 =?utf-8?B?dk1OdlhSQmt2V09Pc1dOMC9za3FsM2U1TmR6YTZJU3EzWldrWmZ1WnpIQndz?=
 =?utf-8?B?L2ozK2c0S3V3YkhpOTFaZHVlL1JqbTI2ZUhQQkI4a0xSdURpSG1yV056ZUtT?=
 =?utf-8?B?QW1hSGdNUUh1SXlrSlZCV3N6V0hWTVVPbWhQdnpHWENOYTlEOWtGNkJKK2Vj?=
 =?utf-8?B?QkhDaUd6ZTIySFZnWTVWTXVCczJPNkF6MEQ5N3ZueEs3S0pNVTdrNXBDUVZC?=
 =?utf-8?B?WENEUnFqZWRZUk12bk5KUGpKcTd5YURYbHN1dGRpQy9nN1N0amRqT292eWZz?=
 =?utf-8?B?TG41R0ltV0htWS9FRUU1cHhQcDFTS3Zyb085S0hHbGs4bEx3VUtmVjNCQUc4?=
 =?utf-8?B?aThWTk5YcDNiSGZBN2R6VTEyb2ZIaFZGY1V3T1BLb01Yc29CV0RPM1BuR3FP?=
 =?utf-8?B?MnFzVW9Cb3dqOGFTRVZhZWM1SWIwenlqdlQvVzNLUWhHNG5vamhoSllxYnpI?=
 =?utf-8?B?dVBraWZyeEV4eWN0N1ZHaEh0K2JKQU9FMzNtOUlmSFVxWDJQb1ArRjFzN3di?=
 =?utf-8?B?dUNYSEtycG9vM2lmUmpjNWxJRGlhbUJXWG44Ulp5elVwc0M0TmNJL3NkOTR6?=
 =?utf-8?B?V3VGVloyRzBOQXpyNGxFZTU3T2R1SE5WK08xeEdEek8xaGJSUlU3Qks0SEVJ?=
 =?utf-8?B?MmI5ZGo0aDFDRGQ1MU0xQVhMTEtaUGx5bXViQ2RUSjJFUDBIWktVVTlLSGFw?=
 =?utf-8?B?WXVlWVIvVmlkTTR5Y0JUb3RWWVNPTE5sT2Rvd0RKN2lhcFJrR1dOWEFBMDRy?=
 =?utf-8?B?cXBtdGNBNU9hOFVlUWtjSFB5d2FscVZxK1BWSWNkSlZHKzJwSHpCVnlQL01a?=
 =?utf-8?B?cnU0S2pHS09tQzNRZlhyN2NIajFjNFFRT09FRlVPcUtndGUzRDE1RkZqYU1T?=
 =?utf-8?B?V1pwVGN4eUh5Ull6SVRSRERFMDhGTWdEMjJkY1I5b1l2OFpWOUdTWVNrWGpy?=
 =?utf-8?B?OGRMQkNWYytyaGxuaXdxMnpycGxtVWdoem1kNVVRM2t6a2NNN1U1ZDB5SURX?=
 =?utf-8?B?V1Y5YmwvUE51N1oxa29Ob1M5ZzJ4NW1qMmRGTHJPRFhFb3NCcFZxaXppU28r?=
 =?utf-8?B?RHpCdjVQWmNUaHRyM25LZW1jVTRTRW1xSkI5bFMxREx4ZWdyOFZzK2ZEUVg1?=
 =?utf-8?Q?yadvKTa4RQl4Tm7Zz+ia8Zk77UvL/Vut8ci/trYhPEw=3D?=
X-Microsoft-Antispam-Message-Info: YTeD7cbb7nmy8ZwLPRrCCUO5kV2oMi69w6/Wrl5Q1g6O+ej8ZXQr0V11jtxuqDBX/rYgtyhalCG6YE79MzFBWQGOrUet2o2pIWdBmZikzaUDGInuSwIY9W2wkViFoqYR4xkbTTAXFzgmT40Gc6dn7Ei+03QZTVm8HXCeZBHfzVuVIy6w0jVyVK5ciuQePUQ4+3iwbHcs0LIeInBhWjkQoBXwO1Ly+MvVb8E7lS2FDWj18YfpJtyYtC/oZXcOukb428ITufSd4Pxfqh1HUIHOMj0xJwzfj94rl7OFskjLZ6Ytgi3QcqU71575QwN1hTwS4gdmCQKh3Q9ufC77Nyeiz37FtYyfrsdAl3hJUwqZ2bY=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB553;6:S6JSQU/Obi+QqhPW6Q1BWakospMqDxCcEOabGPychyuHN5bQyS5HUc3rsYgh+UQbPRprZS64sE3Nm+JCKHDYzoZSR1syKvsRdSVbwVhPOEFnEzkVGiArFCXWFXvHcUh45ejmIDE+9xApdPdSzrGpmFj/d2JqMyLDzp1wnthcOytRE4uCQ/rPQJ2vqQg9oekS6IYEkCcSDuVcQETL2ybILLSUtcSOd9L+OojjOrt/TmV0dIx0Iaj8CEwi9gkLkjzhFQrLt/JfwCCIVEY4clFjbQZupQ2cgyFPA4c9o16LfLElUzVvoMUK45r+ECUdBrYk+I+HMMyeTkT6uSz3MHjBByvr68CUIKMewltFPSdLk9BeRLRjJxxdqJSKftug7J3uQoaPvcu5jjUHSlRvxaE/3AD4SWKzYH6uk8q9crUzuup8FNJvih6zE8F1sUEBUTQVhLWcw3pMmV93uMsX9jXCcg==;5:VhF8D7LkV89xZzc+F2CG1hryWs65bBQS88zL9IX+QzNEJgONRmAkpcT1QuMGXPNa3tDb0s/88JJSu/9SSbOYvll93izm44f/wFsYCn/9weh497Z2oy/xztSHBnT3/cNTWJyX0RHjNlXlk/cgDtujcYGXndo9VGoZrJmirdk48Ag=;7:BfM6bLhJ47ikHv5BY9Jkk28qiil3QOziVGfc/RcIbyQXwmDQkHCDlkD9H7Px6s2PuQEjYbe0HmV860yrqduxNSUPj8FXCUdTq2t9fQ4vJ6e+VFBVA07K01Dizk5Q0hCmmTEU12hpB9OzyXxxMNXbyJCZJXv6YXSOje8jXMawObiZw7i7mT6pEXyhNF+AYHDcGZRXAqj+/xn8hFaSN8NX3EZ7N0C12AFmyrH4VeHcFzx2XkZ/iB5zNlhnz/ZvOrib
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2018 06:39:37.6094
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1023ef1b-9ca2-4136-47a2-08d5f38bb946
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR03MB553
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE4LTA3LTI2IGF0IDExOjQ0ICswMDAwLCBBcmRlbGVhbiwgQWxleGFuZHJ1IHdy
b3RlOg0KPiBPbiBNb24sIDIwMTgtMDctMjMgYXQgMTE6MTggKzAyMDAsIE5pY2hvbGFzIE1jIEd1
aXJlIHdyb3RlOg0KPiA+IHdhaXRfZm9yX2NvbXBsZXRpb25fdGltZW91dCByZXR1cm5zIHVuc2ln
bmVkIGxvbmcgbm90IGludCBzbyBhbg0KPiA+IGFwcHJvcHJpYXRlDQo+ID4gdmFyaWFibGUgaXMg
ZGVjbGFyZWQgYW5kIHRoZSBhc3NpZ25tZW50IGFuZCBjaGVjayBmaXhlZCB1cC4NCj4gPiANCj4g
DQo+IFBhdGNoIGxvb2tzIGdvb2QuDQo+IA0KPiBUaGFua3MgZm9yIHRoaXMNCg0KWyBJIGZvcmdv
dCB0byBhZGQgdGhpcyBdDQoNClJldmlld2VkLWJ5OiBBbGV4YW5kcnUgQXJkZWxlYW4gPGFsZXhh
bmRydS5hcmRlbGVhbkBhbmFsb2cuY29tPg0KDQoNCj4gDQo+IEFsZXgNCj4gDQo+ID4gU2lnbmVk
LW9mZi1ieTogTmljaG9sYXMgTWMgR3VpcmUgPGhvZnJhdEBvc2FkbC5vcmc+DQo+ID4gLS0tDQo+
ID4gDQo+ID4gZm91bmQgYnkgZXhwZXJpbWVudGFsIGNvY2NpbmVsbGUgc2NyaXB0DQo+ID4gDQo+
ID4gQXMgdGhlIHRpbWVvdXQgcmV0dXJuZWQgaXMgYWx3YXlzIDw8IElOVF9NQVggdGhlcmUgaXMg
bm8gc2lkZS1lZmZlY3QNCj4gPiB3aXRoDQo+ID4gdGhlDQo+ID4gdHlwZSBjb252ZXJzaW9uIGhl
cmUsIG5ldmVyIHRoZSBsZXNzIHByb3BlciB0eXBlcyBzaG91bGQgYmUgdXNlZC4NCj4gPiANCj4g
PiBQYXRjaCB3YXMgY29tcGlsZSB0ZXN0ZWQgd2l0aDogeDg2XzY0X2RlZmNvbmZpZyArIENPTkZJ
R19TUEk9eSwNCj4gPiBDT05GSUdfSUlPPXksDQo+ID4gQ09ORklHX0FENzc5Mz15IChpbXBsaWVz
IENPTkZJR19BRF9TSUdNQV9ERUxUQT15KQ0KPiA+IA0KPiA+IFBhdGNoIGlzIGFnYWluc3QgNC4x
OC1yYzUgKGxvY2FsdmVyc2lvbi1uZXh0IGlzIG5leHQtMjAxODA3MjApDQo+ID4gDQo+ID4gIGRy
aXZlcnMvaWlvL2FkYy9hZF9zaWdtYV9kZWx0YS5jIHwgNSArKystLQ0KPiA+ICAxIGZpbGUgY2hh
bmdlZCwgMyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2lpby9hZGMvYWRfc2lnbWFfZGVsdGEuYw0KPiA+IGIvZHJpdmVycy9paW8v
YWRjL2FkX3NpZ21hX2RlbHRhLmMNCj4gPiBpbmRleCBjZjFiMDQ4Li5mYzk1MTA3IDEwMDY0NA0K
PiA+IC0tLSBhL2RyaXZlcnMvaWlvL2FkYy9hZF9zaWdtYV9kZWx0YS5jDQo+ID4gKysrIGIvZHJp
dmVycy9paW8vYWRjL2FkX3NpZ21hX2RlbHRhLmMNCj4gPiBAQCAtMjA5LDYgKzIwOSw3IEBAIHN0
YXRpYyBpbnQgYWRfc2RfY2FsaWJyYXRlKHN0cnVjdCBhZF9zaWdtYV9kZWx0YQ0KPiA+ICpzaWdt
YV9kZWx0YSwNCj4gPiAgCXVuc2lnbmVkIGludCBtb2RlLCB1bnNpZ25lZCBpbnQgY2hhbm5lbCkN
Cj4gPiAgew0KPiA+ICAJaW50IHJldDsNCj4gPiArCXVuc2lnbmVkIGxvbmcgdGltZW91dDsNCj4g
PiAgDQo+ID4gIAlyZXQgPSBhZF9zaWdtYV9kZWx0YV9zZXRfY2hhbm5lbChzaWdtYV9kZWx0YSwg
Y2hhbm5lbCk7DQo+ID4gIAlpZiAocmV0KQ0KPiA+IEBAIC0yMjQsOCArMjI1LDggQEAgc3RhdGlj
IGludCBhZF9zZF9jYWxpYnJhdGUoc3RydWN0IGFkX3NpZ21hX2RlbHRhDQo+ID4gKnNpZ21hX2Rl
bHRhLA0KPiA+ICANCj4gPiAgCXNpZ21hX2RlbHRhLT5pcnFfZGlzID0gZmFsc2U7DQo+ID4gIAll
bmFibGVfaXJxKHNpZ21hX2RlbHRhLT5zcGktPmlycSk7DQo+ID4gLQlyZXQgPSB3YWl0X2Zvcl9j
b21wbGV0aW9uX3RpbWVvdXQoJnNpZ21hX2RlbHRhLT5jb21wbGV0aW9uLA0KPiA+IDIqSFopOw0K
PiA+IC0JaWYgKHJldCA9PSAwKSB7DQo+ID4gKwl0aW1lb3V0ID0gd2FpdF9mb3JfY29tcGxldGlv
bl90aW1lb3V0KCZzaWdtYV9kZWx0YS0NCj4gPiA+Y29tcGxldGlvbiwNCj4gPiAyICogSFopOw0K
PiA+ICsJaWYgKHRpbWVvdXQgPT0gMCkgew0KPiA+ICAJCXNpZ21hX2RlbHRhLT5pcnFfZGlzID0g
dHJ1ZTsNCj4gPiAgCQlkaXNhYmxlX2lycV9ub3N5bmMoc2lnbWFfZGVsdGEtPnNwaS0+aXJxKTsN
Cj4gPiAgCQlyZXQgPQ0KPiA+IC1FSU87Tu+/ve+/ve+/ve+/ve+/vXLvv73vv71577+977+977+9
Yu+/vVjvv73vv73Hp3bvv71e77+9Kd66ey5u77+9K++/ve+/ve+/ve+/vXvvv73vv70qIu+/ve+/
vV5u77+9cu+/ve+/ve+/vXrvv70a77+977+9aO+/ve+/ve+/ve+/vSbvv73vv70e77+9R++/ve+/
vQ0KPiA+IO+/vWjvv70DKO+/vemaju+/vd2iaiLvv73vv70a77+9G23vv73vv73vv73vv73vv716
77+93pbvv73vv73vv71m77+977+977+9aO+/ve+/ve+/vX7vv71t77+9
