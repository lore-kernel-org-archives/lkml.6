Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B370C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 18:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4042A20658
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 18:39:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4042A20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbeIEXKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 19:10:48 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:60443 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727627AbeIEXKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 19:10:48 -0400
Received: from [148.252.241.226] (helo=xylophone)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1fxci0-0004SU-Fa; Wed, 05 Sep 2018 19:39:20 +0100
Message-ID: <1536172759.3024.44.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 026/124] iwlwifi: pcie: fix race in Rx buffer
 allocator
From:   Ben Hutchings <ben.hutchings@codethink.co.uk>
To:     Shaul Triebitz <shaul.triebitz@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Cc:     stable@vger.kernel.org,
        Sasha Levin <alexander.levin@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 05 Sep 2018 19:39:19 +0100
In-Reply-To: <20180804082703.421702408@linuxfoundation.org>
References: <20180804082702.434482435@linuxfoundation.org>
         <20180804082703.421702408@linuxfoundation.org>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-08-04 at 11:00 +0200, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Shaul Triebitz <shaul.triebitz@intel.com>
> 
> [ Upstream commit 0f22e40053bd5378ad1e3250e65c574fd61c0cd6 ]
> 
> Make sure the rx_allocator worker is canceled before running the
> rx_init routine.  rx_init frees and re-allocates all rxb's pages.  The
> rx_allocator worker also allocates pages for the used rxb's.  Running
> rx_init and rx_allocator simultaniously causes a kernel panic.  Fix
> that by canceling the work in rx_init.
> 
> Signed-off-by: Shaul Triebitz <shaul.triebitz@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/net/wireless/iwlwifi/pcie/rx.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> --- a/drivers/net/wireless/iwlwifi/pcie/rx.c
> +++ b/drivers/net/wireless/iwlwifi/pcie/rx.c
> @@ -713,6 +713,8 @@ int iwl_pcie_rx_init(struct iwl_trans *t
>  						WQ_HIGHPRI | WQ_UNBOUND, 1);
>  	INIT_WORK(&rba->rx_alloc, iwl_pcie_rx_allocator_work);
>  
> +	cancel_work_sync(&rba->rx_alloc);
> +
>  	spin_lock(&rba->lock);
>  	atomic_set(&rba->req_pending, 0);
>  	atomic_set(&rba->req_ready, 0);

This seems to be an incomplete fix.  INIT_WORK() will overwrite the
list pointers in the work item, so there is still a race condition.

I think that the RX initialisation and reinitialisation/reset cases
need to be explicitly distinguished.  In the initialisation case the
driver should do only INIT_WORK() and in the reset case it should do
only cancel_work_sync() (although it would be safe to do INIT_WORK()
*after* that).

Ben.

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
