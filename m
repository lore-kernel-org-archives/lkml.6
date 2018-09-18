Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 231F2ECE561
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 05:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9644521473
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 05:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kFn4WLyz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9644521473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbeIRK6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 06:58:19 -0400
Received: from mail-sn1nam01on0087.outbound.protection.outlook.com ([104.47.32.87]:44064
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726433AbeIRK6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 06:58:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JoCDdnUkD7o5IrNl3TI40egmg9e0KqbSrhA98FhS5cM=;
 b=kFn4WLyzVuV7ex7wCt7ckeMO1U5BKboKpLiUuTQigogpRZfrT23JlXY3/A5Y6SVjeoVB+Wir81kVjqqO0lL20k6e/ptJWnDXnk8n/QSdjBsIESxahLc2QUfLBptWq1KsQq/A8biu9SkWQ0zUZfKiygaMhDkmSn5r3lDfhxxWTwY=
Received: from SN1PR12CA0066.namprd12.prod.outlook.com (2603:10b6:802:20::37)
 by BY1PR12MB0422.namprd12.prod.outlook.com (2a01:111:e400:51b2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.18; Tue, 18 Sep
 2018 05:27:20 +0000
Received: from CO1NAM03FT044.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::209) by SN1PR12CA0066.outlook.office365.com
 (2603:10b6:802:20::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1143.18 via Frontend
 Transport; Tue, 18 Sep 2018 05:27:19 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXCHOV02.amd.com (165.204.84.17) by
 CO1NAM03FT044.mail.protection.outlook.com (10.152.81.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1164.13 via Frontend Transport; Tue, 18 Sep 2018 05:27:19 +0000
Received: from [10.237.40.91] (10.34.1.3) by SATLEXCHOV02.amd.com
 (10.181.40.72) with Microsoft SMTP Server (TLS) id 14.3.389.1; Tue, 18 Sep
 2018 00:27:18 -0500
Subject: Re: [PATCH] list: introduce list_bulk_move_tail helper
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <amd-gfx@lists.freedesktop.org>
References: <20180917120834.13993-1-christian.koenig@amd.com>
From:   "Zhang, Jerry(Junwei)" <Jerry.Zhang@amd.com>
Message-ID: <3d3d1448-fac0-947c-0381-09f7f8ac9bd6@amd.com>
Date:   Tue, 18 Sep 2018 13:27:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180917120834.13993-1-christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.34.1.3]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(376002)(136003)(2980300002)(428003)(189003)(199004)(53936002)(16576012)(126002)(6116002)(3846002)(2616005)(47776003)(81166006)(58126008)(426003)(72206003)(8676002)(316002)(81156014)(356003)(446003)(2201001)(31696002)(104016004)(110136005)(7736002)(86362001)(486006)(68736007)(11346002)(53546011)(8936002)(305945005)(476003)(67846002)(478600001)(64126003)(2870700001)(186003)(26005)(106466001)(2906002)(65806001)(50466002)(105586002)(77096007)(5660300001)(336012)(6666003)(39060400002)(36756003)(97736004)(31686004)(23676004)(2486003)(16526019)(6246003)(65956001)(76176011)(65826007)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:BY1PR12MB0422;H:SATLEXCHOV02.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM03FT044;1:NTyj8WYdM5NZn64/n8BVYj73tfsj1DMgW9MFvSBOB436+0QzkveopXVLQvdfUiCu4FMKmc497hg71yfF2zbTE8Tj7MPTC4bQf+ixy3DdaXA36Q+GlrQy+n10Iy0Q0LcJ
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 819cf727-794a-43ba-e61f-08d61d27677f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY1PR12MB0422;
X-Microsoft-Exchange-Diagnostics: 1;BY1PR12MB0422;3:5k2Xy6ZvryDF/rH8boaCrdm05aFAGQDFAngshNRQUv8LhMHXsI64GSf0F5VyBhdwk8Ncfry9XH8FPi/6bRD0UJrW28yCD9rbplWxGb/No8P4ccTF2jR1k0ANa1Bfu4R1NYZyY2Bx7N76ASJG8eXm/YLYivzATxMAS0/6rp1lN+LxmQCG/GWDuQ+B+Vcjn+VDu23nAHKNfqUk0iiCTXXaSG2j8Qo/klpwQz2q5bxf0FvsLXZQHjzrjiwgWWagRJv7yflZbwAV4YtBw0TAsGI9ldbpcGO6o4BcLXRrT5DTc9EJifREOPP1AsgM28qNdCmUAqp25Y+mmdb7Hx4MZKUD6NTDaZe+TgciZePeHS31oJ4=;25:wkTm8bVEuavqlspec7vnoi8TwrcUWPgilaOuMjTqXVzgqd8C/h6MG1pwYmRRRc44t4nHtowT6afi6Vsxumf4mu9dz1a32vvnz1eLQa1n4DlAFHBMFTWu4PrsDEHbU51uPkQzZYB+XrvsCP5uE4SROL4WEWNZXgZ4fFbtm0yORvmwM2+GMokUg5JX1WDoWjWLEo1bF3CgI3zhpdSqPsQ+B8ivW1ufTdCl2ytsG8Z6ulY/nmskWS3p8l94OXQBXmbd1HHtG+PKtBkgDgqYUDFjlgNnh2IT4+0tI06JjhZx6QN2oxPx0iIqL5QzgLtajL8mrF0zPWj4eRg1Qwt+YiBR5g==
X-MS-TrafficTypeDiagnostic: BY1PR12MB0422:
X-Microsoft-Exchange-Diagnostics: 1;BY1PR12MB0422;31:kZd41L4wNL/OdsM/VGUtvosC/BJDMVvp1HHU7Lg2FRs/7kVHtLpFLG0S//4ZXRl9zw+0KJFME/IhOWoXSHwwamSp7YZpr17sUTfInsvDdGBh1EGMrR5JL9PiM59PaPBqVtqPnoXo3xrOihb06ejB3wGuxyvnSG3CjXF3+dCZzr8C8vA7tCeOrPqtWA0lx4Wgmo/On31Myq9gvCm7nVeMwQjyTlFEzukyzbZKpzI3cVc=;20:phsuPzU7hfBzzF8VpF1AI5Kn0AcTehZGNUSOi755X0hvg4IaenWI1bN9HLS3npLXt02wC4RhwQNHVWqUPJP++uMdNXiv0DIcHOTNWMgiHOaILKVuIkkSYX8rbGHIdtxlwILYNsCYwRNL9mUvwrt6Zq+DjJNfmjIkwBVzOUsjZbbm53nwMTr8HNLzd/NN0UT9Hg7bfIj3Zrm3/kyIpYrTdJHKYnFC/77g9hKwPB4VQVrXsPoz/+XOGjEW047AWEZcJK/+UGD8em7mU0+Qyv/HdWVzzJIW0n9UAswWHwlvRmgCc0BeS5lHfFSFpdeSLFf2d0AfMr4/ODP+8ygLNKwz5vaCvH65Q0CT8WrD3+Hh0HotQY43Y/FVs3JfWiz3bCAZKboqekyZXY2IAdpV/CeD2+Zu2HHeGI+jPo4c1y4Smz4P070H7MHQPxg7cycpNjM6Iu5SPY/GhM+UDxZFtAbjsaAGNJAnWfr9Ms8TnI2dZABY7yGwnrriK7I5fABE2fiR
X-Microsoft-Antispam-PRVS: <BY1PR12MB042260D86389DFD3908EF00EFF1D0@BY1PR12MB0422.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(93006095)(93003095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050);SRVR:BY1PR12MB0422;BCL:0;PCL:0;RULEID:;SRVR:BY1PR12MB0422;
X-Microsoft-Exchange-Diagnostics: 1;BY1PR12MB0422;4:82lpR6cA2cPr2uvj14quWvZRWj3DBLHxmGJAQxwZ6MoU4XZAzZRhNIVbGVg0Nk7CcslxXyIjSBT7nbDYQBXm7gEoTKAZlPjsgxHnmIJntjT7r0VCc7VYTDLB83XVWu4EkS2POb86HWPUM+aswwHAQmln1GVOhvN64nm0UH4OJhF0FlAPMyM4lGR78HIGYqfTWvHmudXM5/5BtPcqVka23FnNOvw84BnvZOtIp+0d9WBgkuGqka/SPp1b10NpqtFgcqLmWbIu6Q7hMeV/mC4aAr69cdjt9eZCpD1EkhNtwW8mKpU2j/SDlacbFmKIlTij
X-Forefront-PRVS: 0799B1B2D7
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWTFQUjEyTUIwNDIyOzIzOnA5MGlEVFgvUUhtMFZIWFpueFRjU1ZEUVlT?=
 =?utf-8?B?Q3YyN3ptUzFVU3lZNy9OQi93akp0akRYQVMrZE9pbGsxNkU2V0dMTmg2Rnhv?=
 =?utf-8?B?WDBuYWdYRTJYYlI3YkxNaklYcEt4ak9GcldQbzUvYmZ6VEpacEtSeGtQTjhU?=
 =?utf-8?B?ZlRnbmE3T01GL3ltM1VKejNKOVFlb3ZmOStVNno2Qnoxdm45U0xMOGVJeXJs?=
 =?utf-8?B?clBHVnlvMnNJZlpDNU8zdFJoeGEwTUJ3Q1FyQjJRWlJaWm5Uc1F6ZDc2V2Rq?=
 =?utf-8?B?aCtWM1E0RlJEaWY1TFJ3SGVrOE8wZi9mRHEyUWVPVC9FK0luck0xcERlOUFF?=
 =?utf-8?B?MGxTVjJ0dDZpbFNPWHRaaTlOZXJYeC9COGVXZk5EelJMa25YTVd4akRzandy?=
 =?utf-8?B?OXo4b3Vjb2hHUW1VODIrOEcwUWQyblZMb0sxbnFta1ZScGhPVW1hYVkvVUxB?=
 =?utf-8?B?SktqeXh1ZDg5MDYwUWYwWVVFQ3ZCU2FXZ3VNV1VSQUtNV0RYVEI2dFk5ZXhi?=
 =?utf-8?B?SnAvTnllRTdEM2hLZGJFNTBRVWIyNWJQWUR3aXBUV3lUVlN5SE9CT253Nm02?=
 =?utf-8?B?U04wdzVnNU44bCtYcVJJanNpUkcrdEN0Rm5Ua2lISGpZUStlSXl2RnNVcEZx?=
 =?utf-8?B?cmFBRk01cjNXa1ZURlZOVW4rb1JlbkpIQU5QeE5GaXpPd1V3L0lNM1ZFa0s2?=
 =?utf-8?B?Zzh6VWo1WHd4R0lObElhRGZBTG55cWE5QjlQK1pHOW5ibHBvenhveXdpQ0oz?=
 =?utf-8?B?b0xsRlZmUkNQVzZYNUxVajZzMDNBNzU5Rnh0QWJ1Tm9uRGhLQkg5aFFHMjNj?=
 =?utf-8?B?bzlIWkUyQ3gwTldOWDhtRVVNSzBEV3Awbk5QbGpSaS9wbFRZK2w2NnBhdTBt?=
 =?utf-8?B?SE9TS2hHYUpaalM0dlpudkNQcWs4d1dhRXE3aTlSTzhkenZyazNNSlpqdEdu?=
 =?utf-8?B?SHpmUXZtSlp3czdET0pQc0Z2VGQyWlo4STZLUUg5NlBPVGlFT0JVbXprWWVD?=
 =?utf-8?B?MzdEOGd4R29aQ01ZU3J0UlQvSHQreXE1OGNPeTVwMUFVZ2VidUZ5K2hKZ3V2?=
 =?utf-8?B?eG9RTWU3VTJ4bk9oOU1YWVovTnBKMVVlaG5wYWd6a2JnTnNkQWpWTFlJOXNQ?=
 =?utf-8?B?eWk0RXE4WUFna2pML2VhQ2VOZGgvaVdSY3FvQzloZjVCSUY1WVdTL1VGTWZB?=
 =?utf-8?B?ZTZuMGtjNnB1TWFjdDcwQkJqaFMycjJrUE5TLzVPQWt3bnVnSEZtVWdxRU1s?=
 =?utf-8?B?Q1d4WWFjQU9BSDhCajF6Nk1DbUhLQUc0blZ3V3lWOU1xV0lIdnhhK0FvemNr?=
 =?utf-8?B?SEljcTluV0VnaVZLM1JZVlU2WmhzemFtM0NGWi9SVVNPN0U4UFE4Y3FYcDRC?=
 =?utf-8?B?Z05OTjdyWlNNVENiSVI1Qkc0OTFuV1dWWlV6SENSQ2gvVnlSaGNkdGVPYjg4?=
 =?utf-8?B?Y2FKNEZuRVd2VDYrdDNtQ1dYMWMrTTdlRXBoZ2VQcGtxMEtJdjFuek01eU5v?=
 =?utf-8?B?OXFueUk1UWk4VitPOHBCYmdkVytibEZXVW5CekdyUENvU3ZFWk5TYmNoa1N0?=
 =?utf-8?B?UXFnYVJQenRUM1QrS1NVeDVPR3pFN3A2Z0FFSWg3VGpJUERTWWp0dk1xcHk1?=
 =?utf-8?B?QkZlOGxZV3ZwdThYeUpjM2hCSGVyc0p0eFZTcVNGdkd3aG9ROEZjK1VveWFu?=
 =?utf-8?B?bWNGaVZ0ek9WbjJ0ZUQzZWY4TEtTTkJINElWcHRiWFRuY2cxeUFNNlplM0N6?=
 =?utf-8?B?UnpWbnNZakltU1huK05IR3dNU01JeHFDd3k1azNMU09LbzE1TG83T2N0b1V1?=
 =?utf-8?B?L3pMYXNNUmR4U3BqcklIK0NMVEpIYk50Q21wNHcvbXRlUzZkT05KekxIUis4?=
 =?utf-8?B?R1BHT1lreEFEZHFPR21kTWx3MCtYN2NtcDE3bC9TOWdvZ2JUSGU3ZXNMY3cx?=
 =?utf-8?B?ekFxRnBuazBnPT0=?=
X-Microsoft-Antispam-Message-Info: W4UbyQdbmeU8v9CfdGeY8l9PzL+XAtdzDowuzeTOO2vAlyn5nNDjDaExz691aXSN+eSXsXthsYDq1wtef2iOfNqEbjVa13Na53ik33rZNf0bZKQH47xnCprpEV85opbKkptkUt4Y0yDRxFtoR2DX8Jk36iS7FJxqYMm1f/ewU3hB+kRpVcQtZW7kIwBYjfoTeimJ4R/P1ZK+ryT/XLvYLCm0ZEVA1PVwmZF6fvd/OYGYbMvuvKP6UpV1Wboxuac0EP5gjKPsRbyY3wpkyOaIzQS3YhElkniwOqglBnuHN7F45vKFo8cHvnfJn0rdRgIbVin28I6y7bZDfLPnUO2BWesG0yitXhAiCTCJs0rpLiA=
X-Microsoft-Exchange-Diagnostics: 1;BY1PR12MB0422;6:7ys8cpqdCcXDjjbu0A/VB/+h823tnwDq1m5FjuuOoZpfqzt2nEl1L9bYktdLLYofnD9fL6uKBFkJpE4Cy/BvP6WNqDqKV0T+k33xWJlz16YWb2RvgQOHXlkzNyywEIMnpzvcFyiFQaQk7UrPs6lrCjUFAKA1FY9vb/hWZJTAgs3kPxYbzAFZBRKE94TNY/vWeL1rDMeCqhj8GvZxNB25ceKTDPQCwP2Guh+hRFSZhsOXn6xQB6L/TN7IkSyAqEspUaQp6onAPqylh900wgQ+fFmfBrVIcJVudYQKQoAMcu8Bp0FcGa2w/Vm0bn5FwevpymluiQq1LCarCQA9SsMHpMJ5rDDUduSBVIQemnTmIS1oEy8K6dmmOquTNsS9n2zkLlgz142sXhzMoLWGnJ4T+oJDclgu8dU4cIEktCFa99eIrZ/zorUIUQkFzLzoMdgdt1BafGMthbi/bAbEhIAc7A==;5:xiwwfQqWE0tAWxBOq/sRlMs/3uUasjd8lWKy+u2RKH5YHqEPBpOPc7FDrsa/tVZo/1o4dj4p90EwOA25Rg1fYwrMAdyLcMCJ1b01P0ubkRpTMe7ELxPNpC7KUf4nFrS9gSQfeOeHaGwlZnuaYzeu8phQn1bnG9VuQfpmL8ptxxE=;7:mX+tRQ1hJ6mLPuELQu2ILJwvvnlaTqF7ggFl4D/XzLA53pEO/Wxv8V8XBnY++/TFrw2P0Oy4V1MyzK56OPQP1bd9WiwjxChKAkWXncVUXuCzIqOqkpVlOYdQxoK2GPn8Lta01TodGI6mUR29BZILFIegj2oLQbJvIzOKbmkF1gelt1uOy4WNYzBikFd0i7QGwme93Tv6g+Q+ATL/bWGPvEXTjuXzGvT/BalnTGYW78hOaowREMXm/l+O55Dit4Jp
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY1PR12MB0422;20:5/ldJC7Jl2Y5doW5UAlq2fYX1tMNvFijibL999XFGGyPjeJLIqHyRV67w/YC8WmzhjffEENFffMUOev+o1vQ2CYj9+42WFaKesIeH8d12lJduLIVtQXOEk3muJEA7XhJvalSmUeOQ2yaVC8UO58OScLuzP1u2vXGXuUpLuZbqwJLPdXfOl0Rhn0dSoNN0Am+d69WcFOd5mwS+t0wPIMHZy17vmF5i5RS4eVL+ojihSDB8MwesFcdfoJtKmABFirK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2018 05:27:19.4681
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 819cf727-794a-43ba-e61f-08d61d27677f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB0422
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/17/2018 08:08 PM, Christian König wrote:
> Move all entries between @first and including @last before @head.
>
> This is useful for LRU lists where a whole block of entries should be
> moved to the end of the list.
>
> Used as a band aid in TTM, but better placed in the common list headers.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Junwei Zhang <Jerry.Zhang@amd.com>
> ---
>   drivers/gpu/drm/ttm/ttm_bo.c | 25 +++++--------------------
>   include/linux/list.h         | 23 +++++++++++++++++++++++
>   2 files changed, 28 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> index b2a33bf1ef10..26b889f86670 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> @@ -247,20 +247,6 @@ void ttm_bo_move_to_lru_tail(struct ttm_buffer_object *bo,
>   }
>   EXPORT_SYMBOL(ttm_bo_move_to_lru_tail);
>   
> -static void ttm_list_move_bulk_tail(struct list_head *list,
> -				    struct list_head *first,
> -				    struct list_head *last)
> -{
> -	first->prev->next = last->next;
> -	last->next->prev = first->prev;
> -
> -	list->prev->next = first;
> -	first->prev = list->prev;
> -
> -	last->next = list;
> -	list->prev = last;
> -}
> -
>   void ttm_bo_bulk_move_lru_tail(struct ttm_lru_bulk_move *bulk)
>   {
>   	unsigned i;
> @@ -276,8 +262,8 @@ void ttm_bo_bulk_move_lru_tail(struct ttm_lru_bulk_move *bulk)
>   		reservation_object_assert_held(pos->last->resv);
>   
>   		man = &pos->first->bdev->man[TTM_PL_TT];
> -		ttm_list_move_bulk_tail(&man->lru[i], &pos->first->lru,
> -					&pos->last->lru);
> +		list_bulk_move_tail(&man->lru[i], &pos->first->lru,
> +				    &pos->last->lru);
>   	}
>   
>   	for (i = 0; i < TTM_MAX_BO_PRIORITY; ++i) {
> @@ -291,8 +277,8 @@ void ttm_bo_bulk_move_lru_tail(struct ttm_lru_bulk_move *bulk)
>   		reservation_object_assert_held(pos->last->resv);
>   
>   		man = &pos->first->bdev->man[TTM_PL_VRAM];
> -		ttm_list_move_bulk_tail(&man->lru[i], &pos->first->lru,
> -					&pos->last->lru);
> +		list_bulk_move_tail(&man->lru[i], &pos->first->lru,
> +				    &pos->last->lru);
>   	}
>   
>   	for (i = 0; i < TTM_MAX_BO_PRIORITY; ++i) {
> @@ -306,8 +292,7 @@ void ttm_bo_bulk_move_lru_tail(struct ttm_lru_bulk_move *bulk)
>   		reservation_object_assert_held(pos->last->resv);
>   
>   		lru = &pos->first->bdev->glob->swap_lru[i];
> -		ttm_list_move_bulk_tail(lru, &pos->first->swap,
> -					&pos->last->swap);
> +		list_bulk_move_tail(lru, &pos->first->swap, &pos->last->swap);
>   	}
>   }
>   EXPORT_SYMBOL(ttm_bo_bulk_move_lru_tail);
> diff --git a/include/linux/list.h b/include/linux/list.h
> index de04cc5ed536..edb7628e46ed 100644
> --- a/include/linux/list.h
> +++ b/include/linux/list.h
> @@ -183,6 +183,29 @@ static inline void list_move_tail(struct list_head *list,
>   	list_add_tail(list, head);
>   }
>   
> +/**
> + * list_bulk_move_tail - move a subsection of a list to its tail
> + * @head: the head that will follow our entry
> + * @first: first entry to move
> + * @last: last entry to move, can be the same as first
> + *
> + * Move all entries between @first and including @last before @head.
> + * All three entries must belong to the same linked list.
> + */
> +static inline void list_bulk_move_tail(struct list_head *head,
> +				       struct list_head *first,
> +				       struct list_head *last)
> +{
> +	first->prev->next = last->next;
> +	last->next->prev = first->prev;
> +
> +	head->prev->next = first;
> +	first->prev = head->prev;
> +
> +	last->next = head;
> +	head->prev = last;
> +}
> +
>   /**
>    * list_is_last - tests whether @list is the last entry in list @head
>    * @list: the entry to test

