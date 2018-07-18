Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13FB8ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 05:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B525B20693
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 05:13:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B525B20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbeGRFti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 01:49:38 -0400
Received: from nautica.notk.org ([91.121.71.147]:44996 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726080AbeGRFti (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 01:49:38 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 4B72AC009; Wed, 18 Jul 2018 07:13:36 +0200 (CEST)
Date:   Wed, 18 Jul 2018 07:13:21 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Tomas Bortoli <tomasbortoli@gmail.com>
Cc:     ericvh@gmail.com, rminnich@sandia.gov, lucho@ionkov.net,
        viro@ZenIV.linux.org.uk, davem@davemloft.net,
        v9fs-developer@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller@googlegroups.com
Subject: Re: [V9fs-developer] [PATCH] p9_parse_header() validate PDU length
Message-ID: <20180718051321.GB16605@nautica>
References: <20180712110211.25535-1-tomasbortoli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180712110211.25535-1-tomasbortoli@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tomas Bortoli wrote on Thu, Jul 12, 2018:
> This patch adds checks to the p9_parse_header() function to
> verify that the length found within the header coincides with the actual
> length of the PDU. Furthermore, it checks that the length stays within the
> acceptable range. To do this the patch brings the actual length of the PDU
> from the different transport layers (rdma and virtio). For TCP (trans_fd.c)
> the length is not know before, so we get it from the header but we check it
> anyway that it's within the valid range.
> 
> Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
> Reported-by: syzbot+65c6b72f284a39d416b4@syzkaller.appspotmail.com
> ---
> [..]
> @@ -498,6 +489,21 @@ p9_parse_header(struct p9_fcall *pdu, int32_t *size, int8_t *type, int16_t *tag,
>  	if (size)
>  		*size = r_size;
>  
> +	if (pdu->size != r_size) {
> +		err = -EINVAL;
> +		goto rewind_and_exit;
> +	}
> +	if (pdu->size >= pdu->capacity || pdu->size < 7) {
> +		p9_debug(P9_DEBUG_ERROR,
> +			 "requested packet size too big or too small: %d\n",
> +			 pdu->size);
> +		return -EIO;
> +	}

Actually, I've been bad advice - this breaks on virtio with zc packets -
a read or ls in a big directory fails with this in dmesg
[ 1006.853775] 9pnet: -- p9_parse_header (17123): requested packet size too big or too small: 4306
[ 1006.853780] 9pnet: -- p9_check_zc_errors (17123): couldn't parse header -5

I haven't given this any thought yet, but dropping the patch for now

-- 
Dominique
