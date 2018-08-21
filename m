Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED7EC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 10:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D74121581
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 10:08:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D74121581
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbeHUN1a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 09:27:30 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:42465 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbeHUN1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 09:27:30 -0400
Received: by mail-qt0-f195.google.com with SMTP id z8-v6so19429209qto.9;
        Tue, 21 Aug 2018 03:07:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xqNsNgCpJFa21cWSGZHlNueon7cKTyWvt+4FEuonZp4=;
        b=RFL/rTl+09adUH3eje4uqv5ON3QaDZsJYquTEqb6JHYVmPW/9h2dQNBrAmCVQ1TuXS
         szbdKSWsClc36CNyXPDJjGTforKs7kJcu0yIh7SIac/97O2PGpc5qIsf9RqC0URveY5t
         0DLv2vDFooHV0mN/4/nZmPzaxK4EZo4+KvjZUFThD/5cl/801/MREigEJSBfr9Tg+A2N
         3UDOVhxrTfGsssGsQn4+NzGutYYTNyrhmfE3tcawz56nDFdWJeknk44+E1kyopb2zQUo
         nJcjMbyGpYCMi3HkuhKTif13ACIlSh0l/RN2HmfhA0Yq4tkkNzNWxeqZ0oTwJWjleRr/
         uzlg==
X-Gm-Message-State: AOUpUlFPIjxdUh8n1fi1tO+XovkIyA4erIxVpfoOMu+9faLi2/1jcxjO
        8mHvCu9RfQG/CGV8HihK1jRSUXJqpxWnqjDwLzc=
X-Google-Smtp-Source: AA+uWPw1YeDdzZYA9TxI8CC9dgL5MP1Rp1A4yNXDL7nRFbGhknbyyxvYDRMgXJg4h02hdayt4asJRPvz1dl5Ue3pA/k=
X-Received: by 2002:aed:2b47:: with SMTP id p65-v6mr9787912qtd.132.1534846077425;
 Tue, 21 Aug 2018 03:07:57 -0700 (PDT)
MIME-Version: 1.0
References: <20180817102645.3839621-1-arnd@arndb.de> <20180821061451.GB481@infradead.org>
In-Reply-To: <20180821061451.GB481@infradead.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 21 Aug 2018 12:07:40 +0200
Message-ID: <CAK8P3a1_VbhLteRiJe2WDk2FgcPFMLTXv_t5oi2zZ1ywh63cZg@mail.gmail.com>
Subject: Re: [RFC 00/15] PCI: turn some __weak functions into callbacks
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 8:14 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Fri, Aug 17, 2018 at 12:26:30PM +0200, Arnd Bergmann wrote:
> > Hi Bjorn and others,
> >
> > Triggered by Christoph's patches, I had another go at converting
> > all of the remaining pci host bridge implementations to be based
> > on pci_alloc_host_bridge and a separate registration function.
>
> I really like the idea behind this series.
>
> > I'm adding a bit of duplication into the less maintained code
> > here, but it makes everything more consistent, and gives an
> > easy place to hook up callback functions etc.
>
> I wonder if there is a way to avoid some of that by adding a few
> more helpers, but even without the helpers that approach looks
> ok to me.

Ok, thanks for taking a first look.

One core part that gets duplicated a lot (also in existing drivers)
is the chunk that could be handled by this:

int pci_host_bridge_init(struct pci_host_bridge *bridge,
                   struct device *parent, int bus,
                   struct pci_ops *ops, void *sysdata,
                   struct list_head *resource_list)
{
       if (resources)
              list_splice_init(resources, &bridge->windows);
       bridge->dev.parent = parent;
       bridge->sysdata = sysdata;
       bridge->busnr = bus;
       bridge->ops = ops;
}

That would probably help, but we should think carefully about
the set of fields that we want pass here, specifically because the
idea of splitting the probing into two parts was to avoid having
to come up with a new interface every time that list changes
due to some rework.

For instance, the numa node is something that might get passed
here, and if we decide to split out the operations into a separate
pci_host_bridge_ops structure, the pointer to that would also
be something we'd want to pass this way.

> Do you have a git tree somewhere to play around with the changes?

I now uploaded it (with fixes incorporated) to

https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git
pci-probe-rework

       arnd
