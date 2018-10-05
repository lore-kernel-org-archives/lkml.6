Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F65C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 10:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EF332098A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 10:17:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EF332098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbeJERPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 13:15:30 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:43439 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727535AbeJERPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 13:15:30 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1g8NAd-0000bi-MV; Fri, 05 Oct 2018 12:17:19 +0200
Message-ID: <1538734639.3545.11.camel@pengutronix.de>
Subject: Re: [PATCH v4 04/11] media: imx: Fix field negotiation
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Steve Longerbeam <slongerbeam@gmail.com>,
        linux-media@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Fri, 05 Oct 2018 12:17:19 +0200
In-Reply-To: <20181004185401.15751-5-slongerbeam@gmail.com>
References: <20181004185401.15751-1-slongerbeam@gmail.com>
         <20181004185401.15751-5-slongerbeam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-10-04 at 11:53 -0700, Steve Longerbeam wrote:
> IDMAC interlaced scan, a.k.a. interweave, should be enabled in the
> IDMAC output channels only if the IDMAC output pad field type is
> 'seq-bt' or 'seq-tb', and field type at the capture interface is
> 'interlaced*'.
> 
> V4L2_FIELD_HAS_BOTH() macro should not be used on the input to determine
> enabling interlaced/interweave scan. That macro includes the 'interlaced'
> field types, and in those cases the data is already interweaved with
> top/bottom field lines.
> 
> The CSI will capture whole frames when the source specifies alternate
> field mode. So the CSI also enables interweave for alternate input
> field type and the field type at capture interface is interlaced.
> 
> Fix the logic for setting field type in try_fmt in CSI entity.
> The behavior should be:
> 
> - No restrictions on field type at sink pad.
> 
> - At the output pads, allow sequential fields in TB order, if the sink pad
>   field type is sequential or alternate. Otherwise passthrough the field
>   type from sink to source pad.
> 
> Move this logic to new function csi_try_field().
> 
> These changes result in the following allowed field transformations
> from CSI sink -> source pads (all other field types at sink are passed
> through to source):
> 
> seq-tb -> seq-tb
> seq-bt -> seq-tb
> alternate -> seq-tb
> 
> In a future patch, the CSI sink -> source will allow:
> 
> seq-tb -> seq-bt
> seq-bt -> seq-bt
> alternate -> seq-bt
> 
> This will require supporting interweave with top/bottom line swapping.
> Until then seq-bt is not allowed at the CSI source pad because there is
> no way to swap top/bottom lines when interweaving to INTERLACED_BT --
> note that despite the name, INTERLACED_BT is top-bottom order in memory.
> The BT in this case refers to field dominance: the bottom lines are
> older in time than the top lines.
> 
> The capture interface device allows selecting IDMAC interweave by
> choosing INTERLACED_TB if the CSI/PRPENCVF source pad is seq-tb and
> INTERLACED_BT if the source pad is seq-bt (for future support of seq-bt).
> 
> Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
