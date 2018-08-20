Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C88AC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 11:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22BE520BF3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 11:20:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22BE520BF3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbeHTOfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 10:35:18 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:46453 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbeHTOfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 10:35:18 -0400
Received: by mail-qt0-f193.google.com with SMTP id d4-v6so15675864qtn.13;
        Mon, 20 Aug 2018 04:20:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v6zsyC2te87uF0RtJ5t0u6eQdifD8RmrlBjRFINr088=;
        b=BIMLeG8PSVhh07OqNckROgNUoZTFSAS+2RZ2VScUrwTsqz4htdVW/SAoh8C/2ThH4V
         HI6zZWGJwxWOMWRVrwMLLBi/glL8VW9No6iANj4ZjnRpXkPF9mrSvQHvdCvrqzDgJ6Kz
         L4om4lkSoVazMxCJAG7WwPbUJO0BuRFe6E9J74Al0QB8wiDqjS9tGUZDQ4XE4/NmrSh7
         G+LGkcVUudSND4ymKqe8LBAb+y7oSNqznpgcpKTKWgCDnzoycZo7kcgz7jnM3a4zq3ys
         7ZXp3dVEHSVvJgJgUHnZF5dE4HFF8BQo5E+xrKcu3/fIndDRhy5ldchknj/r8MTWIeAQ
         0Aag==
X-Gm-Message-State: AOUpUlGn6x1HarYrWYVUzZPQN5C+0mmw9gfVZ+pXpJdoe94y1HJdLeQJ
        mRF9kPuBsUxRzTd/Z5HHLdLt4GqhIPigVu/8RJI=
X-Google-Smtp-Source: AA+uWPxFqYu8MTZg5ODa5YYedofk9y3d9xLtfJzqeASyNPw379fivmsODYiv1TmoRFe7zY7drrVxvKsX6lViBRG5mVE=
X-Received: by 2002:a0c:8b67:: with SMTP id d39-v6mr40563417qvc.180.1534764005043;
 Mon, 20 Aug 2018 04:20:05 -0700 (PDT)
MIME-Version: 1.0
References: <20180817102645.3839621-1-arnd@arndb.de> <20180817102645.3839621-8-arnd@arndb.de>
 <CAJZ5v0iCgQxxuoCB9B4-Ho3xeLwb4v99Xyw-9e-tT53mRD+YVQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0iCgQxxuoCB9B4-Ho3xeLwb4v99Xyw-9e-tT53mRD+YVQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 20 Aug 2018 13:19:48 +0200
Message-ID: <CAK8P3a31Ds14Ke1qLoMapK1Wq1M4tR6n+nL1VOKzR8+oN0eOBw@mail.gmail.com>
Subject: Re: [RFC 07/15] PCI/ACPI: clean up acpi_pci_root_create()
To:     Rafael Wysocki <rafael@kernel.org>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2018 at 10:23 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Fri, Aug 17, 2018 at 12:33 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > @@ -909,8 +881,7 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
> >         int ret, busnum = root->secondary.start;
> >         struct acpi_device *device = root->device;
> >         int node = acpi_get_node(device->handle);
> > -       struct pci_bus *bus;
> > -       struct pci_host_bridge *host_bridge;
> > +       struct pci_host_bridge *bridge;
>
> Why "bridge" and not "host" or even something to stand for "root complex"?
>
> Or maybe it can still be "host_bridge"?

I did this for consistency with the naming in drivers/pci/probe.c,
which always declares the local variable as 'struct pci_host_bridge *bridge'.
It's easy to change here if you feel strongly about it (I don't).

        Arnd
