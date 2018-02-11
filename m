Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x2270zopBdXNElS8XWQF35lsjsYtiM/5y2m8OjCdiyfoiX0M5zi/2rlNeWY3DvtCMzEiGuLtz
ARC-Seal: i=1; a=rsa-sha256; t=1518348119; cv=none;
        d=google.com; s=arc-20160816;
        b=oxVdBBhZDJ14qnyJFHQG4M8LhN70+zdyB9C6dp9tGUoszQUtckFZK6Gchg8+lMb1OR
         lDXP/3vpcnPcanKhu3tZWetDFd4x4/86DTogrALsAIVt4YgWFeuszNG5OpcdT4niADZz
         i8m8lZt2TzuzyDmpE/Nsd7aL+7Y2Lp0OFke1hqxLPDLxTNtGvaSQ5g8w/G9/nJTyP6+7
         8q6DtzY6sWG/MZgPrCdKpnBQE02VpPDGtCdwGDzOp6diqcjK2KWw1txqTQnMEOr8hjNc
         kgb7ZzayKT7VhrCIeCMHFK+BDzSqMRzVW8c55z6eAKffnPVOUD+QxwOgzrXLAc0XJRgQ
         IMjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:user-agent:in-reply-to
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=VAy+g+qSEgXq37gpouYRGFo071MaqXa3cgI+LAAgGvE=;
        b=pEJ4nVPGJNNJa8wB83NaNlHQcQnHGhgo7bUYd1HoaUMvyGjxXTOxiMDQIagm4dQIqx
         L8QWAtmDwm2aysMcSmjxUBnppupfL4KQ2ZzBwWw8LZZVTSvi4Uo6oPLtX5RQi+PG9M27
         vUQBC0SbKdvghAaJCaCEQBQEEzFLsXr1YVgKx5RCPvff1hMYcolwe6rag91DSk1ptw0q
         h7kds0EbEsGGfgtLsXkx1+D65vqbYVyOlOxHOhEEsKwipvMZccHpo9Aa8geBJyX1sps1
         bfq7RMqYzyyExnGT2hmDHMybW0TEiI+1nTXcfrqL4iYMl7O2znjkCOP5M5P2WYkTzGrw
         pZIQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@gmail.com header.s=20161025 header.b=RpySd9di;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@gmail.com header.s=20161025 header.b=RpySd9di;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753045AbeBKLV7 (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Sun, 11 Feb 2018 06:21:59 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54506 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753024AbeBKLV6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 11 Feb 2018 06:21:58 -0500
Date: Sun, 11 Feb 2018 12:21:53 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        x86@kernel.org, shuah@kernel.org,
        Andrew Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 2/5] selftests/x86: fix vDSO selftest segfault for
 vsyscall=none
Message-ID: <20180211112153.f2ni5mcuut6f6zvq@gmail.com>
References: <20180211111013.16888-1-linux@dominikbrodowski.net>
 <20180211111013.16888-3-linux@dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180211111013.16888-3-linux@dominikbrodowski.net>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592102766376680865?=
X-GMAIL-MSGID: =?utf-8?q?1592103397626880432?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


* Dominik Brodowski <linux@dominikbrodowski.net> wrote:

> +		char name[128];
> +		if (sscanf(line, "%p-%p %c-%cp %*x %*x:%*x %*u %s",
> +			   &start, &end, &r, &x, name) != 5)

So that's a buffer overflow waiting to happen, if a line in 'maps' gets too large, 
right?

Thanks,

	Ingo
