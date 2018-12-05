Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91998C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 07:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D6DB206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 07:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FmUk7gYV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D6DB206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbeLEHLV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 02:11:21 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:46908 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbeLEHLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 02:11:20 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB574Ska101593;
        Wed, 5 Dec 2018 07:10:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=zEx7FYUQNfSZuw7S5NHtoUJ5AraOFeU23ry2T2pRsZ8=;
 b=FmUk7gYVbMhR1rCBQaXStiNhMErvwuvO54f8HCZ1DoWBK5ma27WfaxauRTG8gkezdBB4
 w2bQ8iahwGH9IPMaHpmqgZn6k6qrGWp8MAPbdEnUVhMYOH4PSyfiAm43AOGyA14TmAZF
 j+GZ9nCidWKQm+ezm+1+inf+1MDgB5Xa5a7tiCEFn3mNk8U3a++D+kes5peA+Q7nC5OV
 MQYOeI8uooQXBOVCHhVyn1L5J/cQ786jH6kfeEBB0LjOLLIVaDToFvGt51Djopc6759S
 1QHSzSfuqZaau5xU9Y88zWuAXY9GWm4YT0Iu4M9EnYqeBjCC+DPvHejljCLJa27bqPyV 2w== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2p3jxrgk8q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Dec 2018 07:10:59 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wB57ArA3001088
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Dec 2018 07:10:53 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wB57AqVt005660;
        Wed, 5 Dec 2018 07:10:52 GMT
Received: from [10.191.30.150] (/10.191.30.150)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 04 Dec 2018 23:10:51 -0800
Subject: Re: [PATCH v2] x86/build: fix compiler support check for
 CONFIG_RETPOLINE
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Cc:     Meelis Roos <mroos@linux.ee>, "H. Peter Anvin" <hpa@zytor.com>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
References: <1543991239-18476-1-git-send-email-yamada.masahiro@socionext.com>
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
Organization: Oracle Corporation
Message-ID: <34aa8fad-ee7f-6833-41a2-00a92b4ad369@oracle.com>
Date:   Wed, 5 Dec 2018 15:10:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <1543991239-18476-1-git-send-email-yamada.masahiro@socionext.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9097 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812050066
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2018/12/5 14:27, Masahiro Yamada wrote:
> It is troublesome to add a diagnostic like this to the Makefile
> parse stage because the top-level Makefile could be parsed with
> a stale include/config/auto.conf.
>
> Once you are hit by the error about non-retpoline compiler, the
> compilation still breaks even after disabling CONFIG_RETPOLINE.
>
> The easiest fix is to move this check to the "archprepare" like commit
> 829fe4aa9ac1 ("x86: Allow generating user-space headers without a
> compiler") did.
>
> Link: https://lkml.org/lkml/2018/12/4/206
> Fixes: 4cd24de3a098 ("x86/retpoline: Make CONFIG_RETPOLINE depend on compiler support")
> Reported-by: Meelis Roos <mroos@linux.ee>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
> Changes in v2:
>    - Revive ifdef CONFIG_RETPOLINE surrounding the KBUILD_CFLAGS addition
>    - Rephase the commit log a bit, hoping the cause of the issue will be clearer
>
>   arch/x86/Makefile | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> index f5d7f41..75ef499 100644
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -220,9 +220,6 @@ KBUILD_CFLAGS += -fno-asynchronous-unwind-tables
>   
>   # Avoid indirect branches in kernel to deal with Spectre
>   ifdef CONFIG_RETPOLINE
> -ifeq ($(RETPOLINE_CFLAGS),)
> -  $(error You are building kernel with non-retpoline compiler, please update your compiler.)
> -endif
>     KBUILD_CFLAGS += $(RETPOLINE_CFLAGS)
>   endif
>   
> @@ -307,6 +304,13 @@ ifndef CC_HAVE_ASM_GOTO
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
Acked-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>

-- 
Regards
Zhenzhong

