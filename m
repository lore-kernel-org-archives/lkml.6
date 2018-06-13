Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A9200C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 06:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49554208AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 06:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=epam.com header.i=@epam.com header.b="i6hB7x1P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49554208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=epam.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754507AbeFMG0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 02:26:33 -0400
Received: from mail-eopbgr70071.outbound.protection.outlook.com ([40.107.7.71]:23436
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754377AbeFMG0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 02:26:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NLkHW39qaMxfwemBgfn06GFE6JO4NG909bpMH0v0tA0=;
 b=i6hB7x1PXwfslcHVTkTiETLiAwX+oIXEQ5pLqkck2XaZ4p474Djm4PBf3/S3rokR4UL7A50iI9ATKnRkfDYQttUbkGnitW6xnJz+TtYBg/i+/GyqfqsSBdl3RxP5yjokmrrAtC+t4F7IlUn+aXQTVE+i0TngVfDWyULCBIY8llA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Oleksandr_Andrushchenko@epam.com; 
Received: from [10.17.182.9] (85.223.209.53) by
 VI1PR0302MB3215.eurprd03.prod.outlook.com (2603:10a6:803:18::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.841.18; Wed, 13 Jun
 2018 06:26:26 +0000
Subject: Re: [PATCH v3 3/9] xen/balloon: Share common memory reservation
 routines
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Oleksandr Andrushchenko <andr2000@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        jgross@suse.com, konrad.wilk@oracle.com
Cc:     daniel.vetter@intel.com, dongwon.kim@intel.com,
        matthew.d.roper@intel.com
References: <20180612134200.17456-1-andr2000@gmail.com>
 <20180612134200.17456-4-andr2000@gmail.com>
 <d63f0cf5-5154-f2a3-155e-fdb6dd0959e2@oracle.com>
From:   Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>
Message-ID: <cbaeec5c-0d69-881c-2b42-54855e53015a@epam.com>
Date:   Wed, 13 Jun 2018 09:26:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <d63f0cf5-5154-f2a3-155e-fdb6dd0959e2@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [85.223.209.53]
X-ClientProxiedBy: AM5PR0701CA0008.eurprd07.prod.outlook.com
 (2603:10a6:203:51::18) To VI1PR0302MB3215.eurprd03.prod.outlook.com
 (2603:10a6:803:18::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d37cb88-85ba-495b-0c96-08d5d0f697c6
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(711020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0302MB3215;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0302MB3215;3:+RbNADRbZqNRybqeHLeD8+j8mjo8rpyVgNmsWQkBuO6ki7Vskig8ETZKq0buYZ8+tShY4wIVn2Dh0NGuTUfypRinLC7ND1shLBj3ggMfYeoRZ3TCt0kQfEQlzvIhnWAmbUW61ghkGOu94t9ZKZth8y6hG/mPTC97EiLnW5574M+yGT51GzFNBT6OtybKIP6uetaoerr72tbbhMbzMVEh5hWD1O54YW5AMv251QLIrF3X+7RXxCFwaZem3QO2CR1I;25:NUjpL/gQQrD0nIDAjIV9HtcwPTS1ztINlqo4m88bkOTb+EjMZ0Z7/sZRplB3991sjxaKGzeE36iDsYXfmSa3Hd94/lVXSWF1YwPkKxjKpA0lUx5u2NJ9ELqWfg524JOqR8c/lYuYbBwQOjRrA+8iRZapq9HEdNK846gnmvRenVenkNGJgp59CpRv1BN9u0D177idp0edG8OCTtcZI5YC99LyLiva7tg8yOGPEgnHa0Yb+SR1wg4/DbO84qVWmP6iL/ww9QtzTKgjjKnLYOcoENWJ9rDYEOWHrXss3XddrPuEI8n18DPg1jDpy/lYoGmkmBaQQull3ds+JPO7SNsq9Q==;31:VKMOWdSexfUhnvCSml+NdPTNZ0LiItWIRZhXyS7ucRJonmK1e5tVQlgwtKbelkvh312EHqlOERqCpoCdg3rec4DVMzC67+NYh8QpUjoe39wEpU4VzMofsDQfLXbMfXB96idCiR6r9xI08vZfIdhTzAj3fXIjqN6dcBcdnWb1v35XoQaN02hQOjbgsLT2f/wy37ISO/MlFuXM0R1gduVJgBFJZ59ITl8G2RgK2qtVzLQ=
X-MS-TrafficTypeDiagnostic: VI1PR0302MB3215:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0302MB3215;20:cBXAlFA4J6Y05PY9Az9AcjhUCqBxE6SpGan2Pa6FWYAqDhutLs67MhXBcPYDE5Tsm/OZh4yQrkXiIKcboybBswl6emyglJhhqAr0gCS/21tjU1rEM5KyMg+rsIOpfqzDrPOo/N2MFeFYLE0yEKdxwXm3UwBP//FsD8tw1yd0lxo1N/8MDzcYdCpYWWEki6T2184GOeXuDoNpczsNkT597170y0x8ixCU8f/oZBuSgSjIu445kNxcy41Atp3Tm4xuY/153umD6pZEOsQ9rcEXmbc38GE59FR7K6FBbLoKzgvktntbzgZtXl5kIsvMUrB91EcR0F6mNH3ftf2l3w9EAzjJMEAKOlImkLbhO61C+uZFg1Jj74IZmTBSMvWTS8KIMLl92cbx/jWmfE3Gkh7PzGoxgDbqq09AZ7m7diHmLMbPSBAtpPKL1XmWpQbxYl1MbCvDrWP51/wKnkYEWo17Ck21BXqLPn12a+07uhOOcSCvBg2OSvEu+mhmLR1gq7fI;4:PrsqGnmMmyRdmHepd3fo2FEOYGbkS0Q7T5Y1Fa+rNKRiE9m74+FtteO0teDK3VRNaYjMGG9S3Eucsj7Y1MAIDPDJCCZmrY84sIx3I06dGM159XzxeFkYAyOr4J0RcyA6OwHfd8osOxO433Cs4VS8VI6GvzO7ATPOpsuh5Ct4bbZ8Dr6KQyKtVyoPswXBcT4oQoHOqQzcGhIrTwtq5j+ly6UkBvLXQi2XxaKbOsX92H3+6lUQe9KN1/akxjxbuqBnN1jCUp1sPWOAuukfTeqYnZLVxnZQ/lNeXTMqfjQTHa6Va9S/2zGwjnfbDlA7jkNd
X-Microsoft-Antispam-PRVS: <VI1PR0302MB3215903D71F0F9E44C4617BFE77E0@VI1PR0302MB3215.eurprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(4114951738403);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:VI1PR0302MB3215;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0302MB3215;
X-Forefront-PRVS: 07025866F6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(396003)(346002)(39860400002)(366004)(376002)(39380400002)(199004)(189003)(2486003)(67846002)(110136005)(77096007)(50466002)(58126008)(7416002)(53936002)(23676004)(26005)(59450400001)(76176011)(52146003)(52116002)(55236004)(6246003)(316002)(16576012)(2906002)(36756003)(6486002)(186003)(16526019)(2870700001)(68736007)(106356001)(386003)(53546011)(64126003)(229853002)(105586002)(97736004)(3846002)(7736002)(6666003)(11346002)(80792005)(39060400002)(65806001)(65956001)(31686004)(66066001)(486006)(2616005)(8676002)(446003)(31696002)(476003)(956004)(86362001)(81166006)(6116002)(25786009)(5660300001)(478600001)(72206003)(47776003)(81156014)(305945005)(8936002)(65826007)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0302MB3215;H:[10.17.182.9];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: epam.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjAzMDJNQjMyMTU7MjM6dXpKZG5adHZndHNZcXRzaHFMOVNsMnJX?=
 =?utf-8?B?TGRsbTA0Z3NaYmEzYS85R3k2d0tqYWEzc3lycE1BQUlIS3J2VStRdTMyRnFO?=
 =?utf-8?B?UXZmSGpCUVBwQmxFVFVhaDV6dXhodWZFWmp3MEhJWkpTa0k0TStCT2p6Q3Rw?=
 =?utf-8?B?MFdlYTVBeHJ1TmNlSjdWZnU4UlpFOGVldVBuQjdJanJvMlRTL2xLQ1BzRVF2?=
 =?utf-8?B?a0lKbnFhdXJHYjZzeFJzMmpXV3VaVUgzYW5MVEIvcG9NRE1sbGdhdDhtMFJI?=
 =?utf-8?B?MURVTS9icGI5aTJtUkhYRmNpS2ZqeDk5MVhCUWZJV1YwUmZXZldoT21qSnFY?=
 =?utf-8?B?bnY0dmQwS0lJVG8wS2xWeFZ4RXNINVp3eWllbWdNSWpTaDBOemZySWFiWmE1?=
 =?utf-8?B?UDhub3IzbU5DaU5CR051TkgrSDkvZ2RMaDFObG5IeE94d2pjTnFGMnl5cjFJ?=
 =?utf-8?B?dmQxZExOZEN5UTV2QnRkRjhSVTlvUDZlNEhLYVoyRzhNbVFxQXYxOXVtR0tr?=
 =?utf-8?B?eGd3aktZVzNrTWNaQ2JJNmJDaGxyR01uMEVoWHhDZlZhZTg4cURjZVZOR2Mx?=
 =?utf-8?B?dzBSQUdFZlJDWlZRRE93V3UrUjMxUElkUHBjRUQwRkM4NXg5dnoxbENQRnli?=
 =?utf-8?B?OFZxbWdhVVhReE9ycGRWWGhibjdtLy9VZ3JZTVorUEpZYWVmQ0w5ZWhPSC9H?=
 =?utf-8?B?dEhzcTg0ckUrelEzWng5MFcwcHRBTkNXNFdNWkNubmF3TUY5aXVnOTR5WkRk?=
 =?utf-8?B?eWplTGc2M1NKdE1BUUl2Q3BqNTl4SCtUZVJRR2EwVFA2YU9GcVV1a3d4bENj?=
 =?utf-8?B?UXdTK0UxL2dCdklLMW85cXh6WjM1Y05IQmVsNm9hUlN4Y2xIWmNCRVhpRUZ5?=
 =?utf-8?B?UEZmWmdCVlFiWFpSTzNwUkxBMEdQSmxVUzJQS0lZUUdUQ3Yyd1BhbWp1ZVRS?=
 =?utf-8?B?UnFnWFhkUlRLK3lxVzhPN3JpSUdIK29uL0I4Q1VSakxoNFkvVkpPVFlPc2Fm?=
 =?utf-8?B?SllTODhRTW04SElBL1ZPVTVRaUpoN04xKzhrdU54WXAyWVhLa2FKOEJzUDR2?=
 =?utf-8?B?eFdmOTZienRxcjhVcnprOXFmTDM4U29MdC8yTllXTmY3TXZnUHA3MHdiU0xC?=
 =?utf-8?B?Q05LblYvL0d3dnlhYlk5dEcyck9ORnhRbGxPamhpM1lyY203d1kvcUZvYWJS?=
 =?utf-8?B?QnFKMXJPaGJtRTB5MnpCZmk0SzBrQlJYSmVleXZMRnY5UmJrTXl0bGswVGVk?=
 =?utf-8?B?WUhvYUtiM21VdDdzNjN6SlNodDMvN1M4RC9BMDEyMEorVUp6SGJGQmpSaFYy?=
 =?utf-8?B?S09UeW9OZFNvNWlRL1dRVjhPY1NFd3BNSGJtZGxCNVVKZlUycUtVZHlOTW91?=
 =?utf-8?B?c0dlME53eHJJdFdEcEZIMHNGQ0N2QVVaMTJWUFNha3ZoaDVIQ3doVVJJdWh4?=
 =?utf-8?B?Vk9tcVk4Q3diMFh4NVMxYlpqYzk4eWk1bXF0Wm1zZFNxVkFwTzhXQTJkZ3BP?=
 =?utf-8?B?Z2Q1RXNrVlN0ZUR2bDEydy9ML29DSkdtNHp2WUNBaS9FSGkyVDljanpsaGlE?=
 =?utf-8?B?b1pSVzNtWFBtWFRQU0l6VlM1V3BId0JlMGtJUWJaaUtzcnlnT1p4SjFBN3hR?=
 =?utf-8?B?em52TEg2cFRmamlLdkRndDVyZ1pObGFMNGk4bmlVUi9NRHJnVG9ZR0NzU1F5?=
 =?utf-8?B?WHl1dG9nV1J4Rmo4UXdXQlhzTHZDZXFXZWpHRE1SV1B3amZZSlZGSWs3bGh4?=
 =?utf-8?B?NHc1NktMUnQrTVQ4UTVSVW43MktsOUZoVnM1bnpMY1VqVWRpWU0vdmlwdFBp?=
 =?utf-8?B?eFpNVUgrTWhSL2VSL09PZThGYnplSEpBVitSWnZ5eElYbnVENjl6Y1h3OXlt?=
 =?utf-8?B?WnRqYUxMbGdrQUd2NURPZElZOU1YcTl4V0VVNGc2UTY0KzB6dUF1Tlo4bTln?=
 =?utf-8?B?cWYzRXZzSERtcnMwb2FtOVpuM3lGVE52aVJlSkJaemFhTFp2L2ZJN3dHbjUw?=
 =?utf-8?B?SHkzbFRlSUMzeXhHdVpYc1pubjhORjRTM1A2ZE92TCtoY1FLdnhrOVFhc3Ja?=
 =?utf-8?B?OEkrT1lCV2V4UTl5ZTNrcDcrQWM2VGVSTHNySDNmQUFUT0RCdnpwR1BDNklr?=
 =?utf-8?Q?KXMzqA59a7iBHIt3yGh2Bbng4=3D?=
X-Microsoft-Antispam-Message-Info: 3bIbQlgyzbgQyZU7ymf8TvbViVCoVkHHProdEdf6Mk0OdX9dGcCX5E4/7lAqTSAPuD2aMMh+yPDJLSjMDWF0dyMH4Kgn76OdxYaF/nFTcgxKWQaBOmxjEQwhT8eQL2cdub06TnZuGHZS9qdWc6eD0Q9WmXa48gJby0cMtw4KjOBY1oYdFGH/hqkFaK2RJKjm
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0302MB3215;6:z3kUxFecB61ZIzJgLEGUqvyC9vLGlmEfMKhPQBIzRryTLgVga5BAPWZmJ7s9UOX/yb11Vo0/Y9iTtP+CR6vBnyrScgRdvWre4Ro1oqeyKdBsWfhseWeNM7azuqTHSDFEKfa8hhELoSHr+EaLorc0Q4D81AoM/vTszvzX6dU67+F7DtVClIUakh1OGsC7X3AKtk6gqEVrCbUFOA9o37zHQAFa6Fn/RHZQ5e8BwrJlmuZ5d/ucv9i4p7e/Ju/0fph5n1+NbRl3J0Splc/QpGZ/XuSGHnKMl/6sDpLc8y3fgJw1NN3lIlOxL5tnI0XJO9ygmNuzis9K0Z0D5X8gjIBojA9dn5UbAIr3fOMFK8Qh33UNXexAQ6Jicia9H4lC72b5lwy5Zj2/1VuVjj5ImiPCAffWd5P57rgr/2wYbF68f10fCvohezzV2HPJNcqpHzH/FMtDeqn2U8Hn3KdqDJLFQg==;5:Q0oHv9Ji1diP8RR8VCvf7ESyzH/0sxiqxxK9ymbcfMTHWf6wLNV7Ii0F/zG73i9SFrWr4GcuvzbXV8igA3gFAcsMGuhroSSR5ESAHal7qLjkjcpVREndddb5LkNwwy0tX5MxproHJnofUgXiUUv9NkAEd7X9fNk6lxXRISuu1xQ=;24:in3YSM+ZuDZzaQyGzlqNzTZnDU9NenJsJzk+WITV/tS9Z5+dpmYaKRrXNMfzmo+iCXgavdaEUFkVOSDB/SG8OKSpCxW4tWsuiAa3GFDjVeA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0302MB3215;7:nNsRVwgARluyaVHP8jfFLgjJvSgCo/E90rk4BF153pV55k0EARd5Q6zpycWl32kMSnjMSs47bhSXNgKnaNO06XlL+ogEqhm/KJ57RxzVa7+l6YYLubF0aZSoB4dAFqgB6Ora2aedmJDHK7ZvtM6bGiqWiBRA5u38Plq0B0HtDMnW4AdQJZZ95cDDKJExhihHF0R3HktmH0HdGeRownBcJF9aCOhDbvVEIQxrLFUrT/uk+iUldKb5fvgXGiyro3Jd
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2018 06:26:26.1018 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d37cb88-85ba-495b-0c96-08d5d0f697c6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0302MB3215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/13/2018 03:47 AM, Boris Ostrovsky wrote:
>
>
> On 06/12/2018 09:41 AM, Oleksandr Andrushchenko wrote:
>> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>
>> diff --git a/include/xen/mem-reservation.h 
>> b/include/xen/mem-reservation.h
>> new file mode 100644
>> index 000000000000..e0939387278d
>> --- /dev/null
>> +++ b/include/xen/mem-reservation.h
>> @@ -0,0 +1,64 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +
>> +/*
>> + * Xen memory reservation utilities.
>> + *
>> + * Copyright (c) 2003, B Dragovic
>> + * Copyright (c) 2003-2004, M Williamson, K Fraser
>> + * Copyright (c) 2005 Dan M. Smith, IBM Corporation
>> + * Copyright (c) 2010 Daniel Kiper
>> + * Copyright (c) 2018 Oleksandr Andrushchenko, EPAM Systems Inc.
>> + */
>> +
>> +#ifndef _XENMEM_RESERVATION_H
>> +#define _XENMEM_RESERVATION_H
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/slab.h>
>> +
>> +#include <asm/xen/hypercall.h>
>> +#include <asm/tlb.h>
>> +
>> +#include <xen/interface/memory.h>
>> +#include <xen/page.h>
>
>
> I should have noticed this in the previous post but I suspect most of 
> these includes belong in the C file. For example, there is no reason 
> for hypercall.h here.
>
Yes, it seems that the header can only have
#include <xen/page.h>
Will move the rest into the .c file
> -boris
>
>
>> +
>> +static inline void xenmem_reservation_scrub_page(struct page *page)
>> +{
>> +#ifdef CONFIG_XEN_SCRUB_PAGES
>> +    clear_highpage(page);
>> +#endif
>> +}
>> +
>> +#ifdef CONFIG_XEN_HAVE_PVMMU
>> +void __xenmem_reservation_va_mapping_update(unsigned long count,
>> +                        struct page **pages,
>> +                        xen_pfn_t *frames);
>> +
>> +void __xenmem_reservation_va_mapping_reset(unsigned long count,
>> +                       struct page **pages);
>> +#endif
>> +
>> +static inline void xenmem_reservation_va_mapping_update(unsigned 
>> long count,
>> +                            struct page **pages,
>> +                            xen_pfn_t *frames)
>> +{
>> +#ifdef CONFIG_XEN_HAVE_PVMMU
>> +    if (!xen_feature(XENFEAT_auto_translated_physmap))
>> +        __xenmem_reservation_va_mapping_update(count, pages, frames);
>> +#endif
>> +}
>> +
>> +static inline void xenmem_reservation_va_mapping_reset(unsigned long 
>> count,
>> +                               struct page **pages)
>> +{
>> +#ifdef CONFIG_XEN_HAVE_PVMMU
>> +    if (!xen_feature(XENFEAT_auto_translated_physmap))
>> +        __xenmem_reservation_va_mapping_reset(count, pages);
>> +#endif
>> +}
>> +
>> +int xenmem_reservation_increase(int count, xen_pfn_t *frames);
>> +
>> +int xenmem_reservation_decrease(int count, xen_pfn_t *frames);
>> +
>> +#endif
>>

