Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC8CC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 01:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B76AA27AC6
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 01:17:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B76AA27AC6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936437AbeF2BRT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 21:17:19 -0400
Received: from mga05.intel.com ([192.55.52.43]:7009 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936423AbeF2BRS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 21:17:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jun 2018 18:17:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,285,1526367600"; 
   d="scan'208";a="67253251"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.13.118])
  by fmsmga004.fm.intel.com with ESMTP; 28 Jun 2018 18:17:16 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH -mm -v4 00/21] mm, THP, swap: Swapout/swapin THP in one piece
References: <20180622035151.6676-1-ying.huang@intel.com>
        <20180627215144.73e98b01099191da59bff28c@linux-foundation.org>
        <87r2krfpi2.fsf@yhuang-dev.intel.com>
        <20180627223118.dd2f52d87f53e7e002ed0153@linux-foundation.org>
        <87muvffp7w.fsf@yhuang-dev.intel.com>
        <20180627231839.e5ac2f38e0397979d3db7765@linux-foundation.org>
        <20180628090301.GC7646@bombadil.infradead.org>
Date:   Fri, 29 Jun 2018 09:17:16 +0800
In-Reply-To: <20180628090301.GC7646@bombadil.infradead.org> (Matthew Wilcox's
        message of "Thu, 28 Jun 2018 02:03:01 -0700")
Message-ID: <87woui9ysj.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> writes:

> On Wed, Jun 27, 2018 at 11:18:39PM -0700, Andrew Morton wrote:
>> On Thu, 28 Jun 2018 13:35:15 +0800 "Huang\, Ying" <ying.huang@intel.com> wrote:
>> > No problem.  I will rebase the patchset on your latest -mm tree, or the
>> > next version to be released?
>> 
>> We need to figure that out with Matthew.
>> 
>> Probably the xarray conversions are simpler and more mature so yes,
>> probably they should be staged first.
>
> I'll take a look.  Honestly, my biggest problem with this patch set is
> overuse of tagging:
>
> 59832     Jun 22 Huang, Ying     ( 131) [PATCH -mm -v4 00/21] mm, THP, swap: Swa
> 59833 N   Jun 22 Huang, Ying     ( 126) ├─>[PATCH -mm -v4 01/21] mm, THP, swap:
> 59834 N   Jun 22 Huang, Ying     (  44) ├─>[PATCH -mm -v4 02/21] mm, THP, swap:
> 59835 N   Jun 22 Huang, Ying     ( 583) ├─>[PATCH -mm -v4 03/21] mm, THP, swap:
> 59836 N   Jun 22 Huang, Ying     ( 104) ├─>[PATCH -mm -v4 04/21] mm, THP, swap:
> 59837 N   Jun 22 Huang, Ying     ( 394) ├─>[PATCH -mm -v4 05/21] mm, THP, swap:
> 59838 N   Jun 22 Huang, Ying     ( 198) ├─>[PATCH -mm -v4 06/21] mm, THP, swap:
> 59839 N   Jun 22 Huang, Ying     ( 161) ├─>[PATCH -mm -v4 07/21] mm, THP, swap:
> 59840 N   Jun 22 Huang, Ying     ( 351) ├─>[PATCH -mm -v4 08/21] mm, THP, swap:
> 59841 N   Jun 22 Huang, Ying     ( 293) ├─>[PATCH -mm -v4 09/21] mm, THP, swap:
> 59842 N   Jun 22 Huang, Ying     ( 138) ├─>[PATCH -mm -v4 10/21] mm, THP, swap:
> 59843 N   Jun 22 Huang, Ying     ( 264) ├─>[PATCH -mm -v4 11/21] mm, THP, swap:
> 59844 N   Jun 22 Huang, Ying     ( 251) ├─>[PATCH -mm -v4 12/21] mm, THP, swap:
> 59845 N   Jun 22 Huang, Ying     ( 121) ├─>[PATCH -mm -v4 13/21] mm, THP, swap:
> 59846 N   Jun 22 Huang, Ying     ( 517) ├─>[PATCH -mm -v4 14/21] mm, cgroup, THP
> 59847 N   Jun 22 Huang, Ying     ( 128) ├─>[PATCH -mm -v4 15/21] mm, THP, swap:
> 59848 N   Jun 22 Huang, Ying     (  85) ├─>[PATCH -mm -v4 16/21] mm, THP, swap:
> 59849 N   Jun 22 Huang, Ying     (  70) ├─>[PATCH -mm -v4 17/21] mm, THP, swap:
>
> There's literally zero useful information displayed in the patch subjects.

Thanks!  What's your suggestion on tagging?  Only keep "mm" or "swap"?

Best Regards,
Huang, Ying
