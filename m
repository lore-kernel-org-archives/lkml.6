Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754813AbeDYRQa (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 13:16:30 -0400
Received: from mail.skyhub.de ([5.9.137.197]:35870 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754552AbeDYRQ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 13:16:26 -0400
Date: Wed, 25 Apr 2018 19:15:57 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Alex G." <mr.nuke.me@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
        rjw@rjwysocki.net, lenb@kernel.org, tony.luck@intel.com,
        tbaicar@codeaurora.org, will.deacon@arm.com, james.morse@arm.com,
        shiju.jose@huawei.com, zjzhang@codeaurora.org, gengdongjiu@huawei.com,
        linux-kernel@vger.kernel.org, alex_gagniuc@dellteam.com,
        austin_bolen@dell.com, shyam_iyer@dell.com, devel@acpica.org,
        mchehab@kernel.org, robert.moore@intel.com, erik.schmauss@intel.com,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [RFC PATCH v2 3/4] acpi: apei: Do not panic() when correctable
 errors are marked as fatal.
Message-ID: <20180425171557.GC2597@pd.tnic>
References: <20180419154006.GE3600@pd.tnic>
 <977608e6-9f5d-c523-a78a-993ac5bfd55f@gmail.com>
 <20180419164528.GD5635@pd.tnic>
 <ffe6b459-c80a-d3c0-451d-0d21ae63da54@gmail.com>
 <20180419190323.GF5635@pd.tnic>
 <dba07329-2f85-2bde-85ea-5bdf26fb8df2@gmail.com>
 <20180422104849.GA32754@pd.tnic>
 <70c43399-e8e5-5061-b5a5-451deb5f02fa@gmail.com>
 <20180425140108.GA2597@pd.tnic>
 <48944beb-4e29-05cc-857b-7698e3dbe89b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <48944beb-4e29-05cc-857b-7698e3dbe89b@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 25, 2018 at 10:00:53AM -0500, Alex G. wrote:
> Firmware-first.

Ok, my guess was right.

> We could probably use more of the native AER print functions, but that's
> beyond the scope of this patch.

No no, this does not belong in this patchset.

> Like the exact thing that this patch series implements? :)

Exact thing? I don't think so.

No, your patchset is grafting some funky and questionable side-handler
which gets to see the PCIe errors first, out-of-line and then it
practically downgrades their severity outside of the error processing
flow.

What I've been telling you to do is to extend ghes_severity() to
give the lower than PANIC severity for CPER_SEC_PCIE errors first
so that the machine doesn't panic from them anymore and those PCIe
errors get processed in the normal error processing path down
through ghes_do_proc() and then land in ghes_handle_aer(). No adhoc
->handle_irqsafe thing - just the normal straightforward error
processing path.

There, in ghes_handle_aer(), you do the check whether the device is
still there - i.e., you try to apply some heuristics to detect the error
type and why the system is complaining - you maybe even check whether
the NVMe device is still there - and *then* you do the proper recovery
action.

And you document for the future people looking at this code *why* you're
doing this.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
