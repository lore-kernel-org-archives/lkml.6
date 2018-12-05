Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C688C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 03:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E89520666
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 03:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="uvPvNegF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E89520666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbeLEDWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 22:22:45 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:51382 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbeLEDWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 22:22:44 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB53EvLT175001;
        Wed, 5 Dec 2018 03:22:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=xqsssdBJaamGymmETkekr5hsqf+KnFdASo7anoTu9yA=;
 b=uvPvNegFCcuKS3Cz/tVUfpw3aoEwfXqvz8D8hFADwjVjQRJIblLS3rtKDxFm2MfwQHaY
 NglBY3ft38bIQeGkfGjbsjWbC3yc/fMFiPfSrRFmxNKcULMEFNO3+jErppGM9amgcUJK
 aWtt5GR4AKnWurvSmp9iXMVl62LOfLZCMOn3LXNr59XWccAuoohUZuk4GMqQFFHZRprE
 XSKU4ywwsi81BJEfnMzahZqmOrM9T173tw9wzpcMXayk1K+hMyF30DnDGOuZ6OXp4Na8
 ABBj6tp3/Sh+3wW01P3KWLCkq7HkFHUMaU9TOgzebx+IkrtCmJbLDbW3tSeo6WDGiyuY cQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2p3hqu017p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Dec 2018 03:22:20 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wB53MKPC017963
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Dec 2018 03:22:20 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wB53MJ39011938;
        Wed, 5 Dec 2018 03:22:19 GMT
Received: from [10.191.22.183] (/10.191.22.183)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 04 Dec 2018 19:22:18 -0800
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
Message-ID: <39eae552-38cb-d6af-4717-e8a1cb1931cd@oracle.com>
Date:   Wed, 5 Dec 2018 11:22:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <1543978802-24196-1-git-send-email-yamada.masahiro@socionext.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9097 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812050028
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,


Thanks for fixing.
There is a question still confusing me. There are many CONFIG_* used in 
arch/x86/Makefile.
Will they also be impacted or not?

# grep CONFIG_ arch/x86/Makefile
ifeq ($(CONFIG_X86_32),y)
         cflags-$(CONFIG_MK8) += $(call cc-option,-march=k8)
         cflags-$(CONFIG_MPSC) += $(call cc-option,-march=nocona)
  ......
drivers-$(CONFIG_MATH_EMULATION) += arch/x86/math-emu/
drivers-$(CONFIG_PCI)      += arch/x86/pci/
drivers-$(CONFIG_OPROFILE) += arch/x86/oprofile/
drivers-$(CONFIG_PM) += arch/x86/power/
drivers-$(CONFIG_FB) += arch/x86/video/
ifeq ($(CONFIG_X86_DECODER_SELFTEST),y)

Thanks
Zhenzhong
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
