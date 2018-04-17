Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754021AbeDQN7g (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 09:59:36 -0400
Received: from mail-eopbgr30114.outbound.protection.outlook.com ([40.107.3.114]:45338
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753775AbeDQN7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 09:59:33 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: Re: [PATCH] fasync: Fix deadlock between task-context and
 interrupt-context kill_fasync()
To: Jeff Layton <jlayton@kernel.org>, bfields@fieldses.org,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, boqun.feng@gmail.com, longman@redhat.com,
        peterz@infradead.org, mingo@redhat.com
References: <152292939368.19745.13784475656016424647.stgit@localhost.localdomain>
 <1523965358.4779.25.camel@kernel.org>
 <3a586f4f-54f9-a7a4-002a-9062b1681e16@virtuozzo.com>
 <1523971860.4779.42.camel@kernel.org>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <a826f6f9-4b48-031f-25d9-926ef1530e16@virtuozzo.com>
Date: Tue, 17 Apr 2018 16:59:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1523971860.4779.42.camel@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0501CA0007.eurprd05.prod.outlook.com
 (2603:10a6:3:1a::17) To VI1PR0801MB1342.eurprd08.prod.outlook.com
 (2603:10a6:800:3a::28)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1342;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1342;3:IefDX2hzPkZ9f0lv/xYgIp+DgZ77PL0hHebJ1zC6HvXI3c1VwWhRXbJ7n3b3cb20iRMSSovAIpeTg88DdEkcwXFWi6Y4UQwEyuoTXrl7GOwk6uCpL1laEx+bgy4BDMKPqLBnpj8x0H5LXUWd8mOAeeLKVQg94AzjMxBlpgj3wD4GdJ/w9+JFwkOp+HBYpZPIQi/BX35bQhAabl9kkDA1e1Z9/bm2HU6gct9UDmINCTKqi1Jkq/6qpUygQu6SYER2;25:8vHQwh38pZp3EAc2zOpLao3th4WGTJTmBRc/phRzGaZLwhXB8vqwFeYVi4TOGcSL0YZiVCkfiznz1T/gA54zqkVTBlysRQWq5gvwibSvyuAOm3OhUbfIuiCiBLxb+fIMUgLZyOgOJ8+pR8RGk8EmLcUkvP7qLiQlbTWKZ1vIT8uPdcu+larTTXcTqmcp3u50yBXJ6ETVf4O8ci9POWoiyRSOYQ5eiWv/PS54KY8HhsOeL0NPMn3vvdVZ5X4LZUn3mz6nJ+K2SHTqULyx2yWDp9QxRCrSVJnnORbII+uGyJsb2sEipBjGbeMxMkkWAtaDj0Gp3vCHCZe8j2cABJWlUg==;31:b1zNaL5XHZwJRYEciRXujtilTD/YlwBNT9vajrIGJvY+i7SVUCSi91h8AxALM8trgcHAt/dLAO2E0aFkg00sOf6Y4t58FGJxfgP9IABuozOobkQBjGg3bqa6euMRMmmLnyc6+gGbeJr3pyqsZ6BT/CY/fwiGZ6l13rd5e8jYpsDrbhgHeoieJAats7U7wEY9IUVifX8x8bteIX+FLW5++cTXWmzw2YrLr1PrLtbekWg=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1342:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1342;20:P2RWW6y99iq1j7xPWTspNaGFNCT572nqlBtxQZBqGhNHSmag1L8paa3h2AhbSdQ8lqJQeicJ7awV1K2h1GrU+PadFcUrctOaFzbjpMFoWG31kRospdIjgaoKqjJB/TItwcWKIYuvQ6AZH+vG/HSK2X57mmkVj+DBS3GRNE9z45b6svc+JKnUFvGf1y9dSKSK072a7ps9yu4Ok3h2TsWc6rOl2HRGDZNvaYZFKFTm71mKs7ln5cRwJ6u831Kk8xZIzMm4ndqbmmIFjfjItOkJ6PscXMITiamlwy4LLCVs4w3KEyM6QFb6lPMYTWvLoEu41dqdAkzqbyXhusuO2CtlsJhVM1Lzzcj8kJBpH7RAbEyauEBNv0Fkl8AMdXCN96WrkDVBehAl+Qk6CJbQUDuwUDz0mxLlHi4x0ySMNdhTW9eO3PkZRQ36dCBXLlUDW8n3Io3WcV0X2DBcYzXtX8b/NL76SCxyAZptohKtVmTvQDlbgTbFvN5EH9NSSEdab6h1;4:9Ne+EyH3NBibqcEy52ZGY+CQysFsRvtvfv3Gc065KiG4486BS4Gg0JNVIQO5vcAJlivlvDpoUK6YIyYUR46N+0JT2/+RmphoEXwLXKnMjxm1wHLM0wiseKuiJqI0PynMTwLOGiek7XWtyEeXxfaHTsIZ+iSHH74PDht/lG4k+sgei1lEgCfzO86hpa4OHTc4mHd/KWljnNfCzP7mys8jZC6LpaIjASnRILLvUDu+K2ViGFeADbhbF4+G92L5T1+cdueSJek6NpFa0cFZq+jQJbDPlzh3ozbFOX95uxyMU3LpefKMlvetftoVGX+aeoxh
X-Microsoft-Antispam-PRVS: <VI1PR0801MB1342690DC61BC829AA0A5113CDB70@VI1PR0801MB1342.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231232)(944501327)(52105095)(10201501046)(93006095)(93001095)(3002001)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:VI1PR0801MB1342;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1342;
X-Forefront-PRVS: 0645BEB7AA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39380400002)(346002)(39850400004)(396003)(366004)(376002)(377424004)(199004)(189003)(53936002)(966005)(2616005)(2906002)(52146003)(39060400002)(6306002)(2486003)(81166006)(52116002)(186003)(77096007)(16526019)(6486002)(8936002)(26005)(23676004)(97736004)(65826007)(81156014)(229853002)(31696002)(6666003)(11346002)(956004)(476003)(478600001)(446003)(6116002)(316002)(31686004)(47776003)(58126008)(50466002)(16576012)(106356001)(64126003)(25786009)(5660300001)(3846002)(59450400001)(65956001)(8676002)(105586002)(6246003)(53546011)(65806001)(305945005)(93886005)(230700001)(7736002)(66066001)(486006)(55236004)(386003)(36756003)(86362001)(68736007)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB1342;H:[172.16.25.5];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjEzNDI7MjM6YVRMUlorKzAzaERnOU5ZL0lwZ1MzTnkx?=
 =?utf-8?B?dFVkcWI1aHk4K1ZDK0RoQURFYldncDZBU1F0MnVPc3RSREw4L0diM0tUZjc2?=
 =?utf-8?B?L0NBYmNXcjhaT1I3NlpZQ2NtMmFLMWpyNjl1VzNkWW1wY2I1ODU1UUxLUUVZ?=
 =?utf-8?B?Q3hFaVdDeFV0ZU4xVk1xOU55a3VIYytXNlB3cGExQlRWNm93QkMybmNXVDFX?=
 =?utf-8?B?UVFQbXNNeGIyOG9laTg1a1VEeE1naDQwNENXZnNOSlBMR0RkaUpYcjJJNG5Z?=
 =?utf-8?B?bGFZOWdCcDZBcDU2czh2YmRYbmRSMEhxYXZGaW0yc09kNS82NVZUK3pNUTRx?=
 =?utf-8?B?VWcybGVxc2ZtR2MveW9Da3JUL2JhU1MzMGlCNWk2a3dkajFzdHpoWE1tYWls?=
 =?utf-8?B?VzloR3Uzank1Ukx3QlZXRXcyZ0x5NXRuY003b3pjV3lmaFZtVElBeEk2WWt4?=
 =?utf-8?B?K2ZqemgxcUl5cm1aT2kzb2ZzOXBTRjVZVklhcXh4OTdmQnRpeCtzWkVkeUVZ?=
 =?utf-8?B?SWNNQzlHZW1PK3ZZY1EzT1VIS3pBckhwUHpMcWxNUGgzai9nTXBmaWVFMGZw?=
 =?utf-8?B?bXY3YmdPbE1RR0l0L3FLbHNZekg0S3RRemJyZG1jZ0Z3V1RoZGVRQ1hTWmlj?=
 =?utf-8?B?d2hEcWc0bHdqMTRZOWFCU1MxWG1FbGVYWEV1MnhiR1JpV3AxbGFzU21QbGpk?=
 =?utf-8?B?cHJSSElSV2txZk41Y1VmaTBXbjFRYmYzOHlQK0Z3ZE15VlR5VC8xSDV4K1VI?=
 =?utf-8?B?dW15amVTVy9aOUlUWmpBeHl0WDNkM2ZyZVhLU25KZTdNaC9La2ZmSzhDY3JV?=
 =?utf-8?B?ZnJNeEZOWVZCMGVPNG5WNXRLVk9FKzdURVY4ZGFBMkhTZVY3UTFWUExONDYr?=
 =?utf-8?B?U0FDU0crQVJjWDRRVkVlRFdQV3dFQWpMb1hHT0hubzRwUG9xc1RqYWFpajJo?=
 =?utf-8?B?dUVDTTlHMXYyT1R4Nkd1NWhaNlNGeTlLanE1WU5WRFJTa1Y0ZTVnYmhxdnhu?=
 =?utf-8?B?QmVWcW5jQWJ4NXdEQ0sxTTk3NkhBa1NENGFpaDF5WEFNNDl5Q050Sk5NRU5h?=
 =?utf-8?B?SkpBZHpvTEVyR2RZK1FoeUx0VzNJWUh1M1IrSWVvdVdjRmNWckFNM1kyVGJL?=
 =?utf-8?B?MEQ5ZWJxZmxKMlBQNTVzNlR1UVNLWUFTaFkycFBJaVFMcER0eUJSY2FzZVZV?=
 =?utf-8?B?VDg4bXZTakEyTGV1T0cvZ0V3YXBTNWJaa2NvZ1NOYWtkNWorVlZPOGhZUk5S?=
 =?utf-8?B?Y01LekdwaWRyVkhnNGlWb0lqK0Z4UTZzS0QzMDNPQlF5b2dueW96cm5hc0hk?=
 =?utf-8?B?dHovdEZKS2pLSjlqTFpjOU5UTDgrcDJtZUsyV2VQcHp3QUNlVTBKTVBaekp0?=
 =?utf-8?B?S1Z3Tndrc1hYcnFkc01zK1lFUWZSc3MvcHlJamFTaEppYzFEa1JyL2cySnFY?=
 =?utf-8?B?TmlOQURZVm42eGtmOStaK2pqWTVpMnpkOHhGSjNkL1FtSG0zeE5jc2M5NE9z?=
 =?utf-8?B?eGJJNmdIVXlFTEo1Q0tldkZmQ1QvdzJrT0RRTk9GVGRUNHdDVUdleUxUNU41?=
 =?utf-8?B?YUlaczlFRXBPUXplRzdmRVRiWkhIaFNvODV1NzlJb0haVHdsdm1yOW1zbGIy?=
 =?utf-8?B?ZlpqRWUxSjdEZjlJdldOVTF5VS9sY3JuRHJDT2hKbmpDZmJUK2JxT1Y2amNY?=
 =?utf-8?B?VFkwcTJlVGJDSXZ3b3ZQRmZ3SGhQazBybWZhTXI4MDlLNktrcXRNZFVOcXdU?=
 =?utf-8?B?eFBubnRwc3ltaE5xYXlkTnRNT1hsWGlDUG9jWDR5dUR1WVRKQm1tVmI3UUFK?=
 =?utf-8?B?TDd0N0Z2dittaTdOcXBxUkhPWW1HbTlOZzN2cmcwUGRIS29NQzJXZWNremV6?=
 =?utf-8?B?cUJEQmw4UDNjR24ya29wME4rTXhhSEk2aFVwS0JDWEJ6aWxFWWE0b0FSd1ll?=
 =?utf-8?B?aFFYb0xzaTROM0Nuckw4YkRzTmdSUGZDUkJnekQ3ek9PK3l4YXUvQnFqc3Ba?=
 =?utf-8?B?amJjVUJaemxmR0N6a3lWOWpRTmlPSytyQ0ZiQTdaMnAwYjNVa3NOSUV0cDMv?=
 =?utf-8?Q?EWOclVstpEKEUgRu/Xj7EFM+NPS?=
