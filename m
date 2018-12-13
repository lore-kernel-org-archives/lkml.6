Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5B7C67872
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50D9620645
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="U0v7yaA5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50D9620645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728940AbeLMMQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 07:16:50 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47792 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728806AbeLMMQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 07:16:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4ZXtW55JAa/vg3hQkSbYV2kNZlrL5oduqPKvGV7TOe0=; b=U0v7yaA5V9wVYtvPRItgV/9ZUY
        US6ZjDY/ysvQOu15Y3/azoIN4C0QCObr9ZWszHqkM1ZcF0aOW7+FA/q2SjXv4Khz3tmknei2qrrSH
        tAltIO3mgfQeLH5UD+52ZXFMHgTQNVz24x90l7Nb+WLyjkuO+4ZY5VArrMOtvpSR2ZnPkv+Bw3Q2M
        5cOyOg3CvX3E1Gn12ctQm63+qeCJ9jPQOSGIMpGMdUlXm/SPfBYaJUXmWOOixVN1o6eg0AZ5KUtf2
        IbL4KjwryqD9vigGzf8sRYhwVqNtJdoN3oGcizaG76TwznbWNSyenbBGXowAUSJkX4FKXXTuO6qqt
        PeYnujiw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gXPv4-0002z1-75; Thu, 13 Dec 2018 12:16:46 +0000
Date:   Thu, 13 Dec 2018 04:16:46 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Matthew Garrett <mjg59@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mickael.salaun@ssi.gouv.fr>,
        Philippe =?iso-8859-1?Q?Tr=E9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>, Shuah Khan <shuah@kernel.org>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        Yves-Alexis Perez <yves-alexis.perez@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/5] Add support for O_MAYEXEC
Message-ID: <20181213121645.GN6830@bombadil.infradead.org>
References: <20181212081712.32347-1-mic@digikod.net>
 <20181213030228.GM6830@bombadil.infradead.org>
 <1544699060.6703.11.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1544699060.6703.11.camel@linux.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 06:04:20AM -0500, Mimi Zohar wrote:
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
> The indication needs to be set during file open, before the open
> returns to the caller.  This is the point where ima_file_check()
> verifies the file's signature.  On failure, access to the file is
> denied.

I understand that's what happens today, but do we need to do it that way?
There's no harm in the interpreter having an fd to a file if it knows
not to execute it.  This is different from a program opening a file and
having the LSM deny access to it because it violates the security model.
