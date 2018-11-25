Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE723C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 10:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A69B20855
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 10:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b="d62F/ZMM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A69B20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mork.no
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbeKYVMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 16:12:49 -0500
Received: from canardo.mork.no ([148.122.252.1]:58855 "EHLO canardo.mork.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727182AbeKYVMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 16:12:49 -0500
Received: from miraculix.mork.no (miraculix.mork.no [IPv6:2001:4641:0:2:7627:374e:db74:e353])
        (authenticated bits=0)
        by canardo.mork.no (8.15.2/8.15.2) with ESMTPSA id wAPALFfl021379
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 25 Nov 2018 11:21:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
        t=1543141280; bh=GQ7JoFg+9gLkKCbYtNyJZSPyRA1X/0rXdvEjJ5dzcs4=;
        h=From:To:Cc:Subject:References:Date:Message-ID:From;
        b=d62F/ZMM1d/JsX+bSWdDAiy6QqGT9NOTlaBfZf12FodDZdUyQH2R6CzSPJHkFqGHN
         neOKSEvp9AhHP2y59xa8lYZj0m/XOBkmGw5OuuvVEvn3daAonTRydBJsqvzPr+zeFM
         C5xAmtQImGuYqzwDOWEo+EqyTwuRkSdD58vj7t8I=
Received: from bjorn by miraculix.mork.no with local (Exim 4.89)
        (envelope-from <bjorn@mork.no>)
        id 1gQrXO-00012n-IL; Sun, 25 Nov 2018 11:21:14 +0100
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
Date:   Sun, 25 Nov 2018 11:21:14 +0100
In-Reply-To: <20181124232327.t3awc6dnjqdtvzwu@dcvr> (Eric Wong's message of
        "Sat, 24 Nov 2018 23:23:27 +0000")
Message-ID: <87in0l31b9.fsf@miraculix.mork.no>
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
> Eric Wong <e@80x24.org> wrote:
>> The above setting with this change and the following keymap
>> preserves my sanity on the atrocious adaptive keyboard on
>> the 2nd-gen X1 Carbon:
>
> Any comments on this patch?  The Esc and F-keys on the keyboard
> are still numb and I'll be getting rid of the laptop in a few
> days; but maybe my patch can still be useful to others...

I've read through and I like it, FWIW.  A brilliant idea. I don't have
the hardare to test the patch, though....

But I do wonder if you aren't missing an empty mask protection
somewhere?  If I read this right, then there is nothing preventing you
from writing 0 here:

> +static ssize_t adaptive_kbd_modes_store(struct device *dev,
> +			struct device_attribute *attr,
> +			const char *buf, size_t count)
> +{
> +	unsigned long t;
> +
> +	if (parse_strtoul(buf, (1 << LAYFLAT_MODE) - 1, &t))
> +		return -EINVAL;
> +
> +	adaptive_kbd_modes =3D (unsigned int)t;
> +	return count;
> +}


And then I believe you have a busy loop here:

> @@ -3815,20 +3838,20 @@ static int adaptive_keyboard_set_mode(int new_mod=
e)
>=20=20
>  static int adaptive_keyboard_get_next_mode(int mode)
>  {
> -	size_t i;
> -	size_t max_mode =3D ARRAY_SIZE(adaptive_keyboard_modes) - 1;
> -
> -	for (i =3D 0; i <=3D max_mode; i++) {
> -		if (adaptive_keyboard_modes[i] =3D=3D mode)
> -			break;
> -	}
> +	int max_mode =3D fls(adaptive_kbd_modes);
> +	int new_mode =3D mode >=3D max_mode ? HOME_MODE : mode + 1;
>=20=20
> -	if (i >=3D max_mode)
> -		i =3D 0;
> -	else
> -		i++;
> +	/* make sure the new mode is allowed by the user */
> +	while (!(adaptive_kbd_modes & (1 << new_mode))) {
> +		new_mode++;
> +		if (new_mode > max_mode)
> +			new_mode =3D HOME_MODE;
>=20=20
> -	return adaptive_keyboard_modes[i];
> +		/* maybe the user disabled all other modes: */
> +		if (new_mode =3D=3D mode)
> +			return mode;
> +	}
> +	return new_mode;
>  }


Or am I reading this wrong?



Bj=C3=B8rn
