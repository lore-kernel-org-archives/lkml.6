Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AB8JxZpFqfNSuDIcLAfqIncmB9rjFEkgjv3gsDWcUjnn+G7+B5ibsD1F3GyD5aXGK1J/aAf4n0MP
ARC-Seal: i=1; a=rsa-sha256; t=1526633050; cv=none;
        d=google.com; s=arc-20160816;
        b=vaIRi4OudPQ6u1S+BkeA5zZeTwKvMf4GBTZKGAyIk4Dc7LkYGn4R3mT4vgYGaxSeCy
         3XhzxYxzuqLLhubEQojVkO5hxEIlE+JK3HTh9D6i6+6rafF2+L2dhK+zD1gtoCSUndZ/
         DJX5dXPz2dI2OJXplp7WpnHB5PhzCBaj2jJHORdBMHl/rX1URQ/01pQAQzti8yEF9wuz
         VJ1zMVo3Ur360vc+63PwItOtOlKsXqN54N5wZupIq4+K8q3SJ9MHa4jQFOdErs1mhtdF
         tIZOhinIDJXT0B0dIBFuCwZgQCG2eJMU0WI3avzc+2Mk0Ma/M34pNfM4tTYXba6MQla+
         HLbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:to:from:subject:dkim-signature
         :arc-authentication-results;
        bh=VYI6dnUnudZTM+MI6064HmYDiGBuZPhais+O3U+Bv6M=;
        b=X6HDlLfxx+2ibV9KRD3zeT20YcE0ykNopyry5rUAslomfWsjrvS1Yrgq/eLnWou5sn
         4Pe8JpOw/APFXGCEza49/6zd5STpAdDPwP3c37L4RzCn6Rlibqb5D/ZDxtPq0Nj5bZKS
         /4BTqtLP7AvDFHquKGLCOIGHjfJpwU32ZkVgWAod1R848Smn/h/zehGjsr8QWnoOkwWV
         2q8NE0NtLD7h7BX9eBW5Ubw4GwrCaf6MM0/KOkwHFzaZ28eTJ8Uauj+nRgjbjGHGxj9i
         9bQTsz5w2eA/y2ms93rKkXJJarVqLTlM5w/q8c9S+VymxP39vKDpV3bJrxeFXELaEYsc
         CKBQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=MtWwsvx9;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.1.100 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=MtWwsvx9;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.1.100 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH v6 14/17] mm: Iterate only over charged shrinkers during
 memcg shrink_slab()
From: Kirill Tkhai <ktkhai@virtuozzo.com>
To: akpm@linux-foundation.org, vdavydov.dev@gmail.com, shakeelb@google.com,
 viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
 ktkhai@virtuozzo.com, tglx@linutronix.de, pombredanne@nexb.com,
 stummala@codeaurora.org, gregkh@linuxfoundation.org, sfr@canb.auug.org.au,
 guro@fb.com, mka@chromium.org, penguin-kernel@I-love.SAKURA.ne.jp,
 chris@chris-wilson.co.uk, longman@redhat.com, minchan@kernel.org,
 ying.huang@intel.com, mgorman@techsingularity.net, jbacik@fb.com,
 linux@roeck-us.net, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 willy@infradead.org, lirongqing@baidu.com, aryabinin@virtuozzo.com
