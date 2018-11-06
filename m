Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A58C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 19:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52A4F2085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 19:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=genki.is header.i=@genki.is header.b="ObKyxVxk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52A4F2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=genki.is
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388496AbeKGE4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 23:56:32 -0500
Received: from genki.is ([104.200.25.21]:43210 "EHLO genki.is"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387624AbeKGE4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 23:56:31 -0500
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Nov 2018 23:56:31 EST
Received: by genki.is (OpenSMTPD) with ESMTP id 62d872ac;
        Tue, 6 Nov 2018 19:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=genki.is; h=date
        :message-id:mime-version:content-transfer-encoding:content-type
        :from:subject:to:cc:in-reply-to:references; s=dkim; bh=kI74M9ymW
        7EHRl29+Eu/hRBf14w=; b=ObKyxVxkVVAmtfyfwlu0J4dyiwdhHe9bWoGMsM0tC
        ryFOEauR7aYVKRVNcZmpA78N6OOqO0C/AI/LvEiQUSatQaoq0A+dGXM5J/Hc9Og/
        9Iw0CX4wQBdZmUGFHeYZOJuS8ga7T8AGvtWBT/Ik1PIPJ9q9rP2jw8/d90nIG/GK
        P7I7MHj+O8cMgWLMVyih0AUBvprMXHzEZFcd9U9Qz+AAK2deF3UnyjzPn33iWzS7
        X30NgU6CcDQze2g5frN58y+ijG7Fe7SIp/Xr/ovZObpV07EK+m4Q8bBRWlajsnKf
        jmRp2nqVmRzmUfcRoINKdCmza5QRhxMwAyZMgp2zTHPwQ==
Received: by genki.is (OpenSMTPD) with ESMTPSA id 76876191 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Tue, 6 Nov 2018 19:23:06 +0000 (UTC)
Date:   Tue, 06 Nov 2018 11:23:05 -0800
Message-ID: <20181106.192305.406697677@genki.is>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
From:   Genki Sky <sky@genki.is>
Subject: Re: [PATCH] Revert "scripts/setlocalversion: git: Make -dirty check
 more robust"
To:     Guenter Roeck <linux@roeck-us.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Christian Kujau <lists@nerdbynature.de>
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <1541527838-4585-1-git-send-email-linux@roeck-us.net>
References: <1541527838-4585-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

On Tue,  6 Nov 2018 10:10:38 -0800, Guenter Roeck <linux@roeck-us.net> wrote:
> This reverts commit 6147b1cf19651c7de297e69108b141fb30aa2349.
>
> The reverted patch results in attempted write access to the source
> repository, even if that repository is mounted read-only.
>
> Output from "strace git status -uno --porcelain":
>
> getcwd("/tmp/linux-test", 129)          = 16
> open("/tmp/linux-test/.git/index.lock", O_RDWR|O_CREAT|O_EXCL|O_CLOEXEC, 0666) =
> 	-1 EROFS (Read-only file system)
>
> While git appears to be able to handle this situation, a monitored build
> environment (such as the one used for Chrome OS kernel builds) may detect
> it and bail out with an access violation error. On top of that, the attempted
> write access suggests that git _will_ write to the file even if a build output
> directory is specified. Users may have the reasonable expectation that the
> source repository remains untouched in that situation.

Hmm, so in summary: According to 6147b1cf1965
("scripts/setlocalversion: git: Make -dirty check more robust",
2018-08-28), one scenario requires the index to be refreshed to get a
correct "dirty" or "not dirty" status. But according to your commit
here, another scenario requires the kernel build system to not even
attempt to update the git index, and doesn't care / aren't impacted by
the cases where the index needs to be refreshed.

Perhaps both scenarios could be satisfied by having
scripts/setlocalversion first check if .git has write permissions, and
acting accordingly. Looking into history, this actually used to be
done, but cdf2bc632ebc ("scripts/setlocalversion on write-protected
source tree", 2013-06-14) removed the updating of the index.

However, I admit I don't understand the justification in that commit
from 2013. I'm no NFS expert, but perhaps the real problem there is an
incorrectly configured NFS setup (uid/gid mismatch between NFS
client/server, or permissions mismatch between mount options and NFS
server?). Christian Kujau: can you speak to that?

Well, we could also make our check $(touch .git/some-file-here
2>/dev/null && ...) instead of $(test -w .git) to handle misconfigured
NFS setups. But not sure if that has its own problems.

Thoughts? It'd be nice to find a fix that works for everyone.

Genki
