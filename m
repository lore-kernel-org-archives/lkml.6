Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F07E0C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 11:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A749420836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 11:03:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A749420836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754320AbeFTLDi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 07:03:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:40655 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754291AbeFTLDh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 07:03:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 03DC3AEB0;
        Wed, 20 Jun 2018 11:03:36 +0000 (UTC)
Date:   Wed, 20 Jun 2018 13:03:35 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: Make CONSOLE_LOGLEVEL_QUIET configurable
Message-ID: <20180620110335.sjzmtra2z3chvon2@pathway.suse.cz>
References: <20180619115726.3098-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619115726.3098-1-hdegoede@redhat.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2018-06-19 13:57:26, Hans de Goede wrote:
> The goal of passing the "quiet" option to the kernel is for the kernel
> to be quiet unless something really is wrong.
> 
> Sofar passing quiet has been (mostly) equivalent to passing
> loglevel=4 on the kernel commandline. Which means to show any messages
> with a level of KERN_ERR or higher severity on the console.
> 
> In practice this often does not result in a quiet boot though, since
> there are many false-positive or otherwise harmless error messages printed,
> defeating the purpose of the quiet option. Esp. the ACPICA code is really
> bad wrt this, but there are plenty of others too.

I see your pain. But this sounds like a workaround for a broken code.
This change might just encourage people to create even more mess.


> This commit makes CONSOLE_LOGLEVEL_QUIET configurable.
> 
> This for example will allow distros which want quiet to really mean quiet
> to set CONSOLE_LOGLEVEL_QUIET so that only messages with a higher severity
> then KERN_ERR (CRIT, ALERT, EMERG) get printed, avoiding an endless game
> of whack-a-mole silencing harmless error messages.

I find it a bit confusing that "quiet" would mean something different
on different systems.

Why did not you use loglevel=<whatever_you_need> instead of "quiet"?

Alternative solution would be to add "silent" or so to calm down
everything. But I am afraid that any change in this area would
just create a mess similar to grep -s and -q options.


Best Regards,
Petr

PS: I will not block it if Steven and Sergey are fine with this. But
I want to be sure that they considered the above views. It looked like
a no-brainer to me at the beginning. I even pushed this to printk.git.
But the pushing gave me some more time to think about it...
