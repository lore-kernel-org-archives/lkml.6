Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751628AbeCUHB6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 03:01:58 -0400
Received: from mga01.intel.com ([192.55.52.88]:46617 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751319AbeCUHB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 03:01:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,338,1517904000";
   d="scan'208";a="27128039"
From: "Metzger, Markus T" <markus.t.metzger@intel.com>
To: Andy Lutomirski <luto@kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>
CC: X86 ML <x86@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, "Luck, Tony" <tony.luck@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 14/15] x86/fsgsbase/64: Support legacy behavior when
 FS/GS updated by ptracer
Thread-Topic: [PATCH 14/15] x86/fsgsbase/64: Support legacy behavior when
 FS/GS updated by ptracer
Thread-Index: AQHTv61cFX2e1koiPEmMNZ4I/COyt6PZOjqAgAAYzYCAAIn1gIAAZOEg
Date: Wed, 21 Mar 2018 07:01:54 +0000
Message-ID: <A78C989F6D9628469189715575E55B23696641B6@IRSMSX103.ger.corp.intel.com>
References: <1521481767-22113-1-git-send-email-chang.seok.bae@intel.com>
 <1521481767-22113-15-git-send-email-chang.seok.bae@intel.com>
 <CALCETrXb5RRuAnKpU2_3Rac4F4tbv1Z+UHU6=QrYk-GCSLv4cw@mail.gmail.com>
 <C78DE381-C618-4370-9B06-F6E25C850661@intel.com>
 <CALCETrX03_AG-OuJdmfmsbvEt0UTdUpaUVDRQgbDZWGY7WD-Xw@mail.gmail.com>
In-Reply-To: <CALCETrX03_AG-OuJdmfmsbvEt0UTdUpaUVDRQgbDZWGY7WD-Xw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMWVjMjE4ZWQtZTdjMS00OTZmLTlmNWUtZWRmOGVmNGQ0M2Y2IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJTQytwdk9uR05JaWYyaHlJRktiMXg5MWF3TUw2Rno5NXFqemVweWgrQzZJQjZLd2dFZzhlSjdrWVh4cUVySWNkIn0=
dlp-product: dlpe-windows
dlp-version: 11.0.0.116
dlp-reaction: no-action
x-originating-ip: [163.33.239.180]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2L7240P016366

> -----Original Message-----
> From: Andy Lutomirski [mailto:luto@kernel.org]
> Sent: 21 March 2018 01:47

Hello Andy,

> I retract this particular comment.  But I still think that all this complexity needs to
> be more clearly justified.  My objection to the old approach wasn't that I thought
> it was obviously wrong -- I thought that someone needed to survey existing
> ptrace() users and see if anyone needed the fancier code that you're adding.  Did
> you find something that needs this fancy code?

There are 3 cases:
- only FS changed, e.g. "p $fs = ..."
- only FS_BASE changed, e.g. "p $fs_base = ..."
- both change, e.g. "p foo()" when restoring the original register state on return
  from the inferior call

The ptracer may use SETREGS in all 3 cases, even though only a single register changed.

For case 1, it might make sense to change FS_BASE as a side-effect.
For case 2, we'd only want to change FS_BASE and leave FS.
For case 3, we'd want both FS and FS_BASE to be set to the ptracer-provided values.

Does that make sense?

Thanks,
Markus.

Intel Deutschland GmbH
Registered Address: Am Campeon 10-12, 85579 Neubiberg, Germany
Tel: +49 89 99 8853-0, www.intel.de
Managing Directors: Christin Eisenschmid, Christian Lamprechter
Chairperson of the Supervisory Board: Nicole Lau
Registered Office: Munich
Commercial Register: Amtsgericht Muenchen HRB 186928
