Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D291C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 13:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C47D327400
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 13:12:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C47D327400
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966161AbeF1NM5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 09:12:57 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:44518 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965423AbeF1NMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 09:12:54 -0400
Received: by mail-wr0-f194.google.com with SMTP id p12-v6so5468542wrn.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 06:12:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Nh1TkwtXyKtA2dv/BEM/kQ0MyrT0/WL4TDQjriYtqZw=;
        b=cWMKIzyVA9BvfWcBP98crJWzN3kSu2BhV3fReswBisWkDzLJB70UPj4hv0p0x0hTGl
         0/gRyHfRNjQsLy0Lvcqf9jGzAXyPmf3k4SrQu4Gw5L3VWjnOSbrpILoOhGto9112Uac0
         Ud5sVtOeLlzUP9WkO5CqMbO+3KRoo9Qd/3Dk8K8MW+FIzT33kh3BjVb5Rei9Z51NyPU8
         KSyn03ceY5diXfQLs+u+xCbiJf1oN9FCoVXi1RDs/jx/j8TzZ6CoYNrAW5DDyqmdA2ho
         nVmvGbpfSceN7PquxIQNB2vNn26dPowiJnxqHu3epKIlNBw2W/3pn4Cgc0JNZAcw1fO5
         I6ew==
X-Gm-Message-State: APt69E0kAQNaXep+ZseYTarb2hzAzPVqMxJYwBNdfCt0+Gc8jimByZvy
        MlIeIqFaKLptkKWNctmnGOo=
X-Google-Smtp-Source: AAOMgpdQ7FTqQcyfd8bqYhfNMXCsbGmuA5A88ZDoBnjAmFgHJr2nhMuCGJOEE5bVW7g0iXq5CcoDRw==
X-Received: by 2002:adf:984e:: with SMTP id v72-v6mr8668090wrb.180.1530191573857;
        Thu, 28 Jun 2018 06:12:53 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id r7-v6sm24002wrn.83.2018.06.28.06.12.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 06:12:53 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id A9A7A12391A; Thu, 28 Jun 2018 15:12:52 +0200 (CEST)
Date:   Thu, 28 Jun 2018 15:12:52 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     Pavel Tatashin <pasha.tatashin@oracle.com>
Cc:     bhe@redhat.com, LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        dave.hansen@intel.com, pagupta@redhat.com,
        Linux Memory Management List <linux-mm@kvack.org>,
        kirill.shutemov@linux.intel.com
Subject: Re: [PATCH v6 4/5] mm/sparse: Optimize memmap allocation during
 sparse_init()
Message-ID: <20180628131252.GB13985@techadventures.net>
References: <20180628062857.29658-1-bhe@redhat.com>
 <20180628062857.29658-5-bhe@redhat.com>
 <20180628120937.GC12956@techadventures.net>
 <CAGM2reZsZVhhg2=dQZf6D-NmPTFRN-_95+s61pC7Axz5G5mkMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGM2reZsZVhhg2=dQZf6D-NmPTFRN-_95+s61pC7Axz5G5mkMQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 08:12:04AM -0400, Pavel Tatashin wrote:
> > > +             if (nr_consumed_maps >= nr_present_sections) {
> > > +                     pr_err("nr_consumed_maps goes beyond nr_present_sections\n");
> > > +                     break;
> > > +             }
> >
> > Hi Baoquan,
> >
> > I am sure I am missing something here, but is this check really needed?
> >
> > I mean, for_each_present_section_nr() only returns the section nr if the section
> > has been marked as SECTION_MARKED_PRESENT.
> > That happens in memory_present(), where now we also increment nr_present_sections whenever
> > we find a present section.
> >
> > So, for_each_present_section_nr() should return the same nr of section as nr_present_sections.
> > Since we only increment nr_consumed_maps once in the loop, I am not so sure we can
> > go beyond nr_present_sections.
> >
> > Did I overlook something?
> 
> You did not, this is basically a safety check. A BUG_ON() would be
> better here. As, this something that should really not happening, and
> would mean a bug in the current project.

I think we would be better off having a BUG_ON() there.
Otherwise the system can go sideways later on. 

-- 
Oscar Salvador
SUSE L3
