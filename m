Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8CB1C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 17:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA5732086C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 17:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388060AbeLQRtl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 12:49:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43552 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726660AbeLQRtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 12:49:41 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 04E055D61D;
        Mon, 17 Dec 2018 17:49:41 +0000 (UTC)
Received: from treble (ovpn-120-179.rdu2.redhat.com [10.10.120.179])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0DDDF3DA7;
        Mon, 17 Dec 2018 17:49:38 +0000 (UTC)
Date:   Mon, 17 Dec 2018 11:49:36 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Qian Cai <cai@lca.pw>
Cc:     yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        mingo@kernel.org, bp@alien8.de, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH] kbuild: error for CONFIG_ORC_UNWINDER is too much
Message-ID: <20181217174936.ouhelssdkshclrr6@treble>
References: <869bc700-1d6d-b950-76c7-5d0fc589152c@lca.pw>
 <20181217161728.6875-1-cai@lca.pw>
 <20181217170305.chni6e5vmev7hp4r@treble>
 <1545066839.18411.17.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1545066839.18411.17.camel@lca.pw>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Mon, 17 Dec 2018 17:49:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 12:13:59PM -0500, Qian Cai wrote:
> On Mon, 2018-12-17 at 11:03 -0600, Josh Poimboeuf wrote:
> > On Mon, Dec 17, 2018 at 11:17:28AM -0500, Qian Cai wrote:
> > > Since ifdef will be evaluated immediately in the first phrase of the
> > > Makefile read-in, there is no guarantee that the value for
> > > CONFIG_ORC_UNWINDER will be up-to-date until in the second phrase that
> > > this recipe is ran.
> > > 
> > > include/config/%.conf: $(KCONFIG_CONFIG) include/config/auto.conf.cmd
> > > 	$(Q)$(MAKE) -f $(srctree)/Makefile syncconfig
> > > 
> > > Hence, change error to warning as this is essentially a best guess. The
> > > original bug can be reproduced this way,
> > 
> > But this still doesn't fix the root of the problem, that the check
> > relies on a stale auto.conf.
> > 
> 
> Yes, but it at least let people to be able to continue compiling kernel without
> prematurely being terminated incorrectly. The good thing is that that check will
> be triggered again to print out the right message once auto.conf has been synced
> up.
> 
> # make
> Makefile:966: "Cannot generate ORC metadata for CONFIG_UNWINDER_ORC=y, please
> install libelf-dev, libelf-devel or elfutils-libelf-devel"
>   HOSTCC  scripts/kconfig/conf.o
>   HOSTLD  scripts/kconfig/conf
> scripts/kconfig/conf  --syncconfig Kconfig
> Makefile:968: "Cannot use CONFIG_STACK_VALIDATION=y, please install libelf-dev,
> libelf-devel or elfutils-libelf-devel"

Instead of giving false (or silent) warnings, why not just fix the real
problem?

Also the error exists for a reason: if the user misses the warning then
the ORC unwinder is broken and oops stack dumps are much less useful.

-- 
Josh
