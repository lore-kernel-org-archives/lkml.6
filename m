Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE10AC004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 10:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F63C2075E
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 10:10:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F63C2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbeI3Qmg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 12:42:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50708 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727861AbeI3Qmg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 12:42:36 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 37E9581F0B;
        Sun, 30 Sep 2018 10:10:13 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-158.pek2.redhat.com [10.72.12.158])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8ECAF608E5;
        Sun, 30 Sep 2018 10:10:06 +0000 (UTC)
Date:   Sun, 30 Sep 2018 18:10:01 +0800
From:   Dave Young <dyoung@redhat.com>
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, bhe@redhat.com, arnd@arndb.de,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        ard.biesheuvel@linaro.org, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        prudo@linux.ibm.com, james.morse@arm.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v15 05/16] kexec_file: kexec_walk_memblock() only walks a
 dedicated region at kdump
Message-ID: <20180930101001.GE6950@dhcp-128-65.nay.redhat.com>
References: <20180928064841.14117-1-takahiro.akashi@linaro.org>
 <20180928064841.14117-6-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180928064841.14117-6-takahiro.akashi@linaro.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Sun, 30 Sep 2018 10:10:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/28/18 at 03:48pm, AKASHI Takahiro wrote:
> In kdump case, there exists only one dedicated memblock region as usable
> memory (crashk_res). With this patch, kexec_walk_memblock() runs a given
> callback function on this region.
> 
> Cosmetic change: 0 to MEMBLOCK_NONE at for_each_free_mem_range*()
> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: Baoquan He <bhe@redhat.com>

Acked-by: Dave Young <dyoung@redhat.com>

> ---
>  kernel/kexec_file.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 370d7eab49fe..2f615a7968dd 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -511,8 +511,11 @@ static int kexec_walk_memblock(struct kexec_buf *kbuf,
>  	phys_addr_t mstart, mend;
>  	struct resource res = { };
>  
> +	if (kbuf->image->type == KEXEC_TYPE_CRASH)
> +		return func(&crashk_res, kbuf);
> +
>  	if (kbuf->top_down) {
> -		for_each_free_mem_range_reverse(i, NUMA_NO_NODE, 0,
> +		for_each_free_mem_range_reverse(i, NUMA_NO_NODE, MEMBLOCK_NONE,
>  						&mstart, &mend, NULL) {
>  			/*
>  			 * In memblock, end points to the first byte after the
> @@ -526,8 +529,8 @@ static int kexec_walk_memblock(struct kexec_buf *kbuf,
>  				break;
>  		}
>  	} else {
> -		for_each_free_mem_range(i, NUMA_NO_NODE, 0, &mstart, &mend,
> -					NULL) {
> +		for_each_free_mem_range(i, NUMA_NO_NODE, MEMBLOCK_NONE,
> +					&mstart, &mend, NULL) {
>  			/*
>  			 * In memblock, end points to the first byte after the
>  			 * range while in kexec, end points to the last byte
> -- 
> 2.19.0
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

Thanks
Dave
