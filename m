Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033801AbeEXQkR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 12:40:17 -0400
Received: from mail-ve1eur01on0125.outbound.protection.outlook.com ([104.47.1.125]:20064
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1031968AbeEXQkP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 12:40:15 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=xemul@virtuozzo.com;
Subject: Re: [PATCH] userfaultfd: prevent non-cooperative events vs
 mcopy_atomic races
To: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>, lkml <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrei Vagin <avagin@virtuozzo.com>
References: <1527061324-19949-1-git-send-email-rppt@linux.vnet.ibm.com>
 <0e1ce040-1beb-fd96-683c-1b18eb635fd6@virtuozzo.com>
 <20180524115613.GA16908@rapoport-lnx>
From: Pavel Emelyanov <xemul@virtuozzo.com>
Message-ID: <e42a383f-491a-b42a-347c-effe4b86b982@virtuozzo.com>
Date: Thu, 24 May 2018 19:40:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180524115613.GA16908@rapoport-lnx>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1P191CA0010.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:cf::20)
 To AM6PR08MB2983.eurprd08.prod.outlook.com (2603:10a6:209:44::24)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(2017052603328)(7153060)(7193020);SRVR:AM6PR08MB2983;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB2983;3:ULf8hinfFooI4mOOiEfwH2HHwSkvGpMqz2P57lNK85JKAr9W7o3H/+WWQMDWYjzMCr3yHkPcRzOf9hsbUfhpHZcTqcAxEIR3rrXPE29yFk7Es3hmMEGRFPrOOmgSSyDGBtMyInnAecGfX/gzHtwlenLWff5lxQBgw+sIOsSisB78xT6Jd8G8LA0PgPhWDvVUbJAw6saYxFXWCzsPei7fBvedEccwsMTa9/DLU+UoueMuBd5oqTxG7ymIv4Auldnq;25:aEA96nLiapNKFWck6wmoVbhw4YituJ240BuZEVox98yezmnZ/LQHwf2383+/oKMnuQ8LD6UoyTtFsEpgNXtkbaSxJwS+tY8Xiuqv2iP5NhWjnycVXLCCUQ4sneIJGIrIRvgtTLseIqOsGwZM5CXJoWAjTEmF+eKgVQUJtMKjtmRTAsU7H/y8jBj7b9EORpyBBNXs90UxfBvDE/RKUBtK8jHThsxsIWEJMLq7qNqaR/JWxoM1jBseZHl4WSrITYYF9akE1XR1bdc0PQUSNdXYsS3SJXPwvmzbAHKQDLw7Es6Nm840eJ0UYSGIPiEbiPPv4FcK7CMdNVNbTphgJtKIiw==;31:zDXt47CFG+Y3qw9S9sDqBz5Mb5f10xgNq8w8H9JexD0GNRNlO2THFdNmpEjiGWFB9Y55SauzuIsmNrQh009xHMFsABuJVyHUUdqm6JRPiiUTH/MCBM2n9AD6NEcwXz6nlmPqeJiSCuWgB552rS7Ys+/EOMgvnjvqAC8gKG/LLdYjUjc02/S4bfgIq8fM9qP+knEbX0NuE+cOHeqstJaAdkMaulAoOghemsKT27NlwpA=
