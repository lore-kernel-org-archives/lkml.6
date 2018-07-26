Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22985C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 18:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C31FE20857
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 18:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NextfourGroupOy.onmicrosoft.com header.i=@NextfourGroupOy.onmicrosoft.com header.b="YTgcCy+j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C31FE20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nextfour.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731770AbeGZTw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 15:52:27 -0400
Received: from mail-eopbgr60085.outbound.protection.outlook.com ([40.107.6.85]:6134
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730452AbeGZTw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 15:52:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NextfourGroupOy.onmicrosoft.com; s=selector1-nextfour-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHH0ZXQ3yiRfQJP49KKclg7m40oauIwf7Om2Uc/bbBg=;
 b=YTgcCy+jQt5f6gzaaqJMsrMmnOkH5Na9L0bViDfNvTzd1u72G6J3Kp71lHUODlc6UFCMavl+R8OzBcoiS8Ym6RKm3MaCPw/5et7tDWyusHj8Ha47mWx//PhVbyy7LOnWrJ4EfWSj2uuQK0gOIm/3EfyvRzZaBDe5/mK0r8gpX5A=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=mika.penttila@nextfour.com; 
Received: from [IPv6:2001:999:61:8d21:74ba:280b:5456:f7d3]
 (2001:999:61:8d21:74ba:280b:5456:f7d3) by
 VI1PR07MB3344.eurprd07.prod.outlook.com (2603:10a6:802:23::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.12; Thu, 26 Jul 2018 18:34:16 +0000
Subject: Re: [RFC v6 PATCH 2/2] mm: mmap: zap pages with read mmap_sem in
 munmap
To:     Yang Shi <yang.shi@linux.alibaba.com>, mhocko@kernel.org,
        willy@infradead.org, ldufour@linux.vnet.ibm.com,
        kirill@shutemov.name, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1532628614-111702-1-git-send-email-yang.shi@linux.alibaba.com>
 <1532628614-111702-3-git-send-email-yang.shi@linux.alibaba.com>
From:   =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>
Message-ID: <f89abbc5-c907-1f72-495c-318011415697@nextfour.com>
Date:   Thu, 26 Jul 2018 21:34:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1532628614-111702-3-git-send-email-yang.shi@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2001:999:61:8d21:74ba:280b:5456:f7d3]
X-ClientProxiedBy: LO2P265CA0068.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::32) To VI1PR07MB3344.eurprd07.prod.outlook.com
 (2603:10a6:802:23::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: acd93b14-d9e5-4484-d8a7-08d5f3266570
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600073)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR07MB3344;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB3344;3:Uk3gqxQ24KJnzUW5zGhQGsRd1NK166zLkb0w0TShd4AA4cuNjWq6i3GUOYNvvin7lT7v0Ox145brTYRdSf7zn81mL6LpYVQC4g6BkSkaFSi5OoaMs+qtjtNMTZjL1e4Mvkcw4guB1hxH2lfTmJlHfLJ1l42XrvjjTsDA3g8GOpbJGyZHMjNmbZNMNHkjqJj1NIaU/0Pyb9dQ84pF5LJTbZRwcmLIVFfIenHb9gShUT8cEpNBx7oFlhv0N/4suXr0;25:3qHlv0e8gmiUkZ13gBuhZhxoDsi6hunlrK+v94RB4c49Rqz+cXVyj2qiTchTGkXDINgyww3a2sfAggrCOHx8B/gmm7ZcF3auS/SEvjmfYh7XEFuvarT/6ZDqKKt0Uqv0KrNSA1uP9iBm8ZviJjdiZehdVtaaWGhmOTbV7kCQi7WE5He9fD2ohKt1AGlJ4DmlVmhy1wx41EorT+ddynv+y/uN4sTYV4kg0qjhj60vF2E8U5CDhm+F9wl0ck5tzkp1smCH+bF4uCn7HXY7DjMHqZTP90vD8MI3PDP/hzcxHAELaZfjAv14NQt+8ZEaJFrD2wBd7fLzIX8Vt9pmijk7OA==;31:InW+CU+YDa21m/ZteNA9shBESE7IS9RHMXTu3KX0X4WJX+jWuh+Qyzy302QAs0NORZ7QGDKvEMA6Ch7GLqiwi97HEWhHIrND2y5L/K9UFQVElMdtVljAuCjjj9fiXm4ghZaooCHJsM29Xx1gkNyWtXL7BSGhVm1Z8331gihUrmJI9zEfUJptsofvGOONDRasoc09tHIZn5rQZvxlIXE2iGnLTN9ymU2eas75zbwVTw0=
X-MS-TrafficTypeDiagnostic: VI1PR07MB3344:
X-Microsoft-Antispam-PRVS: <VI1PR07MB3344706DDA9B18C1F2022B0C832B0@VI1PR07MB3344.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192374486261705)(104084551191319)(168385556255192);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(2016111802025)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(6043046)(201708071742011)(7699016);SRVR:VI1PR07MB3344;BCL:0;PCL:0;RULEID:;SRVR:VI1PR07MB3344;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB3344;4:mLIgbWIqLZkGPSzSDTwJy4IH07C9rnkl9jN3jDD8F31qU4fN8juoPCpwYGXascKReGadDTOGgNq8MmRMJI8BwxVdHsEO/BM+c37mM3KcF9q1e4Z1lqs9YELr9gyOLNVX2pITPrfc0KYoPRfqJDT/m3vRmgHW4nU7+kBX3trdSo6OjemFN+VzgUC65MsVk+gXWBdO7iHxFMlOWVzi6qZ1sOytCQ/4dzV70pYc8LaWdM3fr5bRA/QXRgpwVLEs4MHAXkcvSmInCt/XSJKzxN0AmyFrJYx/5ALJyjwhasxjqNYhUOCIRlsu3IoCUNQb8CtVkJFc4GM80okQj5L4rBfHXhAiKSRNulrmA1cYkAxQSdNBhghHQ3T+rFudp9aCr+VK
X-Forefront-PRVS: 07459438AA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39830400003)(396003)(136003)(366004)(376002)(346002)(199004)(189003)(476003)(50466002)(25786009)(575784001)(105586002)(64126003)(4326008)(6666003)(31686004)(106356001)(7736002)(8936002)(68736007)(486006)(47776003)(53936002)(11346002)(36756003)(23676004)(86362001)(6486002)(81156014)(76176011)(14444005)(52396003)(229853002)(2616005)(446003)(65956001)(6116002)(966005)(386003)(97736004)(65826007)(305945005)(5660300001)(6306002)(1706002)(58126008)(478600001)(65806001)(186003)(16526019)(316002)(2870700001)(46003)(6246003)(8676002)(2486003)(81166006)(53546011)(2906002)(52146003)(52116002)(31696002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR07MB3344;H:[IPv6:2001:999:61:8d21:74ba:280b:5456:f7d3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nextfour.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA3TUIzMzQ0OzIzOlluakE5aHFEbVM1VGNzZkQ1RXJVb1NibWhD?=
 =?utf-8?B?TlNPMFJKL3d2U1ZpZC9SVUFMaXRuanRrdVpsS0RjelBOQVhERWlZQXpyQk9l?=
 =?utf-8?B?NW4xUzBuNW1YZnJPSkxJamN2bUpzbWRqa1hGdG4rbmFCbXdjV1prUWdJZlNp?=
 =?utf-8?B?UXdsQjJRWi9DMllGR25qK084a0FHdnhNR3dudWUxVTNLaDFGQ2ZLN0EwdzB2?=
 =?utf-8?B?b0JmVW1WeU5LcEtaL0xydExkT1N5Zk41U1pIS1ZaZUJqODArUjliTDVGL2Mx?=
 =?utf-8?B?c3c4Y1orTWtDZ1hlS1lSVEFFK0IxWGpqTVh2c2Y0ZDNSY0ttU2tGSjRLUzUv?=
 =?utf-8?B?RGt4bGtyUXVWbmFSNURRRDF5YmZxK2NJcCsydlVmcFd5Rm1wSzA0R25tc3dK?=
 =?utf-8?B?eGlIZlZlNWdYQVlBcmttN0N5TENva0t6QnlXZXlsWkdpU003U1dMZGI1clBt?=
 =?utf-8?B?NU5qUmNtUVVMclhHM0JVY2EzNVZ1L3pWWnIvR0pTOTIzVXJFNE9ESy93TmJr?=
 =?utf-8?B?ZlRad0dndDJMbTNqMzQvNDM5L2hKMHhHaDhoK0dlaE9WVzN5bFJjREpDN3Ey?=
 =?utf-8?B?c0NYbXA0STNNdktxTlVWUjhiUnFYMjRDMnZ3dnQzckVWRWVDQXdLUXBHaEg5?=
 =?utf-8?B?R2RzU05idzBhQTJUOUdGQ2N5amEzUkpHQnpsN2ZqMlRLTmFEc3NIUVFtYWZT?=
 =?utf-8?B?RUFJWFg0RGZkSHd1ZXIyK1J1dnJQUkZmQnNGS2xmQTJ0MmdYL1FZTGd3UUpP?=
 =?utf-8?B?OGRBMFpOZ2FhL2dyaDNZQnF0T2lSUEJZRkg1dElNZmJQZ20xaHNmYWV3Sm1R?=
 =?utf-8?B?b1RWN3RrOEpmWVBYRWlObllaMWJSL3p4WVhrNStlL0ZnWjVxWnF0KzUrMFU3?=
 =?utf-8?B?aytUeHRIWXlYMVdRazRDQWFlV3NTUTZMQ1pnSWtvbFpqbkFBSHdRYlBWQzdZ?=
 =?utf-8?B?WDl1SlZ4OHBzM0kwSFUrVm8wd051dlFzTmszNUo0Z0ZOVG1acll6SGg0Qncx?=
 =?utf-8?B?T29tRjhMNlRoYzlMTWRJU0lBZGp4U3pxbVA0cWtHdkdxNW1MdldxNUxOR1BP?=
 =?utf-8?B?RmpxdDlwWG1WSmJoMFJFaWJNaU1vTm5kWFJrTUVVdUJNOXNlRGQrZE9STzdr?=
 =?utf-8?B?dllMcFBiUmZwUVVOTXdBQXB4ZjlWMmd0YkNJYXZIOUdVWTV5dGRlYTdPNEt3?=
 =?utf-8?B?d2ZQaW90ekNyQittdHBGNUFwL0xmeEl5dFl4UTlLdkpHeG10SE8zS3pYRm8r?=
 =?utf-8?B?OTdaSEJDWVZldzNRU0lKOVFoMG1iazd6bDZqa3VuQlJ1Mm90OWhYWm9ETlVB?=
 =?utf-8?B?em5oVDUrcTlDalQ1TzhiT29yMVdNNndzTjJudXAyWHE2RWtUWXczMEhVRVdW?=
 =?utf-8?B?bzZPTW9RakloQklqWk5IMzl4aFFpUzJicEVUeWpFaXRrSnpmNzZiKzBTYzdI?=
 =?utf-8?B?a0xZV2hDZVBSRmYwQ2tkK1BmVXE3aVEvT0pURWpVMkJBNVY1YUNpcml0dHhy?=
 =?utf-8?B?b1Vxbi9Xb1NBWXJwbmZZSUNnd01BelhTL2J5TFVBRzN5Z0lOY3RlajhMWFZR?=
 =?utf-8?B?anZaMTgybmk1SUkwejdQNTQ5cFpNaXZxUk02OFVwUmVyVy83WHJ2bFNXYUJL?=
 =?utf-8?B?cVhEQlBiQlZiNzRsMkhvY3NIZ1BpOVJCV2FhZ3I4QWg1d0VJTDVvYktXSnZG?=
 =?utf-8?B?Z0g0U21pbTVrcHo2dk1kb3JFalVVY2p0MHh3akYzMXNUbFY3QVk0SlJZNFg4?=
 =?utf-8?B?QmM1NzMvVHdUZHRWRHVRSlNOaE0vS1pHOERNcWZqbUJVSWpid3FiQS8yRzBt?=
 =?utf-8?B?UW9vV1RmMHliSXJWRitYNDNpMllDalNkbGN2Qk5IdnVGd2ptcnBHUDN1bjdZ?=
 =?utf-8?Q?pKXABBVcLJM=3D?=
X-Microsoft-Antispam-Message-Info: 1SreRzPDZsbFp0uKQXcK35adBO4nVfx7Iw/FLaRKPp8tdL6kFg/KiG4DTFVTllBQzDX37HxoJAKY6GqAE8IfMFXc20lpZT8yLC8FzdEvGTmiCD0KEB0leThf6LdLkfnhMBks4JEErMkVlPIMK2inTC/2RLKJSN2bzhOU2bGeU5tTkr8dKrYgWH46wcQpIGV4XwFZITCYXFcX9xPEFFUfLLIviFB5UsQoztni4QhA6SMo5gfC5NE9ew0iNAaENsC5E5EB/xZ+bdOOo2viqcO4nc1tipsobCAUIU39cgn6kkxWb6SiL9BPhgiC9Z+SVbk0ACNF/lqcQJbMLW/Ach2mpvmS7OL30N2qCKqU6SW/pdo=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB3344;6:PiQVSxBx4yk/KVSy7XxR261ojgt5BeePYX1QmmDHT2ycrlyEierSg89TnaFJt3AOqMV/lNQfnTj36nTdjXMfuFRCptPn4LhuDW2AHTi1CSpPNcsj9KcR1fL8BIUI/Y5El7fBqWsYqCxyvfO0AcMAuaUdcDb8TevYA30Jayb6lbFGsdD33+DuOSpP7P8sftZ8zbaOUi9ddvSOflmHglpItjGyjHJg/tu3GAJSE+b58QOAq/XmngVakHMO/KOzeCNFX8zAb7jcON3RfywM4usQu+N6HNVzFQPU7MMTqjHbKWBUPwvdCKZhUYpSXUKewRkRDKc+F5znxqBvT9ZSTc8wUFburCboO84wOKbol2Sj8rWJduCuUDBTQekrSlKaisuJSVADTihmOzfbz+XCvlwtei6UmtHkZJxqV/pTLXqW3Mli7MvVbNeUpIA9PBOf5eIaKP1KD0r7FwxTAVIsF8t49w==;5:NmMtjj6H/PdogYH5sLc2KotgWnBTzO6o5UVUVLXtfqME6cXB2g7KWN7dpXPzLaeT1yMUX4Lkz8NYYlYqsuAd5wUPvVS/lk2aa0A9dYTNUTXMCCBdps9qt4rWsZmh8bHupXzHwkQ+JKJ9YjJiq44qbX4Y27M0/HbvVSt62gx9+TU=;7:qUDbA7XmIi/uIWyrxA5WJl1pLSHZF35GemnD0DKvvLyBv+5jB2WQOr/AVwqvEQTM++TbKG+cWUAWEeHIoG5I3WqK6SLTf7xMB3FOPJoPSGtYoW/QLFBToEtPpPCYSrpbkorhHrXhMpEHpZp6E0seqrsyKj67FX6AKW3eAX/Gajj8l+Cw7NTLHm4qh4H4LIjflEkVQC7AGud9Z2ycuiKz6JuLB331DrbrciB46UUe6Z+9sVQ8cP0RzqtV770V1YqL
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nextfour.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2018 18:34:16.9327 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acd93b14-d9e5-4484-d8a7-08d5f3266570
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 972e95c2-9290-4a02-8705-4014700ea294
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB3344
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26.07.2018 21:10, Yang Shi wrote:
> When running some mmap/munmap scalability tests with large memory (i.e.
>> 300GB), the below hung task issue may happen occasionally.
> INFO: task ps:14018 blocked for more than 120 seconds.
>        Tainted: G            E 4.9.79-009.ali3000.alios7.x86_64 #1
>  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this
> message.
>  ps              D    0 14018      1 0x00000004
>   ffff885582f84000 ffff885e8682f000 ffff880972943000 ffff885ebf499bc0
>   ffff8828ee120000 ffffc900349bfca8 ffffffff817154d0 0000000000000040
>   00ffffff812f872a ffff885ebf499bc0 024000d000948300 ffff880972943000
>  Call Trace:
>   [<ffffffff817154d0>] ? __schedule+0x250/0x730
>   [<ffffffff817159e6>] schedule+0x36/0x80
>   [<ffffffff81718560>] rwsem_down_read_failed+0xf0/0x150
>   [<ffffffff81390a28>] call_rwsem_down_read_failed+0x18/0x30
>   [<ffffffff81717db0>] down_read+0x20/0x40
>   [<ffffffff812b9439>] proc_pid_cmdline_read+0xd9/0x4e0
>   [<ffffffff81253c95>] ? do_filp_open+0xa5/0x100
>   [<ffffffff81241d87>] __vfs_read+0x37/0x150
>   [<ffffffff812f824b>] ? security_file_permission+0x9b/0xc0
>   [<ffffffff81242266>] vfs_read+0x96/0x130
>   [<ffffffff812437b5>] SyS_read+0x55/0xc0
>   [<ffffffff8171a6da>] entry_SYSCALL_64_fastpath+0x1a/0xc5
>
> It is because munmap holds mmap_sem exclusively from very beginning to
> all the way down to the end, and doesn't release it in the middle. When
> unmapping large mapping, it may take long time (take ~18 seconds to
> unmap 320GB mapping with every single page mapped on an idle machine).
>
> Zapping pages is the most time consuming part, according to the
> suggestion from Michal Hocko [1], zapping pages can be done with holding
> read mmap_sem, like what MADV_DONTNEED does. Then re-acquire write
> mmap_sem to cleanup vmas.
>
> But, some part may need write mmap_sem, for example, vma splitting. So,
> the design is as follows:
>         acquire write mmap_sem
>         lookup vmas (find and split vmas)
> 	detach vmas
>         deal with special mappings
>         downgrade_write
>
>         zap pages
> 	free page tables
>         release mmap_sem
>
> The vm events with read mmap_sem may come in during page zapping, but
> since vmas have been detached before, they, i.e. page fault, gup, etc,
> will not be able to find valid vma, then just return SIGSEGV or -EFAULT
> as expected.
>
> If the vma has VM_LOCKED | VM_HUGETLB | VM_PFNMAP or uprobe, they are
> considered as special mappings. They will be dealt with before zapping
> pages with write mmap_sem held. Basically, just update vm_flags.
>
> And, since they are also manipulated by unmap_single_vma() which is
> called by unmap_vma() with read mmap_sem held in this case, to
> prevent from updating vm_flags in read critical section, a new
> parameter, called "skip_flags" is added to unmap_region(), unmap_vmas()
> and unmap_single_vma(). If it is true, then just skip unmap those
> special mappings. Currently, the only place which pass true to this
> parameter is us.
>
> With this approach we don't have to re-acquire mmap_sem again to clean
> up vmas to avoid race window which might get the address space changed.
>
> And, since the lock acquire/release cost is managed to the minimum and
> almost as same as before, the optimization could be extended to any size
> of mapping without incurring significant penalty to small mappings.
>
> For the time being, just do this in munmap syscall path. Other
> vm_munmap() or do_munmap() call sites (i.e mmap, mremap, etc) remain
> intact for stability reason.
>
> With the patches, exclusive mmap_sem hold time when munmap a 80GB
> address space on a machine with 32 cores of E5-2680 @ 2.70GHz dropped to
> us level from second.
>
> munmap_test-15002 [008]   594.380138: funcgraph_entry: |  vm_munmap_zap_rlock() {
> munmap_test-15002 [008]   594.380146: funcgraph_entry:      !2485684 us |    unmap_region();
> munmap_test-15002 [008]   596.865836: funcgraph_exit:       !2485692 us |  }
>
> Here the excution time of unmap_region() is used to evaluate the time of
> holding read mmap_sem, then the remaining time is used with holding
> exclusive lock.
>
> [1] https://lwn.net/Articles/753269/
>
> Suggested-by: Michal Hocko <mhocko@kernel.org>
> Suggested-by: Kirill A. Shutemov <kirill@shutemov.name>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Laurent Dufour <ldufour@linux.vnet.ibm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> ---
>  include/linux/mm.h |  2 +-
>  mm/memory.c        | 41 ++++++++++++++++------
>  mm/mmap.c          | 99 +++++++++++++++++++++++++++++++++++++++++++++++++-----
>  3 files changed, 123 insertions(+), 19 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index a0fbb9f..e4480d8 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1321,7 +1321,7 @@ void zap_vma_ptes(struct vm_area_struct *vma, unsigned long address,
>  void zap_page_range(struct vm_area_struct *vma, unsigned long address,
>  		    unsigned long size);
>  void unmap_vmas(struct mmu_gather *tlb, struct vm_area_struct *start_vma,
> -		unsigned long start, unsigned long end);
> +		unsigned long start, unsigned long end, bool skip_vm_flags);
>  
>  /**
>   * mm_walk - callbacks for walk_page_range
> diff --git a/mm/memory.c b/mm/memory.c
> index 7206a63..6a772bd 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1514,7 +1514,7 @@ void unmap_page_range(struct mmu_gather *tlb,
>  static void unmap_single_vma(struct mmu_gather *tlb,
>  		struct vm_area_struct *vma, unsigned long start_addr,
>  		unsigned long end_addr,
> -		struct zap_details *details)
> +		struct zap_details *details, bool skip_vm_flags)
>  {
>  	unsigned long start = max(vma->vm_start, start_addr);
>  	unsigned long end;
> @@ -1525,11 +1525,19 @@ static void unmap_single_vma(struct mmu_gather *tlb,
>  	if (end <= vma->vm_start)
>  		return;
>  
> -	if (vma->vm_file)
> -		uprobe_munmap(vma, start, end);
> +	/*
> +	 * Since unmap_single_vma might be called with read mmap_sem held
> +	 * in munmap optimization, so vm_flags can't be updated in this case.
> +	 * They have been updated before this call with write mmap_sem held.
> +	 * Here if skip_vm_flags is true, just skip the update.
> +	 */
> +	if (!skip_vm_flags) {
> +		if (vma->vm_file)
> +			uprobe_munmap(vma, start, end);
>  
> -	if (unlikely(vma->vm_flags & VM_PFNMAP))
> -		untrack_pfn(vma, 0, 0);
> +		if (unlikely(vma->vm_flags & VM_PFNMAP))
> +			untrack_pfn(vma, 0, 0);
> +	}
>  
>  	if (start != end) {
>  		if (unlikely(is_vm_hugetlb_page(vma))) {
> @@ -1546,7 +1554,19 @@ static void unmap_single_vma(struct mmu_gather *tlb,
>  			 */
>  			if (vma->vm_file) {
>  				i_mmap_lock_write(vma->vm_file->f_mapping);
> -				__unmap_hugepage_range_final(tlb, vma, start, end, NULL);
> +				if (!skip_vm_flags) {

Should that be :
	if (skip_vm_flags) {
instead?
 

> +					/*
> +					 * The vma is being unmapped with read
> +					 * mmap_sem.
> +					 * Can't update vm_flags here, it has
> +					 * been updated before this call with
> +					 * write mmap_sem held.
> +					 */
> +					__unmap_hugepage_range(tlb, vma, start,
> +							end, NULL);
> +				} else
> +					__unmap_hugepage_range_final(tlb, vma,
> +							start, end, NULL);
>  				i_mmap_unlock_write(vma->vm_file->f_mapping);
>  			}
>  		} else
>
--Mika

