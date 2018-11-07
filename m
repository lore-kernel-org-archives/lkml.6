Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48208C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 12:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17AD2208E7
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 12:14:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17AD2208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730686AbeKGVod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 16:44:33 -0500
Received: from ozlabs.org ([203.11.71.1]:54865 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726392AbeKGVod (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 16:44:33 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42qlhc3dp4z9sCX;
        Wed,  7 Nov 2018 23:14:24 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     frowand.list@gmail.com, Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: Re: [PATCH v6 03/18] of: overlay: add missing of_node_get() in __of_attach_node_sysfs
In-Reply-To: <1541431515-25197-4-git-send-email-frowand.list@gmail.com>
References: <1541431515-25197-1-git-send-email-frowand.list@gmail.com> <1541431515-25197-4-git-send-email-frowand.list@gmail.com>
Date:   Wed, 07 Nov 2018 23:14:23 +1100
Message-ID: <87pnvhqe3k.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

frowand.list@gmail.com writes:

> From: Frank Rowand <frank.rowand@sony.com>
>
> There is a matching of_node_put() in __of_detach_node_sysfs()
>
> Remove misleading comment from function header comment for
> of_detach_node().
>
> This patch may result in memory leaks from code that directly calls
> the dynamic node add and delete functions directly instead of
> using changesets.
>
> Tested-by: Alan Tull <atull@kernel.org>
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>

This seems sensible to me. I guess we could argue about whether the
sysfs code needs its own reference, but it certainly doesn't hurt that
it does, as long as it's handled symmetrically - which it is now.

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

> ---
>
> This patch should result in powerpc systems that dynamically
> allocate a node, then later deallocate the node to have a
> memory leak when the node is deallocated.
>
> The next patch in the series will fix the leak.

I think this should go in the changelog, it's useful information that we
don't want to lose track of once this is applied.

Either that or we actually squash the two patches together when applying
to avoid the bisection break.

cheers

>  drivers/of/dynamic.c | 3 ---
>  drivers/of/kobj.c    | 4 +++-
>  2 files changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
> index 12c3f9a15e94..146681540487 100644
> --- a/drivers/of/dynamic.c
> +++ b/drivers/of/dynamic.c
> @@ -272,9 +272,6 @@ void __of_detach_node(struct device_node *np)
>  
>  /**
>   * of_detach_node() - "Unplug" a node from the device tree.
> - *
> - * The caller must hold a reference to the node.  The memory associated with
> - * the node is not freed until its refcount goes to zero.
>   */
>  int of_detach_node(struct device_node *np)
>  {
> diff --git a/drivers/of/kobj.c b/drivers/of/kobj.c
> index 7a0a18980b98..c72eef988041 100644
> --- a/drivers/of/kobj.c
> +++ b/drivers/of/kobj.c
> @@ -133,6 +133,9 @@ int __of_attach_node_sysfs(struct device_node *np)
>  	}
>  	if (!name)
>  		return -ENOMEM;
> +
> +	of_node_get(np);
> +
>  	rc = kobject_add(&np->kobj, parent, "%s", name);
>  	kfree(name);
>  	if (rc)
> @@ -159,6 +162,5 @@ void __of_detach_node_sysfs(struct device_node *np)
>  		kobject_del(&np->kobj);
>  	}
>  
> -	/* finally remove the kobj_init ref */
>  	of_node_put(np);
>  }
> -- 
> Frank Rowand <frank.rowand@sony.com>