X-MS-TrafficTypeDiagnostic: AM6PR08MB2983:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB2983;20:qCty5nVfvMUj3hqMaa750SSImBzrExhpaVykr+TDlXocZCzoc/thWz4OWZYuOoLBUHb6OzAnIfRMVxiYOmLr3NWf5su28NXCAhGWjr3m6LLpRipxEjMUdWzhOiNNq5I5/6U5VoAZ/D6Wv/9szrxX4IBqc0KBV2lmkE1qzCbF3dr++XWprb/EhnApzjUipviRzvBJatql6lHgjr/X9Le23uDyime8iPuuYIV51JW8leiFKE0rd9llPo3Po4R6aYmJfrw6kM4HK23lfln6Yd5frDYY97lJgJFEcKm9NqEcSaQwoNHofzu1yr6Z/WbYw5LWgiCjLmcu7QQbwpWvcmYAnIBf0Wlu5vcGFWLpZmv8F90LPiYsFO/04UEOV2GevYQgicYNeMqSdw8x3vYR7SNb+wHE3a/UP9Q7f4l0eGiVEOd0IG8exXktvHN9lL+07R0NSUIHPy8bhDlTDLTUI7gDVCLH7dNM894Cpb8mOSxXy/1jNXRimztSbd4aCnfz+vOt;4:3LoxGo2ox1mQYfD466JIgBlAu2TCnA5awqQIBLUflRbtVV1djZVyt56+3Uwg4Kvf2vTZSn4RlNheyCFiTmmGXDpK+U48bQh2d2vm9npXwPQtEj/c3LSF2a84WlQctdOW/K3NVsA51Y9J0CbWS+bw/jmJBZWzCHX8oLHMm/9WfZ6WscFJ1oUQ4ycykNHqJBoVq5u3Y+tBXPnhKJrLX/rAsq8a+49EAUvylMLaaPjrVoUt3e9pfKakVCAehUd/zD0VnMb1AMgUXLZrVfXtbJb8vQ==
X-Microsoft-Antispam-PRVS: <AM6PR08MB2983CEFBD98DD50AC285227AB06A0@AM6PR08MB2983.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:AM6PR08MB2983;BCL:0;PCL:0;RULEID:;SRVR:AM6PR08MB2983;
X-Forefront-PRVS: 0682FC00E8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(346002)(376002)(396003)(366004)(39850400004)(39380400002)(189003)(199004)(229853002)(6486002)(25786009)(478600001)(50466002)(107886003)(97736004)(4326008)(6246003)(53936002)(64126003)(54906003)(16576012)(316002)(58126008)(59450400001)(31696002)(26005)(77096007)(6666003)(65806001)(2906002)(66066001)(65956001)(386003)(6916009)(3846002)(6116002)(68736007)(106356001)(31686004)(105586002)(36756003)(8676002)(81156014)(8936002)(81166006)(52116002)(65826007)(52146003)(2486003)(476003)(2616005)(956004)(11346002)(446003)(305945005)(486006)(7736002)(23676004)(5660300001)(230700001)(53546011)(47776003)(16526019)(86362001)(76176011)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR08MB2983;H:[172.16.24.160];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTZQUjA4TUIyOTgzOzIzOnhTZnlqMzQ2RWRURmNXejBPV0lBNVdWNnhz?=
 =?utf-8?B?WVFaV0ROVzlCd21SbkJuak1mZkZIUWpUS2JiRER3c0tRTUVRTUlFd2txNkky?=
 =?utf-8?B?aFYwMWxRZ3ZCRGJLaHNSU0tVRFJvbjkyZUpjVmtRVU5xVkNiMkZyaHJWaUQz?=
 =?utf-8?B?d1J5ZjEySnFodE4xVUZBVXZxbENyTDhWT2o2STRFaTVhanY1WkplVTJsMUVu?=
 =?utf-8?B?bDVHeXZsVTV1OGNPdDM4Q2FKMDFRVFFjQklUNnM0NWNIWEJrYy9rK0I2Tk8v?=
 =?utf-8?B?YVVqekNDLzBzWVNUcnArZHdKWGFBNVh1aTBKTmdKam1GMXN5cG1tbExWQkIw?=
 =?utf-8?B?RkZOSVZkd1BIQmxqNWxhVHVuaDRQRWE3VHp3bWE2R2gwV3B4cEs2Y01jQXJq?=
 =?utf-8?B?cjZXelIrcXU5SzJielRvM2RUSTVnb016K1lvSUkrUWZQV0pTNXhzM2d5TkdX?=
 =?utf-8?B?aWpGelBTdm05RG1TRnJNRkpZOC9nanFZclp5aXVSMThwYzIwaDI3SFphdXE0?=
 =?utf-8?B?S3BTSzQrMmtXb0tnYW1OakNoeWNpOWVFMjhoMVFsRENRYk9uY2NoYU1nS0lQ?=
 =?utf-8?B?UGJHTWN4alFTK25CUnp1ZXliNXRaTUIrdlE2WDZEOEJZUExiUytITHk4QWtk?=
 =?utf-8?B?MnVHeGVVaCsyMnF5RjRsQ240ZTlvZTFqSkZBTys2M3E3MEowczErNTJqQ1Y4?=
 =?utf-8?B?c2JLNlAvR2F0RHJTVktHRWU2d2dBWm5panBpZ2ZMRmpFUVdTL3crUThkOUgx?=
 =?utf-8?B?YjYzOWZIck9zODl3c2hYbXBiWlVlRGpxaitmWGx2YVdWL2M5U05vaUZiTkxY?=
 =?utf-8?B?TS9rNGJsTTVWR3NBZzNHYUl5blpvUStvbG0vMnJtQUNxRnpiZ2plcWNJaW1r?=
 =?utf-8?B?TTZPTWtjYVd2Y08vcVVFbzVLR0ZSZEdpYWo4UDZEVi9TdTdpSDRTK2ZtZW1P?=
 =?utf-8?B?aDhCTkllTHBNdHZKSjFkcXlGMWJsTHErUDlWQ2p6dFI2Q1RvS0N0LzRvbWFC?=
 =?utf-8?B?d0RWOUd1L2FmMTR5VUFQOTNYZ3BJSEpDZksyemVIMUlwZmV5WitieTc0cm8z?=
 =?utf-8?B?WExYYUhxR0Q5aktoQ2QwaVAzTjlST1ZveHJEU09vNEh1TUs4WjFRdm55U2pj?=
 =?utf-8?B?OUVFT3liS3pCUTN6L2wrWUNiaHdtRytvdlZpemkvbzBKVW5CKzd0S0UvY0NZ?=
 =?utf-8?B?K0FWbSsxZXJVdXRreGN0S3lkKzNlQXYzcitUa3ZpanptV0RkUVZqS01wWHBE?=
 =?utf-8?B?dVdVN2YxNkY0eUdnTXltNHJiT3pWbWVsWnhDaFJrdlVCZG9VcC9teTA4Y0Vl?=
 =?utf-8?B?S0VXUmdmSTFwek15MnpYcm1SayswVUxBTGVEMkZmQVFrVmRGY0U0WDJpc3BQ?=
 =?utf-8?B?bmlxaTVFRU1XUU5IU2Zhbk5CaU11SG5QT0NJVC9xdkp5M2lYT2l0dlBWcjYv?=
 =?utf-8?B?WWpVb2VKSUtSdmM1enRnand0aHJVUkkzZFUwaVR3dERtdXAxVWlmcEl4TXVW?=
 =?utf-8?B?TVFOL1JXTVkvMEdhYU1Oa2E0UGprcThUVEEycER3Rzk1cis4UmNUeER4TzV4?=
 =?utf-8?B?b0tmVmQweHZiQnFWSktNZXd2c2FMWTRlcnEzQVAzbDhyRzVVcE5tWCtSOWFi?=
 =?utf-8?B?VWhpKzZCWTMxekNBOFQ4SGJiSVV0QU02WHAxRzh6SWhUeWt0WkdiNzdsUWZW?=
 =?utf-8?B?WG1aNmFZUEJkdVhqY0lsQW5EVE45Vk9laGVyVWFVVFZpOFZ0SlgvQXB1VlQv?=
 =?utf-8?B?VGVIN2poNmRORXVXRE1CTHRjekpkUHI4RXhvWEE1LzJFZHBkZVZjVEp5cGFz?=
 =?utf-8?B?SWtVRVh6VUw1TzlIL1VQdUtKM1ZYaU50NU1LODBWb3JXVFZ1cWFkR0kzWDQ2?=
 =?utf-8?B?VE5BM3cxbHdCUStUSzV5ZEc5cUcydTB0cWJ5QmRBQW9WMWZUa1FsSmcyQmxB?=
 =?utf-8?B?MmphWmhYZ1FUWHZJaStOMnBLTzlCSlZicWw0Sm9heFVVdnp6ZWE5enFDWElp?=
 =?utf-8?B?V245aVNsbnVndVRpNkc5VVdxbzd4L1lWK0U5QT09?=
