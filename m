Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56AE3C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E65C320862
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="sygdlpEi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E65C320862
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbeGaJ1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 05:27:22 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:55809 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbeGaJ1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 05:27:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1533023300; x=1564559300;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=x7y7yCTyd4HXV730zrufQ4JceMulZHEDh3P8TEWNRTw=;
  b=sygdlpEiKi3Kl+Dp9YucMkAb7NLTUD5Fn8CcNe2tDWllrd54MBAyLXRx
   R1H9x6Yp35SUUqP+jIXDYTHuc0IT/r8VILQy9cAtRoEEnvHj30ceywxZ1
   bXNuz9DJD11zekUz3qVt5N2jB19fk3L7P54r6YJXjHRWrVx97hhRq8BZk
   8=;
X-IronPort-AV: E=Sophos;i="5.51,426,1526342400"; 
   d="scan'208";a="747137890"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-2c-168cbb73.us-west-2.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 31 Jul 2018 07:44:15 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2c-168cbb73.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w6V7hgpp080031
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 31 Jul 2018 07:43:48 GMT
Received: from EX13D02EUC004.ant.amazon.com (10.43.164.117) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 31 Jul 2018 07:43:47 +0000
Received: from EX13D02EUC001.ant.amazon.com (10.43.164.92) by
 EX13D02EUC004.ant.amazon.com (10.43.164.117) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 31 Jul 2018 07:43:47 +0000
Received: from EX13D02EUC001.ant.amazon.com ([10.43.164.92]) by
 EX13D02EUC001.ant.amazon.com ([10.43.164.92]) with mapi id 15.00.1367.000;
 Tue, 31 Jul 2018 07:43:47 +0000
From:   "Sironi, Filippo" <sironi@amazon.de>
To:     Borislav Petkov <bp@alien8.de>
CC:     Prarit Bhargava <prarit@redhat.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: Re: [PATCH] x86/MCE: Fix CPU microcode version output
Thread-Topic: [PATCH] x86/MCE: Fix CPU microcode version output
Thread-Index: AQHUExbi8uypSsTACk266VWFhyGxKqSoDE4AgAAOvgCAAQMzgA==
Date:   Tue, 31 Jul 2018 07:43:46 +0000
Message-ID: <391F9020-01AA-43FF-88D6-A2CC994962F2@amazon.de>
References: <20180703164844.9742-1-prarit@redhat.com>
 <20180703165849.GA17773@agluck-desk> <20180703214300.GA15087@zn.tnic>
 <e76c74b6-4008-9f7d-83bf-dd48433a7ea3@redhat.com>
 <20180730161604.GC11890@nazgul.tnic>
In-Reply-To: <20180730161604.GC11890@nazgul.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.164.213]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A56A7AECF0C8D148BABEFF8FADD3D91B@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 30. Jul 2018, at 18:16, Borislav Petkov <bp@alien8.de> wrote:
> =

> On Mon, Jul 30, 2018 at 11:23:18AM -0400, Prarit Bhargava wrote:
>> Filippo & Borislav, did the patch get committed to a -next tree?
> =

> No, I'm still waiting for it - looks like Filippo is busy.
> =

> Care to send one instead as suggested here?
> =

> https://lore.kernel.org/lkml/20180601121939.GA23298@nazgul.tnic/
> =

> -- =

> Regards/Gruss,
>    Boris.
> =

> ECO tip #101: Trim your mails when you reply.
> --

Sorry, I was out of office for a while.
I'll look into this today.

Filippo


Amazon Development Center Germany GmbH
Berlin - Dresden - Aachen
main office: Krausenstr. 38, 10117 Berlin
Geschaeftsfuehrer: Dr. Ralf Herbrich, Christian Schlaeger
Ust-ID: DE289237879
Eingetragen am Amtsgericht Charlottenburg HRB 149173 B

