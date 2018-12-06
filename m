Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2938DC65BAF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF00B20989
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:33:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF00B20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbeLFVcs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 16:32:48 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41154 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726200AbeLFVcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 16:32:24 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wB6LToPu138628
        for <linux-kernel@vger.kernel.org>; Thu, 6 Dec 2018 16:32:22 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2p7bdd92gg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 16:32:22 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Thu, 6 Dec 2018 21:32:20 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 6 Dec 2018 21:32:16 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wB6LWF5v64815120
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 6 Dec 2018 21:32:15 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B446C42045;
        Thu,  6 Dec 2018 21:32:15 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7DDC542042;
        Thu,  6 Dec 2018 21:32:14 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.206.110])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  6 Dec 2018 21:32:14 +0000 (GMT)
Date:   Thu, 6 Dec 2018 23:32:12 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jann Horn <jannh@google.com>, Peter Xu <peterx@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH 1/1] userfaultfd: check VM_MAYWRITE was set after
 verifying the uffd is registered
References: <20181206212028.18726-1-aarcange@redhat.com>
 <20181206212028.18726-2-aarcange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181206212028.18726-2-aarcange@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18120621-0020-0000-0000-000002F3A712
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18120621-0021-0000-0000-00002143B9BB
Message-Id: <20181206213212.GB7479@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-06_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812060180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 04:20:28PM -0500, Andrea Arcangeli wrote:
> Calling UFFDIO_UNREGISTER on virtual ranges not yet registered in uffd
> could trigger an harmless false positive WARN_ON. Check the vma is
> already registered before checking VM_MAYWRITE to shut off the
> false positive warning.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: 29ec90660d68 ("userfaultfd: shmem/hugetlbfs: only allow to register VM_MAYWRITE vmas")
> Reported-by: syzbot+06c7092e7d71218a2c16@syzkaller.appspotmail.com
> Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  fs/userfaultfd.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index cd58939dc977..7a85e609fc27 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -1566,7 +1566,6 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
>  		cond_resched();
> 
>  		BUG_ON(!vma_can_userfault(vma));
> -		WARN_ON(!(vma->vm_flags & VM_MAYWRITE));
> 
>  		/*
>  		 * Nothing to do: this vma is already registered into this
> @@ -1575,6 +1574,8 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
>  		if (!vma->vm_userfaultfd_ctx.ctx)
>  			goto skip;
> 
> +		WARN_ON(!(vma->vm_flags & VM_MAYWRITE));
> +
>  		if (vma->vm_start > start)
>  			start = vma->vm_start;
>  		vma_end = min(end, vma->vm_end);
> 

-- 
Sincerely yours,
Mike.

