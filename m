Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7356C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 16:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F738208E8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 16:33:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F738208E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934535AbeGJQdb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 12:33:31 -0400
Received: from smtp-out6.electric.net ([192.162.217.187]:50464 "EHLO
        smtp-out6.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934101AbeGJQda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 12:33:30 -0400
Received: from 1fcvZt-0004di-UD by out6d.electric.net with emc1-ok (Exim 4.90_1)
        (envelope-from <David.Laight@ACULAB.COM>)
        id 1fcvZv-0004jq-TR; Tue, 10 Jul 2018 09:33:27 -0700
Received: by emcmailer; Tue, 10 Jul 2018 09:33:27 -0700
Received: from [156.67.243.126] (helo=AcuMS.aculab.com)
        by out6d.electric.net with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <David.Laight@ACULAB.COM>)
        id 1fcvZt-0004di-UD; Tue, 10 Jul 2018 09:33:25 -0700
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 10 Jul 2018 17:35:04 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 10 Jul 2018 17:35:04 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Martin KaFai Lau' <kafai@fb.com>, Okash Khawaja <osk@fb.com>
CC:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        "David S. Miller" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH bpf 1/1] bpf: btf: Fix bitfield extraction for big endian
Thread-Topic: [PATCH bpf 1/1] bpf: btf: Fix bitfield extraction for big endian
Thread-Index: AQHUF7OfQA7M1iwM3EWyyOlGSAzC+KSIqAuw
Date:   Tue, 10 Jul 2018 16:35:04 +0000
Message-ID: <457ec72d8d7c4cdd8c112f9c8c91b0e7@AcuMS.aculab.com>
References: <20180709002202.019053555@fb.com>
 <20180709004002.440153594@fb.com>
 <20180709183236.r4b7gzmev5h4lcbw@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20180709183236.r4b7gzmev5h4lcbw@kafai-mbp.dhcp.thefacebook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Outbound-IP: 156.67.243.126
X-Env-From: David.Laight@ACULAB.COM
X-Proto: esmtps
X-Revdns: 
X-HELO: AcuMS.aculab.com
X-TLS:  TLSv1.2:ECDHE-RSA-AES256-SHA384:256
X-Authenticated_ID: 
X-PolicySMART: 3396946, 3397078
X-Virus-Status: Scanned by VirusSMART (c)
X-Virus-Status: Scanned by VirusSMART (s)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin KaFai Lau
> Sent: 09 July 2018 19:33
> On Sun, Jul 08, 2018 at 05:22:03PM -0700, Okash Khawaja wrote:
> > When extracting bitfield from a number, btf_int_bits_seq_show() builds
> > a mask and accesses least significant byte of the number in a way
> > specific to little-endian. This patch fixes that by checking endianness
> > of the machine and then shifting left and right the unneeded bits.
> >
> > Thanks to Martin Lau for the help in navigating potential pitfalls when
> > dealing with endianess and for the final solution.
> >
> > Fixes: b00b8daec828 ("bpf: btf: Add pretty print capability for data with BTF type info")
> > Signed-off-by: Okash Khawaja <osk@fb.com>
> >
> > ---
> >  kernel/bpf/btf.c |   32 +++++++++++++++-----------------
> >  1 file changed, 15 insertions(+), 17 deletions(-)
> >
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -162,6 +162,8 @@
> >  #define BITS_ROUNDDOWN_BYTES(bits) ((bits) >> 3)
> >  #define BITS_ROUNDUP_BYTES(bits) \
> >  	(BITS_ROUNDDOWN_BYTES(bits) + !!BITS_PER_BYTE_MASKED(bits))
> > +const int one = 1;
> > +#define is_big_endian() ((*(char *)&one) == 0)
> >
> >  #define BTF_INFO_MASK 0x0f00ffff
> >  #define BTF_INT_MASK 0x0fffffff
> > @@ -991,16 +993,13 @@ static void btf_int_bits_seq_show(const
> >  				  void *data, u8 bits_offset,
> >  				  struct seq_file *m)
> >  {
> > +	u8 left_shift_bits, right_shift_bits;
> Nit.
> Although only max 64 bit int is allowed now (ensured by btf_int_check_meta),
> it is better to use u16 such that it will be consistent to BTF_INT_BITS.

Double-nit.

Use 'int' or 'unsigned int'.
Sub-word arithmetic will require extra instructions on almost everything
except x86.

	David

