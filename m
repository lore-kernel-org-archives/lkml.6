Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00030C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 14:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B72202082A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 14:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lo1JyTuL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B72202082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbeJDVDm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 17:03:42 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36261 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727369AbeJDVDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 17:03:42 -0400
Received: by mail-lf1-f65.google.com with SMTP id d4-v6so6907940lfa.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 07:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=26OpygXkVkQ+yy/bOBSZug/4KNAD5akX+cDA2JpwiYI=;
        b=Lo1JyTuLy0JkdfX/5X2hYieCvqUgyGKcs5fa8U3FhZLoOJ8bBMWtmXrR5Tfley5Xtk
         TAHilvZ15Tnr1O7LsI3oLi/yDq2p23lugoLLYvF19yonOivzRETbZzrMMys71/+vUXVj
         pbDNuvaSO0LCjfzMHiaGrMsY5UISaGBvZpmIgJNlu3tP7NAKArDZHzSacvnEVQXicYjV
         0b+MBQLIyb6OruaT86QogT6fcDLDBrfRWY6+XN8vTr652kVK5xcMvRH3hRJXuIFQc3To
         dXtFKRw+Ql7lbCXSTApqa7Xaj9u6KyVk8sHQwHySCj2pY48gVyPP0CPuPWnTZUu4QZ4X
         La9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=26OpygXkVkQ+yy/bOBSZug/4KNAD5akX+cDA2JpwiYI=;
        b=ui+BLhVob7I73kn6dkbVzn/rRYMgSMj3X7lyHCk/wFlc45NYSt9z1BwXptQuUEiiP/
         fvcwx/yDdk0OF7qd0Wmk4qkO3aBP2iK3MPsO5hQbZOEbzkgICYvPHeLntj0hGMpvHYXZ
         P8C8JM21hbiiv4PwsSFcSIMOeueOxLiHqXDLy2jsJE5+GE99UYrj2pXRpRZrVG858RXj
         XNR/upXA40koDnE9wyNDUjEzW6MrfZvDFLYLQKWQ77JNMREHL1uiYxjNIEG952XPg+DJ
         6FLEo+Miggup3Z89w25Dsq04oUoEY5pS32ntfYStShzqWF8ErOwO43MK0+uKd0+/IvTW
         oqwA==
X-Gm-Message-State: ABuFfohXvjNLsdNvQ6PpbR5FLkA2KSCaffEywmhMgjWZ2XalU8wefRY8
        nt5zYpvCNwV2QdMKp8/4Ujk=
X-Google-Smtp-Source: ACcGV61YqXGROw40LUBsmjoOjlMetrtIspVX63dpa98BorqXXuy+Iohw2yfYcBdMIoFRYYsMFZMsyQ==
X-Received: by 2002:a19:d3c4:: with SMTP id k187-v6mr4160505lfg.101.1538662210873;
        Thu, 04 Oct 2018 07:10:10 -0700 (PDT)
Received: from z50.localnet (78-10-164-223.static.ip.netia.com.pl. [78.10.164.223])
        by smtp.gmail.com with ESMTPSA id p11-v6sm1105856lji.87.2018.10.04.07.10.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 07:10:10 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mtd: rawnand: ams-delta: use ->exec_op()
Date:   Thu, 04 Oct 2018 16:11:42 +0200
Message-ID: <38470936.GRFaOSl3cF@z50>
In-Reply-To: <20181004155933.0a32c4ac@bbrezillon>
References: <20180719081508.5dafebde@bbrezillon> <7546835.d2Xs8Qh0bZ@z50> <20181004155933.0a32c4ac@bbrezillon>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, October 4, 2018 3:59:33 PM CEST Boris Brezillon wrote:
> On Thu, 04 Oct 2018 15:52:57 +0200
> Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:
> 
> > Hi Boris,
> > 
> > On Wednesday, October 3, 2018 4:06:34 PM CEST Boris Brezillon wrote:
> > > On Wed, 03 Oct 2018 15:55:25 +0200
> > > Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:
> > >     
> > > > > > 
> > > > > > Implementation of NAND_OP_WAITRDY_INSTR has been based on legacy
> > > > > > nand_wait_ready(),    
> > > > > 
> > > > > I don't remember what the ams-delta ->dev_ready()/->waitfunc() hooks
> > > > > are doing, but is shouldn't be too hard to replace them by an
> > > > > ams_delta_wait_ready() func.    
> > > > 
> > > > Default nand_wait() is used as ->waitfunc(), and ->dev_ready() returns 
R/B 
> > > > GPIO pin status.  
> > > 
> > > Okay. Then it might make sense to provide a generic helper to poll a
> > > gpio.
> > > 
> > > void nand_gpio_waitrdy(struct nand_chip *chip, struct gpio_desc *gpiod)
> > > {
> > > 	...
> > > }  
> > 
> > How about a still more generic helper which accepts dev_ready() callback 
as an 
> > argument?
> 
> Nope, I still prefer the GPIO based one. We'll see if others need a
> a more generic helper, but I doubt it.

OK.

Legacy nand_wait_ready() uses a hardcoded timeout value of 400 ms.   Should we 
follow the same approach in nand_gpio_waitrdy(), or should we rather let 
drivers pass the timeout value, like in case of nand_soft_waitrdy()?

Thanks,
Janusz


