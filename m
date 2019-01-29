Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF96C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 16:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C66521852
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 16:09:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="AGiD8rla"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbfA2QJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 11:09:34 -0500
Received: from mail.skyhub.de ([5.9.137.197]:34486 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbfA2QJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 11:09:33 -0500
Received: from zn.tnic (p200300EC2BCC5400E03D356D4AA330A5.dip0.t-ipconnect.de [IPv6:2003:ec:2bcc:5400:e03d:356d:4aa3:30a5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C13451EC03D8;
        Tue, 29 Jan 2019 17:09:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1548778171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=x8kSoUID2rgrVCoR8ywBl5J1z5kvh0UvKxeFcFas9zs=;
        b=AGiD8rlaKH8UaXiv4AkO9CeRVqxorJnv5UtHtzbRA8u79/+9EIcg9IX3W/+0styZ9DaKO3
        uplzH3iifayo0vFbsrRvrGd1uHfdy8zZLRYJk4ObzL9ENTWyRng1C06FXCyRwfDA6zzDSp
        yZBVCU1l0B64h2WGvemL4ztp1k+JOYU=
Date:   Tue, 29 Jan 2019 17:09:28 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] EDAC, skx_comm_edac: Separate common codes from the
 skx_edac driver
Message-ID: <20190129160928.GB27037@zn.tnic>
References: <20190125195902.17109-1-tony.luck@intel.com>
 <20190125195902.17109-2-tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190125195902.17109-2-tony.luck@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 11:58:59AM -0800, Tony Luck wrote:
> From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> 
> Part of the skx_edac driver codes are also used for Intel 10nm server
> EDAC driver. Carve out the common part from the skx_edac driver in
> preparation to support both skx_edac driver and i10nm_edac driver.
> 
> Co-developed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  drivers/edac/skx_comm_edac.c | 693 +++++++++++++++++++++++++++++++++++
>  drivers/edac/skx_comm_edac.h | 158 ++++++++
>  2 files changed, 851 insertions(+)
>  create mode 100644 drivers/edac/skx_comm_edac.c
>  create mode 100644 drivers/edac/skx_comm_edac.h

skx_common.[ch]

> diff --git a/drivers/edac/skx_comm_edac.h b/drivers/edac/skx_comm_edac.h
> new file mode 100644
> index 000000000000..f7618a9cc0ae
> --- /dev/null
> +++ b/drivers/edac/skx_comm_edac.h
> @@ -0,0 +1,158 @@
> +// SPDX-License-Identifier: GPL-2.0

If you guys would've used checkpatch, you would've seen:

WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
#739: FILE: drivers/edac/skx_comm_edac.h:1:
+// SPDX-License-Identifier: GPL-2.0

Needs to be /* ... */ in a header.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
