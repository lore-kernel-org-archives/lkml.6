Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AH8x226WJ/BEfOYiZ9srCi6pYj9H2Eug1bh6vFO/FG8eUNY3pGO53IGmA0PTHlySjRdm28uelrQT
ARC-Seal: i=1; a=rsa-sha256; t=1518020093; cv=none;
        d=google.com; s=arc-20160816;
        b=S/DSzozBBVchvmKB5oZ7ND48rP2K2h2vKZ95AHKFtdtXOm3e2GkHdRDwkt5fxoQ5CY
         MrYtKZ8QUgoAHZ/U/kBVRDn1/QNFNJeh6PIbHnlwISz5XVR1NS58bccTDPETVrpYusAt
         VHFnGPAaHdawoUr1DJKyL+930D29SPGHV+VFzFs49ApZW5h2X8BK7V7CFP/wK95B+wiI
         K7KPO2d1l/9CpWLR7TkpzqdVtUsGMeYEAsb2yU26gBRGLONMECZH4mndQ6aUMp1TPIxM
         P4LJMmbFaO5MqSRWT8ypC5/jFoAMEEDxJ5ODsAmH8uiqj5IPhejRobt9xnOOykvVx4by
         DxQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:user-agent:message-id:date
         :to:from:subject:dkim-signature:arc-authentication-results;
        bh=l0nWh/X/8kd2A2BIDNr8wFiMYCu1p7bwOka4T0fLHsk=;
        b=ukKuNQjs+XsggH8K2affzLlw/hDQPZeCpL5J3qwYMGS4TVPeAdJjMWuO9juUl+Qrwr
         y+HtKSuCMKaUiwlYTNXyJte7ABqQ61Pd288/N75VSPZ3eYGWuxz4FG6nh4NrB0cxyX25
         7+M6fBDbUdQpZi4UbOIL/asV46pMhTNJttvsZK7gUJU+Gfc+4Ako0ZiZH1cIxg7Sk3uo
         l65dG4ydQV5MZOFZs7ICBRZiMJ7Bdm1N9b0JyhAWFDJ8QY0RE0QXevugEDQW5HbrKvWQ
         bqsClNyZY6pF9w0P9bQvLDQe/307hvJ7dlLGYMl+WNiOgvNEa2dHlczw0KzFTnlx2rKz
         xPuA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=QMeqoHDr;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.1.128 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=QMeqoHDr;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.1.128 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH RFC] x86: KASAN: Sanitize unauthorized irq stack access
From: Kirill Tkhai <ktkhai@virtuozzo.com>
To: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
 aryabinin@virtuozzo.com, glider@google.com, dvyukov@google.com,
 luto@kernel.org, bp@alien8.de, jpoimboe@redhat.com,
 dave.hansen@linux.intel.com, jgross@suse.com, kirill.shutemov@linux.intel.com,
 keescook@chromium.org, minipli@googlemail.com, gregkh@linuxfoundation.org,
 kstewart@linuxfoundation.org, linux-kernel@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-mm@kvack.org
