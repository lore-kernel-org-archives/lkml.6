Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1EF9C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA59C21773
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbfAJKSD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 05:18:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:38170 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727692AbfAJKSC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 05:18:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 228AEAFF8;
        Thu, 10 Jan 2019 10:18:00 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 8087B1E1519; Thu, 10 Jan 2019 11:17:57 +0100 (CET)
Date:   Thu, 10 Jan 2019 11:17:57 +0100
From:   Jan Kara <jack@suse.cz>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Pankaj Gupta <pagupta@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, qemu-devel@nongnu.org,
        linux-nvdimm@ml01.01.org, linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-acpi@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, jack@suse.cz, stefanha@redhat.com,
        dan.j.williams@intel.com, riel@surriel.com, nilal@redhat.com,
        kwolf@redhat.com, pbonzini@redhat.com, zwisler@kernel.org,
        vishal.l.verma@intel.com, dave.jiang@intel.com, david@redhat.com,
        jmoyer@redhat.com, xiaoguangrong.eric@gmail.com, hch@infradead.org,
        mst@redhat.com, jasowang@redhat.com, lcapitulino@redhat.com,
        imammedo@redhat.com, eblake@redhat.com, willy@infradead.org,
        tytso@mit.edu, adilger.kernel@dilger.ca, darrick.wong@oracle.com,
        rjw@rjwysocki.net
Subject: Re: [PATCH v3 0/5] kvm "virtio pmem" device
Message-ID: <20190110101757.GC15790@quack2.suse.cz>
References: <20190109144736.17452-1-pagupta@redhat.com>
 <20190110012617.GA4205@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110012617.GA4205@dastard>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 10-01-19 12:26:17, Dave Chinner wrote:
> On Wed, Jan 09, 2019 at 08:17:31PM +0530, Pankaj Gupta wrote:
> >  This patch series has implementation for "virtio pmem". 
> >  "virtio pmem" is fake persistent memory(nvdimm) in guest 
> >  which allows to bypass the guest page cache. This also
> >  implements a VIRTIO based asynchronous flush mechanism.  
> 
> Hmmmm. Sharing the host page cache direct into the guest VM. Sounds
> like a good idea, but.....
> 
> This means the guest VM can now run timing attacks to observe host
> side page cache residency, and depending on the implementation I'm
> guessing that the guest will be able to control host side page
> cache eviction, too (e.g. via discard or hole punch operations).
> 
> Which means this functionality looks to me like a new vector for
> information leakage into and out of the guest VM via guest
> controlled host page cache manipulation.
> 
> https://arxiv.org/pdf/1901.01161
> 
> I might be wrong, but if I'm not we're going to have to be very
> careful about how guest VMs can access and manipulate host side
> resources like the page cache.....

Right. Thinking about this I would be more concerned about the fact that
guest can effectively pin amount of host's page cache upto size of the
device/file passed to guest as PMEM, can't it Pankaj? Or is there some QEMU
magic that avoids this?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
