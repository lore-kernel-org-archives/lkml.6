Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6553BC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 15:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04F832084E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 15:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b="Am0S+l0v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04F832084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mork.no
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbeKZCdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 21:33:11 -0500
Received: from canardo.mork.no ([148.122.252.1]:42755 "EHLO canardo.mork.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726226AbeKZCdL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 21:33:11 -0500
Received: from miraculix.mork.no (miraculix.mork.no [IPv6:2001:4641:0:2:7627:374e:db74:e353])
        (authenticated bits=0)
        by canardo.mork.no (8.15.2/8.15.2) with ESMTPSA id wAPFfG7N010168
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 25 Nov 2018 16:41:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
        t=1543160478; bh=2KAkplTJhGzzvyoPKCDSLroA5gHvmKhAYlkFOqKCpWk=;
        h=From:To:Cc:Subject:References:Date:Message-ID:From;
        b=Am0S+l0vYCmOLrFi3IMRBWwJaJLTmcztdJIdTr3VPPrYwc0x7wjC8wERgXajK6Y+0
         Yui4jEzJOZxyeziKGVQx0S3WdffI8FtQUXx/227Ert5ajUugni6td1CcL2b88tCVyF
         n/56jZCocZ1mncBuLas/AfSAH/mZfhB1pAQnmP+U=
Received: from bjorn by miraculix.mork.no with local (Exim 4.89)
        (envelope-from <bjorn@mork.no>)
        id 1gQwX5-0003Ie-TH; Sun, 25 Nov 2018 16:41:15 +0100
From:   =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To:     Eric Wong <e@80x24.org>
Cc:     Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        Shuduo Sang <shuduo.sang@canonical.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        linux-kernel@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH] platform/x86: thinkpad_acpi: add adaptive_kbd_modes parameter
Organization: m
References: <20181115073429.z44czywrf7f65ndb@dcvr>
        <20181124232327.t3awc6dnjqdtvzwu@dcvr>
        <87in0l31b9.fsf@miraculix.mork.no>
        <20181125144441.xpwuov2i7lab3agh@dcvr>
Date:   Sun, 25 Nov 2018 16:41:15 +0100
In-Reply-To: <20181125144441.xpwuov2i7lab3agh@dcvr> (Eric Wong's message of
        "Sun, 25 Nov 2018 14:44:41 +0000")
Message-ID: <87zhtx17xg.fsf@miraculix.mork.no>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.100.2 at canardo
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Wong <e@80x24.org> writes:
> Bj=C3=B8rn Mork <bjorn@mork.no> wrote:
>
>> And then I believe you have a busy loop here:
>>=20
>> > @@ -3815,20 +3838,20 @@ static int adaptive_keyboard_set_mode(int new_=
mode)
>> >=20=20
>> >  static int adaptive_keyboard_get_next_mode(int mode)
>> >  {
>> > -	size_t i;
>> > -	size_t max_mode =3D ARRAY_SIZE(adaptive_keyboard_modes) - 1;
>> > -
>> > -	for (i =3D 0; i <=3D max_mode; i++) {
>> > -		if (adaptive_keyboard_modes[i] =3D=3D mode)
>> > -			break;
>> > -	}
>> > +	int max_mode =3D fls(adaptive_kbd_modes);
>> > +	int new_mode =3D mode >=3D max_mode ? HOME_MODE : mode + 1;
>> >=20=20
>> > -	if (i >=3D max_mode)
>> > -		i =3D 0;
>> > -	else
>> > -		i++;
>> > +	/* make sure the new mode is allowed by the user */
>> > +	while (!(adaptive_kbd_modes & (1 << new_mode))) {
>> > +		new_mode++;
>> > +		if (new_mode > max_mode)
>> > +			new_mode =3D HOME_MODE;
>> >=20=20
>> > -	return adaptive_keyboard_modes[i];
>> > +		/* maybe the user disabled all other modes: */
>> > +		if (new_mode =3D=3D mode)
>> > +			return mode;
>> > +	}
>> > +	return new_mode;
>> >  }
>
> Not a busy loop, since new_mode will reset at HOME_MODE (0)
> and then it'll hit "new_mode =3D=3D mode" and remain locked in
> to the current mode.

Right.  I see it now.  Thanks for explaining.

I guess I was expecting a complete loop bypass ala

  if (!max_mode)
     return mode:

but your solution will of course work just as fine.



Bj=C3=B8rn
