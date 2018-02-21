Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751326AbeBUBGC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 20:06:02 -0500
Received: from mga11.intel.com ([192.55.52.93]:57932 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750710AbeBUBGB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 20:06:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,542,1511856000";
   d="scan'208";a="19074468"
From: "Luck, Tony" <tony.luck@intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
CC: Joe Konno <joe.konno@linux.intel.com>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Matthew Garrett <matthew.garrett@nebula.com>,
        Jeremy Kerr <jk@ozlabs.org>, Andi Kleen <ak@linux.intel.com>,
        Matthew Garrett <mjg59@google.com>, "Peter Jones" <pjones@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        James Bottomley <james.bottomley@hansenpartnership.com>
Subject: RE: [PATCH 1/2] fs/efivarfs: restrict inode permissions
Thread-Topic: [PATCH 1/2] fs/efivarfs: restrict inode permissions
Thread-Index: AQHTpon2sBXepSmY30arvR+oDcRgZ6OuOFeA//+bYYCAAJIigP//ko4AgACcNgD//3rHwA==
Date: Wed, 21 Feb 2018 01:05:59 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7B37DE1B@ORSMSX110.amr.corp.intel.com>
References: <20180215182208.35003-1-joe.konno@linux.intel.com>
 <20180215182208.35003-2-joe.konno@linux.intel.com>
 <6680a760-eb30-4daf-2dad-a9628f1c15a8@kernel.org>
 <20180220211849.fqjb6rdmypl6opir@agluck-desk>
 <CA+55aFzjyB=E+=q-W9oYZ7Py7nJwm8YQHFjfbWTib6wvkP9B_A@mail.gmail.com>
 <20180220233008.55rfm7zw62hrao5p@agluck-desk>
 <CA+55aFy8JMLjpDk+sU6pirSZdVqqHtw5oocDAEC7wcHuo5Vssw@mail.gmail.com>
In-Reply-To: <CA+55aFy8JMLjpDk+sU6pirSZdVqqHtw5oocDAEC7wcHuo5Vssw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNTdiNGQyNjQtYzFmOC00MmJiLTg4MGMtZjA5MGFlZWY0MzJjIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJKRXJBMzlcL3hYdFJZTFJTa0w3dVU1TGU5T1hZWmplaXdzSHBwSmJzZ0cyMm9nTHhIZTk1N2ZBRnpHc3VnSFQ3eiJ9
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
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1L166eO011482

>> EFI[1] stinks. Reading any file in /sys/firmware/efi/efivars/ generates
>> 4 (yes FOUR!) SMIs.

> Is that actualkly the normal implementation?

I don't know if there are other implementations. This is what I see on my
lab system.

> Also, if these are just synchronous SMI's, then don't we just end up
> correctly assigning the CPU load to the reader, and it doesn't
> actually matter? Where's the DoS?

SMI are broadcast to all logical CPUs. The bigger the system the
more the pain from an SMI as code tries to rendezvous them all
(4 socket * 24 core * 2 HyperThreads = 192 CPUs on my system).

Looping reading files from efivarfs doesn't stop the system, but it
does slow to a crawl while it is happening.  Not a full blown DoS,
but fairly unpleasant.

-Tony
