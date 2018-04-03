Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754972AbeDCJuy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 05:50:54 -0400
Received: from mail-ve1eur01on0106.outbound.protection.outlook.com ([104.47.1.106]:43070
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751413AbeDCJuv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 05:50:51 -0400
Subject: Re: possible deadlock in skb_queue_tail
To: syzbot <syzbot+6b495100f17ca8554ab9@syzkaller.appspotmail.com>,
        davem@davemloft.net, dh.herrmann@gmail.com, dvlasenk@redhat.com,
        dwindsor@gmail.com, elena.reshetova@intel.com, ishkamiel@gmail.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        matthew@mjdsystems.ca, mjurczyk@google.com, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        xemul@virtuozzo.com
References: <0000000000003584570568da18dd@google.com>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <06c79d3f-3f28-7f1e-9431-66c18149c9e6@virtuozzo.com>
Date: Tue, 3 Apr 2018 12:50:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <0000000000003584570568da18dd@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: MRXP264CA0045.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:14::33) To HE1PR0801MB1339.eurprd08.prod.outlook.com
 (2603:10a6:3:3a::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c481b6a4-f20b-41cd-44e5-08d599485f8c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1339;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;3:hu3pIInLcVKKGoasTtvtcblDSaL7UOAOHfb1B0WMQPPmCkKZ+tm/3QxkaBcD0EeLRYIKKqNHHoxk1kC7TFnIIsgAVF25LI0JS6TqcX3mcxiBD1KbVqsYQoNKjNRNBESlqrKN4Kn3083vNhdN0TAGXTUdmyyb3FBq+eOcGhfVj8pbS4yeuCQj45OYzBOocG+sZMSJRdjOHEqNxZQzyWpGL1rrrGut0fTKJ9wfMQpb16K8vkOghMuUEjSTWW94eZut;25:nUyrI5HCaoN4Gg4ksnqiLLsRN3Sojtu7CY+0YlB6Ep9bM5QpacoUAnSThs6pJUXeTeu0xZ7mAjD+JE2bNpDfrOUho/afPScy4vJVrUjcyChzh4fH7AtSZ5SJXRr1lALYshfkl/bI6Q21SoIFY4IzwkF67jbovu5nkEfAx5m9OcO+ZDQJhgltBdMqvGnB88yI5um3f4kRMTjy5sKNcl9R9Tfepu7D3QylpYoIfJMCm2r/HM+nOtE9IX0lLYGasQAvGQi7luMwIhMMoIldpSeykT59PIUMnDvjeJ+4wt97e3I2eemIE/B0s/E8CPKYgHxkCit7+N1bqeMj2PcMCHHTaA==;31:xB5ZJIA0hnCN/ats7Rs01OchsJPAbAdIvxqqQdhRsRgOPvN1VFroyO7NEQJcnbhycbQMgbIvbqYds0YjMPDvfg28FriGfpDHdC5eF1DIXXmlxCkaZ19fAaborNTAEogDcTyySM/wIKH4wFGm1dkPLxcSYdzBygkyAj/n7H08pwv6xkzYlBj4WJVtANYHW4cVtVVPJJy84pskL832xkzLGI7GL+RtZvEPB547CfBRvA0=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1339:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;20:+uBiRg3YqAUzQH2M4am/KJmwvkRQPO6JquBag5I1mG7kihy0WIxV5/E3lRs2Mg1kw65ubkqTsjqCWd+a64djHwdQk0sxH19jNrsFHgalLb/vlNUfCsPbADMq7Ghn6bmnryZOeBg3Fv7D3uy0uEEA6HLzDUhlOKqpzwTh8HNJLJAvT4Ckw75c5E1TgfJtozUL29d8EQ5oQzA3ucO+IabjGbmzGO8i2OThmJZ01ciuOYL0GOXsLF2vxWAiGEB0uS/kYOkoudrgBhKiCX8sr9Wz0zGndYvEC9q5L7k5VrtfIlnnomefdL1iPQTV7hEKlR0q71cLy1wVkNdP2FSRQKrbcBoTWoUUSa+zC9QJWI/g5c+ri5ephREOfN3XA8XIluCd64MndrY8zoZI8Hb+94K0+5djqdn3kZDHXDq+Mq9hEkcrnhmGlIV0T+QbfJ8Ya38EqjleJnQuoD1YyhkYVeN0QKdg1R/sfzuP4XbGmUz31+Ad3ml0UeQLKa0kNIIm+vKT;4:VrWovNxGMz1kfIWR/IMBi06L1QLfYdDBgD64srEDnb11PhP4UxvU/nCjxxhW2Kje8z7m39IJNhttyW+qb629/DGzJ2dgZIPUO2NdoW+SdJkjNykUkk1IK0cMOb4kfT3wHtv4dGLSUwgbPqR2YGBmEZ7d9JmOZESZ1EKH4v5Gqke3ateXe/PMkxQGsj3kXAi1jjIyh7h1ljU+H+SL0VrlWEG7aEaqL07Glg8dS/UYG2IJ3WBWIUyLuuk/MJfx/xSkhpBHk5iqRyisOWWwB7AqhXLcH5FX4owYWCFWIds3Z0f7ZYTHD8FlWo2Gzgfwl1Wm
X-Microsoft-Antispam-PRVS: <HE1PR0801MB1339289919F2F0B761E021BACDA50@HE1PR0801MB1339.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(148501403981450);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231221)(944501327)(52105095)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:HE1PR0801MB1339;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1339;
X-Forefront-PRVS: 0631F0BC3D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(376002)(39850400004)(39380400002)(346002)(366004)(396003)(189003)(199004)(486005)(956004)(39060400002)(2616005)(2486003)(476003)(8936002)(77096007)(81156014)(81166006)(97736004)(966005)(76176011)(23676004)(52146003)(52116002)(486005)(316002)(478600001)(53936002)(26005)(68736007)(11346002)(59450400001)(2906002)(6486002)(16576012)(25786009)(6346003)(6116002)(446003)(3846002)(6306002)(105586002)(2870700001)(8676002)(106356001)(31696002)(36756003)(31686004)(575784001)(7736002)(305945005)(16526019)(65806001)(58126008)(229853002)(6246003)(386003)(47776003)(65956001)(66066001)(50466002)(65826007)(11609785009)(5660300001)(6666003)(7416002)(53546011)(64126003)(86362001)(6636002)(99710200001)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1339;H:[172.16.25.196];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzk7MjM6QnYvNXMyOUN4ZzM0UzQwVmV6ZnR6N2d0?=
 =?utf-8?B?SU9kcjJQUUlLR256bXlvamFMOFpSUHhER083YTI5emRnN2NROHV3NkpYS1pn?=
 =?utf-8?B?SCsyQWRqVGU4TnY2VzVaNWJxMXlMbjJ2elBwemNqNitnSk5ZeVF0WDZXZlNH?=
 =?utf-8?B?eXpmNDdiWU1HTC94TmNHOEVLNW94bVpmeU5FclRzaW9mTjNkNHoyWWR4RktE?=
 =?utf-8?B?VEVGajZQbllGTVlLUTR5eFUrZjJ5QXprOW5GVXUwdE5IRVRONHRaZmFZMXFZ?=
 =?utf-8?B?TVIwaVRoanNkSm1jc0taNU5BbjRqZTNMQnJUR3N5Vmg1cGFUamxGYUM3Y3pl?=
 =?utf-8?B?N29LZ0N0b2pSVEV6SXZmQnpLWDBVNVVwRExPa1B4K3ZjTlBXRmgwOHNFUjJN?=
 =?utf-8?B?NSt3dW1KckZHY2lWTkFTSlpNaC9RdGtRTzM4ZHhhMThDaUs5T3B2c1J3WURP?=
 =?utf-8?B?c2FmOGJCZ1BpWTUrMVNDdFRNdXFHZU4zVW9xbnNyVm5OTGpOUllDTDc4T0c2?=
 =?utf-8?B?bWNOdmljcmVCNGE0YTBYeURrVENmKzhsMFBqQ2M1SGcxYkdkZ25oSit3UXZY?=
 =?utf-8?B?Q3FUbmsvMDBocC9uN1c3dHJqNGtranEyWU9HOGFPR21UUkxxY09GVW94SXZu?=
 =?utf-8?B?dTN0QThaK3Baekp6MEplOThTS2ZraSsyWGRKQytEbUNuLzNVckcyR3VJSElT?=
 =?utf-8?B?UmlKVjBlZTkzYUE5b0xwL0htSlg0SXBmQzdNRCtaMmpTQXVjVUl4SUZTR3Bw?=
 =?utf-8?B?dnlvUm5GbkE4UXM5YzM1czVEWXF1eUp3QU41NmdPaDRzSENxZHhLVENKVEdW?=
 =?utf-8?B?UHBGM3NuTWJUcnBxL3VXMis5QnEvK1M0RE5LOHQrUmpnVDZWSzVxeDd5RFc3?=
 =?utf-8?B?bWFHNEJ6Q3Mrci9ONyszNXRGOGZ6QzgrTmF4b1ZQLzdFRkRHTGdxQlk2akF3?=
 =?utf-8?B?dE1vV1FPVW5YZEM0d0hDTitRUGhIYUdDMFN3QlpOeEFRUng5SnR5Z2FIYTR3?=
 =?utf-8?B?RWl0TmZnQUxFanFpY05zaWxpV0lFYmh5bUQrV2pMdm1vOHlRZXNkVytXaTJk?=
 =?utf-8?B?U3A4M1A5NGhoRnVDdVU4QjZCRy83SEJwOTFGbE1sQi9ob2tpa2ltOHFJc0sx?=
 =?utf-8?B?bk8rdWVGOTVFcGJvUVl5dmZjaWJLdGx2dmVsMWFNcXdsb2RGN1ZCY2VGQWx3?=
 =?utf-8?B?azhIU3pzblYxVnZiZzBYWHk3ZE40ZlZIZ090UVFMVTJ6MXVNak43Vi9TNlZH?=
 =?utf-8?B?cnVpamVPcWI0c05lSGw0NFRqTmxjQk91MHpWTXBjaVpDTHhNd0F2a0s3aEpp?=
 =?utf-8?B?ZDlPTFRVRnhDcG40NkdlVmNuYU0zb0tZSHZyTzZkUURTcFBvNDNVMEE4K210?=
 =?utf-8?B?MEFjZjllakZnK0U1UkQ0dkdNdFI1MzVwS0dyWFlSUklCT0oxK1pucS96RmZp?=
 =?utf-8?B?RFdEUWVsS2c1RXVJaERnbXhxMTBLTWIvN2JxdXFvVWJyL29qNWdEUUNST0xX?=
 =?utf-8?B?dXRxdC8vYnQ3amRPVkJSbjZ1aThxQVNMelRWR0ZEWjBnekxZcC92ekpoRmc5?=
 =?utf-8?B?aW5UTkoxcHFVckdCMDlPR1BEenlac2hGU3l3MUVhRllWUUpJT3hFMEZHZ2xR?=
 =?utf-8?B?bjRqZnV0VkRadnkwZGc4U0NpVlc2NzB2V2s0U1QvZ0d0a1g3K0dXbVdDS3Z1?=
 =?utf-8?B?TGk3V3NISzdSaVdQekhyTW5ON1hpUVhxREFVd2RLWmFVY0tKdnFCM29oak5m?=
 =?utf-8?B?VS9uRU5vaXl2SENVRVluazVaZkYxV3ZjSnczWHA0VEFxbDdtV2JBK09oMmpO?=
 =?utf-8?B?dTE2YVE4TzhPWEJXM29RQ3JscTNRcld3NzA4Sy9BSTNlL21oVmdNZ2ZaQUVJ?=
 =?utf-8?B?Zk9UWkV5Z25KT2RBVG9lYzBwMXkxQWJZSEVodGpLcHBtYkQxY0VRU1NPTmxK?=
 =?utf-8?B?RTJnNGErNHNObHMycWI3Rk1COE5oSnNNQ0ozaERLdHV0S1NVelEwcjVoc0g1?=
 =?utf-8?B?UGlCcEFrSlo2MHg4dWRsN0ZWaFUyUUN4ZlNpK0pveGFUMlp3SUsvdHhWV3di?=
 =?utf-8?B?TkNULzBmOXR6eGNpVldzUWdvNTV4V2hHOXJTenVXN3EzZTM2ejRXYjBMYXBq?=
 =?utf-8?B?STJXaVdWU0xYVnk2RFN6aFc3eXZnNGl2WWtiY2NKWVZ2Sk9ZTTJHdEFzM3RU?=
 =?utf-8?Q?c1E4yNALM1/CaJFw8ZaRXL6gcI0j6wymiLhszlv3+Xpo=3D?=
