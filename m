Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9865BC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 21:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18D8D22438
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 21:58:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="f96G8Dze"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18D8D22438
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754428AbeFZV6Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 17:58:24 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34279 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753043AbeFZV6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 17:58:18 -0400
Received: by mail-pf0-f193.google.com with SMTP id g3-v6so3953139pfi.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 14:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jaJWtNDfTYlYV8D9yr+HttlYYNXH8477B4KZl8cgm5U=;
        b=f96G8DzeF2AzokJ7dFoWUECRkyr0UyO5N1p6k+sw0894fWS+RA2yda0zWP6lZVDn/g
         MkTp7c7c4v5sv06hSZNHhHDzUs8NRH8nHvovFz3Z6Kr4HeBqmEfub0eXcU9BOXVP3LHJ
         LrYsb+PoLFD+3SGdgSD6xYM6r09ZATNPtdXOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jaJWtNDfTYlYV8D9yr+HttlYYNXH8477B4KZl8cgm5U=;
        b=ImM4XIvrHlI1Lva+Esflx5yKKGi0BvR3/kx02iADmAHXuz5DC1CEi0F1eU23J7flQ3
         g4S12QImLPuwkUx9AFpxKPAkP+p1xgMCMC4l8Ixdj6j/ZmzzW4Bx5sCXjL/f2yFP7UsD
         pkmlI+ukBBVV7G71ztRikYm2K5roelY/DmmjoKDhgej5fKYlc/D7xdWpURykrQsg5jee
         9AwqN3j+dUzZBXoXq4aySuKbXgn9fL05IhMuCtdcIuK8rkTbwKXNrHU5LoYZmniu/3J2
         ih+hCZ8jo3O2huJTVquijirAA40DB2aZ2wvnLzUaMcjmoUmSC21ZtCeyZTX9Q6OgE/xU
         1bkw==
X-Gm-Message-State: APt69E3QvmocQyZBV1WxStwDdWCgHP0nklvqttr7b2PpDeHaY7+3kEGI
        BYuvZhqxjbcQiwi9kFU0jY3sWQ==
X-Google-Smtp-Source: ADUXVKLokM1KZcS5q0Dfb8L62X8ncp1jKO0OCDgiNpdRJwPHEGwdqXpR2F4uqleGW/RAj4TVrid/gg==
X-Received: by 2002:a65:6141:: with SMTP id o1-v6mr2743958pgv.409.1530050297753;
        Tue, 26 Jun 2018 14:58:17 -0700 (PDT)
Received: from localhost ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id e10-v6sm3105661pgv.48.2018.06.26.14.58.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 14:58:17 -0700 (PDT)
Date:   Tue, 26 Jun 2018 14:58:16 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Evan Green <evgreen@chromium.org>
Cc:     georgi.djakov@linaro.org, linux-pm@vger.kernel.org,
        gregkh@linuxfoundation.org, rjw@rjwysocki.net, robh+dt@kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        khilman@baylibre.com, Vincent Guittot <vincent.guittot@linaro.org>,
        Saravana Kannan <skannan@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, abailon@baylibre.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v5 1/8] interconnect: Add generic on-chip interconnect API
Message-ID: <20180626215816.GQ129942@google.com>
References: <20180620121141.15403-1-georgi.djakov@linaro.org>
 <20180620121141.15403-2-georgi.djakov@linaro.org>
 <CAE=gft4sSdFL7J27WdTuYCtfLPAyv8xOAizYhmtfK5UkTbP5-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAE=gft4sSdFL7J27WdTuYCtfLPAyv8xOAizYhmtfK5UkTbP5-A@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 01:57:21PM -0700, Evan Green wrote:
