Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8180C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 10:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91F7F20863
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 10:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551265197;
	bh=acm04amO7TUS9ylWPUE5jtMaWDRvwKIsr8GKiyqYjvA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VL62RMet/K8JS+PHNOmh4NtGa5lWQYWf5K+IzBe/KfvREopy4yAOQ7IrIfxVp/uL+
	 KcjKABobyJj+Txixa3s0RbTgRniN5hnBOjQVRYRBtHEQoZbAp5kstXHmYLNfQLCukI
	 9VJeMCtZKBrT8pS3MUx7A4PDrg0P2N6bxddnKeec=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbfB0K7z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 05:59:55 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33582 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfB0K7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 05:59:55 -0500
Received: by mail-lf1-f68.google.com with SMTP id z23so118380lfe.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 02:59:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yNq5Uleu2cn8YQnQ110fLs6Wj1liIPW08FHGZs7Oo9A=;
        b=L3ZqrsmOu0Nl58HggeWrKiX+VH1dGitgWd5zOaVf++q4x8nZYrMx1974IQFFsCBDnz
         i6Abuc4nOe1q/gPeOt+LVrhCFPibMCmTLeUZtkqvFJmYA13opMevNmd0YaxPuYQKqk8d
         cNooI6BpjEQ8ZxFM1UmZmtn6wiUxsBTNkE00oayOPNzdntIUyflUG8TBMizTjTLDRwsk
         IoMPks6vuv9xlg8JqsqfrK8IJM0mTOyv93HLmBEB8M3NMEHdI1OYJag/Ofp/jzS4YB9p
         +A/hE9VbNauXBwI3p1Y3dX/KRZKYw40UzB/82GdyPiWBWnVtHzea8IqS0GvpaYP5ix0O
         Lj9Q==
X-Gm-Message-State: AHQUAuYqFIvCYrAPxQPT8a7YZSZPVjZaWz5VmyfvF6qQD0ll74OwS3aM
        95U9WXktcEeaBXO9X7riATQ=
X-Google-Smtp-Source: AHgI3IarnWNMihQMt5Bp/KzCN4qvMk7xo/hw280N1C5SLpgwJElG9wN8E8rxcesl9QBneFzYtP+kRw==
X-Received: by 2002:a19:e347:: with SMTP id c7mr450930lfk.137.1551265192676;
        Wed, 27 Feb 2019 02:59:52 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id e21sm730968lfc.90.2019.02.27.02.59.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Feb 2019 02:59:51 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gywwJ-0007vr-9j; Wed, 27 Feb 2019 11:59:51 +0100
Date:   Wed, 27 Feb 2019 11:59:51 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 1/2] device.h: pack struct dev_links_info
Message-ID: <20190227105951.GM4747@localhost>
References: <20190226144108.25891-1-gregkh@linuxfoundation.org>
 <20190227092318.GK4747@localhost>
 <20190227093104.GA5354@kroah.com>
 <20190227094021.GL4747@localhost>
 <20190227095424.GA11387@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190227095424.GA11387@kroah.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 10:54:24AM +0100, Greg Kroah-Hartman wrote:
> On Wed, Feb 27, 2019 at 10:40:21AM +0100, Johan Hovold wrote:
> > On Wed, Feb 27, 2019 at 10:31:04AM +0100, Greg Kroah-Hartman wrote:
> > > On Wed, Feb 27, 2019 at 10:23:18AM +0100, Johan Hovold wrote:
> > > > On Tue, Feb 26, 2019 at 03:41:07PM +0100, Greg Kroah-Hartman wrote:
> > > > > The dev_links_info structure has 4 bytes of padding at the end of it
> > > > > when embedded in struct device (which is the only place it lives).  To
> > > > > help reduce the size of struct device pack this structure so we can take
> > > > > advantage of the hole with later structure reorganizations.
> > > > > 
> > > > > Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> > > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > ---
> > > > >  include/linux/device.h | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/include/linux/device.h b/include/linux/device.h
> > > > > index 6cb4640b6160..b63165276a09 100644
> > > > > --- a/include/linux/device.h
> > > > > +++ b/include/linux/device.h
> > > > > @@ -884,7 +884,7 @@ struct dev_links_info {
> > > > >  	struct list_head suppliers;
> > > > >  	struct list_head consumers;
> > > > >  	enum dl_dev_state status;
> > > > > -};
> > > > > +} __packed;
> > > > 
> > > > This seems like a bad idea. You're changing the alignment of these
> > > > fields to one byte, something which may cause the compiler to generate
> > > > less efficient code to deal with unaligned accesses (even if they happen
> > > > to currently be naturally aligned in struct device).
> > > 
> > > No, all this changes is the trailing "space" is gone.  The alignment of
> > > the fields did not change at all as they are all naturally aligned
> > > (list_head is just 2 pointers).
> > 
> > Yes, currently and in struct device, but given a pointer to a struct
> > dev_links_info the compiler must assume it is unaligned and act
> > accordingly for example.
> 
> Packing the structure doesn't mean that the addressing of it is not also
> aligned, that should just depend on the location of the pointer in the
> first place, right?

Packing a structure per definition means changing the alignment
requirement of each field of the struct to 1-byte alignment.

Another example of unintended consequences would obviously be that if
someone later adds a short field, say 1-byte, field before the
dev_links_info struct, all its fields would be non-naturally aligned
also in struct device.

Sure that can be avoided by inspection (and refusal to add new holes),
but again, not obvious when the link structure is defined elsewhere.

> Surely compilers are not that foolish :)
> 
> And accessing this field should not be an issue of "slow", hopefully the
> memory savings would offset any compiler mess.

There are other subtleties like atomicity that may come into play.

And even if any penalties are deemed acceptable in this case, you're
also setting a precedent for others. Note that we do not seem to use
__packed this way currently

> > > So this allows us to save 4 bytes in struct device by putting something in that
> > > trailing "hole" that can be aligned with it better (i.e. an integer or
> > > something else).
> > 
> > I understand that, but I don't think it is worth to start using packed
> > liked this for internal structures as it may have subtle and unintended
> > consequences.
> 
> I'm not understanding what the consequences are here, sorry.  Does the
> compiler output change given that the structure is still aligned
> properly in the "parent" structure?  I can't see any output changed
> here, but maybe I am not looking properly?

It's all arch dependent, and you won't see any difference on x86-64.

The following example produces additional instructions even on 32-bit
arm here:

struct a1 {
	void *p;
	void *q;
	int i;
} __attribute__((__packed__));

struct a2 {
	void *p;
	void *q;
	int i;
};

int f(struct a1 *a)
{
	return a->i;
}

int g(struct a2 *a)
{
	return a->i;
}

Johan
