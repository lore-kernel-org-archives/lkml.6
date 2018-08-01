Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06447C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 20:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF258208A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 20:10:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF258208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bell.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732115AbeHAV6V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 17:58:21 -0400
Received: from simcoe208srvr.owm.bell.net ([184.150.200.208]:57876 "EHLO
        torfep02.bell.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727679AbeHAV6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 17:58:21 -0400
Received: from bell.net torfep02 184.150.200.158 by torfep02.bell.net
          with ESMTP
          id <20180801201052.SGJA32387.torfep02.bell.net@torspm01.bell.net>;
          Wed, 1 Aug 2018 16:10:52 -0400
Received: from [192.168.2.49] (really [70.53.62.189]) by torspm01.bell.net
          with ESMTP
          id <20180801201052.FGDN26298.torspm01.bell.net@[192.168.2.49]>;
          Wed, 1 Aug 2018 16:10:52 -0400
Subject: Re: [PATCH] parisc: prefer _THIS_IP_ and _RET_IP_ statement
 expressions
To:     Nick Desaulniers <ndesaulniers@google.com>, deller@gmx.de,
        jejb@parisc-linux.org
Cc:     natechancellor@gmail.com, Thomas Gleixner <tglx@linutronix.de>,
        Pravin Shedge <pravin.shedge4linux@gmail.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180801182258.17834-1-ndesaulniers@google.com>
From:   John David Anglin <dave.anglin@bell.net>
Message-ID: <78c667f9-5c8b-3835-83eb-4b59e27e4f7e@bell.net>
Date:   Wed, 1 Aug 2018 16:10:50 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180801182258.17834-1-ndesaulniers@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Cloudmark-Analysis: v=2.2 cv=DZT4krlW c=1 sm=0 tr=0 a=VCUqJnZSONuD0ISaPFNHjQ==:17 a=IkcTkHD0fZMA:10 a=dapMudl6Dx4A:10 a=1XWaLZrsAAAA:8 a=FBHGMhGWAAAA:8 a=Ifv6Lg9Ka88XSd5aAdAA:9 a=pkQT88gv_6D-eQI2:21 a=nhHLAN8c2ApQi0kw:21 a=QEXdDO2ut3YA:10 a=9gvnlMMaQFpL9xblJ6ne:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-01 2:22 PM, Nick Desaulniers wrote:
> As part of the effort to reduce the code duplication between _THIS_IP_
> and current_text_addr(), let's consolidate callers of
> current_text_addr() to use _THIS_IP_.
Using the generic _THIS_IP_ results in significantly longer code than 
the parisc implementation
of current_text_addr().  It also results in a local label in the text.  
This breaks the unwind data
for the function with the label in 32-bit kernels.  The implementation 
of current_text_addr()
doesn't add a label.  _THIS_IP_ should be defined using 
current_text_addr() on parisc.
>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>   arch/parisc/kernel/unwind.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/parisc/kernel/unwind.c b/arch/parisc/kernel/unwind.c
> index 2ef83d78eec4..a4b430f440a9 100644
> --- a/arch/parisc/kernel/unwind.c
> +++ b/arch/parisc/kernel/unwind.c
> @@ -439,8 +439,8 @@ unsigned long return_address(unsigned int level)
>   	/* initialize unwind info */
>   	asm volatile ("copy %%r30, %0" : "=r"(sp));
>   	memset(&r, 0, sizeof(struct pt_regs));
> -	r.iaoq[0] = (unsigned long) current_text_addr();
> -	r.gr[2] = (unsigned long) __builtin_return_address(0);
> +	r.iaoq[0] = _THIS_IP_;
> +	r.gr[2] = _RET_IP_;
>   	r.gr[30] = sp;
>   	unwind_frame_init(&info, current, &r);
>   

Dave

-- 
John David Anglin  dave.anglin@bell.net

