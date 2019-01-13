Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04619C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 01:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4D8120836
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 01:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="k2ZeoyA4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfAMBnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 20:43:39 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39559 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbfAMBni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 20:43:38 -0500
Received: by mail-ot1-f65.google.com with SMTP id n8so16483424otl.6
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jan 2019 17:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=12pdMTxqi83EEHwmbAWeg9wmewWbN2jswxBvTfN4Tx4=;
        b=k2ZeoyA4j1WraN5omupcFDMgaU+uV0QBeNCMiUymjP1qGJm8hqsyu2RY3U7NLfn54F
         EPU1jFpn0N4gZTtVTx/nIKOAXdI18EK2uXZreDYXCSrOQyJF5d+B56KbZSnzD6Ehvr5o
         m0URnBw/09KygC5MXK2xT7sPrDqumhH8QDk+5C2Lm2oAMKDaXB/+EI143Kwg6Mx8kLKd
         Q8cS2seWxCRLB6A1nlTXL7CQPPlnCIseuq5qfa567lHNNrkY+JGfUlMWesk47sP0W8aW
         UV5xhgOdGEdtBvgYLCIR8xslQKpCnCGP5eAj/F0uBRw0mYYdlLWMBik+ZGMyxnYcwNi6
         y/nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=12pdMTxqi83EEHwmbAWeg9wmewWbN2jswxBvTfN4Tx4=;
        b=lPPCDg7vEb+SItGW8mcC3TvgCe4Q29y6aWsYWAzw1ewSADOuPy82yT71kEm6rTIAWZ
         0Bm0KUiAvDIfxI/dGcsvwA2pXFJoFC6U6QbwGIa9MNRP+U5pD02JcGSY2iP+s/9P+PVz
         J8teVzl8/eg/ymRXCcypaR7AKihZo2MjWFVsaPN3eS+Ip0F+kzLzFb07AkD4u+PC8/KY
         GtfJ7bVwvf/xtqW5b3VfBcQSHCfYaKumfM1yy1eTkv1oLu5wbst04ToR94Cu9aObzPJ/
         tdjxOawE/Ac+yyceWFYc3d9jn8HS+mfhFj6VPqxrJqj6Dvho8BwvDMFsYXiah8kzh176
         WLLA==
X-Gm-Message-State: AJcUukfiD8Hdgoqt9w4RAQ7AyDP9Eo6DDalsznFRIrI4l84F0miCdbd0
        pTqeU/Gp4vbDSC0J1NlDz5HTDXELdJ91iqE0d4/GfQ==
X-Google-Smtp-Source: ALg8bN5szFGR70yAx+7w804SW60dQFWqcQhHcibuHwNACfmb+lm5JCP7yrlLJmLn1hLRRPVPOxjan9YU5HRcmF/+5wc=
X-Received: by 2002:a9d:6a50:: with SMTP id h16mr12556790otn.95.1547343817474;
 Sat, 12 Jan 2019 17:43:37 -0800 (PST)
MIME-Version: 1.0
References: <20190109144736.17452-1-pagupta@redhat.com> <20190110012617.GA4205@dastard>
 <20190110101757.GC15790@quack2.suse.cz> <1354249849.63357171.1547343519970.JavaMail.zimbra@redhat.com>
In-Reply-To: <1354249849.63357171.1547343519970.JavaMail.zimbra@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sat, 12 Jan 2019 17:43:26 -0800
Message-ID: <CAPcyv4hwcgTUpgNCefCGu4DvgkYBp5b=f+hJ+FC=s5APYKoycg@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] kvm "virtio pmem" device
To:     Pankaj Gupta <pagupta@redhat.com>
Cc:     Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>,
        Qemu Developers <qemu-devel@nongnu.org>,
        linux-nvdimm <linux-nvdimm@ml01.01.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Nitesh Narayan Lal <nilal@redhat.com>,
        Kevin Wolf <kwolf@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ross Zwisler <zwisler@kernel.org>,
        vishal l verma <vishal.l.verma@intel.com>,
        dave jiang <dave.jiang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        jmoyer <jmoyer@redhat.com>,
        xiaoguangrong eric <xiaoguangrong.eric@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, lcapitulino@redhat.com,
        Igor Mammedov <imammedo@redhat.com>,
        Eric Blake <eblake@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        adilger kernel <adilger.kernel@dilger.ca>,
        darrick wong <darrick.wong@oracle.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 12, 2019 at 5:38 PM Pankaj Gupta <pagupta@redhat.com> wrote:
>
>
>
> >
> > On Thu 10-01-19 12:26:17, Dave Chinner wrote:
> > > On Wed, Jan 09, 2019 at 08:17:31PM +0530, Pankaj Gupta wrote:
> > > >  This patch series has implementation for "virtio pmem".
> > > >  "virtio pmem" is fake persistent memory(nvdimm) in guest
> > > >  which allows to bypass the guest page cache. This also
> > > >  implements a VIRTIO based asynchronous flush mechanism.
> > >
> > > Hmmmm. Sharing the host page cache direct into the guest VM. Sounds
> > > like a good idea, but.....
> > >
> > > This means the guest VM can now run timing attacks to observe host
> > > side page cache residency, and depending on the implementation I'm
> > > guessing that the guest will be able to control host side page
> > > cache eviction, too (e.g. via discard or hole punch operations).
> > >
> > > Which means this functionality looks to me like a new vector for
> > > information leakage into and out of the guest VM via guest
> > > controlled host page cache manipulation.
> > >
> > > https://arxiv.org/pdf/1901.01161
> > >
> > > I might be wrong, but if I'm not we're going to have to be very
> > > careful about how guest VMs can access and manipulate host side
> > > resources like the page cache.....
> >
> > Right. Thinking about this I would be more concerned about the fact that
> > guest can effectively pin amount of host's page cache upto size of the
> > device/file passed to guest as PMEM, can't it Pankaj? Or is there some QEMU
> > magic that avoids this?
>
> Yes, guest will pin these host page cache pages using 'get_user_pages' by
> elevating the page reference count. But these pages can be reclaimed by host
> at any time when there is memory pressure.

Wait, how can the guest pin the host pages? I would expect this to
happen only when using vfio and device assignment. Otherwise, no the
host can't reclaim a pinned page, that's the whole point of a pin to
prevent the mm from reclaiming ownership.

> KVM does not permanently pin pages. vfio does that but we are not using
> it here.

Right, so I'm confused by your pin assertion above.
