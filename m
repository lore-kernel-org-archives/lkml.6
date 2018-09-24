Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C2EC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 373A3214C1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ytgVanLZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 373A3214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729762AbeIXX4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 19:56:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:38066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727673AbeIXX4D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 19:56:03 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40EE92098A;
        Mon, 24 Sep 2018 17:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537811564;
        bh=GiM2Mr8stf/rR22ZuGnC/QSpASPg60xmysnCm6jmx0U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ytgVanLZ54X06JKp3WHPsTvfvtao5Ei0KyNjn2CZD2Cl0Qu47FZBXPgwieyvTeRM6
         uRk1A82K2wqEoBtDJk5mRK9mJDJbdoBDfWfSuM4tT6m5tNYS6N0yjuDOA5tF1Pbiax
         1yYQaVSeFxmYJtw3KFMU3jeL+bETnNHklu7TOApI=
Date:   Mon, 24 Sep 2018 12:52:42 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lianbo Jiang <lijiang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, akpm@linux-foundation.org,
        dan.j.williams@intel.com, thomas.lendacky@amd.com,
        bhelgaas@google.com, baiyaowei@cmss.chinamobile.com, tiwai@suse.de,
        bp@suse.de, brijesh.singh@amd.com, dyoung@redhat.com,
        bhe@redhat.com
Subject: Re: [PATCH 1/3 v3] resource: fix an error which walks through iomem
 resources
Message-ID: <20180924175241.GO224714@bhelgaas-glaptop.roam.corp.google.com>
References: <20180921073211.20097-1-lijiang@redhat.com>
 <20180921073211.20097-2-lijiang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180921073211.20097-2-lijiang@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 03:32:09PM +0800, Lianbo Jiang wrote:
> When we walk through iomem resources by calling walk_iomem_res_desc(),
> the values of the function parameter may be modified in the while loop
> of __walk_iomem_res_desc(), which will cause us to not get the desired
> result in some cases.

If I understand correctly, the issue is caused by the interaction
between __walk_iomem_res_desc() and find_next_iomem_res() in this
path:

  __walk_iomem_res_desc
    find_next_iomem_res
      res->flags = p->flags;            # <-- problem

This path is used by the following interfaces, and I think your patch
would fix the issue for them:

  walk_iomem_res_desc()
  walk_system_ram_res()
  walk_mem_res()

However, find_next_iomem_res() is also used directly by
walk_system_ram_range().  I think that path has the same problem, and
your patch does not fix that path.

I have a few more comments related to the existing code that I'll post
soon.

> At present, it only restores the original value of res->end, but it
> doesn't restore the original value of res->flags in the while loop of
> __walk_iomem _res_desc(). Whenever the find_next_iomem_res() finds a
> resource and returns the result, the original values of this resource
> will be modified, which might lead to an error in the next loop. For
> example:
> 
> The original value of resource flags is:
>  res->flags=0x80000200(initial value)
> 
> p->flags   _ 0x81000200 _                _ 0x80000200 _
>           /              \              /              \
> |________|_______A________|____|_....._|______B_________|..........___|
> 0                                                            0xffffffff
>                 (memory address ranges)
> 
> Note: if ((p->flags & res->flags) != res->flags) continue;
> 
> When the resource A is found, the original value of this resource flags
> will be changed to 0x81000200(res->flags=0x81000200), and continue to
> look for the next resource, when the loop reaches resource B, it can not
> get the resource B any more(you can refer to the for loop of find_next
> _iomem_res()), because the value of conditional expression will become
> true and will also jump the resource B.
> 
> In fact, we should get the resource A and B when we walk through the
> whole tree, but it only gets the resource A, the resource B is missed.
> 
> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
> ---
>  kernel/resource.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/resource.c b/kernel/resource.c
> index 30e1bc68503b..f5d9fc70a04c 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -375,6 +375,7 @@ static int __walk_iomem_res_desc(struct resource *res, unsigned long desc,
>  				 int (*func)(struct resource *, void *))
>  {
>  	u64 orig_end = res->end;
> +	u64 orig_flags = res->flags;
>  	int ret = -1;
>  
>  	while ((res->start < res->end) &&
> @@ -385,6 +386,7 @@ static int __walk_iomem_res_desc(struct resource *res, unsigned long desc,
>  
>  		res->start = res->end + 1;
>  		res->end = orig_end;
> +		res->flags = orig_flags;
>  	}
>  
>  	return ret;
