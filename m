Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF98C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 22:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 842362083A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 22:18:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 842362083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933670AbeFTWSV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 18:18:21 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36312 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933308AbeFTWSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 18:18:20 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1B06EC8A;
        Wed, 20 Jun 2018 22:18:20 +0000 (UTC)
Date:   Wed, 20 Jun 2018 15:18:19 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     osalvador@techadventures.net
Cc:     mhocko@suse.com, vbabka@suse.cz, pasha.tatashin@oracle.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH 1/4] mm/memory_hotplug: Make add_memory_resource use
 __try_online_node
Message-Id: <20180620151819.3f39226998bd80f7161fcea5@linux-foundation.org>
In-Reply-To: <20180601125321.30652-2-osalvador@techadventures.net>
References: <20180601125321.30652-1-osalvador@techadventures.net>
        <20180601125321.30652-2-osalvador@techadventures.net>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  1 Jun 2018 14:53:18 +0200 osalvador@techadventures.net wrote:

> From: Oscar Salvador <osalvador@suse.de>
> 
> add_memory_resource() contains code to allocate a new node in case
> it is necessary.
> Since try_online_node() also hast some code for this purpose,
> let us make use of that and remove duplicate code.
> 
> This introduces __try_online_node(), which is called by add_memory_resource()
> and try_online_node().
> __try_online_node() has two new parameters, start_addr of the node,
> and if the node should be onlined and registered right away.
> This is always wanted if we are calling from do_cpu_up(), but not
> when we are calling from memhotplug code.
> Nothing changes from the point of view of the users of try_online_node(),
> since try_online_node passes start_addr=0 and online_node=true to
> __try_online_node().
> 
> ...
>
> @@ -1126,17 +1136,14 @@ int __ref add_memory_resource(int nid, struct resource *res, bool online)
>  	 */
>  	memblock_add_node(start, size, nid);
>  
> -	new_node = !node_online(nid);
> -	if (new_node) {
> -		pgdat = hotadd_new_pgdat(nid, start);
> -		ret = -ENOMEM;
> -		if (!pgdat)
> -			goto error;
> -	}
> +	ret = __try_online_node (nid, start, false);
> +	new_node = !!(ret > 0);

I don't think __try_online_node() will ever return a value greater than
zero.  I assume what was meant was

	new_node = !!(ret >= 0);

which may as well be

	new_node = (ret >= 0);

since both sides have bool type.

The fact that testing didn't detect this is worrisome....

> +	if (ret < 0)
> +		goto error;
> +
>  
>  	/* call arch's memory hotadd */
>  	ret = arch_add_memory(nid, start, size, NULL, true);
> -
>  	if (ret < 0)
>  		goto error;
>  
> 
> ...
>
