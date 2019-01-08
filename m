Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7760CC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 22:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 331F52146F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 22:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="Ufv4z6NI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730340AbfAHWvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 17:51:23 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:47074 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728830AbfAHWvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 17:51:22 -0500
Received: by mail-pf1-f194.google.com with SMTP id c73so2610327pfe.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 14:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z1s6TSGDjP6SNuli3YtUtMnOPSMApQhQ8/VHYSzE1QM=;
        b=Ufv4z6NIYoGMh+ULLdEDR779mrYWYbbLuz7tP+YxmsMT6EqSRAjiRs0Al9OTzjWuSK
         bajywjTL9kYIK3+HcHAPg7jdbVz2Ms5LfgbF9RfounLnXhexjczBeOOjqndApBKX/tvG
         ZZvqBeEpWInxQ1+mdnShrpUhETsHrx7r+AJ55dxcimEQRkmGJCYSDvCLd+jPlsBRF6pw
         /gMu1sQzywkPKAoT6tpAtnVDJ6bxeFoTnKYlNBliY0Qv5/mHtx7UHas+NuvTxJDlXaW+
         PYxf6eUn5lS5zVMdVGmNtlEbtoCC/gj8JkM22ZO6XZuSV0cysuRO5FqaLWDO8a870nWY
         kovA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z1s6TSGDjP6SNuli3YtUtMnOPSMApQhQ8/VHYSzE1QM=;
        b=CRotBLnaZofgufXqyPSYNAGMS1nnLlCbtZKINcm53jlYBVYPvg8p7Gm7t4k5CHOFFz
         8KGMET4mg53DprTztDK4UudiZdLI2UgaA67JE4sWmPXuDCzL+Gb7KlwapvCyYbwbPcIV
         Ca1GDP/AW5tbephKMe6piI+/vyFgxhHKL8uH0HKXf76wHA9cuSFjMGwrqr5ez8F8xYke
         UxU4bc2SjdCfELiiLARHVtJ2uR/B2mgBHRcbPm07AYIn9CuE3dsJrXNksN2iMSMLafBu
         7t1uNw2uN13z7n2M1Oz934kOLnktaM+MjbUZXyGybr9sGdrwie9wQS5a83kTrA9E+ICs
         pJKg==
X-Gm-Message-State: AJcUukejH7Z/P3TJ+o/nbnW4MyYalmIwwPuWtJyoBX9j72jm2hzQiF/4
        zCc/0RN9BwP11Wdgp08tA7w26w==
X-Google-Smtp-Source: ALg8bN6ARyPR+LzaLDp+r/5Dd5PYt+2IdqGyxXIJivm8zSTmYknemtlluytBENpySO8GEyU7IBQI/g==
X-Received: by 2002:a62:6b8a:: with SMTP id g132mr3596032pfc.201.1546987881602;
        Tue, 08 Jan 2019 14:51:21 -0800 (PST)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id i184sm98316555pfc.41.2019.01.08.14.51.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Jan 2019 14:51:21 -0800 (PST)
Date:   Tue, 8 Jan 2019 14:51:12 -0800
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Ian Kumlien <ian.kumlien@gmail.com>
Cc:     Linux Kernel Network Developers <netdev@vger.kernel.org>,
        jeffrey.t.kirsher@intel.com,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        nikolay@cumulusnetworks.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] v4.20 - bridge not getting DHCP responses? (works in
 4.19.13)
Message-ID: <20190108145112.65fc554f@hermes.lan>
In-Reply-To: <CAA85sZsyEnkmwO2grp3H5pXErrNV=prOjEfPy=odoQ8iSHox4Q@mail.gmail.com>
References: <CAA85sZsiifWTKq=Mw30f-UVyrzywnYYX7GvyqG+O+ndSYBML9A@mail.gmail.com>
        <CAA85sZsj5PxZeiXSVK92QXi93fc+Ch2x2KHqzzPcT2OffaKsEQ@mail.gmail.com>
        <CAA85sZsyEnkmwO2grp3H5pXErrNV=prOjEfPy=odoQ8iSHox4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jan 2019 23:10:04 +0100
Ian Kumlien <ian.kumlien@gmail.com> wrote:

> On Sun, Jan 6, 2019 at 11:21 PM Ian Kumlien <ian.kumlien@gmail.com> wrote:
> >
> > [Sorry for the repost, screwed up the netdev address...]
> >
> > Hi,
> >
> > Switching from 4.19.x -> 4.20 resulted in DHCP not working for my VM:s.
> >
> > My firewall (which also runs the dhcpd) runs VM:s and it does this by
> > having physical
> > interfaces attached to bridges - which the VM:s in turn attach to.
> >
> > Since 4.20 the VM:s can't use DHCP, it's odd since the requests are
> > seen - a response is sent but
> > it never enters the interface attached to the bridge.
> >
> > Basically:
> > VM vnet2: -> br0 -> eno2 -> switch -> eno1 (dhcpd)
> > dhcpd eno1 -> siwtch and... gone.
> >
> > Any clues?
> >
> > All the nics are handled by ixgbe  
> 
> So, doing similar tests at work with other drivers works - could it be
> related to the mac address filter that was added?
> I don't *really* use VF:s though... (can't really find anything else atm)
> 
> Will try to test, but the VM:s on this machine is in use.

The default MAC address of the bridge device is the first device assigned
to the bridge.  Remember most VF interfaces will only allow single MAC address
and no promiscious mode.
