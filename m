Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE389C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 14:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90ED6217F9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 14:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549378353;
	bh=YYosVEfjw34D+TtsvSvjOuSr//0DVVoCCC0u5tckTSg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eiT6HciWuvQUgjOVvm5P2JE9CVyPX52qyefK0ogauiiyybQ3dMfhe92d/MB7mYITR
	 El+Q3zSWji22XM3+4TJrnO4pTsKbbe68FOxTcT9vp39D6YbUJn1Q2f18tbx4I+UZje
	 5EiRNFDvb2/jAtKqaXHwwi85XboPrby8BXAv8n1Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbfBEOwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 09:52:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:34042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbfBEOwb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 09:52:31 -0500
Received: from localhost (unknown [212.187.182.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 244062081B;
        Tue,  5 Feb 2019 14:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549378350;
        bh=YYosVEfjw34D+TtsvSvjOuSr//0DVVoCCC0u5tckTSg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ovmq7q3ygf3dUZSvld8v98BmehEcCgKjFOy0jqxgyBxS6+WMOCV/6hMgE5l/hdHxv
         Xm+TqVPW5KvDFspngtv9FTADycQDVU5Kw5mOat15bNfnYd1E5j1jQHoMpabShuQjoC
         33/u7zZk3rYPncQDjznRJQ0EdO4oOXMQHanHU5J4=
Date:   Tue, 5 Feb 2019 15:52:27 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Keith Busch <keith.busch@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCHv5 04/10] node: Link memory nodes to their compute nodes
Message-ID: <20190205145227.GG17950@kroah.com>
References: <20190124230724.10022-1-keith.busch@intel.com>
 <20190124230724.10022-5-keith.busch@intel.com>
 <CAJZ5v0jE_gRT5WgpQYwZQmx6N5G+axymbSySb2Nk8Q0OGeNt9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jE_gRT5WgpQYwZQmx6N5G+axymbSySb2Nk8Q0OGeNt9A@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2019 at 01:33:27PM +0100, Rafael J. Wysocki wrote:
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

When you use a "raw" kobject then userspace tools do not see the devices
and attributes in libraries like udev.  So unless userspace does not
care about this at all, you should use a 'struct device' where ever
possible.  The memory "savings" usually just isn't worth it unless you
have a _lot_ of objects being created here.

Who is going to use all of this new information?

thanks,

greg k-h
