Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C863C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 10:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0450221479
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 10:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="CFdENGFW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0450221479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbeJRSgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 14:36:14 -0400
Received: from mail-dm3nam03on0055.outbound.protection.outlook.com ([104.47.41.55]:32310
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727516AbeJRSgO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 14:36:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7vICQsMLy8L4QXpXcg9GH3YcPz9VT/EYZWEU8z4Yd9Q=;
 b=CFdENGFWha5k7olTgMyDa4dnOLyivqOnJythLEJqNmNNot8PuLdEi7Qf/NRX9ZXYeeybT39QK6r41o20aELQGL1/c38gHpM6RozZ5zh7vb6lwgXAjPWq9RMjH+YbRTu6lRrHFak5t+A1wsaw/84U4jNO66QNCife4G00PlJSSb0=
Received: from CY4PR03CA0101.namprd03.prod.outlook.com (2603:10b6:910:4d::42)
 by DM2PR03MB557.namprd03.prod.outlook.com (2a01:111:e400:241b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1250.20; Thu, 18 Oct
 2018 10:35:45 +0000
Received: from BY2FFO11FD019.protection.gbl (2a01:111:f400:7c0c::161) by
 CY4PR03CA0101.outlook.office365.com (2603:10b6:910:4d::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.20 via Frontend Transport; Thu, 18 Oct 2018 10:35:44 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta4.analog.com;
Received: from nwd2mta4.analog.com (137.71.25.57) by
 BY2FFO11FD019.mail.protection.outlook.com (10.1.14.107) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1250.12
 via Frontend Transport; Thu, 18 Oct 2018 10:35:44 +0000
Received: from NWD2HUBCAS8.ad.analog.com (nwd2hubcas8.ad.analog.com [10.64.69.108])
        by nwd2mta4.analog.com (8.13.8/8.13.8) with ESMTP id w9IAZhGi020910
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 18 Oct 2018 03:35:43 -0700
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS8.ad.analog.com ([fe80::90a0:b93e:53c6:afee%12]) with mapi id
 14.03.0301.000; Thu, 18 Oct 2018 06:35:43 -0400
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/2] dt-bindings: iio: adc: Add docs for AD7606 ADC
Thread-Topic: [PATCH 2/2] dt-bindings: iio: adc: Add docs for AD7606 ADC
Thread-Index: AQHUZsLaixS/NwXBaUS0h2Dgug26JaUlEikA
Date:   Thu, 18 Oct 2018 10:35:42 +0000
Message-ID: <66d43c0401e0899584665c7ddec5d36caae49a20.camel@analog.com>
References: <1539853956-26644-1-git-send-email-stefan.popa@analog.com>
In-Reply-To: <1539853956-26644-1-git-send-email-stefan.popa@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.50.1.244]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <ECA681831DD86E43999D19CFB96EFCB7@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(136003)(39860400002)(376002)(2980300002)(438002)(189003)(199004)(3846002)(4326008)(110136005)(11346002)(102836004)(246002)(126002)(476003)(446003)(2616005)(336012)(426003)(186003)(36756003)(6116002)(2486003)(356004)(486006)(26005)(436003)(118296001)(5660300001)(23676004)(2900100001)(50466002)(47776003)(316002)(1720100001)(2906002)(7416002)(4001150100001)(14454004)(8936002)(86362001)(229853002)(478600001)(6306002)(8676002)(6246003)(76176011)(54906003)(7736002)(5250100002)(966005)(106466001)(7636002)(7696005)(2501003)(305945005)(106002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR03MB557;H:nwd2mta4.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11FD019;1:QaddjRe42PbJmN7VQocRTK28ygP78tlwvLfddmC5iVDreNxXdSTBwlFIrZprGMRcMGBt8q0qW5Skf0HNGErGLvJ8Xg5qHzI0DX+Ek94p8YZZC1q5SLNxZfAmuzl8zNAv
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 046124d3-1f7d-4b35-d066-08d634e575d1
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM2PR03MB557;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB557;3:pBDSqLnQuu90pTIAgoKXV23QoKup411PDcaV4MaOXFhFE0dNeD0A7EhxvbV+9kZErOCi6aiCr71FdvlcdzSpSgdJw9ZgilraQXxzXJeU+/Ltv52olOYHY+yEFAqUzZ8Ig7r98pkZaVoK2VmoXodu/OLnyLQd8BHRaOKmvexnQRYyw/0Tdjco994VSCa94VhJEYedWzAefQ6slNLoq7u3T471OKhtk8eI5Qz3Gn2gs8JNrbXAH6gRgtvT/Tt/ErJj2bR5n1Dq5r6k4xmDCPN2nrDl/OykVd4hsxSWbqvVf4AL5ZvSuoz9GhBtDLolAIMEYx1DZth81x2TwmICJ2EQsSzWwKzNokoxuFA5Ez0cY+Q=;25:QDhL96VSIXYa7lwvyx6oQ8/vQxHcxJ3rcqva5/YrHwirLWmQDDMKL6HcRiHfJI3NfR2CQotBmQzHQvynSQMZIcMo76ls7wyc9fhMkKSrwZbALn81MvKeCkuM6ep3L7UUvxmWpPhhviEyr/1xihaddiyUcTGqncNJBViVc6iTwa01E/yIBZtiDcjJ4ItdRbYacLMy3c+gJxJSJ35zHf+tB5aGQKS1MCEs5iaYczfmud5Vh/Y2uZvTii6zTjKWYyfy8kSuegUXrW8y0LFjdsqzk3FBHqSvflT8Xep4WmXsg4wVhy2YeWGDevzEA0ZcXP0/Vh2dtRPVVNZjTim1vLFi0VM/cNrvgaSGN79U6V5MOXI=
X-MS-TrafficTypeDiagnostic: DM2PR03MB557:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB557;31:dNmZYD5TxJ32r5Jb/g9mXe7lij0i8bEMNfT4UtJHW+Wzluk5oVveReufxoWJsjAMRY4kwGCsIM6zbfCPe65+pdTpLl885BG3jEhoiCfT1bBm3Gh2dRn2H/Xo9/RUpXQfFKu96H3jAUZFBpBCt5r0UM/1SVIEbdp8+Up4jQMEyWj79IqgGqvWfI+OEDdKKelPeXvZDpmvT5o1vnHRI0NnoMacriBdrd5SxAm5Fqy1xsU=;20:Z7RHruDczBONzEQYOJ3NkK/4oDKCc20+xbHsuSwnEV6vJDwtJBBxj+Sw6p3a6lLrkeYhZznIRQwNdSadlawlXPXSgBumZ9UYcAZ8CrUbXqyHrHiCC2D+kfUmAgR0v1Mz4nimPgM+WjjWkr/Pz+nqi3L6RJsHkw2BzHavWXBcBLx7Ufl+BxuQXoHs5tzt9QrMBsd25ujyYmOm1PGetMPcKyHus57tvWcTuFUcYwbJYhTNRGRaED32oNMCpbQFMjtg3a23YXwphF3vv+rp07anq32lCHsuY78iQg8rzjNm81kbiKL5Q35LfEpiDP1IXmvwZYh21S1hyNoEr2mzw0nPbwA7vloljvL9KIZ6Nmp7QWDfp7tq5ewTqz9Xu6FpJge1pIy20o1POI+Zh4fZWR26YlkL69Hk0/coqI9isBXVH2mb4yhypLxuSnfzKegkzccXU3r38krwU4+gKI+T9FnbgTbSsgSnR2DHvmrdIAEAIaHNvkaSmu3Vd/a2iye8HAPM
X-Microsoft-Antispam-PRVS: <DM2PR03MB557C1BFFD1BD5395E4A8D3EF9F80@DM2PR03MB557.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(232431446821674)(9452136761055)(170811661138872)(95692535739014);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(10201501046)(3002001)(3231355)(944501410)(4982022)(52105095)(6055026)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DM2PR03MB557;BCL:0;PCL:0;RULEID:;SRVR:DM2PR03MB557;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB557;4:syzeq2OQT5CqOvtPNnlApG9gMw0IBxJkTJM8pky0Td4wBesR4EgAc7vGL92Rja30tIHTeX2oQyKoR7BvY04o2h5GpXaXGRXWHGEvbcM5A69U6t4kdnEX7yEneNV27dzAzbyUoIyfk/ojARn7rfQ8FfEeT/CJDeWjNhbC421uPIVGxTUHFOlqRhZxBTYwlX90dIvhEvCUyxbxz10jATJCh6IVJykAYzmJzb/VhIdp3MsvN2+uWl3TWDyQkMMoGURtMbkGg/S4l8XObSTQQA6Y8RUjLeW4k+HAYuZ2GiWFpy05volAck3kbabEjwR4WjQNdj9001P89Q3OCIaUwSotYyNmDELUcjQqZxnFo1Tgy5+y7VHWB6hcKwvhcPIxst3JkG8Ou5zZ4Ui1vG70+v1c0XAd2eaQZXLc0MGZy/qHaPU=
X-Forefront-PRVS: 08296C9B35
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTJQUjAzTUI1NTc7MjM6OXo3aGd3Qkx2YTJnb2E2MmpSRk5hNnpFWk4r?=
 =?utf-8?B?WkNOZGwxMWVIVmI4VnNleG1rcXkydXBkTWx3S0VFdUlMQUE4WGRzaTEwb2E1?=
 =?utf-8?B?OVRjRE9SMTBnL2lKc08zRWVJTUlUVWQ2YXZEY0RrK3p6QVdDOU8zd3NiTE8r?=
 =?utf-8?B?Z0xjTUFXLzFyczE5V2pnRDRVcTdJMHhSVGNMQzFqd0JScTJiTVkxbkthdTBv?=
 =?utf-8?B?eEU3Zldrc2E3ZTlOcENETTRIdmxlRjFuMThOMStLZkxtUGppNjVxOFVydHF4?=
 =?utf-8?B?cW5vYkVXb3Y0NjVJcHEvVWxaZ0JBUkI4SmpNOG5OMDNucmdDTlZWSmFJVmRZ?=
 =?utf-8?B?VmoxZmFGNlh2WWx3OFUzSTJvNS9kcW45blRlKzAwM3ZuR25GY0dZbGVCZ0RN?=
 =?utf-8?B?Smt4OFYwVGpzQlN5dzNkamRDSTYwWVVhaE1CRjdkK1BNbmQrOXExWmYrNGMz?=
 =?utf-8?B?QXNPdzJLKzlDcEVpSVl3Szg1Z0VVc1BLaWFONEVOZlE4S0hGOE5OWkJlQ3Bi?=
 =?utf-8?B?L1VlaUhLK1M3TlA3MlZERm43TUtiTTJQc2VLNmlUeUFtaEZYVU8yQlJpL0lk?=
 =?utf-8?B?djdETnRTTmRiQTZ0UURWMjZ4WmZZNVRkZm9DVVhBWWRhNGgrTDRqenBVNlJF?=
 =?utf-8?B?TzN5QXd2TCtKQ0xZZzduYmRVRU9BbDAwcm1VeWNYREx3S1RLV2FtOWRjOVBp?=
 =?utf-8?B?dFYreTVxaHpodmhzeHVwWEhhZS9wLzBML3JKbmM1cXJEL0ZudmhwU3AyZkky?=
 =?utf-8?B?VVJyT011d0M2R1ZSbVk2dmhVblEvS2xjMWloeWZxcHMrSTR3aEU3dXlBTUJR?=
 =?utf-8?B?KzlRa0ZIS0RrOFFocVBuS3JaWXdMS3d0aUdMdUdWZ2cyZHZ2ZzRySktBNy9Y?=
 =?utf-8?B?Y3M2OXNieHFCTUVDRGs3eTZoNXcvWmo5SmZJL3V2L3JMejFaNUF2ZTEyRWgz?=
 =?utf-8?B?R2IxekcvQ2hLd1hYaytyZkFFS2QrajdmUloxNFc1aXZmOUVwMFZXZUhDUXlq?=
 =?utf-8?B?a3lScW5INUVPRlE2anN5MG9YWHl5NGNkQlZiTm1lemZaRno4NWxTTmpkOE9C?=
 =?utf-8?B?c1RpaFp5WlNSWjUwZGVhNm5CSVI5TWpvYStPMHB0TGpFODdYL3V0bHlWZS9T?=
 =?utf-8?B?aFVPeSs1VklZSFZHUXlPbS94cFVocXpWdXJ3MDkrbktwRHIvYWxORmJGRkZJ?=
 =?utf-8?B?M0FsTUx3dU5CVGZxcFlEVEIvbzFicWpDVEV4TlhZUFY3K3YxcFJDK0l3WmQw?=
 =?utf-8?B?QXZrdlpUNVRzY0Z4YXhFYllzUEVRWUd1YmpCeHROdEIxZVZlTm1HUzNpc0Mx?=
 =?utf-8?B?UVFjcmhabE5LK2tFM3kxL3FnWUtPcXpQeGliSHMwMVZDMU80YTVPQlBPekZq?=
 =?utf-8?B?WGkxMGsvOW12Nzd0WG5iSWNpRHdrOFExcDJ5STYvNXhWRkNmQVU0ak5tcGxx?=
 =?utf-8?B?c0N6SE5kQ3kxMVU4THh2dm9NVi9halhTSjd5dmE4RHVRUU9VUlpFR05lOFY0?=
 =?utf-8?B?Z1lWcHFtUVl3dmFkWVBINE9OZmNFcTQyK0NWdHpSL3R2OE9Kck9yb1k2dDdI?=
 =?utf-8?B?V1ZnNEhld0RRL2Qxc0pGN2xjaTNqSFYyMUFrRkZCVExzZno2NUV2YXF4MTBr?=
 =?utf-8?B?ejg5SUpIYlFZMUFXNVhOZFZ0VnlteTFkbC8vek1uQllaVWdIK2tXV2ZwMWdl?=
 =?utf-8?B?UGR6aTdkMVcySUhUcTJTV21qVnBsVWVVMGpaK3ZBbU9hSkU4bEF4djRsbXpk?=
 =?utf-8?B?cks5SEd0VEU3QkJrVm9RPT0=?=
X-Microsoft-Antispam-Message-Info: VNzoW2CJI6UhURoVoCqn8IA8u0tXh9CV1SdsX9C2k7mhA/J3L1l2U0lL5MZiwLfqQmRKs3uH+oNfzEUQA4Dm7hU9Y6eBGUy4P3/qx2I/q+IJmMA9xhzOpxHAnEJaHtuI8D68kEp3+6+KEPklssGsj5Z/vW5APjJcjYIZrhFSAbtGKOTgE46PiptOj1YkPvmq6zE8KSETSUfN0B75jaNOAmbozRMbLGgWFTLP5o3a+EivwygDlxvFy1MutzJWmNZi4/iRsJXhTlMYuJX0N2uBfPgqCtw2ooeYLtCBTD6js9rpd9nARH1kO4uFRy2f6unEntvBSrmPod9TT1VpjHvw3O3SPS3bnY6cAfJ+3Puts7c=
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB557;6:hGs3e9tE54snTP1j2QiZ08l1/9gmC64VRdwPR+9jATkYbojC/6KhwTBsJdcSfSlPtaIukcbXvfOoKK93hPbLO0WsS2du93GBm/5Yi7fGsvt6bLWLNPnaKXnYYqYfL7U2UHLtc138BGH6B8ekqmwk7HEyvrHkenqVGIzEirZ3FWTgAUfV6Km5pLteyFIMXwVN8I7Q6aoGSQDok3m1wezQ9JUmhk/zuCAIo2y4HzN6JrvVZ1M1oOVc66LqXwF8EGkYj5TNpKuhBBF3TlbEhNbKaoMhEVVXYZ85WxwOxVPj9cPxBs53T8vuMvaoUzhfb118fWr+WjL6b9KFzbkf93McGSF7ifIal7x9gh6+mrgc0jg6Ndm+29Ov+OJdhvO3wmA9e03JJiYPvOdHcLkr+uqoZqi1Rmx4r3LoRiy2Pg37mtDg+hgTqHm8crukfZcmZ4XvI3I8LbvdvR32ZjIOZ6y9n8uqQBAisutJnA2sBYPlJls=;5:BRCxPXMJmeQ6Km/50Lp94ab+vbAvudT85bZDds0lTx4U2h9tZ/JynQ4lMeBudrdTuBCxy6Ztis2dU1g7+3HJ+AEfrXmpi99F8IHSVoo0uBcm6rEmwq6Yg66WviBThTGbkjbk2PYe+e+N7dG7f0xElvOWUh7o2otzLbbj+oXft/M=;7:lmJyVXT4LimEw/Sxl7iOVdQmpZXZSixTjPYdrUvalOz/o8+FQ6zuX8rdEf3ihoWpVkFPR4R1k6VoHzPQX92acUUT2+ppiq5bBUfewC0XAyEFTbVGlcPp9RJGjwe0c+H9T4sPVgoFMbmovXth1wj4fV8LYqDdGPUWx77zxKmwZt8GOtF9VvFz4fUCY/zEoSikTZYEZFK+bAorL/Y9f0E3W58H79dWLAe+8caZEzgaW+5PF/Hr5qll4Lb3yytF248n
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2018 10:35:44.5374
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 046124d3-1f7d-4b35-d066-08d634e575d1
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR03MB557
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE4LTEwLTE4IGF0IDEyOjEyICswMzAwLCBTdGVmYW4gUG9wYSB3cm90ZToNCj4g
RG9jdW1lbnQgc3VwcG9ydCBmb3IgQUQ3NjA2IEFuYWxvZyB0byBEaWdpdGFsIENvbnZlcnRlci4N
Cj4gDQoNCkNvbW1tZW50cyBpbmxpbmUNCg0KPiBTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gUG9wYSA8
c3RlZmFuLnBvcGFAYW5hbG9nLmNvbT4NCj4gLS0tDQo+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5n
cy9paW8vYWRjL2FkaSxhZDc2MDYudHh0ICAgICB8IDUxDQo+ICsrKysrKysrKysrKysrKysrKysr
KysNCj4gIE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHwgIDEgKw0KPiAgMiBmaWxlcyBjaGFuZ2VkLCA1MiBpbnNlcnRpb25zKCspDQo+ICBjcmVhdGUg
bW9kZSAxMDA2NDQNCj4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9hZGMv
YWRpLGFkNzYwNi50eHQNCj4gDQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvaWlvL2FkYy9hZGksYWQ3NjA2LnR4dA0KPiBiL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9paW8vYWRjL2FkaSxhZDc2MDYudHh0DQo+IG5ldyBmaWxlIG1vZGUg
MTAwNjQ0DQo+IGluZGV4IDAwMDAwMDAuLmRlZGU1ODENCj4gLS0tIC9kZXYvbnVsbA0KPiArKysg
Yi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaWlvL2FkYy9hZGksYWQ3NjA2LnR4
dA0KPiBAQCAtMCwwICsxLDUxIEBADQo+ICtBbmFsb2cgRGV2aWNlcyBBRDc2MDYgU2ltdWx0YW5l
b3VzIFNhbXBsaW5nIEFEQw0KPiArDQo+ICtSZXF1aXJlZCBwcm9wZXJ0aWVzIGZvciB0aGUgQUQ3
NjA2Og0KPiArDQo+ICsgLSBjb21wYXRpYmxlOiBNdXN0IGJlIG9uZSBvZiAiYWRpLGFkNzYwNS00
IiwgImFkaSxhZDc2MDYtOCIsDQo+ICJhZGksYWQ3NjA2LTYiIG9yDQo+ICsgCSAgICAgICAiYWRp
LGFkNzYwNi00Ii4NCj4gKyAtIHJlZzogU1BJIGNoaXAgc2VsZWN0IG51bWJlciBmb3IgdGhlIGRl
dmljZQ0KPiArIC0gc3BpLW1heC1mcmVxdWVuY3k6IE1heCBTUEkgZnJlcXVlbmN5IHRvIHVzZQ0K
PiArIAlzZWU6IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkvc3BpLWJ1cy50
eHQNCj4gKyAtIHNwaS1jcGhhOiBTZWUgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3NwaS9zcGktYnVzLnR4dA0KDQpJIGRvbid0IGtub3cgd2hhdCB0aGUgdHlwaWNhbCBwcmVmZXJl
bmNlIGlzICh3aXRoIHJlc3BlY3QgdG8gU1BJIGRvY3MpLCBidXQNCkknZCBqdXN0IHJlZmVyZW5j
ZSB0aGUgIkRvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkvc3BpLWJ1cy50eHQN
CiJkb2MgaGVyZS4NCg0KPiArIC0gYXZjYy1zdXBwbHk6IHBoYW5kbGUgdG8gdGhlIEF2Y2MgcG93
ZXIgc3VwcGx5DQo+ICsgLSBpbnRlcnJ1cHRzOiBJUlEgbGluZSBmb3IgdGhlIEFEQw0KPiArIAlz
ZWU6IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9pbnRlcnJ1cHQtDQo+IGNvbnRy
b2xsZXIvaW50ZXJydXB0cy50eHQNCj4gKyAtIGNvbnZlcnNpb24tc3RhcnQtZ3BpbzogbXVzdCBi
ZSB0aGUgZGV2aWNlIHRyZWUgaWRlbnRpZmllciBvZiB0aGUNCj4gQ09OVlNUIHBpbi4NCj4gKwkJ
CSAgVGhpcyBsb2dpYyBpbnB1dCBpcyB1c2VkIHRvIGluaXRpYXRlIGNvbnZlcnNpb25zDQo+IG9u
DQo+ICsJCQkgIHRoZSBhbmFsb2cgaW5wdXQgY2hhbm5lbHMuDQo+ICsNCj4gK09wdGlvbmFsIHBy
b3BlcnRpZXM6DQo+ICsNCj4gKyAtIHJlc2V0LWdwaW86IG11c3QgYmUgdGhlIGRldmljZSB0cmVl
IGlkZW50aWZpZXIgb2YgdGhlIFJFU0VUIHBpbi4gSWYNCj4gc3BlY2lmaWVkLA0KPiArIAkgICAg
ICAgaXQgd2lsbCBiZSBhc3NlcnRlZCBkdXJpbmcgZHJpdmVyIHByb2JlLg0KPiArIC0gZmlyc3Qt
ZGF0YS1ncGlvOiBtdXN0IGJlIHRoZSBkZXZpY2UgdHJlZSBpZGVudGlmaWVyIG9mIHRoZSBGUlNU
REFUQQ0KPiBwaW4uDQo+ICsgCQkgICAgVGhlIEZSU1REQVRBIG91dHB1dCBpbmRpY2F0ZXMgd2hl
biB0aGUgZmlyc3QgY2hhbm5lbCwNCj4gVjEsIGlzDQo+ICsJCSAgICBiZWluZyByZWFkIGJhY2sg
b24gZWl0aGVyIHRoZSBwYXJhbGxlbCwgYnl0ZSBvciBzZXJpYWwNCj4gaW50ZXJmYWNlLg0KPiAr
LSBzdGFuZGJ5LWdwaW86IG11c3QgYmUgdGhlIGRldmljZSB0cmVlIGlkZW50aWZpZXIgb2YgdGhl
IFNUQlkgcGluLiBUaGlzDQo+IHBpbiBpcyB1c2VkDQo+ICsJCXRvIHBsYWNlIHRoZSBBRDc2MDYg
aW50byBvbmUgb2YgdHdvIHBvd2VyLWRvd24gbW9kZXMsDQo+IFN0YW5kYnkgbW9kZSBvcg0KPiAr
CQlTaHV0ZG93biBtb2RlLg0KPiArLSByYW5nZS1ncGlvOiBtdXN0IGJlIHRoZSBkZXZpY2UgdHJl
ZSBpZGVudGlmaWVyIG9mIHRoZSBSQU5HRSBwaW4uIFRoZQ0KPiBwb2xhcml0eSBvbg0KPiArCSAg
ICAgIHRoaXMgcGluIGRldGVybWluZXMgdGhlIGlucHV0IHJhbmdlIG9mIHRoZSBhbmFsb2cgaW5w
dXQNCj4gY2hhbm5lbHMuIElmDQo+ICsJICAgICAgdGhpcyBwaW4gaXMgdGllZCB0byBhIGxvZ2lj
IGhpZ2gsIHRoZSBhbmFsb2cgaW5wdXQgcmFuZ2UgaXMNCj4gwrExMFYgZm9yDQo+ICsJICAgICAg
YWxsY2hhbm5lbHMuIElmIHRoaXMgcGluIGlzIHRpZWQgdG8gYSBsb2dpYyBsb3csIHRoZSBhbmFs
b2cNCj4gaW5wdXQgcmFuZ2UNCj4gKwkgICAgICBpcyDCsTVWIGZvciBhbGwgY2hhbm5lbHMuDQo+
ICsNCg0Kbml0cGljazogYHJhbmdlLWdwaW9gICYmIGBzdGFuZGJ5LWdwaW9gIGVudHJpZXMgYXJl
IGluZGVudGVkIGRpZmZlcmVudGx5DQp0aGFuIGByZXNldC1ncGlvYCAmJiBgZmlyc3QtZGF0YS1n
cGlvYA0KDQo+ICtFeGFtcGxlOg0KPiArDQo+ICsJYWRjQDAgew0KPiArCQljb21wYXRpYmxlID0g
ImFkaSxhZDc2MDYtOCI7DQo+ICsJCXJlZyA9IDwwPjsNCj4gKwkJc3BpLW1heC1mcmVxdWVuY3kg
PSA8MTAwMDAwMD47DQo+ICsJCXNwaS1jcG9sOw0KPiArDQo+ICsJCWF2Y2Mtc3VwcGx5ID0gPCZh
ZGNfdnJlZj47DQo+ICsNCj4gKwkJaW50ZXJydXB0cyA9IDwyNSBJUlFfVFlQRV9FREdFX0ZBTExJ
Tkc+Ow0KPiArCQlpbnRlcnJ1cHQtcGFyZW50ID0gPCZncGlvPjsNCj4gKw0KPiArCQljb252ZXJz
aW9uLXN0YXJ0LWdwaW8gPSA8JmdwaW8gMTcgMD47DQo+ICsJCXJlc2V0LWdwaW8gPSA8JmdwaW8g
MjcgMD47DQo+ICsJCWZpcnN0LWRhdGEtZ3BpbyA9IDwmZ3BpbyAyMiAwPjsNCj4gKwkJc3RhbmRi
eS1ncGlvID0gPCZncGlvIDI0IDA+Ow0KPiArCX07DQo+IGRpZmYgLS1naXQgYS9NQUlOVEFJTkVS
UyBiL01BSU5UQUlORVJTDQo+IGluZGV4IDg0MzU0NWQuLjZkNjNkYjQgMTAwNjQ0DQo+IC0tLSBh
L01BSU5UQUlORVJTDQo+ICsrKyBiL01BSU5UQUlORVJTDQo+IEBAIC04NDUsNiArODQ1LDcgQEAg
TDoJbGludXgtaWlvQHZnZXIua2VybmVsLm9yZw0KPiAgVzoJaHR0cDovL2V6LmFuYWxvZy5jb20v
Y29tbXVuaXR5L2xpbnV4LWRldmljZS1kcml2ZXJzDQo+ICBTOglTdXBwb3J0ZWQNCj4gIEY6CWRy
aXZlcnMvaWlvL2FkYy9hZDc2MDYuYw0KPiArRjoJRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL2lpby9hZGMvYWQ3NjA2LnR4dA0KPiAgDQo+ICBBTkFMT0cgREVWSUNFUyBJTkMgQUQ5
Mzg5QiBEUklWRVINCj4gIE06CUhhbnMgVmVya3VpbCA8aGFucy52ZXJrdWlsQGNpc2NvLmNvbT4N
Cg==
