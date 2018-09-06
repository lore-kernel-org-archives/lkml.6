Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E0CC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 18:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A536C2075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 18:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2V8Zo+M8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A536C2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730277AbeIFWkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 18:40:08 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:54912 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727850AbeIFWkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 18:40:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=Ge5TW+ZMx9HjdcAB40z9G6IVDb/Sj5hlTRcBTOugR3w=;
        b=2V8Zo+M83hBPQHliQbzoAjHHL1kor4OQZ6XfGtVnVJP1G03VFCJbLw6xq2K48ElWUSk0YorW4C5sbF3T7uuZZuTtgQwsVp6ZFWI/6w+OJbvOrDUGfKS/3sj8fkzQpqYVUmHDwrqTIwmJ+5GryE1KfheJ9si3dlP9szP+Pti0nI0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fxyce-0007mp-A4; Thu, 06 Sep 2018 20:03:16 +0200
Date:   Thu, 6 Sep 2018 20:03:16 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     "Keller, Jacob E" <jacob.e.keller@intel.com>
Cc:     "Wang, Dongsheng" <dongsheng.wang@hxt-semitech.com>,
        "Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>,
        "sergei.shtylyov@cogentembedded.com" 
        <sergei.shtylyov@cogentembedded.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] net: ethernet: i40e: fix build error
Message-ID: <20180906180316.GB26997@lunn.ch>
References: <1536114430-21356-1-git-send-email-dongsheng.wang@hxt-semitech.com>
 <02874ECE860811409154E81DA85FBB5884C78D88@ORSMSX115.amr.corp.intel.com>
 <eab442369533452a9fc138e310aa57b9@HXTBJIDCEMVIW02.hxtcorp.net>
 <02874ECE860811409154E81DA85FBB5884C7AC01@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02874ECE860811409154E81DA85FBB5884C7AC01@ORSMSX115.amr.corp.intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm more worried about how it interacts with modules. For example,
> we could have i40e and i40evf share some code, but then wouldn't one
> of them become dependent on the other? i.e. you'd have to load i40e
> in order to successfully load i40evf? Or you'd have to have some
> sort of common glue module which you load first, and then load i40e
> and i40evf after? This also creates some interactions with
> out-of-tree modules which make it difficult. It would be nice if we
> could share the code in some way that still resulted in allowing
> each module to be separate...
 
You have a few options here.

1) A library module, containing shared code. Use EXPORT_SYMBOL_GPL()
in the library module, and the kernel runtime linker will link the
calls into the library. Also, modprobe will ensure the library module
is loaded first, before the driver module.

2) Build time sharing of code. Place the shared code into a .o file,
and link it to both modules.

There is nothing particularly difficult here, this all done lots of
times within the kernel. Just look around and see how others do it.

      Andrew
