Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B880C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D13D20851
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:51:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D13D20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728658AbeLJRv2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 12:51:28 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38910 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727567AbeLJRv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 12:51:27 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBAHnYkg008151
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 12:51:26 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2p9tnyycm9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 12:51:25 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Mon, 10 Dec 2018 17:51:23 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 10 Dec 2018 17:51:20 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBAHpJIV53149934
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 10 Dec 2018 17:51:19 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 43733AE055;
        Mon, 10 Dec 2018 17:51:19 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 45505AE04D;
        Mon, 10 Dec 2018 17:51:18 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.204.5])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 10 Dec 2018 17:51:18 +0000 (GMT)
Date:   Mon, 10 Dec 2018 19:51:16 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Pravin Shedge <pravin.shedge4linux@gmail.com>,
        linux-mm@kvack.org
Subject: Re: [PATCH] userfaultfd: clear flag if remap event not enabled
References: <20181210065121.14984-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181210065121.14984-1-peterx@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18121017-0028-0000-0000-0000032897D7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121017-0029-0000-0000-000023E4BACD
Message-Id: <20181210175115.GB6380@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-10_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=892 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812100160
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 02:51:21PM +0800, Peter Xu wrote:
> When the process being tracked do mremap() without
> UFFD_FEATURE_EVENT_REMAP on the corresponding tracking uffd file
> handle, we should not generate the remap event, and at the same
> time we should clear all the uffd flags on the new VMA.  Without
> this patch, we can still have the VM_UFFD_MISSING|VM_UFFD_WP
> flags on the new VMA even the fault handling process does not
> even know the existance of the VMA.
> 
> CC: Andrea Arcangeli <aarcange@redhat.com>
> CC: Andrew Morton <akpm@linux-foundation.org>
> CC: Mike Rapoport <rppt@linux.vnet.ibm.com>
> CC: Kirill A. Shutemov <kirill@shutemov.name>
> CC: Hugh Dickins <hughd@google.com>
> CC: Pavel Emelyanov <xemul@virtuozzo.com>
> CC: Pravin Shedge <pravin.shedge4linux@gmail.com>
> CC: linux-mm@kvack.org
> CC: linux-kernel@vger.kernel.org
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  fs/userfaultfd.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index cd58939dc977..798ae8a438ff 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -740,6 +740,9 @@ void mremap_userfaultfd_prep(struct vm_area_struct *vma,
>  		vm_ctx->ctx = ctx;
>  		userfaultfd_ctx_get(ctx);
>  		WRITE_ONCE(ctx->mmap_changing, true);
> +	} else if (ctx) {
> +		vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
> +		vma->vm_flags &= ~(VM_UFFD_WP | VM_UFFD_MISSING);

My preference would be 

	if (!ctx)
		return;
	
	if (ctx->features & UFFD_FEATURE_EVENT_REMAP) {
		...
	} else {
		...
	}

but I don't feel strongly about it.

I'd appreciate a comment in the code and with it 

Acked-by: Mike Rapoport <rppt@linux.ibm.com>


>  	}
>  }
> 
> -- 
> 2.17.1
> 

-- 
Sincerely yours,
Mike.

