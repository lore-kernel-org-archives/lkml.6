Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B498C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 09:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5251C2538E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 09:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="J3WgpO/+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5251C2538E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933005AbeF1JDF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 05:03:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39350 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932262AbeF1JDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 05:03:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=CwXYGm+G3U+xuipIqbn7lqL7pvnVJ5aS8Wwwk4ZgbbY=; b=J3WgpO/+sFAo8BIWnIU1k7r+/g
        mebLtka9Nfy+XxIDTscI+jaxOf3acB0rcearyNrZCrIY8yPgXxs5+bp4fy7hyAvV4OuBlcXAlmf6T
        NHjdkBLvozdmQY689MWwPR9Uoh1AHIfYx9X+7BXSja0YtKdxA0zCvqCs4FApdq2OWgXVoPEH3FZfm
        C5kxfS0WYcxDBRU7tfY1yv1Rt1yyY3WBRmMDJo0dap+iTQCrwkvb9AMEmSpjgqO7ACjAiEpaT5jhZ
        MCTeNn3RJECNf5FeQF0qzyzcNBtoeCPP7/QPUzlVtt9cN6bxlG2kZM0zMb95r2dJZuX++1HFVA8pB
        ffUVkIsw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fYSpR-0003XO-VF; Thu, 28 Jun 2018 09:03:01 +0000
Date:   Thu, 28 Jun 2018 02:03:01 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Huang, Ying" <ying.huang@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH -mm -v4 00/21] mm, THP, swap: Swapout/swapin THP in one
 piece
Message-ID: <20180628090301.GC7646@bombadil.infradead.org>
References: <20180622035151.6676-1-ying.huang@intel.com>
 <20180627215144.73e98b01099191da59bff28c@linux-foundation.org>
 <87r2krfpi2.fsf@yhuang-dev.intel.com>
 <20180627223118.dd2f52d87f53e7e002ed0153@linux-foundation.org>
 <87muvffp7w.fsf@yhuang-dev.intel.com>
 <20180627231839.e5ac2f38e0397979d3db7765@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180627231839.e5ac2f38e0397979d3db7765@linux-foundation.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 11:18:39PM -0700, Andrew Morton wrote:
> On Thu, 28 Jun 2018 13:35:15 +0800 "Huang\, Ying" <ying.huang@intel.com> wrote:
> > No problem.  I will rebase the patchset on your latest -mm tree, or the
> > next version to be released?
> 
> We need to figure that out with Matthew.
> 
> Probably the xarray conversions are simpler and more mature so yes,
> probably they should be staged first.

I'll take a look.  Honestly, my biggest problem with this patch set is
overuse of tagging:

59832     Jun 22 Huang, Ying     ( 131) [PATCH -mm -v4 00/21] mm, THP, swap: Swa
59833 N   Jun 22 Huang, Ying     ( 126) ├─>[PATCH -mm -v4 01/21] mm, THP, swap:
59834 N   Jun 22 Huang, Ying     (  44) ├─>[PATCH -mm -v4 02/21] mm, THP, swap:
59835 N   Jun 22 Huang, Ying     ( 583) ├─>[PATCH -mm -v4 03/21] mm, THP, swap:
59836 N   Jun 22 Huang, Ying     ( 104) ├─>[PATCH -mm -v4 04/21] mm, THP, swap:
59837 N   Jun 22 Huang, Ying     ( 394) ├─>[PATCH -mm -v4 05/21] mm, THP, swap:
59838 N   Jun 22 Huang, Ying     ( 198) ├─>[PATCH -mm -v4 06/21] mm, THP, swap:
59839 N   Jun 22 Huang, Ying     ( 161) ├─>[PATCH -mm -v4 07/21] mm, THP, swap:
59840 N   Jun 22 Huang, Ying     ( 351) ├─>[PATCH -mm -v4 08/21] mm, THP, swap:
59841 N   Jun 22 Huang, Ying     ( 293) ├─>[PATCH -mm -v4 09/21] mm, THP, swap:
59842 N   Jun 22 Huang, Ying     ( 138) ├─>[PATCH -mm -v4 10/21] mm, THP, swap:
59843 N   Jun 22 Huang, Ying     ( 264) ├─>[PATCH -mm -v4 11/21] mm, THP, swap:
59844 N   Jun 22 Huang, Ying     ( 251) ├─>[PATCH -mm -v4 12/21] mm, THP, swap:
59845 N   Jun 22 Huang, Ying     ( 121) ├─>[PATCH -mm -v4 13/21] mm, THP, swap:
59846 N   Jun 22 Huang, Ying     ( 517) ├─>[PATCH -mm -v4 14/21] mm, cgroup, THP
59847 N   Jun 22 Huang, Ying     ( 128) ├─>[PATCH -mm -v4 15/21] mm, THP, swap:
59848 N   Jun 22 Huang, Ying     (  85) ├─>[PATCH -mm -v4 16/21] mm, THP, swap:
59849 N   Jun 22 Huang, Ying     (  70) ├─>[PATCH -mm -v4 17/21] mm, THP, swap:

There's literally zero useful information displayed in the patch subjects.
