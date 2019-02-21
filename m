Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21CEAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 19:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAF162081B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 19:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbfBUTya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 14:54:30 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:48292 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbfBUTya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 14:54:30 -0500
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6D1F64355;
        Thu, 21 Feb 2019 19:54:29 +0000 (UTC)
Date:   Thu, 21 Feb 2019 11:54:26 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/2] test_firmware: silence underflow warning in
 test_dev_config_update_u8()
Message-Id: <20190221115426.f616100906d989eda93d66dc@linux-foundation.org>
In-Reply-To: <20190221191855.GB1737@kadam>
References: <20190221183700.GA1737@kadam>
        <20190221183826.GA30993@kadam>
        <20190221105458.409d1968961962079c54b815@linux-foundation.org>
        <20190221191855.GB1737@kadam>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Feb 2019 22:18:56 +0300 Dan Carpenter <dan.carpenter@oracle.com> wrote:

> On Thu, Feb 21, 2019 at 10:54:58AM -0800, Andrew Morton wrote:
> > On Thu, 21 Feb 2019 21:38:26 +0300 Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > 
> > > We put an upper bound on "new" but we don't check for negatives.
> > 
> > U8_MAX has unsigned type, so `if (new > U8_MAX)' does check for negative.
> > 
> 
> No, doesn't work in this case.
> 
> #define U8_MAX          ((u8)~0U)
> 
> It would need to unsigned long for the type promotion to prevent
> negatives, but it starts as unsigned int, then unsigned char, which is
> type promoted to int.

OK.

> It would be more clear to just write it as:
> 
> #define U8_MAX 0xff

That doesn't work either.  Tricky.


#include <stdio.h>

typedef unsigned char u8;

#define U8_MAX 0xff

int main(int argc, char *argv[])
{
	long new;

	new = -20;

	if (new > U8_MAX)
		printf("over\n");
}

