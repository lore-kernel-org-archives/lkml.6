Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934039AbeBMP5k (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 10:57:40 -0500
Received: from mail-ot0-f169.google.com ([74.125.82.169]:46316 "EHLO
        mail-ot0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933440AbeBMP5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 10:57:39 -0500
X-Google-Smtp-Source: AH8x224zc186M74emI+swqsIMiyxdEZjKkBqKI8nKNW+u78CXnbn+fey22N94V61LoKHUWdEOTynlD0naDCeIlZQ8DQ=
MIME-Version: 1.0
In-Reply-To: <x49bmgtqb9p.fsf@segfault.boston.devel.redhat.com>
References: <151847194459.58291.11339638808076622981.stgit@djiang5-desk3.ch.intel.com>
 <x49inb1n7kb.fsf@segfault.boston.devel.redhat.com> <CAPcyv4gt88pEivOyEGdYbTx9H2LV7+mQQ9H1ESWhzM+gpbtW0g@mail.gmail.com>
 <x49bmgtqb9p.fsf@segfault.boston.devel.redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 13 Feb 2018 07:57:36 -0800
Message-ID: <CAPcyv4j7dnmiRxkFr8DgBLd-xkm8vS+T8xmZWSxUgOp8JZPhLQ@mail.gmail.com>
Subject: Re: [PATCH v2] libnvdimm: re-enable deep flush for pmem devices
To: Jeff Moyer <jmoyer@redhat.com>
Cc: Dave Jiang <dave.jiang@intel.com>,
        "Zwisler, Ross" <ross.zwisler@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm@lists.01.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 5:17 AM, Jeff Moyer <jmoyer@redhat.com> wrote:
> Dan Williams <dan.j.williams@intel.com> writes:
>
>> On Mon, Feb 12, 2018 at 2:53 PM, Jeff Moyer <jmoyer@redhat.com> wrote:
>>> Dave Jiang <dave.jiang@intel.com> writes:
>>>
>>>> Re-enable deep flush so that users always have a way to be sure that a write
>>>> does make it all the way out to the NVDIMM. The PMEM driver writes always
>>>> make it "all the way to the NVDIMM", and it relies on the ADR mechanism to
>>>> flush the write buffers on power failure. Deep flush is there to explicitly
>>>> flush those write buffers to protect against (rare) ADR failure.
>>>> This change prevents a regression in deep flush behavior so that applications
>>>> can continue to depend on fsync() as a mechanism to trigger deep flush in the
>>>> filesystem-dax case.
>>>
>>> That's still very confusing text.  Specifically, the part where you say
>>> that pmem driver writes always make it to the DIMM.  I think the
>>> changelog could start with "Deep flush is there to explicitly flush
>>> write buffers...."  Anyway, the fix looks right to me.
>>
>> I ended up changing the commit message to this, let me know if it reads better:
>
> Thanks.  It's still unclear to me what the text, "The PMEM driver writes
> always arrive at the NVDIMM" means.  However, it's good enough.

Yeah, Dave, had similar feedback. A better way of saying it is that
the writes always arrive at the persistence domain, but deep flush
pushes them to the smallest platform failure domain. On current
platforms that's to the ADR domain and past the ADR domain.
