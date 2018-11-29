Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB72CC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 11:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BCC02081B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 11:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="FeN99sjH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BCC02081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbeK2WXW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 17:23:22 -0500
Received: from mail-eopbgr810054.outbound.protection.outlook.com ([40.107.81.54]:20488
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726621AbeK2WXW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 17:23:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qi2lLzfKdg/+AEdEmqia2/1v3JadTpIPLhN6qIPizCs=;
 b=FeN99sjHVJCocxFwKE8Z03XFFgbrR9A0Ush5bU2T55qnBzq2bxeTeQwGSpWkitSAWz4cqFkLtVFAJRSl5cfpMSqkjg0uao0aFn52RUbCD2K6EtpXm13okmw6k/8gMxz4STHxC2A7zg6yAwHNAVRILo99Y39K3MPlv5BWXenBWP0=
Received: from BN3PR03CA0077.namprd03.prod.outlook.com
 (2a01:111:e400:7a4d::37) by BL2PR03MB545.namprd03.prod.outlook.com
 (2a01:111:e400:c23::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1382.18; Thu, 29 Nov
 2018 11:18:12 +0000
Received: from BY2FFO11FD019.protection.gbl (2a01:111:f400:7c0c::111) by
 BN3PR03CA0077.outlook.office365.com (2a01:111:e400:7a4d::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1382.18 via Frontend Transport; Thu, 29 Nov 2018 11:18:11 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; googlegroups.com; dkim=none (message not signed)
 header.d=none;googlegroups.com; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta4.analog.com;
Received: from nwd2mta4.analog.com (137.71.25.57) by
 BY2FFO11FD019.mail.protection.outlook.com (10.1.14.107) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1339.12
 via Frontend Transport; Thu, 29 Nov 2018 11:18:11 +0000
Received: from NWD2HUBCAS8.ad.analog.com (nwd2hubcas8.ad.analog.com [10.64.69.108])
        by nwd2mta4.analog.com (8.13.8/8.13.8) with ESMTP id wATBIA7P010827
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 29 Nov 2018 03:18:10 -0800
Received: from NWD2MBX5.ad.analog.com ([fe80::49e:7a9f:284e:1a49]) by
 NWD2HUBCAS8.ad.analog.com ([fe80::90a0:b93e:53c6:afee%12]) with mapi id
 14.03.0301.000; Thu, 29 Nov 2018 06:18:10 -0500
From:   "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
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
Subject: Re: [PATCH 1/2] staging: iio: ad7780: Add gain & filter gpio support
Thread-Topic: [PATCH 1/2] staging: iio: ad7780: Add gain & filter gpio
 support
Thread-Index: AQHUh0ZwdQEeLsQOikOfI7kZCTR8MKVm76+A
Date:   Thu, 29 Nov 2018 11:18:10 +0000
Message-ID: <1543490289.11186.22.camel@analog.com>
References: <cover.1543428366.git.giuliano.belinassi@usp.br>
         <231cbc909b892a0ebe172460d34e9eeb9cfa3003.1543428366.git.giuliano.belinassi@usp.br>
In-Reply-To: <231cbc909b892a0ebe172460d34e9eeb9cfa3003.1543428366.git.giuliano.belinassi@usp.br>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.50.1.118]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <03E49254B4FBDA4BA836020364213F58@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(346002)(136003)(2980300002)(438002)(199004)(189003)(36756003)(50466002)(478600001)(229853002)(47776003)(246002)(966005)(72206003)(14454004)(8676002)(356004)(86362001)(8936002)(2201001)(4001150100001)(2501003)(106002)(6246003)(476003)(316002)(39060400002)(126002)(486006)(106466001)(4326008)(11346002)(5660300001)(110136005)(54906003)(2616005)(446003)(76176011)(23676004)(436003)(426003)(26005)(2486003)(7416002)(102836004)(14444005)(6306002)(3846002)(186003)(6116002)(103116003)(7636002)(7736002)(7696005)(305945005)(2906002)(336012)(921003)(1121003)(6606295002);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2PR03MB545;H:nwd2mta4.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11FD019;1:pFxVAVrQPym7BGzoOTCEyhETR/PAI7it8nDd6uFyqoHrHuiIflBYlEvNTMWbJaT7SggFeaWmdLohIqsd+qJZ6u+MthlS0SQJjnlfcbmEbwEHdRcq69OGPgUvhjRsmadS
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e578ea38-91ae-4411-aa2f-08d655ec5952
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060)(7193020);SRVR:BL2PR03MB545;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB545;3:Xw676Fj5hvCqucCQRv78rDPT/jpgyiySwf+6KkIk35dcQNfNHVUQKWfvmt2SZy74fCXUoC88kXe3emxTM4AFJTPB0YUwtMJGCVVIM0QnWVUS15oETtQP1GZTVeydF52yz2AC3/EhRSz+EyAuNVZrXWFt26J/5in2cQi2OwgcNiNkcG9w7SgAfqcCbFDp2o50OfU/+Gw7p0KY6lc6d31oCjaGFA2u0j0W4LGeO0VaItLZ8BOVQ189IWRNr35TxN8PxyDAD4TC1Z2LAnRrkIraPyVpS3QhL6J1d5RZi7OveYJRIIkOs8ppH658desZgNysemRXIqW/YsGwtv6stD8WN3cKUr0rTEnUFE3JqUlTyqU=;25:/8cAxLMqeT+lIANWmmV+BO457/J76QHLicGvq0cIRk0V8TFQMn3gJAcvFLas3cqrvacxfkVwwubQGvj2Y+6fT3SRmDwnsny39IIFytGfKwoeAHEFuYEeEGLomiLFKqGQ53IKLhtrfIsd8fDMPo2ckdE7heMILEW8qKxXBVdrjpfN8AP/lBlv5z1tf/b+fu7Le53q1ShSjfwgmqee5UAi/bJ2PT+CZhGnMoeIh5rqh5mK4WS/WZ99hXWD/VANMsXY4wF7vYvbxOy2eDdLl6Sa/+0KfsI0HiJ92fBaKwhQBzEtkpb8I8Tt+3Y8zm2B/csYps6HzyHv8uYG0LizK+joeXcFYiKRWNS2c42VbKz91zU=
X-MS-TrafficTypeDiagnostic: BL2PR03MB545:
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB545;31:t29pbersGeIZOZ48kW1cqtS3zmvlVHKTaMc4Ap05AQCUhPCtdZTC+l23eSBG8g9u7UBoorp9G+F+k+lh8kaNa1wnFjihQY9nlfHKFrMKm0hkQxYEI2QNpl4FmvXKPB3XXvUX9+fCFIUKIYELF7yRv25PEmMTk7/DWo4wd0O2Ydj66wJWCtvthhaQFfR/EwDu6dtCQA/bI2Ji4kz/JezK88XzWL0zyVIoZo7I1RU6lZU=;20:nGYXiK8g3fv39j5EoFALx/5zJCF1VQU6SBkC7nQrG+yj3r9gyDDtK5rTtBCAaOKb5MSRW7sH+5FmQ06407URSceDcdtt0/9QuMAObPo3e4jeYHm0V0j8PA1g+8bREpBo40gZ1KInNL4q2HflXyfwUG96U0w781kfbuU76PysBJr4AkHl4CZqEAgEFWDCJmtRmHUMuwqOP3fAuAmAl3tJ5ngDsLOP6mXbcnLRoXqC/t8wzVK8hudzcAn3fyTrabdu+Qk3m11OK0DTTSDZglH4a0YzDYlyDll0abJUqhFoHNdgfatSV6+YapdfAGpQVvjopIdi09PNTEEZ0r2s+BQmUt6dkTtx0biODTBS0PIfodrmAhpcPDZAs62fk+2JVjJoB+x9wTKxh2TPV0DcJJDPyK8IUvX0ViSO3236l7wBGOxwBWZyHr/DqolpWgkvzfnCr7knuKDzN7TZA90e4hvFKLvN+KqVBw9bdmaX4KIztMQaKuNhgh3f881wexyqtv+M
X-Microsoft-Antispam-PRVS: <BL2PR03MB5452C89F4EFC4C6136C23B39DD20@BL2PR03MB545.namprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231453)(999002)(944501410)(52105112)(93006095)(93004095)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BL2PR03MB545;BCL:0;PCL:0;RULEID:;SRVR:BL2PR03MB545;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB545;4:aomZIbu0420gVlty5iH2PlczNY/CpNMd2XMIAYk0zg3fmoD2KMgaRHXivaETK20uWZgttvcFyR8eJdQeIixE89Vr+h8eW1UpsCjNvZNOuGbguP1ALQsmOzAoC9rHlb0W1uXk4ksGhLxq5mlDmDD5iuCR1uunrIIEJWX4z8/LqbrfFYDmMpxUz+PFGWgEcq4gas8Dom374fn3ypkumomBnj7ecdVG0p3HvDKQqAkEc+LehjKN+02nDTr0GEH2A5zXRWro5XvLgqrV0Il/xD5cdw==
X-Forefront-PRVS: 0871917CDA
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTDJQUjAzTUI1NDU7MjM6NWdLNVhyRzkyWm1nRmhpSE5vY0ZWd1JudFdJ?=
 =?utf-8?B?V09aUVg5VmRabXpVWWU2ZnJuemZGeE0wWE9SU0ZYdUpIL29NZFIwMUp2N0U3?=
 =?utf-8?B?RUd0ZlY4czBKR3NYM1I2Wm1Xc28wM1FKUG1rYStkN0JlRDRjYVFGbFBNSmFo?=
 =?utf-8?B?VE9ydDd0b281K0N2bERxZGJ2d3ZMNGpmM1kwdm4xc2lvcjNLakRjeU42Ly91?=
 =?utf-8?B?UmFZSHhIdG80enY0NFdSL1h0UEovY1BIMjFXTXlFd2JyQjZFelR5WC9wb0RY?=
 =?utf-8?B?Qm9hdUk0WkxUQUFLbHJQdXlHM0FTaW15WWZKR0ZJZW9kcS94cW1aL25DRHMw?=
 =?utf-8?B?NTFhU0w3bGhRdXZvaU5PNkg2cWoxMTYzS0tneXo1ZkpxNmdKNmw5ZnZXZU0w?=
 =?utf-8?B?cUx1aFBNSWR3UWxDcHg1TzlQQUFITXF1amlBN0dwRE1OZmVQbFZqWmhMVGs5?=
 =?utf-8?B?STV5V0ZLZnF2M2syUEZWTWhEdmdWTWpjL0hWVlFQU29xSkYwN1FFaEdaWWRm?=
 =?utf-8?B?UW5sNlJYM3UyMEpoeDhJdk9aSExPK2l0aUVBNytOSkNFS3c3QThpUTQ0NHov?=
 =?utf-8?B?V3lkVzdQMXVidVZqaElGemh2eFoyOTBwS0ptaUwxazFkdHNOcXlCOFpCOGdq?=
 =?utf-8?B?V3lDNWxxRDh5TXNsb0N2ZkI1aDBZc3kvVUt6clFZQWppako1anpaRnB4a2kv?=
 =?utf-8?B?Q05oMDJSemw2eHorUnJ2Tm1Lb1FNLzgrL1ZjTkFXTE5sKzlwWEkrN0xrUUdH?=
 =?utf-8?B?eHI0cndNZXJLbjR3c3NkNDVxSG0xZUJhYU9VSW1wTHBBSVZHcDd5VDR0dVZ0?=
 =?utf-8?B?WGFLdHd4dW5DT3d0Q2l3c0JudUp2TmcvcVVoRmI1T1ZsSE41S2ROUm9MeDR1?=
 =?utf-8?B?TnlpSElFc3RtQ0pjOTBxeDk5cWFwSzFQak12elNHNHlXZWR6bmVVenM3VmM3?=
 =?utf-8?B?ZVlBTk01VkJJVHZLaFJ0ODV0OE9KS0l6ZjI2ODlBanArZHNCM1ZuSElQN1Zk?=
 =?utf-8?B?d0ZUWUFhd0ZDR1diVUVaOUlISGk0eEdjV0tiZ2ZEWWxCbHJPWFlzYUhZWW9s?=
 =?utf-8?B?QmdaamwxcWVHQWNqbENEd2c0OGJ0eUgvck5BQ3ZiaXIvemhTUzEwaU5uK1Ev?=
 =?utf-8?B?QThMazdBUW5FTHhjYllQZ1pjYmczeW01QWFmZ0puK3FDV0hwWkkxNWlubUpE?=
 =?utf-8?B?V2dDVmkzbWQ2Y2ludFhxelNnOWxyWVZlMmFBWFVRUVV1Y1lpNmlCNFFKQnZn?=
 =?utf-8?B?ekFlMjJyRGpzRk9MbGwrMm1TOGlaNkUxYy9MNENWU0owZDA3WW5mWVpCQ2hX?=
 =?utf-8?B?VjJGc2dmTnBPK0RyZkI3ZG4zeFRxOGxSTXl1cUhzb2NabmJJcEZPRUhtTC9L?=
 =?utf-8?B?ZUpvRWFPUWp1cHh3ejJUaVFXTnZoUjRDWEd3YjlNUmtQdjhRTHdHWjFBSUJH?=
 =?utf-8?B?R0psTUN3VXVxSUpsMDZWNDBTdHFRVnNGTnVKd1l4ZDhpSEMxMWJIcE4yRjhW?=
 =?utf-8?B?cXc2eDRNMDduZENwb1JxYmliSmRhbFlRZmlxelUvQkxYM1A5a0dlWnFsbXBJ?=
 =?utf-8?B?bXB5TXRpZ3MxKy8zTnV6eklNbDh6UEFldlRSdU5GdmlYbzh2OEo0NElMYllS?=
 =?utf-8?B?c0laNXFTWWQwNEpSS05PcHdhL1FuVjRnbzFzQnZmTittYUxwSmp2a1lhVGdP?=
 =?utf-8?B?UWtVQ2hmWnZhSmNpQmhLSkQzYUNuZlJzWVhSSzFBdHcyRXNTWXQ0cmVVSnVS?=
 =?utf-8?B?cDJCSHVkRlRSSUxKTEE4KytJeDNRQ1RmVDh3ZWovakJ0UWh6c1ZYQmdZdFNq?=
 =?utf-8?B?Nkd4TzJLaWkvWXkxSjZpSjl3RFhBZlJVbm1NK2RSeVNxdz09?=
