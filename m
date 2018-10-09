Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F823C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 08:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D5912089D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 08:59:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D5912089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbeJIQPN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 12:15:13 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:42275 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726393AbeJIQPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 12:15:13 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by eu-smtp-1.mimecast.com with ESMTP id
 uk-mta-157-l5akfGpBOGyDDLZROCIpeg-1; Tue, 09 Oct 2018 09:59:17 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 9 Oct 2018 09:59:18 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 9 Oct 2018 09:59:18 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Masami Hiramatsu' <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
        Matthew Helsley <mhelsley@vmware.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        "Jiri Kosina" <jkosina@suse.cz>
Subject: RE: [POC][RFC][PATCH 1/2] jump_function: Addition of new feature
 "jump_function"
Thread-Topic: [POC][RFC][PATCH 1/2] jump_function: Addition of new feature
 "jump_function"
Thread-Index: AQHUX4JXf4uWjPQOJUG5UZOYRQnM7KUWm/Kg
Date:   Tue, 9 Oct 2018 08:59:18 +0000
Message-ID: <a6ed96f907414e799536deaea28a1a5d@AcuMS.aculab.com>
References: <20181006015110.653946300@goodmis.org>
        <20181006015720.634688468@goodmis.org>
 <20181009124401.6005e2a39c760851aa54e600@kernel.org>
In-Reply-To: <20181009124401.6005e2a39c760851aa54e600@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: l5akfGpBOGyDDLZROCIpeg-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu
> Sent: 09 October 2018 04:44
...
> I think we can replace the first 5 bytes of the default function
> to jmp instruction (to alternative function) instead of making
> this trampoline.

Or have a trampoline that is just a jump instruction and overwrite
the target address at run time to select the non-default code.
With care the target address can be aligned so that the write is atomic
and can be done while other cpu might be calling the function.

This will be lower impact that a 'jump indirect' - especially since
the latter would have to be implemented using a 'retpoline'.

It would also make it possible to re-instate the default function.
(By saving its address after the jump.)

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

