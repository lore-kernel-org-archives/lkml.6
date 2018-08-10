Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88897C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 19:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 424CD2242A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 19:32:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 424CD2242A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbeHJWDy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 18:03:54 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51871 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbeHJWDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 18:03:53 -0400
Received: by mail-wm0-f68.google.com with SMTP id y2-v6so2998803wma.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 12:32:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KdLHacgPWjfwI9r1yzRJG8hl5iQJgAW/2OAq4y8iy2Q=;
        b=GfRpqr6ZlutKNOPsYZd68TqHYBGW4bWr36xo0oA4MbL6Rzz7dPNquZXXP8dz5UIM2I
         9elPsDVq0Tw8j86bTMdWQrSJv1YShNHwR+GcKywatTMjvLkQrB/35ZZmFi8lHmsk9Otw
         IRcJ9xmsx3EZVsTPgnOS8wlnVOLm255J2O6uUtYLm0qLYUcifSrXhXhJ/6AOVpqg2A56
         637y9Y8GMA2xSi7zMSJ4MuDRf8whwm3RxmY7ELfDxqtWy7OYM+ryBHxBmsv94QR971qr
         clFfvZ+S1ttHglo4mKJ9CWdmsWg1MzFCgJFl9e4Gy3Hh2lH3sllhSTRRRTYqQwocxjqS
         /nnw==
X-Gm-Message-State: AOUpUlG2H7wb0EigmqfpPMatNz0VXRGpT9qtx3KOE5LIgXusbI/eJm9v
        K1P3aeiKhB9x5IOn6WdGeRM=
X-Google-Smtp-Source: AA+uWPx8tV2tcY31XyOz/OIovwZgrk7OwrliciQ3C34zGg8zLJ9s0nFH5u0KuyOYunvkiFvwbpeRuw==
X-Received: by 2002:a1c:63d4:: with SMTP id x203-v6mr2283395wmb.9.1533929559222;
        Fri, 10 Aug 2018 12:32:39 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id j133-v6sm4453400wmd.12.2018.08.10.12.32.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 12:32:38 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id D3B7D12482B; Fri, 10 Aug 2018 21:32:37 +0200 (CEST)
Date:   Fri, 10 Aug 2018 21:32:37 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     Rashmica Gupta <rashmica.g@gmail.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, toshi.kani@hpe.com,
        tglx@linutronix.de, bp@suse.de, brijesh.singh@amd.com,
        thomas.lendacky@amd.com, jglisse@redhat.com,
        gregkh@linuxfoundation.org, baiyaowei@cmss.chinamobile.com,
        dan.j.williams@intel.com, iamjoonsoo.kim@lge.com,
        Vlastimil Babka <vbabka@suse.cz>, malat@debian.org,
        Bjorn Helgaas <bhelgaas@google.com>, yasu.isimatu@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [PATCH v3] resource: Merge resources on a node when hot-adding
 memory
Message-ID: <20180810193237.GA22441@techadventures.net>
References: <20180809025409.31552-1-rashmica.g@gmail.com>
 <20180809181224.0b7417e51215565dbda9f665@linux-foundation.org>
 <CAC6rBs=yYYZw-c02yp6rx-+TN2oUGgrp=uuLhZ=Kc_nnjmTRqA@mail.gmail.com>
 <20180810130052.GC1644@dhcp22.suse.cz>
 <CAC6rBsmkTSSg1RhWkpU-t+tQdyz7NKbfu96tX9BG1=LOGVg-Bw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC6rBsmkTSSg1RhWkpU-t+tQdyz7NKbfu96tX9BG1=LOGVg-Bw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 11, 2018 at 12:25:39AM +1000, Rashmica Gupta wrote:
> On Fri, Aug 10, 2018 at 11:00 PM, Michal Hocko <mhocko@kernel.org> wrote:
> > On Fri 10-08-18 16:55:40, Rashmica Gupta wrote:
> > [...]
> >> Most memory hotplug/hotremove seems to be block or section based, and
> >> always adds and removes memory at the same place.
> >
> > Yes and that is hard wired to the memory hotplug code. It is not easy to
> > make it work outside of section units restriction. So whatever your
> > memtrace is doing and if it relies on subsection hotplug it cannot
> > possibly work with the current code.
> >
> > I didn't get to review your patch but if it is only needed for an
> > unmerged code I would rather incline to not merge it unless it is a
> > clear win to the resource subsystem. A report from Oscar shows that this
> > is not the case though.
> >
> 
> Yup, makes sense. I'll work on it and see if I can not break things.

In __case__ we really need this patch, I think that one way to fix this is
to only call merge_node_resources() in case the node is already online.
Something like this (completely untested):

+struct resource *request_resource_and_merge(struct resource *parent,
+                                           struct resource *new, int nid)
+{
+       struct resource *conflict;
+
+       conflict = request_resource_conflict(parent, new);
+
+       if (conflict)
+               return conflict;
+
+#ifdef CONFIG_MEMORY_HOTREMOVE
+       /* We do not need to merge any resources on a node that is being
+        * hot-added together with its memory.
+	 * The node will be allocated later.
+	 */
+       if (node_online(nid))
+       	merge_node_resources(nid, parent);
+#endif /* CONFIG_MEMORY_HOTREMOVE */

Although as Michal said, all memory-hotplug code is section-oriented, so
whatever it is that interacts with it should expect that.
Otherwise it can fail soon or later.

-- 
Oscar Salvador
SUSE L3
