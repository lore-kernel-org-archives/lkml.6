Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68CD3C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D5B12170E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:26:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D5B12170E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbeHURrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 13:47:11 -0400
Received: from mail.bootlin.com ([62.4.15.54]:43767 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726743AbeHURrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 13:47:11 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 870D7207B3; Tue, 21 Aug 2018 16:26:46 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id BA54620787;
        Tue, 21 Aug 2018 16:26:45 +0200 (CEST)
Date:   Tue, 21 Aug 2018 16:26:44 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Alban <albeu@free.fr>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Naren <naren.kernel@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lukas Wunner <lukas@wunner.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Sven Van Asbroeck <svendev@arcx.com>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        David Lechner <david@lechnology.com>,
        Andrew Lunn <andrew@lunn.ch>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-i2c@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v2 06/29] mtd: Add support for reading MTD devices via
 the nvmem API
Message-ID: <20180821162644.5a1d7799@bbrezillon>
In-Reply-To: <20180821155706.2adf3b4c@eos>
References: <20180810080526.27207-1-brgl@bgdev.pl>
        <20180810080526.27207-7-brgl@bgdev.pl>
        <20180817182720.6a6e5e8e@bbrezillon>
        <20180819133106.0420df5f@tock>
        <20180819184609.6dcdbb9a@bbrezillon>
        <20180821005327.0d312a85@tock>
        <20180821074404.23aaeb6b@bbrezillon>
        <20180821142716.0adcdd56@eos>
        <20180821145725.3b385399@bbrezillon>
        <20180821155706.2adf3b4c@eos>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Aug 2018 15:57:06 +0200
Alban <albeu@free.fr> wrote:

> 
> That would only be needed if the NVMEM framework would do "forward"
> parsing, creating data structure for each NVMEM cell found under an
> NVMEM provider. However currently it doesn't do that and only goes
> "backward", starting by resolving a phandle pointing to a cell, then
> finding the provider that the cell belongs to.

Yes, I missed that when briefly looking at the code.

> 
> This also has the side effect that nvmem cells defined in DT don't
> appear in sysfs, unlike those defined from board code.

Wow, that's not good. I guess we'll want to make that consistent at
some point.

 
> > > > > Furthermore xlate functions are more about converting
> > > > > from hardware parameters to internal kernel representation than
> > > > > to hide extra DT parsing.        
> > > > 
> > > > Hm, how is that different? ->of_xlate() is just a way for drivers
> > > > to have their own DT representation, which is exactly what we
> > > > want here.      
> > > 
> > > There is a big difference. DT represent the hardware and the
> > > relationship between the devices in an OS independent format. We
> > > don't add extra stuff in there just to map back internal Linux API
> > > details.    
> > 
> > And I'm not talking about adding SW information in the DT, I'm talking
> > about HW specific description. We have the same solution for pinctrl
> > configs (it's HW/driver specific).  
> 
> For pinctrl I do understand, these beast can be very different from SoC
> to SoC, having a single biding for all doesn't make much sense.
> 
> However here we are talking about a simple linear storage, nothing
> special at all. I could see the need for an xlate to for example
> support a device with several partitions, but not to just allow each
> driver to have slightly incompatible bindings.

Maybe, but I guess that's up to the subsystem maintainer to decide what
he prefers.
> > 
> > No because partitions defined the old way (as direct subnodes of the
> > MTD node) will be considered as NVMEM cells by the NVMEM framework,
> > and I don't want that.  
> 
> As I explained above that is not currently the case. If the NVMEM,
> framework is ever changed to explicitly parse NVMEM cells in advance
> we can first update the few existing users to add the compatible string.

We're supposed to be backward compatible (compatible with old DTs), so
that's not an option, though we could add a way to check the compat
string afterwards.

> 
> > Plus, I don't want people to start defining their NVMEM cells and
> > forget the compat string (which would work just fine because the
> > NVMEM framework doesn't care).  
> 
> A review of a new DTS should check that it use each binding correctly,
> AFAIK the DT people do that. We could also add a warning when there is
> no compatible string, that would also help pushing people to update
> their DTS.

Yes, but I'd still prefer if we were preventing people from referencing
mtd-nvmem cells if the node does not have an "nvmem-cell" compat.

> 
> > >     
> > > > What forces people to add this compatible in their
> > > > DT? Nothing. I'll tell you what will happen: people will start
> > > > defining their nvmem cells directly under the MTD node because
> > > > that *works*, and even if the binding is not documented and we
> > > > consider it invalid, we'll be stuck supporting it forever.      
> > > 
> > > Do note that undocumented bindings are not allowed. DTS that use
> > > undocumented bindings (normally) just get rejected.    
> > 
> > Except that's just in theory. In practice, if people can do something
> > wrong, they'll complain if you later fix the bug and break their
> > setup. So no, if we go for the "nvmem cells have an 'nvmem-cell'
> > compat", then I'd like the NVMEM framework to enforce that somehow.  
> 
> That should be trivial to implement.

Exactly, and that's why I'm insisting on this point.
