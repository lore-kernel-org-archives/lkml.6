Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7EBC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 08:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95A6620841
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 08:09:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95A6620841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbeJJPaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 11:30:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:38220 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725837AbeJJPae (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 11:30:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4BFF9AFDA;
        Wed, 10 Oct 2018 08:09:33 +0000 (UTC)
Date:   Wed, 10 Oct 2018 10:09:32 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     zhe.he@windriver.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/4] printk: Give error on attempt to set log buffer
 length to over 4G
Message-ID: <20181010080932.h6nln2qsgg4oef4l@pathway.suse.cz>
References: <1538239553-81805-1-git-send-email-zhe.he@windriver.com>
 <1538239553-81805-4-git-send-email-zhe.he@windriver.com>
 <20181008135916.gg4kkmoki5bgtco5@pathway.suse.cz>
 <20181008145950.GA1473@tigerII.localdomain>
 <20181009130538.7rtd3du2d7l6m63w@pathway.suse.cz>
 <20181009135758.GA1419@tigerII.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181009135758.GA1419@tigerII.localdomain>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2018-10-09 22:57:58, Sergey Senozhatsky wrote:
> On (10/09/18 15:05), Petr Mladek wrote:
> > > 
> > > Yeah, I think we gonna have problems even with a 4G logbuf and a 32-bit
> > > user-space doing syslog(int len).
> > > 
> > > I agree on the "not motivated enough" part ;)
> > 
> > OK, I have pushed an updated patch that has the limit 2GB
> > into printk.git, for-4.20 branch.
> > 
> > Note that it is slightly different than the yesterday's proposal.
> > I made a mistake in testing and still compared with UNIT_MAX.
> > 
> > The pushed version can be seen at
> > https://git.kernel.org/pub/scm/linux/kernel/git/pmladek/printk.git/commit/?h=for-4.20&id=e6fe3e5b7d16e8f146a4ae7fe481bc6e97acde1e
> 
> 
> ---
> 
> > +#define LOG_BUF_LEN_MAX (u32)(1 << 31)
> [..]
> > +	if (size > (u64)LOG_BUF_LEN_MAX) {
> > +		size = (u64)LOG_BUF_LEN_MAX;
> > +		pr_err("log_buf over 2G is not supported.\n");
> > +	}
> 
> Why not INT_MAX?

INT_MAX is 0x7fffffff but we need 0x80000000. I did not find
any predefined macro.

> 
> > +	pr_info("log_buf_len: %u bytes\n", log_buf_len);
> > +	pr_info("early log buf free: %u(%u%%)\n",
> >  		free, (free * 100) / __LOG_BUF_LEN);
> 
> Can 'free * 100' overflow?

Good question. It uses the size of the static buffer. If I count
correctly then we are on the safe side because LOG_BUF_SHIFT
is limited by

	range 12 25

Best Regards,
Petr
