Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6769CC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 08:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 203B321868
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 08:41:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 203B321868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbeHQLoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 07:44:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59276 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbeHQLoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 07:44:22 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 714C7C03;
        Fri, 17 Aug 2018 08:41:49 +0000 (UTC)
Date:   Fri, 17 Aug 2018 10:41:46 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        devel@linuxdriverproject.org, linux-s390@vger.kernel.org,
        xen-devel@lists.xenproject.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        David Rientjes <rientjes@google.com>
Subject: Re: [PATCH RFC 1/2] drivers/base: export
 lock_device_hotplug/unlock_device_hotplug
Message-ID: <20180817084146.GB14725@kroah.com>
References: <20180817075901.4608-1-david@redhat.com>
 <20180817075901.4608-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180817075901.4608-2-david@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2018 at 09:59:00AM +0200, David Hildenbrand wrote:
> From: Vitaly Kuznetsov <vkuznets@redhat.com>
> 
> Well require to call add_memory()/add_memory_resource() with
> device_hotplug_lock held, to avoid a lock inversion. Allow external modules
> (e.g. hv_balloon) that make use of add_memory()/add_memory_resource() to
> lock device hotplug.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> [modify patch description]
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  drivers/base/core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 04bbcd779e11..9010b9e942b5 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -700,11 +700,13 @@ void lock_device_hotplug(void)
>  {
>  	mutex_lock(&device_hotplug_lock);
>  }
> +EXPORT_SYMBOL_GPL(lock_device_hotplug);
>  
>  void unlock_device_hotplug(void)
>  {
>  	mutex_unlock(&device_hotplug_lock);
>  }
> +EXPORT_SYMBOL_GPL(unlock_device_hotplug);

If these are going to be "global" symbols, let's properly name them.
device_hotplug_lock/unlock would be better.  But I am _really_ nervous
about letting stuff outside of the driver core mess with this, as people
better know what they are doing.

Can't we just "lock" the memory stuff instead?  Why does the entirety of
the driver core need to be messed with here?

thanks,

greg k-h
