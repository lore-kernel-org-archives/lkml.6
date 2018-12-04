Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED6AFC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 21:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A898E2082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 21:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KN+Tgrkr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A898E2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbeLDVJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 16:09:55 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41341 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbeLDVJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 16:09:55 -0500
Received: by mail-qt1-f194.google.com with SMTP id d18so19828000qto.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 13:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:subject:to:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CiIdPQDd52KXB344IvmDHtniUM1QRYYVDsV+oeidLmY=;
        b=KN+TgrkrO6W9IG9t0e2BEkYtKqi474DVoyLbnzGU7X96yBHqY2zjgCtWQqCNBxOFvP
         YehiJO3R4egfhmJO+qF5F/pxlHl6dtthXVwJP3OXtSFV+76t3w6WXrApFbkeWx2Eaa6g
         CBLkFZN4nh5J//nGjMxWJI4KV1begs6CJKcwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=CiIdPQDd52KXB344IvmDHtniUM1QRYYVDsV+oeidLmY=;
        b=Vn4UL9yPU3zw5rcQnsj4jqEPTcrawJD3xHDzXny8vobGZlOs2cC4ZPMP0ncy0B7Gd6
         1EUqvvtXvaeZFw3XBXtrAQKw/w9+U1iB6RljftmXEYt/VFNTQcEDF+aOShlIUwQS1QUc
         XgDpEpXKgBtqPktUUYEZDuSGB77+77BQ2Hq3LUvbK5nsJpTcXfGBujEdwSGISKfQdjcQ
         3kv0Xiiq9kx/zD78VZwlgAMdVtv1Py57EjBg/t42iCGO0Cd8qJzu2/LkmoUgnz0UZ37d
         mDb+Jy08PkcmfMtDYgi+yDu9uMJOm6Oj+9mMmecN9ga2i1IGAOeGS1sTmgGNzyvF9jK9
         L82Q==
X-Gm-Message-State: AA+aEWbxXy9gbRKrJcI1Fxs8qZMi8SGoJrutPxF3onUdgIcQEpgDSDcB
        2JjmgUmeBOEDs4ny6vLOOKeQ7Q==
X-Google-Smtp-Source: AFSGD/WhYo7oTjOYXa8L5BiMFEtHZVaIWDcCqCipmZXJG0gKn6tsISquoMObJSe51M5vPVY36bgTRw==
X-Received: by 2002:a0c:8822:: with SMTP id 31mr21442775qvl.5.1543957793523;
        Tue, 04 Dec 2018 13:09:53 -0800 (PST)
Received: from [192.168.49.18] ([138.204.25.29])
        by smtp.gmail.com with ESMTPSA id j89sm12889481qkh.34.2018.12.04.13.09.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 13:09:52 -0800 (PST)
Cc:     Rafael David Tinoco <rafael.tinoco@linaro.org>, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        ben.hutchings@codethink.co.uk, stable@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux@roeck-us.net, Yuchung Cheng <ycheng@google.com>,
        Nandita Dukkipati <nanditad@google.com>,
        Neal Cardwell <ncardwell@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 4.19 000/139] 4.19.7-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20181204103649.950154335@linuxfoundation.org>
From:   Rafael David Tinoco <rafael.tinoco@linaro.org>
Organization: Linaro
Message-ID: <716b46ef-03da-9656-92fd-3823f31f5ce6@linaro.org>
Date:   Tue, 4 Dec 2018 19:09:46 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181204103649.950154335@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/4/18 8:48 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.7 release.
> There are 139 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Dec  6 10:36:22 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.7-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

During functional tests for this v4.19 release, we faced a PANIC,
described bellow, but unlikely related to this specific v4.19 version.

First a WARN() at tcp_output.c:

tcp_send_loss_probe():
...
	/* Retransmit last segment. */
	if (WARN_ON(!skb))
		goto rearm_timer;
...

