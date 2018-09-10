Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29377C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4EAB20870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:49:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4EAB20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbeIJOmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 10:42:52 -0400
Received: from mail.bootlin.com ([62.4.15.54]:60179 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726907AbeIJOmw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 10:42:52 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id DAD37208AF; Mon, 10 Sep 2018 11:49:38 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-30-219.w90-88.abo.wanadoo.fr [90.88.15.219])
        by mail.bootlin.com (Postfix) with ESMTPSA id 684EF208BE;
        Mon, 10 Sep 2018 11:49:28 +0200 (CEST)
Date:   Mon, 10 Sep 2018 11:49:27 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        David Lechner <david@lechnology.com>,
        Andrew Lunn <andrew@lunn.ch>, Alban Bedel <albeu@free.fr>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v2 13/16] nvmem: add support for cell lookups from
 machine code
Message-ID: <20180910114927.083e2de8@bbrezillon>
In-Reply-To: <CAMRc=Me0bYjdmaqqxKqFkRRSNdoOgDf1A==dASz0dJAtx9BDqg@mail.gmail.com>
References: <20180907100750.14564-1-brgl@bgdev.pl>
        <20180907100750.14564-14-brgl@bgdev.pl>
        <484b6ec5-cd8e-e5c5-0c5c-2f11c504ea1c@linaro.org>
        <CAMRc=MdnSHY1ah4X3Bu55HvZcOQHxPHaFudidDA4mEOW9ZzeEg@mail.gmail.com>
        <20180910102324.52ecd8f7@bbrezillon>
        <c72866dd-1fb0-c765-5815-ba63d051a09b@linaro.org>
        <CAMRc=Me0bYjdmaqqxKqFkRRSNdoOgDf1A==dASz0dJAtx9BDqg@mail.gmail.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Sep 2018 11:45:48 +0200
Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> 2018-09-10 10:55 GMT+02:00 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>:
> >
> >
> > On 10/09/18 09:23, Boris Brezillon wrote:  
> >>
> >> Well, if we get rid of nvmem-machine.h, the cell-lookup stuff
> >> should go in nvmem-consumer.h not nvmem-provider.h. On the other hand,
> >> everything that is related to cell creation should be placed in
> >> nvmem-provider.h.  
> >
> > Yes, this is how it should be!
> >  
> 
> Any actual reason for not putting these definitions into a separate
> 'machine' header? This approach is currently used by gpio, pinctrl,
> iio and regulator framework because most systems use either DT or ACPI
> and don't need to pull in any stuff aimed at board files.

I'm perfectly fine with the separate header file, all I'm saying is, if
Srinivas does not want nvmem-machine.h, definitions should be placed in
nvmem-provider.h or nvmem-consumer.h depending on who they're meant to
be used by (providers or consumers).
