Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB1BC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C9642081B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:27:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C9642081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbeLDP13 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 10:27:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:33970 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725910AbeLDP13 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 10:27:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 81066AD25;
        Tue,  4 Dec 2018 15:27:26 +0000 (UTC)
Date:   Tue, 4 Dec 2018 16:27:24 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] printk: Add caller information to printk() output.
Message-ID: <20181204152724.ypk44mi4a56nrud4@pathway.suse.cz>
References: <1543045075-3008-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20181130154024.ls3mntfdr4zvluub@pathway.suse.cz>
 <f224bd68-7394-ff70-cad6-d3fbbb3b5f7d@i-love.sakura.ne.jp>
 <20181203150603.cdqii263e4kmmibo@pathway.suse.cz>
 <b38c6957-c3c1-54fc-781e-06d7eed6a9b1@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b38c6957-c3c1-54fc-781e-06d7eed6a9b1@i-love.sakura.ne.jp>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2018-12-04 06:10:40, Tetsuo Handa wrote:
> On 2018/12/04 0:06, Petr Mladek wrote:
> >> If we modify print_time(), I think that the leading spaces inserted by "%5lu"
> >> makes little sense, for "%5lu" is too small for systems with uptime >= 1.16 days
> >> and parsers after all cannot assume fixed length for the timestamp field. Then,
> >> we could change from "%5lu.%06lu" to "%lu.%06lu" so that parsers (like /bin/awk)
> >> can get prefix part using white spaces as a delimiter.
> > 
> > My primary concern was a human readability. The different header columns
> > are separated by brackets and the message itself is separated by the space.
> 
> PID_MAX_LIMIT is 4194304, which can take up to 10 bytes if [T%u] is used.

4194304 is the worst case. I would use the same approach as with the
timestamp seconds. It uses 5 characters as the minimum. But it might
eventully get bigger.

IMHO, [T%5u] looks like a reasonable default.


> But unless a race occurs, each series of printk() lines are printed with
> same width.

It is not about series of printk() lines. It is about readability of the
entire log.


> My concern is how to minimize number of characters written to
> consoles, for writing to consoles are slow, and userspace usually uses
> /dev/kmsg rather than netconsole as a source. For normal users who do not
> need to directly parse console/netconsole output, saving spaces in the header
> fields will be OK.

The number of characters is important. But we do not need to get to the
extreme. Readability by humans is important.


> > /dev/kmsg uses key=value notation. It does not need any version. The
> > version filed was intended for crashdump. It would make the life
> > easier for its maintainers.
> 
> If the version field is for crashdump rather than for netconsole, we can
> get it from some vmcoreinfo variable rather than appending to every record.

Exactly. And I asked you to add back
VMCOREINFO_OFFSET(printk_log, from_id).

Best Regards,
Petr
