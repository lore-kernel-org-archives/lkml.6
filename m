Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20FD1C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 14:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEB442148C
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 14:15:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEB442148C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391719AbeHPROF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 13:14:05 -0400
Received: from mga04.intel.com ([192.55.52.120]:28055 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726312AbeHPROF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 13:14:05 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Aug 2018 07:15:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,247,1531810800"; 
   d="scan'208";a="83855657"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.44])
  by orsmga002.jf.intel.com with ESMTP; 16 Aug 2018 07:15:11 -0700
Date:   Thu, 16 Aug 2018 08:15:59 -0600
From:   Keith Busch <keith.busch@intel.com>
To:     Michal Wnukowski <wnukowski@google.com>
Cc:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        "keith.busch@linux.intel.com" <keith.busch@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "yigitfiliz@google.com" <yigitfiliz@google.com>
Subject: Re: [PATCH v2] Bugfix for handling of shadow doorbell buffer.
Message-ID: <20180816141558.GB5438@localhost.localdomain>
References: <CA+55aFxOc7_s-BbWJx-kyit-pH9m5fQJk6MSMJ57tFFvMtNh-w@mail.gmail.com>
 <20180815225157.89523-1-wnukowski@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180815225157.89523-1-wnukowski@google.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 03:51:57PM -0700, Michal Wnukowski wrote:
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 17a0190bd88f..4452f8553301 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -306,6 +306,14 @@ static bool nvme_dbbuf_update_and_check_event(u16 value, u32 *dbbuf_db,
>  		old_value = *dbbuf_db;
>  		*dbbuf_db = value;
>  
> +		/*
> +		 * Ensure that the doorbell is updated before reading
> +		 * the EventIdx from memory. NVMe controller should have
> +		 * similar ordering guarantees - update EventIdx before
> +		 * reading doorbell.
> +		 */
> +		mb();
> +
>  		if (!nvme_dbbuf_need_event(*dbbuf_ei, value, old_value))
>  			return false;
>  	}

Looks good to me. This should also be a stable candidate.

Reviewed-by: Keith Busch <keith.busch@intel.com>