X-Microsoft-Antispam-Message-Info: wDq4wYlPtXbPWqpJBT2CA9JgA48E/iRoyWOTHlcEvHMnCM2vNLTLfDJMYeitjROy3zSAwWoxtatDhPeZFF9wMoN7HEN7hM/YrAJEY/pfFDtqmYzFzxqToQwYiB0Geq9lydY6OJapfqI9rx/UKHrlX6lCUhsAL4OD0OA3Op2xdTezDTrYtZt1HIyftr/6+sx1z76av8yApd3W2JxJC+HoicQMYEnlcBoqKr+f+TQoYmrZGAGr0s1VrfOpNZZyYNoCmVMTW31EDquYmdjtnE31J5f01yBTzU5laKqgrYspLasMyhZkBUzjoWrfB8CWktm939QdxaCqaFPnzci8Ba/HK69TWcFRYgaV1ehdzxowKbc=
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB545;6:2OnKz+6sviXMdwdWOQX7ZVZdcWfIl0fQ6jfHRih/Cv4NVLXF4WSdFNGfvAWIol6JuCTepRxMYqFM2PbQic3vfihOHQZbtMcn/PEGYJwOw03M/uWnHlZygwTOyN4sJwYe8qiZVFSHo+Vnf1wuxS32Ecm0mSN4gr+EeMUP+sQnven7rm9EuuJD+vvzN0fbueLCL3DfucZd7/ENmbt2/SMAhOY8T0u4AQGr84FjrCqa5uQVJ/+Q3jda9+rJp2I9FjiPVJYctQOwKhBbPcZiA71o4wC/DQdoxzskTUztpiPnirpwgCNB1iJ25Dv5l3E25Glh98HbOT6kxto0Nth8zmy1C53+9D3ZJ9JOakYRX23/8JKmln/4h92s4NyUg9fqMIdv62+1XAoBKTyiRlPCoioupSNA2uf3fBQVMOTKWLyuQJ3DBWFvfYhF7hnA8wj4fcq2AaRb7Z4cUHi0m8fxYeEvL9mX11xydWi5CGguRTQy9Gs=;5:rHxma4Cr9APMO96jrBa9jYHxIRH6B+WBC21mgLbuaUm5M4AibQCaPIPdiGYZ+yYpT5nOnIaMuzkTXK+MWq2hrVu06oZ/ATYUlQS5BsicsskrUwL2uNCCH2GxCjurpcjR6/+Tty7o9FkXwwObEALGeKrjUZEoz6xd8HVj/QDyzwA=;7:RhLuZrcoNBy5VrIgf1FcFaKe48sIrGrrFGtYib3lnYTRKC62PMpnrqU8CqGsqdkytMxusJ3WTk6PTMsjRkR+aP3OeYBFBGnUIRDoMUnl9ClAIKhd7ME/Ik8961kBQ6fNKdeat7gNmWkfAiB8IOY1uQ==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2018 11:18:11.5923
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e578ea38-91ae-4411-aa2f-08d655ec5952
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR03MB545
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTWksIDIwMTgtMTEtMjggYXQgMTY6MTUgLTAyMDAsIEdpdWxpYW5vIEJlbGluYXNzaSB3cm90
ZToNCj4gUHJldmlvdXNseSwgdGhlIEFENzc4MCBkcml2ZXIgb25seSBzdXBwb3J0ZWQgZ3BpbyBm
b3IgdGhlICdwb3dlcmRvd24nDQo+IHBpbi4gVGhpcyBjb21taXQgYWRkcyBzdXBwcG9ydCBmb3Ig
dGhlICdnYWluJyBhbmQgJ2ZpbHRlcicgcGluLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogR2l1bGlh
bm8gQmVsaW5hc3NpIDxnaXVsaWFuby5iZWxpbmFzc2lAdXNwLmJyPg0KPiAtLS0NCj4gQ2hhbmdl
cyBpbiB2MjoNCj4gwqDCoMKgwqAtIE5vdyB0aGlzIHBhdGNoIGlzIHBhcnQgb2YgdGhlIHBhdGNo
c2V0IHRoYXQgYWltcyB0byByZW1vdmUgYWQ3NzgwDQo+IG91dCBvZiBzdGFnaW5nLiBodHRwczov
L21hcmMuaW5mby8/bD1saW51eC1paW8mbT0xNTQyODIzNDk4MDg4OTAmdz0yDQo+IMKgwqDCoMKg
LSBBbHNvLCBub3cgaXQgcmVhZHMgdm9sdGFnZSBhbmQgZmlsdGVyIHZhbHVlcyBmcm9tIHRoZSB1
c2Vyc3BhY2UNCj4gaW5zdGVhZCBvZiBncGlvIHBpbiBzdGF0ZXMuDQoNCkhlbGxvLA0KUGxlYXNl
IHNlZSBiZWxsb3cuDQoNCj4gDQo+IMKgZHJpdmVycy9zdGFnaW5nL2lpby9hZGMvYWQ3NzgwLmPC
oMKgwqDCoMKgwqDCoHwgNzggKysrKysrKysrKysrKysrKysrKysrKysrLS0NCj4gwqBpbmNsdWRl
L2xpbnV4L2lpby9hZGMvYWRfc2lnbWFfZGVsdGEuaCB8wqDCoDUgKysNCj4gwqAyIGZpbGVzIGNo
YW5nZWQsIDc5IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9zdGFnaW5nL2lpby9hZGMvYWQ3NzgwLmMNCj4gYi9kcml2ZXJzL3N0YWdpbmcv
aWlvL2FkYy9hZDc3ODAuYw0KPiBpbmRleCBjNGE4NTc4OWMyZGIuLjA1OTc5YTc5ZmRhMyAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9zdGFnaW5nL2lpby9hZGMvYWQ3NzgwLmMNCj4gKysrIGIvZHJp
dmVycy9zdGFnaW5nL2lpby9hZGMvYWQ3NzgwLmMNCj4gQEAgLTM5LDYgKzM5LDEyIEBADQo+IMKg
I2RlZmluZSBBRDcxNzBfUEFUVEVSTgkJKEFENzc4MF9QQVQwIHwgQUQ3MTcwX1BBVDIpDQo+IMKg
I2RlZmluZSBBRDcxNzBfUEFUVEVSTl9NQVNLCShBRDc3ODBfUEFUMCB8IEFENzc4MF9QQVQxIHwN
Cj4gQUQ3MTcwX1BBVDIpDQo+IMKgDQo+ICsjZGVmaW5lIEFENzc4MF9HQUlOX0dQSU8JMA0KPiAr
I2RlZmluZSBBRDc3ODBfRklMVEVSX0dQSU8JMQ0KPiArDQo+ICsjZGVmaW5lIEFENzc4MF9HQUlO
X01JRFBPSU5UCTY0DQo+ICsjZGVmaW5lIEFENzc4MF9GSUxURVJfTUlEUE9JTlQJMTMzNTANCj4g
Kw0KPiDCoHN0cnVjdCBhZDc3ODBfY2hpcF9pbmZvIHsNCj4gwqAJc3RydWN0IGlpb19jaGFuX3Nw
ZWMJY2hhbm5lbDsNCj4gwqAJdW5zaWduZWQgaW50CQlwYXR0ZXJuX21hc2s7DQo+IEBAIC01MCw2
ICs1Niw4IEBAIHN0cnVjdCBhZDc3ODBfc3RhdGUgew0KPiDCoAljb25zdCBzdHJ1Y3QgYWQ3Nzgw
X2NoaXBfaW5mbwkqY2hpcF9pbmZvOw0KPiDCoAlzdHJ1Y3QgcmVndWxhdG9yCQkqcmVnOw0KPiDC
oAlzdHJ1Y3QgZ3Bpb19kZXNjCQkqcG93ZXJkb3duX2dwaW87DQo+ICsJc3RydWN0IGdwaW9fZGVz
YwkJKmdhaW5fZ3BpbzsNCj4gKwlzdHJ1Y3QgZ3Bpb19kZXNjCQkqZmlsdGVyX2dwaW87DQo+IMKg
CXVuc2lnbmVkIGludAlnYWluOw0KPiDCoA0KPiDCoAlzdHJ1Y3QgYWRfc2lnbWFfZGVsdGEgc2Q7
DQo+IEBAIC0xMTUsMTggKzEyMyw2NSBAQCBzdGF0aWMgaW50IGFkNzc4MF9yZWFkX3JhdyhzdHJ1
Y3QgaWlvX2Rldg0KPiAqaW5kaW9fZGV2LA0KPiDCoAlyZXR1cm4gLUVJTlZBTDsNCj4gwqB9DQo+
IMKgDQo+ICtzdGF0aWMgaW50IGFkNzc4MF93cml0ZV9yYXcoc3RydWN0IGlpb19kZXYgKmluZGlv
X2RldiwNCj4gKwkJCcKgwqDCoMKgc3RydWN0IGlpb19jaGFuX3NwZWMgY29uc3QgKmNoYW4sDQo+
ICsJCQnCoMKgwqDCoGludCB2YWwsDQo+ICsJCQnCoMKgwqDCoGludCB2YWwyLA0KPiArCQkJwqDC
oMKgwqBsb25nIG0pDQo+ICt7DQo+ICsJc3RydWN0IGFkNzc4MF9zdGF0ZSAqc3QgPSBpaW9fcHJp
dihpbmRpb19kZXYpOw0KPiArCWNvbnN0IHN0cnVjdCBhZDc3ODBfY2hpcF9pbmZvICpjaGlwX2lu
Zm8gPSBzdC0+Y2hpcF9pbmZvOw0KPiArCWludCB1dnJlZiwgZ2FpbjsNCj4gKwl1bnNpZ25lZCBp
bnQgZnVsbF9zY2FsZTsNCj4gKw0KPiArCWlmICghY2hpcF9pbmZvLT5pc19hZDc3OHgpDQo+ICsJ
CXJldHVybiAwOw0KPiArDQo+ICsJc3dpdGNoIChtKSB7DQo+ICsJY2FzZSBJSU9fQ0hBTl9JTkZP
X1NDQUxFOg0KPiArCQlpZiAodmFsICE9IDApDQo+ICsJCQlyZXR1cm4gLUVJTlZBTDsNCj4gKw0K
PiArCQl1dnJlZiA9IHJlZ3VsYXRvcl9nZXRfdm9sdGFnZShzdC0+cmVnKTsNCg0KcmVndWxhdG9y
X2dldF92b2x0YWdlKCkgaGFzIGFscmVhZHkgYmVlbiBjYWxsZWQgaW4gdGhlIHByb2JlIGZ1bmN0
aW9uIGFuZA0KdGhlIHJlc3VsdCBpcyBzdG9yZWQgaW7CoHN0LT5pbnRfdnJlZl9tdi4NCk15IHN1
Z2dlc3Rpb24gd291bGQgYmUgdG8gdXNlIGEgbG9jYWwgdnJlZiB2YXJpYWJsZSBkZWNsYXJlZCBh
cyB1bnNpZ25lZA0KaW50LiBJdCBpcyBteSBmYXVsdCB0aGF0IEkgaGF2ZW4ndCBleHBsYWluZWQg
Y29ycmVjdGx5IGluIHRoZSBwcmV2aW91cw0KZW1haWwsIGJ1dCB5b3UgbmVlZCB0byBtdWx0aXBs
eSB2cmVmX212IHdpdGjCoDEwMDAwMDBMTCBpbiBvcmRlciB0byBnZXQgdGhlDQpyaWdodCBwcmVj
aXNpb246IHZyZWYgPSBzdC0+aW50X3ZyZWZfbXYgKiAxMDAwMDAwTEwuIEFmdGVyd2FyZHMgeW91
IHdpbGwgYmUNCmFibGUgdG8gcGVyZm9ybSB0aGUgZGl2aXNpb25zLg0KPiArDQo+ICsJCWlmICh1
dnJlZiA8IDApDQo+ICsJCQlyZXR1cm4gdXZyZWY7DQo+ICsNCj4gKwkJZnVsbF9zY2FsZSA9IDEg
PDwgKGNoaXBfaW5mby0+Y2hhbm5lbC5zY2FuX3R5cGUucmVhbGJpdHMgDQo+IC0gMSk7DQo+ICsJ
CWdhaW4gPSBESVZfUk9VTkRfQ0xPU0VTVCh1dnJlZiwgZnVsbF9zY2FsZSk7DQo+ICsJCWdhaW4g
PSBESVZfUk9VTkRfQ0xPU0VTVChnYWluLCB2YWwyKTsNCj4gKw0KPiArCQlncGlvZF9zZXRfdmFs
dWUoc3QtPmdhaW5fZ3BpbywgZ2FpbiA8DQo+IEFENzc4MF9HQUlOX01JRFBPSU5UID8gMCA6IDEp
Ow0KDQpPbmNlIHRoZSBnYWluIGlzIHNldCwgeW91IGNhbiBzdG9yZSBpdCBpbiBzdC0+Z2FpbiB2
YXJpYWJsZS4NCg0KPiArCWNhc2UgSUlPX0NIQU5fSU5GT19TQU1QX0ZSRVE6DQo+ICsJCWlmICh2
YWwyICE9IDApDQo+ICsJCQlyZXR1cm4gLUVJTlZBTDsNCj4gKw0KPiArCQlncGlvZF9zZXRfdmFs
dWUoc3QtPmZpbHRlcl9ncGlvLCB2YWwgPA0KPiBBRDc3ODBfRklMVEVSX01JRFBPSU5UID8gMCA6
IDEpOw0KDQpUaGlzIGlzIHByb2JhYmx5IGZpbmUsIGFsdGhvdWdoIEkgYW0gbm90IGEgYmlnIGZh
biBvZiB0aGUgdGVybmFyeSBvcGVyYXRvci4NCkEgc2ltcGxlIGlmIGVsc2Ugc3RhdGVtZW50IHdv
dWxkIGRvLiBIb3dldmVyLCBJIGRvbid0IGZlZWwgc3Ryb25nbHkgYWJvdXQNCml0LCBzbyBmZWVs
IGZyZWUgdG8gZGlzYWdyZWUuwqANCg0KPiArCWJyZWFrOw0KPiArCX0NCj4gKw0KPiArCXJldHVy
biAwOw0KPiArfQ0KPiArDQo+IMKgc3RhdGljIGludCBhZDc3ODBfcG9zdHByb2Nlc3Nfc2FtcGxl
KHN0cnVjdCBhZF9zaWdtYV9kZWx0YSAqc2lnbWFfZGVsdGEsDQo+IMKgCQkJCcKgwqDCoMKgwqB1
bnNpZ25lZCBpbnQgcmF3X3NhbXBsZSkNCj4gwqB7DQo+IMKgCXN0cnVjdCBhZDc3ODBfc3RhdGUg
KnN0ID0gYWRfc2lnbWFfZGVsdGFfdG9fYWQ3NzgwKHNpZ21hX2RlbHRhKTsNCj4gwqAJY29uc3Qg
c3RydWN0IGFkNzc4MF9jaGlwX2luZm8gKmNoaXBfaW5mbyA9IHN0LT5jaGlwX2luZm87DQo+ICsJ
aW50IHZhbDsNCj4gwqANCj4gwqAJaWYgKChyYXdfc2FtcGxlICYgQUQ3NzgwX0VSUikgfHwNCj4g
wqAJwqDCoMKgwqAoKHJhd19zYW1wbGUgJiBjaGlwX2luZm8tPnBhdHRlcm5fbWFzaykgIT0gY2hp
cF9pbmZvLQ0KPiA+cGF0dGVybikpDQo+IMKgCQlyZXR1cm4gLUVJTzsNCj4gwqANCj4gwqAJaWYg
KGNoaXBfaW5mby0+aXNfYWQ3Nzh4KSB7DQo+IC0JCWlmIChyYXdfc2FtcGxlICYgQUQ3NzgwX0dB
SU4pDQo+ICsJCXZhbCA9IHJhd19zYW1wbGUgJiBBRDc3ODBfR0FJTjsNCj4gKw0KPiArCQlpZiAo
dmFsICE9IGdwaW9kX2dldF92YWx1ZShzdC0+Z2Fpbl9ncGlvKSkNCj4gKwkJCXJldHVybiAtRUlP
Ow0KDQpJdCBpcyBub3Qgb2J2aW91cyB0byBtZSB3aGF0IGlzIHRoZSBwb2ludCBvZiB0aGlzIGNo
ZWNrLiBNYXliZSB5b3UgY2FuIGFkZA0KYSBjb21tZW50Pw0KDQo+ICsNCj4gKwkJaWYgKHZhbCkN
Cj4gwqAJCQlzdC0+Z2FpbiA9IDE7DQo+IMKgCQllbHNlDQo+IMKgCQkJc3QtPmdhaW4gPSAxMjg7
DQoNCkRvIHdlIHN0aWxsIG5lZWQgdGhpcz8gSSBhbSBub3QgY29udmluY2VkLsKgDQoNCj4gQEAg
LTE0MSwxOCArMTk2LDIwIEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYWRfc2lnbWFfZGVsdGFfaW5m
bw0KPiBhZDc3ODBfc2lnbWFfZGVsdGFfaW5mbyA9IHsNCj4gwqAJLmhhc19yZWdpc3RlcnMgPSBm
YWxzZSwNCj4gwqB9Ow0KPiDCoA0KPiAtI2RlZmluZSBBRDc3ODBfQ0hBTk5FTChiaXRzLCB3b3Jk
c2l6ZSkgXA0KPiArI2RlZmluZSBBRDcxNzBfQ0hBTk5FTChiaXRzLCB3b3Jkc2l6ZSkgXA0KPiDC
oAlBRF9TRF9DSEFOTkVMX05PX1NBTVBfRlJFUSgxLCAwLCAwLCBiaXRzLCAzMiwgd29yZHNpemUg
LSBiaXRzKQ0KPiArI2RlZmluZSBBRDc3ODBfQ0hBTk5FTChiaXRzLCB3b3Jkc2l6ZSkgXA0KPiAr
CUFEX1NEX0NIQU5ORUxfR0FJTl9GSUxURVIoMSwgMCwgMCwgYml0cywgMzIsIHdvcmRzaXplIC0g
Yml0cykNCj4gwqANCj4gwqBzdGF0aWMgY29uc3Qgc3RydWN0IGFkNzc4MF9jaGlwX2luZm8gYWQ3
NzgwX2NoaXBfaW5mb190YmxbXSA9IHsNCj4gwqAJW0lEX0FENzE3MF0gPSB7DQo+IC0JCS5jaGFu
bmVsID0gQUQ3NzgwX0NIQU5ORUwoMTIsIDI0KSwNCj4gKwkJLmNoYW5uZWwgPSBBRDcxNzBfQ0hB
Tk5FTCgxMiwgMjQpLA0KPiDCoAkJLnBhdHRlcm4gPSBBRDcxNzBfUEFUVEVSTiwNCj4gwqAJCS5w
YXR0ZXJuX21hc2sgPSBBRDcxNzBfUEFUVEVSTl9NQVNLLA0KPiDCoAkJLmlzX2FkNzc4eCA9IGZh
bHNlLA0KPiDCoAl9LA0KPiDCoAlbSURfQUQ3MTcxXSA9IHsNCj4gLQkJLmNoYW5uZWwgPSBBRDc3
ODBfQ0hBTk5FTCgxNiwgMjQpLA0KPiArCQkuY2hhbm5lbCA9IEFENzE3MF9DSEFOTkVMKDE2LCAy
NCksDQo+IMKgCQkucGF0dGVybiA9IEFENzE3MF9QQVRURVJOLA0KPiDCoAkJLnBhdHRlcm5fbWFz
ayA9IEFENzE3MF9QQVRURVJOX01BU0ssDQo+IMKgCQkuaXNfYWQ3Nzh4ID0gZmFsc2UsDQo+IEBA
IC0xNzMsNiArMjMwLDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBhZDc3ODBfY2hpcF9pbmZvDQo+
IGFkNzc4MF9jaGlwX2luZm9fdGJsW10gPSB7DQo+IMKgDQo+IMKgc3RhdGljIGNvbnN0IHN0cnVj
dCBpaW9faW5mbyBhZDc3ODBfaW5mbyA9IHsNCj4gwqAJLnJlYWRfcmF3ID0gYWQ3NzgwX3JlYWRf
cmF3LA0KPiArCS53cml0ZV9yYXcgPSBhZDc3ODBfd3JpdGVfcmF3LA0KPiDCoH07DQo+IMKgDQo+
IMKgc3RhdGljIGludCBhZDc3ODBfcHJvYmUoc3RydWN0IHNwaV9kZXZpY2UgKnNwaSkNCj4gQEAg
LTIyMiw2ICsyODAsMTggQEAgc3RhdGljIGludCBhZDc3ODBfcHJvYmUoc3RydWN0IHNwaV9kZXZp
Y2UgKnNwaSkNCj4gwqAJCWdvdG8gZXJyb3JfZGlzYWJsZV9yZWc7DQo+IMKgCX0NCj4gwqANCj4g
KwlpZiAoc3QtPmNoaXBfaW5mby0+aXNfYWQ3Nzh4KSB7DQo+ICsJCXN0LT5nYWluX2dwaW8gPSBk
ZXZtX2dwaW9kX2dldF9vcHRpb25hbCgmc3BpLT5kZXYsDQo+ICsJCQkJCQkJImdhaW4iLA0KPiAr
CQkJCQkJCUdQSU9EX09VVF9ISUdIKTsNCj4gKwkJaWYgKElTX0VSUihzdC0+Z2Fpbl9ncGlvKSkg
ew0KDQppZiB0aGUgR1BJTyBpcyBvcHRpb25hbCwgdGhlbiB3ZSBzaG91bGQgY29udGludWUgaW4g
Y2FzZSBvZsKgLUVOT0RFVi4NCg0KU2hvdWxkbid0IHdlIGhhdmUgYcKgZGV2bV9ncGlvZF9nZXRf
b3B0aW9uYWwoKSBjYWxsIGFsc28gZm9yIGZpbHRlcl9ncGlvPw0KDQo+ICsJCQlyZXQgPSBQVFJf
RVJSKHN0LT5nYWluX2dwaW8pOw0KPiArCQkJZGV2X2Vycigmc3BpLT5kZXYsICJGYWlsZWQgdG8g
cmVxdWVzdCBnYWluIEdQSU86DQo+ICVkXG4iLA0KPiArCQkJCXJldCk7DQo+ICsJCQlnb3RvIGVy
cm9yX2Rpc2FibGVfcmVnOw0KPiArCQl9DQo+ICsJfQ0KPiArDQo+IMKgCXJldCA9IGFkX3NkX3Nl
dHVwX2J1ZmZlcl9hbmRfdHJpZ2dlcihpbmRpb19kZXYpOw0KPiDCoAlpZiAocmV0KQ0KPiDCoAkJ
Z290byBlcnJvcl9kaXNhYmxlX3JlZzsNCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvaWlv
L2FkYy9hZF9zaWdtYV9kZWx0YS5oDQo+IGIvaW5jbHVkZS9saW51eC9paW8vYWRjL2FkX3NpZ21h
X2RlbHRhLmgNCj4gaW5kZXggNzMwZWFkMWE0NmRmLi42Y2FkYWI2ZmQ1ZmQgMTAwNjQ0DQo+IC0t
LSBhL2luY2x1ZGUvbGludXgvaWlvL2FkYy9hZF9zaWdtYV9kZWx0YS5oDQo+ICsrKyBiL2luY2x1
ZGUvbGludXgvaWlvL2FkYy9hZF9zaWdtYV9kZWx0YS5oDQo+IEBAIC0xNzMsNiArMTczLDExIEBA
IGludCBhZF9zZF92YWxpZGF0ZV90cmlnZ2VyKHN0cnVjdCBpaW9fZGV2DQo+ICppbmRpb19kZXYs
IHN0cnVjdCBpaW9fdHJpZ2dlciAqdHJpZyk7DQo+IMKgCV9fQURfU0RfQ0hBTk5FTChfc2ksIF9j
aGFubmVsLCAtMSwgX2FkZHJlc3MsIF9iaXRzLCBcDQo+IMKgCQlfc3RvcmFnZWJpdHMsIF9zaGlm
dCwgTlVMTCwgSUlPX1ZPTFRBR0UsIDApDQo+IMKgDQo+ICsjZGVmaW5lIEFEX1NEX0NIQU5ORUxf
R0FJTl9GSUxURVIoX3NpLCBfY2hhbm5lbCwgX2FkZHJlc3MsIF9iaXRzLCBcDQo+ICsJX3N0b3Jh
Z2ViaXRzLCBfc2hpZnQpIFwNCj4gKwlfX0FEX1NEX0NIQU5ORUwoX3NpLCBfY2hhbm5lbCwgLTEs
IF9hZGRyZXNzLCBfYml0cywgXA0KPiArCQlfc3RvcmFnZWJpdHMsIF9zaGlmdCwgTlVMTCwgSUlP
X1ZPTFRBR0UsDQo+IEJJVChJSU9fQ0hBTl9JTkZPX1JBVykpDQo+ICsNCj4gwqAjZGVmaW5lIEFE
X1NEX1RFTVBfQ0hBTk5FTChfc2ksIF9hZGRyZXNzLCBfYml0cywgX3N0b3JhZ2ViaXRzLCBfc2hp
ZnQpIFwNCj4gwqAJX19BRF9TRF9DSEFOTkVMKF9zaSwgMCwgLTEsIF9hZGRyZXNzLCBfYml0cywg
XA0KPiDCoAkJX3N0b3JhZ2ViaXRzLCBfc2hpZnQsIE5VTEwsIElJT19URU1QLCBc