Date: Wed, 07 Feb 2018 19:14:43 +0300
Message-ID: <151802005995.4570.824586713429099710.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR05CA0153.eurprd05.prod.outlook.com
 (2603:10a6:7:28::40) To HE1PR0801MB1337.eurprd08.prod.outlook.com
 (2603:10a6:3:39::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67e14ccb-b841-4e14-16c1-08d56e45e8d8
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:HE1PR0801MB1337;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1337;3:iY1hsMiaz3gjCd3owww0rKHZZ31lHHJ4LUi7Yi9E4mZgNPjNPcUNhlE78aYqpjw5w69I+mkfSSi8GG7QPgnYzcg6/n1Aoo696N6Kq5AGBpBuLD5zDyQhV9C2icRFJ4Ycjfu885WMPiLEfKFoeno6wcEadQr0kE6wzobhhs9IU0jZ6K5iWdbnV6bucPc7KTuZ8u9qgLlcRKT5zcK3+NtUGaNp1vSL47DFshUvdt2oyTsCxmz6u6nTJyqgu+FkZcZD;25:A4H7Pul9l3IjKNAkBtJUSWZLlK/tcGmgVQXd7Z/tNZOq2ydB3ca3mbWvABCZu3wuf/c+Qn5xvrTK8brh2JYb2KAB4keHqU09IL+UWyW/vO36Mx1DMEGatIH968OxytGmL6YEppsk9fgYErTbiRJTGWusu+r+rJuxddj2V8gV885EjHmA7IbwkL3o6i2dP0vNik/KBC4n97eySPLYK3qis9JFShVOeJyinoVriEmAKARbu/9ggFYLRg/Tq90Di/Ao7LmPbG5UvRcVjClpU8RKZs+tOm8XRUxe8wQOW23TtjHpZ4bP1eeQaVmp8b3YozpBLj4bQzO/ocoXMcvjK4TSIg==;31:hRdzNPOKFqDkcqPiimAqw/QVfd8SfA+QdJ7fBwzr8KhXfwWk0IzJGwnHmtXs8DYm8+bm97VkncyH3pnCgBGR6sKQ7OUho2O2dVNWeXvQgRFvjZE35EV8tc87wQTA8ZN3Z1vQY2DGJm/eA1RwX4X5y7rybp8p/Ypd/EPrQW0i3gg+hGHSzDB5w+7hW0jsqaoDW8WBp5wcZlCG1RkO1NHPG1kbeu70qqyRnmxXUVshCUs=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1337:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1337;20:IdzNguAfVW8oYk7Ze7+ICTyi2CKRX8a1gXm+5+0qvO7kanuvyi4bHa3dx22j81zN3PidmZn5yr2Ygl5cnsN/IT1HQ2Sp3JnSD0IPKMgyFvA9ySLlVzohQZiFg5S+fJVUH7ECjxq2nTlWJBuFR32HovJjNlHSjujLQoRt2YDT9nZx2HzcwRnKAdyV8lGCNrIzkh0uo+p7YKKma3ogg9Ej7DqqJLSBEWbXsGjH2pncapB4YHvkhQIvf8pkcDvkA9w/WJKDZ1nM//K1bvdoxwzFqrL488IoidFRc1eWa/6nP9kz++ziFGCxVGftOkRRW77wzn2uUzX4Hj/9V0h+/RpORTxhyaMyVkYYLyo0HKJxebMiT0bN5DE8fC6LRjLDGTRce/tHJx+xwGOPkkhFqXOxIWvWniynhMMKqxjqVzX7CTY=;4:DrRHFP/raOuKixRe7qc1IyFA8txjznWr8tTK6C67wTYIHhZ6jeM06GWQfb/uuV0+hwBNVmLIKGaf+AFXWmzNdFvTn3aka/esbDnVn6s1UkDSC9nMp13LvpVZOK5K2SnrEoYq9jMowjnH20yjggua8Nky26kKOuV4Lk7iMfPPQGrOFIUIfULPGuZ80H86HBKeupVbZgD4/0elLG5bjHdthLhFWhLo5b32St4GgSYMCJCwLthutCU5ozglOfpR9fD985ZgYu5/BbK3Q6ol/JzCNQ==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB1337C4D83C7F918A4BD9F96DCDFC0@HE1PR0801MB1337.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231101)(2400082)(944501161)(6041288)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:HE1PR0801MB1337;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1337;
X-Forefront-PRVS: 0576145E86
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39850400004)(366004)(376002)(39380400002)(396003)(346002)(189003)(199004)(61506002)(3846002)(6116002)(316002)(58126008)(7736002)(305945005)(53936002)(2906002)(106356001)(86362001)(83506002)(575784001)(105586002)(478600001)(103116003)(81166006)(50466002)(6506007)(8676002)(81156014)(386003)(6666003)(5660300001)(47776003)(66066001)(230700001)(68736007)(25786009)(33896004)(55236004)(7416002)(8936002)(59450400001)(16526019)(186003)(9686003)(7696005)(52116002)(26005)(55016002)(23676004)(2486003)(97736004)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1337;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzc7MjM6akJkbXBlNkNZSk5jVzBkbk1Fb0k0SzlZ?=
 =?utf-8?B?M2Y0VU8rYTNvU0s3MXV0M3hvdjBubDlIb3BxWjZ0bXNleG1XUmdYNnQ0UENY?=
 =?utf-8?B?dm94ZVJZalZwbVE1Y25hY1EvZ1h0a1doejFhWkV0RitYV2cwdzdzSjkyK2Iv?=
 =?utf-8?B?UEprOTBzUVBoSmtKaXRrckx5QXgyMmdxdE5ySm1zVGI5WDJ3ekYyS3kwNEpu?=
 =?utf-8?B?aWs4RkJUMzNka21sanNsZUZMZUhkTGE2aTF5KzRtajl5UWJkUDRlZGMrT0Ja?=
 =?utf-8?B?REZPVXoxYmU2c1lySWtPTDRVa0M2WThiNTd3T1F0TlhXTm1Va1h1M1R5alVa?=
 =?utf-8?B?U2NETEFMejZvZG1kZGdmNDBXZk9PdmhPQVV4SzdiSmlIbkNtR1hUOGhXZ3FU?=
 =?utf-8?B?dytlQTFWaVhIYnl3RnJwTE9seUZTMGtPQ2thQVpSNlVYNytPMnJmUVhWTFNT?=
 =?utf-8?B?REJRNVJ0RnVVcC91NW9BWVQwVE9wZkdETUU1czRWcGdockVPeElLRDZ2WSts?=
 =?utf-8?B?Q0g4V1hWelFRalh5TUJKTmJjSk1YNkhrNlgvekJsMElDRmliRHRZWXhlUjFw?=
 =?utf-8?B?T0dOeVQ5NGNIczBKSEQ5Z0c4cys4eUFyQVpKaExmbDdWMEtlUjB2d3h5NVVR?=
 =?utf-8?B?VlB4SjdKbGRLVk80WW9rbFFiWXNqaFBQNlhqZXZHRENXT01JV1ptY1plYlF0?=
 =?utf-8?B?eWtzSGh1OXVOV080MURHUG5nZlZ4Z3VsdC9FNmFDa3djSnNUcEVyQXlVcDh4?=
 =?utf-8?B?eUFUeWV6bHJrMjdYRHZTcjZRMWtrdzFYOU53K0xScmd3RytBdHBiYmdnenhh?=
 =?utf-8?B?QWUwdVhiclFSc2NQbVlTMS9aRkcvOERpWSt3MERQVnZVTXFjQ3czTkxWY0tk?=
 =?utf-8?B?cmpReWp2aHlZQ09mcjYwamt1YzhGTHlydlVQcjdSNHBDdVBTS3prOVU2Q2Mv?=
 =?utf-8?B?bXBrdGZsMHAvd0RzL0tCT3l5emY1bExYdXhQUkVRUHdFNUJaWFh6YlFwWmQv?=
 =?utf-8?B?TEJLdm92SW5PYmFOM0YwR0NJQTZKcE0wejl2R2IrODRXa0JKNUxSMms3dDRW?=
 =?utf-8?B?MWovak1PSVJVeTRMakQrNmxhOTFpTU01K01pbXpwUkR2aVNDM3VVQW1DOVVi?=
 =?utf-8?B?amx1empwSGYyQzYwWXJWNGZhQkxwR3FuUzJLZFdCQ2JreUVzUWdueFpNa0t1?=
 =?utf-8?B?S1Uyam9oSXJHZzJLdDJQZ3FCYnFVc2VSczlJQ1puVktpR0lVNk83VmJXS0VU?=
 =?utf-8?B?SDhOZFgveU8wN2RQTjlQSUZHMHdWcnA2YVJLN1ZmVFZHblBvOW5sVWZlaVRo?=
 =?utf-8?B?WXFjYWc4LzR1VmFBNjBxcWN5WFlUWFRZMkE1TW56RVRkOXJWT2N0M05zMjhx?=
 =?utf-8?B?M3BZdURCbStZWTR0VGJaelc3Y3IvNkIzeE9xM2lUc3l4eWZndDBtMElIVWVk?=
 =?utf-8?B?c29lMGNZb3JiWWJkeUNHdndzc2Z2Y2psNUkzOWJtR0JJSUFjTUFZaHhuOG43?=
 =?utf-8?B?MzIyQ1R1VG94eEtyTVJGcTUxQ2Q3UHFRVkxnOGU0a2JlaHIwWlJpaDZ1UE8x?=
 =?utf-8?B?TzVDNkRDUUdKVlF4WFdwM3VJVldDQzd2MEZMRHltQzhtWWszTUhqUHNqNDhK?=
 =?utf-8?B?LzVvblBmOXl3TDZoRGFsQ05MUDlxZE9RbEJhRmlXR1BVcVlJTnZqaUhVRzlY?=
 =?utf-8?Q?Wd3eSN9gpvCWJl+L5vjo=3D?=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1337;6:nywOFcBD6qIvU8I8JkZ5exbrdTvllVquQrY0ocl9oLmHRGGjUFaJ6Kevj/5NgvmZYrSIdI7r9CtnTmNRzSgHHtjHVC5ZVY9UmwY/qtYgRpAhC47n8DFUeyxufsGIOoFb4L/K4PbMC1CVbThJAxBHXR+5zp5OfXSn/qUdCJmo5CPRMlyI0SZsnmrX0d0iK1b6LEF6+rba7UeLa/ww4Q4iGhonRjwLGlM5ym9FjVlE5DlnYVWFK5wPR23scKipfNmhaCMFfW9U/vbUcsdE2aADCgoiSLPjOv3dM9Zwryay5jmIZWGrEYmpNApEPttza1Y0V+DoeD0mDuz7f8LMVuexVRDRZd4FjPjb4OK9cTGjAUo=;5:Dx1l0P9g1TjaVTH9FqGKI7/JGFn1aeREfziW+2mCD5uUSq2nhBepcGlBCa2hQ/HckolJJc+stV7mTuW71ZOZl2uwY8SqiT5cfZpQMSLUu3EUCcu0HwA5sP1fnoujS4jABj5wE4c7j7Xq5i6eQFotzNWKJTLxINc4O9SGCAvzZXY=;24:LYeOFRjxE8FCgDUTpfOs5Ry7ENCkGOlNaks2/kxRZlRKdpUffWNdNZDZJ082lNfOFBonnK9tgTSv2cUbV+UP1gHdFR58VJkpODvFzaKRqk8=;7:yF/8OTveSJ8tdhcf1PgvYs4Sw0t7yxX7D1Pel4jGrrluLmQDSv8g/irLjNM1VFHflMuwQhDID4+jCqweSzzPz9GAYBAq/nEmq+6SAkSL4CxYCjNyKvuV1Sl+TEAqD9H1fW51qBfDf6t7sUIyUZ04fiLDkxPNvmdzCfjVXthqRTs33C/B2LOelM+fEYzO6BWfEwblhOHFBoRWhj1+yyzFnTjQSHcEpFJH9Izqizp+/aakUXZq+os8U91tR5hjg4fO
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1337;20:95oRfU/I57Qx7Ep/TQxWLD+I0qZxd8M3BZjRNT+F/Xgi3jsl/elq/mHWOcwDlsLi4pACbWlIYlXvJZW8k8RwwrbgqZiPly722g6BzuQWtiPikR/z26o95pYwxiNTt7IBQTf72UejAVof/V7/+WeTwSc5Sx0RrAPncvOivEHLHOA=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2018 16:14:47.4817 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67e14ccb-b841-4e14-16c1-08d56e45e8d8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1337
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591759437440105803?=
X-GMAIL-MSGID: =?utf-8?q?1591759437440105803?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Sometimes it is possible to meet a situation,
when irq stack is corrupted, while innocent
callback function is being executed. This may
happen because of crappy drivers irq handlers,
when they access wrong memory on the irq stack.

