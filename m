Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 1B3A7C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 11:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4B0A20020
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 11:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=epam.com header.i=@epam.com header.b="bVJAPduG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4B0A20020
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=epam.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935427AbeFML5Y (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 07:57:24 -0400
Received: from mail-eopbgr40088.outbound.protection.outlook.com ([40.107.4.88]:63655
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935244AbeFML5V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 07:57:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GsT2CG6fZOg51ES6st6BYKOF2En+bgf0WnQ4h9c0Wfo=;
 b=bVJAPduG45uYzgNh08NFYbuZLM1wyw+sEVMCPL/Wxtzd/a3ZJG1W394FzsYylmsJJNGNPuQz725StzOSnynfWG1uz3PLBkMx8LBbyul2fLMVymuJfFZIMUSo4jMKJ3fkS3rGq/QPxJ73Tv08e6dbwAHVigBOYxoXVR7h+Ii/vUw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Oleksandr_Andrushchenko@epam.com; 
Received: from [10.17.182.9] (85.223.209.53) by
 AM0PR0302MB3203.eurprd03.prod.outlook.com (2603:10a6:208:9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.16; Wed, 13 Jun
 2018 11:57:16 +0000
Subject: Re: [PATCH v3 8/9] xen/gntdev: Implement dma-buf export functionality
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Oleksandr Andrushchenko <andr2000@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        jgross@suse.com, konrad.wilk@oracle.com
Cc:     daniel.vetter@intel.com, dongwon.kim@intel.com,
        matthew.d.roper@intel.com
References: <20180612134200.17456-1-andr2000@gmail.com>
 <20180612134200.17456-9-andr2000@gmail.com>
 <bd5adb0e-af98-528f-d6f9-9d5888ff2412@oracle.com>
From:   Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>
Message-ID: <5c50f951-47db-782d-1ac2-162892f7ec91@epam.com>
Date:   Wed, 13 Jun 2018 14:57:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <bd5adb0e-af98-528f-d6f9-9d5888ff2412@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [85.223.209.53]
X-ClientProxiedBy: AM5PR0202CA0023.eurprd02.prod.outlook.com
 (2603:10a6:203:69::33) To AM0PR0302MB3203.eurprd03.prod.outlook.com
 (2603:10a6:208:9::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4809c0f6-d600-47c1-d60a-08d5d124cfa7
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(711020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM0PR0302MB3203;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0302MB3203;3:vfd2aj2VaffCo82f79+lQG74TnsslM3koC2Qp0DCIqsKXdiCvZE1dU/YOG+tXXxX0xkUkEJSmJ7aHreHYX2nznGvW7El6PD/3jhsc+ssmWd7rzyuHzT2svTbQBcQJLSK6aXbt9Kw2FdKY5UA6fLNBrNjQATDL8neNm4vxGyVQyZCYo8Xy16HqnqGdvNeNsFkO8xEZcgJUroQepHMENxvUGp1kdKmEFJtEmNIbvKMW6y+rg6nexlnd+mePT9TLSv+;25:9rp7u3H/7i//x5ULpMrmJnxzpJOlUMspO6YvqAkHwCk8xViMASD3pSfvkjThNfPRMd69tONIGzyEUy6CGirKiSpMnoQBl09hxTDZiYw4eh4a4fz6SFvL7vOCwG0iMwo0WUNt6nRaod0YeHF0xEytw3RzMQ7TV62+hMPOcfBwMTI0Kagsm7AJuKdkKNt0Fk23Yvl7sCimbZFCDSYh21O3JlPF9VwEBFoO41+v28UmxRrb9M4BJu5xwsKvcEbq7rO0kdFtD3b5hcev0SNaGdqVzmOuJYHKgCKVyoN306kL9IkK8oi0Mx1YCRKmidqKh3owHNneYrOLMRE/T0NRl8Gnvg==;31:9yFaOk985arAxkxzXUj2QD17BzMNKtzzFjNW3lYBUhzODqf26X+gkwhSp676vVu/jAu70oqotGEfJ0ph7hZFIv9GvYUBrPDQzILHyIDioT0G7eVjITtVTG5m9jemPCKvQmkXSUw1yA/9vNB693iyHtzZOKLEnL2XztPsHWZWQ4OAqm8nqshSUQPThzAhTZPcKukAd0vlA0lspXhXlfNiI87QAi530PlVLCioHEnAACs=
X-MS-TrafficTypeDiagnostic: AM0PR0302MB3203:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0302MB3203;20:u5xNpTE7tbz2WuQF4gxRK9th1TPFcsqOlhP5TIk84/Ynj75Om1PfndCAluA697nAY16tqkoQU5g/4YrJGO8GMSXFi2kNPiYqp8JIFseV0v9Iz4u2EL6R0P0gDyCeIvq4G0RdNwj0nEInNC/OvryXBZ4iqoaiHe7ze5mlT7qINys1yxj7slJUjBzSxcnAXbOm6Q+V5Gby6XTTA4SLQ73Yz4kEOJmNHIS0Td9H5IxgUodvw2rWKQNSN89/wMlero6b4CjErYvllKAm57Il9CS+Tw/s6id390cLihsBun43a6pRIoRTEJF9nsvQdMv9g1MIp8hUiTS2walUIDBjCTz4Y9f+GLmIg0m17rx4LuvVfo3h7X12BhXtiaSqiaM0watt6T+kQgKW6iehTAEm2ul68WzOYp6iXLdIX0OYyiIFDJmz4Pe1UYU9pjE7anSSKX3NDGXzztbJ2DN4vHhGvEXlzRpqX2GQw/5kk4qjta0jPNj8LG0W6RnJ+Gv+LU3X5sWZ;4:iwejdenFs2Ll45WSY7bvisIxImytcaIeDE0IfTkS5nxqE8BUGNCzcIcMNc1nhE/Qa7o60tOJ235wfvet31Tqm8s+OU2nhXrvEhaG1mQIEYQeZFNo6GSkbh2WPgnnQr8/sGJwi8m9Evy6KZHhSXtyrDfQkGgkY12kZFHgS7FAQe8TigRVepqwZ8mWwZj9EQyOfDE35zInl8+jCo8WIXhHovqfiKOi8+eNKRJ3+OqG35puQAYqopBhZ3RBXTYA0dFu2nc0gXuzgKLhagirwYVRb7feFVYLpdeMxTjDxI6/0a9OXjl5Vzeseis5KfH7uoMj
X-Microsoft-Antispam-PRVS: <AM0PR0302MB3203E3B4CFA2F639A2B23193E77E0@AM0PR0302MB3203.eurprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(4114951738403);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:AM0PR0302MB3203;BCL:0;PCL:0;RULEID:;SRVR:AM0PR0302MB3203;
X-Forefront-PRVS: 07025866F6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(346002)(376002)(366004)(396003)(39380400002)(57704003)(199004)(189003)(16526019)(6666003)(50466002)(186003)(77096007)(26005)(68736007)(55236004)(72206003)(5890100001)(76176011)(2906002)(8676002)(81166006)(81156014)(52116002)(478600001)(53546011)(59450400001)(386003)(23676004)(52146003)(2486003)(8936002)(6116002)(97736004)(80792005)(31696002)(345774005)(3846002)(86362001)(7416002)(106356001)(229853002)(66066001)(65956001)(2870700001)(53936002)(6246003)(65826007)(305945005)(7736002)(5660300001)(4326008)(39060400002)(65806001)(25786009)(316002)(16576012)(64126003)(36756003)(67846002)(47776003)(6486002)(476003)(956004)(31686004)(446003)(11346002)(2616005)(486006)(110136005)(58126008)(105586002)(21314002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR0302MB3203;H:[10.17.182.9];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: epam.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTBQUjAzMDJNQjMyMDM7MjM6TmRQWDlBOE5YbWxaYTZTb2h0NXdIQUpL?=
 =?utf-8?B?eTZCZ1JuYTFEQ29yR3RCSkE4bEFYNHlFQmkwM1ZOL1BLOG1qUVFLS1p3L0Ez?=
 =?utf-8?B?elN6cythTkUxdWRSNks0U3dZR2JZaTVLcVY5R1pXNzEvVWcvL3hVcjllSSs0?=
 =?utf-8?B?a3MwQWRqb0ZJanZnZTlVbkZtcW80VWxXMXRZUGhSQm5CeVBqd3lTM1JYcENu?=
 =?utf-8?B?dDZIOHJRTTArZFc3ZmxLdDkwVVdGUjF0enFRNkhINU9PMzRsbFJvZDE0T1Mr?=
 =?utf-8?B?MXNtbUQrd28xalZXUzRnOGpzdCtXZXNxY2VJK1B0TExKanQ2NlEyR2N0OVIz?=
 =?utf-8?B?dUZITnl1T0ovZXorai9mQ1RaSUM2OGV6d0xqRVMyTWsvSTAzME0ramIwdTh4?=
 =?utf-8?B?bGY4Y05KNHBncmlhcmFiYzZLajR3UThuUDdYT3RJSXg3Z3hIY1lCUndqZ01r?=
 =?utf-8?B?RjVaVkF6OWJTQ1hlY2JiU3JTVS94ZU5vZTNhYk9hTUVaSEdoeVQyZkk0aUVO?=
 =?utf-8?B?cjU0MmdrL0trV2RUV256Tk5yd0l0N0NxVnRDeWFPMVhqd2xJUkE1SmZzZ0lm?=
 =?utf-8?B?dTdONVBQRWFmalhmMGtYYVc4MGZlcXhZaGFZZS9JbmlZUFJSRjFKc25ZWkFt?=
 =?utf-8?B?dkdFOEhJcTY0OUZ1bFlmbUNUZWU3VWthNER0N3luZVRSN2FNUzFITkwrM1hD?=
 =?utf-8?B?ZUROeVRtNDBOZXk2QkZNVUNRRlF3ZTBkemgxYTdSeStyUnBTM216RC9sY3JR?=
 =?utf-8?B?T1UzRmdyWm41MVdMaGtLOXQ0eGlTY3BxU1lXT0dYNTVGbitqd0paVW9NU2Jw?=
 =?utf-8?B?TDRhY0wvS2VDeFdvV05NcnNsbkdHM21ZQUVsOHdnVnpIZUs1NWV4WkFZM2M2?=
 =?utf-8?B?NGtwMFVmT1NxQVV4TFJJV0l4UmVpeUp3ZDFNenROVnJWTGY0alI4WGZKcnZE?=
 =?utf-8?B?cnlub2d2NW9wRHJwcDBRWWFMZkNvdFBRaVRRU0dTdXY1c1lVUnl4OHVaMmFW?=
 =?utf-8?B?ZGlEWm5wbEpDbmxrSEc4Snl3RS81WWRmTnBjdzc4TkcyYng0ZXo5WStzbm4y?=
 =?utf-8?B?cUVBYUdDTW1qenJVbHBmcmdWREUyM1pISW9yb294QVQ0UU80SUVjdHRxalNK?=
 =?utf-8?B?ak9EdEdUVUZqbkNTaDgzYlFVU2hXc2hKbnFqWGswWHJoUTlLMTZKWFFmSkNZ?=
 =?utf-8?B?VDJNeDZER2RVY2kyc0RJaEhJSnE3dlltanZwWWNVVTZsZUpLczlTU2ljekpF?=
 =?utf-8?B?eFAwNVVJa0FTMXRwUU10REdRNkFMV3hOdG9tNW9BYmVQOGFMbExnQXVPVlAw?=
 =?utf-8?B?MUhHaWtQN0pQSDBuREQ4YWtkbmtrK0tlVjEzeHZIeGZyb1FKdng4OG9vUEpp?=
 =?utf-8?B?U0Rrd0xKUnNxbXRlK1VHM045MmdydFNjRlpVaHFuRUFuK3NCMmowTHBKQ3E4?=
 =?utf-8?B?Zy8vNzM0SnRVb1NJUy9tRUdXYkY4MWF2aHF3ZVdZVTc5bmUrUlB0ai9ScG5Y?=
 =?utf-8?B?YmdxbE53QlQ5K3RvNlIwanRsdlZSUjFoQlRUS1dkVXUrZEJKOTl6dE4vMjcz?=
 =?utf-8?B?eFc3U1VqM2NWdmZFdFd3RjJZYVhxcndRMVNFenZ2Tm54OWF2bzUrUUlseGJo?=
 =?utf-8?B?R2o0bmtIWnBvdFBXcno4RGhNU0VTNjhqN3FtTktLZjNZWmc2NXZ2Q3kzSnE4?=
 =?utf-8?B?UGJRM1o2T0tjY01ka3djZTRFdDNGM1R5VFVOTlRxUlVGQThMTTI4VkozNnlT?=
 =?utf-8?B?SUh4Y2FjbDRRbU5KMk9OekpjbUdtK1oyUVJJekZrRks2K2RKSk5iQ2x0QzVQ?=
 =?utf-8?B?MUdHV2lSVVJvUTZrb0xsekg1c0luZ0NadEpXUCtwU3BSZHhoTmV6eEFMY1hY?=
 =?utf-8?B?OEllY1lwTmRqQ1FuTlVsRXZaMVJzL2FNa1FDc2hHMnNIdklLR2JsWHpRdlBQ?=
 =?utf-8?B?a0lKN0VIUndINlRPTkFyRUZBVEcraC84dzYyc0VIeFJCRmRacVRBYlNVRjdG?=
 =?utf-8?B?eGJjZER2OGZ4OVF5YUNuMFZ3c1MrNXAzZmZyN2N6UStaUTZFdlArNTdINTBx?=
 =?utf-8?B?cld3RXQ4V21yV20vdFd4aUlLR01VeWM0YTdmbjNwdjRCcHFmYnExMWkzVHZ3?=
 =?utf-8?B?YU12MGw3bFF1MTFrYWNtQ2hscC95SGUrNm94a0pjWFhGTjMwRHBxYTJpcWR0?=
 =?utf-8?B?UlpId1dTb3BLVWExYVp0ODlJaEtZcWIxRDRIWTRzY1dlb3l2ZnU0cE5GRDdH?=
 =?utf-8?B?bTZ2Qkt4aGxJcnBjZi9CVXVPYlN2MFVNcE9vTTZBQXJncnUxdTdLYTNnPT0=?=
X-Microsoft-Antispam-Message-Info: mHV6DyiIwFMMdQHabbVe/0tn+IRMAgWNh1Dy9X2NqDwsSfgrOLN62IDot6H6JSeeuMigNSSvMEm9PCJXQLoL9yDQXbPgFVIlbrwIZD7nc+89WA88TSIKE2p8aT3X1/55p+wdz054G2/jBTqQeahLZdrq4A+DhPMbSBEQfiEbv8y6Bkrvm/oaqMMKr1GhiDuz
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0302MB3203;6:4ZEIcHjT9VIoIFn+jlFybyk6YjLKtTyQyvk1EqtvnzN8BY+dhL3LeOb5UrlzvVXwCHS6hsb+IXnTTCaV1ULNsqS1t/bDV9eDkMBSmh9uD4MZNefr5X3YEY/C4CtUHGoDZLT3scQpyHiC49VrowmsHwgJoNvgkJEnVjmdKgrOU6bOlN/+yg5NaiVWtjevZ5Bd0Gc956nqbG3EGhS9op2T8yogFCIeeQlO3Lma/ip5ECZS8VVr6yc3KdEB2nZp5F6NzM4P+f9mj85Ayso+EM7tC3iwK0D1een1Bhpvi44csFmXknnC0ImJlrfSHK/1sn7FE1tZAvi1Itzn9IkJZ0NUi5SnIZv4Cp3PFkwoM3iwELX37vKj/jd7pZ6TLsebzB8K/W9RZs/RWbfsEDU7g83BN2CMxSF//KM0AKYfvq1GTBOBwFTdBgwIrgGuyF+tJKVAzCQ6mHjzfTFh1GvnI7zbug==;5:tvBn+IB7haXTPUstbK2zIdvnvyvcZ+9chrhE+0GYZZ9Yn6WBIIHyoi+gquPyH/SSe8AVeiE5vKzYZINtjPgA+ehaPvr75hLnFvNCAVFm6kZLNRQaN8m8Ubh262vAPEi/ulmq7GG+iy7KVOo3xH3WKq+T5KD1Mj7wWsakxJ80XDQ=;24:kVLtBDiceA9WXnkEkQNZxdMzEIIs0FIyOQ7fy3iHuCQp2QyBSbHxJf/xpi7Quolz/bbkcL9p4NlnFijOMZTPE+nEwbiRbcQZ2dxkSdZcd7Q=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0302MB3203;7:aE8z72/ftidTBZu8fKPYSXmk14ej46Aw6Z+APO7Mx6V9Gy/qz+S5/AHNU1iJGHQRL/OmPkWYNSm4zPQU9HpDXVY1hS5clazJq7GQ2MeRT1T8Ogwge0zw+3S9+MO+41PxqenRR67I5OQIbHoZmKObpLX+tPTZP8w0ASJQ/tAQonWlSfYkCs+KU44X051Uk92KyVXiRSudS10iNu9FTMUadlE07C2uYRdPvqQvUKsNqauyY/EE3ZS0phMqhuci7NTe
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2018 11:57:16.9297 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4809c0f6-d600-47c1-d60a-08d5d124cfa7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0302MB3203
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/13/2018 05:58 AM, Boris Ostrovsky wrote:
>
>
> On 06/12/2018 09:41 AM, Oleksandr Andrushchenko wrote:
>> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>
>> 1. Create a dma-buf from grant references provided by the foreign
>>     domain. By default dma-buf is backed by system memory pages, but
>>     by providing GNTDEV_DMA_FLAG_XXX flags it can also be created
>>     as a DMA write-combine/coherent buffer, e.g. allocated with
>>     corresponding dma_alloc_xxx API.
>>     Export the resulting buffer as a new dma-buf.
>>
>> 2. Implement waiting for the dma-buf to be released: block until the
>>     dma-buf with the file descriptor provided is released.
>>     If within the time-out provided the buffer is not released then
>>     -ETIMEDOUT error is returned. If the buffer with the file descriptor
>>     does not exist or has already been released, then -ENOENT is
>>     returned. For valid file descriptors this must not be treated as
>>     error.
>>
>> 3. Make gntdev's common code and structures available to dma-buf.
>>
>> Signed-off-by: Oleksandr Andrushchenko 
>> <oleksandr_andrushchenko@epam.com>
>> ---
>>   drivers/xen/gntdev-common.h |   4 +
>>   drivers/xen/gntdev-dmabuf.c | 470 +++++++++++++++++++++++++++++++++++-
>>   drivers/xen/gntdev.c        |  10 +
>>   3 files changed, 482 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/xen/gntdev-common.h b/drivers/xen/gntdev-common.h
>> index a3408fd39b07..72f80dbce861 100644
>> --- a/drivers/xen/gntdev-common.h
>> +++ b/drivers/xen/gntdev-common.h
>> @@ -89,4 +89,8 @@ bool gntdev_account_mapped_pages(int count);
>>     int gntdev_map_grant_pages(struct gntdev_grant_map *map);
>>   +#ifdef CONFIG_XEN_GNTDEV_DMABUF
>> +void gntdev_remove_map(struct gntdev_priv *priv, struct 
>> gntdev_grant_map *map);
>> +#endif
>> +
>>   #endif
>> diff --git a/drivers/xen/gntdev-dmabuf.c b/drivers/xen/gntdev-dmabuf.c
>> index dc57c6a25525..84cba67c6ad7 100644
>> --- a/drivers/xen/gntdev-dmabuf.c
>> +++ b/drivers/xen/gntdev-dmabuf.c
>> @@ -3,13 +3,53 @@
>>   /*
>>    * Xen dma-buf functionality for gntdev.
>>    *
>> + * DMA buffer implementation is based on drivers/gpu/drm/drm_prime.c.
>> + *
>>    * Copyright (c) 2018 Oleksandr Andrushchenko, EPAM Systems Inc.
>>    */
>>   +#include <linux/dma-buf.h>
>>   #include <linux/slab.h>
>>   +#include <xen/grant_table.h>
>> +#include <xen/gntdev.h>
>> +
>> +#include "gntdev-common.h"
>>   #include "gntdev-dmabuf.h"
>>   +struct gntdev_dmabuf {
>> +    struct gntdev_dmabuf_priv *priv;
>> +    struct dma_buf *dmabuf;
>> +    struct list_head next;
>> +    int fd;
>> +
>> +    union {
>> +        struct {
>> +            /* Exported buffers are reference counted. */
>> +            struct kref refcount;
>> +
>> +            struct gntdev_priv *priv;
>> +            struct gntdev_grant_map *map;
>> +        } exp;
>> +    } u;
>> +
>> +    /* Number of pages this buffer has. */
>> +    int nr_pages;
>> +    /* Pages of this buffer. */
>> +    struct page **pages;
>> +};
>> +
>> +struct gntdev_dmabuf_wait_obj {
>> +    struct list_head next;
>> +    struct gntdev_dmabuf *gntdev_dmabuf;
>> +    struct completion completion;
>> +};
>> +
>> +struct gntdev_dmabuf_attachment {
>> +    struct sg_table *sgt;
>> +    enum dma_data_direction dir;
>> +};
>> +
>>   struct gntdev_dmabuf_priv {
>>       /* List of exported DMA buffers. */
>>       struct list_head exp_list;
>> @@ -23,17 +63,439 @@ struct gntdev_dmabuf_priv {
>>     /* Implementation of wait for exported DMA buffer to be released. */
>>   +static void dmabuf_exp_release(struct kref *kref);
>> +
>> +static struct gntdev_dmabuf_wait_obj *
>> +dmabuf_exp_wait_obj_new(struct gntdev_dmabuf_priv *priv,
>> +            struct gntdev_dmabuf *gntdev_dmabuf)
>> +{
>> +    struct gntdev_dmabuf_wait_obj *obj;
>> +
>> +    obj = kzalloc(sizeof(*obj), GFP_KERNEL);
>> +    if (!obj)
>> +        return ERR_PTR(-ENOMEM);
>> +
>> +    init_completion(&obj->completion);
>> +    obj->gntdev_dmabuf = gntdev_dmabuf;
>> +
>> +    mutex_lock(&priv->lock);
>> +    list_add(&obj->next, &priv->exp_wait_list);
>> +    /* Put our reference and wait for gntdev_dmabuf's release to 
>> fire. */
>> +    kref_put(&gntdev_dmabuf->u.exp.refcount, dmabuf_exp_release);
>> +    mutex_unlock(&priv->lock);
>> +    return obj;
>> +}
>> +
>> +static void dmabuf_exp_wait_obj_free(struct gntdev_dmabuf_priv *priv,
>> +                     struct gntdev_dmabuf_wait_obj *obj)
>> +{
>> +    struct gntdev_dmabuf_wait_obj *cur_obj, *q;
>> +
>> +    mutex_lock(&priv->lock);
>> +    list_for_each_entry_safe(cur_obj, q, &priv->exp_wait_list, next)
>> +        if (cur_obj == obj) {
>> +            list_del(&obj->next);
>> +            kfree(obj);
>> +            break;
>> +        }
>> +    mutex_unlock(&priv->lock);
>
>
> Do we really need to walk the list?
>
It can be deleted without walking the list and no reason to do that walk.
Just an example of over-engineering here, thank you for spotting this.
> And if we do, do we need the safe variant of the walk? We are holding 
> the lock. Here and elsewhere.
>
You are perfectly right. I will not use safe variant of the walk, no 
need for that
>
>> +}
>> +
>> +static int dmabuf_exp_wait_obj_wait(struct gntdev_dmabuf_wait_obj *obj,
>> +                    u32 wait_to_ms)
>> +{
>> +    if (wait_for_completion_timeout(&obj->completion,
>> +            msecs_to_jiffies(wait_to_ms)) <= 0)
>> +        return -ETIMEDOUT;
>> +
>> +    return 0;
>> +}
>> +
>> +static void dmabuf_exp_wait_obj_signal(struct gntdev_dmabuf_priv *priv,
>> +                       struct gntdev_dmabuf *gntdev_dmabuf)
>> +{
>> +    struct gntdev_dmabuf_wait_obj *obj, *q;
>> +
>> +    list_for_each_entry_safe(obj, q, &priv->exp_wait_list, next)
>> +        if (obj->gntdev_dmabuf == gntdev_dmabuf) {
>> +            pr_debug("Found gntdev_dmabuf in the wait list, wake\n");
>> +            complete_all(&obj->completion);
>> +            break;
>> +        }
>> +}
>> +
>> +static struct gntdev_dmabuf *
>> +dmabuf_exp_wait_obj_get_by_fd(struct gntdev_dmabuf_priv *priv, int fd)
>
>
> The name of this routine implies (to me) that we are getting a wait 
> object but IIUIC we are getting a gntdev_dmabuf that we are going to 
> later associate with a wait object.
>
How about dmabuf_exp_wait_obj_get_dmabuf_by_fd?
I would like to keep function prefixes, e.g. dmabuf_exp_wait_obj_
just to show to which functionality a routine belongs.
>
>> +{
>> +    struct gntdev_dmabuf *q, *gntdev_dmabuf, *ret = ERR_PTR(-ENOENT);
>> +
>> +    mutex_lock(&priv->lock);
>> +    list_for_each_entry_safe(gntdev_dmabuf, q, &priv->exp_list, next)
>> +        if (gntdev_dmabuf->fd == fd) {
>> +            pr_debug("Found gntdev_dmabuf in the wait list\n");
>> +            kref_get(&gntdev_dmabuf->u.exp.refcount);
>> +            ret = gntdev_dmabuf;
>> +            break;
>> +        }
>> +    mutex_unlock(&priv->lock);
>> +    return ret;
>> +}
>> +
>>   int gntdev_dmabuf_exp_wait_released(struct gntdev_dmabuf_priv 
>> *priv, int fd,
>>                       int wait_to_ms)
>>   {
>> -    return -EINVAL;
>> +    struct gntdev_dmabuf *gntdev_dmabuf;
>> +    struct gntdev_dmabuf_wait_obj *obj;
>> +    int ret;
>> +
>> +    pr_debug("Will wait for dma-buf with fd %d\n", fd);
>> +    /*
>> +     * Try to find the DMA buffer: if not found means that
>> +     * either the buffer has already been released or file descriptor
>> +     * provided is wrong.
>> +     */
>> +    gntdev_dmabuf = dmabuf_exp_wait_obj_get_by_fd(priv, fd);
>> +    if (IS_ERR(gntdev_dmabuf))
>> +        return PTR_ERR(gntdev_dmabuf);
>> +
>> +    /*
>> +     * gntdev_dmabuf still exists and is reference count locked by 
>> us now,
>> +     * so prepare to wait: allocate wait object and add it to the 
>> wait list,
>> +     * so we can find it on release.
>> +     */
>> +    obj = dmabuf_exp_wait_obj_new(priv, gntdev_dmabuf);
>> +    if (IS_ERR(obj))
>> +        return PTR_ERR(obj);
>> +
>> +    ret = dmabuf_exp_wait_obj_wait(obj, wait_to_ms);
>> +    dmabuf_exp_wait_obj_free(priv, obj);
>> +    return ret;
>> +}
>> +
>> +/* DMA buffer export support. */
>> +
>> +static struct sg_table *
>> +dmabuf_pages_to_sgt(struct page **pages, unsigned int nr_pages)
>> +{
>> +    struct sg_table *sgt;
>> +    int ret;
>> +
>> +    sgt = kmalloc(sizeof(*sgt), GFP_KERNEL);
>> +    if (!sgt) {
>> +        ret = -ENOMEM;
>> +        goto out;
>> +    }
>> +
>> +    ret = sg_alloc_table_from_pages(sgt, pages, nr_pages, 0,
>> +                    nr_pages << PAGE_SHIFT,
>> +                    GFP_KERNEL);
>> +    if (ret)
>> +        goto out;
>> +
>> +    return sgt;
>> +
>> +out:
>> +    kfree(sgt);
>> +    return ERR_PTR(ret);
>> +}
>> +
>> +static int dmabuf_exp_ops_attach(struct dma_buf *dma_buf,
>> +                 struct device *target_dev,
>> +                 struct dma_buf_attachment *attach)
>> +{
>> +    struct gntdev_dmabuf_attachment *gntdev_dmabuf_attach;
>> +
>> +    gntdev_dmabuf_attach = kzalloc(sizeof(*gntdev_dmabuf_attach),
>> +                       GFP_KERNEL);
>> +    if (!gntdev_dmabuf_attach)
>> +        return -ENOMEM;
>> +
>> +    gntdev_dmabuf_attach->dir = DMA_NONE;
>> +    attach->priv = gntdev_dmabuf_attach;
>> +    return 0;
>> +}
>> +
>> +static void dmabuf_exp_ops_detach(struct dma_buf *dma_buf,
>> +                  struct dma_buf_attachment *attach)
>> +{
>> +    struct gntdev_dmabuf_attachment *gntdev_dmabuf_attach = 
>> attach->priv;
>> +
>> +    if (gntdev_dmabuf_attach) {
>> +        struct sg_table *sgt = gntdev_dmabuf_attach->sgt;
>> +
>> +        if (sgt) {
>> +            if (gntdev_dmabuf_attach->dir != DMA_NONE)
>> +                dma_unmap_sg_attrs(attach->dev, sgt->sgl,
>> +                           sgt->nents,
>> +                           gntdev_dmabuf_attach->dir,
>> +                           DMA_ATTR_SKIP_CPU_SYNC);
>> +            sg_free_table(sgt);
>> +        }
>> +
>> +        kfree(sgt);
>> +        kfree(gntdev_dmabuf_attach);
>> +        attach->priv = NULL;
>> +    }
>> +}
>> +
>> +static struct sg_table *
>> +dmabuf_exp_ops_map_dma_buf(struct dma_buf_attachment *attach,
>> +               enum dma_data_direction dir)
>> +{
>> +    struct gntdev_dmabuf_attachment *gntdev_dmabuf_attach = 
>> attach->priv;
>> +    struct gntdev_dmabuf *gntdev_dmabuf = attach->dmabuf->priv;
>> +    struct sg_table *sgt;
>> +
>> +    pr_debug("Mapping %d pages for dev %p\n", gntdev_dmabuf->nr_pages,
>> +         attach->dev);
>> +
>> +    if (dir == DMA_NONE || !gntdev_dmabuf_attach)
>> +        return ERR_PTR(-EINVAL);
>> +
>> +    /* Return the cached mapping when possible. */
>> +    if (gntdev_dmabuf_attach->dir == dir)
>> +        return gntdev_dmabuf_attach->sgt;
>> +
>> +    /*
>> +     * Two mappings with different directions for the same 
>> attachment are
>> +     * not allowed.
>> +     */
>> +    if (gntdev_dmabuf_attach->dir != DMA_NONE)
>> +        return ERR_PTR(-EBUSY);
>> +
>> +    sgt = dmabuf_pages_to_sgt(gntdev_dmabuf->pages,
>> +                  gntdev_dmabuf->nr_pages);
>> +    if (!IS_ERR(sgt)) {
>> +        if (!dma_map_sg_attrs(attach->dev, sgt->sgl, sgt->nents, dir,
>> +                      DMA_ATTR_SKIP_CPU_SYNC)) {
>> +            sg_free_table(sgt);
>> +            kfree(sgt);
>> +            sgt = ERR_PTR(-ENOMEM);
>> +        } else {
>> +            gntdev_dmabuf_attach->sgt = sgt;
>> +            gntdev_dmabuf_attach->dir = dir;
>> +        }
>> +    }
>> +    if (IS_ERR(sgt))
>> +        pr_debug("Failed to map sg table for dev %p\n", attach->dev);
>> +    return sgt;
>> +}
>> +
>> +static void dmabuf_exp_ops_unmap_dma_buf(struct dma_buf_attachment 
>> *attach,
>> +                     struct sg_table *sgt,
>> +                     enum dma_data_direction dir)
>> +{
>> +    /* Not implemented. The unmap is done at 
>> dmabuf_exp_ops_detach(). */
>> +}
>> +
>> +static void dmabuf_exp_release(struct kref *kref)
>> +{
>> +    struct gntdev_dmabuf *gntdev_dmabuf =
>> +        container_of(kref, struct gntdev_dmabuf, u.exp.refcount);
>> +
>> +    dmabuf_exp_wait_obj_signal(gntdev_dmabuf->priv, gntdev_dmabuf);
>> +    list_del(&gntdev_dmabuf->next);
>> +    kfree(gntdev_dmabuf);
>> +}
>> +
>> +static void dmabuf_exp_ops_release(struct dma_buf *dma_buf)
>> +{
>> +    struct gntdev_dmabuf *gntdev_dmabuf = dma_buf->priv;
>> +    struct gntdev_dmabuf_priv *priv = gntdev_dmabuf->priv;
>> +
>> +    gntdev_remove_map(gntdev_dmabuf->u.exp.priv, 
>> gntdev_dmabuf->u.exp.map);
>> +    mutex_lock(&priv->lock);
>> +    kref_put(&gntdev_dmabuf->u.exp.refcount, dmabuf_exp_release);
>> +    mutex_unlock(&priv->lock);
>> +}
>> +
>> +static void *dmabuf_exp_ops_kmap_atomic(struct dma_buf *dma_buf,
>> +                    unsigned long page_num)
>> +{
>> +    /* Not implemented. */
>> +    return NULL;
>> +}
>> +
>> +static void dmabuf_exp_ops_kunmap_atomic(struct dma_buf *dma_buf,
>> +                     unsigned long page_num, void *addr)
>> +{
>> +    /* Not implemented. */
>> +}
>> +
>> +static void *dmabuf_exp_ops_kmap(struct dma_buf *dma_buf,
>> +                 unsigned long page_num)
>> +{
>> +    /* Not implemented. */
>> +    return NULL;
>> +}
>> +
>> +static void dmabuf_exp_ops_kunmap(struct dma_buf *dma_buf,
>> +                  unsigned long page_num, void *addr)
>> +{
>> +    /* Not implemented. */
>> +}
>> +
>> +static int dmabuf_exp_ops_mmap(struct dma_buf *dma_buf,
>> +                   struct vm_area_struct *vma)
>> +{
>> +    /* Not implemented. */
>> +    return 0;
>> +}
>> +
>> +static const struct dma_buf_ops dmabuf_exp_ops =  {
>> +    .attach = dmabuf_exp_ops_attach,
>> +    .detach = dmabuf_exp_ops_detach,
>> +    .map_dma_buf = dmabuf_exp_ops_map_dma_buf,
>> +    .unmap_dma_buf = dmabuf_exp_ops_unmap_dma_buf,
>> +    .release = dmabuf_exp_ops_release,
>> +    .map = dmabuf_exp_ops_kmap,
>> +    .map_atomic = dmabuf_exp_ops_kmap_atomic,
>> +    .unmap = dmabuf_exp_ops_kunmap,
>> +    .unmap_atomic = dmabuf_exp_ops_kunmap_atomic,
>> +    .mmap = dmabuf_exp_ops_mmap,
>> +};
>> +
>> +struct gntdev_dmabuf_export_args {
>> +    struct gntdev_priv *priv;
>> +    struct gntdev_grant_map *map;
>> +    struct gntdev_dmabuf_priv *dmabuf_priv;
>> +    struct device *dev;
>> +    int count;
>> +    struct page **pages;
>> +    u32 fd;
>> +};
>> +
>> +static int dmabuf_exp_from_pages(struct gntdev_dmabuf_export_args 
>> *args)
>> +{
>> +    DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
>> +    struct gntdev_dmabuf *gntdev_dmabuf;
>> +    int ret = 0;
>
>
> Not necessary.
>
Will remove =0;
>> +
>> +    gntdev_dmabuf = kzalloc(sizeof(*gntdev_dmabuf), GFP_KERNEL);
>> +    if (!gntdev_dmabuf)
>> +        return -ENOMEM;
>> +
>> +    kref_init(&gntdev_dmabuf->u.exp.refcount);
>> +
>> +    gntdev_dmabuf->priv = args->dmabuf_priv;
>> +    gntdev_dmabuf->nr_pages = args->count;
>> +    gntdev_dmabuf->pages = args->pages;
>> +    gntdev_dmabuf->u.exp.priv = args->priv;
>> +    gntdev_dmabuf->u.exp.map = args->map;
>> +
>> +    exp_info.exp_name = KBUILD_MODNAME;
>> +    if (args->dev->driver && args->dev->driver->owner)
>> +        exp_info.owner = args->dev->driver->owner;
>> +    else
>> +        exp_info.owner = THIS_MODULE;
>> +    exp_info.ops = &dmabuf_exp_ops;
>> +    exp_info.size = args->count << PAGE_SHIFT;
>> +    exp_info.flags = O_RDWR;
>> +    exp_info.priv = gntdev_dmabuf;
>> +
>> +    gntdev_dmabuf->dmabuf = dma_buf_export(&exp_info);
>> +    if (IS_ERR(gntdev_dmabuf->dmabuf)) {
>> +        ret = PTR_ERR(gntdev_dmabuf->dmabuf);
>> +        gntdev_dmabuf->dmabuf = NULL;
>> +        goto fail;
>> +    }
>> +
>> +    ret = dma_buf_fd(gntdev_dmabuf->dmabuf, O_CLOEXEC);
>> +    if (ret < 0)
>> +        goto fail;
>> +
>> +    gntdev_dmabuf->fd = ret;
>> +    args->fd = ret;
>> +
>> +    pr_debug("Exporting DMA buffer with fd %d\n", ret);
>> +
>> +    mutex_lock(&args->dmabuf_priv->lock);
>> +    list_add(&gntdev_dmabuf->next, &args->dmabuf_priv->exp_list);
>> +    mutex_unlock(&args->dmabuf_priv->lock);
>> +    return 0;
>> +
>> +fail:
>> +    if (gntdev_dmabuf->dmabuf)
>> +        dma_buf_put(gntdev_dmabuf->dmabuf);
>> +    kfree(gntdev_dmabuf);
>> +    return ret;
>> +}
>> +
>> +static struct gntdev_grant_map *
>> +dmabuf_exp_alloc_backing_storage(struct gntdev_priv *priv, int 
>> dmabuf_flags,
>> +                 int count)
>> +{
>> +    struct gntdev_grant_map *map;
>> +
>> +    if (unlikely(count <= 0))
>> +        return ERR_PTR(-EINVAL);
>> +
>> +    if ((dmabuf_flags & GNTDEV_DMA_FLAG_WC) &&
>> +        (dmabuf_flags & GNTDEV_DMA_FLAG_COHERENT)) {
>> +        pr_debug("Wrong dma-buf flags: either WC or coherent, not 
>> both\n");
>
> Why not just print the value of the flags?
Will print hex value of the flags
>
>> +        return ERR_PTR(-EINVAL);
>> +    }
>> +
>> +    map = gntdev_alloc_map(priv, count, dmabuf_flags);
>> +    if (!map)
>> +        return ERR_PTR(-ENOMEM);
>> +
>> +    if (unlikely(gntdev_account_mapped_pages(count))) {
>> +        pr_debug("can't map: over limit\n");
>
>
> I think printing @count value here would be useful.
>
Will add
>
>> +        gntdev_put_map(NULL, map);
>> +        return ERR_PTR(-ENOMEM);
>> +    }
>> +    return map;
>>   }
>>     int gntdev_dmabuf_exp_from_refs(struct gntdev_priv *priv, int flags,
>>                   int count, u32 domid, u32 *refs, u32 *fd)
>>   {
>> +    struct gntdev_grant_map *map;
>> +    struct gntdev_dmabuf_export_args args;
>> +    int i, ret;
>> +
>>       *fd = -1;
>
>
> Is this still needed?
No, will remove. I was thinking here about if user-space ignores
IOCTL return value and tries to use the fd so it fails on -1.
But, ok, no reason to fix user-space bugs in the kernel
>
>> -    return -EINVAL;
>> +
>> +    map = dmabuf_exp_alloc_backing_storage(priv, flags, count);
>> +    if (IS_ERR(map))
>> +        return PTR_ERR(map);
>> +
>> +    for (i = 0; i < count; i++) {
>> +        map->grants[i].domid = domid;
>> +        map->grants[i].ref = refs[i];
>> +    }
>> +
>> +    mutex_lock(&priv->lock);
>> +    gntdev_add_map(priv, map);
>> +    mutex_unlock(&priv->lock);
>> +
>> +    map->flags |= GNTMAP_host_map;
>> +#if defined(CONFIG_X86)
>> +    map->flags |= GNTMAP_device_map;
>> +#endif
>> +
>> +    ret = gntdev_map_grant_pages(map);
>> +    if (ret < 0)
>> +        goto out;
>> +
>> +    args.priv = priv;
>> +    args.map = map;
>> +    args.dev = priv->dma_dev;
>> +    args.dmabuf_priv = priv->dmabuf_priv;
>> +    args.count = map->count;
>> +    args.pages = map->pages;
>> +
>> +    ret = dmabuf_exp_from_pages(&args);
>> +    if (ret < 0)
>> +        goto out;
>> +
>> +    *fd = args.fd;
>> +    return 0;
>> +
>> +out:
>> +    gntdev_remove_map(priv, map);
>> +    return ret;
>>   }
>>     /* DMA buffer import support. */
>> @@ -63,6 +525,10 @@ struct gntdev_dmabuf_priv *gntdev_dmabuf_init(void)
>>       if (!priv)
>>           return ERR_PTR(-ENOMEM);
>>   +    mutex_init(&priv->lock);
>> +    INIT_LIST_HEAD(&priv->exp_list);
>> +    INIT_LIST_HEAD(&priv->exp_wait_list);
>> +
>>       return priv;
>>   }
>>   diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
>> index e82660d81d7e..5f93cd534840 100644
>> --- a/drivers/xen/gntdev.c
>> +++ b/drivers/xen/gntdev.c
>> @@ -262,6 +262,16 @@ void gntdev_put_map(struct gntdev_priv *priv, 
>> struct gntdev_grant_map *map)
>>       gntdev_free_map(map);
>>   }
>>   +#ifdef CONFIG_XEN_GNTDEV_DMABUF
>> +void gntdev_remove_map(struct gntdev_priv *priv, struct 
>> gntdev_grant_map *map)
>> +{
>> +    mutex_lock(&priv->lock);
>> +    list_del(&map->next);
>> +    gntdev_put_map(NULL /* already removed */, map);
>
>
> Why not pass call gntdev_put_map(priv, map) and then not have this 
> routine at all?
>
Well, I wish I could, but the main difference when calling 
gntdev_put_map(priv, map)
with priv != NULL and my code is that:

void gntdev_put_map(struct gntdev_priv *priv, struct gntdev_grant_map *map)
{
     [...]
     if (populate_freeable_maps && priv) {
     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
         mutex_lock(&priv->lock);
         list_del(&map->next);
         mutex_unlock(&priv->lock);
     }
     [...]
}

and

#define populate_freeable_maps use_ptemod
                                ^^^^^^^^^^
which means the map will never be removed from the list in my case
because use_ptemod == false for dma-buf.
This is why I do that by hand, e.g. remove the item from the list
and then pass NULL for priv.

Also, I will remove gntdev_remove_map as I can now access
priv->lock and gntdev_put_map directly form gntdev-dmabuf.c

> I really dislike the fact that we are taking a lock here that 
> gntdev_put_map() takes as well, although not with NULL argument. (And 
> yes, I see that gntdev_release() does it too.)
>
This can be re-factored later I guess?
>
> -boris
>
Thank you,
Oleksandr
>
>> +    mutex_unlock(&priv->lock);
>> +}
>> +#endif
>> +
>>   /* 
>> ------------------------------------------------------------------ */
>>     static int find_grant_ptes(pte_t *pte, pgtable_t token,
>>

