Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8149BC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AF9820834
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="BDmz3dQe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AF9820834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934385AbeGCRcl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 13:32:41 -0400
Received: from mail-eopbgr80124.outbound.protection.outlook.com ([40.107.8.124]:57836
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934331AbeGCRcg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 13:32:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dluf6oCQ9eUt5tMLvrbqOOYw8TFNa9MWVMZSt7f7piQ=;
 b=BDmz3dQeLqRRVnLQzsVDmYUAqncrCuEIhSskNhVL/VQa6uQBa/4bk0rBwFpLTd4TEMBZjn+f+AU2tLTp3XjnmB0rbe/cJMa2+epiVf551zwovf/qTC6aIMmunOhcpO+St5FPorxW566sjLRxsLHVuMsjjW3W7W9JgTQ/Xo8XKXc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from [172.16.25.5] (185.231.240.5) by
 DB6PR0801MB1335.eurprd08.prod.outlook.com (2603:10a6:4:b::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.24; Tue, 3 Jul 2018 17:32:29 +0000
Subject: Re: [PATCH v8 03/17] mm: Assign id to every memcg-aware shrinker
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        stummala@codeaurora.org, gregkh@linuxfoundation.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Roman Gushchin <guro@fb.com>, mka@chromium.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Chris Wilson <chris@chris-wilson.co.uk>, longman@redhat.com,
        Minchan Kim <minchan@kernel.org>,
        Huang Ying <ying.huang@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>, jbacik@fb.com,
        Guenter Roeck <linux@roeck-us.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, lirongqing@baidu.com,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>
References: <153063036670.1818.16010062622751502.stgit@localhost.localdomain>
 <153063054586.1818.6041047871606697364.stgit@localhost.localdomain>
 <20180703152723.GB21590@bombadil.infradead.org>
 <CALvZod7xAP9AjRWp2XX1uJBkuOprYKCf7hzAXNTdw89dc-n4OA@mail.gmail.com>
 <a9fe3e9e-a1b7-ee19-35e6-af32b5f25a37@virtuozzo.com>
 <CALvZod6eomn1Mt5r28tMthq4b+3MWuWJKgishf_N4UjortzvHw@mail.gmail.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <ed6a04cb-6164-bfab-f2ff-8813068e2e95@virtuozzo.com>
Date:   Tue, 3 Jul 2018 20:32:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CALvZod6eomn1Mt5r28tMthq4b+3MWuWJKgishf_N4UjortzvHw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: AM5PR0602CA0005.eurprd06.prod.outlook.com
 (2603:10a6:203:a3::15) To DB6PR0801MB1335.eurprd08.prod.outlook.com
 (2603:10a6:4:b::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7616e128-6e89-4c5d-be25-08d5e10af48c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1335;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1335;3:G0/zu5y2rt0fj3SmnNAlQIoy9IpR7XugT4an8cFhNJLZbtNqNeEUM5DnIjJV/R+JZt0QTY9l0hl+v01g47vgv5Y+BzUZhmrn7Xq8TbMrOt1cOhgnRJOlbgE+7kprqDvtyB4Lcz7IkB/aTFcy4jq+LzU1y0HKgbHuvsqpGpBB4zWuY5jWtPYc2uhxXSCwLwmmg6SA+EIicFmP4ER31LZRokvQpyOWGhzgBOg2gfddV3WPH4w0j6ftqwmZVElnjUWt;25:sAccO1jR1DtiVr0zMGpKRaVL+xK2lfdionjNrMq0eSOgrwl0TaZfK5+LKsvrO5oDRH3BKn4Es2w4Z8AMC8DzfCjY0DLkpb6hSciYYytrxT98JP9wSHBxRmLfWZilZQ2f3rFKfz7kElRhOQgc3pcy9S/DUkck/GRBRwpLkOSgSLlB5O3I7njlGzcWAqm6ufYwj+Sy8Z6xnymozrR1pAFFGObs9mc5x5zdozPEmbWdefHwcCxSn9zOjIbSZy5HoKIPG/F787ECnzFsbvrnEgnzbcYKfniO2dJJ6oMKkGs0GqVbmQJ4+opSasINlCRAC6gN2XhktyiVotqWLH5s3uCmEQ==;31:iCY70yafVmNPmyUDOr+dH+lA2OgljN17RFtrHn3Fr8Tf0ymtEIJSmAacbYgdEyPHodq0n8/8YWHgWJDYN365aT69nt8g5cCsvl+s22Tu5Nj3NnCDt1w6dQOuWayi5orZOLYdWCt6ipzvndLuiM9g0MXEPCn09z7H5ILvbH5V18y+JpyKutZtDFgeMSevluzqsrRvgLlfZKA+WLhjprl+z24YjD4E+nhBSDWPxTb4zQw=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1335:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1335;20:T3hM3dJdR+w4Tsx2guqWLWJL1S65OlljD+Eo9mpnfttltoHDhrxa9cM0RiFrzfaeuGgZNnu+j+0OxCgI0PzPLgYeeCc8LWqpzeknWoCLmuW4+xKKuBSIlz/YTrHVVmG6KTTPomnhCLML5rYS/yo0doKhX1Kf6b02VaTv9yrNwNtyZvGFjtjLVDesFzasvi2iEdclweiakvaonJXt2zNSfxNxQgxHv5T2CQGOeEs+aQ9kFlXzaXLOlxwwkK5V5DbAvX9c/N4wBGZ4NDxHFA1uqonsldXMFlSoOWaQ9R+miWF9UUdQcD0Zh//BT6VSvjk4zpJ7Z33fjwmF+/ZM7PL8a24XChr4tYWdJSRJDI34LrZr6NADWceyoBC5//UBrgIBPQpmRUXiuofMFgaANpqDDsLvcx6xma9dNNxMvwRNR1+eSt3RxWcwrGyDt6HHwuIRzDoepKwiKMGz2gsHOx0TSbIpRPKr0hmPf6BXyj+vFP+VfnZ+sYP4slVFiL+Uv8bI;4:t5X3kN2ndYkOHaSAS0l0ArQpkSWhQKsG546mZuXwfQ+1LyRZytIAmxGytJbCmHFDua/pE6GNgyFyEKj2cdLQZZx9ctGyD4CCIxB3Bw53MLQjWEzPIX1JJdHus7b9azJ/9yAoSO7HtfyI26FnBFHLOhZKq78mO3iYZ4892EF5/IJnDBPRhoIIy1bBU8Onxufshdnoqm5duC8bMJH6hXnUIGDft/hEeF/ffCGXJQTQDSW4PkrXRhfsDuDHCVbFabIM6Fm+nszaxH2nLWsOq7BzpGIJ7+phwXIVPKjzqU0Na2NNuJuzR15Wrhcfx0BUEgPN
X-Microsoft-Antispam-PRVS: <DB6PR0801MB13356DF08FA21860CE731CD5CD420@DB6PR0801MB1335.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DB6PR0801MB1335;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB1335;
X-Forefront-PRVS: 0722981D2A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(376002)(346002)(396003)(39850400004)(136003)(366004)(189003)(199004)(51914003)(25786009)(2486003)(66066001)(86362001)(39060400002)(6246003)(65956001)(4326008)(81166006)(81156014)(5660300001)(68736007)(446003)(7416002)(31686004)(65826007)(97736004)(8936002)(6486002)(47776003)(50466002)(14444005)(486006)(476003)(2616005)(305945005)(956004)(6306002)(31696002)(65806001)(229853002)(93886005)(36756003)(54906003)(230700001)(58126008)(186003)(3846002)(8676002)(966005)(16576012)(53936002)(316002)(6116002)(16526019)(2906002)(105586002)(23676004)(52146003)(26005)(6916009)(6666003)(77096007)(53546011)(11346002)(7736002)(386003)(64126003)(52116002)(106356001)(478600001)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0801MB1335;H:[172.16.25.5];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA4MDFNQjEzMzU7MjM6WmRXVnZRK0V2cW9hRE45N1M1MC9HQTVH?=
 =?utf-8?B?QXBPbjNMMW5VckJxamVNTjZGWS9wOHQ1R25DZU9FOTNSL0MzRnYzTlZpeGRN?=
 =?utf-8?B?YTEySzdUWkVZNXA2ZUFMQys3ck1HT0J2UUV3TktPcmQ5dWZkNzJQWHlKWS9o?=
 =?utf-8?B?cmYwQkk3OUFGeHhlcjNwVWhLUFFGNnR6NExHV2JHaUlSZm1xVnhKNVNDMENm?=
 =?utf-8?B?ZTU1TDJ1MzZFUzJmUVNFbFBTVkt2QzZienJjMkFmWWlNek5VV2VjblFtTDFv?=
 =?utf-8?B?alB2N3Q1aTVMUm9rU0xVaENCdGNOd1A1dWNrRnppeTFEVG43SUNicE1kNmdO?=
 =?utf-8?B?MzNDcWJuTjJ2SnRPRDZpOXdVeWJFTzErOW5yRk43V3QxN0ZDeFBlUGFMVi9L?=
 =?utf-8?B?MVZJT3NnVlRGUlVjZWZGRjI3Z0dpcWhnZDkycE01REZHWnhiRjBlVHQ4L0lk?=
 =?utf-8?B?YWNnLytEZWpKOEN4VnZlRFZjemE2R3d0RnBhcFRDMWhaOFpzMWJjTFM5ckRm?=
 =?utf-8?B?UFozeXVpMDJVS0Qvc1lib08rTXFJaHVSNm9WZ2w3LzhCTEtDWHNxZFdxUGFM?=
 =?utf-8?B?VFNhRVVRbkJVclB3UmNYR1g1elFQMEZPdHMxem1SbTZDaW1XVDZHQlE4QmpM?=
 =?utf-8?B?a05KM3hvWldzMWJpMWlDdS9IUnNBcEtYdHZ4U3p2VXhTa0MxUmJEN3EvS0wz?=
 =?utf-8?B?b3R1NE5EYktKYUhndFhwZnpvVzR2a2tmSjFHRDRkU0Erem5MeEJ2clRkL3lR?=
 =?utf-8?B?SEVyZnBTdU9DbVFJeDZwTTlpd3gwZWt3QVNSYnk1ZVEzQ0Nqd2ZEYlFpc0Jp?=
 =?utf-8?B?Yjh6TUpxOHdnY09CdTRKQUhhUC8wWFh2Z2RmVDVxYks0SVY1NmQ5YWU2eUZp?=
 =?utf-8?B?V1hsZ00rZjVvNlBRVmNXN0FCZEF3bzV5VENrU2FsRW9wa1N1SGI3VFpKN20x?=
 =?utf-8?B?Uy9ZdS9lQ2JKUjFBVWpYLzJTMHRvQ29pamRJQXlFdHBnZ1VDOXdhT1Y2Vnl5?=
 =?utf-8?B?WFZlTndBNHd6R1B4WCtsQkQyRjBhZnkxWGhVOUZHamJvMzc5RU9pUSs4MDI2?=
 =?utf-8?B?WGJvVmZWa00wbjh6OG02eWl5a2U4NFlrdGh5bUVUeFc0dEF4MnJOOTRnSGdC?=
 =?utf-8?B?T3k3QjZNRy9BK0syY2s5YmE4ZVlZcjBoYnFCWVV6czVOeHdjUnRJK01ta0ps?=
 =?utf-8?B?K0p1NTlLdzBlYS9JcHFDTE1IWjZsWjVhWXNMU0tKdHM4bU4wSWJEZjlmcWht?=
 =?utf-8?B?Q0RFZEdjY0hyY1F1YllZeE9TNU9WK3BWL1VPMzEyTWlKcENhcWxzODIway8x?=
 =?utf-8?B?Nm1EY1Z4WlpWV0FWeVl6MXJMNmNEeFJJbTRvUndOVnF5YlJLT29tV1ppZlF4?=
 =?utf-8?B?MDA1ODljVWIyeHVVa3g1OHNDYVpIdisxQlA0SlJzYXBXK3JYemhHWkNUc0Yy?=
 =?utf-8?B?Z2IxQmtUT2tzcDhMbVdZNUppa1hzQkFLTXl6V2ZOL1NLRHR1Z2d3U05QWFBO?=
 =?utf-8?B?T1dOUDlQKzhYWmpMZzlJNXltYWl3OWJTVHpjUzhzVVVHRDhqUFJ0TGd4WkN2?=
 =?utf-8?B?R2w4YWFtVU5ydDB2UUFHc2JxRDN1UkZvenRqay9uRzFLZHg5c25vaTY5NzNF?=
 =?utf-8?B?dEJwaHcyYjdlM3c4VUhDQTJkcFVhSFExK2dadk1FVWdFVm83UVhtTWlIQ2F6?=
 =?utf-8?B?bmlvZmY3Z3ZoYWhBSGhBaUEwN242UE54M2I5azRWWDFiQUU4bG9ka0c2TVBG?=
 =?utf-8?B?N25BUFpqVjJvRDBWK3ZmeGliOVBGT01zZFV3aTR3ZGg2aHNCMFdPUWpveC9R?=
 =?utf-8?B?bVdTeFZaRDJPVmxUWTU4TkdQc1BaU0F4YS9JY2UyaFdCV3Yxd2RxZ2NkUmxO?=
 =?utf-8?B?c2xPVU41Nnl1U0EwRWdTNk14YjBhN1VjSTBBaHFMM2kxS2wxWG1mVUhUTThB?=
 =?utf-8?B?cEJpeTVrMVN3NHo3OVUwRXRzVmtsd0FzT09QKzBzeXdZN25CKzZWekhZTVdG?=
 =?utf-8?B?d3F6UkFCOGd5MC9LNW4xY1IrdDlSU1hrTmdURGJQczZ5Y1BSbFQrV1J5ZWdM?=
 =?utf-8?B?SnRVZXljS28xWGJIVGpZaDBCTlJKT01yZVVRcE9mZjVhS0ZYN3owMUVxVlRI?=
 =?utf-8?Q?Okuf4Q5G2JohdWaAbR9YYyWn0=3D?=
X-Microsoft-Antispam-Message-Info: +ZMHa54BzEWuTkvazyKyxqrSDsQUurUuuXQhnYQWIeeg0BTKNB3Fp2N4j542QlosWiJdnCnbF29wTWLIwv4r7yhJXx6pSWeFUzTnPI+7m1Sc3nB+qfz1WWa22dvh5YPI2AlXRul5aGi1nVO4Yu61YLJ9CrjDU82Ox/Tg3qx5pmOpH1Efx4VzibWlqDAmboYqWqAm/aZ08CynZqgLbL3r7JjU2ah2IWQ4hi0J1IGpEba6ogQHfjZ893nJl4mhif48E7RbVqw8eQcp6idB9JCvzXbEYaNmNcwsQzzNkDSDmp52cjs+4rIRbeJT9tNRCG6WTvQD3dlkZgIx71t+vGa/UqM69ANJyqSn+c+SB3zWTAw=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1335;6:XwbX7IlVqgvHiVt6EKIBhwMWe0pL5eT/SDo0DaqXy3vNNMmrdNMDpovANH8djem9Z6dCGP9vUsv3q6wJIihp1/7U85zmbRU4CGa5byWvaJEJfmYIKknhB1VNc3SLleNblqmgn2x3stjPv7yBHrSlvmYY8auqqFIFIHgDIg6JiaLxmQBeob3Yjtp9jCYL95LjRLHYln/zFECoNv3JNJiPmvST9LQNU9+nHmIhCSrx+wsCcQhvu928WBfyTuECRCFqSj/EmAcWhfJ2GYHKTbB+hLvaOZ1syWnnE22OFLNvUshxPskiUyv/bmgX4su8FsALDSTDxJFrXXAyp677VIC8Nh3xce/AcQrMxptzA0Y8zADHBxHwdJlg4PxtoiNRhDFjNwTaORfY89xJExaIyrK8EQtCi3LNhqvlHsqhM0nZCZtzWRX3KyM/J9lfStBpNfcwsjAAILj1vf0w1iIm7NjWhg==;5:0mGKUaI1wvg3h72KzrX8lS9eJCh0c85x5cTZ1L+43h4yB95ezjWNt371lTEucpvDdbeVQhKqjdvtE6HqFokE/qoA/fTprndQUdjCJf34uuzZJiEfNkkiwuze97aL2VBOwR9/l8SqoVi6SfzTpoeXnwmG5oQRAD79OmpS6liAGkA=;24:QSVVzmLetj/AkFLxYecJy7wpzuPZzsDYCkzqGQpGT7AFzVjEESeLENApWTnCAtLovmhz4xuskHWJTv3NBmfWjTm+GOgdV8KMt9JQ9iIPgbM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1335;7:nGdp/XWuQRPntcZEYJwpISYY8+vo6PEGhAVmbR7gpmX0cX8BoDkt6iwq3VACaoVK+u9JZweaTvzxkSfHxfbRS7bNJtnUIEAdxKm32NzNMsh3HYtad0VgszXO/EJJM2e6GlG3z1rR6WxglE0Gk1GhzcUmiglJQq1nz816rNrDF4UMzf6Yqr8FVe8p3HJPVoBGd5CttubvdQgwmQ2vEqqp4A8DXXseddy+s48qClArU+zuBu36T2qpF9ePbySG7FzS;20:DTghruLEX6Fiu8ye2CFpaO7Jx6VrFRSGk0geYIvWfg8yDrCUnrRgDZXJvm13vNUdZ5nuMcm2NW1qfVpP7Exw6C+O090BmLtth68HxE8c/nPYzTJHjBmEi1mt57CtwobKsBQjv60s32NeyILtB0hgQSl/DAuJYilc2iiNGJ6uB+4=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2018 17:32:29.2864 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7616e128-6e89-4c5d-be25-08d5e10af48c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1335
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.07.2018 20:00, Shakeel Butt wrote:
> On Tue, Jul 3, 2018 at 9:17 AM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>>
>> Hi, Shakeel,
>>
>> On 03.07.2018 18:46, Shakeel Butt wrote:
>>> On Tue, Jul 3, 2018 at 8:27 AM Matthew Wilcox <willy@infradead.org> wrote:
>>>>
>>>> On Tue, Jul 03, 2018 at 06:09:05PM +0300, Kirill Tkhai wrote:
>>>>> +++ b/mm/vmscan.c
>>>>> @@ -169,6 +169,49 @@ unsigned long vm_total_pages;
>>>>>  static LIST_HEAD(shrinker_list);
>>>>>  static DECLARE_RWSEM(shrinker_rwsem);
>>>>>
>>>>> +#ifdef CONFIG_MEMCG_KMEM
>>>>> +static DEFINE_IDR(shrinker_idr);
>>>>> +static int shrinker_nr_max;
>>>>
>>>> So ... we've now got a list_head (shrinker_list) which contains all of
>>>> the shrinkers, plus a shrinker_idr which contains the memcg-aware shrinkers?
>>>>
>>>> Why not replace the shrinker_list with the shrinker_idr?  It's only used
>>>> twice in vmscan.c:
>>>>
>>>> void register_shrinker_prepared(struct shrinker *shrinker)
>>>> {
>>>>         down_write(&shrinker_rwsem);
>>>>         list_add_tail(&shrinker->list, &shrinker_list);
>>>>         up_write(&shrinker_rwsem);
>>>> }
>>>>
>>>>         list_for_each_entry(shrinker, &shrinker_list, list) {
>>>> ...
>>>>
>>>> The first is simply idr_alloc() and the second is
>>>>
>>>>         idr_for_each_entry(&shrinker_idr, shrinker, id) {
>>>>
>>>> I understand there's a difference between allocating the shrinker's ID and
>>>> adding it to the list.  You can do this by calling idr_alloc with NULL
>>>> as the pointer, and then using idr_replace() when you want to add the
>>>> shrinker to the list.  idr_for_each_entry() skips over NULL entries.
>>>>
>>>> This will actually reduce the size of each shrinker and be more
>>>> cache-efficient when calling the shrinkers.  I think we can also get
>>>> rid of the shrinker_rwsem eventually, but let's leave it for now.
>>>
>>> Can you explain how you envision shrinker_rwsem can be removed? I am
>>> very much interested in doing that.
>>
>> Have you tried to do some games with SRCU? It looks like we just need to
>> teach count_objects() and scan_objects() to work with semi-destructed
>> shrinkers. Though, this looks this will make impossible to introduce
>> shrinkers, which do synchronize_srcu() in scan_objects() for example.
>> Not sure, someone will actually use this, and this is possible to consider
>> as limitation.
>>
> 
> Hi Kirill, I tried SRCU and the discussion is at
> https://lore.kernel.org/lkml/20171117173521.GA21692@infradead.org/T/#u
> 
> Paul E. McKenney suggested to enable SRCU unconditionally. So, to use
> SRCU for shrinkers, we first have to push unconditional SRCU.

First time, I read this, I though the talk goes about some new srcu_read_lock()
without an argument and it's need to rework SRCU in some huge way. Thanks
god, it was just a misreading :)
> Tetsuo had another lockless solution which was a bit involved but does
> not depend on SRCU.

Ok, I see refcounters suggestion. Thanks for the link, Shakeel!

Kirill
