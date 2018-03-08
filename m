Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933955AbeCHRFs (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 12:05:48 -0500
Received: from mga17.intel.com ([192.55.52.151]:22992 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933407AbeCHRFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 12:05:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,441,1515484800";
   d="scan'208";a="32346792"
From: "Luck, Tony" <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>,
        "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
CC: "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chun-Yi Lee <jlee@suse.com>, Will Deacon <will.deacon@arm.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        "Neri, Ricardo" <ricardo.neri@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        "Zijlstra, Peter" <peter.zijlstra@intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>
Subject: RE: [PATCH V2 2/3] efi: Introduce efi_rts_workqueue and some
 infrastructure to invoke all efi_runtime_services()
Thread-Topic: [PATCH V2 2/3] efi: Introduce efi_rts_workqueue and some
 infrastructure to invoke all efi_runtime_services()
Thread-Index: AQHTtNngZNpn0MRvAUySKQBVd1NV5aPFNzYAgAEifoCAAJCUgP//qb7g
Date: Thu, 8 Mar 2018 17:05:44 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7B392450@ORSMSX110.amr.corp.intel.com>
References: <1520292190-5027-1-git-send-email-sai.praneeth.prakhya@intel.com>
 <1520292190-5027-3-git-send-email-sai.praneeth.prakhya@intel.com>
 <20180307121047.GG23662@pd.tnic>
 <FFF73D592F13FD46B8700F0A279B802F2E5818E4@ORSMSX114.amr.corp.intel.com>
 <20180308140830.GE21166@pd.tnic>
In-Reply-To: <20180308140830.GE21166@pd.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNTc5MGYzZTQtZTRkNS00NjI1LThkYjYtMTYxZTdlYjRkZDY3IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJtXC9Yc1BsSHNIbXZNNE42SEYxQkpsdmc3RmpIR0VadXFqT1oyMjdCQWVjZ1RtUTdETUZaNWloUnBxQ2RIVHc4TSJ9
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
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w28H5r6u021376

> "Hence, pstore calls efi_runtime_services() without using efi_rts_wq" -
> that doesn't sound like optimal design to me. I would try to shove them
> all through the workqueue - not have exceptions.

But pstore is trying to save the last gasp dying words from a kernel that
has paniced. There isn't any guarantee that work queue will run. I think
it is reasonable to have some special case to make sure that we do save
the information.  But perhaps that special case should be to have pstore
call directly into the guts of the EFI code and not worry about all these
fancy switches of "mm" etc.

This is true for the machine check logging case too, but the mitigation is
that the details of the error persist in the machine check banks across the
reset ... so all is not lost if the work queue isn't run here.

-Tony
