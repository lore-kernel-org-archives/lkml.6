Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93CFCC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 02:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D3DF208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 02:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aEC/97rQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D3DF208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387656AbeHPFUV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 01:20:21 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37044 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727285AbeHPFUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 01:20:20 -0400
Received: by mail-wm0-f68.google.com with SMTP id n11-v6so2887324wmc.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 19:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0rULuMANK+8h/agHBwYMagtGdZ9Zl3Y8rQZGFG55RVk=;
        b=aEC/97rQ1IZ0I88svk/I03RZ/OdHGHQ3sk6aKccXPlUu/pQx4x1ti+BFs7/rIilAuF
         K3CDfozWtSrZJ3wZ6eSj8MAR4eBuFjztN+BaHdHtmbcl8PLVfWF+vkTO3pp9MzaKlrIQ
         ZFqRtfjAMSIIt6tMamuTNGYpoBF/ddp0RIouo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0rULuMANK+8h/agHBwYMagtGdZ9Zl3Y8rQZGFG55RVk=;
        b=JFo/91Syfit5k2B4hk4DqCA3EPq/vlIAZ7jwumkqen0Ais8rhIC/1wdy+pvPqY+05T
         BQYe0QM3zXFZ3KAz2UooZuzcHwDWg8i1L31NGK1LOMLWE+JAqJcWozOGdGXbx10cUtkQ
         Ll+mCxBuGDY7mJHAGSXWpbWimQ/RyznNEhndvd5eqJo9vIWBQM+KfDjrUE3Kt9WgVqS4
         Q3ZkYOXd8Xfd5WsqWEUCK9urN5UKAl3kgd9Jy5e9FuY9M5wtczPc0HMDQ8Vz92A1DhLF
         s2sgYDcD96FFGAz4YPEBYSGoF/sBO3CB4j2zZZ9Ry/h4LwSM/DNZx6GTX+eHFIVf7Eag
         dEAA==
X-Gm-Message-State: AOUpUlFW66/YAZ0/OuzgXEqKv5Mw+YjFUNejmxMCiAm4xwWl45bS32oV
        NwSJMwNkl9WQz8ziKmbpAjhtkQ==
X-Google-Smtp-Source: AA+uWPxWiBKk4jy52ZF5N6aQ+Lm62nqQqMPPs/8zEj3TUgQk7M3EQtrF0x76gfTN3aMk2DuwSWWwWw==
X-Received: by 2002:a1c:9f12:: with SMTP id i18-v6mr15221643wme.124.1534386314361;
        Wed, 15 Aug 2018 19:25:14 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([45.76.138.171])
        by smtp.gmail.com with ESMTPSA id e137-v6sm5214868wma.20.2018.08.15.19.25.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Aug 2018 19:25:13 -0700 (PDT)
Date:   Thu, 16 Aug 2018 10:25:06 +0800
From:   leo.yan@linaro.org
To:     Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Cc:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: AArch64 boot failure on Hikey960 on latest master after "arm64:
 insn: Don't fallback on nosync path for general insn patching"
Message-ID: <20180816022506.GB13920@leoy-ThinkPad-X240s>
References: <462f8ae6-9948-a8e5-7504-623d40344336@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <462f8ae6-9948-a8e5-7504-623d40344336@iki.fi>
User-Agent: Mutt/1.10+31 (9cdd884) (2018-06-19)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 02:38:51AM +0300, Tuomas Tynkkynen wrote:
> Hello,
> 
> Booting Linus's master of today with the usual arm64 defconfig fails for
> me on the Hikey960 board. I've bisected it down to:
> 
> commit 693350a7998018391852c48f68956cf0f855b2b9 (HEAD, refs/bisect/bad)
> Author: Will Deacon <will.deacon@arm.com>
> Date:   Tue Jun 19 17:55:28 2018 +0100
> 
>     arm64: insn: Don't fallback on nosync path for general insn patching
> 
> Here's the boot log with earlycon enabled after which the boot hangs:

[...]

> [    0.207583] CPU features: SANITY CHECK: Unexpected variation in SYS_ID_AA64MMFR0_EL1. Boot CPU: 0x00000000001122, CPU4: 0x00000000101122
> [    0.207614] CPU features: Unsupported CPU feature variation detected.
> [    0.207643] BUG: scheduling while atomic: swapper/4/0/0x00000002
> [    0.207645] Modules linked in:
> [    0.207652] CPU: 4 PID: 0 Comm: swapper/4 Tainted: G S                4.18.0-rc3-00017-g693350a79980 #17
> [    0.207654] Hardware name: HiKey960 (DT)
> [    0.207656] Call trace:
> [    0.207670]  dump_backtrace+0x0/0x150
> [    0.207674]  show_stack+0x14/0x20
> [    0.207680]  dump_stack+0x90/0xbc
> [    0.207685]  __schedule_bug+0x58/0x70
> [    0.207690]  __schedule+0x51c/0x5b0
> [    0.207693]  schedule+0x38/0xa0
> [    0.207694]  schedule_timeout+0x23c/0x340
> [    0.207698]  wait_for_common+0x140/0x170
> [    0.207701]  wait_for_completion+0x14/0x20
> [    0.207704]  __stop_cpus+0x68/0xa0
> [    0.207706]  stop_cpus+0x40/0x60
> [    0.207708]  stop_machine_cpuslocked+0xd4/0xf0
> [    0.207711]  aarch64_insn_patch_text+0x48/0x70
> [    0.207715]  arch_jump_label_transform+0x48/0x80
> [    0.207718]  __jump_label_update+0xa4/0xf0
> [    0.207721]  jump_label_update+0xe8/0x120
> [    0.207724]  static_key_enable_cpuslocked+0x7c/0xc0
> [    0.207730]  arch_timer_check_ool_workaround+0x190/0x1f0
> [    0.207732]  arch_timer_starting_cpu+0xd8/0x290
> [    0.207737]  cpuhp_invoke_callback+0x90/0x220
> [    0.207739]  notify_cpu_starting+0x68/0xa0
> [    0.207742]  secondary_start_kernel+0xe8/0x160

From this part log, it's quite likely related with CPU4 (CA73) with
arch timer workaround ERRATUM_858921, before I reported another
similiar lockup issue: https://lkml.org/lkml/2017/7/24/346.

Thanks,
Leo Yan
