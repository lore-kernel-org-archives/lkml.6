Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF73ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3B7420684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="e9THxG5Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3B7420684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731814AbeGSOPn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 10:15:43 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:56934 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731686AbeGSOPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 10:15:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KSMcv9O8pArvFyO6KbIHQUs7UX1cEuQAHpZCCuKjjdg=; b=e9THxG5ZH5pz6HpqNazmUuyat
        xMDSbh0PhkJi/L9VZCanfliZsj2e1tFnXXaI1PKDuIuZtNTfOu/151Mg5N0Sj9fQw/yUJ7MAdtMBK
        q3kJzyycrBVFdwqmTEIr5A/St6gFwVNIp74v81gFH3p4Y+cchoEEhs42izPpFm95gEcCw=;
Received: from n2100.armlinux.org.uk ([fd8f:7570:feb6:1:214:fdff:fe10:4f86]:57484)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1fg92h-0005uc-PJ; Thu, 19 Jul 2018 14:32:27 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1fg92e-00038U-Hu; Thu, 19 Jul 2018 14:32:24 +0100
Date:   Thu, 19 Jul 2018 14:32:22 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Qais Yousef <Qais.Yousef@arm.com>
Subject: Re: arm: v4.18-rc5 with cpuidle on TC2 (A7 boot) spectre v2 issue
Message-ID: <20180719133222.GL17271@n2100.armlinux.org.uk>
References: <2abc6c11-2e8c-a4ea-6911-0f495d90ace6@arm.com>
 <20180719100109.GH17271@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline
In-Reply-To: <20180719100109.GH17271@n2100.armlinux.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 19, 2018 at 11:01:10AM +0100, Russell King - ARM Linux wrote:
> On Thu, Jul 19, 2018 at 11:42:50AM +0200, Dietmar Eggemann wrote:
> > Hi,
> > 
> > running v4.18-rc5 (plus still missing "power: vexpress: fix corruption in
> > notifier registration", otherwise I get this rcu_sched stall issue) on TC2
> > (A7 boot) with vanilla multi_v7_defconfig plus
> > CONFIG_ARM_BIG_LITTLE_CPUIDLE=y gives me continuous:
> > 
> > ...
> >  CPUX: Spectre v2: incorrect context switching function, system vulnerable
> > ...
> > 
> > messages.
> > 
> > Work around is to disable CONFIG_HARDEN_BRANCH_PREDICTOR.
> 
> or disable big.Little if you want the hardening.
> 
> The choices are currently either protection against Spectre or big.Little
> support since the two are mutually exclusive at the moment.

An alternative would be to give the patches in the attachment a test.
They're not finished yet, so I haven't sent them out, but still worth
testing.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up

--AqsLC8rIMeq19msA
Content-Type: application/x-xz
Content-Disposition: attachment; filename="bl.tar.xz"
Content-Transfer-Encoding: base64

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
k0tl87HEZ/sCAAAAAARZWg==

--AqsLC8rIMeq19msA--
