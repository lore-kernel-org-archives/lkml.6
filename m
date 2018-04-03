Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755466AbeDCLnF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 07:43:05 -0400
Received: from mail-he1eur01on0136.outbound.protection.outlook.com ([104.47.0.136]:23317
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755135AbeDCLnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 07:43:03 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: Re: possible deadlock in skb_queue_tail
To: Dmitry Vyukov <dvyukov@google.com>, Ingo Molnar <mingo@kernel.org>
Cc: syzbot <syzbot+6b495100f17ca8554ab9@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>,
        David Herrmann <dh.herrmann@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        David Windsor <dwindsor@gmail.com>, elena.reshetova@intel.com,
        ishkamiel@gmail.com, Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, matthew@mjdsystems.ca,
        Mateusz Jurczyk <mjurczyk@google.com>, netdev <netdev@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com, Al Viro <viro@zeniv.linux.org.uk>,
        xemul@virtuozzo.com
References: <0000000000003584570568da18dd@google.com>
 <06c79d3f-3f28-7f1e-9431-66c18149c9e6@virtuozzo.com>
 <CACT4Y+Zb4Y1=H8Vtd1d+ULKu-P3ftud=SgFqSAfu9SE6Lu3LMA@mail.gmail.com>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <0eb5ed24-012a-89c9-bac9-796a0276221a@virtuozzo.com>
Date: Tue, 3 Apr 2018 14:42:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+Zb4Y1=H8Vtd1d+ULKu-P3ftud=SgFqSAfu9SE6Lu3LMA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0402CA0002.eurprd04.prod.outlook.com
 (2603:10a6:3:d0::12) To HE1PR0801MB1338.eurprd08.prod.outlook.com
 (2603:10a6:3:39::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46ac9ea0-5960-4020-76af-08d599580b81
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1338;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;3:qoMrDXlTgvOA/ok4vmbylSp6dWzWusqK7bxFDR+FvmbS6/ZBwn8rZ9MNI/dnzj65bnWlCEwoGTHPuzN7i7WfLbuGkexASJapA1Y+v6dcTIrXbPNnlWRx9Pgnm1xqfIiGvSJpPHZzpC9eFvhS0/ysFTZqZLubg4QgjMVeWScMN43IYRNu/xJiWDqEGpe4aiWI0Adx7gBgPB1lKaRIUirRumnYDiyndGPEO67rdhYOaUCX3TTE+lIF0nTHLtCDv8N6;25:Bi+oPgmfHE1F14tdIfl+KRgNUnqNvjmTFpEJQs3T9ETBq9OmWQKpPUulT1gsebrV4R2nUOMxCX75s/QvigVjS2/kQFFlk//zeZT2eAKXKd/lCBGT95qcHVQz00ZHmQDt4j/0xq/mGGXxkAhh/CqHOSVvDSSBsosO8ENMAopeC5DvPnsGFerma4VOEmKCJ72er+00wocxsVb7CupMkN5DJKuxk24sCnOJqW2FZ2bg8g8GmeKynZrwVF/I/l5d+vvURswV6YIiO53Rx1Hh4Dm1hAi2G0rZlo0dQuxeSkS3M9WvnUnIRktLqiftCYktvR1jcuMwhxHoL7PQ0pZ0E2aDHQ==;31:YAss3WBi05YakSlR5KlOLyQQ2Urr3luMzo7RatoJNd0Co7GLUmMctyRwggnLWdAcu/9oeRrAiimiOQdmHIgeUYdwTMmGGEmfo4xUxZHZO5m1OBBWiCQgU6zDOgnJcntv1UfQRJUXE6sseoUI2hbRQgtraDKnOeFVp3GPcjnWIq3PL4mQ83jl2lavziaE4EkSgZgHWja8pE5VcUsRYoovZeRfTEdtwJ/rdxpSUmEPp+Q=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1338:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;20:qG8PchOSlJm4dx7LWiOghI6YQbGxWnras6X4Q/Ce0v4bEAbI4ZV6hg8Bo9R57UXFXlmtEeO6J2iDfloMsQvdFZvIjJ1vU2D3WaAvfzZKU2yb7TRsKqlq18xk9yV/jTN9vDyQy1EEVaqaOMOA8LQqB2mqaFOF0CzqhBXt805zyi2wRrCgL+CQk3Mg0oB/VRtvurypBEasS5G/WN6V3WvRIDDY4Wuk2FYJLQ6QZglN9vWmejT3er5IkBiuT6+IeB0lHdVF+/FlA/PK3/VyouOX3vyahIcJGRzcpjRJjIAReNIpOitalHizTq7dqqzdxEg4ISccv7vaFxtOxj44RK3mIn0bHwHDaE2KRtPP6zBVJ050t4QujkDY4/MK7VQ/9vbWAaHCoJ0KunEg7oty9rnHdrqNIGH1k73LLNhoQkVKkR7QpuY+/wcnNe1iMtGvzeV79RFKuzJOneTele7IbGzRGmN5fJYR1BHt2LZUfDZJNQ/OIj1zdEGj2RhKI6l8UyrM;4:nVLXfCwCYKcOyspWg9H2eezMKNC4EkmwrRFf+F2KgSGxVBL2Bj+lWH2WX2hNzBZyt+O7csWXg3cuYspws59lhezjGKDsSIPKW1OHXYRTwIHG8dgRT1oaeTXPjNU4dGGVLk8kqRJpk5rajXwXtm4gRPouDRC9V8eILWZZ2J96vjXMXsIB+nM6sBYHDgDB9pc4AKmohjIyB6MFw0dSID+tIyDy8Ea3srqOHJnb7yQJbagrNZVxH3pNpi72WB8JMjw23iv6/LeQt1+4CakMrh+yJVe0vzRMspeYroTK8nh2YhQJmWLwpOGf0hUsfz4eczqE4TVvv1+Uas3obCAQekkw2vF7DiuPi7CeY5gxXhknTW5cSB0BARGhImX2CPG9U3WP
X-Microsoft-Antispam-PRVS: <HE1PR0801MB13389C8DE0A859457E09B350CDA50@HE1PR0801MB1338.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(228788266533470)(148501403981450)(211936372134217);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231221)(944501327)(52105095)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:HE1PR0801MB1338;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1338;
X-Forefront-PRVS: 0631F0BC3D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(366004)(376002)(396003)(39380400002)(39840400004)(346002)(199004)(189003)(57704003)(52116002)(77096007)(105586002)(76176011)(2486003)(107886003)(68736007)(106356001)(65806001)(31686004)(23676004)(47776003)(31696002)(229853002)(110136005)(58126008)(66066001)(65956001)(54906003)(52146003)(316002)(16526019)(50466002)(16576012)(26005)(2906002)(7736002)(6666003)(575784001)(305945005)(86362001)(6116002)(3846002)(476003)(65826007)(486005)(39060400002)(11609785009)(25786009)(36756003)(486005)(11346002)(446003)(4326008)(5660300001)(97736004)(7416002)(53936002)(6306002)(8936002)(386003)(230700001)(59450400001)(53546011)(81166006)(6486002)(81156014)(6246003)(8676002)(64126003)(956004)(966005)(478600001)(2616005)(99710200001);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1338;H:[172.16.25.196];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzg7MjM6TWJ4WnNJaXFlNEhsQkVsSW5xNGhVVnBX?=
 =?utf-8?B?bEh2VVpCTDVsMldiMW5qL0lvTWp1ME1ZRkdxSlNsa0p5L1R2SFNoLzlaS1Qw?=
 =?utf-8?B?c1NKa3RDNnpvQ1V4anE1dm1MRXFBNUM4QjVSL3RsYXNreTRLdGkrMDFRSlVJ?=
 =?utf-8?B?UGpXQnUyMXZUeWwxaU5ScHlNd3dQQVNmL0Qwb0xNeUdIWEFWYzlnMFVhYXJh?=
 =?utf-8?B?ZGVsZTdzUXNrbEZLMUEyeE5DRzNBdUJNa1ExUkM4Qm9aRnNPTFZyTFpHOEpw?=
 =?utf-8?B?YlAvcVljUVlhKzNVZEpEVnI3V2FJVk5XYUFJRXEzQ3lKOUNrS29ZR25ERnpN?=
 =?utf-8?B?Nmk3a3FCbmJNOUNsTVFhWW5ReGVNQmFaZXUyUXVTYXhmOEpKdXhWZ0xNSnJv?=
 =?utf-8?B?dFlweEEzeVNVbVhaeFR5VERMZXB1d1REU0w5VnRTWFUzb1pBTFRiVnZ6c2hu?=
 =?utf-8?B?cEYyRDg3bDh4dlMyeU0rQjRwS2wxYnZQQmVROTJ5WStoaWNwOGNyTWdTUUhT?=
 =?utf-8?B?VDNhajJQZnhjMkJ6YitWTFlETHNUQWs2ZFZEV2I3SU5tdFowK2Nycmp5UjlJ?=
 =?utf-8?B?NUhJa09DS2JPR2NkZ0Q0QmRReDBQVTh3WmtBTHVYZ1gxYWtCanExTlhaMkJR?=
 =?utf-8?B?ZEp3MTAvWmJaYmJoUFNwMWpGUzJ6d2M4aUtsd0dTN1c4MzJBYW03ZEtua3F2?=
 =?utf-8?B?NGZEQm5Ud3lyMkg1c3Z5RG5ObGQ0WjZIYUwzZHVFaUs2OUh0cFR4S04zN2gr?=
 =?utf-8?B?ajYwQ25ZRGJWMTJTSkpjL05HR09oN041NTdXU2hMcDJJZUk1aEhSdTNTdXFI?=
 =?utf-8?B?RUIxRnhCNmhkcGpQcG5vRDZxRXgvZXlJbEU3a2xGOXNCRVJJVWhEaXdmZEU0?=
 =?utf-8?B?dzFZNEtwaHRtR0cyUVFiNGN3c0pZNG5vTUpnWDJUeXBOWTlXQkxhYnNZL2ly?=
 =?utf-8?B?YnExVmtRUEFzelY4aDJPUURDMWNaa2FXTEZVMG0xZnBBdXNNczRlV1U5T0hG?=
 =?utf-8?B?MFhUUXJ0c1V0bjF0bkdBMWNybE5ab1A5NzlZVWtqQXdJQW8vYzdFMTlDMi9z?=
 =?utf-8?B?cHFFY1NhYlc5MVlvQzhTUGNYT0lxVG9Zd3VFNWpsT25IQ2tvMHQ3Q3hsNS9r?=
 =?utf-8?B?UXFiWnVmN0U4bmFsYnBTN0ZRTElnWFozdTZPNFl0Ry9MeHQyTGFhdEFlOXFB?=
 =?utf-8?B?alVtUDE3MkJuK2t4Sy9jYUkrQVN4NWdUb2R4THl4dHZSanZVT2RleGNJM0h4?=
 =?utf-8?B?dHlGaXRwbVUxc1YvUEUzZ0lKM2cxNzVXeHVwWHFPRkpDQWJ0enlJM0hwWm8y?=
 =?utf-8?B?WjVTS3RsUGMvc2p6N2RHTGFwWVVtSWFVWVBUQkUrcTNVbTJFWGJoandNSkdI?=
 =?utf-8?B?SjVrNnRyTVpYay9QcnZyVzVsWDNnSkpacFBocnBlUGxTQi93STFORXN1N21v?=
 =?utf-8?B?TFQ1S0E0MmE3MlRqZkNhdDRRUmRpcTV0NjNTVDR6c0ZkZEJtSmErckpRd3JT?=
 =?utf-8?B?dld2WXEwai8wd0FhUCtwbkpkTFlWTzJwZHFOSURoYmI2VVEwVEVyaFBIcFN2?=
 =?utf-8?B?Z2lCcVBTTG55c0l3VjdMNFBvU2U3ZFFsUkkySXdWcFdqdVdYM0xvUENWeDZT?=
 =?utf-8?B?MzVwWHc3S2tTaEszM09DYUpqWEEwM285WGE3UVR3emNKY2p2SHd0eWxWTXMr?=
 =?utf-8?B?dHZCWmNGeGpzUHhPS2ZRRytYSE5EWnNIendqMlpGcFRmeGhZRkNxdkJUZlpL?=
 =?utf-8?B?cVd0dEpjeUVDb2dZL1lpOTRTSFlZTzQrSk9uN01jWFhkMFBGNDErbHg2WFpx?=
 =?utf-8?B?bGlZQXkrZGNHU3VocWJST1JLUklna3NhQnhwTUo5RENEbnBvL1Z0aFl1MjND?=
 =?utf-8?B?TnUwT09ocm5LQVR5eURyZUJyNWphTnJYaHZlbWVTWGtmNnB5b3M4RGgwRm9S?=
 =?utf-8?B?SkRaWUJwdXhFc01ScjlZYkVDY2g0bzZKQ2JGN0c5TkxvVDdVK2RtdU8yMW9E?=
 =?utf-8?B?bFByb1kwTUZ5aVNTT244a0VBWmZNbjlNdlJHbDFCeUJ4RjdrcjJhaUhMMG5l?=
 =?utf-8?B?cC9xNTRyQWM5ZSswYkt4Sk9oSVBhZ1N2clVzNjVoVldvRmNtN01naVcyR3pu?=
 =?utf-8?B?c0VKR0hmOTdYMUZsOUJNK3p0UGlsUUorNHlwVHRvc2VuS0NiYWI4b3J1U05k?=
 =?utf-8?B?M0xHN24vY3NQc2MvV2ZLaXBvQ2Rpc1RKZ0s2ZVBUM2ZMVEFFN09TcER3Z2ls?=
 =?utf-8?Q?3mQgOWtTfdM9yTO1zHqz?=
X-Microsoft-Antispam-Message-Info: smdAlPLFJDBlsNr+ygjcGHuw8JpCAdck+OmnpmME7ps08eJSiTtmQWzkOC/ltG5+9Xf9Hp4U57S4otwOoW1ZdKvDT2Uy5yRTMiCr3qORthblbrPA+ACBO3lJDxqsbY6U55Rj0n8Y1fsHRpWJ0cNJKgbZBz7UaW9cyk+phHrOEBUKV/Ehv2GODT1UiN1SY19j
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;6:87WiqTXDccCH7B+ySZ9jfEa3/4EUT3dHC6zqKHqIYLyP8Foxl6yb28Z03JRo8iMzbNfwnt3IAiKlvuLlgmF2FJnD6i9kpTfjZkHVrGIEVqyJEBlG9k6S4/8ciQ1e3RdECq8yVirBCyDI5+ZXLPrzYHQb3/cxCojevVqaIT3L6Ga0SGG9jQS2esXM5NjG2KqE/sXvym+p1lKKswwi6bQItLRTm49PYmKE8oQ0+N8vTmOZNyOL0IQpHXN4Bi2PPePZfsgeAI8OKIgAKNOR2CUkgj9ioZE8Ey/3dS/mKezv1QPhSk4/YKELFBl0/FxsKUuyz/a+M0HUzTwdv0Y6Dezg5CHsCXbVZ6ShoDaSxWNxKwdKG/S86vuVyCbkFLopHmm9EL5y5u9fXoftPFNIOodpaKmYGDXFjwGDu3KB/5ot9JOYvC96q8gaJ4DzWXXEmX8PnpN7naoDnmsVZyf2hcG6rQ==;5:921OL8zV39pwVy+8qSA11jB3zTOBL2uBOVh9ufc5lV+UmVHWXUePrzmFOhTNC0FUmznomvmxVYvNQQnSxgaE1OCdbu/EqaUkoe8Ibh9VitY9UilLFAEyk2nQCbdFovbLkhz/EawYHORTotLDynIoYlp6JRDG4v85h+ofX9P0zZI=;24:WKlAFUFK7yCskTKmNx4du8MRKD9cKb7t06dVz1eU2bbAj6hUXII73Is7e2Flv/96YbkQ0TfuKNRIr5a1TNOaD2x3i40/atZob7EfauPvDs8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;7:HqCxj61CV4auitjhjLp7JVLX17qssFDqNK3x13/w1chsdweRNrsJaBbOob5Wp7mBQ9kbydNE6qSUpJScDJV29e0htrm3346rs+DzJq9wmFuKcwpVPwEOFPI/g3QP8tVpICujfWuT78KSgma5civ5zHzpf8PYF40ScnDkXXpYzEawNvznnSFCQv/WqqqQlu24uaeScz7S5AGterpLjzNyRvnM7lhJAeLT3GrU+kUit0EBgKauY3lkE8ifncaK1dyj;20:YRyzIC4jM2vUslp85eummGusR7/ZiZC0SgsEamckUJP59acfHEpxbin5bZ3viskAe+Z0HWdZWvg6bsN8bGtY8KQoO4G92XjguboJnBsVj0aurlvN9Tp1vghLulmJE65SfGiEtf8aU2Rna0+m62a+UerKCpohL9aAqwwCBEjnCI4=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2018 11:42:56.5592 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46ac9ea0-5960-4020-76af-08d599580b81
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1338
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.04.2018 14:25, Dmitry Vyukov wrote:
> On Tue, Apr 3, 2018 at 11:50 AM, Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>> On 02.04.2018 12:20, syzbot wrote:
>>> Hello,
>>>
>>> syzbot hit the following crash on net-next commit
>>> 06b19fe9a6df7aaa423cd8404ebe5ac9ec4b2960 (Sun Apr 1 03:37:33 2018 +0000)
>>> Merge branch 'chelsio-inline-tls'
>>> syzbot dashboard link: https://syzkaller.appspot.com/bug?extid=6b495100f17ca8554ab9
>>>
>>> Unfortunately, I don't have any reproducer for this crash yet.
>>> Raw console output: https://syzkaller.appspot.com/x/log.txt?id=6218830443446272
>>> Kernel config: https://syzkaller.appspot.com/x/.config?id=3327544840960562528
>>> compiler: gcc (GCC) 7.1.1 20170620
>>>
>>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>>> Reported-by: syzbot+6b495100f17ca8554ab9@syzkaller.appspotmail.com
>>> It will help syzbot understand when the bug is fixed. See footer for details.
>>> If you forward the report, please keep this part and the footer.
>>>
>>>
>>> ======================================================
>>> WARNING: possible circular locking dependency detected
>>> 4.16.0-rc6+ #290 Not tainted
>>> ------------------------------------------------------
>>> syz-executor7/20971 is trying to acquire lock:
>>>  (&af_unix_sk_receive_queue_lock_key){+.+.}, at: [<00000000271ef0d8>] skb_queue_tail+0x26/0x150 net/core/skbuff.c:2899
>>>
>>> but task is already holding lock:
>>>  (&(&u->lock)->rlock/1){+.+.}, at: [<000000004e725e14>] unix_state_double_lock+0x7b/0xb0 net/unix/af_unix.c:1088
>>>
>>> which lock already depends on the new lock.
>>>
>>>
>>> the existing dependency chain (in reverse order) is:
>>>
>>> -> #1 (&(&u->lock)->rlock/1){+.+.}:
>>>        _raw_spin_lock_nested+0x28/0x40 kernel/locking/spinlock.c:354
>>>        sk_diag_dump_icons net/unix/diag.c:82 [inline]
>>>        sk_diag_fill.isra.4+0xa52/0xfe0 net/unix/diag.c:144
>>>        sk_diag_dump net/unix/diag.c:178 [inline]
>>>        unix_diag_dump+0x400/0x4f0 net/unix/diag.c:206
>>>        netlink_dump+0x492/0xcf0 net/netlink/af_netlink.c:2221
>>>        __netlink_dump_start+0x4ec/0x710 net/netlink/af_netlink.c:2318
>>>        netlink_dump_start include/linux/netlink.h:214 [inline]
>>>        unix_diag_handler_dump+0x3e7/0x750 net/unix/diag.c:307
>>>        __sock_diag_cmd net/core/sock_diag.c:230 [inline]
>>>        sock_diag_rcv_msg+0x204/0x360 net/core/sock_diag.c:261
>>>        netlink_rcv_skb+0x14b/0x380 net/netlink/af_netlink.c:2443
>>>        sock_diag_rcv+0x2a/0x40 net/core/sock_diag.c:272
>>>        netlink_unicast_kernel net/netlink/af_netlink.c:1307 [inline]
>>>        netlink_unicast+0x4c4/0x6b0 net/netlink/af_netlink.c:1333
>>>        netlink_sendmsg+0xa4a/0xe80 net/netlink/af_netlink.c:1896
>>>        sock_sendmsg_nosec net/socket.c:629 [inline]
>>>        sock_sendmsg+0xca/0x110 net/socket.c:639
>>>        sock_write_iter+0x31a/0x5d0 net/socket.c:908
>>>        call_write_iter include/linux/fs.h:1782 [inline]
>>>        new_sync_write fs/read_write.c:469 [inline]
>>>        __vfs_write+0x684/0x970 fs/read_write.c:482
>>>        vfs_write+0x189/0x510 fs/read_write.c:544
>>>        SYSC_write fs/read_write.c:589 [inline]
>>>        SyS_write+0xef/0x220 fs/read_write.c:581
>>>        do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
>>>        entry_SYSCALL_64_after_hwframe+0x42/0xb7
>>>
>>> -> #0 (&af_unix_sk_receive_queue_lock_key){+.+.}:
>>>        lock_acquire+0x1d5/0x580 kernel/locking/lockdep.c:3920
>>>        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>>>        _raw_spin_lock_irqsave+0x96/0xc0 kernel/locking/spinlock.c:152
>>>        skb_queue_tail+0x26/0x150 net/core/skbuff.c:2899
>>>        unix_dgram_sendmsg+0xa30/0x1610 net/unix/af_unix.c:1807
>>>        sock_sendmsg_nosec net/socket.c:629 [inline]
>>>        sock_sendmsg+0xca/0x110 net/socket.c:639
>>>        ___sys_sendmsg+0x320/0x8b0 net/socket.c:2047
>>>        __sys_sendmmsg+0x1ee/0x620 net/socket.c:2137
>>>        SYSC_sendmmsg net/socket.c:2168 [inline]
>>>        SyS_sendmmsg+0x35/0x60 net/socket.c:2163
>>>        do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
>>>        entry_SYSCALL_64_after_hwframe+0x42/0xb7
>>
>> sk_diag_dump_icons() dumps only sockets in TCP_LISTEN state.
>> TCP_LISTEN state may be assigned in only place in net/unix/af_unix.c:
>> it's unix_listen(). The function is applied to stream and seqpacket
>> socket types.
>>
>> It can't be stream because of the second stack, and seqpacket also can't,
>> as I don't think it's possible for gcc to inline unix_seqpacket_sendmsg()
>> in the way, we don't see it in the stack.
>>
>> So, this is looks like false positive result for me.
>>
>> Kirill
> 
> Do you mean that these &(&u->lock)->rlock/1 referenced in 2 stacks are
> always different?

In these 2 particular stacks they have to be different.

But we may meet another stacks, where stream or seqpacket
functions are used instead of unix_dgram_sendmsg(), and
they may be true positive.

Kirill
 
> +Ingo for lockdep false positive
> Do we need some kind of annotation here?
> 
> 
>>> other info that might help us debug this:
>>>
>>>  Possible unsafe locking scenario:
>>>
>>>        CPU0                    CPU1
>>>        ----                    ----
>>>   lock(&(&u->lock)->rlock/1);
>>>                                lock(&af_unix_sk_receive_queue_lock_key);
>>>                                lock(&(&u->lock)->rlock/1);
>>>   lock(&af_unix_sk_receive_queue_lock_key);
>>>
>>>  *** DEADLOCK ***
>>>
>>> 1 lock held by syz-executor7/20971:
>>>  #0:  (&(&u->lock)->rlock/1){+.+.}, at: [<000000004e725e14>] unix_state_double_lock+0x7b/0xb0 net/unix/af_unix.c:1088
>>>
>>> stack backtrace:
>>> CPU: 0 PID: 20971 Comm: syz-executor7 Not tainted 4.16.0-rc6+ #290
>>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
>>> Call Trace:
>>>  __dump_stack lib/dump_stack.c:17 [inline]
>>>  dump_stack+0x194/0x24d lib/dump_stack.c:53
>>>  print_circular_bug.isra.38+0x2cd/0x2dc kernel/locking/lockdep.c:1223
>>>  check_prev_add kernel/locking/lockdep.c:1863 [inline]
>>>  check_prevs_add kernel/locking/lockdep.c:1976 [inline]
>>>  validate_chain kernel/locking/lockdep.c:2417 [inline]
>>>  __lock_acquire+0x30a8/0x3e00 kernel/locking/lockdep.c:3431
>>>  lock_acquire+0x1d5/0x580 kernel/locking/lockdep.c:3920
>>>  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>>>  _raw_spin_lock_irqsave+0x96/0xc0 kernel/locking/spinlock.c:152
>>>  skb_queue_tail+0x26/0x150 net/core/skbuff.c:2899
>>>  unix_dgram_sendmsg+0xa30/0x1610 net/unix/af_unix.c:1807
>>>  sock_sendmsg_nosec net/socket.c:629 [inline]
>>>  sock_sendmsg+0xca/0x110 net/socket.c:639
>>>  ___sys_sendmsg+0x320/0x8b0 net/socket.c:2047
>>>  __sys_sendmmsg+0x1ee/0x620 net/socket.c:2137
>>>  SYSC_sendmmsg net/socket.c:2168 [inline]
>>>  SyS_sendmmsg+0x35/0x60 net/socket.c:2163
>>>  do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
>>>  entry_SYSCALL_64_after_hwframe+0x42/0xb7
>>> RIP: 0033:0x455269
>>> RSP: 002b:00007f71ffad6c68 EFLAGS: 00000246 ORIG_RAX: 0000000000000133
>>> RAX: ffffffffffffffda RBX: 00007f71ffad76d4 RCX: 0000000000455269
>>> RDX: 04924924924924f4 RSI: 0000000020000200 RDI: 0000000000000016
>>> RBP: 000000000072bf58 R08: 0000000000000000 R09: 0000000000000000
>>> R10: 00000000200000d4 R11: 0000000000000246 R12: 00000000ffffffff
>>> R13: 00000000000004ca R14: 00000000006f9390 R15: 0000000000000001
>>> IPVS: Unknown mcast interface: bcsh0
>>> IPVS: Unknown mcast interface: bcsh0
>>> IPVS: Unknown mcast interface: bcsh0
>>> IPVS: Unknown mcast interface: bcsh0
>>> IPVS: Unknown mcast interface: bcsh0
>>> IPVS: Unknown mcast interface: bcsh0
>>> IPVS: Unknown mcast interface: bcsh0
>>> IPVS: Unknown mcast interface: bcsh0
>>> IPVS: Unknown mcast interface: bcsh0
>>> IPVS: sync thread started: state = BACKUP, mcast_ifn = bcsh0, syncid = 0, id = 0
>>> IPVS: Unknown mcast interface: bcsh0
>>> IPVS: Unknown mcast interface: bcsh0
>>> IPVS: Unknown mcast interface: bcsh0
>>> IPVS: Unknown mcast interface: bcsh0
>>> IPVS: Unknown mcast interface: bcsh0
>>> IPVS: Unknown mcast interface: bcsh0
>>> IPVS: Unknown mcast interface: bcsh0
>>> IPVS: Unknown mcast interface: bcsh0
>>>
>>>
>>> ---
>>> This bug is generated by a dumb bot. It may contain errors.
>>> See https://goo.gl/tpsmEJ for details.
>>> Direct all questions to syzkaller@googlegroups.com.
>>>
>>> syzbot will keep track of this bug report.
>>> If you forgot to add the Reported-by tag, once the fix for this bug is merged
>>> into any tree, please reply to this email with:
>>> #syz fix: exact-commit-title
>>> To mark this as a duplicate of another syzbot report, please reply with:
>>> #syz dup: exact-subject-of-another-report
>>> If it's a one-off invalid bug report, please reply with:
>>> #syz invalid
>>> Note: if the crash happens again, it will cause creation of a new bug report.
>>> Note: all commands must start from beginning of the line in the email body.
>>
>> --
>> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
>> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
>> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/06c79d3f-3f28-7f1e-9431-66c18149c9e6%40virtuozzo.com.
>> For more options, visit https://groups.google.com/d/optout.