Date: Fri, 18 May 2018 11:44:01 +0300
Message-ID: <152663304128.5308.12840831728812876902.stgit@localhost.localdomain>
In-Reply-To: <152663268383.5308.8660992135988724014.stgit@localhost.localdomain>
References: <152663268383.5308.8660992135988724014.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0902CA0021.eurprd09.prod.outlook.com
 (2603:10a6:3:e5::31) To VI1PR0801MB1341.eurprd08.prod.outlook.com
 (2603:10a6:800:3a::27)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1341;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1341;3:Zts5mOiddJsRpbcmVr+O3k6QNsHEUuopn50x56HnkfCcdo7+urKKWpw/O/1YCabg1mQLOjtLIRIfU1OYIkb4Pe37aLGdfK7Kp9ZnGWxN160f1MyEQ+ym++xEvDA6kggbVbSKj9pkOgPRpcrBAu3cOaFU37QNkyIunsOfR06cEbX/yju0/D5pA5AV5GGElemVvogX2/fy+xUL0lER4IvmNHL5bJA0OIiCvG2DsinYn+fjmJjmFHxamGH4XG2KK1AE;25:USijv7CYc80q39R5LrdN+k/51QYsXlcHFcbciVbvWRULoXR1mXuGYgkZhBTjCIhKOOxqExvHCRkMOWesMX79RudUf/lTheqYH55dLVMyb+21jWgd+iGu3hV02sYpCkRWHJwenjI7gogqzQSYV5isZnHzseK/ZWcxXi9KftyZ4GppqxY30ZxeELwyR5qYMGYtZs7FZ8UFLebePBBuIWs15LXBpai5r5SvEz9XvfCW3ye4RvlMBypOzfvztCDkMy7iGmiKjAWm2UyBGeJVR/3d1WOgGT7w4/kVSiUMQGbPAoVqqn1LmvcWaKEl6ERUvYduQAnh9XnrGWAqUCXH116iBw==;31:5W9wAmw7Fn7MnxMc93V+PzJozg0Kxif7KbeaKzIOY8Ss4I6qM0RXNqPoZnEv3qyHzOT7opaKn+0YX56neJ4Q8pwzDXBIAXnYu4DZASusiEajzuHmC4bDd/wfiEWLlUdqscrF3Fg9fBR5TJXy8AiCpld7ZinEGNNZxbAkcbkJe3DlEA9V4qO+qyUX6cXE+EXbTUP8+j+BgZfDDh82IxdV08rhA1iueHJ6VhhiSMY5MLw=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1341:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1341;20:l4RX0p4s58XUy66Qn44AvljTxv/ixwtCwenOBShSNlpzaRo/WtJacxIt+y8bhpGf2R+3ljm4l9YGqe9wqIfes3nN1Js8OZumPWIlEOGIzDQuAnjMEnSS1x6SAxBxvzM8/8JGnRtbMr/kmggN13BsBnLThEJFLlNXkq3H0QjSTP7OMmHSqVJ1QzcYY5YnGvO/SKQytYFTG5vRCcVfTNn4av117fXMeWpvq3aCsxVTzM1ZjtKOrNRI6Su0uxPQQRLAE0ALVxKNMDTsIR7RbLstjQP9nLstjiJVA11yzpKw3twe1U1oSiPApxX2Gd3YiWP8zfbnZ++eDXGmQo9x1RXe1bBc7cHBv5ezVAbGNTZpRF13fEQTzltnzNjn7phDZnlcSL7xL7DqZFWfGQTS3oIn19pXldlbyRBNYQO7QLEqdu/sCbLNxRaNpNgH4s+V9AtORivIi8E4YADlcKfid2PNL4KvmIX5FUShWutmb6KE7cIbHkDDTXKPa94q4M7WM/WD;4:OjrPl+fe4EuYI7r1+135ZnZpmejtFRF1Tx/MuJou69Y0bn1Yo65DsefTCKnLtltSyMYbZUN/7dfdYMLpeVfPsjGxNBc9590kmGraDJPDOXj3CacIJupbs2nuljO/mnvojeJW3+VPZ4tPKwv5pbj4Wa4cXeMTNDBAA28qhERYG7vtRHZljgeo3EDMXeZI0SbamgRTwNsUZiMrLLYE6RfLYjPk3DkDWgSp3lrXaxgn5xbWIIr5fptbXk2BONftszpF7EWmJmJh++3qE8FZ7mq0Vg==
