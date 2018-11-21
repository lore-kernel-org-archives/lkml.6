Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6887CC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 17:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34E2721731
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 17:42:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34E2721731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732525AbeKVESF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 23:18:05 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34532 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729279AbeKVESE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 23:18:04 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wALHdLWX065416
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 12:42:44 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2nwae2ccsv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 12:42:43 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Wed, 21 Nov 2018 17:42:42 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 21 Nov 2018 17:42:40 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wALHgdrR786864
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 21 Nov 2018 17:42:39 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 38F904203F;
        Wed, 21 Nov 2018 17:42:39 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A20124204B;
        Wed, 21 Nov 2018 17:42:38 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.207.68])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 21 Nov 2018 17:42:38 +0000 (GMT)
Date:   Wed, 21 Nov 2018 18:42:36 +0100
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] userfaultfd: convert userfaultfd_ctx::refcount to
 refcount_t
References: <20181115003916.63381-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181115003916.63381-1-ebiggers@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18112117-4275-0000-0000-000002E4A2CC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112117-4276-0000-0000-000037F1CF55
Message-Id: <20181121174236.GA5704@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-21_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811210153
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 04:39:16PM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Reference counters should use refcount_t rather than atomic_t, since the
> refcount_t implementation can prevent overflows, reducing the
> exploitability of reference leak bugs.  userfaultfd_ctx::refcount is a
> reference counter with the usual semantics, so convert it to refcount_t.
> 
> Note: I replaced the BUG() on incrementing a 0 refcount with just
> refcount_inc(), since part of the semantics of refcount_t is that that
> incrementing a 0 refcount is not allowed; with CONFIG_REFCOUNT_FULL,
> refcount_inc() already checks for it and warns.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  fs/userfaultfd.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index 356d2b8568c14..8375faac2790d 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -53,7 +53,7 @@ struct userfaultfd_ctx {
>  	/* a refile sequence protected by fault_pending_wqh lock */
>  	struct seqcount refile_seq;
>  	/* pseudo fd refcounting */
> -	atomic_t refcount;
> +	refcount_t refcount;
>  	/* userfaultfd syscall flags */
>  	unsigned int flags;
>  	/* features requested from the userspace */
> @@ -140,8 +140,7 @@ static int userfaultfd_wake_function(wait_queue_entry_t *wq, unsigned mode,
>   */
>  static void userfaultfd_ctx_get(struct userfaultfd_ctx *ctx)
>  {
> -	if (!atomic_inc_not_zero(&ctx->refcount))
> -		BUG();
> +	refcount_inc(&ctx->refcount);
>  }
> 
>  /**
> @@ -154,7 +153,7 @@ static void userfaultfd_ctx_get(struct userfaultfd_ctx *ctx)
>   */
>  static void userfaultfd_ctx_put(struct userfaultfd_ctx *ctx)
>  {
> -	if (atomic_dec_and_test(&ctx->refcount)) {
> +	if (refcount_dec_and_test(&ctx->refcount)) {
>  		VM_BUG_ON(spin_is_locked(&ctx->fault_pending_wqh.lock));
>  		VM_BUG_ON(waitqueue_active(&ctx->fault_pending_wqh));
>  		VM_BUG_ON(spin_is_locked(&ctx->fault_wqh.lock));
> @@ -686,7 +685,7 @@ int dup_userfaultfd(struct vm_area_struct *vma, struct list_head *fcs)
>  			return -ENOMEM;
>  		}
> 
> -		atomic_set(&ctx->refcount, 1);
> +		refcount_set(&ctx->refcount, 1);
>  		ctx->flags = octx->flags;
>  		ctx->state = UFFD_STATE_RUNNING;
>  		ctx->features = octx->features;
> @@ -1911,7 +1910,7 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
>  	if (!ctx)
>  		return -ENOMEM;
> 
> -	atomic_set(&ctx->refcount, 1);
> +	refcount_set(&ctx->refcount, 1);
>  	ctx->flags = flags;
>  	ctx->features = 0;
>  	ctx->state = UFFD_STATE_WAIT_API;
> -- 
> 2.19.1.930.g4563a0d9d0-goog
> 

-- 
Sincerely yours,
Mike.

