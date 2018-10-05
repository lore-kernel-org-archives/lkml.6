Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA1ACC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 10:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 897302084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 10:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="gi+DDpld"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 897302084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbeJERWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 13:22:43 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:52202 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727601AbeJERWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 13:22:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZYX+zoljw6FLZWp7ebzRfQsxvvNeDL1RIUspnNkZTiE=; b=gi+DDpldXv8v6IJcxUdjqlDe/
        3yP7alK0ecgSMeZfbBNgf15PYa7qx0IzqrGyOGgrud0PyOHaE1zRikp4tzFsd5Igrhrb6QyRsXZRT
        B6BEOmgpEseoZoZM+Yi+HSPlvQ49oap1LKmcHQPD15miN0+/v+vujbq2MfPVECaO8RWdg=;
Received: from n2100.armlinux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:50927)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1g8NHS-0003Td-ND; Fri, 05 Oct 2018 11:24:22 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1g8NHM-00089u-Vk; Fri, 05 Oct 2018 11:24:17 +0100
Date:   Fri, 5 Oct 2018 11:24:13 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Manjeet Pawar <manjeet.p@samsung.com>
Cc:     ebiederm@xmission.com, arnd@arndb.de, akpm@linux-foundation.org,
        mhiramat@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        pankaj.m@samsung.com, a.sahrawat@samsung.com,
        Rohit Thapliyal <r.thapliyal@samsung.com>
Subject: Re: [PATCH] traps:Recover undefined user instruction on ARM
Message-ID: <20181005102412.GI30658@n2100.armlinux.org.uk>
References: <CGME20181005045237epcas5p3bc0ab07cfb8c25ef81188b4614b978ba@epcas5p3.samsung.com>
 <20181005045237epcas5p3bc0ab07cfb8c25ef81188b4614b978ba~anUhv_CDP0965009650epcas5p34@epcas5p3.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181005045237epcas5p3bc0ab07cfb8c25ef81188b4614b978ba~anUhv_CDP0965009650epcas5p34@epcas5p3.samsung.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2018 at 10:15:57AM +0530, Manjeet Pawar wrote:
> From: Rohit Thapliyal <r.thapliyal@samsung.com> 
> 
> During user undefined instruction exception, the arm exception
> handler currently results in application crash through SIGILL.
> The bad instruction can be due to ddr/hardware issue.
> For such cases, exception trap handler could try to recover the corrupted
> text by clearing pagetable entry of undefined instruction pc and trying to fetch
> the instruction opcode by generating major page fault.
> Resulting in loading the page with correct instruction from mapped file.
> If there is no error in root filesystem i.e. the opcode is intact
> in file, then filemap fault shall be able to recover
> the instruction and continue execution normally instead of crashing.

For the reasons others have pointed out in previous replies, I will not
merge this patch or anything similar to this for mainline.  The only
sane solution to the above problem is to fix the hardware or the
hardware timings so that DDR access is reliable.

Sorry.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
