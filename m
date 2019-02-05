Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 102E5C282CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 14:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBF5B2080F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 14:48:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729026AbfBEOsu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 09:48:50 -0500
Received: from mga12.intel.com ([192.55.52.136]:34779 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728299AbfBEOst (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 09:48:49 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2019 06:48:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,564,1539673200"; 
   d="scan'208";a="115431231"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga008.jf.intel.com with ESMTP; 05 Feb 2019 06:48:48 -0800
Date:   Tue, 5 Feb 2019 07:48:15 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>
Subject: Re: [PATCHv5 04/10] node: Link memory nodes to their compute nodes
Message-ID: <20190205144815.GA28023@localhost.localdomain>
References: <20190124230724.10022-1-keith.busch@intel.com>
 <20190124230724.10022-5-keith.busch@intel.com>
 <CAJZ5v0jE_gRT5WgpQYwZQmx6N5G+axymbSySb2Nk8Q0OGeNt9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jE_gRT5WgpQYwZQmx6N5G+axymbSySb2Nk8Q0OGeNt9A@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2019 at 04:33:27AM -0800, Rafael J. Wysocki wrote:
> On Fri, Jan 25, 2019 at 12:08 AM Keith Busch <keith.busch@intel.com> wrote:
> > +/**
> > + * struct node_access_nodes - Access class device to hold user visible
> > + *                           relationships to other nodes.
> > + * @dev:       Device for this memory access class
> > + * @list_node: List element in the node's access list
> > + * @access:    The access class rank
> > + */
> > +struct node_access_nodes {
> > +       struct device           dev;
> 
> I'm not sure if the entire struct device is needed here.
> 
> It looks like what you need is the kobject part of it only and you can
> use a kobject directly here:
> 
> struct kobject        kobj;
> 
> Then, you can register that under the node's kobject using
> kobject_init_and_add() and you can create attr groups under a kobject
> using sysfs_create_groups(), which is exactly what device_add_groups()
> does.
> 
> That would allow you to avoid allocating extra memory to hold the
> entire device structure and the extra empty "power" subdirectory added
> by device registration would not be there.

This is conflicting with Greg's feedback from the first version of
this series:

  https://lore.kernel.org/lkml/20181126190619.GA32595@kroah.com/

Do you still recommend using kobject?
