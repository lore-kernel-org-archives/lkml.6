Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F5A0C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 13:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F29521581
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 13:04:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F29521581
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbeHTQTp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 12:19:45 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:52293 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbeHTQTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 12:19:44 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1frjqq-0002ZK-GA; Mon, 20 Aug 2018 15:04:08 +0200
Message-ID: <1534770242.5445.13.camel@pengutronix.de>
Subject: Re: [PATCH 1/2] media: docs-rst: Document memory-to-memory video
 decoder interface
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Tomasz Figa <tfiga@chromium.org>, linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Pawel Osciak <posciak@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>, kamil@wypas.org,
        a.hajda@samsung.com, Kyungmin Park <kyungmin.park@samsung.com>,
        jtp.park@samsung.com,
        Tiffany Lin =?UTF-8?Q?=28=E6=9E=97=E6=85=A7=E7=8F=8A=29?= 
        <tiffany.lin@mediatek.com>,
        Andrew-CT Chen =?UTF-8?Q?=28=E9=99=B3=E6=99=BA=E8=BF=AA=29?= 
        <andrew-ct.chen@mediatek.com>, todor.tomov@linaro.org,
        nicolas@ndufresne.ca,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.org>,
        ezequiel@collabora.com
Date:   Mon, 20 Aug 2018 15:04:02 +0200
In-Reply-To: <20180724140621.59624-2-tfiga@chromium.org>
References: <20180724140621.59624-1-tfiga@chromium.org>
         <20180724140621.59624-2-tfiga@chromium.org>
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

On Tue, 2018-07-24 at 23:06 +0900, Tomasz Figa wrote:
[...]
> +Seek
> +====
> +
> +Seek is controlled by the ``OUTPUT`` queue, as it is the source of
> +bitstream data. ``CAPTURE`` queue remains unchanged/unaffected.
> +
> +1. Stop the ``OUTPUT`` queue to begin the seek sequence via
> +   :c:func:`VIDIOC_STREAMOFF`.
> +
> +   * **Required fields:**
> +
> +     ``type``
> +         a ``V4L2_BUF_TYPE_*`` enum appropriate for ``OUTPUT``
> +
> +   * The driver must drop all the pending ``OUTPUT`` buffers and they are
> +     treated as returned to the client (following standard semantics).
> +
> +2. Restart the ``OUTPUT`` queue via :c:func:`VIDIOC_STREAMON`
> +
> +   * **Required fields:**
> +
> +     ``type``
> +         a ``V4L2_BUF_TYPE_*`` enum appropriate for ``OUTPUT``
> +
> +   * The driver must be put in a state after seek and be ready to
> +     accept new source bitstream buffers.
> +
> +3. Start queuing buffers to ``OUTPUT`` queue containing stream data after
> +   the seek until a suitable resume point is found.
> +
> +   .. note::
> +
> +      There is no requirement to begin queuing stream starting exactly from
> +      a resume point (e.g. SPS or a keyframe). The driver must handle any
> +      data queued and must keep processing the queued buffers until it
> +      finds a suitable resume point. While looking for a resume point, the

I think the definition of a resume point is too vague in this place.
Can the driver decide whether or not a keyframe without SPS is a
suitable resume point? Or do drivers have to parse and store SPS/PPS if
the hardware does not support resuming from a keyframe without sending
SPS/PPS again?

regards
Philipp