X-Microsoft-Antispam-Message-Info: p+L8b2PXHg0fcBVZzlZftc6H+VkgK3DAN4Xu15c+oBB0HCbqbIGrZIh6i5LpGCWP6BbjwTdcBkWSQbH/g8nhFvJwU5gT4IdYnHc+wL2iQMDrvrG1VPTgL4XuLnIU9Slwv2z92kwNKq0InxFkZ+E6wQZ9t6bQMMjvGnHJfuBBgompgG5ahNPrPiHA999FZg37
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;6:D98F2eLWpGFkRL81zjzmXMLoB6jzTeMvdb+pT42Z6AUSb2fHlW1DtPcLsfXFIRL0xr8WygMwaVZ6JLmqU8yUqweueVs/E8xLY58FPueElwGDfK5X6KWkvBKWg37vitNFZwAR4IhmwT+3Y1bk9XVKy9jc/8I3zNp1jUkI8Rl/QOmYwPMoXkUw89TomNkIRHGtpzFHV1JyGiBzsp+n6n320Yjcm19xiOwy2Ck5slepaiO5cLI/x9UgdoQBI6udjhmKY5HSe4P7qanJ8RsPQgEQ5/Fv4QmhjUPxzmCuZTkpMP0L9iOvdTQ/PsYpJvRZs4SNB5JkBK27D09myfPgHq2wBF4yfXliKMzc8vnr8vyHFU30Ur08b0Snh1u+vl/uls0OvdZ+PRWwGY028sfN5v2ZMpp3RAQnSL5pCI6xvPdC8J7Uh+3kzv6aLhp3WlcDYU6wfXBotEI1O0Z4rgNWYPAkdA==;5:ac9qhMOCs+TSKHSbr+JtIdU2pjp3/Stoq3C/sHqcVpw0EtffHmNc26fs3gBYTNoPSz3tgIeBbJDBK/S/ffM+s1zO45/5a+YU4OedVB7a+N9Rz4JlAUJCaAnhPPu/WEuWKpKGPdmmyGXzy0pBTPYcrNY4OxcdfSKhmfKdE2BCOZ8=;24:KjgzYXqm2DtIoWWpHNQZtCStMvvmCmbo6bHzWeg4MUPmsZ6PtwiVI5PWtPmj7h++ISrZE1Us6sIhCrEEXlxo9wc/dT4ZkANlXc4e4is3KUA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;7:jtRDSCFZVEc63l4dTJ+UrSxHPHragyUnNthWxvTsWxo8BvhzNd82sO/CodP1J58TYXRXR908zyX3CJ1UyYoHBMycXY9WvtvPhpBPug8ex8nSl5i+4eueV66OqTPW56VAdLd08NB5T3CMZrel0JQqhC5w8Z5DbvociTrrCgE/J9jQXV0vN4o65wjZ1H0PPxwZrDKFzjovFjJbVjU5i0kQMGTPXz7qU73q7e/e/OXEpMb8jKMH0s6wQPMLKUk6Fgj0;20:RkPuC36x4lYJHmEtkQ/XPGZlLTr7vHiTlyTEuEDFRc72BTIrkTXE03P0Qus/O9zHB4r8Rv4f0/0aZHEuJnZRzOh4nda34ThVJYcjTJkCnaKwcfvskDwUx7Lmalv7pdZB/tIqmEJe2yJ7bph9s+lU1kZjOjQtxfqDVyOEI0WNlTA=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2018 09:50:44.5171 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c481b6a4-f20b-41cd-44e5-08d599485f8c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1339
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.04.2018 12:20, syzbot wrote:
> Hello,
> 
> syzbot hit the following crash on net-next commit
> 06b19fe9a6df7aaa423cd8404ebe5ac9ec4b2960 (Sun Apr 1 03:37:33 2018 +0000)
> Merge branch 'chelsio-inline-tls'
> syzbot dashboard link: https://syzkaller.appspot.com/bug?extid=6b495100f17ca8554ab9
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> Raw console output: https://syzkaller.appspot.com/x/log.txt?id=6218830443446272
> Kernel config: https://syzkaller.appspot.com/x/.config?id=3327544840960562528
> compiler: gcc (GCC) 7.1.1 20170620
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+6b495100f17ca8554ab9@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed. See footer for details.
> If you forward the report, please keep this part and the footer.
> 
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 4.16.0-rc6+ #290 Not tainted
> ------------------------------------------------------
> syz-executor7/20971 is trying to acquire lock:
>  (&af_unix_sk_receive_queue_lock_key){+.+.}, at: [<00000000271ef0d8>] skb_queue_tail+0x26/0x150 net/core/skbuff.c:2899
> 
> but task is already holding lock:
>  (&(&u->lock)->rlock/1){+.+.}, at: [<000000004e725e14>] unix_state_double_lock+0x7b/0xb0 net/unix/af_unix.c:1088
> 
> which lock already depends on the new lock.
> 
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #1 (&(&u->lock)->rlock/1){+.+.}:
>        _raw_spin_lock_nested+0x28/0x40 kernel/locking/spinlock.c:354
>        sk_diag_dump_icons net/unix/diag.c:82 [inline]
>        sk_diag_fill.isra.4+0xa52/0xfe0 net/unix/diag.c:144
>        sk_diag_dump net/unix/diag.c:178 [inline]
>        unix_diag_dump+0x400/0x4f0 net/unix/diag.c:206
>        netlink_dump+0x492/0xcf0 net/netlink/af_netlink.c:2221
>        __netlink_dump_start+0x4ec/0x710 net/netlink/af_netlink.c:2318
>        netlink_dump_start include/linux/netlink.h:214 [inline]
>        unix_diag_handler_dump+0x3e7/0x750 net/unix/diag.c:307
>        __sock_diag_cmd net/core/sock_diag.c:230 [inline]
>        sock_diag_rcv_msg+0x204/0x360 net/core/sock_diag.c:261
>        netlink_rcv_skb+0x14b/0x380 net/netlink/af_netlink.c:2443
>        sock_diag_rcv+0x2a/0x40 net/core/sock_diag.c:272
>        netlink_unicast_kernel net/netlink/af_netlink.c:1307 [inline]
>        netlink_unicast+0x4c4/0x6b0 net/netlink/af_netlink.c:1333
>        netlink_sendmsg+0xa4a/0xe80 net/netlink/af_netlink.c:1896
>        sock_sendmsg_nosec net/socket.c:629 [inline]
>        sock_sendmsg+0xca/0x110 net/socket.c:639
>        sock_write_iter+0x31a/0x5d0 net/socket.c:908
>        call_write_iter include/linux/fs.h:1782 [inline]
>        new_sync_write fs/read_write.c:469 [inline]
>        __vfs_write+0x684/0x970 fs/read_write.c:482
>        vfs_write+0x189/0x510 fs/read_write.c:544
>        SYSC_write fs/read_write.c:589 [inline]
>        SyS_write+0xef/0x220 fs/read_write.c:581
>        do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
>        entry_SYSCALL_64_after_hwframe+0x42/0xb7
> 
> -> #0 (&af_unix_sk_receive_queue_lock_key){+.+.}:
>        lock_acquire+0x1d5/0x580 kernel/locking/lockdep.c:3920
>        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>        _raw_spin_lock_irqsave+0x96/0xc0 kernel/locking/spinlock.c:152
>        skb_queue_tail+0x26/0x150 net/core/skbuff.c:2899
>        unix_dgram_sendmsg+0xa30/0x1610 net/unix/af_unix.c:1807
>        sock_sendmsg_nosec net/socket.c:629 [inline]
>        sock_sendmsg+0xca/0x110 net/socket.c:639
>        ___sys_sendmsg+0x320/0x8b0 net/socket.c:2047
>        __sys_sendmmsg+0x1ee/0x620 net/socket.c:2137
>        SYSC_sendmmsg net/socket.c:2168 [inline]
>        SyS_sendmmsg+0x35/0x60 net/socket.c:2163
>        do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
>        entry_SYSCALL_64_after_hwframe+0x42/0xb7

