Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12D8ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 17:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76EF920684
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 17:52:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="i0Yenu7a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76EF920684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730798AbeGQS0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 14:26:24 -0400
Received: from mail-cys01nam02on0110.outbound.protection.outlook.com ([104.47.37.110]:23456
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729709AbeGQS0Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 14:26:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fpfni3mi+Kj0b3PZ+lXMRe99bChidQR0xCgq4JwDBeA=;
 b=i0Yenu7aNQbYH1/c/2Zire4fYMdSKAe5mgYX75+k+WvPROBlH6/Q+S7v1I/jL7NRTjyvqKpgDBxrMjkYNH4KC2yzRKde3NPHFf7mF3LTiEHbQWVgI9QoPLQCbMDH8mcg6e35mwV5pTWVLtOVKRyJczVcaEWOxXBKcFFaNAQiwlw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 BYAPR08MB4934.namprd08.prod.outlook.com (2603:10b6:a03:6a::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.17; Tue, 17 Jul 2018 17:52:34 +0000
Date:   Tue, 17 Jul 2018 10:52:32 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>, stable@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: Change definition of cpu_relax() for Loongson-3
Message-ID: <20180717175232.ea7pi2bqswnzmznc@pburton-laptop>
References: <1531467477-9952-1-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531467477-9952-1-git-send-email-chenhc@lemote.com>
User-Agent: NeoMutt/20180622
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: MWHPR08CA0046.namprd08.prod.outlook.com
 (2603:10b6:300:c0::20) To BYAPR08MB4934.namprd08.prod.outlook.com
 (2603:10b6:a03:6a::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69827f20-69f5-4ddf-46ae-08d5ec0e13cc
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(5600053)(711020)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB4934;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;3:ZsjNOFWnaxynZKLhDbNQONmnkT+NEDM/8VmlY4SkXECcW1NOPbskywjumwWs4+phHthonNb/q//BpUfPxj3kf4/4q3pao51h/M7oxoaMtVty24z1TM0s9O3Uxtirc2naLD7i+8cutiuL3LdWFrBTJWl2LmRJgEdxnUBTQqADkiwgF33GM9x3251w9DrskJzuVpRrgIAKMXWaFdVv3kJjsNd29xFk0MhXJVXUPx1frovk+9Af1HaSFg/FFiqXOEY0;25:qm/dqndYl9aQrtEveHpDWEC8Z54pgez/U2fXOUDdfaY3BFd3THtLJg8BsTldgR7n9b+jS0x7zPDY46nRRn+tYasmb6xZfKPAcyAaeWmlf8oKOyifnuNwB0yjrPJ8x5YLMrDUjPnHm1oG4H5WZ9qV5IIlh5KpM22HamI9DDIylmXPswUmF0aiMPcSPipKEqWnKib15QGOdF7SI822mdnvp1E7R8jKzQd3xKH9OavXG5nw4Qg8wd6uxJerz9e1V4IsvactMt9QFnFPq5/IKM6g2W8r8/kKCXgESVjHFRon1TGcwa7PE0SMyS4QzY3a843CnyjA7/AKvRY77v+RTRNFTg==;31:RR9zZP63A6xhAMOGrF8iLhb1S1xazjFzJNjaG7yJmbBIdSGKNXHg1lx+RLQMGrFMYJ8RF0VZfDXjINOUdQzgf9/Bttu0JaDa5jFs08bosJBg7fxRUihw60Y1+fjv2EdyVzx6JQ4dfGkBkk0uIzaEle5xbZfGwFQThrM3V81Z6oVM+LoJ8nAVxxBWidSIQEX986wxjKfJGZCK7i3KUAHgEcN/t/LCc5RPI3busEf/9bg=
X-MS-TrafficTypeDiagnostic: BYAPR08MB4934:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;20:APzc69KQdXhNcetLeRAwyPCUw62YFuKgkQwwR1eiBFIDvmoE3lKsuT6QcMwDN3FvIeOTCDR/dlhHa53yGnwWbU5lkNdfgur41TVPJYvNAR0poZe/Z8jYqBK6jE7p+3OH2tnPEcM8msm6wLdVkQNFBlK9vcypiscFVT+TUQJ9HIkinIYasLkX1BKjtD/sn6QCB1ykxH8rPLReFXkZzfqxk5ifovzx4fjAeCCfjdUEpC/EJoMu89RNR/9qcC9iPwGc;4:7hyP945O/w2Y73R9BPXbIhaAGeT4dpnNm/DwVOEJ3IXVkJfCslJW7KPtdSfzIPNL9PVM/ifZP0wvJmS6IDhZg80F1w+/zdE4E8ALqkX1gnpKMrc0A6ANngrSUTm1GeFPbRiukGWB684lIMrPxovwhrXkCgaGgDaCVOA1XZDTff4MVFCOgQpilrzitpamZeX5I4cUHISpZPtGiA56jkC9vcngsx+Do8fDpCf1GeDOzVEPz5LF0rQ0SUXj59kTzLASti/GwHJCK58Wmxu9GQTr6q572PX8Bzqh7+QmBT6+58JrkaGH1WEjypjEpU9/ON4L
X-Microsoft-Antispam-PRVS: <BYAPR08MB4934FC369FBE5D53EB916F7DC15C0@BYAPR08MB4934.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(10201501046)(3231311)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123560045)(2016111802025)(20161123562045)(20161123564045)(20161123558120)(6043046)(6072148)(201708071742011)(7699016);SRVR:BYAPR08MB4934;BCL:0;PCL:0;RULEID:;SRVR:BYAPR08MB4934;
X-Forefront-PRVS: 073631BD3D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(39840400004)(396003)(136003)(346002)(366004)(376002)(189003)(199004)(305945005)(76176011)(7416002)(5660300001)(1076002)(47776003)(6116002)(3846002)(66066001)(7736002)(23726003)(68736007)(50466002)(8936002)(8676002)(81166006)(81156014)(52116002)(105586002)(53936002)(58126008)(6496006)(386003)(16526019)(42882007)(186003)(33896004)(26005)(4326008)(316002)(106356001)(25786009)(76506005)(97736004)(6916009)(229853002)(39060400002)(6246003)(478600001)(2906002)(33716001)(6486002)(486006)(44832011)(14444005)(11346002)(476003)(9686003)(446003)(16586007)(54906003)(956004);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR08MB4934;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR08MB4934;23:FVcVxi5UofBhPX1EUY3LnboFhLHPFdYLYcakGd3GE?=
 =?us-ascii?Q?n490NaMM3MVqsgF+15DFfkU2Etxs29ISXFPvOhwYwo4eFJRrnrOKPuQekYWQ?=
 =?us-ascii?Q?9LeQHzzc+D8EPgvxWYg+g5d+EVcpXotoO6KCDDE+Xve+MeTc/paHtB3NZbKN?=
 =?us-ascii?Q?Z08mZNa6sCbdYB6ZYZm01qKEpCrIZ/SSB8S5YRjkFm/S6DHyLLVVZmqIbS8y?=
 =?us-ascii?Q?jDtLFx+JL+OMQ+kOAe7MgkZ6rSVpn6ovjQcr/Av3G8ZlKQM9NzIACUCbhr3V?=
 =?us-ascii?Q?hzEX9+K4lax7xmV9Lox8N46ZKwSZZ6D5eFHTsVfFx2RBpev0zq3nEmDd3zi4?=
 =?us-ascii?Q?A24J1V/OfIsAI8w87JKEZLvZToy6mC3TFjTfDJPMre/CZXt3fpza4ocv8Iv4?=
 =?us-ascii?Q?QdpT/hB4OzngrfRfpTbon2W3AvigenaqjnSIWdQI1+qCaSi83h/y3EaRkqgR?=
 =?us-ascii?Q?34cHhHRkAPoLfcCQBUseRQEvMMX/AJIh61ZYRTL+zCekgaOHcqxqkjjprY+0?=
 =?us-ascii?Q?fhcgvkrubJZ4fMdQQbuwHZkKWf1XLr1Z0t+pXf6TAkhqo7m6DIebZaddyJOH?=
 =?us-ascii?Q?opz/XQ4mdp68SlcR8woLOmT5c65hZNXOZw4klEPBO2pEkBzIOtQ9d3tVZinr?=
 =?us-ascii?Q?EsjZHpiwdXmuZMMQC/jvxhSf9gXBi9hhEPpzT5peU72A+e2P7nKqBN4qJU1/?=
 =?us-ascii?Q?gHfzm84N/ZNP9vUSxkqTAni+/R0XFd4q6K6XB9MaE5XtjKLqA32v3vXeRgqK?=
 =?us-ascii?Q?HdDNmQcIx7hZ0a15A8MTPCx/yDLMw8P+33pGBNH+Hr1lTtsuUbi8CRF3UCyE?=
 =?us-ascii?Q?xpvnD33aM+oj7E+GXjk92V4DQc8UqOXOSPDBV/XvHrl7nudqtbk8Har+kCML?=
 =?us-ascii?Q?zWnF8cYh02d1BYX+6MSmfJFVZxvtxaJmeMNtMn/TaL6pQfm6WytFca4Dxbfz?=
 =?us-ascii?Q?nmKr2mKleoMjrhe2EkU/wbCqyOy7ubzfWBkg7gXA8fjAQPOYbgEaEGz10fbQ?=
 =?us-ascii?Q?p+rH9JVEl3G0A3afkJYOS2+Xcxo4pSFU/8B+gQD+BCgmhlCPPg7u6SaUzg1+?=
 =?us-ascii?Q?UIpN7OzyZhjBgS0p0MS/3VtLGadxYn/LBVZjQpGmMwTS4SfOJZoXITxIN+02?=
 =?us-ascii?Q?FTxahghydq2W7uJW18aosgoCiA3iElOO5rkW15bGfxNBhcsbpo1AlI/y3ocb?=
 =?us-ascii?Q?HSIDW2MCOC5oo05SY1LPvxN3JD0ll9CNDOej0BrXA4sL+jh1Eg1oEjRPpxiK?=
 =?us-ascii?Q?17oWDxke0IP+/Q+wuXiM2aA+YVF2YCcNh/1LLFM0jh77xYrFDNKbvYxla4kM?=
 =?us-ascii?Q?plpBsufMAnoGBCzvC4TpktP02m7/N7dAxVN9MQKnbDQqzwu9Eyt29vzEdJQg?=
 =?us-ascii?Q?Ongyw=3D=3D?=
X-Microsoft-Antispam-Message-Info: pEDLCj7EH47OHQcTSuISpcxove5HpOA9vqoCCUQ9oHebFBsSnq/0QisibF/hEBi+3rwXAZD4RI3lrjRHKIXUl5ZYhy5kupx4U6xl18g2KvqXVifW0HFQWSKvvcawxfxbuBJG5AOe4xBpjvIx1NmP53qwiN6XDQuyaB+PUjyhnXqr3Es62Y5zkqU2Yl760Du0v87kzyBbV8ytkSeIvwKoNvHAWEIAqc7NBThgIoKOpEXUMt/vdiUbFb5QS+DXvw5vVm9bR7NLNNXCyCBMEXyaECToCCwo0NO3je1Xdubi2VDjkTUVYZckXl7n8HjYnwCku6cR3CrjXVnNcUkXyO9rHMNbC4X7oEzgXu+9tOlLAVQ=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;6:LE/r35ON8GZhX+BZbDoHSOEln/3ZNygKz4LaMmeKx8ptHCYkY2KbJQoXBPH3k/TZksCnjFeJFiJp3ad+getYjklPOSODcYy9OEF7gCxfkkMUB8GzGBBZZ2nCt998Q1f9V+/irL+cuF9yNz6jv6mg7n00vqhCsgFDdmjQyYp0/cJsD3WGOBc9ti5PHaY17yZoT8HarYYYCL48hhpY9E8fl3sGp2yGb0ihosHGo/Fe484v8j3nPjMy7WZ9sjDh/59kuhZwQsRP4aXzhzkAQhRQEf31UvqGz7UKnngJdkFvpXYysiBnKDvcAQ8PBDCoOmcZQtQ4pXGCT43GaY5O3IGpFPX5cJshJdNwvSFtVI4au7OEqZTsmCjI5B/Dl68us5wl4V+Y9XmOjN5LpjU7DLch0iaHSJLCxuS6d96Xme3DRus1vPFodCXySgGoVmu7LNnzfLfDOglRAF+gc4BJf3+WjA==;5:i+dd1eTbAkFy2fdhxzG7WKkIxGP2GmzufxAjiRcSF0TuFnJ0LNdffhKewP10vmgre3POfadZRFpOLcUFPYnu/pPZrkSONDrwjYhkBFGw327fQt8e0uidbkJoL7spqLdrsBye+D+5oU0ScKdmj+Rpi7HvuUYahric8sBZgEqRLI4=;24:o3lwxYnSQBg/y4SasgFdQMibJE4IHbHjVujiEOHWgw3v5Li9wylSs5wH0nBrCuzuOYPDoTZoV0GfcP5aHDDuxF1iW3rZwnjPR0qbIAPD6/4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;7:lPuFm9mcEgFF5xuMPmCWIxXvyGeFxvnE7+Qp3QD+OmsH6XQ8E2dOS/yp9Vg/MrMA0rLhUZ8A61lVAlvhV91dcqRt1e3vZ3gnC28rxCuMy62OTaTjNQhI6z9nBbVHRNyvrxekGQSOFW1diXtzPzdfOUfeT1Ko9PYYzhyU9yj+4mqDqmHa/ohXIh6PAm7zCX8eO9t7dotwvpGXYuvldSDaOQfc/MvkZTJUL60NRiiGRPSzL+Q4zFl2Z0MzOiN3A7Wj
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2018 17:52:34.7113 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69827f20-69f5-4ddf-46ae-08d5ec0e13cc
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4934
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Huacai,

On Fri, Jul 13, 2018 at 03:37:57PM +0800, Huacai Chen wrote:
> Linux expects that if a CPU modifies a memory location, then that
> modification will eventually become visible to other CPUs in the system.
> 
> On Loongson-3 processor with SFB (Store Fill Buffer), loads may be
> prioritised over stores so it is possible for a store operation to be
> postponed if a polling loop immediately follows it. If the variable
> being polled indirectly depends on the outstanding store [for example,
> another CPU may be polling the variable that is pending modification]
> then there is the potential for deadlock if interrupts are disabled.
> This deadlock occurs in qspinlock code.
> 
> This patch changes the definition of cpu_relax() to smp_mb() for
> Loongson-3, forcing a flushing of the SFB on SMP systems before the
> next load takes place. If the Kernel is not compiled for SMP support,
> this will expand to a barrier() as before.
> 
> References: 534be1d5a2da940 (ARM: 6194/1: change definition of cpu_relax() for ARM11MPCore)
> Cc: stable@vger.kernel.org
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---
>  arch/mips/include/asm/processor.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/mips/include/asm/processor.h b/arch/mips/include/asm/processor.h
> index af34afb..a8c4a3a 100644
> --- a/arch/mips/include/asm/processor.h
> +++ b/arch/mips/include/asm/processor.h
> @@ -386,7 +386,17 @@ unsigned long get_wchan(struct task_struct *p);
>  #define KSTK_ESP(tsk) (task_pt_regs(tsk)->regs[29])
>  #define KSTK_STATUS(tsk) (task_pt_regs(tsk)->cp0_status)
>  
> +#ifdef CONFIG_CPU_LOONGSON3
> +/*
> + * Loongson-3's SFB (Store-Fill-Buffer) may get starved when stuck in a read
> + * loop. Since spin loops of any kind should have a cpu_relax() in them, force
> + * a Store-Fill-Buffer flush from cpu_relax() such that any pending writes will
> + * become available as expected.
> + */

I think "may starve writes" or "may queue writes indefinitely" would be
clearer than "may get starved".

> +#define cpu_relax()	smp_mb()
> +#else
>  #define cpu_relax()	barrier()
> +#endif
>  
>  /*
>   * Return_address is a replacement for __builtin_return_address(count)
> -- 
> 2.7.0

Apart from the comment above though this looks better to me.

Re-copying the LKMM maintainers - are you happy(ish) with this?

Thanks,
    Paul
