Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E84DFC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 08:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DBA225090
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 08:06:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DBA225090
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752758AbeFZIGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 04:06:55 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:54150
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751869AbeFZIGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 04:06:51 -0400
X-IronPort-AV: E=Sophos;i="5.51,274,1526335200"; 
   d="scan'208";a="269949661"
Received: from dhcp-64-47.ens-lyon.fr ([140.77.64.47])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2018 10:06:48 +0200
Date:   Tue, 26 Jun 2018 10:06:48 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Joe Perches <joe@perches.com>
cc:     Chengguang Xu <cgxu519@gmx.com>, jakub.kicinski@netronome.com,
        davem@davemloft.net, LKML <linux-kernel@vger.kernel.org>,
        cocci <cocci@systeme.lip6.fr>, oss-drivers@netronome.com,
        netdev@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input <linux-input@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>
Subject: Re: [PATCH v2 net] nfp: cast sizeof() to int when comparing with
 error code
In-Reply-To: <ff0b2834b771a467246b9f7c1b4600c38f5bb463.camel@perches.com>
Message-ID: <alpine.DEB.2.20.1806261005190.4512@hadrien>
References: <20180626011631.22717-1-cgxu519@gmx.com> <ff0b2834b771a467246b9f7c1b4600c38f5bb463.camel@perches.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 25 Jun 2018, Joe Perches wrote:

> On Tue, 2018-06-26 at 09:16 +0800, Chengguang Xu wrote:
> > sizeof() will return unsigned value so in the error check
> > negative error code will be always larger than sizeof().
>
> This looks like a general class of error in the kernel
> where a signed result that could be returning a -errno
> is tested against < or <= sizeof()
>
> A couple examples:
>
> drivers/input/mouse/elan_i2c_smbus.c:
>
> 		len = i2c_smbus_read_block_data(client,
> 						ETP_SMBUS_IAP_PASSWORD_READ,
> 						val);
> 		if (len < sizeof(u16)) {
>
> i2c_smbus_read_block_data can return a negative errno
>
>
> net/smc/smc_clc.c:
>
> 	len = kernel_sendmsg(smc->clcsock, &msg, &vec, 1,
> 			     sizeof(struct smc_clc_msg_decline));
> 	if (len < sizeof(struct smc_clc_msg_decline))
>
> where kernel_sendmsg can return a negative errno
>
> There are probably others, I didn't look hard.
>
> Perhaps a cocci script to find these could be generated?

Here's another one:

drivers/usb/serial/ir-usb.c
@@ -126,13 +126,8 @@ irda_usb_find_class_desc(struct usb_seri
 	if (!desc)
 		return NULL;

-	ret = usb_control_msg(dev, usb_rcvctrlpipe(dev, 0),
-			USB_REQ_CS_IRDA_GET_CLASS_DESC,
-			USB_DIR_IN | USB_TYPE_CLASS | USB_RECIP_INTERFACE,
-			0, ifnum, desc, sizeof(*desc), 1000);

 	dev_dbg(&serial->dev->dev, "%s -  ret=%d\n", __func__, ret);
-	if (ret < sizeof(*desc)) {
 		dev_dbg(&serial->dev->dev,
 			"%s - class descriptor read %s (%d)\n", __func__,
 			(ret < 0) ? "failed" : "too short", ret);

There are other results, but I haven't checked all of them.

julia
