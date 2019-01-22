Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB8CC282C5
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 04:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3363B20855
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 04:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbfAVEOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 23:14:46 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:14977 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726819AbfAVEOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 23:14:46 -0500
X-UUID: a458644dd1854e088f11c1ecc95e2c13-20190122
X-UUID: a458644dd1854e088f11c1ecc95e2c13-20190122
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1906042018; Tue, 22 Jan 2019 12:14:37 +0800
Received: from MTKMBS06N1.mediatek.inc (172.21.101.129) by
 mtkexhb01.mediatek.inc (172.21.101.102) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 22 Jan 2019 12:14:36 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 22 Jan 2019 12:14:35 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 22 Jan 2019 12:14:35 +0800
Message-ID: <1548130475.7975.74.camel@mtkswgap22>
Subject: Re: [PATCH] mm/slub: use WARN_ON() for some slab errors
From:   Miles Chen <miles.chen@mediatek.com>
To:     Christopher Lameter <cl@linux.com>
CC:     Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Tue, 22 Jan 2019 12:14:35 +0800
In-Reply-To: <01000168726fcf15-81d8feb3-26f0-44d6-bbd8-62aa149118b5-000000@email.amazonses.com>
References: <1548063490-545-1-git-send-email-miles.chen@mediatek.com>
         <01000168726fcf15-81d8feb3-26f0-44d6-bbd8-62aa149118b5-000000@email.amazonses.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-01-21 at 22:02 +0000, Christopher Lameter wrote:
> On Mon, 21 Jan 2019, miles.chen@mediatek.com wrote:
> 
> > From: Miles Chen <miles.chen@mediatek.com>
> >
> > When debugging with slub.c, sometimes we have to trigger a panic in
> > order to get the coredump file. To do that, we have to modify slub.c and
> > rebuild kernel. To make debugging easier, use WARN_ON() for these slab
> > errors so we can dump stack trace by default or set panic_on_warn to
> > trigger a panic.
> 
> These locations really should dump stack and not terminate. There is
> subsequent processing that should be done.

Understood. We should not terminate the process for normal case. The
change only terminate the process when panic_on_warn is set.

> Slub terminates by default. The messages you are modifying are only
> enabled if the user specified that special debugging should be one
> (typically via a kernel parameter slub_debug).

I'm a little bit confused about this: Do you mean that I should use the
following approach?

1. Add a special debugging flag (say SLAB_PANIC_ON_ERROR) and call
panic() by:

if (s->flags & SLAB_PANIC_ON_ERROR)
     panic("slab error");

2. The SLAB_PANIC_ON_ERROR should be set by slub_debug param.

> It does not make sense to terminate the process here.


Thanks for you comment. Sometimes it's useful to trigger a panic and get
its coredump file before any restore/reset processing because we can
exam the unmodified data in the coredump file with this approach. 

I added BUG() for the slab errors in internal branches for a few years
and it does help for both software issues and bit flipping issues. It's
a quite useful in developing stage.

cheers,
Miles

