Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE22C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 21:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CEC522510
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 21:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="A30Hi0kK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CEC522510
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbeKNHcu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 02:32:50 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39979 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbeKNHcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 02:32:50 -0500
Received: by mail-wr1-f66.google.com with SMTP id p4so5793072wrt.7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 13:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=eHaN7VjjdTB8ZEamMalE2bKr4KlN2yfkJbiZkT0IUEM=;
        b=A30Hi0kKmLsjuPbnllfhnHEhgl5M34sqYKmcO5N76bZ60asoWQxHv7msRwwP0Ez2HH
         aWclK+fR8jZnbAfEUrOB4e2SQDkU/lMYCkOjK0H7F5b+ZdtL7NVz/T5tYOK1jnbluziT
         EDT6DBGwHYVHGzXB+8/sgzcnywjWfWegx2aa8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=eHaN7VjjdTB8ZEamMalE2bKr4KlN2yfkJbiZkT0IUEM=;
        b=LiW3BA25fLNAifg7YN0UGWyxHqFIYXReIRP2sD2Ul3ktndD4qW19D0aIW1dFUWkCXg
         1BWxuDg2PK04HKy0eT808ggKY+gtFoumT0IocKTrfNsdIQwTlBatZGhR2MgwOtxD1edF
         8q3zlzzkqXK3Q2w6xG+EqfZU16DAPa4xQgvqg1a5uAF/0Y0LpzIirvTP+5WwoYOhR8KF
         itg9cJvgeWDZAohsuHjwaNqTl5Ocy0dHAey1md51sG5Wt0eEoy3Vq0S43PEeFiddSc3B
         XUuf3Df/zqvie5Rg2rFQ414VjfTto5XXGMoL27eYqxkHdT+hWH09WHOYaRx4U0akg5bo
         S+Fg==
X-Gm-Message-State: AGRZ1gKgbNQ0WzQWznh0NpjM5ELSv11hXNokxuVwMfEv9G7xn1MqHdkL
        m2vfAIbjx6JgA0wLx4EO9pzE8A==
X-Google-Smtp-Source: AJdET5fvPHBXVWi/wZUTMfqgJeBBSfFpbbKXBHTaIOf70svYuQY8O90qeTNwgK4q8MHMMTb9iD8qnQ==
X-Received: by 2002:adf:f748:: with SMTP id z8-v6mr6709931wrp.237.1542144766005;
        Tue, 13 Nov 2018 13:32:46 -0800 (PST)
Received: from wychelm.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id e10-v6sm18909123wmg.23.2018.11.13.13.32.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Nov 2018 13:32:45 -0800 (PST)
Date:   Tue, 13 Nov 2018 21:32:42 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Prarit Bhargava <prarit@redhat.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [GIT PULL] kgdb changes for v4.20-rc3
Message-ID: <20181113213242.GA18288@wychelm.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus

Normally pull requests for kgdb come from Jason Wessel but he's seems to
have been struggling for time this dev cycle so I've stepped in. That
I've put this together at (somewhat past) the last minute goes some way
to explaining why I've included some -Wimplicit-fallthrough fixes here.


The following changes since commit ccda4af0f4b92f7b4c308d3acc262f4a7e3affad:

  Linux 4.20-rc2 (2018-11-11 17:12:31 -0600)

are available in the Git repository at:

  https://git.linaro.org/people/daniel.thompson/linux.git tags/kgdb-fixes-4.20-rc3

for you to fetch changes up to 646558ff1643467d3b941b47f519867cbca462c3:

  kdb: kdb_support: mark expected switch fall-throughs (2018-11-13 20:38:50 +0000)

----------------------------------------------------------------
kgdb fixes for 4.20-rc3

The most important changes here are two fixes for kdb regressions causes by
the hashing of %p pointers together with a fix for a potential overflow in
kdb tab completion handling (and warning fix).

Also included are a set of changes in preparation to (eventually) enable
-Wimplicit-fallthrough.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>

----------------------------------------------------------------
Christophe Leroy (2):
      kdb: use correct pointer when 'btc' calls 'btt'
      kdb: print real address of pointers instead of hashed addresses

Gustavo A. R. Silva (3):
      kdb: kdb_main: refactor code in kdb_md_line
      kdb: kdb_keyboard: mark expected switch fall-throughs
      kdb: kdb_support: mark expected switch fall-throughs

Prarit Bhargava (1):
      kdb: Use strscpy with destination buffer size

 kernel/debug/kdb/kdb_bt.c       |  4 ++--
 kernel/debug/kdb/kdb_io.c       | 15 +++++++++------
 kernel/debug/kdb/kdb_keyboard.c |  4 ++--
 kernel/debug/kdb/kdb_main.c     | 35 ++++++++++-------------------------
 kernel/debug/kdb/kdb_private.h  |  2 +-
 kernel/debug/kdb/kdb_support.c  | 28 ++++++++++++++--------------
 6 files changed, 38 insertions(+), 50 deletions(-)
