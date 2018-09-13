Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 490DEC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE64E20881
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:04:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE64E20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbeIMSN3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:13:29 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:58374 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726930AbeIMSN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:13:29 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by eu-smtp-1.mimecast.com with ESMTP id
 uk-mta-53-eHCeEkkZNIq8e6X4YDs0EA-1; Thu, 13 Sep 2018 14:04:03 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 13 Sep 2018 14:06:14 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 13 Sep 2018 14:06:13 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Karel Zak' <kzak@redhat.com>,
        Eugene Korenevsky <ekorenevsky@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: RE: [PATCH v2] efi: take size of partition entry from GPT header
Thread-Topic: [PATCH v2] efi: take size of partition entry from GPT header
Thread-Index: AQHUSnRba9AUJIT+vUG+D13HDhLQCKTuLuRw
Date:   Thu, 13 Sep 2018 13:06:13 +0000
Message-ID: <6d349d22d37041c1a2942d8ed4c76b69@AcuMS.aculab.com>
References: <20180911161527.GA30689@vnote>
 <20180912083844.iegei2kobcz4b7ag@ws.net.home>
In-Reply-To: <20180912083844.iegei2kobcz4b7ag@ws.net.home>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: eHCeEkkZNIq8e6X4YDs0EA-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Karel Zak
> Sent: 12 September 2018 09:39
> On Tue, Sep 11, 2018 at 07:15:27PM +0300, Eugene Korenevsky wrote:
> > +static gpt_entry *get_gpt_entry(gpt_header *gpt_hdr, gpt_entry *ptes, u32 index)
> > +{
> > +	return (gpt_entry *)((u8 *)ptes + gpt->sizeof_partition_entry * index);
> 
> I guess header use LE, so you need:
> 
>                le32_to_cpu(gpt_hdr->sizeof_partition_entry)

I suspect you also need a sanity check that the value isn't too small
or stupidly large.

In principle slightly short lengths presumably imply that the disk
was formatted with an older standard - so the last fields should be
ignored.
They may not be any such disks - until the on-disk structure is extended
and the kernel structure updated to match.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

