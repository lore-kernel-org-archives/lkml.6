Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9325C43612
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 02:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E964218FE
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 02:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546050573;
	bh=7ma79gBOvRlxzIEkh/eueZWE2pLUkmMSUErSOoXNWAQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AMdjWdVLePh45eKokEih3UhuwM+Hkp7Oq4mjv6bZtKeCCDM2UWXUhsKniLm0YKKPY
	 6uy8LPg3MvP3xf8n/mVndUBzcII07HzX6VGqT0oOHNjkZSeUVJvqsXOnPsJPvhcs+2
	 XdErec0O0IBYQHpn5hxI9DfgL2Syi+QB5SSEIPvs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbeL2C3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 21:29:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:43928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727208AbeL2C3c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 21:29:32 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FDB42146F;
        Sat, 29 Dec 2018 02:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546050571;
        bh=7ma79gBOvRlxzIEkh/eueZWE2pLUkmMSUErSOoXNWAQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ewypNhDQHgaurMsd8QBaJupDj2Ssyyj73DEY2Da2xX6rX06J7f0oV4EyJiblP64Lc
         xP6/jSNkvwOj/uLvF5uu7EoYLbGxCP4CKDIb5kNLILrvDLUzHZKM4m4yjY9Qqq6aG2
         1aeiSJk/cQjevHffChWDP9h2h5qVDx9zRmcbTrdY=
Date:   Fri, 28 Dec 2018 20:29:23 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     yu <kkndyu@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Logan Gunthorpe <logang@deltatee.com>,
        Stephen Bates <sbates@raithlin.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Eric Wehage <Eric.Wehage@huawei.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>
Subject: Re: How to force RC to forward p2p TLPs
Message-ID: <20181229022923.GA159477@google.com>
References: <CADayL-pxr_dpJykyiTeQDO13XmKPoKUs544zVrB2taHTVEx9Pw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADayL-pxr_dpJykyiTeQDO13XmKPoKUs544zVrB2taHTVEx9Pw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+cc Logan, Stephen, Jonathan, Eric, Alex]

On Sat, Dec 22, 2018 at 12:50:19PM +0800, yu wrote:
> Hi all,
> 
> We have a PCIE card which has a PEX8732 switch on-board,  and there
> are two endpoint SOCs like graphic decoder behind the switch, and by
> default the ACS is enabled in 8732.
> 
> We use the p2p DMA to transfer data between these two endpoint SOCs,
> and if the host server is not enable ACS in BIOS, the p2p works well,
> but when ACS is enabled in BIOS, the p2p is always failed. With the
> help of a protocol analyzer, we can see that the TLP is redirected to
> RC, and RC just discard it.
> 
> I tried to find how to make RC forward redirected TLP to its original
> target, but nothing found, it seems this is highly related to the RC
> vendors.
> 
> In the PCIE 4.0 spec, the section of the RC behavior of the p2p
> request redirect  said that ''implementation-specific logic within the
> RC that determines whether the request is directed towards its
> original target, or blocked as an ACS Violation error. the algorithms
> and specific controls for making this determination are not
> architected by this spec''.
> 
> 
> So is there some spec or document to describe how to set the RC? Any
> suggestion is appreciated.

Not that I'm aware of, but the folks I cc'd would know a lot more
about this area.

Bjorn
