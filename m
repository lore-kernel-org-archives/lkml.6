Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A45C004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 10:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 966012075E
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 10:08:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 966012075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbeI3QlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 12:41:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50594 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727861AbeI3QlL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 12:41:11 -0400
Received: from smtp.corp.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F134881F0E;
        Sun, 30 Sep 2018 10:08:48 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-158.pek2.redhat.com [10.72.12.158])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CF7633091326;
        Sun, 30 Sep 2018 10:08:38 +0000 (UTC)
Date:   Sun, 30 Sep 2018 18:08:34 +0800
From:   Dave Young <dyoung@redhat.com>
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, bhe@redhat.com, arnd@arndb.de,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        ard.biesheuvel@linaro.org, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        prudo@linux.ibm.com, james.morse@arm.com,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v15 04/16] powerpc, kexec_file: factor out memblock-based
 arch_kexec_walk_mem()
Message-ID: <20180930100834.GD6950@dhcp-128-65.nay.redhat.com>
References: <20180928064841.14117-1-takahiro.akashi@linaro.org>
 <20180928064841.14117-5-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180928064841.14117-5-takahiro.akashi@linaro.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.26
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Sun, 30 Sep 2018 10:08:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi AKASHI,

On 09/28/18 at 03:48pm, AKASHI Takahiro wrote:
> Memblock list is another source for usable system memory layout.
> So move powerpc's arch_kexec_walk_mem() to common code so that other
> memblock-based architectures, particularly arm64, can also utilise it.
> A moved function is now renamed to kexec_walk_memblock() and integrated
> into kexec_locate_mem_hole(), which will now be usable for all
> architectures with no need for overriding arch_kexec_walk_mem().
> 
> With this change, arch_kexec_walk_mem() need no longer be a weak function,
> and was now renamed to kexec_walk_resources().
> 
> Since powerpc doesn't support kdump in its kexec_file_load(), the current
> kexec_walk_memblock() won't work for kdump either in this form, this will
> be fixed in the next patch.
> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Cc: "Eric W. Biederman" <ebiederm@xmission.com>
> Acked-by: Dave Young <dyoung@redhat.com>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: Baoquan He <bhe@redhat.com>
> Acked-by: James Morse <james.morse@arm.com>

[snip]

> +
>  /**
>   * arch_kexec_walk_mem - call func(data) on free memory regions

The function name should be updated as well.

>   * @kbuf:	Context info for the search. Also passed to @func.
> @@ -510,8 +560,8 @@ static int locate_mem_hole_callback(struct resource *res, void *arg)
>   * and that value will be returned. If all free regions are visited without
>   * func returning non-zero, then zero will be returned.
>   */
> -int __weak arch_kexec_walk_mem(struct kexec_buf *kbuf,
> -			       int (*func)(struct resource *, void *))
> +static int kexec_walk_resources(struct kexec_buf *kbuf,
> +				int (*func)(struct resource *, void *))
>  {
>  	if (kbuf->image->type == KEXEC_TYPE_CRASH)
>  		return walk_iomem_res_desc(crashk_res.desc,
> @@ -538,7 +588,11 @@ int kexec_locate_mem_hole(struct kexec_buf *kbuf)
>  	if (kbuf->mem != KEXEC_BUF_MEM_UNKNOWN)
>  		return 0;
>  
> -	ret = arch_kexec_walk_mem(kbuf, locate_mem_hole_callback);
> +	if (IS_ENABLED(CONFIG_HAVE_MEMBLOCK) &&
> +			!IS_ENABLED(CONFIG_ARCH_DISCARD_MEMBLOCK))
> +		ret = kexec_walk_memblock(kbuf, locate_mem_hole_callback);
> +	else
> +		ret = kexec_walk_resources(kbuf, locate_mem_hole_callback);
>  
>  	return ret == 1 ? 0 : -EADDRNOTAVAIL;
>  }
> -- 
> 2.19.0
> 

Thanks
Dave
