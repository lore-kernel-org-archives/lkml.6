Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29FC9C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6E7D20890
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:13:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6E7D20890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388407AbeGXRUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 13:20:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41866 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388319AbeGXRUY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 13:20:24 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0CE32402243B;
        Tue, 24 Jul 2018 16:13:11 +0000 (UTC)
Received: from [10.10.123.162] (ovpn-123-162.rdu2.redhat.com [10.10.123.162])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3C5352026D68;
        Tue, 24 Jul 2018 16:13:08 +0000 (UTC)
Subject: Re: [RFC v3] qemu: Add virtio pmem device
To:     Pankaj Gupta <pagupta@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, qemu-devel@nongnu.org,
        linux-nvdimm@ml01.01.org
References: <20180713075232.9575-1-pagupta@redhat.com>
 <20180713075232.9575-4-pagupta@redhat.com>
Cc:     jack@suse.cz, stefanha@redhat.com, dan.j.williams@intel.com,
        riel@surriel.com, haozhong.zhang@intel.com, nilal@redhat.com,
        kwolf@redhat.com, pbonzini@redhat.com, ross.zwisler@intel.com,
        david@redhat.com, xiaoguangrong.eric@gmail.com, hch@infradead.org,
        mst@redhat.com, niteshnarayanlal@hotmail.com,
        lcapitulino@redhat.com, imammedo@redhat.com
From:   Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <783786ae-2e85-2376-448c-1e362c3d4d48@redhat.com>
Date:   Tue, 24 Jul 2018 11:13:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180713075232.9575-4-pagupta@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Tue, 24 Jul 2018 16:13:11 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Tue, 24 Jul 2018 16:13:11 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'eblake@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/13/2018 02:52 AM, Pankaj Gupta wrote:
>   This patch adds virtio-pmem Qemu device.
> 
>   This device presents memory address range information to guest
>   which is backed by file backend type. It acts like persistent
>   memory device for KVM guest. Guest can perform read and persistent
>   write operations on this memory range with the help of DAX capable
>   filesystem.
> 
>   Persistent guest writes are assured with the help of virtio based
>   flushing interface. When guest userspace space performs fsync on
>   file fd on pmem device, a flush command is send to Qemu over VIRTIO
>   and host side flush/sync is done on backing image file.
> 
> Changes from RFC v2:

This patch has no n/M in the subject line; but is included in a thread 
that also has a 0/2 cover letter, as well as 1/2 and 2/2 patches in 
separate mails.  Is that intentional?

When sending revision notes on a specific patch, it's best to place them...

> - Use aio_worker() to avoid Qemu from hanging with blocking fsync
>    call - Stefan
> - Use virtio_st*_p() for endianess - Stefan
> - Correct indentation in qapi/misc.json - Eric
> 
> Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> ---

...here, after the --- separator. They are useful to reviewers on the 
list, but are stripped by 'git am' as they don't need to be part of the 
git history (a year from now, we won't care how many iterations the 
patch went through during review, only what actually landed).


> +++ b/qapi/misc.json
> @@ -2907,6 +2907,29 @@
>             }
>   }
>   
> +##
> +# @VirtioPMemDeviceInfo:
> +#
> +# VirtioPMem state information
> +#
> +# @id: device's ID
> +#
> +# @start: physical address, where device is mapped
> +#
> +# @size: size of memory that the device provides
> +#
> +# @memdev: memory backend linked with device
> +#
> +# Since: 2.13

There is no 2.13 release, and you've missed the 3.0 window.  Please 
update this and any other version reference to 3.1.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
