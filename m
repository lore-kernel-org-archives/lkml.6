Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCBB1C6786C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 03:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92BE320851
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 03:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gB/wt+5I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92BE320851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbeLMDCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 22:02:34 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:45556 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbeLMDCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 22:02:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wkjviKf3aN2mLDkPF2pxE5QaInJ9Yf6kITrXLVMxCPw=; b=gB/wt+5Im+cEhdT9AemjcOfZgN
        Am+dd4FhSjE6bAz1t0Kj8e0CCLIOY+aojdW69PA0iFtcde0CWfM8BDMuELOKQtL/FF8WO7WwNr/zF
        rJueWqQVAA/bg+FMm/FfpbTmTBqM8/0RDr6UxB6f/9FqoXa3D6+Oj+WWzWdA7/nvaZGUMkJwTCWJ9
        rKVS13MR5qHNp/U4eHK/73A5HZ3ai/CwpR4NtmwjMD497WTi3aMHOpBC3GSrS7iG92wnBdAWDsssG
        lh+XRq62T7WqeR4cB/dPkGY98P59txz7nJwcxG7c3hxS5yn2Itvq4ZXyHhNPIzlO0mzUOGl+DUGsI
        bdwp70Tw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gXHGe-0006LC-Ht; Thu, 13 Dec 2018 03:02:28 +0000
Date:   Wed, 12 Dec 2018 19:02:28 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Matthew Garrett <mjg59@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mickael.salaun@ssi.gouv.fr>,
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
Message-ID: <20181213030228.GM6830@bombadil.infradead.org>
References: <20181212081712.32347-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181212081712.32347-1-mic@digikod.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 09:17:07AM +0100, Mickaël Salaün wrote:
> The goal of this patch series is to control script interpretation.  A
> new O_MAYEXEC flag used by sys_open() is added to enable userland script
> interpreter to delegate to the kernel (and thus the system security
> policy) the permission to interpret scripts or other files containing
> what can be seen as commands.

I don't have a problem with the concept, but we're running low on O_ bits.
Does this have to be done before the process gets a file descriptor,
or could we have a new syscall?  Since we're going to be changing the
interpreters anyway, it doesn't seem like too much of an imposition to
ask them to use:

	int verify_for_exec(int fd)

instead of adding an O_MAYEXEC.
