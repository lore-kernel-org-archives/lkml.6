Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F68CC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 08:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 299772086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 08:13:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="nWaXeQ1a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 299772086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbeIDMhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 08:37:21 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35633 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbeIDMhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 08:37:21 -0400
Received: by mail-pf1-f194.google.com with SMTP id p12-v6so1319735pfh.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 01:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jqgnbNXqUG887SXlUDeCp8uKIPwg9WkXkw+ZI+Q9gdQ=;
        b=nWaXeQ1aoZbZlsh801zbhxcdDdB+705Ol9GiKw1q53M7PQJPFVJN22Tl5lU1pM2cMr
         ZjkZZB/IPJoiorwLHDKnXYowBrp7wotiajY4f8ayDJ4/axE4yKDPUoP7rDRUTbiMvtyR
         1hJUz8cKZ2NUWIAmnVF0KTW9TaxQBA4gIuCF/XWKRX4u8sSOvD07E7aOfElyrNe0DrZG
         tZUigmJNZoQyRHXCjuKJt4DqQSnbpZnWrp1w4VhrgK0Q7mGANdjBy13cOTYosBN6k9nD
         39xlENYSgtZNfH8XeP2CxmfgjL3EDk6EF0wPZpzhrFA54sMr83FshlU9Ha1/UvknN9um
         B3XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jqgnbNXqUG887SXlUDeCp8uKIPwg9WkXkw+ZI+Q9gdQ=;
        b=Pu6RitIkmPKYPtGKFXWw8IBLw81n1XoiIG0X0Frr9iv3sjQbCC8y4UBnkfU4BZtzmJ
         xTD33wN5U/Yp/UlpIbPGlOM+rgfBXqumQF0gxKyUaAldwSMqyP2Sfx8jJ+Gqe80WA9Fg
         CUSixz3uksl6i4xlULLGSrzeng1TJaj45Jv9TNcc/xNA0lHjOveZapvkjSBPJXWROPc6
         rNoRg/z5aOSrQ2cktp0NoqhH5HaxSl55OjhPDmW1r79Mb+WZhDBCLoDnousYgiojyfzX
         i0W2tHXLEYH4Ye+/hJ4aO0QOleiG/Z/TjKXOguQKBY7wWoiuI9d2CKgZty1/Wd9vQsX8
         tlDA==
X-Gm-Message-State: APzg51D+kS80NJNif8lfd15nK/8XQJ3tME0+EThcq25DejPNz9mA7VQ9
        L7n+XTbJ15Jqh/V/4KxpjgpLqg==
X-Google-Smtp-Source: ANB0Vda7wfvv5BhLSf2EVV1YfsFtntnKmR50wai03AO1hkrgQJIRRbgm2UTbRs7lhbtys8Du/rKm4Q==
X-Received: by 2002:a63:88c8:: with SMTP id l191-v6mr30092430pgd.340.1536048800205;
        Tue, 04 Sep 2018 01:13:20 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([134.134.139.83])
        by smtp.gmail.com with ESMTPSA id x9-v6sm9599959pfd.31.2018.09.04.01.13.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 01:13:19 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 4152E300D89; Tue,  4 Sep 2018 11:13:14 +0300 (+03)
Date:   Tue, 4 Sep 2018 11:13:14 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Baoquan He <bhe@redhat.com>
Cc:     tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
        thgarnie@google.com, kirill.shutemov@linux.intel.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] x86/mm/KASLR: Adjust the vmemmap size according to
 paging mode
Message-ID: <20180904081314.gdhm55qchhl5irmv@kshutemo-mobl1>
References: <20180829021754.21850-1-bhe@redhat.com>
 <20180829021754.21850-2-bhe@redhat.com>
 <20180829120530.6dhgsautjjrj4ztt@kshutemo-mobl1>
 <20180830152512.GE14702@192.168.1.2>
 <20180902205242.kcpt6wsatacahswp@kshutemo-mobl1>
 <20180903074718.GD1740@192.168.1.3>
 <20180903102642.rmzawwqsqjvh2mkb@kshutemo-mobl1>
 <20180903145213.GG1740@192.168.1.3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180903145213.GG1740@192.168.1.3>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 03, 2018 at 10:52:13PM +0800, Baoquan He wrote:
> On 09/03/18 at 01:26pm, Kirill A. Shutemov wrote:
> > On Mon, Sep 03, 2018 at 03:47:18PM +0800, Baoquan He wrote:
> > > On 09/02/18 at 11:52pm, Kirill A. Shutemov wrote:
> > > > On Thu, Aug 30, 2018 at 11:25:12PM +0800, Baoquan He wrote:
> > > > > Hi Kirill,
> > > > > 
> > > > > I made a new version according to your suggestion, just a little
> > > > > different, I didn't make 1TB as default, just calculate with the actual
> > > > > size, then align up to 1TB boundary.  Just found kcore is printing more
> > > > > entries than before, I thought it's caused by my code, later got it was
> > > > > touchde by other people.
> > > > > 
> > > > > Any comment about this? I can change accordingly.
> > > > 
> > > > Looks good to me.
> > > > 
> > > > But there's corner case when struct page is unreasonably large and
> > > > vmemmap_size will be way to large. We probably have to report an error if
> > > > we cannot fit vmemmap properly into virtual memory layout.
> > > 
> > > Hmm, sizeof(struct page) can't exceed one whole page surely, otherwise
> > > system bootup can't go over vmemmap initlization. Except of this, we may
> > > need think about the virtual memory layout which vmemmap can be allowed
> > > to occupy.
> > > 
> > > If KASAN enabled, KASLR disabled,
> > > 4-level 1TB + 1TB hole (2TB)
> > > 5-level 512TB + 2034TB hole (2.5PB)
> > > 
> > > If KASAN disabled, KASLR enabled,
> > > 4-level 1TB + 1TB hole + 16TB  (18TB)
> > > 5-level 512TB + 2034TB hole + 8PB (10.5PB)
> > > 
> > > So, as you can see, if add check in memory KASLR code, we should only
> > > consider KASLR enabled case. We possibly don't need to worry about
> > > 5-level case since the size 10.5PB is even bigger than the maximum
> > > physical RAM mapping size. For 4-level, 18TB align to multiples of 2, it
> > > will be 32 times of the current 1TB, then we usually assume 64 as the
> > > default value of sizeof(struct page), then 64*32 == 1024. So we can add
> > > check like this, what do you think? Or any other idea?
> > 
> > Looks reasonable to me.
> > 
> > But I would have the BUILD_BUG_ON() in generic code. If you struct page is
> > more than 1/4 of PAGE_SIZE something is horribly broken.
> 
> Just the 1/4 of PAGE_SIZE is based on analysis of KASLR case. If
> non-KASLR case, it may not be that value.

Even if it technically possible to have struct page larger than
PAGE_SIZE/4, it's just insane.

> Not sure if it's OK to put it in generic code, and haven't thought of a
> good place, maybe in setup_arch(), just at the beginning?

I don't see an obvious place too. Maybe free_area_init_nodes()?

-- 
 Kirill A. Shutemov