X-Microsoft-Antispam-PRVS: <VI1PR0801MB134199BEEB52AD052C0FDA86CD900@VI1PR0801MB1341.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:VI1PR0801MB1341;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1341;
X-Forefront-PRVS: 0676F530A9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(979002)(6069001)(376002)(39850400004)(39380400002)(396003)(366004)(346002)(189003)(199004)(6116002)(25786009)(39060400002)(81166006)(81156014)(106356001)(8676002)(68736007)(486006)(55016002)(8936002)(66066001)(47776003)(11346002)(3846002)(446003)(476003)(478600001)(956004)(105586002)(16526019)(103116003)(186003)(59450400001)(58126008)(9686003)(26005)(50466002)(53936002)(2906002)(230700001)(7736002)(5660300001)(33896004)(316002)(7416002)(97736004)(55236004)(6666003)(6636002)(61506002)(86362001)(7696005)(386003)(6506007)(2486003)(23676004)(76176011)(52116002)(305945005)(921003)(1121003)(309714004)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB1341;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjEzNDE7MjM6eE1STDI0SGxEdVVNK3d0T2s5U1FFV2dT?=
 =?utf-8?B?ekFyMFMvUE1XeEp5MDhxMjdwWmROc3VPTTh0SWJSV1ZvaVo2WlVNa3hFU00r?=
 =?utf-8?B?V09XSEF2UVZ2aGx6SFdWeE5PYlQ3WnRlSEN2N2VQQkw4dFZSYXoyZHBCeGd1?=
 =?utf-8?B?NUI4RlhzK2h5WXVLTVZsSXNSbC92TFNoYkFQNWozMEdGYkd6Vnd0MzVhUUdJ?=
 =?utf-8?B?MUR3aHhKOXNPQmpYUlJ0Mk56cnZvU3RSeGt5TXI1MFhtSHVJb1JSbFFSVDJz?=
 =?utf-8?B?dXUxdDdpWFJieHYrUFJ3U1NLVmU0SGp6S0V5YytXY21TMEpxQXAxODBrRGtD?=
 =?utf-8?B?VmIyWDZ3eE1xdDZCQXdVRTZnV3FFSHZJSkowdVZDQ01VUnlXSnh5Mm1qSTRw?=
 =?utf-8?B?dzBhY2dxZlAwY2U1V3ZHYm5hY2JIM2hLTk5hVnVxOVNUbE5jUmtqdU1NOVJT?=
 =?utf-8?B?dXNtUlpaT242b3Q5SlQ3UEIveGNLVWtnSUFHVXI1MHRramE5aUx3U1ptTU85?=
 =?utf-8?B?dXVOQ2RyMVpNTktiaE9BOXhwMnhxM3B0MzlHbkhWaFRFU0tFUGNHbzVoZG5m?=
 =?utf-8?B?c1JtNVc1TUp6UGJITGdKSDNFeE4rK2k2QnJzLzQvam5aOG9EVzhkaVBFd1JG?=
 =?utf-8?B?bmdmalZmVGNNcDltMnlKdXJFVHJ4U2MyWGhvWlRHdnY4Y2hyM1Y1M091NktN?=
 =?utf-8?B?WmFUdFg3U0pBTjQzNGU1MjRpTnAzSHpvRTdvVVJISnlXaU9rdUpZL1RNNElu?=
 =?utf-8?B?SVZJbDJLVjJISnpHSHZiNVlZQlZVV2tlNVVENVQ5SFRJODNNY0krUEJYenAv?=
 =?utf-8?B?OHJmVG1OS0x5UWpkbW8rdk5yeFlsQWdJM3FQdFcxQytmS3FHcUlqcHdjVFkx?=
 =?utf-8?B?Q2NFZGtIalA5eE1PV1NxQnVwbk81bmMxTkUrcTlXSmE1R1pvYW43ZFB2VFQ0?=
 =?utf-8?B?NElVdEFySTI0VlJZcU15REhsNVhXUFZJQlBXS0syWlpDQnVYMWZBbGhCWFZi?=
 =?utf-8?B?SjViWjVaUE1HUEVrWE5tQldMQnRuSCtQUCtmMnQvTlpqRUFSekxIQk1uZnU1?=
 =?utf-8?B?MDNmbitOTGpkNkNZTDc2WXRrVFh4dW5lVFVLaEcxSzc1UjNWVUVGN1NYaXM2?=
 =?utf-8?B?QkZZL25JbTE1MWgwTktIdkRVVXR6bTdGd21pVkQ5amM4NlhwaTJiNWllakRQ?=
 =?utf-8?B?U1JHOEFQdWpyeVJOTXZPbjZLMEttZzBBOU5mRy9RRmx4SnQ1T0FKQzdMTjJH?=
 =?utf-8?B?MXF4eXZVQzIycjRQWStucGY0S3NPTEsxZTZ1U3ZkbWhtUHNaYXF4eTc2NUo5?=
 =?utf-8?B?RkIxRm1QbHRvWkZGdjlwZWFqekx6MnpaS0x0dG1nbUZtSXgwQ01YWFRIaWFi?=
 =?utf-8?B?b3hUd2RHcjRJZHVkdmh5MmlqbzdPNVoxeUdhRFExRndsangyN0h3cGZFZFE0?=
 =?utf-8?B?K1IxWUtXRmtvcG00UTMwdmhGRi9ubVdpeVhZV29RZUgzZjMzcXJ0Q243MGJG?=
 =?utf-8?B?QU9FcXBOWkhTZlUyRC80MStnRTdrdjUzZkdvYURhVnlTUXZZaGNkbzR3ZUZP?=
 =?utf-8?B?WmZ1REp0UWo5aG9aZjJiYlIxNzZHZW9yUHEvUndJNURSRCtrMG9VRWZGenR2?=
 =?utf-8?B?NTl5OFcxRkt4V1NTYStkbThSczdGOEt6cSt2aDJEVkRRMjl2bWxaVytyYXlN?=
 =?utf-8?B?aG9INTdoSFF3ZmorWnRNWWlmZmxXRnB2SFpVaklRTG1pdEhrc0hoNjNvOUxz?=
 =?utf-8?B?LzlkdVZHYlVMS2Q1SUk0SjhwT3h4MzVwMWVkUTBnL1FWekVPNkJvWXNuZndi?=
 =?utf-8?B?dTZKR1FOa0pFdUNUekxZdUVSOWhoRWxSeGdPUnVXRTA4TUJTRFQxVUl4QnhC?=
 =?utf-8?B?QkFYVUNSeG1sNXIyR21LUm9NSnJHaDVOcXFzeGRlYWZaV0pTMUV6V1FGd2dt?=
 =?utf-8?B?ekpUSnJDbmF2Z21OOHdOdG5uNllwOHNsdm5EQmJHcklNaXZyL0drd2psL3Ir?=
 =?utf-8?Q?fn2hXp0S?=
