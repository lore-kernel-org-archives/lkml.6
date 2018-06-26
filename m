Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06951C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 02:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A41A02642F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 02:11:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A41A02642F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965245AbeFZCLE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 22:11:04 -0400
Received: from smtprelay0126.hostedemail.com ([216.40.44.126]:59427 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S965190AbeFZCLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 22:11:03 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 5495F18224D7A;
        Tue, 26 Jun 2018 02:11:02 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: scent76_8cd89f294c4f
X-Filterd-Recvd-Size: 1964
Received: from XPS-9350.home (unknown [47.151.150.235])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Tue, 26 Jun 2018 02:11:00 +0000 (UTC)
Message-ID: <ff0b2834b771a467246b9f7c1b4600c38f5bb463.camel@perches.com>
Subject: Re: [PATCH v2 net] nfp: cast sizeof() to int when comparing with
 error code
From:   Joe Perches <joe@perches.com>
To:     Chengguang Xu <cgxu519@gmx.com>, jakub.kicinski@netronome.com,
        davem@davemloft.net, LKML <linux-kernel@vger.kernel.org>,
        Julia Lawall <julia.lawall@lip6.fr>,
        cocci <cocci@systeme.lip6.fr>
Cc:     oss-drivers@netronome.com, netdev@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input <linux-input@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>
Date:   Mon, 25 Jun 2018 19:10:59 -0700
In-Reply-To: <20180626011631.22717-1-cgxu519@gmx.com>
References: <20180626011631.22717-1-cgxu519@gmx.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-06-26 at 09:16 +0800, Chengguang Xu wrote:
> sizeof() will return unsigned value so in the error check
> negative error code will be always larger than sizeof().

This looks like a general class of error in the kernel
where a signed result that could be returning a -errno
is tested against < or <= sizeof()

A couple examples:

drivers/input/mouse/elan_i2c_smbus.c:

		len = i2c_smbus_read_block_data(client,
						ETP_SMBUS_IAP_PASSWORD_READ,
						val);
		if (len < sizeof(u16)) {

i2c_smbus_read_block_data can return a negative errno


net/smc/smc_clc.c:

	len = kernel_sendmsg(smc->clcsock, &msg, &vec, 1,
			     sizeof(struct smc_clc_msg_decline));
	if (len < sizeof(struct smc_clc_msg_decline))

where kernel_sendmsg can return a negative errno

There are probably others, I didn't look hard.

Perhaps a cocci script to find these could be generated?

