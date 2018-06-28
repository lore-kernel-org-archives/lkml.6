Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED3FC4314B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 19:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9F8E275A2
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 14:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="er2LUDGo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9F8E275A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966765AbeF1OxH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 10:53:07 -0400
Received: from mail-eopbgr10099.outbound.protection.outlook.com ([40.107.1.99]:40384
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966209AbeF1OxE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 10:53:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3OBDv0vlZgSoJxW7kr+vqLPznUb614HhqXtKpPSGjwU=;
 b=er2LUDGonqujH78zdyl6H0giToXvEbTRTnbmmMswFPC/9uuM5tGgz8/yHW1melzCVFbBxK0U3AdlqOdKzORC57PNKNddG9TFc+XkW58l+H3YG9DJK3mOrJ0gxCBC0UJTpk31MtETc3JU8Fi+iDD0hFKYnEE/PDwwlR71clOHicY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from [172.16.25.5] (185.231.240.5) by
 AM5PR0801MB1329.eurprd08.prod.outlook.com (2603:10a6:203:1f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.20; Thu, 28 Jun
 2018 14:53:00 +0000
Subject: Re: [PATCH v2] net, mm: account sock objects to kmemcg
To:     Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Greg Thelen <gthelen@google.com>, Roman Gushchin <guro@fb.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-mm@kvack.org
References: <20180627221642.247448-1-shakeelb@google.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <6f15cc1b-c026-6df1-19ba-d2396f71b488@virtuozzo.com>
Date:   Thu, 28 Jun 2018 17:52:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180627221642.247448-1-shakeelb@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: AM4PR07CA0018.eurprd07.prod.outlook.com
 (2603:10a6:205:1::31) To AM5PR0801MB1329.eurprd08.prod.outlook.com
 (2603:10a6:203:1f::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01cc8ced-867f-4095-be91-08d5dd06d870
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1329;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1329;3:WymTtQhids+Fsj9YOzWyo6ecgLZHrzZOpc4Ol6J3ImvDMcqPRo7ry529VjJJKxvRel8G+Nmzl3f2VGPG7xYAwapWLfapAw3kXD/6owU1W1LkbdlMh8o31XFopsEc0qR0ePhmNVCVDteWbyG2i43spJkRcfCRuw/2L2g1Tl66YHpw0eO9UE3h9aeg34tZskcrJrorRbw31f/ofLHVi8lMRKLOckYPtNqnxQlg+u2ahwRL3Mqr940No/+VRmPzAjmA;25:c78MtzSIPMInIJrPjBc0B6rKbUqrQkK13VS5hc4eEnbg0A6Fqq/rmNby0YG2mpe2kDlxLOceW70L8cXWIz0to+t9D8HLe3nUtY3Aq2WsQ+UeMxq5RrQtz8ml4UbitocUIe+aUu2q+AkLjs4SAi9o544krbrOo2Fw91DgtrWa2Fq5pTM1UfO40yvxurxWxRQGGFDDh4vsy/xNX/49QPU1LBxhLFSCjqRqD2hTVLHgVCTl+Y3/lX7TTMrLJMPDY7iLCISQKJsxBaBnqzx1ma0Vcqj7qEiVG0YslTkZ8csZdhJXFp7JtQxqzzlL2XY0OCCXmRNuqqHAy/y2B8is6xsDzQ==;31:NiS9DctvJYjuwElxYpxrFOnX7qpo1XM7Ne3pPFQM1r02iT2WvwV4rSOTZrBLqZrAxeLFj3ur5Kjgqd2bKi10+ehvpSBFkbK8sCuXTpX6eLtt00zrB4OCj1EWhGrYXUWQRd7z5UrHlWiytVmVY401cxJ8yXZS88Jh7+gY8rwM6wF6LcIji4FQXkxNHBNvRdBRgMjGslvYhdNNFEVx+CyPu5jIUzNo/NRkh0uVKimYhoI=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1329:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1329;20:jEpLYsCQIW4Ruk2bfObx4YnNpVjR1U0BXz5loo41DNBJG9+Cb+uihHiNiLJ8e1zufgf4O8aaxeKj0rdxo0Uc+uumnSjJAwcXZzej7SJaRAIDV3ZgyJr9SbEsOMTflNmrMJ53wCp8syqTC0p6ZTForXV1L7lss2sqw/J5iL0EBNe7o+aBVgkWl0jWvpormcPqfnHKjJiSyVSbYLWq3SzMiCIEscPdMpWIVehjMQvxHNSUCn7KJ+Nq2kDuJC4XAIHCHwqZ50bWJXDodP/g0wE2fBdU52aKPkChqxcDc/7sSh59F/reEkmYUDpj56/pE5xLcjahJnieM77iiiH/54EnLuw+oQHiO5IhOkMA+yepJYIG78DwfUn7aN1SGzGvi+KKTK5yofviIUmiag2KZ81/74HOuxHvdXN4exXgQNdBj7LWl22gbyWDKWpdFmyzJJxKfsGTqpO3H6+94RFjEXElereJ0+yBOMz8bk5LikUA3cDjSGAnITMMr/IAxhxfmy6C;4:AGjiIQw5wRtlB7pQFkOlAXaeT7n/yJwSXetmDdvDUbyiQKZ02sIatyI+YE5d1cBmesX9gthK8q0UO8EtPg7lxkpM+QmeDWx9EB3IcKG5sEYAJggVMNvtrYDHWV23DG54hPt/VgdhypjF/j00xEh1shtca33up0uVWcSSsIwt0phJu3xSJnU82gOsNsdTCW4+3WD712bNOrqvZ61BrGFds1t4PwLrRYWSzRLgH84b1NGF7mATzmFvBLPFqyfASdKN2Cj0yDtZ4bv2wD0usxHZwGWasjTT8hfhMfOL4HFbQTIrTwl+dVg4VZhjIWgVjiobb3OD2USlucT3ki1AalDdZdYATDOvRV348fxDEZTokBo=
X-Microsoft-Antispam-PRVS: <AM5PR0801MB13298CF8FFBD52C8C0AE4B73CD4F0@AM5PR0801MB1329.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:AM5PR0801MB1329;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1329;
X-Forefront-PRVS: 0717E25089
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(396003)(366004)(39850400004)(376002)(136003)(346002)(189003)(199004)(54534003)(53936002)(186003)(50466002)(25786009)(5660300001)(64126003)(16576012)(2616005)(86362001)(76176011)(14444005)(446003)(11346002)(77096007)(65826007)(97736004)(58126008)(16526019)(6486002)(68736007)(110136005)(54906003)(31696002)(229853002)(316002)(476003)(7416002)(6666003)(39060400002)(106356001)(26005)(6246003)(486006)(956004)(7736002)(230700001)(478600001)(52116002)(4326008)(53546011)(386003)(81156014)(31686004)(52146003)(15650500001)(23676004)(2906002)(2486003)(8936002)(36756003)(305945005)(8676002)(47776003)(105586002)(6116002)(3846002)(65806001)(66066001)(65956001)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB1329;H:[172.16.25.5];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjEzMjk7MjM6MjdaelV3cEI0SXFpQjBvcmpUKy91UkVl?=
 =?utf-8?B?RTBxaFNmTXZ6Zlp2cWk5eXlDZEE2QS9UY2pOdERGdlJQcHNHQ29uenlBWmds?=
 =?utf-8?B?RkJNb0NObzI4bTNhTVhBbkJnOEYySjR3UWVMeDcxdWwvSmZIeEduZTBmbjQw?=
 =?utf-8?B?NWNuRXluclZlbXFmbHVONTRwQ0w1YzB1NS9SRGhlRzZNR2t6RmljR3FjZEZS?=
 =?utf-8?B?anhpZmNybC9IZkFXbkZGenJmVzIxeVlab2hsNzY3amdWT1c0TysxSmRuZStq?=
 =?utf-8?B?V0w5TEVFa3JBaFYvbUpidVF2Zi80bFVFK0NsaktFazRDWFBBaFpQck5QQW5R?=
 =?utf-8?B?Ujg1aDRCb3lRY1huaGVpV1VLQXJFd1RsWGtKbGt4cEdySS9WUkFDaTJNeWpq?=
 =?utf-8?B?ZTNYa3BHSmMzMnpjL29WNmRlWDYwa25Pajl2NmlpcUJNcXJzZzl0RG9WQ3Az?=
 =?utf-8?B?b21pQjJma04yTzlWWjlYRldVRjcwa0MwTTRITlBSdDdkS1d6bllrOGlwZFhH?=
 =?utf-8?B?TDczVFpVSW9EMTB3VW4vd0ZVNGlTbDVidFA0Yk15aDA5dEYweXNUeWRNaVVI?=
 =?utf-8?B?VjcxdHdDZTIvRno1MDBPZmJDclZxeHlwdWhXRzhqcG45cExvcG1OUDcyN0dE?=
 =?utf-8?B?eURhbDFtZ1EycEdZWXJxZjNVamd5bEoramczYmhqK2JZcjFTUzZiRGozRlVO?=
 =?utf-8?B?WmVEc01YYVUxL1FMNWhvZU1Db1NGSGQvWTFaWVJ0bE9jbWhVUTBvSXY1WGlv?=
 =?utf-8?B?WUJlNmxNYUZBTElnOC83Z2k1YU8xdy96QjUvdzdMT2Q0eVNYQWtva3NnRGNF?=
 =?utf-8?B?M2pqVFBNNllUdW5OZ3dvZmF3eElKNDJ4VU1YMjFQSEFwSENJZTZOeXhqTVBR?=
 =?utf-8?B?SFBvNWVsNjVEWXpjVGZ6U1dqSlhzU1NjRWtFVHRvaWs2OU94S290YUp3VEFm?=
 =?utf-8?B?S2JjUDBaVEZBdHZ3SEE4NFVaVnhNdUR4SXJOVUhyMER4bGlIVlNFREkrYlVh?=
 =?utf-8?B?U2I1eXdyQzlPWDFKUlNsdFAwVTlOYUx0Y0ZTU2pETWtsb2w5bVpCUStXWXI0?=
 =?utf-8?B?dEk4Vlh6REFCTXhYMlJSRUFMcHJmNzhMMHNKZWwvZFpvcXQ0bmdqeUxFa1NT?=
 =?utf-8?B?ZFkzK09hUHFCTERxcnlMcTd1MWJUVVlSLzhBY2Y5TENDR1kvTE03ZHdFQ2cv?=
 =?utf-8?B?QTVjSng5RnBzVGZUU3daWG9Wb0xPT2ZTTThIcHRETVpEbWRqZTJBdm1CY0Yx?=
 =?utf-8?B?NTFaZWZtWFBkNzNnREpIODVwU1VNVHIyREVEaCs1SG82R2pRZVFUcGJFZUoz?=
 =?utf-8?B?dDBYcm1zN2o1T29iekYyZ2RXOXhmK2xvZ1RUQkg4cmVLckFVSTRkTXJWbG12?=
 =?utf-8?B?REpIM3ZSSHd1TjlOM3Rtcmt2YUZRdzVCMFlmUGtvc1g3VzBIM0hiVkluT0tk?=
 =?utf-8?B?WW5kR1JvbHg4eitvZ3djaCtScWVvNSs3cXZhS0xvNUo4d3U0aFdlSi8rQTlS?=
 =?utf-8?B?NzJYMVF2UmFtWGI5OVRKN0V4SFRUOUhkZHI5T3pvZkl3MzErdmZmWkI3R2J3?=
 =?utf-8?B?ekcyM24zMFlGSUJsWTRsRGtVYTM1dWR4RnZkcFhSUWx0ZVNNZGYwTTk4bytJ?=
 =?utf-8?B?NnZJNlUwRXlFMWx1cEd4VzgrOTFHYjJ3SlRHc0NoZzdjSk1XQ2RjcU9LYVJz?=
 =?utf-8?B?WkZHaXZjT25KWDh0L2ZmWnN6QXJYbEhSWUtBVW8yTUVkYmZSTVVuTGhNMWlH?=
 =?utf-8?B?Z25hcWVjZWFoNitJaEVLSHp4Zll2enlXc3B3K0RWRnNUNmJtbm5EY0lHSFYr?=
 =?utf-8?B?UnhjSS82WTRqNjViNTYwMlIvaWFNZXQxeXFNV1BzbjV1TnFwNzFuZytIVm9k?=
 =?utf-8?B?dktVd0FLK1o5djVUN0l1SzZIVXVOVnIwT1gvMjJMY0ZWZkFPZ0dzVENYQjEv?=
 =?utf-8?B?QUo0cUZ3Wjk4NUF3am5KeGJiRmp4TVp5RFYxMTdpY2ZHMExXZEEvMndlK01D?=
 =?utf-8?B?aDNQNmI5UVpHRkZyekpmU2RIQTNJeXJUZ3I5bnlMaUtsOVhDR1Ayd3NVS1NM?=
 =?utf-8?B?WmJmdC9SVE1rQklRanBaWk9kUkpJU3o2aU51Qm9pd2JOYy9hdzBDQ0twTk9x?=
 =?utf-8?B?YVdMQT09?=
X-Microsoft-Antispam-Message-Info: WorkgPdDBTLR1Y/qAZrTMq9MatDp4q00/BhuO4NbLFCNfaOGcbJN2mvr+zvln/A/LrRb/cbz7wvWIkOJVJrQaacxvp2xZE729iOR58MmxlEvBtkGr+zLFwj/k0AbjEv64z2LC0947rrG/PE5tJDCh++UbFOi+QCnykYDIccI681zGTRS4epCvzlkh9jmOb1sTcZSTHvHm5anWDg4gLeD6nN4OiAO0cvRPwoEDTx0wifVHVMNZ+ewOMuVBCPC8axieQY3vyL8r7TPRDMgRgneVKz2P8rnukurlu2HnAqDUqdXIWmSokeWm2W8fqKSgObOy4RVtSCr7X/ymiklfWeXeyz4GvyTiNYSwL+3AMahDeA=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1329;6:HkyaP5LMNgl0uviVJsWjOH9gYcZxw36TnwnWcekXLsJvmu1zjHiMzgJmjldNzqz4uh/ciAcowqrfHW22xmndQqnA3C9wdh/vXD4bAtCbUaYkAACq+0Hj1YYbMbDM80kx1WPb9m/UPaJtQdARbDJGxiu2C9MU8FgOfspuJvXym0S7CK5pLcyF7zEps5i0nVfAGu7l2I/kHZl4dXsihrGfRtFIZRgv2awHQ9aypgYGXwDIQyePRk0cnRjZkNRxge9/G72wXP9BTJRguESGNYGgaWOjKVCZqi/3Mm1gjrJEmNCa5WZyzZg5RGs1IqEjF51aakUmqc3uemYEGX1GdW13TfMsp4pWrYCdevcR733lf5524g4ci5kSvE8IkBJfMf/8Kn8+AOURJhbt8Yy8Filf18IaL3pj7tokShyMVo6H9DslHrMZUuWQpllYCI3SJBU5BuHs7Yy2GgLX8RUdB9k9vA==;5:c/Ds54JDsDKGnb1UJtcaazScubVUj1bGpc7Xhw0ta+BQ6qZzVYCKDZA7QKUoxHk1t11Yao2jTuAQ6uQo7EhYVEoH2lH1qZS/2/FhonDzYrLbv3pUVWpJNf0nrUuOzP3LRjaCrF4aS1afoNa2vV+iNud8KN7f4McukeUqFiKUX1o=;24:Wp/5qpEI+iAPtuq6lmJPeG0oQ5CJflQfGopXtguVHWC4QU/iN431vYRVkiHBqKU+qusLUjorHhkW2IVlwnNcZ9krRUo/dhmsrCKD9m/LS/E=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1329;7:tFxhYOnYXov9DHmzyfjihjmj4VqMPBgk8SwhzqRoReLhvaoB2M3nPtdQ5EtvYddyETrCkqH8TaNvbZ4i4IbEX4nM89ABPbf9+BvpWx0Cn7gkwBlJ7WYlkC4o5s8f0ldXvrM8YKNRKErARCHpNB5/DVdsfhtfgzROlmWIlMLvtzz5Y/KUkXtN8W6BojZ930aneJLZmDyltDlaMZpT5oTsJJjUmHbLcXtfo4Kcda45CDl1IaFK/lpY1A1zdf8VqDnf;20:fIlNqHOZykPsE7WVXydVJbnHjMpUzm79mwFt3KvCqoxHgRLWToYkRjsRciSQ+/1SAGig3UBe+MRM949NZI0A0g/7uGB/kslY+U/+D1fpZsrPMVvbfr/UPBahjSGTRZf8zdzHlMYZqQH3PxbLYUtQEAMMEoPXx3jaMy7agRtInOI=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2018 14:53:00.6887 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01cc8ced-867f-4095-be91-08d5dd06d870
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1329
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.06.2018 01:16, Shakeel Butt wrote:
> Currently the kernel accounts the memory for network traffic through
> mem_cgroup_[un]charge_skmem() interface. However the memory accounted
> only includes the truesize of sk_buff which does not include the size of
> sock objects. In our production environment, with opt-out kmem
> accounting, the sock kmem caches (TCP[v6], UDP[v6], RAW[v6], UNIX) are
> among the top most charged kmem caches and consume a significant amount
> of memory which can not be left as system overhead. So, this patch
> converts the kmem caches of all sock objects to SLAB_ACCOUNT.
> 
> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> Suggested-by: Eric Dumazet <edumazet@google.com>

Looks good for me.

Reviewed-by: Kirill Tkhai <ktkhai@virtuozzo.com>

> ---
> Changelog since v1:
> - Instead of specific sock kmem_caches, convert all sock kmem_caches to
>   use SLAB_ACCOUNT.
> 
>  net/core/sock.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/net/core/sock.c b/net/core/sock.c
> index bcc41829a16d..9e8f65585b81 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -3243,7 +3243,8 @@ static int req_prot_init(const struct proto *prot)
>  
>  	rsk_prot->slab = kmem_cache_create(rsk_prot->slab_name,
>  					   rsk_prot->obj_size, 0,
> -					   prot->slab_flags, NULL);
> +					   SLAB_ACCOUNT | prot->slab_flags,
> +					   NULL);
>  
>  	if (!rsk_prot->slab) {
>  		pr_crit("%s: Can't create request sock SLAB cache!\n",
> @@ -3258,7 +3259,8 @@ int proto_register(struct proto *prot, int alloc_slab)
>  	if (alloc_slab) {
>  		prot->slab = kmem_cache_create_usercopy(prot->name,
>  					prot->obj_size, 0,
> -					SLAB_HWCACHE_ALIGN | prot->slab_flags,
> +					SLAB_HWCACHE_ALIGN | SLAB_ACCOUNT |
> +					prot->slab_flags,
>  					prot->useroffset, prot->usersize,
>  					NULL);
>  
> @@ -3281,6 +3283,7 @@ int proto_register(struct proto *prot, int alloc_slab)
>  				kmem_cache_create(prot->twsk_prot->twsk_slab_name,
>  						  prot->twsk_prot->twsk_obj_size,
>  						  0,
> +						  SLAB_ACCOUNT |
>  						  prot->slab_flags,
>  						  NULL);
>  			if (prot->twsk_prot->twsk_slab == NULL)
> 
