Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADD2C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F657204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:20:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F657204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbeJSBWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 21:22:11 -0400
Received: from smtprelay0122.hostedemail.com ([216.40.44.122]:45880 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726444AbeJSBWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 21:22:11 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 64720182CF671;
        Thu, 18 Oct 2018 17:20:13 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: ball44_1ed36987a3056
X-Filterd-Recvd-Size: 1774
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Thu, 18 Oct 2018 17:20:11 +0000 (UTC)
Message-ID: <5cfa9ed2b8eee3622715a7c0c62b09461dea607c.camel@perches.com>
Subject: Re: [PATCH] drivers/vfio: Fix an 8-byte alignment issue
From:   Joe Perches <joe@perches.com>
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Kangjie Lu <kjlu@umn.edu>,
        Alex Williamson <alex.williamson@redhat.com>,
        "open list:VFIO DRIVER" <kvm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Thu, 18 Oct 2018 10:20:10 -0700
In-Reply-To: <1539800299-2787-1-git-send-email-wang6495@umn.edu>
References: <1539800299-2787-1-git-send-email-wang6495@umn.edu>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-10-17 at 13:18 -0500, Wenwen Wang wrote:
> This patch adds a 4-byte reserved field in the structure
> vfio_eeh_pe_op to make sure that the u64 fields in the structure
> vfio_eeh_pe_err are 8-byte aligned.
> 
> Signed-off-by: Wenwen Wang <wang6495@umn.edu>
> ---
>  include/uapi/linux/vfio.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 1aa7b82..3e71ded 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -729,6 +729,7 @@ struct vfio_eeh_pe_op {
>  	__u32 argsz;
>  	__u32 flags;
>  	__u32 op;
> +	__u32 __res;
>  	union {
>  		struct vfio_eeh_pe_err err;
>  	};

Why use an anonymous union for a single element?
Why not make struct vfio_eeh_pe_err __aligned(8)?
Why not make the u64 structure elements of
struct ufio_eeh_pe_err __aligned_u64?