[  173.557528] WARNING: CPU: 1 PID: 0 at
/srv/oe/build/tmp-rpb-glibc/work-shared/juno/kernel-source/net/ipv4/tcp_output.c:2485
tcp_send_loss_probe+0x164/0x1e8
[  173.571425] Modules linked in: crc32_ce crct10dif_ce fuse
[  173.576804] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.19.7-rc1 #1
[  173.583014] Hardware name: ARM Juno development board (r2) (DT)
[  173.588879] pstate: 60000005 (nZCv daif -PAN -UAO)
[  173.593629] pc : tcp_send_loss_probe+0x164/0x1e8
[  173.598205] lr : tcp_send_loss_probe+0x70/0x1e8
[  173.602692] sp : ffff00000800bcc0
[  173.605976] x29: ffff00000800bcc0 x28: 0000000000000002
[  173.611251] x27: 0000000000000001 x26: ffff00000961fac0
[  173.616525] x25: ffff000008ce8d88 x24: ffff00000961f000
[  173.621799] x23: ffff800974fb2000 x22: ffff800974fb2008
[  173.627073] x21: 00000000000005a8 x20: 0000000000000000
[  173.632346] x19: ffff800974fb1f80 x18: 0000000000000000
[  173.637620] x17: 0000000000000000 x16: 0000000000000000
[  173.642893] x15: 0000000000000000 x14: 0000000000000000
[  173.648167] x13: 000000009100ad59 x12: ffff800976a14b68
[  173.653440] x11: 0000000000000001 x10: ffff00000961f848
[  173.658713] x9 : ffff0000096a8000 x8 : ffff00000961f848
[  173.663987] x7 : ffff000008ce8dcc x6 : 000000015808f2bf
[  173.669260] x5 : 00ffffffffffffff x4 : 0000000000000015
[  173.674534] x3 : 0000000000000002 x2 : 0000000000000020
[  173.679808] x1 : ffff800974fb21d0 x0 : 0000000000000000
[  173.685081] Call trace:
[  173.687507]  tcp_send_loss_probe+0x164/0x1e8
[  173.691738]  tcp_write_timer_handler+0xf8/0x250
[  173.696226]  tcp_write_timer+0xe0/0x110
[  173.700030]  call_timer_fn+0xbc/0x3f0
[  173.703660]  expire_timers+0x104/0x220
[  173.707376]  run_timer_softirq+0xec/0x1a8
[  173.711349]  __do_softirq+0x114/0x554
[  173.714978]  irq_exit+0x144/0x150
[  173.718263]  __handle_domain_irq+0x6c/0xc0
[  173.722321]  gic_handle_irq+0x60/0xb0
[  173.725949]  el1_irq+0xb4/0x130
[  173.729065]  cpuidle_enter_state+0xbc/0x3f0
[  173.733210]  cpuidle_enter+0x34/0x48
[  173.736753]  call_cpuidle+0x44/0x78
[  173.740209]  do_idle+0x238/0x2b8
[  173.743407]  cpu_startup_entry+0x2c/0x30
[  173.747295]  secondary_start_kernel+0x190/0x1d8
[  173.751782] irq event stamp: 1502997
[  173.755330] hardirqs last  enabled at (1502996): [<ffff000008e53c98>]
_raw_spin_unlock_irq+0x38/0x80
[  173.764377] hardirqs last disabled at (1502997): [<ffff0000080814fc>]
do_debug_exception+0x164/0x1a8
[  173.773424] softirqs last  enabled at (1502992): [<ffff0000080f6df0>]
_local_bh_enable+0x28/0x48
[  173.782128] softirqs last disabled at (1502993): [<ffff0000080f74fc>]
irq_exit+0x144/0x150

right after, a NULL dereference at tcp_rearm_rto():

