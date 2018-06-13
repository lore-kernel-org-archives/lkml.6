Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 272FAC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 20:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1E1C208C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 20:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eeZf0Oa4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1E1C208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935726AbeFMUCk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 16:02:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:59230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935291AbeFMUCj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 16:02:39 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B79C208C4;
        Wed, 13 Jun 2018 20:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528920159;
        bh=HQyIVFs7KptU7wVdTQh3UAS5W4wtoPEcxhnI1kc7Dy8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eeZf0Oa4ILJwinXx8wieZR3r4lPNczkqeSXzfWLzHkVDfnXeBY6crImgEwtiHXOIS
         zn6VU/S3twE9bG/+3sWoiAoI1AKFs90/XS0OLbAkXsD2vp0rIqxVMptVqQSRZ9Vw41
         zOU6kIfYmjomWQKcRWzCs927PCIL7CFjnNVHQjR0=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id B7F501450F4; Wed, 13 Jun 2018 17:02:36 -0300 (-03)
Date:   Wed, 13 Jun 2018 17:02:36 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf intel-pt: Fix packet decoding of CYC packets
Message-ID: <20180613200236.GG2686@kernel.org>
References: <1528371002-8862-1-git-send-email-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528371002-8862-1-git-send-email-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jun 07, 2018 at 02:30:02PM +0300, Adrian Hunter escreveu:
> Use a 64-bit type so that the cycle count is not limited to 32-bits.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> Cc: stable@vger.kernel.org

Thanks, applied.

- Arnaldo

> ---
>  tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c
> index ba4c9dd18643..d426761a549d 100644
> --- a/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c
> +++ b/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c
> @@ -366,7 +366,7 @@ static int intel_pt_get_cyc(unsigned int byte, const unsigned char *buf,
>  		if (len < offs)
>  			return INTEL_PT_NEED_MORE_BYTES;
>  		byte = buf[offs++];
> -		payload |= (byte >> 1) << shift;
> +		payload |= ((uint64_t)byte >> 1) << shift;
>  	}
>  
>  	packet->type = INTEL_PT_CYC;
> -- 
> 1.9.1
