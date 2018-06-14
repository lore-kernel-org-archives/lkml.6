Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 27C5EC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 08:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3ABE208D7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 08:24:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3ABE208D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754816AbeFNIYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 04:24:36 -0400
Received: from verein.lst.de ([213.95.11.211]:45107 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752876AbeFNIYe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 04:24:34 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id C750568C4E; Thu, 14 Jun 2018 10:32:52 +0200 (CEST)
Date:   Thu, 14 Jun 2018 10:32:52 +0200
From:   "hch@lst.de" <hch@lst.de>
To:     "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc:     "hch@lst.de" <hch@lst.de>,
        Bart Van Assche <Bart.VanAssche@wdc.com>,
        "randrianasulu@gmail.com" <randrianasulu@gmail.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: kernel BUG at drivers/scsi/scsi_error.c:197! - git
        4.17.0-x64-08428-g7d3bf613e99a
Message-ID: <20180614083252.GA18536@lst.de>
References: <201806091606.51078.randrianasulu@gmail.com> <025bf705-15b0-65e5-4b16-6c91d41c1730@infradead.org> <40617b19667b3c1302f8a903c19f2fa2f409b12a.camel@wdc.com> <5ca74fb7-af70-31c3-0e3f-bace058e5a57@oracle.com> <20180613140411.GA32701@lst.de> <09e8bd7605febd091679172d68ca1e9ca3990c91.camel@wdc.com> <20180613143558.GA1163@lst.de> <77932f7b-08ba-7ece-3778-d7da82772057@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77932f7b-08ba-7ece-3778-d7da82772057@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 03:49:28PM +0800, jianchao.wang wrote:
> Yes, it will work for this issue.
> But we should also clear the RQF_TIMED_OUT in __blk_mq_requeue_request and blk_mq_rq_ctx_init.

blk_mq_rq_ctx_init always clears rq_flags, so we don't need to explcitly
clear it.

__blk_mq_requeue_request probablys needs it so that we handle the
case of requeuing from the error handling indeed.