X-Microsoft-Antispam-Message-Info: LrmlEkpiHO1oDXVipseKuOHklrfRH8zDuvCukA8bIiL64s7ODlFFepJiy2R13ptRGuB1Y620GNs25xN9SPPgEAjpuOxCHNrNd4M1pmSg1+LlYyjIWil+E5hU9MMUVrzrmg4BhHimi182TeB+74imQCo3k5Kt8In51VmSPmwu+jB8ibWqExtakoK7T4P8dMJ2
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1342;6:TqbQ3IA0eW4kA9ueFvfBhzVuZM9dyWRXv3V93JmPXCNEQUzrYrbG1isFXSLCcXqemEpUx+WeuecIe/VvDH92R44LdJkUwmRpVRExVeRIn1z4FJ/uH059N7iS5/BuKRo7JDvUuKt2QKum5wZqGZlj3l8IYyw3up2SlwqU2Msa+gOBSH5RRPCjBN0uBENYbuJE+ihFB/8OL6/wPnpAg8B+IEC79wUtHd+wDMoTZY2pYVbR8F2fSFgCWH/yi7GzdRS5+2NmrpeD3Wy5kBQbGF/dwZy7IJPP0FZYf3Kr2xYfMeqvmbG1FLfQw4mYkXg1m5tBqdQnEvkgXNcKiNQyOG2LyB0to6wBKa6YWxOTFU4483e0qiatVV8iOKeReMNTR50pe0UUQTqeP6lYIS3tfuY1WQnQ323MVMGtF5GlRGiUgNJQqEwPwCVLVKTI4iQb6Y0CSaCTrCjNo/OZQjBFGvuZmQ==;5:8rtHg5ti989BNwjs0+gUvFFc9Z5Ni0pytnzrsD/MbExfC3NezPgvg3NEHgJcTFXJtoQBz7Qur7Ra79vBh/2g0hesR+zsurkQHDcRRmM537OXzfRQsIIHTqFETWFDa0OMprNDPdNEtME3QMAaRGcDkeELXie/iBPWJPvMKVJmol0=;24:90WmnK5/NYfcnaWFNlPhy7vGVtBdRfM06S4JYsKrXuulY6RqHR9fGBsRotedYPIcFCEozMnLIvoo1bdqHSUVJffRLndAfFi28bpAHd2WxyE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1342;7:f2P9JhdilVHcBy4ZiLEr8xIqgWue315KhAbkEQJwDtD42CnmaoNZ+Sfq4+P9iM0BEkTMu1sw6bB4W9oOpER1q4O0bWZakZdq/IM39xUrtQiYxC5yMaXz2HofID/2dmy2scsnLFoHelc/1MQMWppsjd1tjJ4EtR+AdZTMbYIUu2sD6CaDAC2q3kFxUDhSwctNvD5DdDfM5d4AnFmy9qbhIMGjS+fFUf3aIQRX+JqAily9h6H7R9SWPH5U0x15fAlS;20:3H0aFpP/q8KzHaLT01+tKvv3hpS5nMZv/nPD8S5K6ZTlspuWy6EQ+RUs0OkZKMEKE6JDkR9c9WaiOaLPjxJ1MbK4RrYxWLttmrIyoP/M8ut5YlIvfQZTFjSu77FogxKfLfgfMx7ZaF373By9ACX2QMXzyLgkBldfVyjQpwwCvS0=
X-MS-Office365-Filtering-Correlation-Id: 832d46eb-afa6-4511-5600-08d5a46b7087
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2018 13:59:29.1666 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 832d46eb-afa6-4511-5600-08d5a46b7087
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1342
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.04.2018 16:31, Jeff Layton wrote:
> On Tue, 2018-04-17 at 14:53 +0300, Kirill Tkhai wrote:
>> Hi, Jeff,
>>
>> On 17.04.2018 14:42, Jeff Layton wrote:
>>> On Thu, 2018-04-05 at 14:58 +0300, Kirill Tkhai wrote:
>>>> I observed the following deadlock between them:
>>>>
>>>> [task 1]                          [task 2]                         [task 3]
>>>> kill_fasync()                     mm_update_next_owner()           copy_process()
>>>>  spin_lock_irqsave(&fa->fa_lock)   read_lock(&tasklist_lock)        write_lock_irq(&tasklist_lock)
>>>>   send_sigio()                    <IRQ>                             ...
>>>>    read_lock(&fown->lock)         kill_fasync()                     ...
>>>>     read_lock(&tasklist_lock)      spin_lock_irqsave(&fa->fa_lock)  ...
>>>>
>>>> Task 1 can't acquire read locked tasklist_lock, since there is
>>>> already task 3 expressed its wish to take the lock exclusive.
>>>> Task 2 holds the read locked lock, but it can't take the spin lock.
>>>>
>>>> Also, there is possible another deadlock (which I haven't observed):
>>>>
>>>> [task 1]                            [task 2]
>>>> f_getown()                          kill_fasync()
>>>>  read_lock(&f_own->lock)             spin_lock_irqsave(&fa->fa_lock,)
>>>>  <IRQ>                               send_sigio()                     write_lock_irq(&f_own->lock)
>>>>   kill_fasync()                       read_lock(&fown->lock)
>>>>    spin_lock_irqsave(&fa->fa_lock,)
>>>>
>>>> Actually, we do not need exclusive fa->fa_lock in kill_fasync_rcu(),
>>>> as it guarantees fa->fa_file->f_owner integrity only. It may seem,
>>>> that it used to give a task a small possibility to receive two sequential
>>>> signals, if there are two parallel kill_fasync() callers, and task
>>>> handles the first signal fastly, but the behaviour won't become
>>>> different, since there is exclusive sighand lock in do_send_sig_info().
>>>>
>>>> The patch converts fa_lock into rwlock_t, and this fixes two above
>>>> deadlocks, as rwlock is allowed to be taken from interrupt handler
>>>> by qrwlock design.
>>>>
>>>> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
>>>>
>>>> I used the following program for testing:
>>>>
>>>> #include <unistd.h>
>>>> #include <stdlib.h>
>>>> #include <signal.h>
>>>> #include <fcntl.h>
>>>> #include <errno.h>
>>>> #include <stdio.h>
>>>>
>>>> #ifndef F_SETSIG
>>>> #define F_SETSIG 10
>>>> #endif
>>>>
>>>> void handler(int sig)
>>>> {
>>>> }
>>>>
>>>> main()
>>>> {
>>>> 	unsigned int flags;
>>>> 	int fd;
>>>>
>>>> 	system("echo 8 > /proc/sys/kernel/random/read_wakeup_threshold");
>>>> 	system("while :; do ls -R / > /dev/random 2>&1 ; echo 3 > /proc/sys/vm/drop_caches; done &");
>>>>
>>>> 	if (signal(SIGINT, handler) < 0) {
>>>> 		perror("Signal");
>>>> 		exit(1);
>>>> 	}
>>>>
>>>> 	fd = open("/dev/random", O_RDWR);
>>>> 	if (fd < 0) {
>>>> 		perror("Can't open");
>>>> 		exit(1);
>>>> 	}
>>>>
>>>> 	flags = FASYNC | fcntl(fd, F_GETFL);
>>>> 	if (fcntl(fd, F_SETFL, flags) < 0) {
>>>> 		perror("Setfl");
>>>> 		exit(1);
>>>> 	}
>>>> 	if (fcntl(fd, F_SETOWN, getpid())) {
>>>> 		perror("Setown");
>>>> 		exit(1);
>>>> 	}
>>>> 	if (fcntl(fd, F_SETSIG, SIGINT)) {
>>>> 		perror("Setsig");
>>>> 		exit(1);
>>>> 	}
>>>>
>>>> 	while (1)
>>>> 		sleep(100);
>>>> }
>>>> ---
>>>>  fs/fcntl.c         |   15 +++++++--------
>>>>  include/linux/fs.h |    2 +-
>>>>  2 files changed, 8 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/fs/fcntl.c b/fs/fcntl.c
>>>> index 1e97f1fda90c..780161a11f9d 100644
>>>> --- a/fs/fcntl.c
>>>> +++ b/fs/fcntl.c
>>>> @@ -865,9 +865,9 @@ int fasync_remove_entry(struct file *filp, struct fasync_struct **fapp)
>>>>  		if (fa->fa_file != filp)
>>>>  			continue;
>>>>  
>>>> -		spin_lock_irq(&fa->fa_lock);
>>>> +		write_lock_irq(&fa->fa_lock);
>>>>  		fa->fa_file = NULL;
>>>> -		spin_unlock_irq(&fa->fa_lock);
>>>> +		write_unlock_irq(&fa->fa_lock);
>>>>  
>>>>  		*fp = fa->fa_next;
>>>>  		call_rcu(&fa->fa_rcu, fasync_free_rcu);
>>>> @@ -912,13 +912,13 @@ struct fasync_struct *fasync_insert_entry(int fd, struct file *filp, struct fasy
>>>>  		if (fa->fa_file != filp)
>>>>  			continue;
>>>>  
>>>> -		spin_lock_irq(&fa->fa_lock);
>>>> +		write_lock_irq(&fa->fa_lock);
>>>>  		fa->fa_fd = fd;
>>>> -		spin_unlock_irq(&fa->fa_lock);
>>>> +		write_unlock_irq(&fa->fa_lock);
>>>>  		goto out;
>>>>  	}
>>>>  
>>>> -	spin_lock_init(&new->fa_lock);
>>>> +	rwlock_init(&new->fa_lock);
>>>>  	new->magic = FASYNC_MAGIC;
>>>>  	new->fa_file = filp;
>>>>  	new->fa_fd = fd;
>>>> @@ -981,14 +981,13 @@ static void kill_fasync_rcu(struct fasync_struct *fa, int sig, int band)
>>>>  {
>>>>  	while (fa) {
>>>>  		struct fown_struct *fown;
>>>> -		unsigned long flags;
>>>>  
>>>>  		if (fa->magic != FASYNC_MAGIC) {
>>>>  			printk(KERN_ERR "kill_fasync: bad magic number in "
>>>>  			       "fasync_struct!\n");
>>>>  			return;
>>>>  		}
>>>> -		spin_lock_irqsave(&fa->fa_lock, flags);
>>>> +		read_lock(&fa->fa_lock);
>>>
>>> Does this need to be read_lock_irq? Why is it ok to allow interrupts
>>> here?
>>
>> Read locked rwlock can be taken for reading from IRQ once again even
>> if there is a writer pending, while spin lock can't:
>>
>> void queued_read_lock_slowpath(struct qrwlock *lock)
>> {
>>         /*
>>          * Readers come here when they cannot get the lock without waiting
>>          */
>>         if (unlikely(in_interrupt())) {
>>                 /*
>>                  * Readers in interrupt context will get the lock immediately
>>                  * if the writer is just waiting (not holding the lock yet),
>>                  * so spin with ACQUIRE semantics until the lock is available
>>                  * without waiting in the queue.
>>                  */
>>                 atomic_cond_read_acquire(&lock->cnts, !(VAL & _QW_LOCKED));
>>                 return;
>>         }
>>
>> So, when we replace spinlock with read_lock(), we don't need disable IRQs anymore.
>> All we need is to make write_lock always disable IRQs.
> 
> Got it, thanks.
> 
> read_lock_irq is still used in several (rather obscure) places. Does
> this mean that we should do a global s/read_lock_irq/read_lock/ and
> remove it? Or is it still useful to disable irqs for some read_lock
> acquisitions?

I haven't analyzed them, but it seems it's possible to introduce a situation,
when rwlock nests with exclusive lock and require to disable IRQ. Let's see
at fasync example. The deadlock also was in:

	https://lkml.org/lkml/2018/4/5/125

and we could fixed it in another way by disabling IRQ during read_lock(). But
in case of fasync we are successful as exclusive lock is not need, and we replaced
spin lock with rwlock.

If the rest of places nest read_lock() with spin lock, they are need in irq disable.
 
>>
>>>>  		if (fa->fa_file) {
>>>>  			fown = &fa->fa_file->f_owner;
>>>>  			/* Don't send SIGURG to processes which have not set a
>>>> @@ -997,7 +996,7 @@ static void kill_fasync_rcu(struct fasync_struct *fa, int sig, int band)
>>>>  			if (!(sig == SIGURG && fown->signum == 0))
>>>>  				send_sigio(fown, fa->fa_fd, band);
>>>>  		}
>>>> -		spin_unlock_irqrestore(&fa->fa_lock, flags);
>>>> +		read_unlock(&fa->fa_lock);
>>>>  		fa = rcu_dereference(fa->fa_next);
>>>>  	}
>>>>  }
>>>> diff --git a/include/linux/fs.h b/include/linux/fs.h
>>>> index c6baf767619e..297e2dcd9dd2 100644
>>>> --- a/include/linux/fs.h
>>>> +++ b/include/linux/fs.h
>>>> @@ -1250,7 +1250,7 @@ static inline int locks_lock_file_wait(struct file *filp, struct file_lock *fl)
>>>>  }
>>>>  
>>>>  struct fasync_struct {
>>>> -	spinlock_t		fa_lock;
>>>> +	rwlock_t		fa_lock;
>>>>  	int			magic;
>>>>  	int			fa_fd;
>>>>  	struct fasync_struct	*fa_next; /* singly linked list */
>>>>
>>>
>>> I've no objection to the patch in principle, but I'm not as familiar
>>> with the fasync code as others here.
>>
>> I took the reviewers list from MAINTAINERS and ./scripts/get_maintainer.pl,
>> don't have an ideas what else should be CCed.

Oh, my English. I.e., "who else". 

> 
> 
> No worries. The patch seems sane enough to me. You can add:
> 
> Acked-by: Jeff Layton <jlayton@kernel.org>

Thanks! Should I resend this with some more CC or you are going to take the patch
via your tree?

Kirill
