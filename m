Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C75C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 10:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AF352170E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 10:44:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AF352170E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbeHUODo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 10:03:44 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38580 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726784AbeHUODo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 10:03:44 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id AC367207C8; Tue, 21 Aug 2018 12:44:02 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id D7BDB207BF;
        Tue, 21 Aug 2018 12:43:51 +0200 (CEST)
Date:   Tue, 21 Aug 2018 12:43:52 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Alban <albeu@free.fr>, Bartosz Golaszewski <brgl@bgdev.pl>,
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
Message-ID: <20180821124352.21340939@bbrezillon>
In-Reply-To: <bd4dd892-3b6c-a77e-b2f3-386600c8c9bd@linaro.org>
References: <20180810080526.27207-1-brgl@bgdev.pl>
        <20180810080526.27207-7-brgl@bgdev.pl>
        <20180817182720.6a6e5e8e@bbrezillon>
        <20180819133106.0420df5f@tock>
        <20180819184609.6dcdbb9a@bbrezillon>
        <5b8c30b8-41e1-d59e-542b-fef6c6469ff0@linaro.org>
        <20180820202038.5d3dc195@bbrezillon>
        <e0ec3194-fd3a-9b3d-fba8-f88447eb56e9@linaro.org>
        <20180821115639.4894c1c9@bbrezillon>
        <bd4dd892-3b6c-a77e-b2f3-386600c8c9bd@linaro.org>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Aug 2018 11:11:58 +0100
Srinivas Kandagatla <srinivas.kandagatla@linaro.org> wrote:

> On 21/08/18 10:56, Boris Brezillon wrote:
> > On Tue, 21 Aug 2018 10:50:07 +0100
> > Srinivas Kandagatla<srinivas.kandagatla@linaro.org>  wrote:
> >   
> >> On 20/08/18 19:20, Boris Brezillon wrote:  
> >>> On Mon, 20 Aug 2018 11:43:34 +0100
> >>> Srinivas Kandagatla<srinivas.kandagatla@linaro.org>  wrote:
> >>>      
> >>>> Overall am still not able to clear visualize on how MTD bindings with
> >>>> nvmem cells would look in both partition and un-partition usecases?
> >>>> An example DT would be nice here!!  
> >>> Something along those lines:
> >>>      
> >> This looks good to me.  
> >>> 	mtdnode {
> >>> 		nvmem-cells {
> >>> 			#address-cells = <1>;
> >>> 			#size-cells = <1>;
> >>>
> >>> 			cell@0 {
> >>> 				reg = <0x0 0x14>;
> >>> 			};
> >>> 		};
> >>>
> >>> 		partitions {
> >>> 			compatible = "fixed-partitions";
> >>> 			#address-cells = <1>;
> >>> 			#size-cells = <1>;
> >>>
> >>> 			partition@0 {
> >>> 				reg = <0x0 0x20000>;
> >>>
> >>> 				nvmem-cells {
> >>> 					#address-cells = <1>;
> >>> 					#size-cells = <1>;
> >>>
> >>> 					cell@0 {
> >>> 						reg = <0x0 0x10>;
> >>> 					};
> >>> 				};
> >>> 			};
> >>> 		};
> >>> 	}; >  
> >> Just curious...Is there a reason why we can't do it like this?:
> >> Is this because of issue of #address-cells and #size-cells Or mtd
> >> bindings always prefer subnodes?
> >>
> >> 	mtdnode {
> >> 		reg = <0x0123000 0x40000>;
> >> 		#address-cells = <1>;
> >> 		#size-cells = <1>;
> >> 		cell@0 {
> >> 			compatible = "nvmem-cell";
> >> 			reg = <0x0 0x14>;
> >> 		};
> >>
> >> 		partitions {
> >> 			compatible = "fixed-partitions";
> >> 			#address-cells = <1>;
> >> 			#size-cells = <1>;
> >>
> >> 			partition@0 {
> >> 				reg = <0x0 0x20000>;
> >> 				cell@0 {
> >> 					compatible = "nvmem-cell";
> >> 					reg = <0x0 0x10>;
> >> 				};
> >> 			};
> >> 		};
> >> 	};  
> > It's because partitions were initially directly defined under the mtd
> > node, so, if you have an old DT you might have something like:
> > 
> > 	mtdnode {
> > 		reg = <0x0123000 0x40000>;
> > 		#address-cells = <1>;
> > 		#size-cells = <1>;
> > 
> > 		partition@0 {
> > 			reg = <0x0 0x20000>;
> > 			...
> > 		};
> > 		...
> > 	};
> > 
> > If we use such a DT with this patch applied, the NVMEM framework will
> > consider MTD partitions as nvmem cells, which is not what we want.  
> Yep, I agree.
> TBH, I wanted to add compatible string to nvmem-cell at some point in 
> time and it seems more natural update too. One of the reason we 
> discussed this in the past was parsers. Looks like mtd can make use of this.
> 
> We should be able to add this as an optional flag in nvmem_config to 
> enforce this check in case providers wanted to.
> 
> Do you think that would help mtd nvmem case?

Yes, it should work if nvmem cells are defined directly under the mtd
node (or the partition they belong to).

> Also I felt like nvmem-cells subnode seems to be a bit heavy!

I still think grouping nvmem cells in a subnode is cleaner (just like
we do for partitions), but I won't object if all parties (you, Alban
and Rob) agree on this solution.
