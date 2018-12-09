Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2631C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 08:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D747720837
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 08:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=g.ncu.edu.tw header.i=@g.ncu.edu.tw header.b="Zn7Ms/Ig"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D747720837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=g.ncu.edu.tw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbeLII1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 03:27:16 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36275 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbeLII1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 03:27:15 -0500
Received: by mail-oi1-f196.google.com with SMTP id x23so6698768oix.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Dec 2018 00:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=g.ncu.edu.tw; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4LKuPhYhw/uNr9uh6WrEzHch/ERmy/ZnGKpU1w1jWcw=;
        b=Zn7Ms/IgR4A7LmCpIUzt085XB9OcD7tF4E+Xwv2QbN9GRrKUDfTaAwclulKdw+8G/1
         vtCTb/rRR1PuA+OqkbfJjOBXcmZnuqoTSxjvGNRDyZGX+L5cah1qwtX830h1Zl879b7+
         bn5oOvdLppQ8K4hp3xOutPpJc1vh5W6TMWtTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4LKuPhYhw/uNr9uh6WrEzHch/ERmy/ZnGKpU1w1jWcw=;
        b=P84lGrny8APQU6VAs3+MyoGK3Bp2+I6xkio/T7fJYT2BgISncSepwb5QtehOeSP2Eq
         R5OihQ5RWJj/0ZdRWpwzqNwKWVljfd7JivxP1UXOkkpIQYLc1cIMANVFbCMdC26Ac8Jk
         eGMlooeasZY9IzQNBx2fheCL/JiLoTv3Oe/jUqIbfyGxXo8LqS2Pw12NUEFBFdGkmwkU
         QjVj3CIeeBjKyJtU/MEfW1tyK6CDzgoGGIJoLDwhlbtyUOPF8r5ZQskrb9mbHi5Qk/k3
         CtuhN0sFNbDt5UZ7bHFFnDohUOq90IiBJWgt6UBD4eebZLm5wkYlS/h3jfuGR4c2rh/+
         Vymg==
X-Gm-Message-State: AA+aEWbKcnYKTUuxXIx5la5igB9Q2VMp2zeLaP1ndjdhfgAM/+1atTHV
        l2r2SL485dWg6rfQYW3Q9b2UZA==
X-Google-Smtp-Source: AFSGD/WX/jc3EhNaXB1XCeWlGuSP0rcd5pzKKzEHJ33vAqPXNruT6mb9I4VnKy5bKhQpKPeNuEL6BQ==
X-Received: by 2002:aca:ec55:: with SMTP id k82mr4700605oih.55.1544344032387;
        Sun, 09 Dec 2018 00:27:12 -0800 (PST)
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com. [209.85.210.41])
        by smtp.gmail.com with ESMTPSA id h24sm3519781otq.11.2018.12.09.00.27.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 00:27:11 -0800 (PST)
Received: by mail-ot1-f41.google.com with SMTP id f18so7655269otl.11;
        Sun, 09 Dec 2018 00:27:11 -0800 (PST)
X-Received: by 2002:a9d:e8c:: with SMTP id 12mr5903831otj.297.1544344030991;
 Sun, 09 Dec 2018 00:27:10 -0800 (PST)
MIME-Version: 1.0
References: <CAC=mGzhs0smXzRxn1k9jDFsaLNAkpCd7rMs--E-SafQVTob7JQ@mail.gmail.com>
 <20181204141341.4353-6-starnight@g.ncu.edu.tw> <20181204204508.3ebead06@alans-desktop>
In-Reply-To: <20181204204508.3ebead06@alans-desktop>
From:   Jian-Hong Pan <starnight@g.ncu.edu.tw>
Date:   Sun, 9 Dec 2018 16:27:15 +0800
X-Gmail-Original-Message-ID: <CAC=mGziyi1ierhg++SUcHMrq1JQ0vH4gZCKUZgchzb8aD1Rv5Q@mail.gmail.com>
Message-ID: <CAC=mGziyi1ierhg++SUcHMrq1JQ0vH4gZCKUZgchzb8aD1Rv5Q@mail.gmail.com>
Subject: Re: [PATCH V4 5/6] net: maclorawan: Implement maclorawan class module
To:     Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        "<linux-arm-kernel@lists.infradead.org\\" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org>," <linux-kernel@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Dollar Chen <dollar.chen@wtmec.com>,
        Ken Yu <ken.yu@rakwireless.com>,
        linux-wpan - ML <linux-wpan@vger.kernel.org>,
        Stefan Schmidt <stefan@datenfreihafen.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I made a fake skb and passed it to lrw_parse_frame() function for
