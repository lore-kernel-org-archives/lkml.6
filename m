Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F8BCC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 11:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 476AE20659
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 11:14:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 476AE20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503637AbeKWV6E convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 16:58:04 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:36007 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2409552AbeKWV6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 16:58:03 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-58-ZDKerV0BO2CTEdE03nTIeQ-1; Fri, 23 Nov 2018 11:14:10 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 23 Nov 2018 11:14:17 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 23 Nov 2018 11:14:17 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Kevin Easton' <kevin@guarana.org>,
        Daniel Colascione <dancol@google.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "timmurray@google.com" <timmurray@google.com>,
        "primiano@google.com" <primiano@google.com>,
        "joelaf@google.com" <joelaf@google.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Mike Rapoport" <rppt@linux.vnet.ibm.com>,
        Roman Gushchin <guro@fb.com>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>,
        Prashant Dhamdhere <pdhamdhe@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "Dominik Brodowski" <linux@dominikbrodowski.net>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Ard Biesheuvel" <ard.biesheuvel@linaro.org>,
        Michal Hocko <mhocko@suse.com>,
        "MatthewWilcox@ip-172-31-15-78" <MatthewWilcox@ip-172-31-15-78>
Subject: RE: [PATCH] Add /proc/pid_generation
Thread-Topic: [PATCH] Add /proc/pid_generation
Thread-Index: AQHUglZTZJgLEEWYF0a4KhMuY5AKgaVdNbzw
Date:   Fri, 23 Nov 2018 11:14:17 +0000
Message-ID: <f00df51af0a4491fa7d86f9dc0c07bf6@AcuMS.aculab.com>
References: <20181121201452.77173-1-dancol@google.com>
 <20181122111930.GA7164@ip-172-31-15-78>
In-Reply-To: <20181122111930.GA7164@ip-172-31-15-78>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: ZDKerV0BO2CTEdE03nTIeQ-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kevin Easton
> Sent: 22 November 2018 11:20
> 
> On Wed, Nov 21, 2018 at 12:14:44PM -0800, Daniel Colascione wrote:
> > This change adds a per-pid-namespace 64-bit generation number,
> > incremented on PID rollover, and exposes it via a new proc file
> > /proc/pid_generation. By examining this file before and after /proc
> > enumeration, user code can detect the potential reuse of a PID and
> > restart the task enumeration process, repeating until it gets a
> > coherent snapshot.
> 
> I see downthread this patch has been withdrawn, but nonetheless I'm
> still curious - does this actually solve the problem?
> 
> It seems to me that a PID could be reused within a scan even if the
> generation number remains the same at the beginning and end of a scan:

Why not allocate a 48bit generation number to each 16bit pid?
Then you have a 64bit 'extended-pid' that can be assumed to never be reused.
Provided enough interfaces are enhanced to support 'extended-pid' values
you'll never get reused values.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

