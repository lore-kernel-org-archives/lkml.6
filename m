Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B77EC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 21:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41B122084A
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 21:44:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730998AbeLPVon (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 16:44:43 -0500
Received: from mail5.windriver.com ([192.103.53.11]:57932 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727256AbeLPVom (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 16:44:42 -0500
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id wBGLgD6c028211
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Sun, 16 Dec 2018 13:42:24 -0800
Received: from yow-pgortmak-d1.corp.ad.wrs.com (128.224.56.57) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.408.0; Sun, 16 Dec 2018 13:42:03 -0800
Received: by yow-pgortmak-d1.corp.ad.wrs.com (Postfix, from userid 1000)        id
 F04002E07BA; Sun, 16 Dec 2018 16:42:02 -0500 (EST)
Date:   Sun, 16 Dec 2018 16:42:02 -0500
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
CC:     Randy Dunlap <rdunlap@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [Regression 4.15] Can't kill CONFIG_UNWINDER_ORC with fire or
 plague.
Message-ID: <20181216214202.GQ11670@windriver.com>
References: <20171226043003.GB10431@windriver.com>
 <d053e6df-ed00-2a02-eb27-4287b7549276@infradead.org>
 <20171229021323.GF10431@windriver.com>
 <20171229164739.rgcqmam6wtno6hge@treble>
 <20171229181830.GH10431@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20171229181830.GH10431@windriver.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Re: [Regression 4.15] Can't kill CONFIG_UNWINDER_ORC with fire or plague.] On 29/12/2017 (Fri 13:18) Paul Gortmaker wrote:

> [Re: [Regression 4.15] Can't kill CONFIG_UNWINDER_ORC with fire or plague.] On 29/12/2017 (Fri 10:47) Josh Poimboeuf wrote:
> 
> > This seems to be related to a kconfig quirk where only silentoldconfig
> > updates the include/config/auto.conf file.  The other config targets
> > (oldconfig, defconfig, etc) don't touch it.  It seems intentional, but I
> > have no idea why.
> > 
> > That causes the Makefile to get stale data for 'CONFIG_*' variables when
> > it includes auto.conf.  So I don't think this is specific to the ORC
> > check.  It seems like it could also cause bugs elsewhere.
> 
> OK, good - you agree with my initial diagnosis of stale auto.conf then.
> Not sure what Randy was testing when he said he couldn't reproduce it.
> 
> > The below (ugly) patch fixes it, though I'm not sure this is the best
> > way to do it.  We probably need Masahiro or Michal to chime in here.
> 
> Yep, that is why I intentionally put the kbuild folks on the To/Cc of
> the original report (and ran away screaming at the prospect of debugging
> Makefiles on xmas day).  But with holidays and all, it might not be
> until early January before they have a chance to reply.

It is nearly a year later and we still have this false positive.

paul@sm:~/git/linux-head$ make -j12 > /dev/null
Makefile:966: *** "Cannot generate ORC metadata for CONFIG_UNWINDER_ORC=y,
 please install libelf-dev, libelf-devel or elfutils-libelf-devel".  Stop.
paul@sm:~/git/linux-head$ grep UNWINDER_ORC .config
# CONFIG_UNWINDER_ORC is not set

We do know a bit more now -- the auto.conf issue has been independently
confirmed and "fixed" for other subsystems/issues since, like RETPOLINE:

 ---------------------
  commit 25896d073d8a0403b07e6dec56f58e6c33678207
  Author: Masahiro Yamada <yamada.masahiro@socionext.com>
  Date:   Wed Dec 5 15:27:19 2018 +0900
   
    x86/build: Fix compiler support check for CONFIG_RETPOLINE

    It is troublesome to add a diagnostic like this to the Makefile
    parse stage because the top-level Makefile could be parsed with
    a stale include/config/auto.conf.

    Once you are hit by the error about non-retpoline compiler, the
    compilation still breaks even after disabling CONFIG_RETPOLINE.
 ---------------------

I'm not sure if we want to treat this on a per config option each time
again and again, or undertake a more global kbuild approach, but it does
warrant a mention and a re-examination before we "solve" this again.

Paul.
--
