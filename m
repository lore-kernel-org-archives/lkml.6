Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B11C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 18:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDA942695E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 18:48:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDA942695E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755039AbeFZSs3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 14:48:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39088 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751901AbeFZSs2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 14:48:28 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3F02E401EF14;
        Tue, 26 Jun 2018 18:48:27 +0000 (UTC)
Received: from localhost (unknown [10.18.25.149])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5D897111763E;
        Tue, 26 Jun 2018 18:48:25 +0000 (UTC)
Date:   Tue, 26 Jun 2018 14:48:25 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Ross Zwisler <ross.zwisler@linux.intel.com>
Cc:     Toshi Kani <toshi.kani@hpe.com>, dm-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v3 0/3] Fix DM DAX handling
Message-ID: <20180626184824.GA7114@redhat.com>
References: <20180626175932.8899-1-ross.zwisler@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626175932.8899-1-ross.zwisler@linux.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Tue, 26 Jun 2018 18:48:27 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Tue, 26 Jun 2018 18:48:27 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'msnitzer@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26 2018 at  1:59pm -0400,
Ross Zwisler <ross.zwisler@linux.intel.com> wrote:

> This series fixes a few issues that I found with DM's handling of DAX
> devices.  Here are some of the issues I found:
> 
>  * We can create a dm-stripe or dm-linear device which is made up of an
>    fsdax PMEM namespace and a raw PMEM namespace but which can hold a
>    filesystem mounted with the -o dax mount option.  DAX operations to
>    the raw PMEM namespace part lack struct page and can fail in
>    interesting/unexpected ways when doing things like fork(), examining
>    memory with gdb, etc.
> 
>  * We can create a dm-stripe or dm-linear device which is made up of an
>    fsdax PMEM namespace and a BRD ramdisk which can hold a filesystem
>    mounted with the -o dax mount option.  All I/O to this filesystem
>    will fail.
> 
> ---
> 
> Changes since v2:
>   * Only set QUEUE_FLAG_DAX for fsdax mode PMEM namespaces. (Mike)
>   * Check for QUEUE_FLAG_DAX in __bdev_dax_supported(). (Mike)
>   * Get rid of DM_TYPE_DAX_BIO_BASED reworks. (Mike)
>   * Dropped the first 2 prep patches of v2 since they were merged for
>     v4.18-rc1.  (Thanks, Darrick!)
> 
> ---
> 
> Mike, can you take this series through your tree?
> 
> Personally I think this should be treated as a bug fix and merged in the
> v4.18-rc* series.

I'd be fine with staging it for 4.18.  Only question is whether others
are fine with the dax patch (and me being the one to get it to Linus)?

I already replied to the 3rd patch with some feedback for v4 (but I can
also take care of those changes if I'm the one to stage these changes).

Maybe if Dan and/or others could provide their review for both the dax
and pmem patches?  If I can get review on those I'll get the series
staged for Linus to pull this week.

Thanks,
Mike