sk_diag_dump_icons() dumps only sockets in TCP_LISTEN state.
TCP_LISTEN state may be assigned in only place in net/unix/af_unix.c:
it's unix_listen(). The function is applied to stream and seqpacket
socket types.

It can't be stream because of the second stack, and seqpacket also can't,
as I don't think it's possible for gcc to inline unix_seqpacket_sendmsg()
in the way, we don't see it in the stack.

So, this is looks like false positive result for me.

Kirill

> 
> other info that might help us debug this:
> 
>  Possible unsafe locking scenario:
> 
>        CPU0                    CPU1
>        ----                    ----
>   lock(&(&u->lock)->rlock/1);
>                                lock(&af_unix_sk_receive_queue_lock_key);
>                                lock(&(&u->lock)->rlock/1);
>   lock(&af_unix_sk_receive_queue_lock_key);
> 
>  *** DEADLOCK ***
> 
> 1 lock held by syz-executor7/20971:
>  #0:  (&(&u->lock)->rlock/1){+.+.}, at: [<000000004e725e14>] unix_state_double_lock+0x7b/0xb0 net/unix/af_unix.c:1088
> 
> stack backtrace:
> CPU: 0 PID: 20971 Comm: syz-executor7 Not tainted 4.16.0-rc6+ #290
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:17 [inline]
>  dump_stack+0x194/0x24d lib/dump_stack.c:53
>  print_circular_bug.isra.38+0x2cd/0x2dc kernel/locking/lockdep.c:1223
>  check_prev_add kernel/locking/lockdep.c:1863 [inline]
>  check_prevs_add kernel/locking/lockdep.c:1976 [inline]
>  validate_chain kernel/locking/lockdep.c:2417 [inline]
>  __lock_acquire+0x30a8/0x3e00 kernel/locking/lockdep.c:3431
>  lock_acquire+0x1d5/0x580 kernel/locking/lockdep.c:3920
>  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>  _raw_spin_lock_irqsave+0x96/0xc0 kernel/locking/spinlock.c:152
>  skb_queue_tail+0x26/0x150 net/core/skbuff.c:2899
>  unix_dgram_sendmsg+0xa30/0x1610 net/unix/af_unix.c:1807
>  sock_sendmsg_nosec net/socket.c:629 [inline]
>  sock_sendmsg+0xca/0x110 net/socket.c:639
>  ___sys_sendmsg+0x320/0x8b0 net/socket.c:2047
>  __sys_sendmmsg+0x1ee/0x620 net/socket.c:2137
>  SYSC_sendmmsg net/socket.c:2168 [inline]
>  SyS_sendmmsg+0x35/0x60 net/socket.c:2163
>  do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
>  entry_SYSCALL_64_after_hwframe+0x42/0xb7
> RIP: 0033:0x455269
> RSP: 002b:00007f71ffad6c68 EFLAGS: 00000246 ORIG_RAX: 0000000000000133
> RAX: ffffffffffffffda RBX: 00007f71ffad76d4 RCX: 0000000000455269
> RDX: 04924924924924f4 RSI: 0000000020000200 RDI: 0000000000000016
> RBP: 000000000072bf58 R08: 0000000000000000 R09: 0000000000000000
> R10: 00000000200000d4 R11: 0000000000000246 R12: 00000000ffffffff
> R13: 00000000000004ca R14: 00000000006f9390 R15: 0000000000000001
> IPVS: Unknown mcast interface: bcsh0
> IPVS: Unknown mcast interface: bcsh0
> IPVS: Unknown mcast interface: bcsh0
> IPVS: Unknown mcast interface: bcsh0
> IPVS: Unknown mcast interface: bcsh0
> IPVS: Unknown mcast interface: bcsh0
> IPVS: Unknown mcast interface: bcsh0
> IPVS: Unknown mcast interface: bcsh0
> IPVS: Unknown mcast interface: bcsh0
> IPVS: sync thread started: state = BACKUP, mcast_ifn = bcsh0, syncid = 0, id = 0
> IPVS: Unknown mcast interface: bcsh0
> IPVS: Unknown mcast interface: bcsh0
> IPVS: Unknown mcast interface: bcsh0
> IPVS: Unknown mcast interface: bcsh0
> IPVS: Unknown mcast interface: bcsh0
> IPVS: Unknown mcast interface: bcsh0
> IPVS: Unknown mcast interface: bcsh0
> IPVS: Unknown mcast interface: bcsh0
> 
> 
> ---
> This bug is generated by a dumb bot. It may contain errors.
> See https://goo.gl/tpsmEJ for details.
> Direct all questions to syzkaller@googlegroups.com.
> 
> syzbot will keep track of this bug report.
> If you forgot to add the Reported-by tag, once the fix for this bug is merged
> into any tree, please reply to this email with:
> #syz fix: exact-commit-title
> To mark this as a duplicate of another syzbot report, please reply with:
> #syz dup: exact-subject-of-another-report
> If it's a one-off invalid bug report, please reply with:
> #syz invalid
> Note: if the crash happens again, it will cause creation of a new bug report.
> Note: all commands must start from beginning of the line in the email body.
