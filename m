Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C446C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B95F22086E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bHxwnf7t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B95F22086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbeIZViM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 17:38:12 -0400
Received: from mail-qt1-f182.google.com ([209.85.160.182]:43436 "EHLO
        mail-qt1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbeIZViM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 17:38:12 -0400
Received: by mail-qt1-f182.google.com with SMTP id l16-v6so17148902qtq.10
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 08:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M1Mu4HTGr6tYBVCLlVcAnCqXE/txgEzqWDLbdEAh984=;
        b=bHxwnf7ti2o1MNhuHYHOw01C5sJOkdA73aC2FF7vJOKGsFdpA/N+i47Lqwy3tiuwQE
         MA5bSnsZJsMHS5NNlDgNJpDSJXv7STXvM4dhi3uXo7P+5ovFVu2mb7VOLluC+yP2TArW
         4Oi5hTYNdysPKURdK0ozS0lpbw65NgNcS4uzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=M1Mu4HTGr6tYBVCLlVcAnCqXE/txgEzqWDLbdEAh984=;
        b=DCASgWK0CmDZc1af3KhooIwd4sD9UCJWVgTBYLMJqgWsl1sigNe0KlEJqKaQ6imfFf
         x2C3dTsczWDdVPpVwZyW0sodeUQqfWSEOMNvghk0UbLyQ8ZA+W1yWgWg6PlCsLPkXLkl
         SUrr0TM61C8Oo159TCkJB8UKAnPy+OiB3qED9tl2AyPHafa+kxjaCUd91fOVGRf1Q8uQ
         XSXilCBMxNhiLp+OnhletAsuEoySxQGbHspuTsIx/4jXF7+cxFuiOam/OwOY2frCij1b
         k7tCVA2Q1Dgbu48ockDjGFEUELyrZMQSEUv4OMwIpXdJT3nAWJ9iRcwwnmFAfz2IbRVd
         om6Q==
X-Gm-Message-State: ABuFfojyZNOK7sac75/nOalgkWlIzqyHFXlCycNH+/19lS/D7a7mnMmH
        EjU4QUif66KglaBhXALvUfr3FHA0WQaTVw==
X-Google-Smtp-Source: ACcGV62B9xmgul71YIHZw/sdl+3qlfwFbM4QaP7c+xQdIsdTjLB9G3hAlNEV+xo2MHdK/qXtRjgwvg==
X-Received: by 2002:a0c:87ba:: with SMTP id 55-v6mr4667089qvj.202.1537975484442;
        Wed, 26 Sep 2018 08:24:44 -0700 (PDT)
Received: from chatter ([184.75.214.131])
        by smtp.gmail.com with ESMTPSA id u21-v6sm3075052qka.88.2018.09.26.08.24.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 08:24:43 -0700 (PDT)
Date:   Wed, 26 Sep 2018 11:25:23 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        Andrea Argangeli <andrea@kernel.org>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Stefan Priebe - Profihost AG <s.priebe@profihost.ag>,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: linux-mm@ archive on lore.kernel.org (Was: [PATCH 0/2] thp
 nodereclaim fixes)
Message-ID: <20180926152523.GA8154@chatter>
Mail-Followup-To: "Kirill A. Shutemov" <kirill@shutemov.name>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        Andrea Argangeli <andrea@kernel.org>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Stefan Priebe - Profihost AG <s.priebe@profihost.ag>,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
References: <20180925120326.24392-1-mhocko@kernel.org>
 <20180926130850.vk6y6zxppn7bkovk@kshutemo-mobl1>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
In-Reply-To: <20180926130850.vk6y6zxppn7bkovk@kshutemo-mobl1>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 26, 2018 at 04:08:50PM +0300, Kirill A. Shutemov wrote:
>On Tue, Sep 25, 2018 at 02:03:24PM +0200, Michal Hocko wrote:
>> Thoughts, alternative patches?
>>
>> [1] http://lkml.kernel.org/r/20180820032204.9591-1-aarcange@redhat.com
>> [2] http://lkml.kernel.org/r/20180830064732.GA2656@dhcp22.suse.cz
>> [3] http://lkml.kernel.org/r/20180820032640.9896-2-aarcange@redhat.com
>
>All these links are broken. lore.kernel.org doesn't have linux-mm@ archive.
>
>Can we get it added?

Adding linux-mm to lore.kernel.org certainly should happen, but it will=20
not fix the above problem, because lkml.kernel.org/r/<foo> links only=20
work for messages on LKML, not for all messages passing through vger=20
lists (hence the word "lkml" in the name).

Once linux-mm is added, you should link to those discussions using=20
lore.kernel.org/linux-mm/<msgid> links.

-K

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQR2vl2yUnHhSB5njDW2xBzjVmSZbAUCW6uk4wAKCRC2xBzjVmSZ
bJwRAQCMjR606Nwvm/8ppqVhjAIW0Nak0uvZWnyjcUZqt8xLmgD9HDeVOPWIE77M
1X7L6stT5sKJjgA6RIG3buA8XFQlvAY=
=mlkK
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
