Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE1DC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 896B120841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:51:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 896B120841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732674AbeGaQcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 12:32:09 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39129 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732443AbeGaQcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 12:32:08 -0400
Received: by mail-wr1-f65.google.com with SMTP id h10-v6so16970928wre.6
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 07:51:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=URY4aDeqZ9DYmgCaZcwjpXNvvzO191bhEH5WjdHBK1Q=;
        b=Jf5vrqogVkUdDwPUjzfStZBvecnwpucb5qnx9EJIXrQgzE7lsFRF7ooulojTyoN3Zd
         8/Tz7YWLRLI2jQ7t3NNK6ho9hbtalLcwvFzvkLNPN/CeUFDLSec+jXhT/y95JEKd8IeY
         hUACO4cTqFqmIGcTEI+C3ZT9M/ziJM1Xw1wWPmuiv4gqZNyki9zVI/Wafo9p1G/ZdUoA
         u/V90BiWG/30ozusZfg7TY6BPdvGNF1RS1SPWgR2ijYc4V717uC3YzcExmaqPX/GipWa
         aQBXvQTzprMFh9n8RCZ2fWvkdlItqjRZ0BRm5rMF/cYnk9UqLv0sLaPrnglN4jbnyIeS
         TiUw==
X-Gm-Message-State: AOUpUlHHigDwTFDNMVndOVkmslAzKgOcTB6B4xw3YNO7WecXFVzg4yDh
        RLu16F9O+G3b3P2wj6RNZec=
X-Google-Smtp-Source: AAOMgpdm4G/1PJpw7n5MMAmMMZ3b3WL9RZkQT5ONEN2CCPqUfu0Zoi+S2f+Ik6T3hmbqG+luXWZbRg==
X-Received: by 2002:adf:e24d:: with SMTP id n13-v6mr21386789wri.205.1533048686551;
        Tue, 31 Jul 2018 07:51:26 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id m68-v6sm4151065wmb.10.2018.07.31.07.51.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 07:51:25 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id 56B8C1244F2; Tue, 31 Jul 2018 16:51:25 +0200 (CEST)
Date:   Tue, 31 Jul 2018 16:51:25 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     Pavel Tatashin <pasha.tatashin@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        kirill.shutemov@linux.intel.com, iamjoonsoo.kim@lge.com,
        Mel Gorman <mgorman@suse.de>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, osalvador@suse.de
Subject: Re: [PATCH] mm: make __paginginit based on CONFIG_MEMORY_HOTPLUG
Message-ID: <20180731145125.GB1499@techadventures.net>
References: <20180731124504.27582-1-osalvador@techadventures.net>
 <CAGM2rebds=A5m1ZB1LtD7oxMzM9gjVQvm-QibHjEENmXViw5eA@mail.gmail.com>
 <20180731144157.GA1499@techadventures.net>
 <20180731144545.fh5syvwcecgvqul6@xakep.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180731144545.fh5syvwcecgvqul6@xakep.localdomain>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 10:45:45AM -0400, Pavel Tatashin wrote:
> Here the patch would look like this:
> 
> From e640b32dbd329bba5a785cc60050d5d7e1ca18ce Mon Sep 17 00:00:00 2001
> From: Pavel Tatashin <pasha.tatashin@oracle.com>
> Date: Tue, 31 Jul 2018 10:37:44 -0400
> Subject: [PATCH] mm: remove __paginginit
> 
> __paginginit is the same thing as __meminit except for platforms without
> sparsemem, there it is defined as __init.
> 
> Remove __paginginit and use __meminit. Use __ref in one single function
> that merges __meminit and __init sections: setup_usemap().
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>

Uhm, I am probably missing something, but with this change, the functions will not be freed up
while freeing init memory, right?

Thanks
-- 
Oscar Salvador
SUSE L3
