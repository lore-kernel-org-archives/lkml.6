Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A72C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 07:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 742342084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 07:08:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 742342084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbeJEOFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 10:05:22 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:43412 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727185AbeJEOFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 10:05:21 -0400
Received: by mail-wr1-f48.google.com with SMTP id n1-v6so12374350wrt.10;
        Fri, 05 Oct 2018 00:07:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oWo1xNzfo+k/gC3Zp/F75xR+3JKVfFbkGJq2SW9FQzo=;
        b=TMEXL9EFYLABFpLsOabNO9lAWHXFSB59c2hy9j0rjLwLfwDu4OdmRQKVtpFPDD7dSe
         gdPzAvTmnvCYUkbCvyrJtShmrUCGi3OdyHHLQnvZPFzzPJfj2sKaNfn1GOUi0B/0xJpA
         VLcb6Ee+/Ngm8CzKs32ANgbfwHFcwTAE4dy1p2zATwJlZK6YUdU7YaGkbWiEfIkERCL1
         qVUaFFfa0efd4Kuy+z6iuza4F2/efHsvCIofl2bHkJsvHxz7srHJWlOYTp5LWtge9+P0
         y4fHJbuHnI7vZ7PQppvn7MYlQ9j7qDT6/GttYgSh15aHCg697jyky6jyIySY+BOCOcCk
         vDfQ==
X-Gm-Message-State: ABuFfogDptB0JjKBbMJoaZJ86GkdIsw+195Oa1oxZqtW1XyhBstvn0f5
        nVcSC7fIRA3ExCuLw5SJifY=
X-Google-Smtp-Source: ACcGV60YB5PqaO8biF/WCLgxrXP1h5Gepxo+CeVyoVF3N/x1M2o3JuOPW7wOPYWHN6vxLsDVXN+r8A==
X-Received: by 2002:a5d:4101:: with SMTP id l1-v6mr7692851wrp.45.1538723278847;
        Fri, 05 Oct 2018 00:07:58 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id e64-v6sm850655wmg.0.2018.10.05.00.07.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 00:07:57 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id 6D6B1125822; Fri,  5 Oct 2018 09:07:56 +0200 (CEST)
Date:   Fri, 5 Oct 2018 09:07:56 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-acpi@vger.kernel.org, xen-devel@lists.xenproject.org,
        devel@linuxdriverproject.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Rashmica Gupta <rashmica.g@gmail.com>,
        Michael Neuling <mikey@neuling.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Oscar Salvador <osalvador@suse.de>,
        YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>,
        Mathieu Malaterre <malat@debian.org>
Subject: Re: [PATCH v3 3/6] mm/memory_hotplug: fix online/offline_pages
 called w.o. mem_hotplug_lock
Message-ID: <20181005070756.GA27754@techadventures.net>
References: <20180927092554.13567-1-david@redhat.com>
 <20180927092554.13567-4-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180927092554.13567-4-david@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 11:25:51AM +0200, David Hildenbrand wrote:
> Reviewed-by: Pavel Tatashin <pavel.tatashin@microsoft.com>
> Reviewed-by: Rashmica Gupta <rashmica.g@gmail.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>
-- 
Oscar Salvador
SUSE L3
