Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AFF5C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B444C20818
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=genki.is header.i=@genki.is header.b="mi3xGCEB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B444C20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=genki.is
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbeKHGQD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 01:16:03 -0500
Received: from genki.is ([104.200.25.21]:43216 "EHLO genki.is"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726517AbeKHGQD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 01:16:03 -0500
Received: by genki.is (OpenSMTPD) with ESMTP id 707560a6;
        Wed, 7 Nov 2018 20:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=genki.is; h=date
        :message-id:mime-version:content-transfer-encoding:content-type
        :from:subject:to:cc:in-reply-to:references; s=dkim; bh=KC7lH5+j5
        kdrLgP6UaMw+u32l6s=; b=mi3xGCEBpMZCFBDlKa1nAfQNRVNKVlMceD9pcqhM/
        vVg5SlNX7gtChr8WrGhESCjivIqklKLQnFAtEcW2vGNP2YwRX/tl/jOh/l25AFqn
        O79tFWw6gm2xAOdjUK8k8mQ1fsX5BxUz6axZolNm5kFpT2IE4AJ1K4Aia8VKoAmk
        KbEsZBro7wRU4YqJAARCDb/AoGdw6xZYFH/pom34z/p6e9+RhF5MnMHVv+7oGCo8
        dOSgGGUVRUS/UWmYw0wIsPslT+iZaIO0UkGFAYab0nAdK7QMFvFVgS/blHdWRXDj
        wEwPJ2H3cBmB+1BxNK003fCnXLuQcLELTzR/XT5PWhaTg==
Received: by genki.is (OpenSMTPD) with ESMTPSA id b4859263 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Wed, 7 Nov 2018 20:43:58 +0000 (UTC)
Date:   Wed, 07 Nov 2018 12:43:58 -0800
Message-ID: <20181107.204358.257636196@genki.is>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
From:   Genki Sky <sky@genki.is>
Subject: Re: [PATCH] Revert "scripts/setlocalversion: git: Make -dirty check
 more robust"
To:     Brian Norris <briannorris@chromium.org>, lists@nerdbynature.de
Cc:     Guenter Roeck <linux@roeck-us.net>, yamada.masahiro@socionext.com,
        Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20181107184435.GA168339@google.com>
References: <1541527838-4585-1-git-send-email-linux@roeck-us.net>
        <20181106.192305.406697677@genki.is> <20181107022156.GA254567@google.com>
        <alpine.DEB.2.21.999.1811061845161.5308@trent.utfs.org>
        <CA+ASDXPMMXCBN6PU8qzRm579sC9VBdwnxZdZwRdPY1cBUP8oGQ@mail.gmail.com>
        <20181107184435.GA168339@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Nov 2018 10:44:37 -0800, Brian Norris <briannorris@chromium.org> wrote:
> On Tue, Nov 06, 2018 at 08:00:36PM -0800, Brian Norris wrote:
> > On a different tangent: how about the --no-optional-locks (see
> > git(1))? Will this get you your "up-to-date" result without writing to
> > the .git directory? I've only read the documentation, but not tested
> > it.

This option definitely seems to be what we want, good find.

> Unfortunately, --no-optional-locks is new as of git 2.14. Dunno how new
> of a git we expect people to use.

Hmm, I'm not sure who can speak to this.

Though if it's too recent, then based on earlier discussion, it sounds
like something like this (hack) might work best:

  [ -w .git ] &&
          touch .git/some-file-here 2>/dev/null &&
          git update-index --refresh --unmerged >/dev/null
  if git diff-index --name-only HEAD | ...
