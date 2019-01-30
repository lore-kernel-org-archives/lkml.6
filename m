Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB00C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E69E420870
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731779AbfA3QRF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 11:17:05 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56942 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727546AbfA3QRE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 11:17:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DBF60EBD;
        Wed, 30 Jan 2019 08:17:03 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F2F33F589;
        Wed, 30 Jan 2019 08:17:02 -0800 (PST)
Subject: Re: [PATCH v3 0/4] uaccess: Add unsafe accessors for arm64
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mingo@redhat.com, peterz@infradead.org, hpa@zytor.com
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com
References: <1547560709-56207-1-git-send-email-julien.thierry@arm.com>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <3bb671a6-a7df-9c96-e4d3-09167df6dab1@arm.com>
Date:   Wed, 30 Jan 2019 16:17:00 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1547560709-56207-1-git-send-email-julien.thierry@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Gentle ping for patches 3 and 4.

Thanks,

Julien

On 15/01/2019 13:58, Julien Thierry wrote:
> Hi,
> 
> First version of this series[1] was briefly in linux-next but had to be
> reverted due to a bug where schedule would end up being called while
> user_access was active[2].
> 
> After clarifications[3], rescheduling while in a user_access region is not
> allowed.
> 
> * Patches 1 and 2 implement the unsafe accessors for arm64
> * Patches 3 and 4 clarify this restriction in the API and attempts to
>   check against violations of the restriction.
> 
> Changes since v2[4]:
> - Rebase on v5.0-rc2
> - access_ok() is now done in user_access_begin(), so rework accessors
>   so access_ok() is not called in unsafe_get/put_user()
> - Split addition of unsafe accessors and the user_access_region check
>   into separate patches
> - Avoid reading SCTLR_EL1 in user_access_region check
> - Add build option for user_access_region checking
> - Reword clarifications on unsafe accessors API
> 
> Changes since v1[1]:
> - Add a way to detect code calling schedule within a user_access region
> - Make sure put_user/get_user arguments are evaluated before disabling PAN
> 
> [1] https://www.spinics.net/lists/arm-kernel/msg674925.html
> [2] https://patchwork.kernel.org/patch/10634783/
> [3] https://lkml.org/lkml/2018/11/28/50
> [4] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-December/617080.html
> 
> Cheers,
> 
> Julien
> 
> -->
> 
> Julien Thierry (4):
>   arm64: uaccess: Cleanup get/put_user()
>   arm64: uaccess: Implement unsafe accessors
>   uaccess: Check no rescheduling function is called in unsafe region
>   arm64: uaccess: Implement user_access_region_active
> 
>  arch/arm64/include/asm/sysreg.h  |   2 +
>  arch/arm64/include/asm/uaccess.h | 123 ++++++++++++++++++++++++++-------------
>  include/linux/kernel.h           |  11 +++-
>  include/linux/uaccess.h          |  13 +++++
>  kernel/sched/core.c              |  22 +++++++
>  lib/Kconfig.debug                |   8 +++
>  6 files changed, 135 insertions(+), 44 deletions(-)
> 
> --
> 1.9.1
> 

-- 
Julien Thierry
