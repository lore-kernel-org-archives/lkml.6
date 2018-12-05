Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA957C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 06:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8526A2084C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 06:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="0pYmpW7r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8526A2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbeLEGHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 01:07:32 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:51932 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbeLEGHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 01:07:31 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB564INK094690;
        Wed, 5 Dec 2018 06:07:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=e9iFII9C1C0acSfgyX90GXg6qSj2zoATcOqH0dCyByE=;
 b=0pYmpW7rn7CSAlDuSy+Bifgh5ZtTTfz/mGjEVBOPeMdEfu5hHTZWRPm6avAr1JKqF3x3
 B3xfI8trsb124YYYenBGOVV910u1OrgoAnOhjQ0VJRX0InX9iHcWGD4vHKjBULotaFsO
 OBSaTj2k4RJwGOP1Lr9WYLdGlSFCyfQgNRQViphiTd7eWClK66sPhTczY40j41ZJMCm7
 MzUAGGMx4+5dCAl/3fwXKymlaMQQ5lkphT/40z73vsuM/Mo5PTvitLnP0A+dA3WgwFNP
 20OZg5/0MVPJM98m2TLFnCqBOqHD7IxyMCmx3Nlabw7eZcpT/agRrWIzZgu/ck4ksJk5 mg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2p3hqu0f97-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Dec 2018 06:07:12 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wB567AFd000472
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Dec 2018 06:07:11 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wB5678w1018626;
        Wed, 5 Dec 2018 06:07:08 GMT
Received: from [10.191.30.150] (/10.191.30.150)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 04 Dec 2018 22:07:08 -0800
Subject: Re: [PATCH] x86/build: fix compiler support check for
 CONFIG_RETPOLINE
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Cc:     Meelis Roos <mroos@linux.ee>, "H. Peter Anvin" <hpa@zytor.com>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
References: <1543978802-24196-1-git-send-email-yamada.masahiro@socionext.com>
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
Organization: Oracle Corporation
Message-ID: <de8a06d6-11c5-19ea-07a6-37f8624c8b66@oracle.com>
Date:   Wed, 5 Dec 2018 14:07:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <1543978802-24196-1-git-send-email-yamada.masahiro@socionext.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9097 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812050056
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2018/12/5 11:00, Masahiro Yamada wrote:
> It is wrong to add CONFIG option diagnostic to the Makefile parse
> stage.
>
> Once you are hit by the error about non-retpoline compiler, the
> compilation still breaks even after disabling CONFIG_RETPOLINE.
>
> The easiest fix is to move this check to the "archprepare" like commit
> 829fe4aa9ac1 ("x86: Allow generating user-space headers without a
> compiler") did.
>
> Link: https://lkml.org/lkml/2018/12/4/206
> Reported-by: Meelis Roos <mroos@linux.ee>
> Fixes: 4cd24de3a098 ("x86/retpoline: Make CONFIG_RETPOLINE depend on compiler support")
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>   arch/x86/Makefile | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> index f5d7f41..ae0148b 100644
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -219,12 +219,7 @@ KBUILD_CFLAGS += -Wno-sign-compare
>   KBUILD_CFLAGS += -fno-asynchronous-unwind-tables
>   
>   # Avoid indirect branches in kernel to deal with Spectre
> -ifdef CONFIG_RETPOLINE
> -ifeq ($(RETPOLINE_CFLAGS),)
> -  $(error You are building kernel with non-retpoline compiler, please update your compiler.)
> -endif
> -  KBUILD_CFLAGS += $(RETPOLINE_CFLAGS)
> -endif
> +KBUILD_CFLAGS += $(RETPOLINE_CFLAGS)

Is it better to also move "# Avoid indirect branches in kernel to deal 
with Spectre"

and "KBUILD_CFLAGS += $(RETPOLINE_CFLAGS)"?

Seems unconditionaly using "KBUILD_CFLAGS += $(RETPOLINE_CFLAGS)" will 
have compiler

using "__x86_indirect_thunk_\reg" call even ifCONFIG_RETPOLINE is 
disabled. I guess

link process will fail?

Thanks

Zhenzhong

>   
>   archscripts: scripts_basic
>   	$(Q)$(MAKE) $(build)=arch/x86/tools relocs
> @@ -307,6 +302,13 @@ ifndef CC_HAVE_ASM_GOTO
>   	@echo Compiler lacks asm-goto support.
>   	@exit 1
>   endif
> +ifdef CONFIG_RETPOLINE
> +ifeq ($(RETPOLINE_CFLAGS),)
> +	@echo "You are building kernel with non-retpoline compiler." >&2
> +	@echo "Please update your compiler." >&2
> +	@false
> +endif
> +endif
>   
>   archclean:
>   	$(Q)rm -rf $(objtree)/arch/i386
