Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752189AbeC0WLo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 18:11:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:52352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751020AbeC0WLn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 18:11:43 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 035B72172B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jeyu@kernel.org
Date: Wed, 28 Mar 2018 00:11:37 +0200
From: Jessica Yu <jeyu@kernel.org>
To: Jia Zhang <zhang.jia@linux.alibaba.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3][RESEND] modsign enhancement
Message-ID: <20180327221137.d7fhboicw2wi3a52@redbean>
References: <1521860389-19262-1-git-send-email-zhang.jia@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1521860389-19262-1-git-send-email-zhang.jia@linux.alibaba.com>
X-OS: Linux redbean 4.15.10-200.fc26.x86_64 x86_64
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Jia Zhang [24/03/18 10:59 +0800]:
>This patch series allows to disable module validity enforcement
>in runtime through the control switch located in securityfs.
>
>In order to keep /sys/module/module/parameters/sig_enforce simple,
>the disablement switch is located at
>/sys/kernel/security/modsign/disable_enforce.
>
>Assuming CONFIG_MODULE_SIG_FORCE=n, here are the instructions to
>test this control switch.
>
># cat /sys/module/module/parameters/sig_enforce
>N
># echo 1 > /sys/module/module/parameters/sig_enforce
># cat /sys/module/module/parameters/sig_enforce
>Y
># echo -n 0 > no_sig_enforce
># openssl smime -sign -nocerts -noattr -binary -in no_sig_enforce \
>    -inkey <system_trusted_key> -signer <cert> -outform der \
>    -out /sys/kernel/security/modsign/disable_enforce
># cat /sys/module/module/parameters/sig_enforce
>N

I'm not convinced we need this. And neither the use case nor the
motivation is explained in the cover letter :-(

The way I see it - the only time you'd actually use this is in the
situation where you have *already* enabled sig_enforce, and then later
you change your mind - meaning you wanted to load unsigned modules
after all. And if you ever plan on loading unsigned modules, why would
you have enabled sig_enforce in the first place? If you want to keep
the option of loading unsigned modules, don't have sig_enforce or
CONFIG_MODULE_SIG_FORCE enabled.

[ CC'd Rusty in case he has some thoughts on this ]

Jessica
