Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A6145C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 13:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6549420020
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 13:56:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6549420020
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935702AbeFMN4A (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 09:56:00 -0400
Received: from verein.lst.de ([213.95.11.211]:41106 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935185AbeFMNz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 09:55:58 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 7FAAC68E46; Wed, 13 Jun 2018 16:04:11 +0200 (CEST)
Date:   Wed, 13 Jun 2018 16:04:11 +0200
From:   "hch@lst.de" <hch@lst.de>
To:     "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc:     Bart Van Assche <Bart.VanAssche@wdc.com>,
        "randrianasulu@gmail.com" <randrianasulu@gmail.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: kernel BUG at drivers/scsi/scsi_error.c:197! - git
        4.17.0-x64-08428-g7d3bf613e99a
Message-ID: <20180613140411.GA32701@lst.de>
References: <201806091606.51078.randrianasulu@gmail.com> <025bf705-15b0-65e5-4b16-6c91d41c1730@infradead.org> <40617b19667b3c1302f8a903c19f2fa2f409b12a.camel@wdc.com> <5ca74fb7-af70-31c3-0e3f-bace058e5a57@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ca74fb7-af70-31c3-0e3f-bace058e5a57@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I suspect this is due to we could expire a same request twice or even more.
> For scsi mid-layer, it return BLK_EH_DONE from .timeout, in fact, the request is not
> completed there, but just queue a delayed abort_work (HZ/100). If the blk_mq_timeout_work
> runs again before the abort_work, the request will be timed out again, because there is not
> any mark on it to identify this request has been timed out.
> 
> Would please try the patch attached on to see whether this issue could be fixed ?
> (this patch only works for scsi device currently)

The patch isn't really going to work without a caller of your new
__blk_mq_complete_request helper, is it?

Either way the concept of doing error handling without quiescing the
queue just looks bogus to me and will end up with some sort of race
here or there.
