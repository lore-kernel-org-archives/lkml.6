Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752414AbeBVFeF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 00:34:05 -0500
Received: from mga07.intel.com ([134.134.136.100]:37661 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750927AbeBVFeD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 00:34:03 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,377,1515484800";
   d="scan'208";a="19422991"
From: "Luck, Tony" <tony.luck@intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
CC: Andi Kleen <ak@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Joe Konno <joe.konno@linux.intel.com>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Jeremy Kerr <jk@ozlabs.org>, Matthew Garrett <mjg59@google.com>,
        Peter Jones <pjones@redhat.com>, "Andy Lutomirski" <luto@kernel.org>,
        James Bottomley <james.bottomley@hansenpartnership.com>
Subject: RE: [PATCH] efivarfs: Limit the rate for non-root to read files
Thread-Topic: [PATCH] efivarfs: Limit the rate for non-root to read files
Thread-Index: AQHTq37FFkulVWeyvEObLqRpM+Xu0KOwMGyA//+0HlA=
Date: Thu, 22 Feb 2018 05:34:01 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7B37FE28@ORSMSX110.amr.corp.intel.com>
References: <CA+55aFy8JMLjpDk+sU6pirSZdVqqHtw5oocDAEC7wcHuo5Vssw@mail.gmail.com>
 <3908561D78D1C84285E8C5FCA982C28F7B37DE1B@ORSMSX110.amr.corp.intel.com>
 <CA+55aFwKsa6bq5SUD6wKv8znGcxqjLCPh33a3DkbnUkSfd68Yw@mail.gmail.com>
 <CAKv+Gu--iHii9SxE7RMZKdVdLvQPPGo0wdCzG30xW0+7dakbmw@mail.gmail.com>
 <CA+55aFx4Q7AzCM5mDwga6_LteNUBWQsT6nKJMjn8JcriS3ExuQ@mail.gmail.com>
 <20180221182104.GI3231@tassilo.jf.intel.com>
 <20180221194731.t7jowrmicvaggu3x@agluck-desk>
 <CA+55aFzy89V13rSxGQy77Bb08qpUpH+J=trcjooKQhsAFbgrVw@mail.gmail.com>
 <3908561D78D1C84285E8C5FCA982C28F7B37F130@ORSMSX110.amr.corp.intel.com>
 <CA+55aFx3WKAL7e3TAs-2okggW6Z+DHANdmcsr+WTDh3N-Mx+Xw@mail.gmail.com>
 <20180222014505.2l76ccrrs36y3b26@agluck-desk>
 <CA+55aFzJXsPcsJ5MtsxTp2n+43xC0yGzANLNcDm1mFbZKR75FQ@mail.gmail.com>
In-Reply-To: <CA+55aFzJXsPcsJ5MtsxTp2n+43xC0yGzANLNcDm1mFbZKR75FQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNmUyZTdjMjItMjI3Yy00NjQ1LWFkODgtMTMzNjY5NTIxMzU4IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJrYXB5Z2UrTnN1bEl6OTB0ajQwUFdTdEZvbm5TUEtJN0xERXVmdUdqR1F3OWtxZDZoUW5EQzdEZ2xCR1BZUkIzIn0=
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.0.116
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1M5YAlQ013036

>  - just make it return -EAGAIN instead of sleeping (which probably
> just works fine and doesn't break anything and is simple)

It is very simple. But it does break things :-(. If I read one of these files
using "dd bs=1", that used to read the whole file (while generating
lots of SMI). With the -EAGAIN it just reads 100 bytes and says:

dd: error reading 'DefSetup-e8a99903-302c-4851-a6be-ab2731873b2f': Resource temporarily unavailable
100+0 records in
100+0 records out
100 bytes copied, 0.153943 s, 0.6 kB/s

>  - add a per-user mutex, and do the usleep inside of it, so that
> anybody who tries to do a thousand threads will just be serialized by
> the mutex.
>
> Note that the mutex needs to be per-user, because otherwise it will be
> a DoS for the other users.

I can try that tomorrow (adding the per-user mutex to struct user_struct
right next to the ratelimit I added.

-Tony
