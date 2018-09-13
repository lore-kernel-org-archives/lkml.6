Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA01C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2832920C0A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:23:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2832920C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbeIMSc0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:32:26 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:22229 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726452AbeIMSc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:32:26 -0400
X-Greylist: delayed 76624 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Sep 2018 14:32:25 EDT
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by eu-smtp-1.mimecast.com with ESMTP id
 uk-mta-42-zJIENtI3N9CNmXesgMuzxA-1; Thu, 13 Sep 2018 14:22:57 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu,
 13 Sep 2018 14:25:07 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 13 Sep 2018 14:25:07 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Davidlohr Bueso' <dave@stgolabs.net>,
        Eugene Korenevsky <ekorenevsky@gmail.com>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: RE: [PATCH v3] efi: take size of partition entry from GPT header
Thread-Topic: [PATCH v3] efi: take size of partition entry from GPT header
Thread-Index: AQHUSsp7gqL1twr/rUmBM1hCfMHUxKTuNArg
Date:   Thu, 13 Sep 2018 13:25:07 +0000
Message-ID: <c158b639852d48d382445d33da8c6a1e@AcuMS.aculab.com>
References: <20180912183519.GA31506@vnote> <20180912185517.GE3902@linux-r8p5>
In-Reply-To: <20180912185517.GE3902@linux-r8p5>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: zJIENtI3N9CNmXesgMuzxA-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Davidlohr Bueso
> Sent: 12 September 2018 19:55
> 
> On Wed, 12 Sep 2018, Eugene Korenevsky wrote:
> > /**
> >  * efi_partition(struct parsed_partitions *state)
> >  * @state: disk parsed partitions
> >@@ -704,32 +710,36 @@ int efi_partition(struct parsed_partitions *state)
> >
> > 	pr_debug("GUID Partition Table is valid!  Yea!\n");
> >
> >-	for (i = 0; i < le32_to_cpu(gpt->num_partition_entries) && i < state->limit-1; i++) {
> >+	for (i = 0;
> >+	     i < le32_to_cpu(gpt->num_partition_entries) && i < state->limit-1;
> >+	     i++) {
> 
> Please rearrange this like:
> 
>        for (i = 0; i < le32_to_cpu(gpt->num_partition_entries) &&
>        	      	      i < state->limit-1; i++)

Better still cache le32_to_cpu(gpt->num_partition_entries) to a local
so that it only has to be calculated once (even if it gets spilled
to the stack).
It can be bounded by state->limit-1 at the same time.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

