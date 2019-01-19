Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F9F6C61CE4
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 17:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDDFE2084C
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 17:16:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbfASRP5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 12:15:57 -0500
Received: from bout01.mta.xmission.com ([166.70.11.15]:37630 "EHLO
        bout01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbfASRP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 12:15:56 -0500
Received: from mx04.mta.xmission.com ([166.70.13.214])
        by bout01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <sbauer@plzdonthack.me>)
        id 1gkuDq-0004zh-LR; Sat, 19 Jan 2019 10:15:54 -0700
Received: from plesk14-shared.xmission.com ([166.70.198.161] helo=plesk14.xmission.com)
        by mx04.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <sbauer@plzdonthack.me>)
        id 1gkuDq-0001yC-4t; Sat, 19 Jan 2019 10:15:54 -0700
Received: from hacktheplanet (unknown [73.58.156.101])
        by plesk14.xmission.com (Postfix) with ESMTPSA id F30372138AF;
        Sat, 19 Jan 2019 17:15:52 +0000 (UTC)
Date:   Sat, 19 Jan 2019 12:15:50 -0500
From:   Scott Bauer <sbauer@plzdonthack.me>
To:     David Kozub <zub@linux.fjfi.cvut.cz>
Cc:     linux-kernel@vger.kernel.org, axboe@kernel.dk, hch@infradead.org,
        jonathan.derrick@intel.com
Message-ID: <20190119171550.GB12171@hacktheplanet>
References: <1547760716-7304-12-git-send-email-zub@linux.fjfi.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547760716-7304-12-git-send-email-zub@linux.fjfi.cvut.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-XM-SPF: eid=1gkuDq-0001yC-4t;;;mid=<20190119171550.GB12171@hacktheplanet>;;;hst=mx04.mta.xmission.com;;;ip=166.70.198.161;;;frm=sbauer@plzdonthack.me;;;spf=none
X-SA-Exim-Connect-IP: 166.70.198.161
X-SA-Exim-Mail-From: sbauer@plzdonthack.me
Subject: Re: [PATCH v2 11/16] block: sed-opal: ioctl for writing to shadow mbr
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on mx04.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 09:31:51PM +0000, David Kozub wrote:
 
> +static int write_shadow_mbr(struct opal_dev *dev, void *data)
> +{
> +	struct opal_shadow_mbr *shadow = data;
> +	const u8 __user *src;
> +	u8 *dst;
> +	size_t off = 0;
> +	u64 len;
> +	int err = 0;
> +
> +	/* do the actual transmission(s) */
> +	src = (u8 *) shadow->data;
> +	while (off < shadow->size) {
> +		err = cmd_start(dev, opaluid[OPAL_MBR], opalmethod[OPAL_SET]);
> +		add_token_u8(&err, dev, OPAL_STARTNAME);
> +		add_token_u8(&err, dev, OPAL_WHERE);
> +		add_token_u64(&err, dev, shadow->offset + off);
> +		add_token_u8(&err, dev, OPAL_ENDNAME);
> +
> +		add_token_u8(&err, dev, OPAL_STARTNAME);
> +		add_token_u8(&err, dev, OPAL_VALUES);
> +
> +		/*
> +		 * The bytestring header is either 1 or 2 bytes, so assume 2.
> +		 * There also needs to be enough space to accommodate the
> +		 * trailing OPAL_ENDNAME (1 byte) and tokens added by
> +		 * cmd_finalize.
> +		 */
> +		len = min(remaining_size(dev) - (2+1+CMD_FINALIZE_BYTES_NEEDED),
> +			  (size_t)(shadow->size - off));

What if remaining_size(dev) <  2 + 1 + CMD_FINALIZE_BYTES_NEEDED? If that's possible we
get min(UINT_MAX(ish) , some size larger than our remaining buffer) and that's not good.


> +		pr_debug("MBR: write bytes %zu+%llu/%llu\n",
> +			 off, len, shadow->size);
> +
> +		dst = add_bytestring_header(&err, dev, len);
> +		if (!dst)
> +			break;
> +		if (copy_from_user(dst, src + off, len))
> +			err = -EFAULT;
> -- 
> 2.20.1
> 
> 
