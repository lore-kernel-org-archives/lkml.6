Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC32C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 21:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADF5C20892
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 21:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=genki.is header.i=@genki.is header.b="VCzRNxd2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADF5C20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=genki.is
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbeKHGjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 01:39:41 -0500
Received: from genki.is ([104.200.25.21]:43230 "EHLO genki.is"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbeKHGjl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 01:39:41 -0500
Received: by genki.is (OpenSMTPD) with ESMTP id 964ecac3;
        Wed, 7 Nov 2018 21:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=genki.is; h=date
        :message-id:mime-version:content-transfer-encoding:content-type
        :from:subject:to:cc:in-reply-to:references; s=dkim; bh=BNry9EZbX
        c5va3/O0oqkiexIwqk=; b=VCzRNxd2q7UvxqxIeT0gbyImqa7UIQUkWEbyFaEU1
        JLVIepqNGuvaBkxW92RP3EtuQL7z0hKI2631bgnJwH3MHQwlmIZZPy3lF/L9vbym
        q8Qm7+VqzPOzqQdVZR0GfTk4JE5iljNP3aayUqPzp6u2dYFRPtz3vAUoF8jp9Xqn
        mdnNU2PmZIucS0VGW77sR2k8l9guQ9gH208lzoJ6EHAWjUcn7JHpmpL4nlgg8nZb
        plyoheZ39unfJcadnyg/c4Hzzv85tdoa25y5OJZb6z7dDTz8h4HyPCopw3V0WIdS
        qagrBT5ylT1kdYToX7qkC4oFn2cQhAFKPu/LUmxcWG25g==
Received: by genki.is (OpenSMTPD) with ESMTPSA id 7f3f5a01 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Wed, 7 Nov 2018 21:07:32 +0000 (UTC)
Date:   Wed, 07 Nov 2018 13:07:31 -0800
Message-ID: <20181107.210731.330601031@genki.is>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
From:   Genki Sky <sky@genki.is>
Subject: Re: [PATCH] Revert "scripts/setlocalversion: git: Make -dirty check
 more robust"
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Brian Norris <briannorris@chromium.org>, lists@nerdbynature.de,
        yamada.masahiro@socionext.com,
        Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20181107205514.GB12273@roeck-us.net>
References: <1541527838-4585-1-git-send-email-linux@roeck-us.net>
        <20181106.192305.406697677@genki.is> <20181107022156.GA254567@google.com>
        <alpine.DEB.2.21.999.1811061845161.5308@trent.utfs.org>
        <CA+ASDXPMMXCBN6PU8qzRm579sC9VBdwnxZdZwRdPY1cBUP8oGQ@mail.gmail.com>
        <20181107184435.GA168339@google.com> <20181107.204358.257636196@genki.is>
        <20181107205514.GB12273@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Nov 2018 12:55:14 -0800, Guenter Roeck <linux@roeck-us.net> wrote:
> I do not think it is a good idea to create a random file in the .git directory
> under any circumstance, and much less so if an output directory was specified,
> no matter if the path is read-only or not. I also still think that it is a
> bad idea to touch the source tree if an output directory was specified.
> It defeats the purpose of specifying an output directory.

I was thinking of touching a pre-existing file like .git/config or
.git/description, which I was hoping would be harmless. But sounds
like that's still not desired?

Okay, I guess one approach is to only refresh the index if $objtree ==
$srctree, by passing some flag to scripts/setlocalversion from
scripts/package/Makefile. Is that what you're thinking? Feels a little
strange, but it seems it'd satisfy everyone.

> Ubuntu 16.04 ships with git version 2.7.4.

Okay. I guess --no-optional-locks is a no-go then.
