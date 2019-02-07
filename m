Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA0D7C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 10:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E35021872
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 10:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfBGKxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 05:53:12 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:37968 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726186AbfBGKxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 05:53:11 -0500
Received: from [192.168.108.68] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez)
        by smtp3-g21.free.fr (Postfix) with ESMTPSA id 5A20813F85A;
        Thu,  7 Feb 2019 11:52:58 +0100 (CET)
Subject: Re: [PATCH v4] scsi/ata: Use unsigned int for cmd's type in ioctls in
 scsi_host_template
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        SCSI <linux-scsi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20190114044206.6351-1-natechancellor@gmail.com>
 <20190126075256.29608-1-natechancellor@gmail.com>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <97d4ab84-f64b-9276-b7a9-3b3be5f5d527@free.fr>
Date:   Thu, 7 Feb 2019 11:52:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190126075256.29608-1-natechancellor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/01/2019 08:52, Nathan Chancellor wrote:

> Clang warns several times in the scsi subsystem (trimmed for brevity):
> 
> drivers/scsi/hpsa.c:6209:7: warning: overflow converting case value to
> switch condition type (2147762695 to 18446744071562347015) [-Wswitch]
>         case CCISS_GETBUSTYPES:
>              ^
> drivers/scsi/hpsa.c:6208:7: warning: overflow converting case value to
> switch condition type (2147762694 to 18446744071562347014) [-Wswitch]
>         case CCISS_GETHEARTBEAT:
>              ^
> 
> The root cause is that the _IOC macro can generate really large numbers,
> which don't find into type 'int', which is used for the cmd paremeter in
              ^^^^                                            ^^^^^^^^^

"which don't fit"
"the cmd parameter"

Regards.

> the ioctls in scsi_host_template. My research into how GCC and Clang are
> handling this at a low level didn't prove fruitful. However, looking at
> the rest of the kernel tree, all ioctls use an 'unsigned int' for the
> cmd parameter, which will fit all of the _IOC values in the scsi/ata
> subsystems.
> 
> Make that change because none of the ioctls expect to take a negative
> value, it brings the ioctls inline with the reset of the kernel, and it
> removes ambiguity, which is never good when dealing with compilers.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/85
> Link: https://github.com/ClangBuiltLinux/linux/issues/154
> Link: https://github.com/ClangBuiltLinux/linux/issues/157
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> ---
> 
> v3 -> v4:
> 
> * Repost with Bart's suggested change and his reviewed by (mainly as an
>   excuse to repost with the below comment).
> 
> v2 -> v3:
> 
> * Fix another -Wswitch warning from drivers/scsi/cxlflash/main.c, coming
>   from decode_hioctl (uncovered via a powernv_defconfig build).
> 
> v1 -> v2:
> 
> * Fix build breakage in cxlflash driver from forgetting to update
>   prototype (thanks to 0day for catching it).
> 
> I apologize for resending this so soon after v3 but it has been three
> months since I sent this patch and I have yet to receive a single
> comment from ANY of the maintainers that './scripts/get_maintainer.pl'
> spits out for this patch so it feels like I am sending it into the void.
> 
> I understand you all are busy people and such and maybe I am being
> impatient but these warnings are rather spammy and we're trying to get
> that category cleaned up as quick as possible so that new warnings are
> easier to spot. I'd appreciate any and all reviews/acks/testing that I
> can get on this patch (especially since it is so simple) so it can be
> accepted and merged into mainline.
