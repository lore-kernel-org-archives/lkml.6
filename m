Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28945C46462
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 19:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6BBA2087D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 19:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="dIoeeLut"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6BBA2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbeJKCui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 22:50:38 -0400
Received: from imap.thunk.org ([74.207.234.97]:43664 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727451AbeJKCui (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 22:50:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=m1751EzBL5wKZVOcTFLI0O/3oGPKONj3evea+PPgh54=; b=dIoeeLut59ea/0M0kQpEO/uS8V
        jLZU4wLfghvQC51q6PgS3s2ubXbW1zF9QDC3Eh6FBKW6aD3SCk4idQHSTuNflMPN4brSRl3tu/gDk
        TpUS7HnxcXtRzdYIKfhjjr9fN6yHDFxInjQTxuG6/6Mw15wHrOFcHTGPTgcihjnLNzbo=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1gAK8J-0002rp-4v; Wed, 10 Oct 2018 19:26:59 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 6575E7A7902; Wed, 10 Oct 2018 15:26:58 -0400 (EDT)
Date:   Wed, 10 Oct 2018 15:26:58 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.cz>,
        Eric Biggers <ebiggers@google.com>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [PATCH] ext4: avoid unused variable warning
Message-ID: <20181010192658.GA27646@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.cz>,
        Eric Biggers <ebiggers@google.com>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
References: <20181010142813.1918180-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181010142813.1918180-1-arnd@arndb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 04:27:58PM +0200, Arnd Bergmann wrote:
> The two new variables are only used in an #ifdef, so they cause a
> warning without CONFIG_QUOTA:
> 
> fs/ext4/super.c: In function 'parse_options':
> fs/ext4/super.c:1977:26: error: unused variable 'grp_qf_name' [-Werror=unused-variable]
>   char *p, *usr_qf_name, *grp_qf_name;
>                           ^~~~~~~~~~~
> fs/ext4/super.c:1977:12: error: unused variable 'usr_qf_name' [-Werror=unused-variable]
>   char *p, *usr_qf_name, *grp_qf_name;
> 
> Fixes: 20cefcdc2040 ("ext4: fix use-after-free race in ext4_remount()'s error path")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Hmm, I wonder if we should do something like:

#define EXT4_UNUSED_VAR __attribute__ ((unused))

and then we could do:

	char *p, *usr_qf_name EXT4_UNUSED_VAR, *grp_qf_name EXT4_UNUSED_VAR;

More generally, I wonder if this is something we should have defined
for the whole kernel, as opposed to a one-off hack that ACPI and ext4
subsystems use.  It's a little ugly, but I think it's much nicer than
having extra #ifdefs such as:

	char *p;
#ifdef CONFIG_QUOTA
	char *usr_qf_name, *grp_qf_name;
#endif

After all, the compiler is perfectly capable of ignoring variables
which are unused.  And if it's only because of an #ifdef later in the
function, it would be nice to not have an extra #ifdef in the variable
declarations.

						- Ted
