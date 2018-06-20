Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE3EC43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 18:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CFA320846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 18:12:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CFA320846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754573AbeFTSMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 14:12:53 -0400
Received: from mga04.intel.com ([192.55.52.120]:22704 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754537AbeFTSMu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 14:12:50 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jun 2018 11:12:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,248,1526367600"; 
   d="scan'208";a="59464055"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.44])
  by fmsmga002.fm.intel.com with ESMTP; 20 Jun 2018 11:12:49 -0700
Date:   Wed, 20 Jun 2018 12:16:01 -0600
From:   Keith Busch <keith.busch@intel.com>
To:     Jianchao Wang <jianchao.w.wang@oracle.com>
Cc:     axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
        josef@toxicpanda.com, ulf.hansson@linaro.org,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5]stop normal completion path entering a timeout req
Message-ID: <20180620181601.GA24145@localhost.localdomain>
References: <1529500964-28429-1-git-send-email-jianchao.w.wang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529500964-28429-1-git-send-email-jianchao.w.wang@oracle.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 09:22:39PM +0800, Jianchao Wang wrote:
> Dear all
> 
> scsi timeout and error handler are based on an assumption that normal
> completion mustn't do anything on an timeout request. After 12f5b931
> (blk-mq: Remove generation seqeunce), we lost this. __blk_mq_complete
> request could ensure a request won't be completed twice, but it can
> still complete a timeout request.
> scsi (even other drivers) have been working on this assumption for many
> years, it is dangerous to discard it suddenly. This patch set is to regain this.

I certainly don't want to harm any drivers. Could you possibly explain
what about removing silent execptions from the completion handler and
letting drivers control the destiny of requests they own is "dangerous"?

A initial look at your proposal looks pretty harmful to me. A driver may
return BLK_EH_RESET_TIMER, then call blk_mq_complete_req from another
thread, and your patch will simply lose that request and escalate error
recovery. That seems exactly what you shouldn't want to happen.
