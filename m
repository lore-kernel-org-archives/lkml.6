Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751265AbeBUT64 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 14:58:56 -0500
Received: from mga14.intel.com ([192.55.52.115]:16719 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750738AbeBUT6y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 14:58:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,375,1515484800";
   d="scan'208";a="19803166"
From: "Luck, Tony" <tony.luck@intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
CC: Andi Kleen <ak@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Joe Konno <joe.konno@linux.intel.com>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Jeremy Kerr <jk@ozlabs.org>, "Matthew Garrett" <mjg59@google.com>,
        Peter Jones <pjones@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        James Bottomley <james.bottomley@hansenpartnership.com>
Subject: RE: [PATCH 1/2] fs/efivarfs: restrict inode permissions
Thread-Topic: [PATCH 1/2] fs/efivarfs: restrict inode permissions
Thread-Index: AQHTpon2sBXepSmY30arvR+oDcRgZ6OuOFeA//+bYYCAAJIigP//ko4AgACcNgD//3rHwAATsdGAAA40CAAAEtZ3gAAApwsA//+SC4CAAIbrgIAAhYIA
Date: Wed, 21 Feb 2018 19:58:53 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7B37F130@ORSMSX110.amr.corp.intel.com>
References: <6680a760-eb30-4daf-2dad-a9628f1c15a8@kernel.org>
 <20180220211849.fqjb6rdmypl6opir@agluck-desk>
 <CA+55aFzjyB=E+=q-W9oYZ7Py7nJwm8YQHFjfbWTib6wvkP9B_A@mail.gmail.com>
 <20180220233008.55rfm7zw62hrao5p@agluck-desk>
 <CA+55aFy8JMLjpDk+sU6pirSZdVqqHtw5oocDAEC7wcHuo5Vssw@mail.gmail.com>
 <3908561D78D1C84285E8C5FCA982C28F7B37DE1B@ORSMSX110.amr.corp.intel.com>
 <CA+55aFwKsa6bq5SUD6wKv8znGcxqjLCPh33a3DkbnUkSfd68Yw@mail.gmail.com>
 <CAKv+Gu--iHii9SxE7RMZKdVdLvQPPGo0wdCzG30xW0+7dakbmw@mail.gmail.com>
 <CA+55aFx4Q7AzCM5mDwga6_LteNUBWQsT6nKJMjn8JcriS3ExuQ@mail.gmail.com>
 <20180221182104.GI3231@tassilo.jf.intel.com>
 <20180221194731.t7jowrmicvaggu3x@agluck-desk>
 <CA+55aFzy89V13rSxGQy77Bb08qpUpH+J=trcjooKQhsAFbgrVw@mail.gmail.com>
In-Reply-To: <CA+55aFzy89V13rSxGQy77Bb08qpUpH+J=trcjooKQhsAFbgrVw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYmVmZjkwNGQtMzAzMi00OTllLWJlYmQtM2M0OTY5MmUzNWRlIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJ3dklyNzlYRWlSM2FHK1lOK1dLaUs0Zmh1ZnJJTGdRRURPRlBXVjFSSEUwN1g5aTNcL2I0RWRhb1wvRitmTGlqdjEifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.0.116
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1LJx013024718

> It's not about slowing down.
>
> It's about "user Xyz is messing with the system and reading efi vars
> all the time" resulting in "user 'torvalds' is installing a kernel,
> and actually wants to read efi vars, but can't".
>
> if you don't make it per-user, you're just replacing one DoS attack
> with another one!

How are you envisioning this rate-limiting to be implemented? Are
you going to fail an EFI call if the rate is too high?  I'm thinking that
we just add a delay to each call so that we can't exceed the limit.
That means your kernel install will complete, just slower than it
would without the delays.

I think I want a small random delay anyway to prevent users from
causing an SMI at the precise moment of their choosing.

-Tony
