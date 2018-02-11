Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x227sxNKRWmRPkmpyna4eF8DuvF3QArgjvjiZrNNTmIZ/5PBbA8VkEqba+t6rIuN+MOTaXYOf
ARC-Seal: i=1; a=rsa-sha256; t=1518354048; cv=none;
        d=google.com; s=arc-20160816;
        b=oqZkJEgJpIpOgfkfh6jTkJdsZ98QEB4NjQhPClRnxe1Y+UHq+SNp8ms8pNuba33R2x
         zawQmXz42rtwza20NWF/9zRSzCbOz4s+/gw9zunl5ODQQl02YeXaieteJx7lPJUArbWX
         B62Wg5uUIYjFIITYMkixR2Qk95jx7/FXnhX+MdSlqWSJpKUJr12OhhvKi/mPqNxmGsLd
         XoPa+uCgWmP4d4UooD/b88/xY9f2V1CA4z44Drtfd5luzXcpF018657jthUuEMeueP7E
         7MGAdZJ7mA8UqgwCB4GkganBNb1f3K5gVIA7dDYq0TYO71U8OS/oCLg6Z555xVMUESkF
         I/Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:user-agent:in-reply-to
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=PQurkGm3KWe2gyowx0ARhH5zTn3c8AfOstBMzuTgrc4=;
        b=LxuTm3mZxuHeUeAJ2DcA7vSCy0tr16YspNDbY2UjxUrtiouZ4eKximvMlwg6cy4v5/
         M10QTIHQ06WpX5YX6oSYq5dGVn97aqvEiEaEnMP2nKnDma5qwQdC1wlxuK0ni1mpNWn3
         Kroxb9jxSGSTBXQFU0ib6moEXQxxIgO3H2aPafka8qkPQNoqoaE++Q4j62elCik6bFG/
         cTvtt0s4zGX/3N0JZUrByJRmxqtKmD+gg0tvBVfkOAx71lNcVktToYcJLCwmjg/74bTR
         nVXA/Y0TteGz3vZBIcXryDMpvOJljc93Ls3ya8alrf97inZzrJj+DEkrNmj5/mF539JK
         S2BA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753243AbeBKNAs (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Sun, 11 Feb 2018 08:00:48 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:44504 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752597AbeBKNAr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 11 Feb 2018 08:00:47 -0500
Date: Sun, 11 Feb 2018 14:00:29 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        x86@kernel.org, shuah@kernel.org,
        Andrew Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 2/5] selftests/x86: fix vDSO selftest segfault for
 vsyscall=none
Message-ID: <20180211130029.GA23754@light.dominikbrodowski.net>
References: <20180211111013.16888-1-linux@dominikbrodowski.net>
 <20180211111013.16888-3-linux@dominikbrodowski.net>
 <20180211112153.f2ni5mcuut6f6zvq@gmail.com>
 <20180211121714.GA11096@isilmar-4.linta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180211121714.GA11096@isilmar-4.linta.de>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592102766376680865?=
X-GMAIL-MSGID: =?utf-8?q?1592109615215979092?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Feb 11, 2018 at 01:17:14PM +0100, Dominik Brodowski wrote:
> On Sun, Feb 11, 2018 at 12:21:53PM +0100, Ingo Molnar wrote:
> > 
> > * Dominik Brodowski <linux@dominikbrodowski.net> wrote:
> > 
> > > +		char name[128];
> > > +		if (sscanf(line, "%p-%p %c-%cp %*x %*x:%*x %*u %s",
> > > +			   &start, &end, &r, &x, name) != 5)
> > 
> > So that's a buffer overflow waiting to happen, if a line in 'maps' gets too large, 
> > right?
> 
> ... as does tools/testing/selftests/x86/test_vsyscall.c already now, right?
> Will fix both up with an additional patch.

Maybe no fix is needed after all: The fgets() call a few lines above
limits "line" to 127 chars max. So "name" can't even get close to 128
chars, right?

	char line[128];
...
	while (fgets(line, sizeof(line), maps)) {

Thanks,
	Dominik