X-Microsoft-Antispam-Message-Info: zb6iDRg+WDnOaoY/sb2usl/wt8fXGzroUFJ1ZPdpCOtko2vafJ1AhC1Dd8huhf8nFshYMQ7k8ntY3C4DLDrwbS+ktsf8kYURoRM8dcbIJf/b+IDbMft55JbT3xAJB/HhoHOiWrXwbeXdggMAgYdnfyyuwUOTTQQ9DUDT4CR/RE6KDk+AotGuyiM1tVsGww5n
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1341;6:Fn1r4nVPoZAB+IEjIRjP7YPvHxXXuOedYsRkjmaF1XxzEZrtGpM3OafQNeUfjYyHCfrnEYBYrmVeT/pZ1VAl8WuotQKRs+W8vahr/o4XoKV6Qn3a8NiQ8ROOdUD8toYgRGu75Ydi1isID/boMReopv+7HA6+tkdIhe3fSDFRQbYzjNT8r4Qig+o888mmVdQOZYI+eE/8D8IWxtnmgdPl4UoS+xLiZL8qQZvtHOFm15CRGJAthngg/Ddep7SzX5Df5rbs21uIWBYQgcYHzU6G2f2yU9sIjJucbz2YHhKh6TgNZWzNKvglE+NUIZsuo3V0/SSZlxRd22XvLcnjR8G2qkJuRpmcEZxPgphSmgBTRav7fTQ8GBKTRcyVZxwDY077ognidT9HslPnqyLLPN0a3YT8SlqpTzAm2PdFSvZRo+ltQwOaNERMWYaCt05dG6y7smE14Fv9+nHmURNLHXsaxQ==;5:yVnkYMdgd7vlHRHvbfrB2b0FwGsWcxsCljjoFuvUVaKXSNcIM8Tf3bGOAW7vCk1NTfPI5296zor7m8LZ1Ulld91Amj6YYqsH8k9ai42AJsjMfDggwMTPykp2XvwXuCdw9+qUfHmj8fbNrLqlM82XJa/Ntoe9NoA5PvggvEFmvyc=;24:XLzlVoyk/pXVW4zyH2EfWZOO7uoHJQwmfaXKyJm8mi4gtz5FuhLSvbERHkW98XuCknVWaODv4bs0g/cXSKEpuPy0PIzPvd/x1d0gndFLYZ4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1341;7:vPTdMr4OaDlcruasn0xQRM/WeJFYeAOtRHyjRW8yIyZCSy3nLU9MCpZ/vL5Bpy2hlZaxUaZT8nt8gPqlV8aHWuyupanVsuHAAYcGjkj7qf3o/svGIbTm+2aQH04GJRQ8taxRyqTkzyptLZNkomlUZjnoGzd4mDLqGph0dPB+WgH12XXt86t2JLU1W+1llRJ8oWYrVlFWaXsBxU7jMxXvQy/wh32H4HAy0Z4pnB7B0S2QnntEM27TR0eJ/FsllZ5X;20:qR9/n4h8fi9hI3AlWkeUTkWwHzGYTCdT530EbkIvCtAlT0k2BDzFv4ZxtrexdqBRFbqAiTlkPTV1MfN9YyN8MbK8Mkfq0AdKwHtwFH1rosslqUd8AukXhnJ4irlURmuFPml9RZrUU2cc5b43Y4bUS432AcHiLdwqSDx+y/EAtxs=
X-MS-Office365-Filtering-Correlation-Id: b494585b-0d92-4f4e-e60a-08d5bc9b83de
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2018 08:44:04.1637 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b494585b-0d92-4f4e-e60a-08d5bc9b83de
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1341
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600790777328718772?=
X-GMAIL-MSGID: =?utf-8?q?1600790777328718772?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Using the preparations made in previous patches, in case of memcg
shrink, we may avoid shrinkers, which are not set in memcg's shrinkers
bitmap. To do that, we separate iterations over memcg-aware and
!memcg-aware shrinkers, and memcg-aware shrinkers are chosen
via for_each_set_bit() from the bitmap. In case of big nodes,
having many isolated environments, this gives significant
performance growth. See next patches for the details.

