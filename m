Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C10CECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 205D62081D
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="V7B+sOzR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 205D62081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbeKHX0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 18:26:55 -0500
Received: from mail-sn1nam02on0042.outbound.protection.outlook.com ([104.47.36.42]:22780
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726897AbeKHX0y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 18:26:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eu5d5PdBi9a3iaaYoQ9Zx8Psha8oahnWh6ZFhbj9iCE=;
 b=V7B+sOzRtLqFiyrw1J7El7w983YL3xvuR9jPCoQNn7JZUoSHY2Sgw6CnMdkI1fxjJ0VPMrM8Kv2w9rG/tpIsXOfK8tJkXLfAbAgAfWqmv2antMOdxLnyIII621M2DNmSWiqJDU4+GImjUI8EG60brbl97joV42G22PSfVN+PG0I=
Received: from BN6PR03CA0008.namprd03.prod.outlook.com (2603:10b6:404:23::18)
 by SN2PR03MB2271.namprd03.prod.outlook.com (2603:10b6:804:d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1294.21; Thu, 8 Nov
 2018 13:51:17 +0000
Received: from BN1BFFO11FD016.protection.gbl (2a01:111:f400:7c10::1:152) by
 BN6PR03CA0008.outlook.office365.com (2603:10b6:404:23::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1294.21 via Frontend Transport; Thu, 8 Nov 2018 13:51:16 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; googlegroups.com; dkim=none (message not signed)
 header.d=none;googlegroups.com; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BN1BFFO11FD016.mail.protection.outlook.com (10.58.144.79) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1294.14
 via Frontend Transport; Thu, 8 Nov 2018 13:51:16 +0000
Received: from NWD2HUBCAS9.ad.analog.com (nwd2hubcas9.ad.analog.com [10.64.69.109])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id wA8DpG9T010167
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 8 Nov 2018 05:51:16 -0800
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS9.ad.analog.com ([fe80::44a2:871b:49ab:ea47%12]) with mapi id
 14.03.0210.002; Thu, 8 Nov 2018 08:51:16 -0500
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
Subject: Re: [PATCH v2 2/2] staging: iio: ad7780: generates pattern_mask
 from PAT bits
Thread-Topic: [PATCH v2 2/2] staging: iio: ad7780: generates pattern_mask
 from PAT bits
Thread-Index: AQHUd2N/r6vJoeoMZk2bZrya8R38RqVGOUOA
Date:   Thu, 8 Nov 2018 13:51:15 +0000
Message-ID: <43efc182fc7ab9aa1d2f1ca798e27d85c7132e1f.camel@analog.com>
References: <cover.1541681371.git.giuliano.belinassi@usp.br>
         <ce8ebadd1638810eaaa3b0b30a961a7b3f88ae34.1541681371.git.giuliano.belinassi@usp.br>
In-Reply-To: <ce8ebadd1638810eaaa3b0b30a961a7b3f88ae34.1541681371.git.giuliano.belinassi@usp.br>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.50.1.244]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <72ED8F6B6E83144397DC23331442CEB4@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(136003)(346002)(2980300002)(438002)(199004)(189003)(36756003)(6246003)(102836004)(5660300001)(11346002)(39060400002)(2616005)(2201001)(476003)(126002)(446003)(8936002)(54906003)(246002)(14454004)(486006)(336012)(575784001)(86362001)(356004)(23676004)(2486003)(4326008)(26005)(7696005)(76176011)(3846002)(7736002)(2906002)(7636002)(6116002)(426003)(436003)(305945005)(106466001)(186003)(47776003)(2900100001)(118296001)(106002)(50466002)(14444005)(7416002)(8676002)(2501003)(316002)(229853002)(110136005)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN2PR03MB2271;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11FD016;1:bLV/HiYRqfaGLMDjYstS3VQ+qeIArZAF0bdtZhAxodThUtjuWLPGLMlNYyQdDrHmzDMEF0Rh6dRufXkeHKw4B9riZH5OklExre4Mh39LY1zofZKhMDlRCRejqJKhPfe3
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d42bdac6-49d6-482f-0b03-08d645814155
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:SN2PR03MB2271;
X-Microsoft-Exchange-Diagnostics: 1;SN2PR03MB2271;3:aZMf22hCy0AVkC2IW4pt+Umb8XHqLncU0aBrkyCs0x/1TVM2XGMkdgEs+XVzZWjC3BvkNPr0hE2LK6iI2knXwK6kJbUox7Pq7WH6QkmbVn91urwbpY/0oTf8Rha81FsZb2OukgPw1co6AhEKuIj+xH6337MK5kFMNVhrTGknYgC7BornXiYkxsHBHKXjU3vJLMI8r8VOtlqZvK0nn/gs2Pw3Px1E0kqV6xhKcqQ4hGlqv01ZNGsKVeo/ZIKb8Iykmq0zQd7nmrKAvbGopGWBZZXTo07NRayNpMHjp5IXlc2G6tSXx9gCA6j89sXYNzIXvO9FEGXHiVjuDlmH90qWod9AckihZdr0TMptScCNbGo=;25:4q7V1JnE4cfZ2caoZnTDeWOVdKNgPuqPAbmKcMg9yGOAVR49rslwDjwVjhEM9AxKqA7Zqs3IALCs6CbuR2lBhM2aIlzkfIucsScly7CyNmRqLYusz3ULn+ihT6R+KoQ1egZ9qxt4E2ZkSxwDcE/t1yqu/AvER7szjZcKVLQ73QEr5P2s+uSoQfolC3/ozyKHkzmlWDrI4u3J5gkQN0Mjd1TMiiZkQaRzY6rzcT1YrOiCsChT2j06bwoPf8W3hscXL69V+92AlZXYKV65dPcgpGg11/2ehOSfAa5tKnWZsyocBEv030UINLvZ+KapBBUtW0B7zqche04ncYaQWKBYsA==
X-MS-TrafficTypeDiagnostic: SN2PR03MB2271:
X-Microsoft-Exchange-Diagnostics: 1;SN2PR03MB2271;31:356sZa0Uku66+3NpS1Jj611M6Bxg6fomgGonpv4aeqxe2Vd/XysFrtsF1RgHAe0mKAGnC2h2TXdxcKUd/fM6iHPjdG74NA6lsUJBjCLlNWWTZNEIKLqAvLec3Wl8NegndCwlCUmGdKBNrL5ZVYIYSOIzYi4tFTLXNBKw6forvxre7TE7JMdFafCEN1z2YRWFqMwD3u9H18+co0sM++9BFIULas8qaRPrlyLMkDWXPik=;20:CnIxzRwxddZ+MA/maZJbkmNd4JOGbBJnAYmB16WmXbUCsxIRiDQIwDyqcDYfznogTHxMsn9XIbjKz5sfxDXGNLZsfFt6eSfqFPozLvaLQzWKNVQ5tJH5vAZr4HBZWP7PNas3KUEVJXyqTtYvy8XSgrAbnR7Z+nvQUHGeiSa1Yh875jCMidvsw0uk///N8K1F6QQqT8CaX/+IIU1IcvRsm0wXl0ZLHVtsABLuqKdUFaFRLfytUjMLANHuMsswWrhg4yHIQ155IwVYVS74HrSJRBthsrIDPGObg+6ERms4V/DRuskb1KpY2vDrrbHgVw+Pewet9Tm/MVCk7C7IVscgDzj2LavZZ4F7d+XEBw53NObkaIEBIgugaWbEB1272V9oVIGV665oGGB0nSQJLIxyOnFhDHJSuJnVudWoxuz/D5uvJcf+eZ3D0kaD0tCF7D+samSc7sQ5geX80s+LWZ3+h6VLaWtghd1kTjOXAoAy7YVP6fbX78CxQu9mbEMqWtpm
X-Microsoft-Antispam-PRVS: <SN2PR03MB227113F9CC6998B7B118939EF9C50@SN2PR03MB2271.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93004095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:SN2PR03MB2271;BCL:0;PCL:0;RULEID:;SRVR:SN2PR03MB2271;
X-Microsoft-Exchange-Diagnostics: 1;SN2PR03MB2271;4:K1m+zobrLgDH5H6URDPfjSfW4GfwHTz1AG4QUMAahJqBb+EjJfJv0WdIOcd9KTzPfhyZSnCGBgaLJ7GF9vSSUQULyzubqrwIagDshe/VRrLqeIKxkNP8fu3zQqgndIdTOST7KrYaqoY1JmTmH9wJavp2Z1ULFYNQjklUKvVELZ9T7hQo9NDRUusK2fiJbSHFgiOVj/q2odZbn0aQNthtOkT/JB+UsT1ew1NlnEMJv/m5LmSTcQhx1acSz6CmPLl9+kKncicH2LGDMIMzrtQRkg==
X-Forefront-PRVS: 0850800A29
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjJQUjAzTUIyMjcxOzIzOjd0anlOamdPQUkyNmpzSGF5K050VE16VlIr?=
 =?utf-8?B?UFZpTjBMQ3BLcmloMG95M3o0Z1o3Y1VWWmQ3ZmgxK1hodjBLS1h1NmJBOEcv?=
 =?utf-8?B?WnMyWGVVNW5pano3SWRWNlRkQXNrem0vN0VQMkdTRFc3eWFGcGZyS3JTSHcz?=
 =?utf-8?B?cFI5cm0yaVRLVHBNcVhkZWtjRW1KNjVXZkIzQURvWkN4eVBRcTh6bDBLOE1l?=
 =?utf-8?B?VkxsT21VYnd6TWZVd2dFbWs4VUZ3OUIvK0dzbVlxb3gxQXBkSk00QSt6bXBy?=
 =?utf-8?B?NWIrWDJlQSs3V21nRitOam9rSGRxSzgyeGh3WWVKaEF2Q3FIcG8zYStmYTVh?=
 =?utf-8?B?cXZ0YTdtUkQra3VWRmhOaVhXN3lRQUMrY3cyd0VqVnptK01qK2ZlYWJEVHBE?=
 =?utf-8?B?NTZrajJxQlFyNjhBZnRHSlpoUWg1dkkveExwUlY0ODRjSm0zSE1UeFZzVE1S?=
 =?utf-8?B?WENBdlo5SUMxWUJHT3NhTVU0dEd5QnZXRnhoVHlxT1ZrOE1WczJUZEx3MWFQ?=
 =?utf-8?B?bnI3SlpyNWlhZGRTNktUUTJhWHN4WDVqdHR4QjhzelNFbEFBdDVuRWFvR1ZV?=
 =?utf-8?B?dDJxS25MZVlrNkNEZVJabXRRWGFVTVV1SEF0QWtWK3ZOa2IxY3ZtTTVyNGlw?=
 =?utf-8?B?cW5zMm1HSDNaV3JZOS9naDhnOGRRdzg4cDFYR3pHZ0h4Y25CZnVFSnEzbGI2?=
 =?utf-8?B?blcyKzdtVFBxeVhzeldGMDVHRWp3eEdRcmhwNy9jWDdLTktUUVZFVDcxb0pU?=
 =?utf-8?B?MGxST0Vsczc0TDhud2d3eTVacUFUZGYwa2t0ZHlDbk93NkhmaTVjVndsOGx1?=
 =?utf-8?B?SHQrdDNhY0RZZzRCYUxmZDU0Y2RENUY5ajgzMmhoZmtOV0ptT1FHQ3hvQkZV?=
 =?utf-8?B?QTdzUzRXcnlWMlVjRWV2eEJvTXA2Z1Zkc2lxZjhySktoOGg5cDlscy9NajMz?=
 =?utf-8?B?R1ZoV3hUdFNEZUZFMjBvOWV1Z2hMMFZQR3hpQndOeWpEMUtaRVFhbGZlRkhy?=
 =?utf-8?B?MlM5U2xJd2lJN3BYZ3hvbm1FeDdzS200SS9oZU1nMFJoVEdtVCs4d1A2NDFM?=
 =?utf-8?B?MFN6cGpsRVFRKzRMS1E4bXdnMzdUbWRncDFMaUpSaHJCaTV4L0REMzBWRVJt?=
 =?utf-8?B?Q0JBcjk3Mnh0c3V5VWtyakYwQjZxQmpBQlBrMS9XTzZDTitNZEpRUnhVNjl3?=
 =?utf-8?B?a2wrZlpBcnhQdElJUjRjRWRjUlhqTmRLZUVBMUdJckVJd2lCSG1RVmNkbUQr?=
 =?utf-8?B?MHRXbkdpZkdQekYvNXJkajNLbzBBejNxV0J1ZldNVDBPczVJQ2liaDJ0d1BD?=
 =?utf-8?B?TzlRcEdUTHRaS082ZjVBVitiZXp4ZjJHRlBkMWpRdFNLZUJNWEVBZm9tZDF6?=
 =?utf-8?B?bU9BbGl2L3k3bEQzazRtOFNjdm5qS2t4cGRDb2Ivb0xxbVRYTUZwc0QvQlFu?=
 =?utf-8?B?Y3hPMHA0M2pwT2M5U0I5aXR6bS9EcHgxVW14SjEzZitSSkY3eXJrNEo1bm9p?=
 =?utf-8?B?dk56aVo4QmRoUEtkWnJzUFZMdk1QRzdNcTdDMjBjS0dHT2pmSjgzZTRjbzJl?=
 =?utf-8?B?MExVWFZaRWtLMlNrVzlSaXJ2YmU4VytyRnpsTysrSnJpMGNhdE9xOEpZdUNP?=
 =?utf-8?B?aEpKT3VoaTBhbkpINmJqR2FFZ3VzWHZoK0xJdDlWdS9MeWU4d1pNN2UzaDQ1?=
 =?utf-8?Q?xNyU5dXxzVUZUX+uIs=3D?=
X-Microsoft-Antispam-Message-Info: LeeohT7ZQpDQe7Y4Zhp5QpNDz/2IFcxWCKDqkkYJs2iIXqUWEN63ZtjVH3tobLkunqWeJkSvpLtoX9SeOShXo5LBlK1hQum1vwuYn3fetiJ1rS0RIJqITWlQbyKzYEc2brYxkpiFhyv33TfhkGTWLy10pgaMsQVhOf3nFvDJVWOQJZdDBp5CGDRW00ppOsgQRZOIUK32PgPFY+bwarmTXMlisSsHxKEreSsY7Qyskabkcx2m+h/rWkY9ujxqny9Cue/jWbjpTPEExZsdammcaRAWeXfxPsBGkFt9gACihL59VL3fduyM0TwKgzxTFitODIjSytusLoEr18He9O1TArceiVT5gtLqmAyUZOjOsPw=
X-Microsoft-Exchange-Diagnostics: 1;SN2PR03MB2271;6:PT5WOLD4rc0+BQ7qX7WUVCo6th/4sHaVo4eHX+anFGyYC8DANyg0XuFPQQmcDjvOUQgalYmCcRXWtF4Fz6x433cyvPcNwse0Sb1WEwWdv3d475gz2JWCxj0WgL6XhOa7jO66gU0CNmtThVNF6j7mNWAq6flw3NguCNjGtjj/GXfV0lm2FhgGDpGAKBqrayzTqpQ3zxhZtL+91gNOGUzbk/T9piIh4aEiSCVUMb21ZPzxb5jNBvyDtdY12M4ihyr1f5/nrZjrgkGxTbmhB0ZeITWqB+DdZ/1EejVQdTcuVJldt58W1WcnuYjfb0Az38DWlU9jwueSXlZdSizqcUZ87KAqfMLPE9lHfDwyAw72b6oOECxOSDPmATkMwHTbl7TSp4DP2ljpPGQoHDPk5SRWfzUXyPW+tUqA9cpoxmM5g7twXl5Qv2e7lHfrjPEgSZQT+TO26LERkcTKyVNc8H6v2w==;5:5CTKJIBbKqsRX4ticlB7AAvPY8r+3CbTKMJb7NdtLJhkanEkupl5/2l3eRAYxByQUbCOrMfAVGJxCs+mHlzXEv1bex+COUelwOg19lM+6K/MVYO7m5k3/rkoxS8LV/qtRbcC1HNCFNroAey64dSulNgY8Ui6N8aNf/DAd+ThiqA=;7:KR1mtiGtkhGt65G3MG7UmFg5vALlR2rBAoXA6mk9kBA8pX5eBfbFTpNC48uAi7fr/RqgFy01k+HBlFdRKDmfi6AEcUUc05lYpPWJveLH2bUpM0IxiX6MHlUCwQWkJpuWkszm85OQM5AByThaRpM0fg==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2018 13:51:16.6975
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d42bdac6-49d6-482f-0b03-08d645814155
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR03MB2271
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE4LTExLTA4IGF0IDExOjAzIC0wMjAwLCBHaXVsaWFubyBCZWxpbmFzc2kgd3Jv
dGU6DQo+IFByZXZpb3VzbHksIGFsbCBwYXR0ZXJuX21hc2tzIGFuZCBwYXR0ZXJucyBpbiB0aGUg
Y2hpcF9pbmZvIHRhYmxlIHdlcmUNCj4gaGFyZGNvZGVkLiBOb3cgdGhleSBhcmUgZ2VuZXJhdGVk
IHVzaW5nIHRoZSBQQVQgbWFjcm9zLCBhcyBkZXNjcmliZWQgaW4NCj4gdGhlIGRhdGFzaGVldHMu
DQoNCk9uZSBjb21tZW50IGFib3V0IGluZGVudGF0aW9uL3doaXRlc3BhY2UuDQoNClJlc3QgbG9v
a3MgZ29vZC4NCg0KQWxleA0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBHaXVsaWFubyBCZWxpbmFz
c2kgPGdpdWxpYW5vLmJlbGluYXNzaUB1c3AuYnI+DQo+IC0tLQ0KPiBDaGFuZ2VzIGluIHYyOg0K
PiAJLSBBZGRlZCB0aGUgUEFUVEVSTiBhbmQgUEFUVEVSTl9NQVNLIG1hY3Jvcw0KPiAJLSBVcGRh
dGUgQklUIG1hY3JvcyBhbGlnbm1lbnQgdG8gbWF0Y2ggd2l0aCBQQVRURVJODQo+IAktIEdlbmVy
YXRlIHBhdHRlcm4gbWFzayB3aXRoIFBBVFRFUk5fTUFTSyBtYWNyb3MuDQo+IA0KPiBkcml2ZXJz
L3N0YWdpbmcvaWlvL2FkYy9hZDc3ODAuYyB8IDQwICsrKysrKysrKysrKysrKysrKystLS0tLS0t
LS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMjQgaW5zZXJ0aW9ucygrKSwgMTYgZGVsZXRpb25z
KC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zdGFnaW5nL2lpby9hZGMvYWQ3NzgwLmMN
Cj4gYi9kcml2ZXJzL3N0YWdpbmcvaWlvL2FkYy9hZDc3ODAuYw0KPiBpbmRleCA5ZWMyYjAwMjUz
OWUuLmZmOGUzYjJkMGVmYyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9zdGFnaW5nL2lpby9hZGMv
YWQ3NzgwLmMNCj4gKysrIGIvZHJpdmVycy9zdGFnaW5nL2lpby9hZGMvYWQ3NzgwLmMNCj4gQEAg
LTIyLDE0ICsyMiwyMiBAQA0KPiAgI2luY2x1ZGUgPGxpbnV4L2lpby9zeXNmcy5oPg0KPiAgI2lu
Y2x1ZGUgPGxpbnV4L2lpby9hZGMvYWRfc2lnbWFfZGVsdGEuaD4NCj4gIA0KPiAtI2RlZmluZSBB
RDc3ODBfUkRZCUJJVCg3KQ0KPiAtI2RlZmluZSBBRDc3ODBfRklMVEVSCUJJVCg2KQ0KPiAtI2Rl
ZmluZSBBRDc3ODBfRVJSCUJJVCg1KQ0KPiAtI2RlZmluZSBBRDc3ODBfSUQxCUJJVCg0KQ0KPiAt
I2RlZmluZSBBRDc3ODBfSUQwCUJJVCgzKQ0KPiAtI2RlZmluZSBBRDc3ODBfR0FJTglCSVQoMikN
Cj4gLSNkZWZpbmUgQUQ3NzgwX1BBVDEJQklUKDEpDQo+IC0jZGVmaW5lIEFENzc4MF9QQVQwCUJJ
VCgwKQ0KPiArI2RlZmluZSBBRDc3ODBfUkRZCQlCSVQoNykNCj4gKyNkZWZpbmUgQUQ3NzgwX0ZJ
TFRFUgkJQklUKDYpDQo+ICsjZGVmaW5lIEFENzc4MF9FUlIJCUJJVCg1KQ0KPiArI2RlZmluZSBB
RDc3ODBfSUQxCQlCSVQoNCkNCj4gKyNkZWZpbmUgQUQ3NzgwX0lEMAkJQklUKDMpDQo+ICsjZGVm
aW5lIEFENzc4MF9HQUlOCQlCSVQoMikNCj4gKyNkZWZpbmUgQUQ3NzgwX1BBVDEJCUJJVCgxKQ0K
PiArI2RlZmluZSBBRDc3ODBfUEFUMAkJQklUKDApDQoNCkNoYW5naW5nIGluZGVudGF0aW9uIGhl
cmUgZG9lc24ndCBhZGQgbXVjaCB2YWx1ZTsgaXQncyBtb3N0bHkNCnBhdGNoL3doaXRlc3BhY2Ug
bm9pc2UuDQoNCldoaWxlIEkgYWdyZWUgdGhhdCBpdCBsb29rcyBuaWNlciB0byBpbmRlbnQgYWxs
IHRoZXNlIHRvIHRoZSBzYW1lIGxldmVsLA0KeW91IGFsc28gbmVlZCB0byB0aGluayBhYm91dCB0
aGUgZmFjdCB0aGF0IHRoZSBrZXJuZWwgZ2l0IHJlcG8gaXMgYWxyZWFkeQ0KcHJldHR5IGJpZyBh
cy1pcywgc28gaXQncyBhIGdvb2QgaWRlYSBpZiBhIHBhdGNoIGFkZHMgYXMgbXVjaCBjb2RlL3Nl
bWFudGljDQp2YWx1ZSBbYXMgcG9zc2libGVdIHdpdGggYXMgbGl0dGxlIGNoYW5nZSBbYXMgcG9z
c2libGVdIGFuZCB3aXRoIGFzIGdvb2Qgb2YNCnJlYWRhYmlsaXR5IFthcyBwb3NzaWJsZV0uDQpb
IEtpbmQgb2Ygc291bmRzIGxpa2UgYSBiYWxhbmNlIGFjdCBiZXR3ZWVuIHRoZSAzIHRoaW5ncyBd
Lg0KDQoNCj4gKw0KPiArI2RlZmluZSBBRDc3ODBfUEFUVEVSTgkJKEFENzc4MF9QQVQwKQ0KPiAr
I2RlZmluZSBBRDc3ODBfUEFUVEVSTl9NQVNLCShBRDc3ODBfUEFUMCB8IEFENzc4MF9QQVQxKQ0K
PiArDQo+ICsjZGVmaW5lIEFENzE3MF9QQVQyCQlCSVQoMikNCj4gKw0KPiArI2RlZmluZSBBRDcx
NzBfUEFUVEVSTgkJKEFENzc4MF9QQVQwIHwgQUQ3MTcwX1BBVDIpDQo+ICsjZGVmaW5lIEFENzE3
MF9QQVRURVJOX01BU0sJKEFENzc4MF9QQVQwIHwgQUQ3NzgwX1BBVDEgfCBBRDcxNzBfUEFUMikN
Cj4gIA0KPiAgc3RydWN0IGFkNzc4MF9jaGlwX2luZm8gew0KPiAgCXN0cnVjdCBpaW9fY2hhbl9z
cGVjCWNoYW5uZWw7DQo+IEBAIC0xMzYsMjYgKzE0NCwyNiBAQCBzdGF0aWMgY29uc3Qgc3RydWN0
IGFkX3NpZ21hX2RlbHRhX2luZm8NCj4gYWQ3NzgwX3NpZ21hX2RlbHRhX2luZm8gPSB7DQo+ICBz
dGF0aWMgY29uc3Qgc3RydWN0IGFkNzc4MF9jaGlwX2luZm8gYWQ3NzgwX2NoaXBfaW5mb190Ymxb
XSA9IHsNCj4gIAlbSURfQUQ3MTcwXSA9IHsNCj4gIAkJLmNoYW5uZWwgPSBBRDc3ODBfQ0hBTk5F
TCgxMiwgMjQpLA0KPiAtCQkucGF0dGVybiA9IDB4NSwNCj4gLQkJLnBhdHRlcm5fbWFzayA9IDB4
NywNCj4gKwkJLnBhdHRlcm4gPSBBRDcxNzBfUEFUVEVSTiwNCj4gKwkJLnBhdHRlcm5fbWFzayA9
IEFENzE3MF9QQVRURVJOX01BU0ssDQo+ICAJCS5pc19hZDc3OHggPSBmYWxzZSwNCj4gIAl9LA0K
PiAgCVtJRF9BRDcxNzFdID0gew0KPiAgCQkuY2hhbm5lbCA9IEFENzc4MF9DSEFOTkVMKDE2LCAy
NCksDQo+IC0JCS5wYXR0ZXJuID0gMHg1LA0KPiAtCQkucGF0dGVybl9tYXNrID0gMHg3LA0KPiAr
CQkucGF0dGVybiA9IEFENzE3MF9QQVRURVJOLA0KPiArCQkucGF0dGVybl9tYXNrID0gQUQ3MTcw
X1BBVFRFUk5fTUFTSywNCj4gIAkJLmlzX2FkNzc4eCA9IGZhbHNlLA0KPiAgCX0sDQo+ICAJW0lE
X0FENzc4MF0gPSB7DQo+ICAJCS5jaGFubmVsID0gQUQ3NzgwX0NIQU5ORUwoMjQsIDMyKSwNCj4g
LQkJLnBhdHRlcm4gPSAweDEsDQo+IC0JCS5wYXR0ZXJuX21hc2sgPSAweDMsDQo+ICsJCS5wYXR0
ZXJuID0gQUQ3NzgwX1BBVFRFUk4sDQo+ICsJCS5wYXR0ZXJuX21hc2sgPSBBRDc3ODBfUEFUVEVS
Tl9NQVNLLA0KPiAgCQkuaXNfYWQ3Nzh4ID0gdHJ1ZSwNCj4gIAl9LA0KPiAgCVtJRF9BRDc3ODFd
ID0gew0KPiAgCQkuY2hhbm5lbCA9IEFENzc4MF9DSEFOTkVMKDIwLCAzMiksDQo+IC0JCS5wYXR0
ZXJuID0gMHgxLA0KPiAtCQkucGF0dGVybl9tYXNrID0gMHgzLA0KPiArCQkucGF0dGVybiA9IEFE
Nzc4MF9QQVRURVJOLA0KPiArCQkucGF0dGVybl9tYXNrID0gQUQ3NzgwX1BBVFRFUk5fTUFTSywN
Cj4gIAkJLmlzX2FkNzc4eCA9IHRydWUsDQo+ICAJfSwNCj4gIH07DQo=
