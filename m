Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932760AbeBLGAC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 01:00:02 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:50415 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932416AbeBLGAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 01:00:00 -0500
X-Google-Smtp-Source: AH8x226GQ3PJpcrrkxEq3h+pcnq1knExXCtP4HjpzP4A5Hjrg2F57Dfxh9g11gtcYSCEP6Xlfwrcww==
Date: Mon, 12 Feb 2018 11:29:48 +0530
From: afzal mohammed <afzal.mohd.ma@gmail.com>
To: mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        dwmw@amazon.co.uk, peterz@infradead.org
Cc: linux-tip-commits@vger.kernel.org
Subject: Re: [tip:x86/pti] x86/speculation: Use IBRS if available before
 calling into firmware
Message-ID: <20180212055948.GA3281@afzalpc>
References: <1518362359-1005-1-git-send-email-dwmw@amazon.co.uk>
 <tip-670c3e8da87fa4046a55077b1409cf250865a203@git.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tip-670c3e8da87fa4046a55077b1409cf250865a203@git.kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Feb 11, 2018 at 11:19:10AM -0800, tip-bot for David Woodhouse wrote:

> x86/speculation: Use IBRS if available before calling into firmware
> 
> Retpoline means the kernel is safe because it has no indirect branches.
> But firmware isn't, so use IBRS for firmware calls if it's available.

afaui, so only retpoline means still mitigation not enough.

Also David W has mentioned [1] that even with retpoline, IBPB is also
required (except Sky Lake).

If IBPB & IBRS is not supported by ucode, shouldn't the below indicate
some thing on the lines of Mitigation not enough ?

> -	return sprintf(buf, "%s%s%s\n", spectre_v2_strings[spectre_v2_enabled],
> +	return sprintf(buf, "%s%s%s%s\n", spectre_v2_strings[spectre_v2_enabled],
>  		       boot_cpu_has(X86_FEATURE_USE_IBPB) ? ", IBPB" : "",
> +		       boot_cpu_has(X86_FEATURE_USE_IBRS_FW) ? ", IBRS_FW" : "",
>  		       spectre_v2_module_string());

On 4.16-rc1, w/ GCC 7.3.0,

/sys/devices/system/cpu/vulnerabilities/meltdown:Mitigation: PTI
/sys/devices/system/cpu/vulnerabilities/spectre_v1:Mitigation: __user pointer sanitization
/sys/devices/system/cpu/vulnerabilities/spectre_v2:Mitigation: Full generic retpoline

Here for the user (at least for me), it is not clear whether the
mitigation is enough. In the present system (Ivy Bridge), as ucode
update is not available, IBPB is not printed along with
"spectre_v2:Mitigation", so unless i am missing something, till then
this system should be considered vulnerable, but for a user not
familiar with details of the issue, it cannot be deduced.

Perhaps an additional status field [OKAY,PARTIAL] to Mitigation in
sysfs might be helpful. All these changes are in the air for me, this
is from a user perspective, sorry if my feedback seems idiotic.

afzal


[1] lkml.kernel.org/r/1516638426.9521.20.camel@infradead.org
