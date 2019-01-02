Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA3FC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 19:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BC7E218E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 19:01:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbfABTBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 14:01:42 -0500
Received: from mga09.intel.com ([134.134.136.24]:2175 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728395AbfABTBm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 14:01:42 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jan 2019 11:01:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,432,1539673200"; 
   d="scan'208";a="306938426"
Received: from ellie.jf.intel.com (HELO ellie) ([10.24.12.137])
  by fmsmga006.fm.intel.com with ESMTP; 02 Jan 2019 11:01:41 -0800
From:   Vinicius Costa Gomes <vinicius.gomes@intel.com>
To:     PO LIU <po.liu@nxp.com>,
        "netdev\@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "davem\@davemloft.net" <davem@davemloft.net>,
        "haustad\@cisco.com" <haustad@cisco.com>,
        "nicolas.ferre\@microchip.com" <nicolas.ferre@microchip.com>,
        "gregkh\@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>
Subject: RE: [PATCH] net: tsn: add an netlink interface between kernel and application layer
In-Reply-To: <VI1PR04MB51359EB3614797A89185C9D292B00@VI1PR04MB5135.eurprd04.prod.outlook.com>
References: <1545968772-7237-1-git-send-email-Po.Liu@nxp.com> <1545968945-7290-1-git-send-email-Po.Liu@nxp.com> <87r2e14fgr.fsf@intel.com> <VI1PR04MB51359EB3614797A89185C9D292B00@VI1PR04MB5135.eurprd04.prod.outlook.com>
Date:   Wed, 02 Jan 2019 11:01:41 -0800
Message-ID: <87k1jm51ey.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Po Liu,

PO LIU <po.liu@nxp.com> writes:

> Hi Vinicius,
>
> Thank you very much for your feedback.
>
> I know the CBS is used to be most important part of AVB. And qdiscs is good tool to configure qos. 
>
> But as you know, the TSN family is a cluster of protocols and much extending the AVB. The protocols have different  functionalities and they may have more than hundred  parameters. For example NXP ls1028a support Qbv/Qci/Qbu/Qav and also the 8021CB (not included in this patch yet).
>
> Some protocols target to configure the traffic class(like Qav CBS).
> Some to config the port(like Qbv). But some for the whole ethernet
> controller(like Qci, the control entries for the whole controller,
> which input ports and which output ports).

Reading your email, now I understand your point a little better. You are
interested in multi-port devices. I admit that I am not too familiar
with how multi-port devices are exposed in Linux, I was only focused on
the end-station use cases, until now.

>
> So I do think all the TSN configuration should not mix in the ethernet
> driver itself. I mean the driver should separate a xxx_tsn.c(for I210,
> may igb_tsn.c) to maintain the tsn operations.

> As far as using qdiscs or the interface of generic netlink. I think
> both could configuring the TSN protocols interface layer. Just what I
> provided the patch net/tsn/genl_tsn.c. But I do believe it is better
> using a standalone TSN middle layer to maintain the TSN capability
> ports. Because the TSN ports include not only the end station and also
> the switch. LS1028 is such a kind of device.

I think this is the "interesting" part of the discussion. From my point
of view the question now is:

"We already have an acceptable way to expoose TSN features for end
stations. What can we do for multi-port devices?"

What are the options here? From a quick look, it seems that extending
switchdev is a possible solution. What else?

Thinking a little more, if all the ports have netdevices associated with
them, then it could be that exposing those features via qdiscs could be
considered still. Perhaps taking a look at how tc-flower offloading is
done can give some ideas.

And about the process, usually when a new interface is proposed, the
patches are directed to net-next and have the RFC tag, so the readers
(and their tools) know what to expect.

>
> And your advises are precious for us. Let's make out an easy and
> flexible interface for TSN.
>
> Br,
> Po Liu
>

Cheers,
--
Vinicius
