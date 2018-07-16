Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC8DECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 15:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECCFE208F7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 15:21:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JDZs33As"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECCFE208F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730702AbeGPPtZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 11:49:25 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:38260 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727374AbeGPPtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 11:49:24 -0400
Received: by mail-it0-f68.google.com with SMTP id v71-v6so21887050itb.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 08:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ryu3NsWRCgZAHLFLDnhrrKcb1QFSmj6/XnLV+bZPNbo=;
        b=JDZs33As1F6aZ0zZ45Gcrjb6viFm8vztd9b/DpCgnfIbwcrRP5tmeLD5kiENjiWtS2
         m3a/OQ3JPSktcwUEYpClWuz99T9LH7p2bWo9SXu+AyOE+p9A7YpXG9lbFRaRqD9FF64k
         jo7XW6Lpl7hw9+wG+yyhGUQusnoVBN5NfvWAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=Ryu3NsWRCgZAHLFLDnhrrKcb1QFSmj6/XnLV+bZPNbo=;
        b=GIOfZv+7HN2YcmRv3U6jV+XHuXYD7qse6pMs1qv9QReYQyeWoqUuw0KP0De9umADnE
         sZXy8rSIQ/KhJ7qW0/YmBIibdPCdioXiOwYpXFFdoR+gRsIPsdioxY/kcP6LAQDW3bWw
         39IorsTxw6VMDmaNjeAZZ0f5WuF2KF6wg7eszu7mqH9GVrH+b6cIA3P6C86644vh4OJN
         8XQ29YQuXE/Jem2b8dZDmo/qtejuy2qv/2RuxG0FVmVvHhRrhom57UpVA3t0Kb9QAKb9
         pPYbvZ02PTi/Oo0BfMhEaFR52emIKeX/XT9WfCDuGvHcdUqy/cBYzBc57//nZlPleJ1C
         93LA==
X-Gm-Message-State: AOUpUlGIHmmmz8f9Ki149StnsoZalN+eMWayYQNp8B/gmT3qAHo1L7r1
        uTwOyPsplCyIV3oYPqpWqK4LeA==
X-Google-Smtp-Source: AAOMgpfCio4OnLADIhqd+wRnGbRBlKo68BCn4+YRJ4DYOj2tLT87EyoaNjr+bO2PTVV3PWeKCCnWUA==
X-Received: by 2002:a24:e506:: with SMTP id g6-v6mr13556935iti.117.1531754489440;
        Mon, 16 Jul 2018 08:21:29 -0700 (PDT)
Received: from chatter (ca2x.mullvad.net. [162.219.176.251])
        by smtp.gmail.com with ESMTPSA id g124-v6sm13349430iog.1.2018.07.16.08.21.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 08:21:27 -0700 (PDT)
Date:   Mon, 16 Jul 2018 11:21:46 -0400
From:   "konstantin@linuxfoundation.org" <konstantin@linuxfoundation.org>
To:     Bart Van Assche <Bart.VanAssche@wdc.com>
Cc:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "luc.vanoostenryck@gmail.com" <luc.vanoostenryck@gmail.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Martin.Uecker@med.uni-goettingen.de" 
        <Martin.Uecker@med.uni-goettingen.de>,
        "miguel.ojeda.sandonis@gmail.com" <miguel.ojeda.sandonis@gmail.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] kernel.h: Avoid that sparse complains about using
 sizeof(void)
Message-ID: <20180716152146.GA1779@chatter>
Mail-Followup-To: Bart Van Assche <Bart.VanAssche@wdc.com>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "luc.vanoostenryck@gmail.com" <luc.vanoostenryck@gmail.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Martin.Uecker@med.uni-goettingen.de" <Martin.Uecker@med.uni-goettingen.de>,
        "miguel.ojeda.sandonis@gmail.com" <miguel.ojeda.sandonis@gmail.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20180705161709.17028-1-bart.vanassche@wdc.com>
 <CAGXu5jJJLh+oMcZ94nkrwCvyJzk6MzOATvt66WC-rHfxGTJh0Q@mail.gmail.com>
 <CA+55aFzYEnZR2GZLR-DwpONjMNYGYoDy+6AWLCVNayWiaZuqoA@mail.gmail.com>
 <CA+55aFynusYJ8OCS_jnQhOEEjrfVhYV5PLxi_XF8ritsWEcP0A@mail.gmail.com>
 <480382ffffcb3008bc317b0c6cec68078e797e27.camel@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
In-Reply-To: <480382ffffcb3008bc317b0c6cec68078e797e27.camel@wdc.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 15, 2018 at 04:07:39AM +0000, Bart Van Assche wrote:
>> Oh,
>>  and I meant to cc Luc on that email, but then forgot. So here he is cc'=
d now.
>
>(+ Konstantin)
>
>Something that is confusing for kernel developers is that the sparse wiki
>(https://sparse.wiki.kernel.org/index.php/Main_Page) refers kernel develop=
ers
>to an outdated sparse tree. Should something be done about this inconsiste=
ncy?
>Should the sparse wiki point at one of Luc's sparse trees or should perhaps
>Luc be granted access to the tree that wiki points at
>(https://git.kernel.org/pub/scm/devel/sparse/sparse.git)?

I believe Luc is working to get the necessary signatures on his PGP key=20
so we can grant him access to the repo at kernel.org. I believe this=20
will be less confusing than modifying the wiki to point to the github=20
fork of the tree.

Best,
Konstantin

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQR2vl2yUnHhSB5njDW2xBzjVmSZbAUCW0y4CQAKCRC2xBzjVmSZ
bAlAAP9rKSWCcF97HmKehA3LtrSRMu+XkjxfOK/fltkReWivWgD+LZVJ0ILJdVZc
6B6LlitGgysTRz50nZRn7E9TQDkxJwY=
=udF8
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
