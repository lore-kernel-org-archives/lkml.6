Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 834A7C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E7832087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="FkyDdINE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbfARQgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 11:36:04 -0500
Received: from mail-oi1-f174.google.com ([209.85.167.174]:41701 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727762AbfARQgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 11:36:04 -0500
Received: by mail-oi1-f174.google.com with SMTP id j21so9396913oii.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 08:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lw/evbXQOPWl45yh4xmiSoRgJO3UEKa0j1zf5GEngpE=;
        b=FkyDdINE7f0BKmDJo6ikxgnXGoIaF5K38PG+i+7xq6DmDquvdWOBQ2bbhUR1jl5EWv
         bxHWPbdJBJxEQhaBYcV9rTl9ywrNqm/5N3TE/pGpTeSb+QSpGui0VlIlYien91SCNjNJ
         1JnfZuUQ7k/Ix3/0ZsyQmDE28VNdPJVxpqA7iROn5fxzfx5l+Y8D7O4OepVQ10J89+DD
         aXnJTkmcn5UGb5iz+ZiZHs6JsJ3ewxugNSjLQo9WJjbK+kBGZgMEuB6xjIrw4puTyQ9/
         wjWQgQVLo0l2wYO2DO9RmxUS2+StTPgCQIFRJySc9Bkx4Houx41p1gZN8mrx3OoMgNao
         foJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lw/evbXQOPWl45yh4xmiSoRgJO3UEKa0j1zf5GEngpE=;
        b=Zp2TCDhXRtnpnCFTHhRCUScfOKAVoQBKGfElqPmxfJ+0owU5OJ1Ksm2qrtxWH6Z9xc
         Vy/uWz43m3gW+CfLHjCiBQb1vyX042tqtxIU/EEr7n2iAPLRZR5V91ZY1UKisgZfBTAC
         NSXCaYaLBF1NH5ARdbIMc6tuaDXaN9r4Qapdk9mwx/zm61vSICZONo2c4HEDrKmuUX85
         Fnmia4M6QTl9pLu0Mnh6TQFv6GmWUN0ZC5LkgXs2+/1yZq/lw4nlGSrE6aduMVpM18hs
         QWif9Qs5mnU1IVGlZBJiu4aR8VzKBIp5U6ZjMgJkZVmnwTkRyfXdP+wbFUpy1emIYebT
         ci6g==
X-Gm-Message-State: AJcUukeTdDvznRxK5pjFd6AtWCysx3j9aU+WWfR4v+mGVwpmY8p7xdRd
        E0Ropj9Wows1YZUbBrDR8Pj/lgnqsICngt0/COxu3CMf
X-Google-Smtp-Source: ALg8bN7dlQwuuKqJEM5wiSPeX3yUCYfDc6SJidEHI/YbGPyjaU7mSqy4lEZ/5GiWydE/OcfOq4RyZfeGFt0ugk3Zxm0=
X-Received: by 2002:aca:2dc8:: with SMTP id t191mr472109oit.235.1547829362554;
 Fri, 18 Jan 2019 08:36:02 -0800 (PST)
MIME-Version: 1.0
References: <20190116175804.30196-1-keith.busch@intel.com> <20190116175804.30196-6-keith.busch@intel.com>
 <20190118112134.00003b65@huawei.com>
In-Reply-To: <20190118112134.00003b65@huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 18 Jan 2019 08:35:50 -0800
Message-ID: <CAPcyv4jo20LkXnVuLcvxFOOSGhx7yGN1vy4jv3N33ubk0q0nOg@mail.gmail.com>
Subject: Re: [PATCHv4 05/13] Documentation/ABI: Add new node sysfs attributes
To:     Jonathan Cameron <jonathan.cameron@huawei.com>
Cc:     Keith Busch <keith.busch@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 3:22 AM Jonathan Cameron
<jonathan.cameron@huawei.com> wrote:
>
> On Wed, 16 Jan 2019 10:57:56 -0700
> Keith Busch <keith.busch@intel.com> wrote:
>
> > Add entries for memory initiator and target node class attributes.
> >
> > Signed-off-by: Keith Busch <keith.busch@intel.com>
> > ---
> >  Documentation/ABI/stable/sysfs-devices-node | 25 ++++++++++++++++++++++++-
> >  1 file changed, 24 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/ABI/stable/sysfs-devices-node b/Documentation/ABI/stable/sysfs-devices-node
> > index 3e90e1f3bf0a..a9c47b4b0eee 100644
> > --- a/Documentation/ABI/stable/sysfs-devices-node
> > +++ b/Documentation/ABI/stable/sysfs-devices-node
> > @@ -90,4 +90,27 @@ Date:              December 2009
> >  Contact:     Lee Schermerhorn <lee.schermerhorn@hp.com>
> >  Description:
> >               The node's huge page size control/query attributes.
> > -             See Documentation/admin-guide/mm/hugetlbpage.rst
> > \ No newline at end of file
> > +             See Documentation/admin-guide/mm/hugetlbpage.rst
> > +
> > +What:                /sys/devices/system/node/nodeX/classY/
> > +Date:                December 2018
> > +Contact:     Keith Busch <keith.busch@intel.com>
> > +Description:
> > +             The node's relationship to other nodes for access class "Y".
> > +
> > +What:                /sys/devices/system/node/nodeX/classY/initiator_nodelist
> > +Date:                December 2018
> > +Contact:     Keith Busch <keith.busch@intel.com>
> > +Description:
> > +             The node list of memory initiators that have class "Y" access
> > +             to this node's memory. CPUs and other memory initiators in
> > +             nodes not in the list accessing this node's memory may have
> > +             different performance.
> > +
> > +What:                /sys/devices/system/node/nodeX/classY/target_nodelist
> > +Date:                December 2018
> > +Contact:     Keith Busch <keith.busch@intel.com>
> > +Description:
> > +             The node list of memory targets that this initiator node has
> > +             class "Y" access. Memory accesses from this node to nodes not
> > +             in this list may have differet performance.
>
> Different performance from what?  In the other thread we established that
> these target_nodelists are kind of a backwards reference, they all have
> their characteristics anyway.  Perhaps this just needs to say:
> "Memory access from this node to these targets may have different performance"?
>
> i.e. Don't make the assumption I did that they should all be the same!

I think a clarification of "class" is needed in this context. A
"class" is the the set of initiators that have the same rated
performance to a given target set. In other words "class" is a tuple
of (performance profile, initiator set, target set). Different
performance creates a different tuple / class.
