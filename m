Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62B1C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 11:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FCC421D69
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 11:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="cINz1630"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FCC421D69
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731076AbeHIOE6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 10:04:58 -0400
Received: from mail-eopbgr20102.outbound.protection.outlook.com ([40.107.2.102]:43520
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730803AbeHIOE6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 10:04:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UvUvp9NwGAkPWzMThcI1SN+/X9bJ1aAcEruDwW00XMM=;
 b=cINz1630qFkYKLm7E5VenlcGKeZynbtQosDs3cOwKxTyxu60gNSKTViz2Z1Eh5Ga+mNEkN9srdGh/tN0sqbzFHf171HjMS5WQaSGadQa+MSquBuIqAog3H78sdExQtoqB02iR7kfv7M3qZb5Fmz36G3SecMEe6YpAjfw7zDU29w=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from [172.16.25.169] (185.231.240.5) by
 DB6PR0801MB2023.eurprd08.prod.outlook.com (2603:10a6:4:76::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Thu, 9 Aug 2018 11:23:32 +0000
Subject: Re: [PATCH RFC v2 02/10] mm: Make shrink_slab() lockless
To:     Michal Hocko <mhocko@kernel.org>
Cc:     akpm@linux-foundation.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, viro@zeniv.linux.org.uk,
        darrick.wong@oracle.com, paulmck@linux.vnet.ibm.com,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        hughd@google.com, shuah@kernel.org, robh@kernel.org,
        ulf.hansson@linaro.org, aspriel@gmail.com,
        vivek.gautam@codeaurora.org, robin.murphy@arm.com, joe@perches.com,
        heikki.krogerus@linux.intel.com, sfr@canb.auug.org.au,
        vdavydov.dev@gmail.com, chris@chris-wilson.co.uk,
        penguin-kernel@I-love.SAKURA.ne.jp, aryabinin@virtuozzo.com,
        willy@infradead.org, ying.huang@intel.com, shakeelb@google.com,
        jbacik@fb.com, mingo@kernel.org, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
References: <153365347929.19074.12509495712735843805.stgit@localhost.localdomain>
 <153365626605.19074.16202958374930777592.stgit@localhost.localdomain>
 <591d2063-0511-103d-bef6-dd35f55afe32@virtuozzo.com>
 <4ceb948c-7ce7-0db3-17d8-82ef1e6e47cc@virtuozzo.com>
 <20180809071418.GA24884@dhcp22.suse.cz>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <964ee4fe-bbd1-0caa-4c5e-a73af99ee7bb@virtuozzo.com>
Date:   Thu, 9 Aug 2018 14:23:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180809071418.GA24884@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: VI1PR0202CA0026.eurprd02.prod.outlook.com
 (2603:10a6:803:14::39) To DB6PR0801MB2023.eurprd08.prod.outlook.com
 (2603:10a6:4:76::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c4efb723-a0b5-41b7-1bfd-08d5fdea8c21
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB2023;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB2023;3:YfmT7w3LH7boKP1YcCazaCYDnGkpG5d9BveCL3JDVU3reO3vrgZ2mRX6tK5MbjxdKMmjtsm4ZZrXagTR+Osb5mQf6oP1CksMIewLzU/HN0Xyab5HZ5419QyPl8j1bBclOM54nuCDZMdgBbf+Og75pXu9vy5LiOi4+rP2NJcgQyuVmLZxDSyK2OY4uN9/W85Ej8jzmBSy7ZaU51dgTQDi5FUZrs7bly4z+/IzIgJfCoWPCJLRQUbjpUBy8Pqes9sB;25:qCZc6SK1y4/bbNQch01INsNH9Z3zH6+ZUozjRQ/WplKMF2d/5nCnX9XmQzbbLOl7pVmtQK3TZm1zGQF7NV8l0M4YTLpq4n/PziGHtRIsSxCrLBk7I5cv8ql72+VFWj8NxsIb+o2nYPP/kNGyiD7Z4+yt48ZimDQQYY5ac+nEU0p7y0YsOmsH+SjDCGn0aiZi31wRZppSwX9vm7MpHB0aKqesUjdiL7nj4oJs2SwUIZVLCPkfJDqBdVEmoF7xnTS9Sf7lv+pQCjPyG6/hPB0kSQWvA3b2f/EImIrMdDv+rq5lyZ7TvypwrFVTDNjrzku7fMGFWaUy/uFQ2c6hW3M2Bw==;31:bD0ViP6LFQFCb+Xl1s1Wj2Rn70ZtAjftinIGN26CsgYlF/ZjsPk5g+ReUEeqEJv26q9jDt4UCJiceuvxF++ZwjsLJ88M5RAPzuwe72B6kysqx61o8KYkbFlhEJq5hVeMz9Dx2ECnLohspPo/V0wwoWZlfTEm+E7J22vxnPj+KB4d28kZnvpYz9KTjU4Ilg7/nheFGncuri9q6DQqDGMyOboYuoUT79nhZDyPGfVlWZg=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB2023:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB2023;20:qEcliXqrstZcHchSgizQtP+khHON4U7PxAZowxMz//eXODSBujztiKvknYWOeoBbvSfEcqU7ddxehTAiSecLY7Tf+tAWh8oUEKJB3D2UhgFrxnfdz2OwhqVVtBkihUhSRPJW+myip70Y3NYx5WvuHb0AKBxde67Ve/VuLD7aD83WvHRQ53Cmx7lFu4xRtCWrQW+tGlKd3aXko7SKidIp1wgzCqnz0Z111PB0P25Zi9sVTl+zpMJuJKYmvAL5cxRDhWDfBzhJHVrUbqnSoJ2Gwef2CxnFor16VyckyvtTnSQ8NcNxIty/qw6vQizgsWGwLaA7wiMPm9yWhT34r7PwTj9lgPtIZ+UKEQlH/pUgQY7mOvsEgIgPvjNKbW0e+OchQ7sk+LSNW+WfdewVLax5ew4PcwqbhVfqBjWHbSYlCIukHgBhmU1rlInvuQVmx60wAs/uQ+ohZ9tBBMdveS3OI+f2LlVKfYS6TYZaerxBEMI1Vd8hmn6TpMyFnubvJLby;4:/71Ijm7Wi//SAvUgE7J+HeY7uOr0wuN/fjrRPlwCiMuaP2SwZCou28iGOt2cAuMb2Yk4i8jPH01ZnDp0hD4Q+haLQTjEJCt5kJFBks28AOZgWEBPLdCwSZQg7iZecgmHbXOLFuiC3n6JbBZkzueBiFHWEo62Rnur5KeGlwetf0AkU2fy6Xx1kvpS1QNBpR9mXaJoO8rSWKSFSL/rsMS2AeBivFv6jaXxH9mEWc2epVQ9na4mlOJP7YBgghLq9FMCnxduaUuuXkC+5I5vwjBVgw==
X-Microsoft-Antispam-PRVS: <DB6PR0801MB2023452A948C69E785EA8845CD250@DB6PR0801MB2023.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DB6PR0801MB2023;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB2023;
X-Forefront-PRVS: 0759F7A50A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(376002)(346002)(366004)(39850400004)(396003)(136003)(189003)(199004)(186003)(305945005)(7416002)(6916009)(7406005)(7736002)(93886005)(217873002)(2906002)(478600001)(6246003)(8936002)(77096007)(65826007)(6116002)(4326008)(39060400002)(23676004)(26005)(52116002)(52146003)(5660300001)(97736004)(2486003)(25786009)(76176011)(16526019)(3846002)(316002)(6486002)(58126008)(6666003)(16576012)(53546011)(31686004)(14444005)(386003)(47776003)(31696002)(86362001)(68736007)(64126003)(50466002)(229853002)(230700001)(66066001)(956004)(81156014)(2616005)(476003)(81166006)(106356001)(8676002)(11346002)(446003)(53936002)(65956001)(105586002)(36756003)(65806001)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0801MB2023;H:[172.16.25.169];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA4MDFNQjIwMjM7MjM6K3NrQ2pQUzF5TjJJOVo3OGQwZDREa2dN?=
 =?utf-8?B?RTNWOWQzY3pETDBXS1VWYi9PcFRGWFJqVnhsd0JqS0tpM0prVTV6eXBvWkNk?=
 =?utf-8?B?UDBWOXhPelJLVVhrZ3dWY3paS2dNdW5FK3o1YWNBZG9pSTVwV2U2cVBSSVBT?=
 =?utf-8?B?R3ZGQW9MQm9tTTVLNTgzdFVqQUF1RWVERjVsNGlvSlFTZjRtMXh6dm1sbUJs?=
 =?utf-8?B?TlpFSWc1ZXlMQ0tIMTJOM3dNeDFXQnRBV1lDbjM1U3VTMGh3czR2eE82bUdM?=
 =?utf-8?B?RmhERzBDMTlFc3pyS2dhQU9SVi8vNXdEdTdOeUpabTdIL3hLZS9sRjk5REM3?=
 =?utf-8?B?bXRMWFQ2UUNVMUZqVXd2MXhYemltWmlxKy9UMmZZY2ZPdVBiM2FMaGQwOUpY?=
 =?utf-8?B?dWZJWDNETEExZXB4cWdmZ0VqZVgzOHJrVU11T3RNMXg0d1JZWWJ4NExDSzhC?=
 =?utf-8?B?OG9aVnRqK1JYZ3BkMEFEWDVJMW8wRDRneEEreTR2OCtWczJvZlIrTWdZN2ll?=
 =?utf-8?B?TmNKdHhMdUxpeDZTRThzZGpQNU1STGRaakdSWGplTCtuKzRLaG56ZTN2dTNN?=
 =?utf-8?B?eWtBcDlCZ1ZwWE1NVGI2Q3E2WjZvU0NETUY4YmwyODRETW8xMGtNcGVyUE12?=
 =?utf-8?B?RlcwaDFTRVhadXFCSERsUVlvS1VWR2p5bEFtSHJjY3Y0bXQxQXJWaE9SVzhu?=
 =?utf-8?B?d3B2bU8zamJIN2s4eFZablVOWUQxOVNXQ3Y1MDlCZjV5UTFvZHVVOFphcFBE?=
 =?utf-8?B?VTNvRnlpc3RnRUF5eFJUeitXRk5VUjBPbm1GRWdrRGVaaVRVcHV3RFBNZXJV?=
 =?utf-8?B?NkJGZVFuZkxUNVRUK2M0Z3NUTUwwRlh1NXNtenFTZUduanNJSUd0azlac29S?=
 =?utf-8?B?TVBnTmhwREpLaHVEZ3B6bVZDZmpZSWtPRWV3MTlPTDlDUVNMaW9LLzlwZUt1?=
 =?utf-8?B?Y1JkL2tkdXZOa3crVGd5N21vTGlxczkyc0JCRHRSUXpRa0EycVg1bEtKRUhu?=
 =?utf-8?B?bXJJT3ZXZlhDeXFaaCswZk90WW93akltNVNaM01PTm5aNGpSVnBwcVpaNTMx?=
 =?utf-8?B?c1RCRzRTWWsxeFVMYnFJMDFSWWo1cW1yOFVIU0s1bnBrbGJzbUxxNzJveWFn?=
 =?utf-8?B?ME8yelp6TC9NekdkM1ZuV3JhU3hpaGVSTHM2amIySk9UdzI0MUZ2djcrbjBV?=
 =?utf-8?B?VkZrMHlmeXprcUdyUi84MW9RK0Qyd0d6TGhYY1pja0h2WHNIQlVVbHIxSkRZ?=
 =?utf-8?B?QUNud2E5cEdMNVViV2NYYlNQTXI1bmFyYmg1Y2lxTFJkeDU5R0pGKzU2ZmdE?=
 =?utf-8?B?dDNKa3FrUVk3ZnlqM0srMi9mNHRPOEJpRG1RODU5WTRxOUEvV2I1L0pvLzVm?=
 =?utf-8?B?TVAzdXI4UFNZVXNXKytwaTIrYVViN21Cc1ltcFZuSmMwS0lrQmhWbnBMS2FC?=
 =?utf-8?B?amlKYlFRMTQ2SHdPWjJWTkdoRjBFSHB2VklsUlRBUnllRUtxbWZtVld2QWNt?=
 =?utf-8?B?VzBZOHdPbGJ0QzdFME9aM0haYkxoc2tXZzdINEpFODJFdnE1TEdGeFVQK3JT?=
 =?utf-8?B?VHF6L1hTNnQrYVU2NFZ5WldPK2Y1TWtEMWVGUW1NejZLaEhkNGhsUEwrY0hT?=
 =?utf-8?B?aFlSbHQyZmpGV3Fndjk1bWNFNGxqaUY5OFNKVXJKZ1dYTWhCYktaN0NtZnlw?=
 =?utf-8?B?SXhuMjdmS0o5QXVwejYwRnFyT3I5YXU0VWhpOGU4Q296a0pCeExhWWhaVEZN?=
 =?utf-8?B?YnZORVVsU1ZmSUlJY1lqV1RWanduR3F4ZzRZdmcvVW5QWURNMFFndkJSeGJW?=
 =?utf-8?B?QzBEYnFobExqNXRHdnpoaDk0QXorL1crTFBWUVgxZ3ppN3U0b2QxMkVhNFJD?=
 =?utf-8?B?NXVkVytIeHNGeGRibkxsTldqUHJGZ1RnMzM1anJVQjRmbkd0Q0p5ODhmdG9v?=
 =?utf-8?B?aDlTdG9HNWJOZVlUR2pKRzdJM3ROdUNlUndwTjVlZzV1WWhKWmRXQ2UxdU1s?=
 =?utf-8?B?QUFkalJNWndiUXFtWmNSVXl5bkg0c1QyWVZzeWZ5MXB6L0c4OWNUR0NEL0li?=
 =?utf-8?Q?ZdG9L1L2tUXsYuDFyjTVGCVjINi?=
X-Microsoft-Antispam-Message-Info: Q+QKuG+FvOwSlNN3XUfRO1++8P5aX1+aoJ+S2mUzQQfkBrKNvruk9ZVBozAA8pPia2MJfT2EO6BMB5ny3PJHURHWj8OvrMqH4TVfpD/A+6KdptqX96cg3GvLdNmmh58xUZ5CSFJJr75NBXHsvgWY9UGcbkUPCP3/lYykQIsJigHJDvbV1S2KH6f/lO3FnThhU7kYQUKCSmGxbizZjRg333+NJR6dwurhd4kKaxPJnuPqngs+BCVLNZIz6SIJQx88GcElUdOJUSaLpzkrvUKH4vnj031wy/cZw/t48z5/vkqroFac2IjAVRVletZqQxyNcEyTopBF0kc/UpvsyECCzZQHsppPWoZ2PzPQS5HcSqs=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB2023;6:frzlcYFbY0qwGCPrS9o8cGm2SEnsrAUMaSSBOcesggtuXE3fa9eUmju7ce48HctGljC4BHTfWfL9LkriMcYm1D+aMJ7gTtRqMO9Lg/+Jdxzv9mkEcgParKC1IwjEiZje7dQ0lfIIwMAlOkKRtn7gHV7idD2f9t6yrWgihrOletCXi52Xo9FN0OnOeQhdiXRd7bMkyZKTn8+MIqdeRi6p2jhVOHdnOLFPiqzRbCftLNR/RvGHkDwmSNpDk/6gQWs1PwJ4T3pKKEJCO9EDjEmXR6+jYeFh5XFkyL52yBN1aOsikdz2YnrxicA4DXPX/PtFrnAqwxnU3ZFxFeNjEd+LrHuq0d7YKJofw9n76IL0Zb52kKX7pbM+g53WJhLLGCpOlGKcQXoi+LuW0GW2y+mYfy2lAOBeT4cN0oKyRjQAmCxsMLFJfNCPGE2RYJRvD740fhgDa79oMosZRlXQgfzokA==;5:5LcdcmjMppRBZJBAaE6Kf0ecD2MogSulDJT5DXke44z3QP1mAI/JCCrhbcZa82s7/MrtkW+qfvxUaTqQWDr9WkfiQQR2uRuqb40DVUWLf4GbER8QvOVxuXlGu5ZUb9Gzrq1zS8IcLyjBnwKLr9CWY/KgIrFPbJbeKtncx1y5ibs=;7:kjsmbjMhpEOPv/C2aEZFYH3JEvb8AYA+tbJO7n5+fjfMkbJrGb2G/vMFAwobGhzfk22gd3bQSMR/gH0qpveWG/5oHFBBeg/NPUEzRlOYKLn3LofZqUMHEQjH+iQiAPL96GVtfUYCAaxvNrYrc0ZZ5dnKxUs/wZuWNERTvIm+WNqNHfpZxlXUcVf5uuW1u7sgh7tOKzEGuykdWUQL+YhvR+N1tKaWfLUDOOEv/FmbuVIwL0pJIIqWqkKVQNkonAv/
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB2023;20:Kq7cmS0i/0vS7s3KvtB1jwpWjAoI4Ro/Vshbgm6P63Keb1ZU6n3HnQZ0K7PTqFJ5wQHatok9V3tzxJJsgZeo5V+J3vQx/eyYTwlo0vnW8PsZlJzJPnFiyHlFAH79W7j99z4rRh3WCrJw1jec5GpCTTpnpGstr9lBoRt7GaCzQ4o=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2018 11:23:32.4479 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4efb723-a0b5-41b7-1bfd-08d5fdea8c21
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB2023
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.08.2018 10:14, Michal Hocko wrote:
> On Wed 08-08-18 16:20:54, Kirill Tkhai wrote:
>> [Added two more places needed srcu_dereference(). All ->shrinker_map
>>  dereferences must be under SRCU, and this v2 adds missed in previous]
>>
>> The patch makes shrinker list and shrinker_idr SRCU-safe
>> for readers. This requires synchronize_srcu() on finalize
>> stage unregistering stage, which waits till all parallel
>> shrink_slab() are finished
>>
>> Note, that patch removes rwsem_is_contended() checks from
>> the code, and this does not result in delays during
>> registration, since there is no waiting at all. Unregistration
>> case may be optimized by splitting unregister_shrinker()
>> in tho stages, and this is made in next patches.
>>     
>> Also, keep in mind, that in case of SRCU is not allowed
>> to make unconditional (which is done in previous patch),
>> it is possible to use percpu_rw_semaphore instead of it.
>> percpu_down_read() will be used in shrink_slab_memcg()
>> and in shrink_slab(), and consecutive calls
>>
>>         percpu_down_write(percpu_rwsem);
>>         percpu_up_write(percpu_rwsem);
>>
>> will be used instead of synchronize_srcu().
> 
> An obvious question. Why didn't you go that way? What are pros/cons of
> both approaches?

percpu_rw_semaphore based variant looks something like:

commit d581d4ad7ecf
Author: Kirill Tkhai <ktkhai@virtuozzo.com>
Date:   Thu Aug 9 14:21:12 2018 +0300

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 0ff97e860759..fe8693775e33 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -168,6 +168,7 @@ unsigned long vm_total_pages;
 
 static LIST_HEAD(shrinker_list);
 static DECLARE_RWSEM(shrinker_rwsem);
+DEFINE_STATIC_PERCPU_RWSEM(shrinker_percpu_rwsem);
 
 #ifdef CONFIG_MEMCG_KMEM
 
@@ -198,7 +199,10 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
 		goto unlock;
 
 	if (id >= shrinker_nr_max) {
-		if (memcg_expand_shrinker_maps(id)) {
+		percpu_down_write(&shrinker_percpu_rwsem);
+		ret = memcg_expand_shrinker_maps(id);
+		percpu_up_write(&shrinker_percpu_rwsem);
+		if (ret) {
 			idr_remove(&shrinker_idr, id);
 			goto unlock;
 		}
@@ -406,7 +410,7 @@ void free_prealloced_shrinker(struct shrinker *shrinker)
 void register_shrinker_prepared(struct shrinker *shrinker)
 {
 	down_write(&shrinker_rwsem);
-	list_add_tail(&shrinker->list, &shrinker_list);
+	list_add_tail_rcu(&shrinker->list, &shrinker_list);
 #ifdef CONFIG_MEMCG_KMEM
 	idr_replace(&shrinker_idr, shrinker, shrinker->id);
 #endif
@@ -434,8 +438,14 @@ void unregister_shrinker(struct shrinker *shrinker)
 	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
 		unregister_memcg_shrinker(shrinker);
 	down_write(&shrinker_rwsem);
-	list_del(&shrinker->list);
+	list_del_rcu(&shrinker->list);
 	up_write(&shrinker_rwsem);
+
+	synchronize_rcu();
+
+	percpu_down_write(&shrinker_percpu_rwsem);
+	percpu_up_write(&shrinker_percpu_rwsem);
+
 	kfree(shrinker->nr_deferred);
 	shrinker->nr_deferred = NULL;
 }
@@ -574,11 +584,11 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 	if (!memcg_kmem_enabled() || !mem_cgroup_online(memcg))
 		return 0;
 
-	if (!down_read_trylock(&shrinker_rwsem))
+	if (!percpu_down_read_trylock(&shrinker_percpu_rwsem))
 		return 0;
 
 	map = rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_map,
-					true);
+					true /* shrinker_percpu_rwsem */);
 	if (unlikely(!map))
 		goto unlock;
 
@@ -590,7 +600,22 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 		};
 		struct shrinker *shrinker;
 
+		/*
+		 * See shutdown sequence in unregister_shrinker().
+		 * RCU allows us to iterate IDR locklessly (this
+		 * is the way to synchronize with IDR changing by
+		 * idr_alloc()).
+		 *
+		 * If we see shrinker pointer undex RCU, this means
+		 * synchronize_rcu() in unregister_shrinker() has not
+		 * finished yet. Then, we unlock RCU, and synchronize_rcu()
+		 * can complete, but unregister_shrinker() can't proceed,
+		 * before we unlock shrinker_percpu_rwsem.
+		 */
+		rcu_read_lock();
 		shrinker = idr_find(&shrinker_idr, i);
+		rcu_read_unlock();
+
 		if (unlikely(!shrinker || shrinker == SHRINKER_REGISTERING)) {
 			if (!shrinker)
 				clear_bit(i, map->map);
@@ -624,13 +649,13 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 		}
 		freed += ret;
 
-		if (rwsem_is_contended(&shrinker_rwsem)) {
+		if (!rcu_sync_is_idle(&shrinker_percpu_rwsem.rss)) {
 			freed = freed ? : 1;
 			break;
 		}
 	}
 unlock:
-	up_read(&shrinker_rwsem);
+	percpu_up_read(&shrinker_percpu_rwsem);
 	return freed;
 }
 #else /* CONFIG_MEMCG_KMEM */
@@ -672,15 +697,17 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 	if (!mem_cgroup_is_root(memcg))
 		return shrink_slab_memcg(gfp_mask, nid, memcg, priority);
 
-	if (!down_read_trylock(&shrinker_rwsem))
+	if (!percpu_down_read_trylock(&shrinker_percpu_rwsem))
 		goto out;
 
-	list_for_each_entry(shrinker, &shrinker_list, list) {
+	rcu_read_lock();
+	list_for_each_entry_rcu(shrinker, &shrinker_list, list) {
 		struct shrink_control sc = {
 			.gfp_mask = gfp_mask,
 			.nid = nid,
 			.memcg = memcg,
 		};
+		rcu_read_unlock();
 
 		ret = do_shrink_slab(&sc, shrinker, priority);
 		if (ret == SHRINK_EMPTY)
@@ -691,13 +718,16 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 		 * prevent the regsitration from being stalled for long periods
 		 * by parallel ongoing shrinking.
 		 */
-		if (rwsem_is_contended(&shrinker_rwsem)) {
+		if (!rcu_sync_is_idle(&shrinker_percpu_rwsem.rss)) {
 			freed = freed ? : 1;
 			break;
 		}
+
+		rcu_read_lock();
 	}
+	rcu_read_unlock();
 
-	up_read(&shrinker_rwsem);
+	percpu_up_read(&shrinker_percpu_rwsem);
 out:
 	cond_resched();
 	return freed;

