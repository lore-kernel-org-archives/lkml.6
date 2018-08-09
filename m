Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A4D8C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 10:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4B0821CCE
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 10:41:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4B0821CCE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730438AbeHINGB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 09:06:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44554 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727768AbeHINGB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 09:06:01 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A676D72620;
        Thu,  9 Aug 2018 10:41:44 +0000 (UTC)
Received: from localhost (unknown [10.43.2.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 45F9D23149;
        Thu,  9 Aug 2018 10:41:44 +0000 (UTC)
Date:   Thu, 9 Aug 2018 12:41:38 +0200
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH wireless-drivers] mt76x0: Remove VLA usage
Message-ID: <20180809104137.GA1955@redhat.com>
References: <20180807225040.GA2164@beast>
 <20180808092450.GA25772@redhat.com>
 <871sb942cx.fsf@kamboji.qca.qualcomm.com>
 <CAGXu5jKqeAHDWdNg++QJko5AM4g160kEQ54jLAojpRq6FszqgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jKqeAHDWdNg++QJko5AM4g160kEQ54jLAojpRq6FszqgA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 09 Aug 2018 10:41:44 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 09 Aug 2018 10:41:44 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'sgruszka@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2018 at 08:41:28AM -0700, Kees Cook wrote:
> >> I thought SPDX line is needed only if file has no license and eeprom.c
> >> file and other mt76x0 files have specified the license. Is SPDX still
> >> needed in that case ?
> 
> I thought all source files needed SPDX: https://lwn.net/Articles/739183/

Ok, goal is to have all kernel source files with SPDX header.

> >>> +#define MT_MAP_READS        DIV_ROUND_UP(MT_EFUSE_USAGE_MAP_SIZE, 16)
> >>>  static int
> >>>  mt76x0_efuse_physical_size_check(struct mt76x0_dev *dev)
> >>>  {
> >>> -    const int map_reads = DIV_ROUND_UP(MT_EFUSE_USAGE_MAP_SIZE, 16);
> >>> -    u8 data[map_reads * 16];
> >>
> >> Why this is variable length array? DIV_ROUND_UP can not be calculated
> >> at compile time? But if so, macro do not change the situation either.
> >
> > The commit log mentioned:
> >
> >   "Even with "const" variables, the compiler will generate warnings about
> >    VLA usage."
> >
> > So I guess the compiler (gcc?) is just not smart enough in this case?
> 
> Correct. This is technically a false positive, but with the goal of
> adding -Wvla to the build globally, we have to get rid of these as
> well. It's a little frustrating, I agree, but with all others fixed
> now, these stand out. :)

Then:
Acked-by: Stanislaw Gruszka <sgruszka@redhat.com>
