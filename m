Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FAKE_REPLY_C,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E564ECDE46
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 01:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F085F20843
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 01:46:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F085F20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=freebsd.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbeJ0KZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 06:25:59 -0400
Received: from mx2.freebsd.org ([8.8.178.116]:27121 "EHLO mx2.freebsd.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbeJ0KZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 06:25:59 -0400
X-Greylist: delayed 325 seconds by postgrey-1.27 at vger.kernel.org; Sat, 27 Oct 2018 06:25:58 EDT
Received: from mx1.freebsd.org (mx1.freebsd.org [IPv6:2610:1c1:1:606c::19:1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mx1.freebsd.org", Issuer "Let's Encrypt Authority X3" (verified OK))
        by mx2.freebsd.org (Postfix) with ESMTPS id E48126712A;
        Sat, 27 Oct 2018 01:41:15 +0000 (UTC)
        (envelope-from emaste@freebsd.org)
Received: from freefall.freebsd.org (freefall.freebsd.org [IPv6:2610:1c1:1:6074::16:84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "freefall.freebsd.org", Issuer "Let's Encrypt Authority X3" (verified OK))
        by mx1.freebsd.org (Postfix) with ESMTPS id 4896275558;
        Sat, 27 Oct 2018 01:41:15 +0000 (UTC)
        (envelope-from emaste@freebsd.org)
Received: by freefall.freebsd.org (Postfix, from userid 1079)
        id 250881C44; Sat, 27 Oct 2018 01:41:14 +0000 (UTC)
Date:   Sat, 27 Oct 2018 01:41:14 +0000
From:   Ed Maste <emaste@freebsd.org>
To:     cyphar@cyphar.com, David Drysdale <drysdale@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] namei: implement O_BENEATH-style AT_* flags
Message-ID: <20181027014114.GA52393@freebsd.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181009065300.11053-3-cyphar@cyphar.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Oct 2018 at 02:53, Aleksa Sarai <cyphar@cyphar.com> wrote:
>
> +#ifndef O_BENEATH
> +#define O_BENEATH      00040000000 /* *Not* the same as capsicum's O_BENEATH! */
> +#endif

I had originally followed up privately to Aleksa about this comment (to
suggest that it's outdated and should be removed), but the reference
Capsicum implementation now supports O_BENEATH and I think it's sensible to
follow up here with the additional context.

O_BENEATH originally came from the Capsicum Linux port, and inherited the
restriction against ".." path components from years ago when the port was
done.  In addition, FreeBSD did not originally implement O_BENEATH as the
"beneath" behaviour is inherently provided once a process enters a
capability mode sandbox.  However, Capsicum now allows ".." paths, and
FreeBSD supports O_BENEATH separately from capability mode.  Absolute paths
are not yet allowed with O_BENEATH but a change is in review to permit them.
 
On FreeBSD a lookup prevented by O_BENEATH semantics returns ENOTCAPABLE,
the errno coming from the Capsicum implementation.

Ideally I would like to see us have the same API; none of this work has yet
shipped in a FreeBSD release and there is an opportunity for us to make
changes to match the interface and errors Linux may adopt.
