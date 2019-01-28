Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 732D0C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F9DF2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730147AbfA1RfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:35:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40712 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729228AbfA1RfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 12:35:12 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 272E0A4287;
        Mon, 28 Jan 2019 17:35:12 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.163])
        by smtp.corp.redhat.com (Postfix) with SMTP id EBE0116BF6;
        Mon, 28 Jan 2019 17:35:10 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 28 Jan 2019 18:35:10 +0100 (CET)
Date:   Mon, 28 Jan 2019 18:35:09 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Brian Behlendorf <behlendorf1@llnl.gov>,
        Siarhei Volkau <lis8215@gmail.com>
Subject: Re: [PATCH] lib/div64: off by one in shift
Message-ID: <20190128173508.GD22143@redhat.com>
References: <1548686944-11891-1-git-send-email-sgruszka@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548686944-11891-1-git-send-email-sgruszka@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Mon, 28 Jan 2019 17:35:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/28, Stanislaw Gruszka wrote:
>
> fls counts bits starting from 1 to 32 (returns 0 for zero argument).
> If we add 1 we shift right one bit more and loose precision

I forgot everything about this code, but I think this patch must be correct,

	divisor >> n;

should have MSB == 1 or we loose the precision... Heh, I managed to find the
initial version of this code, see

	https://lore.kernel.org/lkml/20101014121159.GA407@redhat.com/

and note that it uses __fls(), not fls()! I didn't notice the final version
replaced __fls() with fls() which is __fls() + 1 if arg != 0.

Acked-by: Oleg Nesterov <oleg@redhat.com>