X-Microsoft-Antispam-Message-Info: aWJh4hPwBFg5or/pnKIcFx4KlQG3aD6q7LO1Urs6atFgSGYXBy7Xvmc8nDxomHYLYVVOMGNJJuoi7x44lhkM1vA0+7CNsOnQ7XV8k+2/Hzat4u60DEBja82GxZHVf/1ELtU8IiiBSaOxM5+TsZegSPny6RTBIeh1FWUO/ModnaVt9cXKrIK2ogR/awUJHfWd
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB2983;6:Bp6vQs5KLFRSKYF86RIzQIpWg17Rb3Dq18Z3gSlOrAnJP8kKaqcFBOuGyxZkqmfnotFW5ZnNtDxHDx4L3o4t2BiHOEI0F2vbg0kM+PhxciO1JI8qVMBqFlUSoVt8z/CqSQ5L/brZoPh5M26jZSe5A0OcMEnhY3Yf3m2JRTXdz1zCLpGjipHoQFydORbOnPikijn+D5LkSyMCYA8OFwy1CvJe/3588CE0UEqbOkaRiGEQ4Cxg8EHBYeSZFoYN24FfA1MICe5DmAVamfak5jzDKg9oo89KFvFM403+z6rGi6vmV5I/WgZGAC1HManm8ngewe1YOOj35QUB2DT2uIMUUWLppGiSS0fqsnb6iU4Sf/qBee/xzrS3Cy6FMfgATn1nrvUiXcjdSjQkb4/PPoo7AvmSCVZn9TQ6PaRqVYSyUosox7ZS/D5H3kfN0r6mSnu+crEeYQfhIjIaObzZkTDt/A==;5:ZPDLYgQApScZ9jYRmEHT53zXY0TXFqgZxJVjwRe8kT5XPgAv4gZItLk4VjtOR7B/r39AoamD6JkOUnuTjdMtD+ZWK70qFLNdRyoDJDeqdqkI9yQccrwI35zcDKmIsHkNKL3N+1DiqIVeo+gn+J9lF7YHlRxxVNUzlJ+b/DSNbJM=;24:eMO+/zg61Qj0OGhYcfxCDLE/AbCCShGu2mPYdQHOftfr7kc2DxSx7uFUUDGQPXLGSqb3gN0fso6YoagBePlKepOP67gJyNDp4q9uj3qeIGA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB2983;7:eN4MV553jfA+0pOfNWKEaDqi8CXKxcpBNoaI+1Tr1l6dCnRCGnHDtSr1/YLdyN4qPk7Q7jnBtAroQ9ylaHeEi7IYH1qu6C/CySyAnYOM6Qu4/mp+NRkRfCe9VZXMlWvU42M1efdaDsk7BaUNKvGQy+SaF5YdrvVcOOPL+d4Z/0FE/ze+wWRWVYhMI3K9PcBMiewYRzLeJeZazL/9BRS8U4PvvH/8fanDJWuPYGHFYIk46AQfCi3CJU8BJxTqkcZX;20:374jGxUoamTiMqFDMQLRhmWgq9FhQ0doR1iOw/rl+VO0jjSEyMKtKgDi9YRa7PZ4GLEFYh72GieGaRYGyaBXmOazk2+mSsMaTfDFI6aRgNmR4MkbLbQByOvHFvpRqlx7jLCo2p5ozN3r0jeyPvR7T5K8djkuMF9F9nWyDd0UEu8=
X-MS-Office365-Filtering-Correlation-Id: fc404747-3f06-49b5-9e31-08d5c1950501
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2018 16:40:11.5448 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc404747-3f06-49b5-9e31-08d5c1950501
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB2983
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/24/2018 02:56 PM, Mike Rapoport wrote:
> On Thu, May 24, 2018 at 02:24:37PM +0300, Pavel Emelyanov wrote:
>> On 05/23/2018 10:42 AM, Mike Rapoport wrote:
>>> If a process monitored with userfaultfd changes it's memory mappings or
>>> forks() at the same time as uffd monitor fills the process memory with
>>> UFFDIO_COPY, the actual creation of page table entries and copying of the
>>> data in mcopy_atomic may happen either before of after the memory mapping
>>> modifications and there is no way for the uffd monitor to maintain
>>> consistent view of the process memory layout.
>>>
>>> For instance, let's consider fork() running in parallel with
>>> userfaultfd_copy():
>>>
>>> process        		         |	uffd monitor
>>> ---------------------------------+------------------------------
>>> fork()        		         | userfaultfd_copy()
>>> ...        		         | ...
>>>     dup_mmap()        	         |     down_read(mmap_sem)
>>>     down_write(mmap_sem)         |     /* create PTEs, copy data */
>>>         dup_uffd()               |     up_read(mmap_sem)
>>>         copy_page_range()        |
>>>         up_write(mmap_sem)       |
>>>         dup_uffd_complete()      |
>>>             /* notify monitor */ |
>>>
>>> If the userfaultfd_copy() takes the mmap_sem first, the new page(s) will be
>>> present by the time copy_page_range() is called and they will appear in the
>>> child's memory mappings. However, if the fork() is the first to take the
>>> mmap_sem, the new pages won't be mapped in the child's address space.
>>
>> But in this case child should get an entry, that emits a message to uffd when step upon!
>> And uffd will just userfaultfd_copy() it again. No?
>  
> There will be a message, indeed. But there is no way for monitor to tell
> whether the pages it copied are present or not in the child.

If there's a message, then they are not present, that's for sure :)

> Since the monitor cannot assume that the process will access all its memory
> it has to copy some pages "in the background". A simple monitor may look
> like:
> 
> 	for (;;) {
> 		wait_for_uffd_events(timeout);
> 		handle_uffd_events();
> 		uffd_copy(some not faulted pages);
> 	}
> 
> Then, if the "background" uffd_copy() races with fork, the pages we've
> copied may be already present in parent's mappings before the call to
> copy_page_range() and may be not.
> 
> If the pages were not present, uffd_copy'ing them again to the child's
> memory would be ok.

Yes.

> But if uffd_copy() was first to catch mmap_sem, and we would uffd_copy them
> again, child process will get memory corruption.

You mean the background uffd_copy()? But doesn't it race even with regular PF handling,
not only the fork? How do we handle this race?

-- Pavel
