Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B76C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14452213A2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:05:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14452213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbeJIUWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 16:22:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:41180 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726415AbeJIUWd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 16:22:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9ED4AAE8F;
        Tue,  9 Oct 2018 13:05:40 +0000 (UTC)
Date:   Tue, 9 Oct 2018 15:05:38 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     zhe.he@windriver.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/4] printk: Give error on attempt to set log buffer
 length to over 4G
Message-ID: <20181009130538.7rtd3du2d7l6m63w@pathway.suse.cz>
References: <1538239553-81805-1-git-send-email-zhe.he@windriver.com>
 <1538239553-81805-4-git-send-email-zhe.he@windriver.com>
 <20181008135916.gg4kkmoki5bgtco5@pathway.suse.cz>
 <20181008145950.GA1473@tigerII.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181008145950.GA1473@tigerII.localdomain>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2018-10-08 23:59:50, Sergey Senozhatsky wrote:
> On (10/08/18 15:59), Petr Mladek wrote:
> > I tried this patch with log_buf_len=5G. The kernel did not crash
> > but dmesg shown some mess. There are several 32-bit variables
> > to store the size, for example:
> > 
> > static u32 log_buf_len = __LOG_BUF_LEN;
> > u32 log_buf_len_get(void)
> > static u32 log_first_idx;
> > static u32 log_next_idx;
> > 
> > I guess that the code somewhere does not detect an overflows
> > correctly.
> > 
> > I am not motivated enought to add support for such huge message
> > buffer. Therefore I suggest to limit it to 32G for now.
> 
> Yeah, I think we gonna have problems even with a 4G logbuf and a 32-bit
> user-space doing syslog(int len).
> 
> I agree on the "not motivated enough" part ;)

OK, I have pushed an updated patch that has the limit 2GB
into printk.git, for-4.20 branch.

Note that it is slightly different than the yesterday's proposal.
I made a mistake in testing and still compared with UNIT_MAX.

The pushed version can be seen at
https://git.kernel.org/pub/scm/linux/kernel/git/pmladek/printk.git/commit/?h=for-4.20&id=e6fe3e5b7d16e8f146a4ae7fe481bc6e97acde1e

Best Regards,
Petr
