Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F19C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 16:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 246562089A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 16:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="in9D8bsE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 246562089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbeJBW5n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 18:57:43 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:38430 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726184AbeJBW5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 18:57:42 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 461CF8EE23D;
        Tue,  2 Oct 2018 09:13:35 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7ToPaDmtread; Tue,  2 Oct 2018 09:13:35 -0700 (PDT)
Received: from [172.20.4.121] (unknown [46.218.58.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 7DC258EE0CE;
        Tue,  2 Oct 2018 09:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1538496815;
        bh=wGIfWL3kmEPq01d4pHIM+pV4Kfgou9zd9C7/LP97Fak=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=in9D8bsE90o4ktD9zZtt5T+HaHQtS96FoqAOrRY6n6mINA1jMCLMy0oToQqe0Sfzs
         uXF0CDhX8BdojmQJFoBrPj3j24QV+GyU3p6zj+eQ4gZK+P7omcGSuKK3k9+Xa8eGeU
         876DD9RoGiKfpmx7KtWXrAi0h89HXXALAufYPjkA=
Message-ID: <1538496810.14607.5.camel@HansenPartnership.com>
Subject: Re: [RFC v2 v2 0/1] ns: introduce binfmt_misc namespace
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Laurent Vivier <laurent@vivier.eu>, linux-kernel@vger.kernel.org
Cc:     Andrei Vagin <avagin@openvz.org>, Dmitry Safonov <dima@arista.com>,
        linux-api@vger.kernel.org, containers@lists.linux-foundation.org,
        Eric Biederman <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Date:   Tue, 02 Oct 2018 18:13:30 +0200
In-Reply-To: <20181002102054.13245-1-laurent@vivier.eu>
References: <20181002102054.13245-1-laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-10-02 at 12:20 +0200, Laurent Vivier wrote:
> v2: no new namespace, binfmt_misc data are now part of
>     the mount namespace
>     I put this in mount namespace instead of user namespace
>     because the mount namespace is already needed and
>     I don't want to force to have the user namespace for that.
>     As this is a filesystem, it seems logic to have it here.
> 
> This allows to define a new interpreter for each new container.
> 
> But the main goal is to be able to chroot to a directory
> using a binfmt_misc interpreter without being root.

Reading all this, I don't quite understand why this works for me and
not for you (I think I get from your explanation that it doesn't work
for you, but I might have missed something):

jejb@jarvis:~> uname -m
x86_64
jejb@jarvis:~> unshare -r -m
root@jarvis:~# chroot /home/jejb/containers/aarch64
jarvis:/ # uname -m
aarch64

Of course to get that to work I have an 'F' entry in
/etc/binfmt.d/qemu-aarch64.conf

Which means I'm running the host emulator in the container, which is
what I want to do.  I think another goal of the patches might be to use
different emulators for different aarch64 containers?  Do you have a
use case for this, because right at the moment for arch emulation
containers I think a single host wide entry per static emulator is the
right approach.

James

