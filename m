Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB10C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 02:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5DC321471
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 02:48:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5DC321471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbeGLCzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 22:55:19 -0400
Received: from mga03.intel.com ([134.134.136.65]:44203 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726394AbeGLCzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 22:55:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jul 2018 19:48:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,341,1526367600"; 
   d="scan'208";a="54394119"
Received: from unknown (HELO [10.239.13.97]) ([10.239.13.97])
  by fmsmga008.fm.intel.com with ESMTP; 11 Jul 2018 19:47:58 -0700
Message-ID: <5B46C258.40601@intel.com>
Date:   Thu, 12 Jul 2018 10:52:08 +0800
From:   Wei Wang <wei.w.wang@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Michal Hocko <mhocko@kernel.org>, virtio-dev@lists.oasis-open.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        KVM list <kvm@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        liliang.opensource@gmail.com, yang.zhang.wz@gmail.com,
        quan.xu0@gmail.com, nilal@redhat.com,
        Rik van Riel <riel@redhat.com>, peterx@redhat.com
Subject: Re: [PATCH v35 1/5] mm: support to get hints of free page blocks
References: <1531215067-35472-1-git-send-email-wei.w.wang@intel.com> <1531215067-35472-2-git-send-email-wei.w.wang@intel.com> <CA+55aFz9a=D-kquM=sG5uhV_HrBAw+VAhcJmtPNz+howy4j9ow@mail.gmail.com> <5B455D50.90902@intel.com> <CA+55aFzqj8wxXnHAdUTiOomipgFONVbqKMjL_tfk7e5ar1FziQ@mail.gmail.com> <20180711092152.GE20050@dhcp22.suse.cz> <CA+55aFwku2tDH4+rfaC67xc4-cEwSrXgnQaci=e2id5ZCRE9JQ@mail.gmail.com> <5B46BB46.2080802@intel.com> <CA+55aFxyv=EUAJFUSio=k+pm3ddteojshP7Radjia5ZRgm53zQ@mail.gmail.com>
In-Reply-To: <CA+55aFxyv=EUAJFUSio=k+pm3ddteojshP7Radjia5ZRgm53zQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/2018 10:30 AM, Linus Torvalds wrote:
> On Wed, Jul 11, 2018 at 7:17 PM Wei Wang <wei.w.wang@intel.com> wrote:
>> Would it be better to remove __GFP_THISNODE? We actually want to get all
>> the guest free pages (from all the nodes).
> Maybe. Or maybe it would be better to have the memory balloon logic be
> per-node? Maybe you don't want to remove too much memory from one
> node? I think it's one of those "play with it" things.
>
> I don't think that's the big issue, actually. I think the real issue
> is how to react quickly and gracefully to "oops, I'm trying to give
> memory away, but now the guest wants it back" while you're in the
> middle of trying to create that 2TB list of pages.

OK. virtio-balloon has already registered an oom notifier 
(virtballoon_oom_notify). I plan to add some control there. If oom happens,
- stop the page allocation;
- immediately give back the allocated pages to mm.

Best,
Wei
