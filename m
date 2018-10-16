Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34747C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 08:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7CEC205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 08:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Xaj0YQud"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7CEC205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbeJPQXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 12:23:12 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:54798 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbeJPQXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 12:23:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QivZEZYBJRjWSaF+/oOFS9hhAh0OQAp5JDcCTesjNag=; b=Xaj0YQudpqMWhokC1lhzwhTrR
        RoR2rcS577WbYNE9Rq6wTJGfa9qYd43jtKvQjjM2garK9P6x/umItLwpDzoHtqLFjP+QQd5pgZvEW
        uFPr+kxGvbjxAg0Yfh+hVvASMwmEEdXHVfPlZK2qeXBZphQbmbz9TFSm7rNSbzOaxeYfw=;
Received: from n2100.armlinux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:55986)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gCKnR-0005Wx-Rx; Tue, 16 Oct 2018 09:33:46 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gCKnO-00056X-Ok; Tue, 16 Oct 2018 09:33:42 +0100
Date:   Tue, 16 Oct 2018 09:33:41 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Nicolas Pitre <nicolas.pitre@linaro.org>
Cc:     Stefan Agner <stefan@agner.ch>, arnd@arndb.de,
        linus.walleij@linaro.org, linux-kernel@vger.kernel.org,
        joel@jms.id.au, ulli.kroll@googlemail.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] ARM: copypage: do not use naked functions
Message-ID: <20181016083341.GE30658@n2100.armlinux.org.uk>
References: <20181015222621.14673-1-stefan@agner.ch>
 <nycvar.YSQ.7.76.1810151831040.1498@knanqh.ubzr>
 <20181015224152.GA30658@n2100.armlinux.org.uk>
 <4e598f27e3dc7ae9fd96a6cf097d1154@agner.ch>
 <nycvar.YSQ.7.76.1810151908450.1498@knanqh.ubzr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YSQ.7.76.1810151908450.1498@knanqh.ubzr>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 07:27:43PM -0400, Nicolas Pitre wrote:
> It's hard to see what that commit was actually fixing, but the operands 
> usage is wrong as explained already. Maybe the generated code has been 
> OK for all those years but that is due to luck rather than correctness.
...
> No idea. Maybe Russell remembers?
> Maybe digging into the mailing list archive might tell.

I found this as a reply to the patch by Mikael Pettersson:

I've tested and verified that this bit enables a gcc-4.5 compiled kernel
to boot on TS-119 (Kirkwood) when combined with my fix for __naked.
With neither or only one of the patches applied, the kernel oopses hard
in copy_user_page() as it tries to start /sbin/init.
...
- the asm() bodies of these __naked functions have inadequate input
  parameter constraints, in particular they fail to declare any
  dependencies on the functions' formal parameters; gcc-4.5 sees this
  and skips the parameter setup before calling these functions, causing
  runtime crashes; Khem's patch (this one) fixes that
  (copypage-xscale.c already had correct asm() constraints so it works
  with only the __naked fix, these other copypage-*.c files need both
  patches to work)

So, while wrong to the GCC manual, it's fixing a bug that is present
with gcc-4.5 and who-knows what other GCC versions.  Reverting the
commit has the chance to cause regressions with GCC.

It looks like any change here needs to be validated on a range of
GCC versions, because there are versions of GCC known not to follow
it's manual!

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
