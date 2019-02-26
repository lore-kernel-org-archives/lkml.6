Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 166E8C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 20:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDEF721850
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 20:47:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728997AbfBZUrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 15:47:51 -0500
Received: from mail1.windriver.com ([147.11.146.13]:40755 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727981AbfBZUrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 15:47:51 -0500
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id x1QKlT6R019878
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Tue, 26 Feb 2019 12:47:29 -0800 (PST)
Received: from [172.25.59.210] (172.25.59.210) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.3.435.0; Tue, 26 Feb 2019
 12:47:29 -0800
Subject: Re: [PATCH] gdbstub: mark expected switch fall-throughs
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
CC:     <kgdb-bugreport@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, Kees Cook <keescook@chromium.org>
References: <20190226191614.GA21908@embeddedor>
From:   Jason Wessel <jason.wessel@windriver.com>
Message-ID: <d0ae1626-1a41-55c5-cfe9-0dea3edc98f9@windriver.com>
Date:   Tue, 26 Feb 2019 14:47:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190226191614.GA21908@embeddedor>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We'll have to fix them at some point.

Acked-by: Jason Wessel <jason.wessel@windriver.com>


Cheers,
Jason.

On 2/26/19 1:16 PM, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch
> cases where we are expecting to fall through.
> 
> This patch fixes the following warnings:
> 
> kernel/debug/gdbstub.c: In function ‘gdb_serial_stub’:
> kernel/debug/gdbstub.c:1031:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
>      if (remcom_in_buffer[1] == '\0') {
>         ^
> kernel/debug/gdbstub.c:1036:3: note: here
>     case 'C': /* Exception passing */
>     ^~~~
> kernel/debug/gdbstub.c:1040:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
>      if (tmp == 0)
>         ^
> kernel/debug/gdbstub.c:1043:3: note: here
>     case 'c': /* Continue packet */
>     ^~~~
> kernel/debug/gdbstub.c:1050:4: warning: this statement may fall through [-Wimplicit-fallthrough=]
>      dbg_activate_sw_breakpoints();
>      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> kernel/debug/gdbstub.c:1052:3: note: here
>     default:
>     ^~~~~~~
> 
> Warning level 3 was used: -Wimplicit-fallthrough=3
> 
> Notice that, in this particular case, the code comment is modified
> in accordance with what GCC is expecting to find.
> 
> This patch is part of the ongoing efforts to enable
> -Wimplicit-fallthrough.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>   kernel/debug/gdbstub.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/debug/gdbstub.c b/kernel/debug/gdbstub.c
> index 7510dc687c0d..9f267b8905b4 100644
> --- a/kernel/debug/gdbstub.c
> +++ b/kernel/debug/gdbstub.c
> @@ -1033,13 +1033,14 @@ int gdb_serial_stub(struct kgdb_state *ks)
>   				return DBG_PASS_EVENT;
>   			}
>   #endif
> +			/* Fall through */
>   		case 'C': /* Exception passing */
>   			tmp = gdb_cmd_exception_pass(ks);
>   			if (tmp > 0)
>   				goto default_handle;
>   			if (tmp == 0)
>   				break;
> -			/* Fall through on tmp < 0 */
> +			/* Fall through - on tmp < 0 */
>   		case 'c': /* Continue packet */
>   		case 's': /* Single step packet */
>   			if (kgdb_contthread && kgdb_contthread != current) {
> @@ -1048,7 +1049,7 @@ int gdb_serial_stub(struct kgdb_state *ks)
>   				break;
>   			}
>   			dbg_activate_sw_breakpoints();
> -			/* Fall through to default processing */
> +			/* Fall through - to default processing */
>   		default:
>   default_handle:
>   			error = kgdb_arch_handle_exception(ks->ex_vector,
> 

