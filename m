Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C501ECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 09:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C369421523
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 09:39:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C369421523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732091AbeITPWR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 11:22:17 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:41921 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbeITPWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 11:22:16 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1g2vQv-0007NM-EJ; Thu, 20 Sep 2018 11:39:37 +0200
Message-ID: <1537436376.3362.159.camel@pengutronix.de>
Subject: Re: [PATCH v1] tty: serial: imx: enable IDDMAEN for the last tail
 data
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Robin Gong <yibin.gong@nxp.com>,
        Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Andy Duan <fugang.duan@nxp.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "jslaby@suse.com" <jslaby@suse.com>
Date:   Thu, 20 Sep 2018 11:39:36 +0200
In-Reply-To: <VI1PR04MB45432291716B64380C1B90DD89130@VI1PR04MB4543.eurprd04.prod.outlook.com>
References: <1537457160-10792-1-git-send-email-yibin.gong@nxp.com>
         <20180920075513.6jqfbrrjax3sp4cn@pengutronix.de>
         <VI1PR04MB45432291716B64380C1B90DD89130@VI1PR04MB4543.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, den 20.09.2018, 08:39 +0000 schrieb Robin Gong:
> > -----Original Message-----
> > From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > Sent: 2018年9月20日 15:55
> > To: Robin Gong <yibin.gong@nxp.com>
> > Cc: jslaby@suse.com; Andy Duan <fugang.duan@nxp.com>;
> > linux-serial@vger.kernel.org; linux-kernel@vger.kernel.org; dl-
> > linux-imx
> > <linux-imx@nxp.com>; kernel@pengutronix.de
> > Subject: Re: [PATCH v1] tty: serial: imx: enable IDDMAEN for the
> > last tail data
> > 
> > Hello,
> > 
> > On Thu, Sep 20, 2018 at 11:26:00PM +0800, Robin Gong wrote:
> > > enable IDDMAEN in UCR4 to let sdma script has the chance to
> > > detect the
> > > idle status and transfer the last tail data with the interrupt
> > > notifying uart driver.Otherwise, the last dma done interrupt of
> > > the
> > > tail data in rxfifo whose size is less than watermark may never
> > > be
> > > received by uart driver.
> > 
> > Is this a theoretic issue? Or does it fix a real problem?
> > 
> > If the former I'd say UCR1_ATDMAEN being set should prevent this
> > stall.
> 
> It's a real fix, you will see 'timeout We read 0 byte' with the
> attached stress test
> running on i.mx7d or i.mx6 if no this patch applied. 
> ' while [ 1 ]; do /unit_tests/UART/mxc_uart_stress_test.out
> /dev/ttymxc5 2000000 D L 100 100 L; done &'
> Please make sure dma enabled on ttymxcX for your test, and sdma
> firmware setup in your rootfs 
> /lib/firmware/imx/sdma/sdma-imx6q.bin or /lib/firmware/imx/sdma/sdma-
> imx7d.bin.
> You can get sdma firmware from below:
> https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-
> firmware.git/tree/imx/sdma

Please see commit 905c0decad28402aa166975023fb88c8f62f93c8 on why using
the idle detect together with with SDMA is wrong. We don't want to re-
introduce the broken behavior.

Regards,
Lucas
