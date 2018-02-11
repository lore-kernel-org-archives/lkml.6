Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x226TthLcKjmU2RewT0Hgieff65daSa1sY3DBEAKL6b/ewvbJCDN+HmPoc6DzMaET3RRQeoLB
ARC-Seal: i=1; a=rsa-sha256; t=1518351437; cv=none;
        d=google.com; s=arc-20160816;
        b=051pZDnLzfMV6x9phE+3SV3MigTpGrutfAGWrJywVDcQb/6U+queqiaLBxc7J0b2Dr
         5T+NADiMTUf72wT1G5tV4dn7IE/JjZupMNHLjagMoOj2ujEHoyn2VFxx/2LDfR899bv3
         C9ibWsW/I9J8z47trj/sDN03serXB34zTEM4+vaBAvgXi2wCNgxnZDa2N4FD9ngH8B/0
         FrwG1p/B3dhAs/JI64yOxZgdv24tgAp75Ai6X6s6+OV3igZDrjWcHLqiIVQ7eEM3QsNI
         V/rKDGGqBbQAlWL1SAzUmaoOq3qIL+qWogEQ1W+tjDa3yOghmZFEZZATErhLh4kw1vhi
         VG0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:user-agent:in-reply-to
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=pP2KrT1Dvj4CjhwririfVAfdanPWfSR8OuYSW3pMsy4=;
        b=tST7Aa6K+uRJFRwvdHAnRWaagj8TMorgipiSC5ytKTPWayl02q4rn1R0z6/flsQhEI
         OCxoHmf+3sdy9zQdpSzijFioqz1kJe43SKob5J6i1Fjfkyu3BoEq263AnIhQK/4vc3RN
         UE1yGTq++L2UDXYiqF1TYWk6gwvGkUcdRfg81BfRh76u7dwE1o3OwmjXQ1j1WHCePisr
         GefLnEejI+0GrQhITVs763o0PA51qi5n2zsN7GOibmDBVYT1PrCrXF8EYxo+f6x+IDvx
         B4dFOUm/ZmJhkdo7g6kDynOvbYXjdnBuW3DrhoKu2G/l1w+6/aJx9CoWwCU7zIyDgSq5
         n9pg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753092AbeBKMRQ (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Sun, 11 Feb 2018 07:17:16 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:43276 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752640AbeBKMRQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 11 Feb 2018 07:17:16 -0500
Date: Sun, 11 Feb 2018 13:17:14 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        x86@kernel.org, shuah@kernel.org,
        Andrew Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 2/5] selftests/x86: fix vDSO selftest segfault for
 vsyscall=none
Message-ID: <20180211121714.GA11096@isilmar-4.linta.de>
References: <20180211111013.16888-1-linux@dominikbrodowski.net>
 <20180211111013.16888-3-linux@dominikbrodowski.net>
 <20180211112153.f2ni5mcuut6f6zvq@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180211112153.f2ni5mcuut6f6zvq@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592102766376680865?=
X-GMAIL-MSGID: =?utf-8?q?1592106876200876179?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Feb 11, 2018 at 12:21:53PM +0100, Ingo Molnar wrote:
> 
> * Dominik Brodowski <linux@dominikbrodowski.net> wrote:
> 
> > +		char name[128];
> > +		if (sscanf(line, "%p-%p %c-%cp %*x %*x:%*x %*u %s",
> > +			   &start, &end, &r, &x, name) != 5)
> 
> So that's a buffer overflow waiting to happen, if a line in 'maps' gets too large, 
> right?

... as does tools/testing/selftests/x86/test_vsyscall.c already now, right?
Will fix both up with an additional patch.

But a more generic question: Is there a quick, easy but reliable test
available in userspace to determine whether
	int $0x80
	vsyscall
is available on a given system, or will cause a segfault?

Thanks,
	Dominik
