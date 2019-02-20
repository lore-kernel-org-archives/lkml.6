Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BEB2C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 17:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02FB02146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 17:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kq/KL3cB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfBTRJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 12:09:09 -0500
Received: from merlin.infradead.org ([205.233.59.134]:46562 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbfBTRJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 12:09:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=b/xQ0De9DqRGz7Fcps93XhuWO/x59JQPfs3kHnkPpwM=; b=kq/KL3cB13GF+XOFS0BtCsw0F
        d3bzd9FWWSCXZVy6/DkADUujFszbWW/3IhfO0YP77BQz6qoEYqyX58EhDMp+7EgZLTgUOrkm65MKz
        bVs2kZoXBlp2MXc6o0o2ApKjrvNac1Q61yb4vWgQtuTxwl9IO2WMxv8ewTUcyt7zMn7C9GII09YoH
        ym8hBP65Ogo5uji54f9QXUlCz8Dm2Nxfl7fXkQrLaEgLf7ThRlWDUi4rPZq0yrJejadECNv4t7if1
        l9xBHwcqo+zfOfoyW9bcHGn5ovEN1JXTNioPLKwF41qAdxFTG6UxxN94XWPc4OYZo9vHGhyYHINvm
        wmjW4Jq9Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gwVMQ-0001zB-MZ; Wed, 20 Feb 2019 17:08:42 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2E6032139CDE4; Wed, 20 Feb 2019 18:08:41 +0100 (CET)
Date:   Wed, 20 Feb 2019 18:08:41 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Laurent Vivier <lvivier@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Borislav Petkov <bp@suse.de>,
        David Gibson <david@gibson.dropbear.id.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nathan Fontenot <nfont@linux.vnet.ibm.com>,
        Michael Bringmann <mwb@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v2] sched/topology: fix kernel crash when a CPU is
 hotplugged in a memoryless node
Message-ID: <20190220170841.GM32494@hirez.programming.kicks-ass.net>
References: <20190220165520.5241-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220165520.5241-1-lvivier@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 05:55:20PM +0100, Laurent Vivier wrote:
> index 3f35ba1d8fde..372278605f0d 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1651,6 +1651,7 @@ void sched_init_numa(void)
>  	 */
>  	tl[i++] = (struct sched_domain_topology_level){
>  		.mask = sd_numa_mask,
> +		.flags = SDTL_OVERLAP,

This makes no sense what so ever. The numa identify node should not have
overlap with other domains.

Are you sure this is not because of the utterly broken powerpc nonsense
where they move CPUs between nodes?

>  		.numa_level = 0,
>  		SD_INIT_NAME(NODE)
>  	};
> -- 
> 2.20.1
> 
