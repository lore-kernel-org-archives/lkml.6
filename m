Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B53BEC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 08:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57A1620891
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 08:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=epam.com header.i=@epam.com header.b="Uw67dZFu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57A1620891
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=epam.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934829AbeFMIR3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 04:17:29 -0400
Received: from mail-eopbgr70071.outbound.protection.outlook.com ([40.107.7.71]:52379
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933618AbeFMIRZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 04:17:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kCmpQvTG+9+XdFAJ3HxvqtrMUkcoKDf2V7XxumlK6l0=;
 b=Uw67dZFuxgD0DnylGZpoClNPDxWxjY011lZEvtSP6uGmoPHko5UDhAHfBWSSSOcr48EwWxrBABZbntB04jzxuAiwIZl35jPNlGQdR4uB95Dsn/tBGwWqeaDGiPW9AIzXqWjJXDvn6wFdXaHLkq0TOQFneIhI4E3XUFV0NUS1E08=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Oleksandr_Andrushchenko@epam.com; 
Received: from [10.17.182.9] (85.223.209.53) by
 DB3PR0302MB3211.eurprd03.prod.outlook.com (2603:10a6:8:9::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.18; Wed, 13 Jun 2018 08:17:22 +0000
Subject: Re: [PATCH v3 7/9] xen/gntdev: Add initial support for dma-buf UAPI
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Oleksandr Andrushchenko <andr2000@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        jgross@suse.com, konrad.wilk@oracle.com
Cc:     daniel.vetter@intel.com, dongwon.kim@intel.com,
        matthew.d.roper@intel.com
References: <20180612134200.17456-1-andr2000@gmail.com>
 <20180612134200.17456-8-andr2000@gmail.com>
 <916e91c9-0710-0afb-2f49-4a7c7b4c02b5@oracle.com>
From:   Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>
Message-ID: <96c72c58-c41d-5140-804e-5d4f03934b06@epam.com>
Date:   Wed, 13 Jun 2018 11:17:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <916e91c9-0710-0afb-2f49-4a7c7b4c02b5@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [85.223.209.53]
X-ClientProxiedBy: AM0PR05CA0025.eurprd05.prod.outlook.com
 (2603:10a6:208:55::38) To DB3PR0302MB3211.eurprd03.prod.outlook.com
 (2603:10a6:8:9::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9bd71575-9422-4394-87c6-08d5d1061747
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(711020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0302MB3211;
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0302MB3211;3:rde7ehIjtrM0oAwfnsXo5nS1XU3DsJXNpaw+gqJT4szqz9qyTSjPQsWRrcnaWArBtI53srC3STzUbFPNasneUKnZ0soZoHOFfO0UX7idmLv0p+Tg591YqxYKxo5Q4zA/h3kzkY1u5pbqBaNQcoxjmgtsGi5yPRUsCBm8ArwiHcdXqrUD6gOxSzeHWQCO0Z9iQDN3wZ9+eB8Ed+SfV8Nd4jGVUxGJ1+NMGFDBWKqb3XXNt6ruTqLdSi2UAdKBOmUx;25:ZjvSm2kFZgrUG7A4kjwnGgKnyK5VyygU0LJ2I7LSql+KdcKb3kQNggVCHURdPf/O9IX6+n50U/5BEygXF31YHXdahNqloDeyq+5x+fW0chbnNWFgf/qKEbw1upWkaqPb+765cO0vGRrSqZ8YVr661HGBJSZehgX6I13mBkIxzl9OWDtj6G0oIxAh2gyfRuThCjp25GI65WhwKnr4OBBHwW/lr+pfH5pw1aKKD22rmzNl2QMFgx7iT+emel5/wxAtNYr6J2CvhRG7ly7dJm8p7nmJB/L7F7VlnvRWRYd3pGF1AdlGFfxVqdRxbjVcDrP9OdCBRrDws9vQEo3YtompPw==;31:L/yKBgeYd03ctTfZqLihaFqLYQI1OHjJce+x3RyIMUrrtnZtmXqzqrdXaQVuCkiwtYSgSlst+YOdQFhLLNtB08Cjp4tD5/H0qIMjEB7/75dP7f6gMuM48P6KYGwZpo41Q6+g905vjaZ2P5zE0VB3OHgmFcj2JTE4v/HqwEG0GCAEI084UoXbUulIuvkPvjTbqFicNjGPhHrlUiliiOgErP2mBCbzBUhOrW0B0g9OvA4=
X-MS-TrafficTypeDiagnostic: DB3PR0302MB3211:
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0302MB3211;20:53+SwtpYnPqGeIK9xtDaNzVtyRtxIpl+WeLbhgB3JxIZ9UIA/yAVKRFiRSEG/qgvnPjdhrOh2kE9iBsVrCBn8h3jTrCTQForapavZ+yNXrZ5z5MyCkxcRkOAQozupd781vKRh+1/FIbidLs2Aopnrl+9/oHc4YO2Xblh9m0WSU7beMIeCgUPuBC62Qd+lb0cjy1B3QT+DmaM4mey9FfG6JINL9yp17YpwrI+OXgKD13csbGcAwB7/n8c8PCUBsjLxIrZ16JuPRQfP4MUhZ/2bf5eSg/gVE+U3+5NJZToKewZLmtr2cGVAtjYfBS927uP/cBvKDAmEw05sSSioxEXZvXpgoX8Kc3wzmhOhw3r24iFcZmnTK/PpNuUGaF/iWIqsEalk0nZj2An75I6yrVfMUOiwau9kCB+DuhLW2kQrFfIVu79STewsC5QlclKFwVXVXJJjRLd8A+CaOAvDFFf41w2Gs2AaK1rE77cCGPexkSdM+ZLktzD7DWVmGUn36F2;4:nf3Pb2Ke/U6WUX9grCJ9URzRiZyDSugqx3HCZFGDJpkjhbHp21yuVU2miUrVkfvBAJjbMA5gLsJG8zxZwrVhcz3+ThAwwSKaJPT6TIibKswgvvBM8uMQbbNiRNz0Hp7EZxUcqzupGf0eWjZZsg9yk/PLXGXHZLEQg99zW8aMnZEyVxlL4NBmW1Y6hcAhHcJLbnS4o+3MQVGJdrbCfRxZxjclkvWJyJ3JctHWySVBpMf/+JWWTEFYid4UC8FLq3QaPPvjVDzunmodmB4IATSdkw==
X-Microsoft-Antispam-PRVS: <DB3PR0302MB3211438BC41B22D99AD07A89E77E0@DB3PR0302MB3211.eurprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DB3PR0302MB3211;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0302MB3211;
X-Forefront-PRVS: 07025866F6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(376002)(346002)(396003)(366004)(39860400002)(39380400002)(189003)(199004)(97736004)(76176011)(80792005)(4326008)(106356001)(66066001)(77096007)(59450400001)(65806001)(105586002)(31696002)(53936002)(386003)(53546011)(26005)(31686004)(478600001)(6666003)(86362001)(72206003)(36756003)(65956001)(6246003)(956004)(55236004)(39060400002)(25786009)(47776003)(229853002)(2616005)(186003)(8936002)(16576012)(2906002)(316002)(7736002)(305945005)(11346002)(8676002)(486006)(67846002)(23676004)(2870700001)(110136005)(52116002)(3846002)(7416002)(6116002)(50466002)(58126008)(68736007)(5660300001)(16526019)(81156014)(81166006)(6486002)(64126003)(476003)(2486003)(65826007)(52146003)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0302MB3211;H:[10.17.182.9];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: epam.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjNQUjAzMDJNQjMyMTE7MjM6VVIyQnlqWDRUdHN3REw5N0tHNTRxVktn?=
 =?utf-8?B?cHNva2taNHI4dFMzOWEzQTQ1ZzAzQU5vK3pFMm91SVo4Q3B1VTBlcFAvZWNZ?=
 =?utf-8?B?QnlpdlNBWDRWdlQxdm5oTDFFbTY1WFRxdFlWbHM5MUJaOXNCbGpZWGZNc3V5?=
 =?utf-8?B?RmVMaG90V0ZyRFJSU3FQQ3Yxb2hPT0FMS2E0TFZUcVdId1d0dkNTWDFOMTQy?=
 =?utf-8?B?cnJwK1p3ekJOeUFKTjRSSGIybThkU3BFbi9TRlA3VGFtTHRzbStWeSsyL0N5?=
 =?utf-8?B?SWJOZGMvcjRjcTVlencyUm9mWElQVjdFMUlHSHNqQmhWdE9venZmNzloUVFo?=
 =?utf-8?B?eENIS3MxYWZuTURMUCt4cGRQbmNXeGZFam03bHNoMmRnK281SmMvclVPbmlx?=
 =?utf-8?B?aU95YnN3VEd5YW1WM1dhUnJaQWxxb3NXdkJlL3hlcWM4VEpuTjRJcW4zWDR0?=
 =?utf-8?B?NHhJSVVvQ2VJb25ETDlpdCtyUHU3QVV4MVpobXlPVUdnK01mM29qNVdUVURV?=
 =?utf-8?B?SENnSGZJazdudGtjRlE4b1I0aGdSaGNuQmtJTzdEM2E3Mmp2VlZNMkUrNVRX?=
 =?utf-8?B?eDBVWUkrcjVJZjlUZzhEbzMwOFgrSmZ0MlR1aktaUjJGeXl1Qk1GVGI3cEZi?=
 =?utf-8?B?YXJUbFFyd09KQURqbFg4TDFkcE9KVjJ1cDRwcFJETTNjMnJhZWdaZzROSS9H?=
 =?utf-8?B?c2F6OXJzZ1VJOWRDZnpBUExWTE5WdWZpV2xxTGxySDdYRVM1dVcrdVVLZFhm?=
 =?utf-8?B?STRYcG9MMjh0NmEvUTBTb1NCVnFsYjRwTVN5RllnVGZnRFBJbGVISnV0STRy?=
 =?utf-8?B?M1hpbXlrUlQ0aXhMUDk1cXpaNnFBUFRGUFV3SW9FVGU1Zk1VNldFR3RTemJq?=
 =?utf-8?B?VERmUEZ6OEpHRit5bm1HbXF3ZS8ySitFN2g3QVRVUTU2d0lXMGx2aTBZQ3pB?=
 =?utf-8?B?S0IxcWpIN3BOcEZydUpRUkxlUUdPUk1zcGFPL0tDd0VxdksvMHhiTWQ5Wk9S?=
 =?utf-8?B?azFtelRYaHlERFNTdFkyOGZBczJzTXdJa2JFNWhEeCt2MWdPRHdUVTR5Tlhh?=
 =?utf-8?B?MDlHMlk5UVRwMUV1T20rV2pkNHBXZ2FEbWRoMXVadStXRDN3aHg1Y0UyT0t2?=
 =?utf-8?B?WFcraUdVeTdwTkNEQmpjM085S1NhS3JaUWt6c3pzdzVETkdTYUZZd1lxUG40?=
 =?utf-8?B?QkRLcG9UcHR3SXF6WkFDT2JEVEdqY2NqTlRZWkx4QWtRWnowQ1l6ME50SVR2?=
 =?utf-8?B?QXM2QWd5eHk1TGRHRVJwSENOR1RFYmd0RUdZV2t0b1V5RUtXR2VSMk1kdyty?=
 =?utf-8?B?b09EUUNOMkpmS3kxcDE1dVpoUjQ3U0VmQks5WFJkaGY0anN3OXAyUnJxbFA3?=
 =?utf-8?B?QmF6MWwyRHNLdWJBdVF3djN0eWo5cnF2S2c1SXUyamwvUldMN29aUVNUWDd1?=
 =?utf-8?B?Uk5Hd0V0WVpacVphaGVMb3RDaXZBU28xalZEUFpCNHBOSnBjTWcwajFmZ0NH?=
 =?utf-8?B?cFlHbXM2RnJuNyszOTZpZVJGMXJRbytYWnA5b0dwUDUrbWNvWFBucHFmaG93?=
 =?utf-8?B?NVJlcDV6OFM1WDZkNTErTEdkdzEvcEFwNGcrSHY5b3pSajNUT0QvOXhXSDNC?=
 =?utf-8?B?REN6SWx6NXZNQUFmZGIybngwWVNwTjA3aUNVRkJZVnRoY1lqcE9NZ1Jhdllw?=
 =?utf-8?B?dldlWnkwMll3eEx4b0xFOFBETE51SWpveXVRNEdnK1NRTWdvWDBGU3E2OGpO?=
 =?utf-8?B?KzE4a2dXSzMyUExhRmZaT0tqVzV0MGZWbDdRQXN0MktRdytvTmdOaWV4NDAr?=
 =?utf-8?B?WSszYjJva3drR0RKVDZ6TDE5elpNVzhnT0loa0xNQVlCZnljMFp0RjdYOGN6?=
 =?utf-8?B?WU5DZmt4a0tuS245bkJzeTNCMUlmRzRtcWN4MkZtd0ZWVXdacDczclRFc2Jo?=
 =?utf-8?B?emdMSmpVWUJ3bHpGdzRSREdjd2ZnbVpQV2FLNUh3K2pYV0txdk56bWNaY1lv?=
 =?utf-8?B?eFRrTTg3TDdtZ09KL3UyelVZbkY0blRBRTBqcG9hZkV2T3lTR3JRZitQR0FN?=
 =?utf-8?B?S0xjZGhtM2ZFa200V01YZXU1YVBIZnQ2a0JhaVAxcUk5WVNhTllHa3JtY3BY?=
 =?utf-8?Q?QNQGl+n5evOhrCan2EYzCnYow=3D?=
X-Microsoft-Antispam-Message-Info: xFxmhBfHv0M/Kb5YkU8P9lpy9hK2BDZ+G2OtudsDRVf+ftrvwydTzVASQzERBKs2jrK2XwhST7WGY1BGGedGyTYuONS5GvZbqLCJOITvk7QtXTXkfIcCwFOsN3tJ+woUO0/vWfmi1MYLw72FyDtmkImBImG4U0CY61/PjOKtRWInCrMZ8E0E1pDMezpZgLNQ
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0302MB3211;6:gTyhPoexXt+8BFu9V+zd/8SBD5kJd2V1Hu/4p2N23eWkiu2BypBvwUGPXhSFVaftyaWKdUCGFEIHs0LP97Ws7gmmHsrUTFvawZ2TV3tlrh15/Usfa6MUMu2U6KmInWHA5eykGlZ2iBT7b4Vw98d1x26+HDXJCD2sB4qkSLy15qv5omJ/QQfiufX2+hF5uUBPEJ/TrwZoqA9GnD81dNB1gI6CYVN1ZnfvIkE9pjXY0hnhAddnw85Wx2+E8fYCvVCFFODm+UIZP+PsY7TNzvHstXTyehf9xETVzvLPw+flkenc3P+cTXEFMZOOqbvPm7wQ133zfUvGLhneWcJ3qv9Pn+wW9FBjdE/00STMcrwwuRdfBxk1FdmkvldbgzzUChdMkv6XmQGfazZ8ORyd+5vi+clgzUHVoob/AvcTJKc7y6lqcBYz3+jBtAKG6CPm1Ni9qfHfXngg7PRP6Dky+V5zig==;5:em3+o7cI5J/qgStqs37o64CM4dt5CgL4uufz/zBQcTf+mGa3sU3xusDVPJcRSnpxbWp/Lf4GCy7skKSdEvsvDBBooz9RgonSHFgqHpAQUZbisI/S4XincRj10OyJDm0uMr5H4DYdhLjnI33tXlHSqVDW76Vp9uDRGeI4LAvNhKE=;24:wSzTrKspdIOywcyBrCE41rnVmcoHXEtWArs9fvEQAYtHAmkZfBchlB+P4WsBsy9gkrD6okEzX1iEyEe/Y8pEsV2s05xLa0t7avKHH3KReYM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0302MB3211;7:dBqvIesuE4s5rL3Yyq9eJq6akKxEm1XEWREIupLs2Ty5naI3aIqWSUb8qA4a513GgR34JPNQ6enHwmP4oufagxeRVjI4Xs2JvvPDOuDeGAT6z+fS0qCIxWFzxNSoHZUjzA5gQixjdvVqwtfCu2kG/KEfUX9a2aNkub7xP35cgqdOLuz4E42uw1FTYGAu3uSY+4OHN9wZtVRj+8swqYYJwNBOyjHv7jx/e8blXLr9ytJfRzNOE8uZyuLDEKv4s2fz
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2018 08:17:22.4669 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bd71575-9422-4394-87c6-08d5d1061747
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0302MB3211
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/13/2018 04:49 AM, Boris Ostrovsky wrote:
>
>
> On 06/12/2018 09:41 AM, Oleksandr Andrushchenko wrote:
>
>> diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
>> index a09db23e9663..e82660d81d7e 100644
>> --- a/drivers/xen/gntdev.c
>> +++ b/drivers/xen/gntdev.c
>> @@ -48,6 +48,9 @@
>>   #include <asm/xen/hypercall.h>
>>     #include "gntdev-common.h"
>> +#ifdef CONFIG_XEN_GNTDEV_DMABUF
>> +#include "gntdev-dmabuf.h"
>> +#endif
>>     MODULE_LICENSE("GPL");
>>   MODULE_AUTHOR("Derek G. Murray <Derek.Murray@cl.cam.ac.uk>, "
>> @@ -566,6 +569,15 @@ static int gntdev_open(struct inode *inode, 
>> struct file *flip)
>>       INIT_LIST_HEAD(&priv->freeable_maps);
>>       mutex_init(&priv->lock);
>>   +#ifdef CONFIG_XEN_GNTDEV_DMABUF
>> +    priv->dmabuf_priv = gntdev_dmabuf_init();
>> +    if (IS_ERR(priv->dmabuf_priv)) {
>> +        ret = PTR_ERR(priv->dmabuf_priv);
>> +        kfree(priv);
>> +        return ret;
>> +    }
>> +#endif
>> +
>>       if (use_ptemod) {
>>           priv->mm = get_task_mm(current);
>>           if (!priv->mm) {
>> @@ -616,8 +628,13 @@ static int gntdev_release(struct inode *inode, 
>> struct file *flip)
>>       WARN_ON(!list_empty(&priv->freeable_maps));
>>       mutex_unlock(&priv->lock);
>>   +#ifdef CONFIG_XEN_GNTDEV_DMABUF
>> +    gntdev_dmabuf_fini(priv->dmabuf_priv);
>> +#endif
>> +
>>       if (use_ptemod)
>>           mmu_notifier_unregister(&priv->mn, priv->mm);
>> +
>>       kfree(priv);
>>       return 0;
>>   }
>> @@ -987,6 +1004,107 @@ static long gntdev_ioctl_grant_copy(struct 
>> gntdev_priv *priv, void __user *u)
>>       return ret;
>>   }
>>   +#ifdef CONFIG_XEN_GNTDEV_DMABUF
>> +static long
>> +gntdev_ioctl_dmabuf_exp_from_refs(struct gntdev_priv *priv,
>> +                  struct ioctl_gntdev_dmabuf_exp_from_refs __user *u)
>
>
> Didn't we agree that this code moves to gntdev-dmabuf.c ?
>
Sure, didn't think we want IOCTL's code to be moved as well,
but that does make sense - will move all
> -boris
>
Thank you,
Oleksandr
