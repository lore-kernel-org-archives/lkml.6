Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94126ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 12:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04AFB214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 12:59:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04AFB214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbeIQS0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 14:26:21 -0400
Received: from lb3-smtp-cloud7.xs4all.net ([194.109.24.31]:39832 "EHLO
        lb3-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727858AbeIQS0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 14:26:21 -0400
Received: from [192.168.2.10] ([212.251.195.8])
        by smtp-cloud7.xs4all.net with ESMTPA
        id 1t7CgvI1Qw2L81t7Fgh9h2; Mon, 17 Sep 2018 14:59:02 +0200
Subject: Re: gpio regression in linux-next
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180917124935.GA26204@kuha.fi.intel.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <9571ebce-d19a-c52f-3273-48dc75168341@xs4all.nl>
Date:   Mon, 17 Sep 2018 14:58:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180917124935.GA26204@kuha.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfMByV54XeUs/Vo3545YAAtwqa1wa5z9/u03oVjmOk5iFqSkSO+6lZ+leFSNoiHNHRqQeCBJtMWh9XXkYjuJT2tNQmnrO/mc3GDKsXLgZ8CJlscQCMFtA
 n2a9aiAsIIka+PDk1HaVjN35VHTpcyfxEB9N/OfO0/sWyrLpuXjXpg/q3Oiv9P33OMycpmIWSDFdorqFc4mixbMbHEf8+5LSFEc3Ub0GK3CurkElAxKbcBeU
 WmgGV0n9B1YtutRmmN6Bc/eaaVYaASQMPlF63dkS/tnVwc2bgytmIVSWJL5cHzIMhjP2ZiYSw3rn4WY0BXMEsQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/17/2018 02:49 PM, Heikki Krogerus wrote:
> Hi,
> 
> I hit a BUG while attempting to unload fusb302 driver module on my
> Intel CHT board (GPDWin). I bisected it to commit:
> 
>         461c1a7d4733 ("gpiolib: override irq_enable/disable")

Does your linux-next have this patch:

https://patchwork.ozlabs.org/patch/969684/

If not, please try again with that patch. If it has, then please let me
know and I'll try to take a look.

Regards,

	Hans

> 
> The issue happens on every attempt. Here's the backtrace:
> 
> [   15.088752] BUG: stack guard page was hit at 00000000e4b17343 (stack is 00000000593f8b21..000000003804e724)
> [   15.124886] kernel stack overflow (double-fault): 0000 [#1] SMP
> [   15.143042] CPU: 1 PID: 1512 Comm: modprobe Not tainted 4.19.0-rc3-next-20180913-heikki+ #327
> [   15.179455] Hardware name: Default string Default string/Default string, BIOS 5.11 05/25/2017
> [   15.215882] RIP: 0010:gpiochip_irq_disable+0x0/0x40
> [   15.234039] Code: 82 68 03 00 00 48 3d 00 f0 ff ff 77 0e 48 8b 50 08 80 e6 02 74 06 f0 80 60 09 fb c3 0f 0b c3 66 66 2e 0f 1f 84 00 00 00 00 00 <55> 53 48 8b 6f 30 48 89 fb 48 8b 85 18 01 00 00 48 85 c0 74 0d ff
> [   15.288437] RSP: 0000:ffffc900009ec000 EFLAGS: 00010086
> [   15.306438] RAX: ffffffff813742f0 RBX: ffff88017a0b4c28 RCX: ffff88017a0b4c70
> [   15.324471] RDX: ffff88017a0b4c00 RSI: 0000000000000001 RDI: ffff88017a0b4c28
> [   15.342399] RBP: ffff88017a037488 R08: ffff88017a0b4c00 R09: ffff88017b13ada0
> [   15.360263] R10: 0000000000000040 R11: 0000000000000000 R12: ffff88017a0b4d60
> [   15.378234] R13: ffff88017a0b4ca4 R14: 000000000000007b R15: ffff88017997c028
> [   15.396157] FS:  0000000000000000(0000) GS:ffff88017ba80000(0063) knlGS:00000000f7f40690
> [   15.431688] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
> [   15.449437] CR2: ffffc900009ebff8 CR3: 0000000179b1d000 CR4: 00000000001006e0
> [   15.467170] Call Trace:
> [   15.484685]  gpiochip_irq_disable+0x17/0x40
> [   15.502050]  gpiochip_irq_disable+0x17/0x40
> [   15.519258]  gpiochip_irq_disable+0x17/0x40
> [   15.536199]  gpiochip_irq_disable+0x17/0x40
> [   15.552910]  gpiochip_irq_disable+0x17/0x40
> [   15.569352]  gpiochip_irq_disable+0x17/0x40
> [   15.585531]  gpiochip_irq_disable+0x17/0x40
> [   15.601411]  gpiochip_irq_disable+0x17/0x40
> [   15.617033]  gpiochip_irq_disable+0x17/0x40
> [   15.632506]  gpiochip_irq_disable+0x17/0x40
> [   15.647754]  gpiochip_irq_disable+0x17/0x40
> [   15.662730]  gpiochip_irq_disable+0x17/0x40
> [   15.677491]  gpiochip_irq_disable+0x17/0x40
> [   15.692013]  gpiochip_irq_disable+0x17/0x40
> [   15.706376]  gpiochip_irq_disable+0x17/0x40
> [   15.720505]  gpiochip_irq_disable+0x17/0x40
> [   15.734374]  gpiochip_irq_disable+0x17/0x40
> [   15.748003]  gpiochip_irq_disable+0x17/0x40
> [   15.761363]  gpiochip_irq_disable+0x17/0x40
> [   15.774447]  gpiochip_irq_disable+0x17/0x40
> [   15.787288]  gpiochip_irq_disable+0x17/0x40
> [   15.799852]  gpiochip_irq_disable+0x17/0x40
> [   15.812168]  gpiochip_irq_disable+0x17/0x40
> [   15.824283]  gpiochip_irq_disable+0x17/0x40
> [   15.836204]  gpiochip_irq_disable+0x17/0x40
> [   15.847882]  gpiochip_irq_disable+0x17/0x40
> [   15.859347]  gpiochip_irq_disable+0x17/0x40
> [   15.870636]  gpiochip_irq_disable+0x17/0x40
> [   15.881810]  gpiochip_irq_disable+0x17/0x40
> [   15.892970]  gpiochip_irq_disable+0x17/0x40
> [   15.903997]  gpiochip_irq_disable+0x17/0x40
> [   15.914802]  gpiochip_irq_disable+0x17/0x40
> [   15.925415]  gpiochip_irq_disable+0x17/0x40
> [   15.935780]  gpiochip_irq_disable+0x17/0x40
> [   15.945921]  gpiochip_irq_disable+0x17/0x40
> [   15.955848]  gpiochip_irq_disable+0x17/0x40
> [   15.965721]  gpiochip_irq_disable+0x17/0x40
> [   15.975523]  gpiochip_irq_disable+0x17/0x40
> [   15.985171]  gpiochip_irq_disable+0x17/0x40
> [   15.994637]  gpiochip_irq_disable+0x17/0x40
> [   16.003898]  gpiochip_irq_disable+0x17/0x40
> [   16.013010]  gpiochip_irq_disable+0x17/0x40
> [   16.021860]  gpiochip_irq_disable+0x17/0x40
> [   16.030481]  gpiochip_irq_disable+0x17/0x40
> [   16.038928]  gpiochip_irq_disable+0x17/0x40
> [   16.047258]  gpiochip_irq_disable+0x17/0x40
> [   16.055423]  gpiochip_irq_disable+0x17/0x40
> [   16.063441]  gpiochip_irq_disable+0x17/0x40
> [   16.071295]  gpiochip_irq_disable+0x17/0x40
> [   16.078945]  gpiochip_irq_disable+0x17/0x40
> [   16.086368]  gpiochip_irq_disable+0x17/0x40
> [   16.093637]  gpiochip_irq_disable+0x17/0x40
> [   16.100729]  gpiochip_irq_disable+0x17/0x40
> [   16.107655]  gpiochip_irq_disable+0x17/0x40
> [   16.114441]  gpiochip_irq_disable+0x17/0x40
> [   16.120978]  gpiochip_irq_disable+0x17/0x40
> [   16.127463]  gpiochip_irq_disable+0x17/0x40
> [   16.133802]  gpiochip_irq_disable+0x17/0x40
> [   16.139897]  gpiochip_irq_disable+0x17/0x40
> [   16.145739]  gpiochip_irq_disable+0x17/0x40
> [   16.151381]  gpiochip_irq_disable+0x17/0x40
> [   16.156801]  gpiochip_irq_disable+0x17/0x40
> [   16.161966]  gpiochip_irq_disable+0x17/0x40
> [   16.166864]  gpiochip_irq_disable+0x17/0x40
> [   16.171510]  gpiochip_irq_disable+0x17/0x40
> [   16.176011]  gpiochip_irq_disable+0x17/0x40
> [   16.180283]  gpiochip_irq_disable+0x17/0x40
> [   16.184326]  gpiochip_irq_disable+0x17/0x40
> [   16.188125]  gpiochip_irq_disable+0x17/0x40
> [   16.191757]  gpiochip_irq_disable+0x17/0x40
> [   16.195202]  gpiochip_irq_disable+0x17/0x40
> [   16.198535]  gpiochip_irq_disable+0x17/0x40
> [   16.201758]  gpiochip_irq_disable+0x17/0x40
> [   16.204835]  gpiochip_irq_disable+0x17/0x40
> [   16.207814]  gpiochip_irq_disable+0x17/0x40
> [   16.210555]  gpiochip_irq_disable+0x17/0x40
> [   16.213046]  gpiochip_irq_disable+0x17/0x40
> [   16.215365]  gpiochip_irq_disable+0x17/0x40
> [   16.217485]  gpiochip_irq_disable+0x17/0x40
> [   16.219404]  gpiochip_irq_disable+0x17/0x40
> [   16.221217]  gpiochip_irq_disable+0x17/0x40
> [   16.223029]  gpiochip_irq_disable+0x17/0x40
> [   16.224834]  gpiochip_irq_disable+0x17/0x40
> [   16.226622]  gpiochip_irq_disable+0x17/0x40
> [   16.228420]  gpiochip_irq_disable+0x17/0x40
> [   16.230201]  gpiochip_irq_disable+0x17/0x40
> [   16.231977]  gpiochip_irq_disable+0x17/0x40
> [   16.233752]  gpiochip_irq_disable+0x17/0x40
> [   16.235524]  gpiochip_irq_disable+0x17/0x40
> [   16.237292]  gpiochip_irq_disable+0x17/0x40
> [   16.239055]  gpiochip_irq_disable+0x17/0x40
> [   16.240818]  gpiochip_irq_disable+0x17/0x40
> [   16.242581]  gpiochip_irq_disable+0x17/0x40
> [   16.244341]  gpiochip_irq_disable+0x17/0x40
> [   16.246092]  gpiochip_irq_disable+0x17/0x40
> [   16.247841]  gpiochip_irq_disable+0x17/0x40
> [   16.249585]  gpiochip_irq_disable+0x17/0x40
> [   16.251324]  gpiochip_irq_disable+0x17/0x40
> [   16.253070]  gpiochip_irq_disable+0x17/0x40
> [   16.254810]  gpiochip_irq_disable+0x17/0x40
> [   16.256545]  gpiochip_irq_disable+0x17/0x40
> [   16.258277]  gpiochip_irq_disable+0x17/0x40
> [   16.260002]  gpiochip_irq_disable+0x17/0x40
> [   16.261729]  gpiochip_irq_disable+0x17/0x40
> [   16.263452]  gpiochip_irq_disable+0x17/0x40
> [   16.265173]  gpiochip_irq_disable+0x17/0x40
> [   16.266888]  gpiochip_irq_disable+0x17/0x40
> [   16.268601]  gpiochip_irq_disable+0x17/0x40
> [   16.270312]  gpiochip_irq_disable+0x17/0x40
> [   16.272025]  gpiochip_irq_disable+0x17/0x40
> [   16.273735]  gpiochip_irq_disable+0x17/0x40
> [   16.275439]  gpiochip_irq_disable+0x17/0x40
> [   16.277134]  gpiochip_irq_disable+0x17/0x40
> [   16.278829]  gpiochip_irq_disable+0x17/0x40
> [   16.280524]  gpiochip_irq_disable+0x17/0x40
> [   16.282215]  gpiochip_irq_disable+0x17/0x40
> [   16.283904]  gpiochip_irq_disable+0x17/0x40
> [   16.285594]  gpiochip_irq_disable+0x17/0x40
> [   16.287280]  gpiochip_irq_disable+0x17/0x40
> [   16.288962]  gpiochip_irq_disable+0x17/0x40
> [   16.290636]  gpiochip_irq_disable+0x17/0x40
> [   16.292311]  gpiochip_irq_disable+0x17/0x40
> [   16.293987]  gpiochip_irq_disable+0x17/0x40
> [   16.295660]  gpiochip_irq_disable+0x17/0x40
> [   16.297332]  gpiochip_irq_disable+0x17/0x40
> [   16.299001]  gpiochip_irq_disable+0x17/0x40
> [   16.300672]  gpiochip_irq_disable+0x17/0x40
> [   16.302343]  gpiochip_irq_disable+0x17/0x40
> [   16.304011]  gpiochip_irq_disable+0x17/0x40
> [   16.305683]  gpiochip_irq_disable+0x17/0x40
> [   16.307354]  gpiochip_irq_disable+0x17/0x40
> [   16.309022]  gpiochip_irq_disable+0x17/0x40
> [   16.310682]  gpiochip_irq_disable+0x17/0x40
> [   16.312341]  gpiochip_irq_disable+0x17/0x40
> [   16.313999]  gpiochip_irq_disable+0x17/0x40
> [   16.315650]  gpiochip_irq_disable+0x17/0x40
> [   16.317304]  gpiochip_irq_disable+0x17/0x40
> [   16.318953]  gpiochip_irq_disable+0x17/0x40
> [   16.320603]  gpiochip_irq_disable+0x17/0x40
> [   16.322253]  gpiochip_irq_disable+0x17/0x40
> [   16.323898]  gpiochip_irq_disable+0x17/0x40
> [   16.325544]  gpiochip_irq_disable+0x17/0x40
> [   16.327186]  gpiochip_irq_disable+0x17/0x40
> [   16.328831]  gpiochip_irq_disable+0x17/0x40
> [   16.330469]  gpiochip_irq_disable+0x17/0x40
> [   16.332117]  gpiochip_irq_disable+0x17/0x40
> [   16.333760]  gpiochip_irq_disable+0x17/0x40
> [   16.335403]  gpiochip_irq_disable+0x17/0x40
> [   16.337048]  gpiochip_irq_disable+0x17/0x40
> [   16.338690]  gpiochip_irq_disable+0x17/0x40
> [   16.340332]  gpiochip_irq_disable+0x17/0x40
> [   16.341978]  gpiochip_irq_disable+0x17/0x40
> [   16.343616]  gpiochip_irq_disable+0x17/0x40
> [   16.345255]  gpiochip_irq_disable+0x17/0x40
> [   16.346893]  gpiochip_irq_disable+0x17/0x40
> [   16.348530]  gpiochip_irq_disable+0x17/0x40
> [   16.350164]  gpiochip_irq_disable+0x17/0x40
> [   16.351806]  gpiochip_irq_disable+0x17/0x40
> [   16.353447]  gpiochip_irq_disable+0x17/0x40
> [   16.355091]  gpiochip_irq_disable+0x17/0x40
> [   16.356732]  gpiochip_irq_disable+0x17/0x40
> [   16.358373]  gpiochip_irq_disable+0x17/0x40
> [   16.360014]  gpiochip_irq_disable+0x17/0x40
> [   16.361659]  gpiochip_irq_disable+0x17/0x40
> [   16.363305]  gpiochip_irq_disable+0x17/0x40
> [   16.364945]  gpiochip_irq_disable+0x17/0x40
> [   16.366586]  gpiochip_irq_disable+0x17/0x40
> [   16.368226]  gpiochip_irq_disable+0x17/0x40
> [   16.369862]  gpiochip_irq_disable+0x17/0x40
> [   16.371496]  gpiochip_irq_disable+0x17/0x40
> [   16.373135]  gpiochip_irq_disable+0x17/0x40
> [   16.374774]  gpiochip_irq_disable+0x17/0x40
> [   16.376409]  gpiochip_irq_disable+0x17/0x40
> [   16.378049]  gpiochip_irq_disable+0x17/0x40
> [   16.379686]  gpiochip_irq_disable+0x17/0x40
> [   16.381322]  gpiochip_irq_disable+0x17/0x40
> [   16.382960]  gpiochip_irq_disable+0x17/0x40
> [   16.384595]  gpiochip_irq_disable+0x17/0x40
> [   16.386229]  gpiochip_irq_disable+0x17/0x40
> [   16.387868]  gpiochip_irq_disable+0x17/0x40
> [   16.389505]  gpiochip_irq_disable+0x17/0x40
> [   16.391142]  gpiochip_irq_disable+0x17/0x40
> [   16.392780]  gpiochip_irq_disable+0x17/0x40
> [   16.394419]  gpiochip_irq_disable+0x17/0x40
> [   16.396059]  gpiochip_irq_disable+0x17/0x40
> [   16.397698]  gpiochip_irq_disable+0x17/0x40
> [   16.399334]  gpiochip_irq_disable+0x17/0x40
> [   16.400967]  gpiochip_irq_disable+0x17/0x40
> [   16.402607]  gpiochip_irq_disable+0x17/0x40
> [   16.404241]  gpiochip_irq_disable+0x17/0x40
> [   16.405880]  gpiochip_irq_disable+0x17/0x40
> [   16.407522]  gpiochip_irq_disable+0x17/0x40
> [   16.409165]  gpiochip_irq_disable+0x17/0x40
> [   16.410808]  gpiochip_irq_disable+0x17/0x40
> [   16.412452]  gpiochip_irq_disable+0x17/0x40
> [   16.414093]  gpiochip_irq_disable+0x17/0x40
> [   16.415738]  gpiochip_irq_disable+0x17/0x40
> [   16.417386]  gpiochip_irq_disable+0x17/0x40
> [   16.419035]  gpiochip_irq_disable+0x17/0x40
> [   16.420683]  gpiochip_irq_disable+0x17/0x40
> [   16.422328]  gpiochip_irq_disable+0x17/0x40
> [   16.423976]  gpiochip_irq_disable+0x17/0x40
> [   16.425623]  gpiochip_irq_disable+0x17/0x40
> [   16.427272]  gpiochip_irq_disable+0x17/0x40
> [   16.428919]  gpiochip_irq_disable+0x17/0x40
> [   16.430567]  gpiochip_irq_disable+0x17/0x40
> [   16.432210]  gpiochip_irq_disable+0x17/0x40
> [   16.433852]  gpiochip_irq_disable+0x17/0x40
> [   16.435497]  gpiochip_irq_disable+0x17/0x40
> [   16.437140]  gpiochip_irq_disable+0x17/0x40
> [   16.438785]  gpiochip_irq_disable+0x17/0x40
> [   16.440430]  gpiochip_irq_disable+0x17/0x40
> [   16.442078]  gpiochip_irq_disable+0x17/0x40
> [   16.443725]  gpiochip_irq_disable+0x17/0x40
> [   16.445372]  gpiochip_irq_disable+0x17/0x40
> [   16.447018]  gpiochip_irq_disable+0x17/0x40
> [   16.448666]  gpiochip_irq_disable+0x17/0x40
> [   16.450314]  gpiochip_irq_disable+0x17/0x40
> [   16.451967]  gpiochip_irq_disable+0x17/0x40
> [   16.453617]  gpiochip_irq_disable+0x17/0x40
> [   16.455268]  gpiochip_irq_disable+0x17/0x40
> [   16.456919]  gpiochip_irq_disable+0x17/0x40
> [   16.458568]  gpiochip_irq_disable+0x17/0x40
> [   16.460216]  gpiochip_irq_disable+0x17/0x40
> [   16.461867]  gpiochip_irq_disable+0x17/0x40
> [   16.463517]  gpiochip_irq_disable+0x17/0x40
> [   16.465166]  gpiochip_irq_disable+0x17/0x40
> [   16.466812]  gpiochip_irq_disable+0x17/0x40
> [   16.468460]  gpiochip_irq_disable+0x17/0x40
> [   16.470109]  gpiochip_irq_disable+0x17/0x40
> [   16.471756]  gpiochip_irq_disable+0x17/0x40
> [   16.473400]  gpiochip_irq_disable+0x17/0x40
> [   16.475045]  gpiochip_irq_disable+0x17/0x40
> [   16.476693]  gpiochip_irq_disable+0x17/0x40
> [   16.478341]  gpiochip_irq_disable+0x17/0x40
> [   16.479988]  gpiochip_irq_disable+0x17/0x40
> [   16.481629]  gpiochip_irq_disable+0x17/0x40
> [   16.483276]  gpiochip_irq_disable+0x17/0x40
> [   16.484924]  gpiochip_irq_disable+0x17/0x40
> [   16.486572]  gpiochip_irq_disable+0x17/0x40
> [   16.488216]  gpiochip_irq_disable+0x17/0x40
> [   16.489864]  gpiochip_irq_disable+0x17/0x40
> [   16.491508]  gpiochip_irq_disable+0x17/0x40
> [   16.493156]  gpiochip_irq_disable+0x17/0x40
> [   16.494801]  gpiochip_irq_disable+0x17/0x40
> [   16.496452]  gpiochip_irq_disable+0x17/0x40
> [   16.498103]  gpiochip_irq_disable+0x17/0x40
> [   16.499758]  gpiochip_irq_disable+0x17/0x40
> [   16.501412]  gpiochip_irq_disable+0x17/0x40
> [   16.503068]  gpiochip_irq_disable+0x17/0x40
> [   16.504722]  gpiochip_irq_disable+0x17/0x40
> [   16.506380]  gpiochip_irq_disable+0x17/0x40
> [   16.508035]  gpiochip_irq_disable+0x17/0x40
> [   16.509699]  gpiochip_irq_disable+0x17/0x40
> [   16.511360]  gpiochip_irq_disable+0x17/0x40
> [   16.513020]  gpiochip_irq_disable+0x17/0x40
> [   16.514676]  gpiochip_irq_disable+0x17/0x40
> [   16.516331]  gpiochip_irq_disable+0x17/0x40
> [   16.517989]  gpiochip_irq_disable+0x17/0x40
> [   16.519645]  gpiochip_irq_disable+0x17/0x40
> [   16.521302]  gpiochip_irq_disable+0x17/0x40
> [   16.522956]  gpiochip_irq_disable+0x17/0x40
> [   16.524613]  gpiochip_irq_disable+0x17/0x40
> [   16.526269]  gpiochip_irq_disable+0x17/0x40
> [   16.527927]  gpiochip_irq_disable+0x17/0x40
> [   16.529585]  gpiochip_irq_disable+0x17/0x40
> [   16.531247]  gpiochip_irq_disable+0x17/0x40
> [   16.532900]  gpiochip_irq_disable+0x17/0x40
> [   16.534560]  gpiochip_irq_disable+0x17/0x40
> [   16.536217]  gpiochip_irq_disable+0x17/0x40
> [   16.537874]  gpiochip_irq_disable+0x17/0x40
> [   16.539531]  gpiochip_irq_disable+0x17/0x40
> [   16.541189]  gpiochip_irq_disable+0x17/0x40
> [   16.542846]  gpiochip_irq_disable+0x17/0x40
> [   16.544503]  gpiochip_irq_disable+0x17/0x40
> [   16.546159]  gpiochip_irq_disable+0x17/0x40
> [   16.547816]  gpiochip_irq_disable+0x17/0x40
> [   16.549471]  gpiochip_irq_disable+0x17/0x40
> [   16.551129]  gpiochip_irq_disable+0x17/0x40
> [   16.552786]  gpiochip_irq_disable+0x17/0x40
> [   16.554442]  gpiochip_irq_disable+0x17/0x40
> [   16.556100]  gpiochip_irq_disable+0x17/0x40
> [   16.557757]  gpiochip_irq_disable+0x17/0x40
> [   16.559414]  gpiochip_irq_disable+0x17/0x40
> [   16.561071]  gpiochip_irq_disable+0x17/0x40
> [   16.562730]  gpiochip_irq_disable+0x17/0x40
> [   16.564387]  gpiochip_irq_disable+0x17/0x40
> [   16.566044]  gpiochip_irq_disable+0x17/0x40
> [   16.567700]  gpiochip_irq_disable+0x17/0x40
> [   16.569357]  gpiochip_irq_disable+0x17/0x40
> [   16.571014]  gpiochip_irq_disable+0x17/0x40
> [   16.572671]  gpiochip_irq_disable+0x17/0x40
> [   16.574328]  gpiochip_irq_disable+0x17/0x40
> [   16.575983]  gpiochip_irq_disable+0x17/0x40
> [   16.577643]  gpiochip_irq_disable+0x17/0x40
> [   16.579297]  gpiochip_irq_disable+0x17/0x40
> [   16.580949]  gpiochip_irq_disable+0x17/0x40
> [   16.582600]  gpiochip_irq_disable+0x17/0x40
> [   16.584254]  gpiochip_irq_disable+0x17/0x40
> [   16.585912]  gpiochip_irq_disable+0x17/0x40
> [   16.587569]  gpiochip_irq_disable+0x17/0x40
> [   16.589223]  gpiochip_irq_disable+0x17/0x40
> [   16.590878]  gpiochip_irq_disable+0x17/0x40
> [   16.592535]  gpiochip_irq_disable+0x17/0x40
> [   16.594193]  gpiochip_irq_disable+0x17/0x40
> [   16.595851]  gpiochip_irq_disable+0x17/0x40
> [   16.597509]  gpiochip_irq_disable+0x17/0x40
> [   16.599167]  gpiochip_irq_disable+0x17/0x40
> [   16.600827]  gpiochip_irq_disable+0x17/0x40
> [   16.602488]  gpiochip_irq_disable+0x17/0x40
> [   16.604146]  gpiochip_irq_disable+0x17/0x40
> [   16.605803]  gpiochip_irq_disable+0x17/0x40
> [   16.607463]  gpiochip_irq_disable+0x17/0x40
> [   16.609120]  gpiochip_irq_disable+0x17/0x40
> [   16.610777]  gpiochip_irq_disable+0x17/0x40
> [   16.612437]  gpiochip_irq_disable+0x17/0x40
> [   16.614091]  gpiochip_irq_disable+0x17/0x40
> [   16.615745]  gpiochip_irq_disable+0x17/0x40
> [   16.617397]  gpiochip_irq_disable+0x17/0x40
> [   16.619050]  gpiochip_irq_disable+0x17/0x40
> [   16.620704]  gpiochip_irq_disable+0x17/0x40
> [   16.622359]  gpiochip_irq_disable+0x17/0x40
> [   16.624011]  gpiochip_irq_disable+0x17/0x40
> [   16.625666]  gpiochip_irq_disable+0x17/0x40
> [   16.627317]  gpiochip_irq_disable+0x17/0x40
> [   16.628971]  gpiochip_irq_disable+0x17/0x40
> [   16.630626]  gpiochip_irq_disable+0x17/0x40
> [   16.632283]  gpiochip_irq_disable+0x17/0x40
> [   16.633933]  gpiochip_irq_disable+0x17/0x40
> [   16.635582]  gpiochip_irq_disable+0x17/0x40
> [   16.637230]  gpiochip_irq_disable+0x17/0x40
> [   16.638874]  gpiochip_irq_disable+0x17/0x40
> [   16.640521]  gpiochip_irq_disable+0x17/0x40
> [   16.642169]  gpiochip_irq_disable+0x17/0x40
> [   16.643817]  gpiochip_irq_disable+0x17/0x40
> [   16.645465]  gpiochip_irq_disable+0x17/0x40
> [   16.647116]  gpiochip_irq_disable+0x17/0x40
> [   16.648765]  gpiochip_irq_disable+0x17/0x40
> [   16.650414]  gpiochip_irq_disable+0x17/0x40
> [   16.652065]  gpiochip_irq_disable+0x17/0x40
> [   16.653716]  gpiochip_irq_disable+0x17/0x40
> [   16.655366]  gpiochip_irq_disable+0x17/0x40
> [   16.657015]  gpiochip_irq_disable+0x17/0x40
> [   16.658659]  gpiochip_irq_disable+0x17/0x40
> [   16.660304]  gpiochip_irq_disable+0x17/0x40
> [   16.661955]  gpiochip_irq_disable+0x17/0x40
> [   16.663602]  gpiochip_irq_disable+0x17/0x40
> [   16.665246]  gpiochip_irq_disable+0x17/0x40
> [   16.666898]  gpiochip_irq_disable+0x17/0x40
> [   16.668549]  gpiochip_irq_disable+0x17/0x40
> [   16.670200]  gpiochip_irq_disable+0x17/0x40
> [   16.671854]  gpiochip_irq_disable+0x17/0x40
> [   16.673501]  gpiochip_irq_disable+0x17/0x40
> [   16.675152]  gpiochip_irq_disable+0x17/0x40
> [   16.676803]  gpiochip_irq_disable+0x17/0x40
> [   16.678454]  gpiochip_irq_disable+0x17/0x40
> [   16.680102]  gpiochip_irq_disable+0x17/0x40
> [   16.681753]  gpiochip_irq_disable+0x17/0x40
> [   16.683404]  gpiochip_irq_disable+0x17/0x40
> [   16.685055]  gpiochip_irq_disable+0x17/0x40
> [   16.686705]  gpiochip_irq_disable+0x17/0x40
> [   16.688353]  gpiochip_irq_disable+0x17/0x40
> [   16.690001]  gpiochip_irq_disable+0x17/0x40
> [   16.691652]  gpiochip_irq_disable+0x17/0x40
> [   16.693296]  gpiochip_irq_disable+0x17/0x40
> [   16.694943]  gpiochip_irq_disable+0x17/0x40
> [   16.696588]  gpiochip_irq_disable+0x17/0x40
> [   16.698236]  gpiochip_irq_disable+0x17/0x40
> [   16.699883]  gpiochip_irq_disable+0x17/0x40
> [   16.701531]  gpiochip_irq_disable+0x17/0x40
> [   16.703183]  gpiochip_irq_disable+0x17/0x40
> [   16.704826]  gpiochip_irq_disable+0x17/0x40
> [   16.706477]  gpiochip_irq_disable+0x17/0x40
> [   16.708128]  gpiochip_irq_disable+0x17/0x40
> [   16.709783]  gpiochip_irq_disable+0x17/0x40
> [   16.711438]  gpiochip_irq_disable+0x17/0x40
> [   16.713089]  gpiochip_irq_disable+0x17/0x40
> [   16.714743]  gpiochip_irq_disable+0x17/0x40
> [   16.716397]  gpiochip_irq_disable+0x17/0x40
> [   16.718049]  gpiochip_irq_disable+0x17/0x40
> [   16.719702]  gpiochip_irq_disable+0x17/0x40
> [   16.721358]  gpiochip_irq_disable+0x17/0x40
> [   16.723012]  gpiochip_irq_disable+0x17/0x40
> [   16.724663]  gpiochip_irq_disable+0x17/0x40
> [   16.726317]  gpiochip_irq_disable+0x17/0x40
> [   16.727971]  gpiochip_irq_disable+0x17/0x40
> [   16.729624]  gpiochip_irq_disable+0x17/0x40
> [   16.731278]  gpiochip_irq_disable+0x17/0x40
> [   16.732933]  gpiochip_irq_disable+0x17/0x40
> [   16.734591]  gpiochip_irq_disable+0x17/0x40
> [   16.736245]  gpiochip_irq_disable+0x17/0x40
> [   16.737900]  gpiochip_irq_disable+0x17/0x40
> [   16.739554]  gpiochip_irq_disable+0x17/0x40
> [   16.741212]  gpiochip_irq_disable+0x17/0x40
> [   16.742870]  gpiochip_irq_disable+0x17/0x40
> [   16.744527]  gpiochip_irq_disable+0x17/0x40
> [   16.746185]  gpiochip_irq_disable+0x17/0x40
> [   16.747846]  gpiochip_irq_disable+0x17/0x40
> [   16.749504]  gpiochip_irq_disable+0x17/0x40
> [   16.751164]  gpiochip_irq_disable+0x17/0x40
> [   16.752820]  gpiochip_irq_disable+0x17/0x40
> [   16.754477]  gpiochip_irq_disable+0x17/0x40
> [   16.756134]  gpiochip_irq_disable+0x17/0x40
> [   16.757792]  gpiochip_irq_disable+0x17/0x40
> [   16.759450]  gpiochip_irq_disable+0x17/0x40
> [   16.761108]  gpiochip_irq_disable+0x17/0x40
> [   16.762763]  gpiochip_irq_disable+0x17/0x40
> [   16.764418]  gpiochip_irq_disable+0x17/0x40
> [   16.766078]  gpiochip_irq_disable+0x17/0x40
> [   16.767735]  gpiochip_irq_disable+0x17/0x40
> [   16.769393]  gpiochip_irq_disable+0x17/0x40
> [   16.771050]  gpiochip_irq_disable+0x17/0x40
> [   16.772707]  gpiochip_irq_disable+0x17/0x40
> [   16.774364]  gpiochip_irq_disable+0x17/0x40
> [   16.776021]  gpiochip_irq_disable+0x17/0x40
> [   16.777678]  gpiochip_irq_disable+0x17/0x40
> [   16.779333]  gpiochip_irq_disable+0x17/0x40
> [   16.780993]  gpiochip_irq_disable+0x17/0x40
> [   16.782649]  gpiochip_irq_disable+0x17/0x40
> [   16.784303]  gpiochip_irq_disable+0x17/0x40
> [   16.785955]  gpiochip_irq_disable+0x17/0x40
> [   16.787612]  gpiochip_irq_disable+0x17/0x40
> [   16.789271]  gpiochip_irq_disable+0x17/0x40
> [   16.790925]  gpiochip_irq_disable+0x17/0x40
> [   16.792579]  gpiochip_irq_disable+0x17/0x40
> [   16.794235]  gpiochip_irq_disable+0x17/0x40
> [   16.795893]  gpiochip_irq_disable+0x17/0x40
> [   16.797550]  gpiochip_irq_disable+0x17/0x40
> [   16.799205]  gpiochip_irq_disable+0x17/0x40
> [   16.800860]  gpiochip_irq_disable+0x17/0x40
> [   16.802520]  gpiochip_irq_disable+0x17/0x40
> [   16.804178]  gpiochip_irq_disable+0x17/0x40
> [   16.805833]  gpiochip_irq_disable+0x17/0x40
> [   16.807491]  gpiochip_irq_disable+0x17/0x40
> [   16.809148]  gpiochip_irq_disable+0x17/0x40
> [   16.810803]  gpiochip_irq_disable+0x17/0x40
> [   16.812460]  gpiochip_irq_disable+0x17/0x40
> [   16.814118]  gpiochip_irq_disable+0x17/0x40
> [   16.815773]  gpiochip_irq_disable+0x17/0x40
> [   16.817427]  gpiochip_irq_disable+0x17/0x40
> [   16.819088]  gpiochip_irq_disable+0x17/0x40
> [   16.820746]  gpiochip_irq_disable+0x17/0x40
> [   16.822407]  gpiochip_irq_disable+0x17/0x40
> [   16.824066]  gpiochip_irq_disable+0x17/0x40
> [   16.825728]  gpiochip_irq_disable+0x17/0x40
> [   16.827389]  gpiochip_irq_disable+0x17/0x40
> [   16.829050]  gpiochip_irq_disable+0x17/0x40
> [   16.830710]  gpiochip_irq_disable+0x17/0x40
> [   16.832370]  gpiochip_irq_disable+0x17/0x40
> [   16.834019]  gpiochip_irq_disable+0x17/0x40
> [   16.835671]  gpiochip_irq_disable+0x17/0x40
> [   16.837323]  gpiochip_irq_disable+0x17/0x40
> [   16.838971]  gpiochip_irq_disable+0x17/0x40
> [   16.840623]  gpiochip_irq_disable+0x17/0x40
> [   16.842277]  gpiochip_irq_disable+0x17/0x40
> [   16.843924]  gpiochip_irq_disable+0x17/0x40
> [   16.845572]  gpiochip_irq_disable+0x17/0x40
> [   16.847222]  gpiochip_irq_disable+0x17/0x40
> [   16.848868]  gpiochip_irq_disable+0x17/0x40
> [   16.850513]  gpiochip_irq_disable+0x17/0x40
> [   16.852161]  gpiochip_irq_disable+0x17/0x40
> [   16.853808]  gpiochip_irq_disable+0x17/0x40
> [   16.855457]  gpiochip_irq_disable+0x17/0x40
> [   16.857104]  gpiochip_irq_disable+0x17/0x40
> [   16.858751]  gpiochip_irq_disable+0x17/0x40
> [   16.860399]  gpiochip_irq_disable+0x17/0x40
> [   16.862050]  gpiochip_irq_disable+0x17/0x40
> [   16.863695]  gpiochip_irq_disable+0x17/0x40
> [   16.865342]  gpiochip_irq_disable+0x17/0x40
> [   16.866990]  gpiochip_irq_disable+0x17/0x40
> [   16.868638]  gpiochip_irq_disable+0x17/0x40
> [   16.870288]  gpiochip_irq_disable+0x17/0x40
> [   16.871932]  gpiochip_irq_disable+0x17/0x40
> [   16.873574]  gpiochip_irq_disable+0x17/0x40
> [   16.875219]  gpiochip_irq_disable+0x17/0x40
> [   16.876863]  gpiochip_irq_disable+0x17/0x40
> [   16.878507]  gpiochip_irq_disable+0x17/0x40
> [   16.880152]  gpiochip_irq_disable+0x17/0x40
> [   16.881798]  gpiochip_irq_disable+0x17/0x40
> [   16.883445]  gpiochip_irq_disable+0x17/0x40
> [   16.885093]  gpiochip_irq_disable+0x17/0x40
> [   16.886738]  gpiochip_irq_disable+0x17/0x40
> [   16.888385]  gpiochip_irq_disable+0x17/0x40
> [   16.890034]  gpiochip_irq_disable+0x17/0x40
> [   16.891686]  gpiochip_irq_disable+0x17/0x40
> [   16.893335]  gpiochip_irq_disable+0x17/0x40
> [   16.894979]  gpiochip_irq_disable+0x17/0x40
> [   16.896626]  gpiochip_irq_disable+0x17/0x40
> [   16.898276]  gpiochip_irq_disable+0x17/0x40
> [   16.899924]  gpiochip_irq_disable+0x17/0x40
> [   16.901572]  gpiochip_irq_disable+0x17/0x40
> [   16.903219]  gpiochip_irq_disable+0x17/0x40
> [   16.904868]  gpiochip_irq_disable+0x17/0x40
> [   16.906517]  gpiochip_irq_disable+0x17/0x40
> [   16.908168]  gpiochip_irq_disable+0x17/0x40
> [   16.909818]  gpiochip_irq_disable+0x17/0x40
> [   16.911466]  gpiochip_irq_disable+0x17/0x40
> [   16.913117]  gpiochip_irq_disable+0x17/0x40
> [   16.914770]  gpiochip_irq_disable+0x17/0x40
> [   16.916420]  gpiochip_irq_disable+0x17/0x40
> [   16.918068]  gpiochip_irq_disable+0x17/0x40
> [   16.919716]  gpiochip_irq_disable+0x17/0x40
> [   16.921361]  gpiochip_irq_disable+0x17/0x40
> [   16.923008]  gpiochip_irq_disable+0x17/0x40
> [   16.924656]  gpiochip_irq_disable+0x17/0x40
> [   16.926304]  gpiochip_irq_disable+0x17/0x40
> [   16.927951]  gpiochip_irq_disable+0x17/0x40
> [   16.929597]  gpiochip_irq_disable+0x17/0x40
> [   16.931245]  gpiochip_irq_disable+0x17/0x40
> [   16.932890]  gpiochip_irq_disable+0x17/0x40
> [   16.934534]  gpiochip_irq_disable+0x17/0x40
> [   16.936182]  gpiochip_irq_disable+0x17/0x40
> [   16.937830]  gpiochip_irq_disable+0x17/0x40
> [   16.939477]  gpiochip_irq_disable+0x17/0x40
> [   16.941122]  gpiochip_irq_disable+0x17/0x40
> [   16.942769]  gpiochip_irq_disable+0x17/0x40
> [   16.944417]  gpiochip_irq_disable+0x17/0x40
> [   16.946061]  gpiochip_irq_disable+0x17/0x40
> [   16.947708]  gpiochip_irq_disable+0x17/0x40
> [   16.949356]  gpiochip_irq_disable+0x17/0x40
> [   16.951002]  gpiochip_irq_disable+0x17/0x40
> [   16.952650]  gpiochip_irq_disable+0x17/0x40
> [   16.954295]  gpiochip_irq_disable+0x17/0x40
> [   16.955943]  gpiochip_irq_disable+0x17/0x40
> [   16.957588]  gpiochip_irq_disable+0x17/0x40
> [   16.959236]  gpiochip_irq_disable+0x17/0x40
> [   16.960885]  gpiochip_irq_disable+0x17/0x40
> [   16.962534]  gpiochip_irq_disable+0x17/0x40
> [   16.964188]  gpiochip_irq_disable+0x17/0x40
> [   16.965840]  gpiochip_irq_disable+0x17/0x40
> [   16.967490]  gpiochip_irq_disable+0x17/0x40
> [   16.969141]  gpiochip_irq_disable+0x17/0x40
> [   16.970792]  gpiochip_irq_disable+0x17/0x40
> [   16.972441]  gpiochip_irq_disable+0x17/0x40
> [   16.974089]  gpiochip_irq_disable+0x17/0x40
> [   16.975738]  gpiochip_irq_disable+0x17/0x40
> [   16.977386]  gpiochip_irq_disable+0x17/0x40
> [   16.979040]  gpiochip_irq_disable+0x17/0x40
> [   16.980693]  gpiochip_irq_disable+0x17/0x40
> [   16.982351]  gpiochip_irq_disable+0x17/0x40
> [   16.984006]  gpiochip_irq_disable+0x17/0x40
> [   16.985660]  gpiochip_irq_disable+0x17/0x40
> [   16.987312]  gpiochip_irq_disable+0x17/0x40
> [   16.988964]  gpiochip_irq_disable+0x17/0x40
> [   16.990619]  gpiochip_irq_disable+0x17/0x40
> [   16.992275]  gpiochip_irq_disable+0x17/0x40
> [   16.993926]  gpiochip_irq_disable+0x17/0x40
> [   16.995578]  gpiochip_irq_disable+0x17/0x40
> [   16.997230]  gpiochip_irq_disable+0x17/0x40
> [   16.998882]  gpiochip_irq_disable+0x17/0x40
> [   17.000532]  gpiochip_irq_disable+0x17/0x40
> [   17.002194]  gpiochip_irq_disable+0x17/0x40
> [   17.003857]  gpiochip_irq_disable+0x17/0x40
> [   17.005516]  gpiochip_irq_disable+0x17/0x40
> [   17.007178]  gpiochip_irq_disable+0x17/0x40
> [   17.008837]  gpiochip_irq_disable+0x17/0x40
> [   17.010499]  gpiochip_irq_disable+0x17/0x40
> [   17.012157]  gpiochip_irq_disable+0x17/0x40
> [   17.013820]  gpiochip_irq_disable+0x17/0x40
> [   17.015482]  gpiochip_irq_disable+0x17/0x40
> [   17.017144]  gpiochip_irq_disable+0x17/0x40
> [   17.018806]  gpiochip_irq_disable+0x17/0x40
> [   17.020467]  gpiochip_irq_disable+0x17/0x40
> [   17.022129]  gpiochip_irq_disable+0x17/0x40
> [   17.023790]  gpiochip_irq_disable+0x17/0x40
> [   17.025451]  gpiochip_irq_disable+0x17/0x40
> [   17.027114]  gpiochip_irq_disable+0x17/0x40
> [   17.028777]  gpiochip_irq_disable+0x17/0x40
> [   17.030443]  gpiochip_irq_disable+0x17/0x40
> [   17.032109]  gpiochip_irq_disable+0x17/0x40
> [   17.033767]  gpiochip_irq_disable+0x17/0x40
> [   17.035428]  gpiochip_irq_disable+0x17/0x40
> [   17.037092]  gpiochip_irq_disable+0x17/0x40
> [   17.038753]  gpiochip_irq_disable+0x17/0x40
> [   17.040413]  gpiochip_irq_disable+0x17/0x40
> [   17.042078]  gpiochip_irq_disable+0x17/0x40
> [   17.043740]  gpiochip_irq_disable+0x17/0x40
> [   17.045402]  gpiochip_irq_disable+0x17/0x40
> [   17.047063]  gpiochip_irq_disable+0x17/0x40
> [   17.048729]  gpiochip_irq_disable+0x17/0x40
> [   17.050396]  gpiochip_irq_disable+0x17/0x40
> [   17.052064]  gpiochip_irq_disable+0x17/0x40
> [   17.053729]  gpiochip_irq_disable+0x17/0x40
> [   17.055395]  gpiochip_irq_disable+0x17/0x40
> [   17.057061]  gpiochip_irq_disable+0x17/0x40
> [   17.058726]  gpiochip_irq_disable+0x17/0x40
> [   17.060388]  gpiochip_irq_disable+0x17/0x40
> [   17.062055]  gpiochip_irq_disable+0x17/0x40
> [   17.063720]  gpiochip_irq_disable+0x17/0x40
> [   17.065384]  gpiochip_irq_disable+0x17/0x40
> [   17.067048]  gpiochip_irq_disable+0x17/0x40
> [   17.068713]  gpiochip_irq_disable+0x17/0x40
> [   17.070377]  gpiochip_irq_disable+0x17/0x40
> [   17.072044]  gpiochip_irq_disable+0x17/0x40
> [   17.073709]  gpiochip_irq_disable+0x17/0x40
> [   17.075376]  gpiochip_irq_disable+0x17/0x40
> [   17.077041]  gpiochip_irq_disable+0x17/0x40
> [   17.078704]  gpiochip_irq_disable+0x17/0x40
> [   17.080369]  gpiochip_irq_disable+0x17/0x40
> [   17.082037]  gpiochip_irq_disable+0x17/0x40
> [   17.083699]  gpiochip_irq_disable+0x17/0x40
> [   17.085364]  gpiochip_irq_disable+0x17/0x40
> [   17.087027]  gpiochip_irq_disable+0x17/0x40
> [   17.088692]  gpiochip_irq_disable+0x17/0x40
> [   17.090358]  gpiochip_irq_disable+0x17/0x40
> [   17.092022]  gpiochip_irq_disable+0x17/0x40
> [   17.093685]  gpiochip_irq_disable+0x17/0x40
> [   17.095351]  gpiochip_irq_disable+0x17/0x40
> [   17.097014]  gpiochip_irq_disable+0x17/0x40
> [   17.098679]  gpiochip_irq_disable+0x17/0x40
> [   17.100348]  gpiochip_irq_disable+0x17/0x40
> [   17.102023]  gpiochip_irq_disable+0x17/0x40
> [   17.103695]  gpiochip_irq_disable+0x17/0x40
> [   17.105364]  gpiochip_irq_disable+0x17/0x40
> [   17.107036]  gpiochip_irq_disable+0x17/0x40
> [   17.108708]  gpiochip_irq_disable+0x17/0x40
> [   17.110377]  gpiochip_irq_disable+0x17/0x40
> [   17.112049]  gpiochip_irq_disable+0x17/0x40
> [   17.113718]  gpiochip_irq_disable+0x17/0x40
> [   17.115392]  gpiochip_irq_disable+0x17/0x40
> [   17.117063]  gpiochip_irq_disable+0x17/0x40
> [   17.118736]  gpiochip_irq_disable+0x17/0x40
> [   17.120407]  gpiochip_irq_disable+0x17/0x40
> [   17.122082]  gpiochip_irq_disable+0x17/0x40
> [   17.123754]  gpiochip_irq_disable+0x17/0x40
> [   17.125423]  gpiochip_irq_disable+0x17/0x40
> [   17.127094]  gpiochip_irq_disable+0x17/0x40
> [   17.128766]  gpiochip_irq_disable+0x17/0x40
> [   17.130435]  gpiochip_irq_disable+0x17/0x40
> [   17.132109]  gpiochip_irq_disable+0x17/0x40
> [   17.133773]  gpiochip_irq_disable+0x17/0x40
> [   17.135439]  gpiochip_irq_disable+0x17/0x40
> [   17.137107]  gpiochip_irq_disable+0x17/0x40
> [   17.138775]  gpiochip_irq_disable+0x17/0x40
> [   17.140442]  gpiochip_irq_disable+0x17/0x40
> [   17.142110]  gpiochip_irq_disable+0x17/0x40
> [   17.143774]  gpiochip_irq_disable+0x17/0x40
> [   17.145438]  gpiochip_irq_disable+0x17/0x40
> [   17.147102]  gpiochip_irq_disable+0x17/0x40
> [   17.148767]  gpiochip_irq_disable+0x17/0x40
> [   17.150435]  gpiochip_irq_disable+0x17/0x40
> [   17.152101]  gpiochip_irq_disable+0x17/0x40
> [   17.153768]  gpiochip_irq_disable+0x17/0x40
> [   17.155435]  gpiochip_irq_disable+0x17/0x40
> [   17.157099]  gpiochip_irq_disable+0x17/0x40
> [   17.158765]  gpiochip_irq_disable+0x17/0x40
> [   17.160433]  gpiochip_irq_disable+0x17/0x40
> [   17.162103]  gpiochip_irq_disable+0x17/0x40
> [   17.163766]  gpiochip_irq_disable+0x17/0x40
> [   17.165427]  gpiochip_irq_disable+0x17/0x40
> [   17.167090]  gpiochip_irq_disable+0x17/0x40
> [   17.168751]  gpiochip_irq_disable+0x17/0x40
> [   17.170413]  gpiochip_irq_disable+0x17/0x40
> [   17.172080]  gpiochip_irq_disable+0x17/0x40
> [   17.173744]  gpiochip_irq_disable+0x17/0x40
> [   17.175408]  gpiochip_irq_disable+0x17/0x40
> [   17.177073]  gpiochip_irq_disable+0x17/0x40
> [   17.178739]  gpiochip_irq_disable+0x17/0x40
> [   17.180408]  __irq_disable+0x3a/0x60
> [   17.182153]  irq_shutdown+0x64/0x70
> [   17.183968]  __free_irq+0x223/0x270
> [   17.185844]  free_irq+0x29/0x60
> [   17.187777]  release_nodes+0x1a7/0x200
> [   17.189817]  device_release_driver_internal+0x193/0x240
> [   17.192035]  driver_detach+0x2d/0x5a
> [   17.194325]  bus_remove_driver+0x47/0x96
> [   17.196710]  __ia32_sys_delete_module+0x187/0x210
> [   17.199232]  ? task_work_run+0x33/0x90
> [   17.201834]  do_int80_syscall_32+0x41/0xe0
> [   17.204548]  entry_INT80_compat+0x6c/0x71
> [   17.207341] Modules linked in: fusb302(-) tcpm pi3usb30532 typec intel_xhci_usb_role_switch roles intel_cht_int33fe
> [   17.213760] ---[ end trace 09a141766951495d ]---
> [   17.217215] RIP: 0010:gpiochip_irq_disable+0x0/0x40
> [   17.220801] Code: 82 68 03 00 00 48 3d 00 f0 ff ff 77 0e 48 8b 50 08 80 e6 02 74 06 f0 80 60 09 fb c3 0f 0b c3 66 66 2e 0f 1f 84 00 00 00 00 00 <55> 53 48 8b 6f 30 48 89 fb 48 8b 85 18 01 00 00 48 85 c0 74 0d ff
> [   17.233048] RSP: 0000:ffffc900009ec000 EFLAGS: 00010086
> [   17.237502] RAX: ffffffff813742f0 RBX: ffff88017a0b4c28 RCX: ffff88017a0b4c70
> [   17.242213] RDX: ffff88017a0b4c00 RSI: 0000000000000001 RDI: ffff88017a0b4c28
> [   17.247051] RBP: ffff88017a037488 R08: ffff88017a0b4c00 R09: ffff88017b13ada0
> [   17.251995] R10: 0000000000000040 R11: 0000000000000000 R12: ffff88017a0b4d60
> [   17.257073] R13: ffff88017a0b4ca4 R14: 000000000000007b R15: ffff88017997c028
> [   17.262252] FS:  0000000000000000(0000) GS:ffff88017ba80000(0063) knlGS:00000000f7f40690
> [   17.273094] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
> [   17.278875] CR2: ffffc900009ebff8 CR3: 0000000179b1d000 CR4: 00000000001006e0
> [   17.285397] modprobe (1512) used greatest stack depth: 8 bytes left
> [   17.286644] WARNING: CPU: 1 PID: 0 at kernel/rcu/tree.c:574 rcu_idle_enter+0x78/0x80
> [   17.287887] Modules linked in: fusb302(-) tcpm pi3usb30532 typec intel_xhci_usb_role_switch roles intel_cht_int33fe
> [   17.290462] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G      D           4.19.0-rc3-next-20180913-heikki+ #327
> [   17.293197] Hardware name: Default string Default string/Default string, BIOS 5.11 05/25/2017
> [   17.296114] RIP: 0010:rcu_idle_enter+0x78/0x80
> [   17.297624] Code: 03 05 c4 5a f5 7e 48 c7 80 a8 00 00 00 00 00 00 00 48 89 d0 65 48 03 05 ae 5a f5 7e ba 02 00 00 00 f0 0f c1 90 b8 00 00 00 c3 <0f> 0b eb a9 0f 1f 40 00 48 c7 c0 80 14 02 00 48 89 c2 65 48 03 15
> [   17.302432] RSP: 0000:ffffc900006bbed0 EFLAGS: 00010002
> [   17.304110] RAX: ffff88017baa1480 RBX: 0000000000000001 RCX: 4000000000000000
> [   17.305833] RDX: 0000000000021480 RSI: 0000000000000026 RDI: 0000000000000000
> [   17.307566] RBP: ffffffff820feaa0 R08: ffff88017ba9faa8 R09: 0000000000000076
> [   17.309315] R10: 00000000000000cb R11: ffff88017ba9faa8 R12: ffff88017a06b400
> [   17.311084] R13: ffffffff8209a720 R14: 0000000000000001 R15: 0000000000000000
> [   17.312885] FS:  0000000000000000(0000) GS:ffff88017ba80000(0000) knlGS:0000000000000000
> [   17.316577] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   17.318493] CR2: ffffc900009ebff8 CR3: 0000000002009000 CR4: 00000000001006e0
> [   17.320450] Call Trace:
> [   17.322418]  do_idle+0x1d2/0x210
> [   17.324402]  cpu_startup_entry+0x6a/0x70
> [   17.326405]  start_secondary+0x165/0x190
> [   17.328425]  secondary_startup_64+0xa4/0xb0
> [   17.330458] ---[ end trace 09a141766951495e ]---
> 

