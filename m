Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E73C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 06:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCD4A2150F
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 06:46:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCD4A2150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389358AbeIUMd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 08:33:58 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:65168 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbeIUMd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 08:33:58 -0400
X-IronPort-AV: E=Sophos;i="5.54,283,1534834800"; 
   d="scan'208";a="19945779"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 20 Sep 2018 23:46:31 -0700
Received: from ajaysk-VirtualBox (10.10.76.4) by CHN-SV-EXCH01.mchp-main.com
 (10.10.76.37) with Microsoft SMTP Server id 14.3.352.0; Thu, 20 Sep 2018
 23:46:29 -0700
Date:   Fri, 21 Sep 2018 12:01:16 +0530
From:   Ajay Singh <ajay.kathat@microchip.com>
To:     Nathan Chancellor <natechancellor@gmail.com>
CC:     <valdis.kletnieks@vt.edu>,
        Aditya Shankar <aditya.shankar@microchip.com>,
        Ganesh Krishna <ganesh.krishna@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-wireless@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: wilc1000: Remove unnecessary pointer check
Message-ID: <20180921120116.603b1de6@ajaysk-VirtualBox>
In-Reply-To: <20180921053911.GA5170@flashbox>
References: <20180920212648.25181-1-natechancellor@gmail.com>
        <32473.1537507532@turing-police.cc.vt.edu>
        <20180921053911.GA5170@flashbox>
Organization: Microchip Technology
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Ajay Singh <ajay.kathat@microchip.com>

On Thu, 20 Sep 2018 22:39:11 -0700
Nathan Chancellor <natechancellor@gmail.com> wrote:

> On Fri, Sep 21, 2018 at 01:25:32AM -0400, valdis.kletnieks@vt.edu
> wrote:
> > On Thu, 20 Sep 2018 14:26:49 -0700, Nathan Chancellor said:  
> > > Clang warns that the address of a pointer will always evaluated
> > > as true in a boolean context:
> > >
> > > drivers/staging/wilc1000/linux_wlan.c:267:20: warning: address of
> > > 'vif->ndev->dev' will always evaluate to 'true'
> > > [-Wpointer-bool-conversion]
> > >         if (!(&vif->ndev->dev))
> > >             ~  ~~~~~~~~~~~^~~
> > > 1 warning generated.
> > >
> > > Since this statement always evaluates to false due to the logical
> > > not, remove it.  
> > 
> > Often, "just nuke it because it's now dead code" isn't the best
> > answer...
> > 
> > At one time, that was likely intended to be checking whether ->dev
> > was a null pointer, to make sure we don't pass request_firmware() a
> > null pointer and oops the kernel, or other things that go
> > pear-shaped....
> > 
> > So the question becomes:   Is it safe to just remove it, or was it
> > intended to test for something that could  legitimately be null if
> > we've hit an error along the way (which means we should fix the
> > condition to be proper and acceptable to both gcc and clang)?
> > 
> >   
> 
> I certainly considered whether or not removing the check versus fixing
> it was the correct answer. Given that this check can be traced back to
> the initial check in of the driver in 2015, I figured it was safe to
> remove it (since a null pointer dereference would most likely have
> been noticed by now).
> 
> Most patches addressing this warning just remove the check given that
> it's not actually changing the code, such as commit a7dc662c6a7b
> ("ASoC: codecs: PCM1789: unconditionally flush work"). However, if
> the driver authors and/or maintainers think that this check should be
> something else (maybe checking that the contents of dev is not null
> versus the address, I'm perfectly happy to submit a v2 with this
> change.
> 

The 'if' condition was intended to check the validity of net_device
structure, but i think its not required here.
The device pointer used in request_firmware(), was received in
the probe functions and different from the one checked in 'if'
condition.

Thus its safe to remove the 'if (!(&vif->ndev->dev))' condition
block.
      

Regards,
Ajay
