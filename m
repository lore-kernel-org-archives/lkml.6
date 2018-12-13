Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE31C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 03:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43B5020811
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 03:20:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="hfIMKNgu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43B5020811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbeLMDUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 22:20:47 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46537 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbeLMDUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 22:20:46 -0500
Received: by mail-ot1-f65.google.com with SMTP id w25so548872otm.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 19:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UoH1a8XE7GS07dgmUMEOE/zqJwmpFakBEUmXWTCjrpM=;
        b=hfIMKNgu/V86zIrvtd9VDfKKBPHl26/En0VmCR5fKgs3KAw11Whj1pN47wHNXDzOPN
         n0glBCoyLYdsc1Z6erpgEb+3JyrshBRhG2HNg3IDGrnV73a8rgIOXkUKAtVlF5ixwRND
         YkCpxifMOSSq1DkKf0L5ICOTGSim5I+qbl5WmwHfEaV9lnmuNQdRdSK6/cHjGTxt/URK
         zE3fI4hv+/ck/J+BWf5ryS3jHi+Vt6FKdAwB0vWTJk/2NIvAA8DlX/YGi0E5Mxo2hxPY
         8cT8FU5SkYwXCsVTmiTplA7KNpaLcvxM7ofdFEFsv4td6+2xXUSjVRFasINW14Enf4ml
         44xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UoH1a8XE7GS07dgmUMEOE/zqJwmpFakBEUmXWTCjrpM=;
        b=RkURMVwXuKkcCa/EUeRdC1URUVI6uA1BNBy0i0t9b6jF0zoIPVyaJMyxY7WkzLihV2
         CD1YOeMHs5WR4P+F8OgXGZuJ44ZWzd/lXVk/Jqlj+jVnCSWSghq5nq+EVt9bonBXRDEm
         /MGCtfaPjrwBFURAQZp0Mm/vkI6KR3DgiwTjQ/3lvaRO4mjk70d6/b+g5yPCSav/VOfu
         Q865l/RhgeHkV16HXeShWSG9S8JYBvtwB4Po0jMjicg5OM1+m6U2qeKsRzcyOF+GJ/Nv
         0xGiFbD481EL/h3gjjeqShNJ/el1umaya10xhU12mb7r9Sqg2JNpWWpY2B0duWz21hrC
         UHIQ==
X-Gm-Message-State: AA+aEWbOkk+1X18iM7X/VahcCBrUygH+RtizvSaD8UOVbJ9K51XMJZE7
        a+XlWsqCabuHX8kp36S9kVOoSWp6wi4=
X-Google-Smtp-Source: AFSGD/Wz/uQ34ArQHTnwlB9y8GZ7Y9oJvKLw1asynv44yrYhT7SQ5raIQ+qn2ngAZasdawAsrY+uuA==
X-Received: by 2002:a9d:4201:: with SMTP id q1mr14695076ote.126.1544671245454;
        Wed, 12 Dec 2018 19:20:45 -0800 (PST)
Received: from ziepe.ca (rrcs-24-227-213-164.sw.biz.rr.com. [24.227.213.164])
        by smtp.gmail.com with ESMTPSA id z7sm322942otm.63.2018.12.12.19.20.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 19:20:44 -0800 (PST)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gXHYJ-0000rM-OZ; Wed, 12 Dec 2018 20:20:43 -0700
Date:   Wed, 12 Dec 2018 20:20:43 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, Jan Kara <jack@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <john.hubbard@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, tom@talpey.com,
        Al Viro <viro@zeniv.linux.org.uk>, benve@cisco.com,
        Christoph Hellwig <hch@infradead.org>,
        Christopher Lameter <cl@linux.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        rcampbell@nvidia.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Weiny, Ira" <ira.weiny@intel.com>
Subject: Re: [PATCH 1/2] mm: introduce put_user_page*(), placeholder versions
Message-ID: <20181213032043.GA3204@ziepe.ca>
References: <3c4d46c0-aced-f96f-1bf3-725d02f11b60@nvidia.com>
 <20181208022445.GA7024@redhat.com>
 <20181210102846.GC29289@quack2.suse.cz>
 <20181212150319.GA3432@redhat.com>
 <CAPcyv4go0Xzhz8rXdfscWuXDu83BO9v8WD4upDUJWb7gKzX5OQ@mail.gmail.com>
 <20181212213005.GE5037@redhat.com>
 <CAPcyv4gJHeFjEgna1S-2uE4KxkSUgkc=e=2E5oqfoirec84C-w@mail.gmail.com>
 <20181212215348.GF5037@redhat.com>
 <20181212233703.GB2947@ziepe.ca>
 <20181213000109.GK5037@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213000109.GK5037@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 07:01:09PM -0500, Jerome Glisse wrote:
> On Wed, Dec 12, 2018 at 04:37:03PM -0700, Jason Gunthorpe wrote:
> > On Wed, Dec 12, 2018 at 04:53:49PM -0500, Jerome Glisse wrote:
> > > > Almost, we need some safety around assuming that DMA is complete the
> > > > page, so the notification would need to go all to way to userspace
> > > > with something like a file lease notification. It would also need to
> > > > be backstopped by an IOMMU in the case where the hardware does not /
> > > > can not stop in-flight DMA.
> > > 
> > > You can always reprogram the hardware right away it will redirect
> > > any dma to the crappy page.
> > 
> > That causes silent data corruption for RDMA users - we can't do that.
> > 
> > The only way out for current hardware is to forcibly terminate the
> > RDMA activity somehow (and I'm not even sure this is possible, at
> > least it would be driver specific)
> > 
> > Even the IOMMU idea probably doesn't work, I doubt all current
> > hardware can handle a PCI-E error TLP properly. 
> 
> What i saying is reprogram hardware to crappy page ie valid page
> dma map but that just has random content as a last resort to allow
> filesystem to reuse block. So their should be no PCIE error unless
> hardware freak out to see its page table reprogram randomly.

No, that isn't an option. You can't silently provide corrupted data
for RDMA to transfer out onto the network, or silently discard data
coming in!! 

Think of the consequences of that - I have a fileserver process and
someone does ftruncate and now my clients receive corrupted data??

The only option is to prevent the RDMA transfer from ever happening,
and we just don't have hardware support (beyond destroy everything) to
do that.

> The question is who do you want to punish ? RDMA user that pin stuff
> and expect thing to work forever without worrying for other fs
> activities ? Or filesystem to pin block forever :) 

I don't want to punish everyone, I want both sides to have complete
data integrity as the USER has deliberately decided to combine DAX and
RDMA. So either stop it at the front end (ie get_user_pages_longterm)
or make it work in a way that guarantees integrity for both.

>     S2: notify userspace program through device/sub-system
>         specific API and delay ftruncate. After a while if there
>         is no answer just be mean and force hardware to use
>         crappy page as anyway this is what happens today

I don't think this happens today (outside of DAX).. Does it?

.. and the remedy here is to kill the process, not provide corrupt
data. Kill the process is likely to not go over well with any real
users that want this combination.

Think Samba serving files over RDMA - you can't have random unpriv
users calling ftruncate and causing smbd to be killed or serve corrupt
data.

Jason
