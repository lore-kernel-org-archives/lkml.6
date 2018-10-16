Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEFE6C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82385205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:15:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82385205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbeJQAGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 20:06:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51608 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727061AbeJQAGt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 20:06:49 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CEA6C3F72C;
        Tue, 16 Oct 2018 16:15:39 +0000 (UTC)
Received: from treble (ovpn-125-6.rdu2.redhat.com [10.10.125.6])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5A7D25D9C8;
        Tue, 16 Oct 2018 16:15:38 +0000 (UTC)
Date:   Tue, 16 Oct 2018 11:15:36 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Borislav Petkov <bp@suse.de>, Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] objtool: move libelf check out of top Makefile
Message-ID: <20181016161536.pnek3dnyem6mspwr@treble>
References: <1539681053-24388-1-git-send-email-yamada.masahiro@socionext.com>
 <1539681053-24388-3-git-send-email-yamada.masahiro@socionext.com>
 <20181016142540.pxlwu3ft6n2b4pgj@treble>
 <CAK7LNARLW4NmeY0Rq19Bj_5kOFbp6YDtsUDhNaAfVXjL85cAMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK7LNARLW4NmeY0Rq19Bj_5kOFbp6YDtsUDhNaAfVXjL85cAMg@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 16 Oct 2018 16:15:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 12:51:40AM +0900, Masahiro Yamada wrote:
> > ifdef CONFIG_UNWINDER_ORC
> >
> > chk_unwinder_orc = echo "int main() {}" | $(HOSTCC) -xc -o /dev/null -lelf -
> > msg_unwinder_orc = "Cannot build objtool to generate ORC metadata for CONFIG_UNWINDER_ORC=y.  " \
> >                        "Please install libelf-dev, libelf-devel or elfutils-libelf-devel."
> > toolcheck-$(CONFIG_UNWINDER_ORC) += unwinder_orc
> >
> > else
> >
> > chk_stack_validation = echo "int main() {}" | $(HOSTCC) -xc -o /dev/null -lelf -
> > msg_stack_validation = "Cannot build objtool for CONFIG_STACK_VALIDATION=y.  " \
> >                        "Please install libelf-dev, libelf-devel or elfutils-libelf-devel."
> > toolcheck-$(CONFIG_STACK_VALIDATION) += stack_validation
> >
> > endif
> >
> >
> > What do you think?
> 
> 
> It is ugly.
> 
> Do you need such detailed information like ORC metadata stuff here?
> 
> This Makefile aims to error out, showing why the build failed.
> That's it.

Yeah, it is kind of ugly.  But the "showing why the build failed" part
is important.  I was trying to give the user a clear error message,
similar to what we have today.

Without context, the user won't know what objtool is, or why it needs to
be built.

If we have just a single error message for all cases, it should at least
mention the config option.  Like

   "Cannot build objtool for CONFIG_STACK_VALIDATION."

But then, most users will only have that enabled because of ORC.  So an
ORC-specific message would be more appropriate in most cases.

So maybe it can just be something more vague:

msg_stack_validation = "Cannot build objtool for CONFIG_UNWINDER_ORC and/or CONFIG_STACK_VALIDATION.  " \
		       "Please install libelf-dev, libelf-devel or elfutils-libelf-devel."

That would probably be good enough.  Then we could drop the ugly ifdef.

-- 
Josh
