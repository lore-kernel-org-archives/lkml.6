Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDEF9C4321E
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 20:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7408820857
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 20:27:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7408820857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbeIJBSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 21:18:37 -0400
Received: from ms.lwn.net ([45.79.88.28]:38220 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726609AbeIJBSh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 21:18:37 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E05D16D9;
        Sun,  9 Sep 2018 20:27:43 +0000 (UTC)
Date:   Sun, 9 Sep 2018 14:27:41 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Salvatore Mesoraca <s.mesoraca16@gmail.com>
Cc:     kernel-hardening@lists.openwall.com, linux-doc@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH v2] kconfig: add hardened defconfig helpers
Message-ID: <20180909142741.3b87df76@lwn.net>
In-Reply-To: <1536516257-30871-1-git-send-email-s.mesoraca16@gmail.com>
References: <1536516257-30871-1-git-send-email-s.mesoraca16@gmail.com>
Organization: LWN.net
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  9 Sep 2018 20:04:17 +0200
Salvatore Mesoraca <s.mesoraca16@gmail.com> wrote:

> +===============================
> +Hardening Configuration Options
> +===============================
> +
> +This is a list of configuration options that are useful for hardening purposes.
> +These options are divided in 4 levels based on the magnitude of their negative
> +side effects, not on their importance or usefulness:
> +
> +	- **Low**: Negligible performance impact. No user-space breakage.
> +	- **Medium**: Some performance impact and/or user-space breakage for
> +	  few users.
> +	- **High**: Notable performance impact and/or user-space breakage for
> +	  many users.
> +	- **Extreme**: Big performance impact and/or user-space breakage for
> +	  most users.
> +
> +In other words: **Low** level contains protections that *everybody* can and
> +should use; **Medium** level should be usable by *most people* without issues;
> +**High** level may cause *some trouble*, especially from a *performance*
> +perspective; **Extreme** level contains protections that *few people* may want
> +to enable, some people will probably *cherry-pick* some options from here based
> +on their needs.
> +
> +For further details about which option is included in each level, please read
> +the description below, for more information on any particular option refer to
> +their help page.
> +
> +The content of this list is automatically translated into *config fragments*
> +that can be used to apply the suggested hardening options to your current
> +configuration.
> +To use them you just need to run ``make hardened$LEVELconfig`` (e.g.
> +``make hardenedhighconfig``).

Some overall thoughts:

- As Sam asked: who are the users of this feature?  Presumably you have
  some real people out there in mind for each of these levels, or you would
  not have created them?

- Who will maintain it?  The list of hardening-relevant configuration
  options is always in high flux, as our understanding of the security
  implications of each.  This feature will require some significant ongoing
  attention or it will quickly become stale.  I think it needs a
  MAINTAINERS entry.

- It's a little strange to see an RST document used as the input for the
  kernel configuration process.  Assuming this is really the best way to do
  this (and I worry about things like duplicated descriptions of kernel
  configuration options), you should, at a minimum, carefully document the
  format of this file at the beginning.  Otherwise people will surely break
  it.  In fact, they'll break it anyway, so more checking in the processing
  script seems indicated.

  Without having thought it through in great depth, I suspect that a better
  approach might be to find a way to mark the hardening level in the
  Kconfig entries.

- You have ordered the options alphabetically, but that is, I would argue,
  not the best way.  My guess is that people would read this file to answer
  the question of "just how many bullets will hardening level H put into my
  foot?"  So I would sort them by hardening level as the primary key.

Thanks,

jon