Note, that the patch does not respect to empty memcg shrinkers,
since we never clear the bitmap bits after we set it once.
Their shrinkers will be called again, with no shrinked objects
as result. This functionality is provided by next patches.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 mm/vmscan.c |   87 +++++++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 78 insertions(+), 9 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index f09ea20d7270..2fbf3b476601 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -373,6 +373,20 @@ int prealloc_shrinker(struct shrinker *shrinker)
 			goto free_deferred;
 	}
 
+	/*
+	 * There is a window between prealloc_shrinker()
+	 * and register_shrinker_prepared(). We don't want
+	 * to clear bit of a shrinker in such the state
+	 * in shrink_slab_memcg(), since this will impose
+	 * restrictions on a code registering a shrinker
+	 * (they would have to guarantee, their LRU lists
+	 * are empty till shrinker is completely registered).
+	 * So, we differ the situation, when 1)a shrinker
+	 * is semi-registered (id is assigned, but it has
+	 * not yet linked to shrinker_list) and 2)shrinker
+	 * is not registered (id is not assigned).
+	 */
+	INIT_LIST_HEAD(&shrinker->list);
 	return 0;
 
 free_deferred:
@@ -544,6 +558,67 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 	return freed;
 }
 
+#ifdef CONFIG_MEMCG_KMEM
+static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
+			struct mem_cgroup *memcg, int priority)
+{
+	struct memcg_shrinker_map *map;
+	unsigned long freed = 0;
+	int ret, i;
+
+	if (!memcg_kmem_enabled() || !mem_cgroup_online(memcg))
+		return 0;
+
+	if (!down_read_trylock(&shrinker_rwsem))
+		return 0;
+
+	/*
+	 * 1) Caller passes only alive memcg, so map can't be NULL.
+	 * 2) shrinker_rwsem protects from maps expanding.
+	 */
+	map = rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_map,
+					true);
+	BUG_ON(!map);
+
+	for_each_set_bit(i, map->map, memcg_shrinker_nr_max) {
+		struct shrink_control sc = {
+			.gfp_mask = gfp_mask,
+			.nid = nid,
+			.memcg = memcg,
+		};
+		struct shrinker *shrinker;
+
+		shrinker = idr_find(&shrinker_idr, i);
+		if (unlikely(!shrinker)) {
+			clear_bit(i, map->map);
+			continue;
+		}
+		BUG_ON(!(shrinker->flags & SHRINKER_MEMCG_AWARE));
+
+		/* See comment in prealloc_shrinker() */
+		if (unlikely(list_empty(&shrinker->list)))
+			continue;
+
+		ret = do_shrink_slab(&sc, shrinker, priority);
+		freed += ret;
+
+		if (rwsem_is_contended(&shrinker_rwsem)) {
+			freed = freed ? : 1;
+			break;
+		}
+	}
+
+	up_read(&shrinker_rwsem);
+	return freed;
+}
+#else /* CONFIG_MEMCG_KMEM */
+static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
+			struct mem_cgroup *memcg, int priority)
+{
+	return 0;
+}
+#endif /* CONFIG_MEMCG_KMEM */
+
 /**
  * shrink_slab - shrink slab caches
  * @gfp_mask: allocation context
@@ -573,8 +648,8 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 	struct shrinker *shrinker;
 	unsigned long freed = 0;
 
-	if (memcg && (!memcg_kmem_enabled() || !mem_cgroup_online(memcg)))
-		return 0;
+	if (memcg && !mem_cgroup_is_root(memcg))
+		return shrink_slab_memcg(gfp_mask, nid, memcg, priority);
 
 	if (!down_read_trylock(&shrinker_rwsem))
 		goto out;
@@ -586,13 +661,7 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 			.memcg = memcg,
 		};
 
-		/*
-		 * If kernel memory accounting is disabled, we ignore
-		 * SHRINKER_MEMCG_AWARE flag and call all shrinkers
-		 * passing NULL for memcg.
-		 */
-		if (memcg_kmem_enabled() &&
-		    !!memcg != !!(shrinker->flags & SHRINKER_MEMCG_AWARE))
+		if (!!memcg != !!(shrinker->flags & SHRINKER_MEMCG_AWARE))
 			continue;
 
 		if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
