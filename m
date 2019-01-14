Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19546C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E565720656
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:51:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbfANUvw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 15:51:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43090 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726809AbfANUvv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 15:51:51 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 64C5E637FC;
        Mon, 14 Jan 2019 20:51:51 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.18.25.74])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A12205D75F;
        Mon, 14 Jan 2019 20:51:50 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Sujith Pandel <sujith_pandel@dell.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Subject: Re: [PATCH] acpi/nfit: Fix command-supported detection
References: <154725096972.1367907.12968253382302127133.stgit@dwillia2-desk3.amr.corp.intel.com>
        <x49sgxvclmu.fsf@redhat.com>
        <CAPcyv4hLGB-=UcHykgAO5X3Oakp_erw_62_gpUD2cqXLXKpJVQ@mail.gmail.com>
        <CAPcyv4hANufJYNnu+tc5yaun3xG8Ht6MirobG4Fj_CaafXE+7g@mail.gmail.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Mon, 14 Jan 2019 15:51:49 -0500
In-Reply-To: <CAPcyv4hANufJYNnu+tc5yaun3xG8Ht6MirobG4Fj_CaafXE+7g@mail.gmail.com>
        (Dan Williams's message of "Mon, 14 Jan 2019 08:47:49 -0800")
Message-ID: <x498sznaroa.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Mon, 14 Jan 2019 20:51:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Williams <dan.j.williams@intel.com> writes:

> On Mon, Jan 14, 2019 at 8:43 AM Dan Williams <dan.j.williams@intel.com> wrote:
>> On Mon, Jan 14, 2019 at 7:19 AM Jeff Moyer <jmoyer@redhat.com> wrote:
> [..]
>> > > +
>> > > +     if (cmd == ND_CMD_CALL) {
>> > > +             int i;
>> > > +
>> > > +             if (call_pkg && nfit_mem->family != call_pkg->nd_family)
>> > > +                     return -ENOTTY;
>> > > +
>> > > +             for (i = 0; i < ARRAY_SIZE(call_pkg->nd_reserved2); i++)
>> > > +                     if (call_pkg->nd_reserved2[i])
>> > > +                             return -EINVAL;
>> > > +             return call_pkg->nd_command;
>> > > +     }
>> > > +
>> > > +     /* Linux ND commands == NVDIMM_FAMILY_INTEL function numbers */
>> > > +     if (nfit_mem->family == NVDIMM_FAMILY_INTEL)
>> > > +             return cmd;
>> > > +     return 0;
>> >
>> > Function zero?  Is that really the right thing to return here?
>>
>> Yes, function zero is never set in n
>
> ...whoops fumble fingered "send"
>
> Function zero should never be set in nfit_mem->dsm_mask, although the
> NVDIMM_FAMILY_MSFT mask violates this assumption. I'll fix that up.

OK, I think I see how it all fits together now, thanks.  It would be
nice if you documented this magical 0 return somehow.

Cheers,
Jeff
