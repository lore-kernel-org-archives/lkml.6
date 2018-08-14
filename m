Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D22C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 04:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE7A42173C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 04:56:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE7A42173C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731867AbeHNHlq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 03:41:46 -0400
Received: from smtprelay0073.hostedemail.com ([216.40.44.73]:58896 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725999AbeHNHlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 03:41:46 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave01.hostedemail.com (Postfix) with ESMTP id E7597180357FE;
        Tue, 14 Aug 2018 04:49:40 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 24BE2181D341D;
        Tue, 14 Aug 2018 04:49:40 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: shape15_19e6d385ddf31
X-Filterd-Recvd-Size: 3390
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Tue, 14 Aug 2018 04:49:37 +0000 (UTC)
Message-ID: <c998658f11cd202fffa4b96b97af196049d78ec0.camel@perches.com>
Subject: Re: [PATCH 2/2] powerpc: Use ARRAY_SIZE to replace its
 implementation
From:   Joe Perches <golf@perches.com>
To:     zhong jiang <zhongjiang@huawei.com>, tony.luck@intel.com,
        fenghua.yu@intel.com, benh@kernel.crashing.org, paulus@samba.org,
        mpe@ellerman.id.au, oleg@redhat.com, rppt@linux.vnet.ibm.com,
        dhowells@redhat.com, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk
Cc:     linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Date:   Mon, 13 Aug 2018 21:49:36 -0700
In-Reply-To: <1534214814-9043-3-git-send-email-zhongjiang@huawei.com>
References: <1534214814-9043-1-git-send-email-zhongjiang@huawei.com>
         <1534214814-9043-3-git-send-email-zhongjiang@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-08-14 at 10:46 +0800, zhong jiang wrote:
> Use ARRAY_SIZE instead of dividing sizeof array with sizeof an element.
> So just replace it.

Better to remove the extern and the const altogether here as well.

$ git grep -w powerpc_num_opcodes
arch/powerpc/xmon/ppc-dis.c:  opcode_end = powerpc_opcodes + powerpc_num_opcodes;
arch/powerpc/xmon/ppc-opc.c:const int powerpc_num_opcodes =
arch/powerpc/xmon/ppc.h:extern const int powerpc_num_opcodes;

And this one could be removed instead:

$ git grep -w vle_num_opcodes
arch/powerpc/xmon/ppc-opc.c:const int vle_num_opcodes =
arch/powerpc/xmon/ppc.h:extern const int vle_num_opcodes;

> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  arch/powerpc/xmon/ppc-opc.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/powerpc/xmon/ppc-opc.c b/arch/powerpc/xmon/ppc-opc.c
> index ac2b55b..f3f57a1 100644
> --- a/arch/powerpc/xmon/ppc-opc.c
> +++ b/arch/powerpc/xmon/ppc-opc.c
> @@ -966,8 +966,7 @@
>    { 0xff, 11, NULL, NULL, PPC_OPERAND_SIGNOPT },
>  };
>  
> -const unsigned int num_powerpc_operands = (sizeof (powerpc_operands)
> -					   / sizeof (powerpc_operands[0]));
> +const unsigned int num_powerpc_operands = ARRAY_SIZE(powerpc_operands);
>  
>  /* The functions used to insert and extract complicated operands.  */
>  
> @@ -6980,8 +6979,7 @@
>  {"fcfidu.",	XRC(63,974,1),	XRA_MASK, POWER7|PPCA2,	PPCVLE,		{FRT, FRB}},
>  };
>  
> -const int powerpc_num_opcodes =
> -  sizeof (powerpc_opcodes) / sizeof (powerpc_opcodes[0]);
> +const int powerpc_num_opcodes = ARRAY_SIZE(powerpc_opcodes);
>  
>  /* The VLE opcode table.
>  
> @@ -7219,8 +7217,7 @@
>  {"se_bl",	BD8(58,0,1),	BD8_MASK,	PPCVLE,	0,		{B8}},
>  };
>  
> -const int vle_num_opcodes =
> -  sizeof (vle_opcodes) / sizeof (vle_opcodes[0]);
> +const int vle_num_opcodes = ARRAY_SIZE(vle_opcodes);
>  
>  /* The macro table.  This is only used by the assembler.  */
>  
> @@ -7288,5 +7285,4 @@
>  {"e_clrlslwi",4, PPCVLE, "e_rlwinm %0,%1,%3,(%2)-(%3),31-(%3)"},
>  };
>  
> -const int powerpc_num_macros =
> -  sizeof (powerpc_macros) / sizeof (powerpc_macros[0]);
> +const int powerpc_num_macros = ARRAY_SIZE(powerpc_macros);
