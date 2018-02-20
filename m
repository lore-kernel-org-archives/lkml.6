Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751415AbeBTXuh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 18:50:37 -0500
Received: from mga09.intel.com ([134.134.136.24]:20301 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751053AbeBTXuf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 18:50:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,542,1511856000";
   d="scan'208";a="176800474"
From: "Luck, Tony" <tony.luck@intel.com>
To: Matthew Garrett <mjg59@google.com>
CC: Linus Torvalds <torvalds@linux-foundation.org>,
        "joe.konno@linux.intel.com" <joe.konno@linux.intel.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jeremy Kerr <jk@ozlabs.org>, "ak@linux.intel.com" <ak@linux.intel.com>,
        "pjones@redhat.com" <pjones@redhat.com>,
        "luto@kernel.org" <luto@kernel.org>,
        James Bottomley <james.bottomley@hansenpartnership.com>
Subject: RE: [PATCH 1/2] fs/efivarfs: restrict inode permissions
Thread-Topic: [PATCH 1/2] fs/efivarfs: restrict inode permissions
Thread-Index: AQHTpon2sBXepSmY30arvR+oDcRgZ6OuOFeA//+bYYCAAJIigP//ko4AgACIt4D//3t70A==
Date: Tue, 20 Feb 2018 23:50:08 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7B37DB0F@ORSMSX110.amr.corp.intel.com>
References: <20180215182208.35003-1-joe.konno@linux.intel.com>
 <20180215182208.35003-2-joe.konno@linux.intel.com>
 <6680a760-eb30-4daf-2dad-a9628f1c15a8@kernel.org>
 <20180220211849.fqjb6rdmypl6opir@agluck-desk>
 <CA+55aFzjyB=E+=q-W9oYZ7Py7nJwm8YQHFjfbWTib6wvkP9B_A@mail.gmail.com>
 <20180220233008.55rfm7zw62hrao5p@agluck-desk>
 <CACdnJussCnLqdGGyOc=iUwEdot_U2DZjGcVWRcQa-DxVcUhabA@mail.gmail.com>
In-Reply-To: <CACdnJussCnLqdGGyOc=iUwEdot_U2DZjGcVWRcQa-DxVcUhabA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNjYxYWM0NDYtNzc3Ni00ZGNiLTlmOTMtNjQ1NWYzMzE3N2RlIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJGU3BWUUdKU3J6bDFTV2hvTzNwaXlJNUtsc1lhWUxzSWptYUowSHVyWmYyWnBTcHNVSHdXUXI2OUc4YlFkWlwvTiJ9
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
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1KNoghY000675

> read() will make two calls - one to obtain the size of the variable, the
> other to read it. It looks like cat will also trigger an fstat(), so we're
> probably also making a call for that. There's presumably some optimisation
> that could be made there if we trust the firmware not to change the size
> behind our back.

Hmmm. "ls -l" reports the size of each of the files without causing any SMIs,
so Linux has that cached someplace and "read" is being silly making a call
to get something that we already know.  Unless we think the size may be
changing asynchronously and are OK with reporting a stale value for "stat"
but want the actual value for "read".

-Tony
