Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7648ECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 09:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE51B2082D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 09:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JBVbhtkX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE51B2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbeJZSIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 14:08:20 -0400
Received: from merlin.infradead.org ([205.233.59.134]:60898 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbeJZSIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 14:08:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Flwloc/RXwyekTLnRQWtL8hKTHk4sO/+tf4eemj4N/8=; b=JBVbhtkXD4liY1/FC72eP/K8Y
        qdxheF3aUiRM/BaZiS+pD2ZCLuoxiAPhUjDBK7qBE/JgnmBwt/pQqctpanIF7qVcarV9AMmCoGpHt
        0zGcsg/o6Lwf8SwQTfyphP6dkSTgdXEO/+GAZigeCB1VLK91Lb8XglxkA8RrmNTraU9scmO6rUSuM
        0YXHimbrxH+OGxkUWVo933P4Ph+FAxk6uCmI0cK9mKeoolEkWYidrvEJiD3Up0GFFWyVxrtL0/UYG
        cuiLMCAfVEQ5DyXZ5m9wRmpC5TpEUTxuwBsesjJzj9wYaaft4itIvI/zM6jixa25fuK49XnEyLphW
        OJxb6+UYw==;
Received: from [167.98.65.38] (helo=worktop)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gFySm-00017Q-IQ; Fri, 26 Oct 2018 09:31:28 +0000
Received: by worktop (Postfix, from userid 1000)
        id A334F6E07BE; Fri, 26 Oct 2018 11:31:26 +0200 (CEST)
Date:   Fri, 26 Oct 2018 11:31:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Igor Stoppa <igor.stoppa@gmail.com>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        James Morris <jmorris@namei.org>,
        Michal Hocko <mhocko@kernel.org>,
        kernel-hardening@lists.openwall.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, igor.stoppa@huawei.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laura Abbott <labbott@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Pekka Enberg <penberg@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Lihao Liang <lianglihao@huawei.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/17] prmem: linked list: set alignment
Message-ID: <20181026093126.GC3159@worktop.c.hoisthospitality.com>
References: <20181023213504.28905-1-igor.stoppa@huawei.com>
 <20181023213504.28905-13-igor.stoppa@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181023213504.28905-13-igor.stoppa@huawei.com>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 12:34:59AM +0300, Igor Stoppa wrote:
> As preparation to using write rare on the nodes of various types of
> lists, specify that the fields in the basic data structures must be
> aligned to sizeof(void *)
> 
> It is meant to ensure that any static allocation will not cross a page
> boundary, to allow pointers to be updated in one step.
> 
> Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> CC: Andrew Morton <akpm@linux-foundation.org>
> CC: Masahiro Yamada <yamada.masahiro@socionext.com>
> CC: Alexey Dobriyan <adobriyan@gmail.com>
> CC: Pekka Enberg <penberg@kernel.org>
> CC: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> CC: Lihao Liang <lianglihao@huawei.com>
> CC: linux-kernel@vger.kernel.org
> ---
>  include/linux/types.h | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/types.h b/include/linux/types.h
> index 9834e90aa010..53609bbdcf0f 100644
> --- a/include/linux/types.h
> +++ b/include/linux/types.h
> @@ -183,17 +183,29 @@ typedef struct {
>  } atomic64_t;
>  #endif
>  
> +#ifdef CONFIG_PRMEM
>  struct list_head {
> -	struct list_head *next, *prev;
> -};
> +	struct list_head *next __aligned(sizeof(void *));
> +	struct list_head *prev __aligned(sizeof(void *));
> +} __aligned(sizeof(void *));
>  
> -struct hlist_head {
> -	struct hlist_node *first;
> +struct hlist_node {
> +	struct hlist_node *next __aligned(sizeof(void *));
> +	struct hlist_node **pprev __aligned(sizeof(void *));
> +} __aligned(sizeof(void *));

Argh.. are we really supporting platforms that do not naturally align
this? If so, which and can't we fix those?

Also, if you force alignment on a member, the structure as a whole
inherits the largest member alignment.

Also, you made something that was simple an unreadable mess without
proper justification (ie. you fail to show need).
