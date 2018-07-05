Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80709C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 20:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 392E123F80
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 20:00:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 392E123F80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754058AbeGEUA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 16:00:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36672 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753961AbeGEUA1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 16:00:27 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 553E940B6C0F;
        Thu,  5 Jul 2018 20:00:26 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 42B012026D74;
        Thu,  5 Jul 2018 20:00:25 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 13/13] libnvdimm, namespace: Publish page structure init state / control
References: <153077334130.40830.2714147692560185329.stgit@dwillia2-desk3.amr.corp.intel.com>
        <153077341292.40830.11333232703318633087.stgit@dwillia2-desk3.amr.corp.intel.com>
        <20180705082931.echvdqipgvwhghf2@linux-x5ow.site>
        <CAPcyv4h1L6ZMCqWXhWD_ZJ=sH7SVzuUGMG2Ln=6Cy6sR4S=VUw@mail.gmail.com>
        <20180705194936.GA28447@bombadil.infradead.org>
        <CAPcyv4jHG9jCWz_hVc8DPxxALQ2JyD=AJKuYn6-ZMhB_fot1-Q@mail.gmail.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Date:   Thu, 05 Jul 2018 16:00:25 -0400
In-Reply-To: <CAPcyv4jHG9jCWz_hVc8DPxxALQ2JyD=AJKuYn6-ZMhB_fot1-Q@mail.gmail.com>
        (Dan Williams's message of "Thu, 5 Jul 2018 12:52:07 -0700")
Message-ID: <x49tvpd78rq.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 05 Jul 2018 20:00:26 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 05 Jul 2018 20:00:26 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jmoyer@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Williams <dan.j.williams@intel.com> writes:

> On Thu, Jul 5, 2018 at 12:49 PM, Matthew Wilcox <willy@infradead.org> wrote:
>> On Thu, Jul 05, 2018 at 07:46:05AM -0700, Dan Williams wrote:
>>> On Thu, Jul 5, 2018 at 1:29 AM, Johannes Thumshirn <jthumshirn@suse.de> wrote:
>>> > On Wed, Jul 04, 2018 at 11:50:13PM -0700, Dan Williams wrote:
>>> >> +static ssize_t memmap_state_store(struct device *dev,
>>> >> +             struct device_attribute *attr, const char *buf, size_t len)
>>> >> +{
>>> >> +     int i;
>>> >> +     struct nd_pfn *nd_pfn = to_nd_pfn_safe(dev);
>>> >> +     struct memmap_async_state *async = &nd_pfn->async;
>>> >> +
>>> >> +     if (strcmp(buf, "sync") == 0)
>>> >> +             /* pass */;
>>> >> +     else if (strcmp(buf, "sync\n") == 0)
>>> >> +             /* pass */;
>>> >> +     else
>>> >> +             return -EINVAL;
>>> >
>>> > Hmm what about:
>>> >
>>> >         if (strncmp(buf, "sync", 4))
>>> >            return -EINVAL;
>>> >
>>> > This collapses 6 lines into 4.
>>>
>>> ...but that also allows 'echo "syncAndThenSomeGarbage" >
>>> /sys/.../memmap_state' to succeed.
>>
>>         if (strncmp(buf, "sync", 4))
>>                 return -EINVAL;
>>         if (buf[4] != '\0' && buf[4] != '\n')
>>                 return -EINVAL;
>>
>
> Not sure that's a win either, I'd rather just:
>
> +       if (strcmp(buf, "sync") == 0 || strcmp(buf, "sync\n") == 0)
> +               /* pass */;
> +       else
> +               return -EINVAL;
>
> If we're trying to save those 2 lines.

WFM.  I don't like that I had to go digging around in sysfs
documentation to convince myself that strcmp was safe, but I guess
that's my problem.  ;-)

Cheers,
Jeff
