Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3908C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 22:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 784CC2075A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 22:06:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 784CC2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935908AbeFRWGC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 18:06:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36532 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755347AbeFRWFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 18:05:49 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E53E240201A2;
        Mon, 18 Jun 2018 22:05:48 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 69078111CB8C;
        Mon, 18 Jun 2018 22:05:48 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libnvdimm, pmem: Fix memcpy_mcsafe() return code handling in nsio_rw_bytes()
References: <152934432951.24427.11070204367866836632.stgit@dwillia2-desk3.amr.corp.intel.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Date:   Mon, 18 Jun 2018 18:05:48 -0400
In-Reply-To: <152934432951.24427.11070204367866836632.stgit@dwillia2-desk3.amr.corp.intel.com>
        (Dan Williams's message of "Mon, 18 Jun 2018 10:52:09 -0700")
Message-ID: <x49bmc792df.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Mon, 18 Jun 2018 22:05:48 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Mon, 18 Jun 2018 22:05:48 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jmoyer@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Williams <dan.j.williams@intel.com> writes:

> Commit 60622d68227d "x86/asm/memcpy_mcsafe: Return bytes remaining"
> converted callers of memcpy_mcsafe() to expect a positive 'bytes
> remaining' value rather than a negative error code. The nsio_rw_bytes()
> conversion failed to return success. The failure is benign in that
> nsio_rw_bytes() will end up writing back what it just read.
>
> Fixes: 60622d68227d ("x86/asm/memcpy_mcsafe: Return bytes remaining")
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/nvdimm/claim.c |    1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/nvdimm/claim.c b/drivers/nvdimm/claim.c
> index 2e96b34bc936..fb667bf469c7 100644
> --- a/drivers/nvdimm/claim.c
> +++ b/drivers/nvdimm/claim.c
> @@ -278,6 +278,7 @@ static int nsio_rw_bytes(struct nd_namespace_common *ndns,
>  			return -EIO;
>  		if (memcpy_mcsafe(buf, nsio->addr + offset, size) != 0)
>  			return -EIO;
> +		return 0;
>  	}
>  
>  	if (unlikely(is_bad_pmem(&nsio->bb, sector, sz_align))) {

Reviewed-by: Jeff Moyer <jmoyer@redhat.com>
