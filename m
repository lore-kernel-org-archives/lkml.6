Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752627AbeENJD4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 05:03:56 -0400
Received: from smtp-out6.electric.net ([192.162.217.184]:57657 "EHLO
        smtp-out6.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752436AbeENJDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 05:03:51 -0400
From: David Laight <David.Laight@ACULAB.COM>
To: "'H. Peter Anvin'" <hpa@zytor.com>,
        "'Alexey Dobriyan'" <adobriyan@gmail.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH] x86: pad assembly functions with INT3
Thread-Topic: [PATCH] x86: pad assembly functions with INT3
Thread-Index: AQHT5kvUTXOpwgS8vUa+aOfUWAYmp6QpLZRAgAGn0QCABCEG0A==
Date: Mon, 14 May 2018 09:04:38 +0000
Message-ID: <83866d054b27419c9d9dd97d9c66c3de@AcuMS.aculab.com>
References: <20180507213755.GA32406@avx2>
 <20fb84fd5eef4c45b2d38d0290235d5d@AcuMS.aculab.com>
 <5c6762fe-5cbe-42ed-ac4e-a7144b8ef7ad@zytor.com>
In-Reply-To: <5c6762fe-5cbe-42ed-ac4e-a7144b8ef7ad@zytor.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-Outbound-IP: 156.67.243.126
X-Env-From: David.Laight@ACULAB.COM
X-Proto: esmtps
X-Revdns: 
X-HELO: AcuMS.aculab.com
X-TLS: TLSv1.2:ECDHE-RSA-AES256-SHA384:256
X-Authenticated_ID: 
X-PolicySMART: 3396946, 3397078
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4E94DBV012549

From: H. Peter Anvin
> Sent: 11 May 2018 19:54
> 
> On 05/10/18 09:39, David Laight wrote:
> > From: Alexey Dobriyan
> >> Sent: 07 May 2018 22:38
> >>
> >> Use INT3 instead of NOP. All that padding between functions is
> >> an illegal area, no legitimate code should jump into it.
> >>
> >> I've checked x86_64 allyesconfig disassembly, all changes looks sane:
> >> INT3 is only used after RET or unconditional JMP.
> >
> > I thought there was a performance penalty (on at least some cpu)
> > depending on the number of and the actual instructions used for padding.
> >
> > I believe that is why gcc generates a small number of very long 'nop'
> > instructions when padding code.
> >
> 
> There is a performance penalty for using NOP instructions *in the
> fallthrough case.*  In the case where the padding is never supposed to
> be executed, which is what we're talking about here, it is irrelevant.

Not completely irrelevant, the instructions stream gets fetched and decoded
beyond the jmp/ret at the end of the function.
At some point the cpu will decode the jmp/ret and fetch/decode from the
target address.
I guess it won't try to speculatively execute the 'pad' instructions
- but you can never really tell!

	David