> Hi Georgi. Thanks for the new spin of this.
> 
> On Wed, Jun 20, 2018 at 5:11 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
> >
> > This patch introduce a new API to get requirements and configure the
> > interconnect buses across the entire chipset to fit with the current
> > demand.
> >
> > The API is using a consumer/provider-based model, where the providers are
> > the interconnect buses and the consumers could be various drivers.
> > The consumers request interconnect resources (path) between endpoints and
> > set the desired constraints on this data flow path. The providers receive
> > requests from consumers and aggregate these requests for all master-slave
> > pairs on that path. Then the providers configure each participating in the
> > topology node according to the requested data flow path, physical links and
> > constraints. The topology could be complicated and multi-tiered and is SoC
> > specific.
> >
> > Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> > ---
> >  Documentation/interconnect/interconnect.rst |  96 ++++
> >  drivers/Kconfig                             |   2 +
> >  drivers/Makefile                            |   1 +
> >  drivers/interconnect/Kconfig                |  10 +
> >  drivers/interconnect/Makefile               |   2 +
> >  drivers/interconnect/core.c                 | 586 ++++++++++++++++++++
> >  include/linux/interconnect-provider.h       | 127 +++++
> >  include/linux/interconnect.h                |  42 ++
> >  8 files changed, 866 insertions(+)
> >  create mode 100644 Documentation/interconnect/interconnect.rst
> >  create mode 100644 drivers/interconnect/Kconfig
> >  create mode 100644 drivers/interconnect/Makefile
> >  create mode 100644 drivers/interconnect/core.c
> >  create mode 100644 include/linux/interconnect-provider.h
> >  create mode 100644 include/linux/interconnect.h
> >
> > ...
> >
> > diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> > new file mode 100644
> > index 000000000000..e7f96fc6722e
> > --- /dev/null
> > +++ b/drivers/interconnect/core.c
> > @@ -0,0 +1,586 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Interconnect framework core driver
> > + *
> > + * Copyright (c) 2018, Linaro Ltd.
> > + * Author: Georgi Djakov <georgi.djakov@linaro.org>
> > + */
> > +
> > +#include <linux/device.h>
> > +#include <linux/idr.h>
> > +#include <linux/init.h>
> > +#include <linux/interconnect.h>
> > +#include <linux/interconnect-provider.h>
> > +#include <linux/list.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/slab.h>
> > +
> > +static DEFINE_IDR(icc_idr);
> > +static LIST_HEAD(icc_provider_list);
> > +static DEFINE_MUTEX(icc_lock);
> > +
> > +/**
> > + * struct icc_req - constraints that are attached to each node
> > + *
> > + * @req_node: entry in list of requests for the particular @node
> > + * @node: the interconnect node to which this constraint applies
> > + * @dev: reference to the device that sets the constraints
> > + * @avg_bw: an integer describing the average bandwidth in kbps
> > + * @peak_bw: an integer describing the peak bandwidth in kbps
> > + */
> > +struct icc_req {
> > +       struct hlist_node req_node;
> > +       struct icc_node *node;
> > +       struct device *dev;
> > +       u32 avg_bw;
> > +       u32 peak_bw;
> > +};
> > +
> > +/**
> > + * struct icc_path - interconnect path structure
> > + * @num_nodes: number of hops (nodes)
> > + * @reqs: array of the requests applicable to this path of nodes
> > + */
> > +struct icc_path {
> > +       size_t num_nodes;
> > +       struct icc_req reqs[0];
> > +};
> > +
> > +static struct icc_node *node_find(const int id)
> > +{
> > +       struct icc_node *node;
> > +
> > +       mutex_lock(&icc_lock);
> > +       node = idr_find(&icc_idr, id);
> > +       mutex_unlock(&icc_lock);
> 
> I wonder if this is too low of a level to be dealing with the lock. I
> notice that everywhere you use this function, you afterwards
> immediately grab the lock and do more stuff. Maybe this function
> should have a comment saying it assumes the lock is already held, and
> then you can grab the lock in the callers, since you're doing that
> anyway.

I think the canonical way to document the expectation would be:

WARN_ON(!mutex_is_locked(&icc_lock));

> > +
> > +       return node;
> > +}
> > +
> > +static struct icc_path *path_allocate(struct icc_node *dst, ssize_t num_nodes)
> > +{
> > +       struct icc_node *node = dst;
> > +       struct icc_path *path;
> > +       size_t i;
> > +
> > +       path = kzalloc(sizeof(*path) + num_nodes * sizeof(*path->reqs),
> > +                      GFP_KERNEL);
> > +       if (!path)
> > +               return ERR_PTR(-ENOMEM);
> > +
> > +       path->num_nodes = num_nodes;
> > +
> > +       for (i = 0; i < num_nodes; i++) {
> > +               hlist_add_head(&path->reqs[i].req_node, &node->req_list);
> > +
> > +               path->reqs[i].node = node;
> > +               /* reference to previous node was saved during path traversal */
> > +               node = node->reverse;
> > +       }
> > +
> > +       return path;
> > +}
> > +
> > +static struct icc_path *path_find(struct device *dev, struct icc_node *src,
> > +                                 struct icc_node *dst)
> > +{
> 
> I personally prefer a comment somewhere indicating that this function
> assumes icc_lock is already held. Not sure if that's conventional or
> not.

Same as above.