This patch aims to catch such the situations
and adds checks of unauthorized stack access.

Every time we enter in interrupt, we check for
irq_count, and allow irq stack usage. After
last nested irq handler is exited, we prohibit
the access back.

I did x86_unpoison_irq_stack() and x86_poison_irq_stack()
calls unconditional, because this requires
to change the order of incl PER_CPU_VAR(irq_count)
and UNWIND_HINT_REGS(), and I'm not sure it's
legitimately to do. So, irq_count is checked in
x86_unpoison_irq_stack().

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 arch/x86/entry/entry_64.S        |    6 ++++++
 arch/x86/include/asm/processor.h |    6 ++++++
 arch/x86/kernel/irq_64.c         |   13 +++++++++++++
 include/linux/kasan.h            |    3 +++
 mm/kasan/kasan.c                 |   16 ++++++++++++++++
 5 files changed, 44 insertions(+)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 741d9877b357..1e9d69de2528 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -485,6 +485,9 @@ END(irq_entries_start)
  * The invariant is that, if irq_count != -1, then the IRQ stack is in use.
  */
 .macro ENTER_IRQ_STACK regs=1 old_rsp
+#ifdef CONFIG_KASAN
+	call	x86_unpoison_irq_stack
+#endif
 	DEBUG_ENTRY_ASSERT_IRQS_OFF
 	movq	%rsp, \old_rsp
 