[  173.794928] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000020
[  173.803649] Mem abort info:
[  173.806437]   ESR = 0x96000004
[  173.809484]   Exception class = DABT (current EL), IL = 32 bits
[  173.815368]   SET = 0, FnV = 0
[  173.818412]   EA = 0, S1PTW = 0
[  173.821543] Data abort info:
[  173.824399]   ISV = 0, ISS = 0x00000004
[  173.828217]   CM = 0, WnR = 0
[  173.831178] user pgtable: 4k pages, 48-bit VAs, pgdp = 000000003f5193ed
[  173.837749] [0000000000000020] pgd=0000000000000000
[  173.842732] Internal error: Oops: 96000004 [#1] PREEMPT SMP
[  173.848251] Modules linked in: crc32_ce crct10dif_ce fuse
[  173.853618] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G        W
4.19.7-rc1 #1
[  173.861198] Hardware name: ARM Juno development board (r2) (DT)
[  173.867060] pstate: 80000005 (Nzcv daif -PAN -UAO)
[  173.871805] pc : tcp_rearm_rto.part.38+0x7c/0xa8
[  173.876378] lr : tcp_rearm_rto.part.38+0x7c/0xa8
[  173.880948] sp : ffff00000800bc80
[  173.884228] x29: ffff00000800bc80 x28: 0000000000000002
[  173.889497] x27: 0000000000000001 x26: ffff00000961fac0
[  173.894765] x25: ffff000008ce8d88 x24: ffff00000961f000
[  173.900034] x23: ffff800974fb2000 x22: ffff800974fb2008
[  173.905302] x21: 00000000000005a8 x20: 0000000000000000
[  173.910570] x19: ffff800974fb1f80 x18: 0000000000000000
[  173.915838] x17: 0000000000000000 x16: 0000000000000000
[  173.921106] x15: 0000000000000000 x14: 0000000000000000
[  173.926374] x13: 000000009100ad59 x12: ffff800976a14b68
[  173.931642] x11: 0000000000000001 x10: ffff00000961f848
[  173.936910] x9 : ffff0000096a8000 x8 : ffff00000961f848
[  173.942178] x7 : ffff000008ce8dcc x6 : 000000015808f2bf
[  173.947446] x5 : 00ffffffffffffff x4 : 0000000000000015
[  173.952714] x3 : 0000000000000002 x2 : 0000000000000020
[  173.957982] x1 : ffff800974fb21d0 x0 : 0000000000000000
[  173.963252] Process swapper/1 (pid: 0, stack limit = 0x000000000f373131)
[  173.969886] Call trace:
[  173.972308]  tcp_rearm_rto.part.38+0x7c/0xa8
[  173.976536]  tcp_rearm_rto+0x40/0x60
[  173.980077]  tcp_send_loss_probe+0xc8/0x1e8
[  173.984218]  tcp_write_timer_handler+0xf8/0x250
[  173.988703]  tcp_write_timer+0xe0/0x110
[  173.992502]  call_timer_fn+0xbc/0x3f0
[  173.996129]  expire_timers+0x104/0x220
[  173.999841]  run_timer_softirq+0xec/0x1a8
[  174.003810]  __do_softirq+0x114/0x554
[  174.007436]  irq_exit+0x144/0x150
[  174.010717]  __handle_domain_irq+0x6c/0xc0
[  174.014773]  gic_handle_irq+0x60/0xb0
[  174.018398]  el1_irq+0xb4/0x130
[  174.021509]  cpuidle_enter_state+0xbc/0x3f0
[  174.025651]  cpuidle_enter+0x34/0x48
[  174.029190]  call_cpuidle+0x44/0x78
[  174.032643]  do_idle+0x238/0x2b8
[  174.035838]  cpu_startup_entry+0x2c/0x30
[  174.039722]  secondary_start_kernel+0x190/0x1d8
[  174.044209] Code: d65f03c0 f9000fb4 91092260 94059dd4 (f9401014)

Since this was a 1 time failure, and we couldn't reproduce it again, we
couldn't KASAN the dereference, unfortunately.

Thanks,
-- 
Rafael D. Tinoco
Linaro - Kernel Validation
