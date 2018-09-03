Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EAE0C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 09:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D22DB2075E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 09:39:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D22DB2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbeICN6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 09:58:19 -0400
Received: from mail.skyhub.de ([5.9.137.197]:42704 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725927AbeICN6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 09:58:19 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id x7tOuzPxwylt; Mon,  3 Sep 2018 11:38:40 +0200 (CEST)
Received: from zn.tnic (p200300EC2BCF4100329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bcf:4100:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3973C1EC0104;
        Mon,  3 Sep 2018 11:38:40 +0200 (CEST)
Date:   Mon, 3 Sep 2018 11:39:45 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kbuild@vger.kernel.org, Dirk Gouders <dirk@gouders.net>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 07/11] kbuild: use 'include' directive to load
 auto.conf from top Makefile
Message-ID: <20180903093945.GA1195@zn.tnic>
References: <1532072796-7947-1-git-send-email-yamada.masahiro@socionext.com>
 <1532072796-7947-8-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1532072796-7947-8-git-send-email-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

On Fri, Jul 20, 2018 at 04:46:32PM +0900, Masahiro Yamada wrote:
> When you build targets that require the kernel configuration, dot-config
> is set to 1, then the top-level Makefile includes auto.conf.  However,
> Make considers its inclusion is optional because the '-include' directive
> is used here.
> 
> If a necessary configuration file is missing for the external module
> building, the following error message is displayed:
> 
>   ERROR: Kernel configuration is invalid.
>          include/generated/autoconf.h or include/config/auto.conf are missing.
>          Run 'make oldconfig && make prepare' on kernel src to fix it.
> 
> However, Make still continues building; /bin/false let the creation of
> 'include/config/auto.config' fail, but Make can ignore the error since
> it is included by the '-include' directive.
> 
> I guess the reason of using '-include' directive was to suppress
> the warning when you build the kernel from a pristine source tree:
> 
>   Makefile:605: include/config/auto.conf: No such file or directory
> 
> The previous commit made sure include/config/auto.conf exists after
> the 'make *config' stage.  Now, we can use the 'include' directive
> without showing the warning.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> Changes in v4: None
> 
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This complains here:

[boris@zn: ~/kernel/linux> git clean -dqfx
[boris@zn: ~/kernel/linux> cp ../configs/config-4.19-rc1 .config
'../configs/config-4.19-rc1' -> '.config'
[boris@zn: ~/kernel/linux> make
Makefile:605: include/config/auto.conf: No such file or directory

I guess because I'm skipping the "make oldconfig" step but that should
not be necessary since it should do oldconfig automatically before
building...

It still works - it is just the warning that is new.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
