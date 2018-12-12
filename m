Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D82C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 08:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B6FC2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 08:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hIO7DCyq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B6FC2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbeLLIPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 03:15:17 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:37352 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbeLLIPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 03:15:17 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBC8E7m8062503;
        Wed, 12 Dec 2018 08:14:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=HnvVZRmb5+psxw23jqLmMfTyU8SDp2eubhdeSVglLAw=;
 b=hIO7DCyqw+Ju5Y4vzt8Yxssm1uHVMPtKqBdX8LZn97mvjYE81AJJ0OUoBDLnLjjMdJBM
 W5pPLNHcs2Li8HNxRyCRjh/m6QRfBs+Hqdmj18vsWkOyx9r4h3AeJtXfLnurWqin7faU
 mZybh2gXrc1FntZtNH2+J78TWz6xUXbL0FC3oMn+o5VZhcy0YCUPJ7FZm9JeVFdepixu
 dz5JrnyuZBI321iDUh073PUHrkjbk6C8Coc6YvH29NoXcmXMGJG7bI07McQDN7xsvEe5
 x9vPVLKtUrlN91rssqeiHWkRuKWPm+w8Wj3qhMJho8tKqPX6y3QgwFxhcPnMggG7JPpV Pg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2p85cu8cs4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Dec 2018 08:14:13 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wBC8EBjh000621
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Dec 2018 08:14:11 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wBC8EAco004482;
        Wed, 12 Dec 2018 08:14:10 GMT
Received: from [10.191.13.139] (/10.191.13.139)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 12 Dec 2018 00:14:10 -0800
Subject: Re: [PATCH] treewide: replace RETPOLINE with CONFIG_RETPOLINE
To:     WANG Chao <chao.wang@ucloud.cn>, linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Borislav Petkov <bp@suse.de>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Andy Lutomirski <luto@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        srinivas.eeda@oracle.com
References: <20181210163725.95977-1-chao.wang@ucloud.cn>
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
Organization: Oracle Corporation
Message-ID: <aaa4267a-c113-222e-157e-309ca9aa7be5@oracle.com>
Date:   Wed, 12 Dec 2018 16:14:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181210163725.95977-1-chao.wang@ucloud.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9104 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=18 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812120073
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2018/12/11 0:37, WANG Chao wrote:
> Since commit 4cd24de3a098 ("x86/retpoline: Make CONFIG_RETPOLINE depend
> on compiler support"), RETPOLINE has been replaced by CONFIG_RETPOLINE.
>
> Fixes: 4cd24de3a098 ("x86/retpoline: Make CONFIG_RETPOLINE depend on compiler support")
> Signed-off-by: WANG Chao <chao.wang@ucloud.cn>
> ---
>   arch/x86/kernel/cpu/bugs.c   | 2 +-
>   include/linux/compiler-gcc.h | 2 +-
>   include/linux/module.h       | 2 +-
>   scripts/mod/modpost.c        | 2 +-
>   4 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index 500278f5308e..e8abe3f6c10e 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -213,7 +213,7 @@ static enum spectre_v2_mitigation spectre_v2_enabled __ro_after_init =
>   static enum spectre_v2_user_mitigation spectre_v2_user __ro_after_init =
>   	SPECTRE_V2_USER_NONE;
>   
> -#ifdef RETPOLINE
> +#ifdef CONFIG_RETPOLINE
>   static bool spectre_v2_bad_module;
>   
>   bool retpoline_module_ok(bool has_retpoline)
> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> index 2010493e1040..977ddf2774f9 100644
> --- a/include/linux/compiler-gcc.h
> +++ b/include/linux/compiler-gcc.h
> @@ -68,7 +68,7 @@
>    */
>   #define uninitialized_var(x) x = x
>   
> -#ifdef RETPOLINE
> +#ifdef CONFIG_RETPOLINE
>   #define __noretpoline __attribute__((__indirect_branch__("keep")))
>   #endif
>   
> diff --git a/include/linux/module.h b/include/linux/module.h
> index fce6b4335e36..0c575f51fe57 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -817,7 +817,7 @@ static inline void module_bug_finalize(const Elf_Ehdr *hdr,
>   static inline void module_bug_cleanup(struct module *mod) {}
>   #endif	/* CONFIG_GENERIC_BUG */
>   
> -#ifdef RETPOLINE
> +#ifdef CONFIG_RETPOLINE
>   extern bool retpoline_module_ok(bool has_retpoline);
>   #else
>   static inline bool retpoline_module_ok(bool has_retpoline)
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 0d998c54564d..5a5b3780456f 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -2157,7 +2157,7 @@ static void add_intree_flag(struct buffer *b, int is_intree)
>   /* Cannot check for assembler */
>   static void add_retpoline(struct buffer *b)
>   {
> -	buf_printf(b, "\n#ifdef RETPOLINE\n");
> +	buf_printf(b, "\n#ifdef CONFIG_RETPOLINE\n");
>   	buf_printf(b, "MODULE_INFO(retpoline, \"Y\");\n");
>   	buf_printf(b, "#endif\n");
>   }

I have no idea why I have missed these chunks. Thank you for fixing.

Reviewed-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>

