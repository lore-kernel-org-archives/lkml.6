Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 597F3C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 15:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18F85208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 15:03:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18F85208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934296AbeFLPDe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 11:03:34 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:46663 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933228AbeFLPDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 11:03:33 -0400
Received: from 79.184.255.56.ipv4.supernova.orange.pl (79.184.255.56) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id d8e6c5eaea8c384e; Tue, 12 Jun 2018 17:03:31 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Ilia Lin <ilialin@codeaurora.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: kryo: allow building as a loadable module
Date:   Tue, 12 Jun 2018 17:02:30 +0200
Message-ID: <3261365.2LNNG94y3I@aspire.rjw.lan>
In-Reply-To: <20180606040929.tksvznlmb3ogtgur@vireshk-i7>
References: <20180605114453.1381941-1-arnd@arndb.de> <20180606040929.tksvznlmb3ogtgur@vireshk-i7>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, June 6, 2018 6:09:29 AM CEST Viresh Kumar wrote:
> On 05-06-18, 13:44, Arnd Bergmann wrote:
> > Building the kryo cpufreq driver while QCOM_SMEM is a loadable module
> > results in a link error:
> > 
> > drivers/cpufreq/qcom-cpufreq-kryo.o: In function `qcom_cpufreq_kryo_probe':
> > qcom-cpufreq-kryo.c:(.text+0xbc): undefined reference to `qcom_smem_get'
> > 
> > The problem is that Kconfig ignores interprets the dependency as met
> > when the dependent symbol is a 'bool' one. By making it 'tristate',
> > it will be forced to be a module here, which builds successfully.
> > 
> > Fixes: 46e2856b8e18 ("cpufreq: Add Kryo CPU scaling driver")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  drivers/cpufreq/Kconfig.arm | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> > index c7ce928fbf1f..52f5f1a2040c 100644
> > --- a/drivers/cpufreq/Kconfig.arm
> > +++ b/drivers/cpufreq/Kconfig.arm
> > @@ -125,7 +125,7 @@ config ARM_OMAP2PLUS_CPUFREQ
> >  	default ARCH_OMAP2PLUS
> >  
> >  config ARM_QCOM_CPUFREQ_KRYO
> > -	bool "Qualcomm Kryo based CPUFreq"
> > +	tristate "Qualcomm Kryo based CPUFreq"
> >  	depends on ARM64
> >  	depends on QCOM_QFPROM
> >  	depends on QCOM_SMEM
> 
> Okay, so we really need this to be a module. But the driver can't really work as
> a module right now if we do this: insmod, rmmod, insmod. Because it doesn't free
> resources at rmmmod and will fail on second insmod.
> 
> Because what you are fixing is a critical build error, we better get it merged
> right now.
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Patch applied, thanks!

