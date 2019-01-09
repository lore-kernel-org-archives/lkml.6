Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66FC4C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39808206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:54:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732149AbfAIOy3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 09:54:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:30136 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731733AbfAIOy2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 09:54:28 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 99030C0C4275;
        Wed,  9 Jan 2019 14:54:27 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 86DA4620D5;
        Wed,  9 Jan 2019 14:54:20 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id F0F4F3F600;
        Wed,  9 Jan 2019 14:54:19 +0000 (UTC)
Date:   Wed, 9 Jan 2019 09:54:19 -0500 (EST)
From:   Pankaj Gupta <pagupta@redhat.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        qemu-devel@nongnu.org, linux-nvdimm@ml01.01.org,
        linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-acpi@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, stefanha@redhat.com,
        dan j williams <dan.j.williams@intel.com>, riel@surriel.com,
        nilal@redhat.com, kwolf@redhat.com, pbonzini@redhat.com,
        zwisler@kernel.org, vishal l verma <vishal.l.verma@intel.com>,
        dave jiang <dave.jiang@intel.com>, david@redhat.com,
        jmoyer@redhat.com,
        xiaoguangrong eric <xiaoguangrong.eric@gmail.com>,
        hch@infradead.org, mst@redhat.com, jasowang@redhat.com,
        lcapitulino@redhat.com, imammedo@redhat.com, eblake@redhat.com,
        willy@infradead.org, tytso@mit.edu,
        adilger kernel <adilger.kernel@dilger.ca>,
        darrick wong <darrick.wong@oracle.com>, rjw@rjwysocki.net
Message-ID: <1413703615.61223613.1547045659656.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190109144215.GI15397@quack2.suse.cz>
References: <20190109135606.15401-1-pagupta@redhat.com> <20190109144215.GI15397@quack2.suse.cz>
Subject: Re: [PATCH v3 4/5] ext4: disable map_sync for virtio pmem
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.65.161.12, 10.4.195.15]
Thread-Topic: ext4: disable map_sync for virtio pmem
Thread-Index: 8LCqfLuGXGXi907GKJOrCBv1J6wJTA==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Wed, 09 Jan 2019 14:54:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> On Wed 09-01-19 19:26:05, Pankaj Gupta wrote:
> > Virtio pmem provides asynchronous host page cache flush
> > mechanism. We don't support 'MAP_SYNC' with virtio pmem
> > and ext4.
> > 
> > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> ...
> > @@ -371,6 +373,13 @@ static int ext4_file_mmap(struct file *file, struct
> > vm_area_struct *vma)
> >  	if (!IS_DAX(file_inode(file)) && (vma->vm_flags & VM_SYNC))
> >  		return -EOPNOTSUPP;
> >  
> > +	/* We don't support synchronous mappings with guest direct access
> > +	 * and virtio based host page cache flush mechanism.
> > +	 */
> > +	if (IS_DAX(file_inode(file)) && virtio_pmem_host_cache_enabled(dax_dev)
> > +						&& (vma->vm_flags & VM_SYNC))
> > +		return -EOPNOTSUPP;
> > +
> 
> Shouldn't there rather be some generic way of doing this? Having
> virtio_pmem_host_cache_enabled() check in filesystem code just looks like
> filesystem sniffing into details is should not care about... Maybe just
> naming this (or having a wrapper) dax_dev_map_sync_supported()?

Thanks for the feedback.

Just wanted to avoid 'dax' in function name just to differentiate this with real dax.
But yes can add a wrapper: dax_dev_map_sync_supported()

Thanks,
Pankaj