@@ -552,6 +555,9 @@ END(irq_entries_start)
 	 */
 
 	decl	PER_CPU_VAR(irq_count)
+#ifdef CONFIG_KASAN
+	call	x86_poison_irq_stack
+#endif
 .endm
 
 /*
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 793bae7e7ce3..4353e3a85b0b 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -404,6 +404,12 @@ union irq_stack_union {
 	};
 };
 
+#define KASAN_IRQ_STACK_SIZE \
+	(sizeof(union irq_stack_union) - \
+		(offsetof(union irq_stack_union, stack_canary) + 8))
+
+#define percpu_irq_stack_addr() this_cpu_ptr(irq_stack_union.irq_stack)
+
 DECLARE_PER_CPU_FIRST(union irq_stack_union, irq_stack_union) __visible;
 DECLARE_INIT_PER_CPU(irq_stack_union);
 
diff --git a/arch/x86/kernel/irq_64.c b/arch/x86/kernel/irq_64.c
index d86e344f5b3d..ad78f4b3f0b5 100644
--- a/arch/x86/kernel/irq_64.c
+++ b/arch/x86/kernel/irq_64.c
@@ -77,3 +77,16 @@ bool handle_irq(struct irq_desc *desc, struct pt_regs *regs)
 	generic_handle_irq_desc(desc);
 	return true;
 }
+
+#ifdef CONFIG_KASAN
+void __visible x86_poison_irq_stack(void)
+{
+	if (this_cpu_read(irq_count) == -1)
+		kasan_poison_irq_stack();
+}
+void __visible x86_unpoison_irq_stack(void)
+{
+	if (this_cpu_read(irq_count) == -1)
+		kasan_unpoison_irq_stack();
+}
+#endif
diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index adc13474a53b..cb433f1bf178 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -40,6 +40,9 @@ void kasan_unpoison_shadow(const void *address, size_t size);
 void kasan_unpoison_task_stack(struct task_struct *task);
 void kasan_unpoison_stack_above_sp_to(const void *watermark);
 
+void kasan_poison_irq_stack(void);
+void kasan_unpoison_irq_stack(void);
+
 void kasan_alloc_pages(struct page *page, unsigned int order);
 void kasan_free_pages(struct page *page, unsigned int order);
 
diff --git a/mm/kasan/kasan.c b/mm/kasan/kasan.c
index 0d9d9d268f32..9bc150c87205 100644
--- a/mm/kasan/kasan.c
+++ b/mm/kasan/kasan.c
@@ -412,6 +412,22 @@ void kasan_poison_object_data(struct kmem_cache *cache, void *object)
 			KASAN_KMALLOC_REDZONE);
 }
 
+#ifdef KASAN_IRQ_STACK_SIZE
+void kasan_poison_irq_stack(void)
+{
+	void *stack = percpu_irq_stack_addr();
+
+	kasan_poison_shadow(stack, KASAN_IRQ_STACK_SIZE, KASAN_GLOBAL_REDZONE);
+}
+
+void kasan_unpoison_irq_stack(void)
+{
+	void *stack = percpu_irq_stack_addr();
+
+	kasan_unpoison_shadow(stack, KASAN_IRQ_STACK_SIZE);
+}
+#endif /* KASAN_IRQ_STACK_SIZE */
+
 static inline int in_irqentry_text(unsigned long ptr)
 {
 	return (ptr >= (unsigned long)&__irqentry_text_start &&
