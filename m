Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A2DFC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 11:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8F412086B
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 11:55:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8F412086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbeIYSDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 14:03:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:56532 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727730AbeIYSDA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 14:03:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3B851ADC2;
        Tue, 25 Sep 2018 11:55:48 +0000 (UTC)
Date:   Tue, 25 Sep 2018 13:55:47 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     zhe.he@windriver.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] printk: Fix panic caused by passing log_buf_len
 to command line
Message-ID: <20180925115547.yd6bm5amzqsgwnrx@pathway.suse.cz>
References: <1537630852-247674-1-git-send-email-zhe.he@windriver.com>
 <20180925113840.GA523@tigerII.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180925113840.GA523@tigerII.localdomain>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2018-09-25 20:38:40, Sergey Senozhatsky wrote:
> On (09/22/18 23:40), zhe.he@windriver.com wrote:
> > @@ -1048,7 +1048,14 @@ static void __init log_buf_len_update(unsigned size)
> >  /* save requested log_buf_len since it's too early to process it */
> >  static int __init log_buf_len_setup(char *str)
> >  {
> > -	unsigned size = memparse(str, &str);
> > +	unsigned int size;
> > +
> > +	if (!str) {
> > +		pr_err("boot command line parameter value not provided\n");
> > +		return -EINVAL;
> > +	}
> 
> Hmm, I thought we agreed on dropping this error print out. It's not exactly
> useful; we still have the default buffer size.

Yeah, we should either use a better message or drop it. I am fine with both
solutions.

Best Regards,
Petr