testing.  I use print_hex_dump() function to show the skb's content.
Here is the original content in the skb->data and the length is 20 bytes.

[   33.732033] 00000000: 40 04 03 02 01 00 00 00 00 27 76 d3 2d 1b 79
a0  @........'v.-.y.
[   33.732065] 00000010: 18 38 fb a6                                      .8..

Byte 0: MHDR field, value is 0x40.
Byte 1 ~ 4: DevAddr field, value is 0x04 0x03 0x02 0x01.
Byte 5: FCtrl field, value is 0x00.
Byte 6 ~ 7: FCnt field, value is 0x00 0x00.
Byte 8: FPort field, value is 0x00.
Byte 9 ~ 15: Encrypted payload
Byte 16 ~ 19: MIC field value is 0x18 0x38 0xfb 0xa6.

> > +void
> > +lrw_parse_frame(struct lrw_session *ss, struct sk_buff *skb)
> > +{
> > +     struct lrw_fhdr *fhdr = &ss->rx_fhdr;
> > +     __le16 *p_fcnt;
> > +
> > +     pr_debug("%s: %s\n", LORAWAN_MODULE_NAME, __func__);
> > +
> > +     /* Get message type */
> > +     fhdr->mtype = skb->data[0];
> > +     skb_pull(skb, LRW_MHDR_LEN);

print_hex_dump skb here:
[   33.732202] 00000000: 04 03 02 01 00 00 00 00 27 76 d3 2d 1b 79 a0
18  ........'v.-.y..
[   33.732204] 00000010: 38 fb a6

> This does not seem robust. There is no point at which you actually check
> the message size is valid etc

Thanks!  It is a potential bug.
It should check skb->len >= length of MHDR + DevAddr + FCtrl + FCnt + MIC.
These are required fields for (Un)confirmed Data Up/Down messages.


print_hex_dump skb here:
[   33.732211] 00000000: 00 27 76 d3 2d 1b 79 a0 18 38 fb a6
   .'v.-.y..8..

> > +     fhdr->fopts_len = fhdr->fctrl & 0xF;
> > +     if (fhdr->fopts_len > 0) {
> > +             memcpy(fhdr->fopts, skb->data, fhdr->fopts_len);
> > +             skb_pull(skb, fhdr->fopts_len);
> > +     }

print_hex_dump skb here:
[   33.732213] 00000000: 00 27 76 d3 2d 1b 79 a0 18 38 fb a6
   .'v.-.y..8..

> In fact you appear to copy random kernel memory into a buffer

It copied fhdr->fopts_len bytes from skb->data to fhdr->fopts if
fhdr->fopts_len > 0.
https://www.kernel.org/doc/html/latest/core-api/kernel-api.html?highlight=memcpy#c.memcpy

> > +
> > +     /* TODO: Parse frame options */
> > +
> > +     /* Remove message integrity code */
> > +     skb_trim(skb, skb->len - LRW_MIC_LEN);

print_hex_dump skb here:
[   33.732216] 00000000: 00 27 76 d3 2d 1b 79 a0
   .'v.-.y.

> and then try and trim the buffer to a negative size ?

It removed 4 tail bytes (MIC).  (skb->len - LRW_MIC_LEN) is the final
new length as skb_trim()'s 2nd argument len.
https://www.kernel.org/doc/html/latest/networking/kapi.html?highlight=skb_trim#c.skb_trim

I found another bug which did not initialize rx_skb_list.  So,
lrw_parse_frame() may be passed a mystery skb.

Please keep reviewing.  That is appreciated.

Thank you,
Jian-Hong Pan
