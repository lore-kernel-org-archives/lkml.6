Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71443C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 13:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4233220878
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 13:01:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4233220878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbeJHUNU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 16:13:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:41938 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726177AbeJHUNU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 16:13:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C55C1ACFB;
        Mon,  8 Oct 2018 13:01:41 +0000 (UTC)
Date:   Mon, 8 Oct 2018 15:01:40 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     zhe.he@windriver.com
Cc:     sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/4] printk: Fix panic caused by passing log_buf_len
 to command line
Message-ID: <20181008130140.elxnip7npkcd6wpq@pathway.suse.cz>
References: <1538239553-81805-1-git-send-email-zhe.he@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538239553-81805-1-git-send-email-zhe.he@windriver.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 2018-09-30 00:45:50, zhe.he@windriver.com wrote:
> From: He Zhe <zhe.he@windriver.com>
> 
> log_buf_len_setup does not check input argument before passing it to
> simple_strtoull. The argument would be a NULL pointer if "log_buf_len",
> without its value, is set in command line and thus causes the following
> panic.
> 
> PANIC: early exception 0xe3 IP 10:ffffffffaaeacd0d error 0 cr2 0x0
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.19.0-rc4-yocto-standard+ #1
> [    0.000000] RIP: 0010:_parse_integer_fixup_radix+0xd/0x70
> ...
> [    0.000000] Call Trace:
> [    0.000000]  simple_strtoull+0x29/0x70
> [    0.000000]  memparse+0x26/0x90
> [    0.000000]  log_buf_len_setup+0x17/0x22
> [    0.000000]  do_early_param+0x57/0x8e
> [    0.000000]  parse_args+0x208/0x320
> [    0.000000]  ? rdinit_setup+0x30/0x30
> [    0.000000]  parse_early_options+0x29/0x2d
> [    0.000000]  ? rdinit_setup+0x30/0x30
> [    0.000000]  parse_early_param+0x36/0x4d
> [    0.000000]  setup_arch+0x336/0x99e
> [    0.000000]  start_kernel+0x6f/0x4ee
> [    0.000000]  x86_64_start_reservations+0x24/0x26
> [    0.000000]  x86_64_start_kernel+0x6f/0x72
> [    0.000000]  secondary_startup_64+0xa4/0xb0
> 
> This patch adds a check to prevent the panic.
> 
> Signed-off-by: He Zhe <zhe.he@windriver.com>

JFYI, I have pushed this patch into printk.git, branch for-4.20.

Best Regards,
Petr
