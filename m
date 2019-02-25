Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BBECC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 058CA20C01
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:29:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731694AbfBYV3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:29:05 -0500
Received: from www62.your-server.de ([213.133.104.62]:46878 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730948AbfBYV3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:29:02 -0500
Received: from [88.198.220.130] (helo=sslproxy01.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1gyNo4-00075x-5j; Mon, 25 Feb 2019 22:29:00 +0100
Received: from [178.197.249.32] (helo=linux.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1gyNo3-0005kC-RN; Mon, 25 Feb 2019 22:28:59 +0100
Subject: Re: [PATCH v2] bpf: test_bpf: turn of preemption in function
 __run_once
To:     Anders Roxell <anders.roxell@linaro.org>, ast@kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
References: <20190222084652.1326-1-anders.roxell@linaro.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <31dccc3f-3355-31b6-87c1-81d9ff35515b@iogearbox.net>
Date:   Mon, 25 Feb 2019 22:28:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190222084652.1326-1-anders.roxell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25371/Mon Feb 25 11:48:47 2019)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/22/2019 09:46 AM, Anders Roxell wrote:
> When running BPF test suite the following splat occurs:
> 
> [  415.930950] test_bpf: #0 TAX jited:0
> [  415.931067] BUG: assuming atomic context at lib/test_bpf.c:6674
> [  415.946169] in_atomic(): 0, irqs_disabled(): 0, pid: 11556, name: modprobe
> [  415.953176] INFO: lockdep is turned off.
> [  415.957207] CPU: 1 PID: 11556 Comm: modprobe Tainted: G        W         5.0.0-rc7-next-20190220 #1
> [  415.966328] Hardware name: HiKey Development Board (DT)
> [  415.971592] Call trace:
> [  415.974069]  dump_backtrace+0x0/0x160
> [  415.977761]  show_stack+0x24/0x30
> [  415.981104]  dump_stack+0xc8/0x114
> [  415.984534]  __cant_sleep+0xf0/0x108
> [  415.988145]  test_bpf_init+0x5e0/0x1000 [test_bpf]
> [  415.992971]  do_one_initcall+0x90/0x428
> [  415.996837]  do_init_module+0x60/0x1e4
> [  416.000614]  load_module+0x1de0/0x1f50
> [  416.004391]  __se_sys_finit_module+0xc8/0xe0
> [  416.008691]  __arm64_sys_finit_module+0x24/0x30
> [  416.013255]  el0_svc_common+0x78/0x130
> [  416.017031]  el0_svc_handler+0x38/0x78
> [  416.020806]  el0_svc+0x8/0xc
> 
> Rework so that preemption is disabled when we loop over function
> 'BPF_PROG_RUN(...)'.
> Commit 568f196756ad ("bpf: check that BPF programs run with preemption disabled")
> highlighted the issue.

(Technically not an issue in the test suite itself, but good to have same
 guarantees everywhere in BPF_PROG_RUN().)

> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Applied, thanks!
