Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF3BC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37D6720685
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NZAtybWC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbfAITPb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 14:15:31 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:41030 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbfAITPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 14:15:30 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x09GOJcC021815;
        Wed, 9 Jan 2019 16:27:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=ZODaZcJHEihwM2lM5+LCehIzLXVvDrvodH3oT3bqgeI=;
 b=NZAtybWCH3l0grJGKaxK4PESOGhDvLOybyr+k/48PFeWTJI3uyzZsVrXUMqGu5wQ1yhX
 1yqo25wM7bfcXo34Wr8Nh0ZuhWoP7r8sJPT/A4sHzBoCU2Ulc0S0if9DNoH3e+0dwsQW
 IMuLbZ3DE/KUFgBHGZ6kR+xTNj8SxPpBgkyn3tZBuZ/Lx8d+vsPu0l1ANaL/kJlQS2zo
 4NxRJQHfANgVbXnZNV+MRn9ayd+M+L2GQocfV8ginqNjb8gFiaP7/QKAsEgwUR7eflGU
 +JlB0y1xPMpWdtaDbJxUYLjjWlo0tRBoWPalanT2Iz44YRiZrZ05VF5dj3iCSZsiPAKt +A== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2ptj3e2jvq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Jan 2019 16:27:01 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x09GQxgU015883
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Jan 2019 16:26:59 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x09GQvdw017959;
        Wed, 9 Jan 2019 16:26:57 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 09 Jan 2019 08:26:57 -0800
Date:   Wed, 9 Jan 2019 08:26:54 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Pankaj Gupta <pagupta@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        qemu-devel@nongnu.org, linux-nvdimm@ml01.01.org,
        linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-acpi@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, jack@suse.cz, stefanha@redhat.com,
        dan.j.williams@intel.com, riel@surriel.com, nilal@redhat.com,
        kwolf@redhat.com, pbonzini@redhat.com, zwisler@kernel.org,
        vishal.l.verma@intel.com, dave.jiang@intel.com, david@redhat.com,
        jmoyer@redhat.com, xiaoguangrong.eric@gmail.com, hch@infradead.org,
        mst@redhat.com, jasowang@redhat.com, lcapitulino@redhat.com,
        imammedo@redhat.com, eblake@redhat.com, willy@infradead.org,
        tytso@mit.edu, adilger.kernel@dilger.ca, rjw@rjwysocki.net
Subject: Re: [PATCH v3 5/5] xfs: disable map_sync for virtio pmem
Message-ID: <20190109162654.GW12689@magnolia>
References: <20190109144736.17452-1-pagupta@redhat.com>
 <20190109144736.17452-6-pagupta@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190109144736.17452-6-pagupta@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9130 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=639
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901090136
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 08:17:36PM +0530, Pankaj Gupta wrote:
> Virtio pmem provides asynchronous host page cache flush
> mechanism. we don't support 'MAP_SYNC' with virtio pmem 
> and xfs.
> 
> Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> ---
>  fs/xfs/xfs_file.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index e474250..eae4aa4 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -1190,6 +1190,14 @@ xfs_file_mmap(
>  	if (!IS_DAX(file_inode(filp)) && (vma->vm_flags & VM_SYNC))
>  		return -EOPNOTSUPP;
>  
> +	/* We don't support synchronous mappings with guest direct access
> +	 * and virtio based host page cache mechanism.
> +	 */
> +	if (IS_DAX(file_inode(filp)) && virtio_pmem_host_cache_enabled(

Echoing what Jan said, this ought to be some sort of generic function
that tells us whether or not memory mapped from the dax device will
always still be accessible even after a crash (i.e. supports MAP_SYNC).

What if the underlying file on the host is itself on pmem and can be
MAP_SYNC'd?  Shouldn't the guest be able to use MAP_SYNC as well?

--D

> +		xfs_find_daxdev_for_inode(file_inode(filp))) &&
> +					(vma->vm_flags & VM_SYNC))
> +		return -EOPNOTSUPP;
> +
>  	file_accessed(filp);
>  	vma->vm_ops = &xfs_file_vm_ops;
>  	if (IS_DAX(file_inode(filp)))
> -- 
> 2.9.3
> 
