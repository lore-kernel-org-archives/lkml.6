Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 198B7C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 22:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8624320837
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 22:56:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8624320837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732420AbeHOBpy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 21:45:54 -0400
Received: from mga04.intel.com ([192.55.52.120]:31857 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729652AbeHOBpy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 21:45:54 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Aug 2018 15:56:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,240,1531810800"; 
   d="scan'208";a="80317844"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.44])
  by fmsmga004.fm.intel.com with ESMTP; 14 Aug 2018 15:56:31 -0700
Date:   Tue, 14 Aug 2018 16:57:16 -0600
From:   Keith Busch <keith.busch@linux.intel.com>
To:     Michal Wnukowski <wnukowski@google.com>
Cc:     Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Keith Busch <keith.busch@intel.com>, yigitfiliz@google.com,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] Bugfix for handling of shadow doorbell buffer.
Message-ID: <20180814225716.GA3224@localhost.localdomain>
References: <20180814221735.62804-1-wnukowski@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180814221735.62804-1-wnukowski@google.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 03:17:35PM -0700, Michal Wnukowski wrote:
>  /* Update dbbuf and return true if an MMIO is required */
>  static bool nvme_dbbuf_update_and_check_event(u16 value, u32 *dbbuf_db,
> -					      volatile u32 *dbbuf_ei)
> +					      u32 *dbbuf_ei)
>  {
>  	if (dbbuf_db) {
>  		u16 old_value;
> @@ -306,6 +306,12 @@ static bool nvme_dbbuf_update_and_check_event(u16 value, u32 *dbbuf_db,
>  		old_value = *dbbuf_db;
>  		*dbbuf_db = value;
>  
> +		/*
> +		 * Ensure that the doorbell is updated before reading
> +		 * the EventIdx from memory
> +		 */
> +		mb();
> +
>  		if (!nvme_dbbuf_need_event(*dbbuf_ei, value, old_value))
>  			return false;
>  	}

You just want to ensure the '*dbbuf_db = value' isn't reordered, right?
The order dependency might be more obvious if done as:

	WRITE_ONCE(*dbbuf_db, value);

  	if (!nvme_dbbuf_need_event(READ_ONCE(*dbbuf_ei), value, old_value))
  		return false;

And 'volatile' is again redundant.
