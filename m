Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95B3C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 17:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F18C20851
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 17:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ODXbHPL6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F18C20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbeLMRNR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 12:13:17 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59148 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727511AbeLMRNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 12:13:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=zgLLqs+Me2TbdLlj8B9zK597kfXhai0M2M28sPkMVp0=; b=ODXbHPL6AhflSJ6NiRudG//aZQ
        8CNzkuzsbKhKOB4M0bSuN1H7NOGsnFmlJsjEswFW78ArPIt/x2G7zU9NyjklD0zRJtJdZJikmXQCI
        nklfjvshoZYTWqAJbjPW/0knYJyCkGS2MDb/FYFhgC43DduGkYKF8NmsA5kPnpTqCHW/VR3+ALKeV
        wJCZDEGHrUYmqFQl5XkAZgxlnCgmR5mAJ7Aw6V8my8s7Ey73AFr8C55C8Fa2GII5pEczwakWLtRpU
        MEOL6qvHkMnaue2+x3us3Yp9GRFfb2kOf85TibumGbyW0h2d6elojMrBbww6GE5AbmcWHvJUT2JsD
        XO3Ugwrw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gXUXv-0002r0-4G; Thu, 13 Dec 2018 17:13:11 +0000
Date:   Thu, 13 Dec 2018 09:13:10 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mickael.salaun@ssi.gouv.fr>
Cc:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Matthew Garrett <mjg59@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Philippe =?iso-8859-1?Q?Tr=E9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>, Shuah Khan <shuah@kernel.org>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        Yves-Alexis Perez <yves-alexis.perez@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/5] Add support for O_MAYEXEC
Message-ID: <20181213171310.GR6830@bombadil.infradead.org>
References: <20181212081712.32347-1-mic@digikod.net>
 <20181213030228.GM6830@bombadil.infradead.org>
 <374ea88c-edc5-f1a6-3637-748635e1e7df@ssi.gouv.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <374ea88c-edc5-f1a6-3637-748635e1e7df@ssi.gouv.fr>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 04:17:29PM +0100, Mickaël Salaün wrote:
> On 13/12/2018 04:02, Matthew Wilcox wrote:
> > On Wed, Dec 12, 2018 at 09:17:07AM +0100, Mickaël Salaün wrote:
> >> The goal of this patch series is to control script interpretation.  A
> >> new O_MAYEXEC flag used by sys_open() is added to enable userland script
> >> interpreter to delegate to the kernel (and thus the system security
> >> policy) the permission to interpret scripts or other files containing
> >> what can be seen as commands.
> > 
> > I don't have a problem with the concept, but we're running low on O_ bits.
> > Does this have to be done before the process gets a file descriptor,
> > or could we have a new syscall?  Since we're going to be changing the
> > interpreters anyway, it doesn't seem like too much of an imposition to
> > ask them to use:
> > 
> > 	int verify_for_exec(int fd)
> > 
> > instead of adding an O_MAYEXEC.
> 
> Adding a new syscall for this simple use case seems excessive. I think

We have somewhat less than 400 syscalls today.  We have 20 O_ bits defined.
Obviously there's a lower practical limit on syscalls, but in principle
we could have up to 2^32 syscalls, and there are only 12 O_ bits remaining.

> that the open/openat syscall familly are the right place to do an atomic
> open and permission check, the same way the kernel does for other file
> access. Moreover, it will be easier to patch upstream interpreters
> without the burden of handling a (new) syscall that may not exist on the
> running system, whereas unknown open flags are ignored.

Ah, but that's the problem.  The interpreter can see an -ENOSYS response
and handle it appropriately.  If the flag is silently ignored, the
interpreter has no idea whether it can do a racy check or whether to
skip even trying to do the check.

