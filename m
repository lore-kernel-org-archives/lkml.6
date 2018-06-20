Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D6AC43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 20:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD6C020020
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 20:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="XnxVNBmJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD6C020020
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933200AbeFTUUi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 16:20:38 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:37111 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932760AbeFTUUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 16:20:37 -0400
Received: by mail-pl0-f68.google.com with SMTP id 31-v6so375341plc.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 13:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=H2TrHhpH3pmhs7MS6ypwNwTrdqwCPgciwd1R1lWJkVg=;
        b=XnxVNBmJ0xwUa2H+LNTablkv/iycTBD9DngDJ47ThSjx623bgXNUGn8HeRmtvST18A
         5c1SnWhKgwUHDF3k5U+4aZR5m/ibyPhl5tIcNsTNXQJAJKhIEzHqDcCu94ImhSywsqw4
         mj/UAJjPc2q3PRNMpx6lTb6GXXZGOBx5BQlI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=H2TrHhpH3pmhs7MS6ypwNwTrdqwCPgciwd1R1lWJkVg=;
        b=rQERe9WiGyKrIUxf7W+gaULlWxfPTPeA9AddbxCrReVEmZmtRP2xYXu+JHC+T8HaiE
         x5QCuoekRvdJyWMFBxtWAcfLSA5cqiXs/6+j2gobLcTRH0nyb46vUvgFJKmeax0T1iPZ
         ysk4W6BhljWi6Yt27m+PDmBMldZSn19C7J/jlkbua0L1fYSgklnAveqaZ5YQsB3sB17+
         31QVqnEJIBOH11HaPKqZ73wpAR4/nWRfrkFCcXdMekwz0+9bphMqlS7UQ1RWUk7/neWf
         AH2NMLluxG+oi4acEmyPjc2sklAJS5rCSKyfZ5z5Nbt0kDh+NQ7ksQVO2mXesv6lMOXk
         lALA==
X-Gm-Message-State: APt69E3fSDL/PaoU0ogPURKl+rMkeCoBqaXmpcdOkmA8K7nSbktug9Ig
        e2ijtqKMtXYCeMqcdd/9/zcQrw==
X-Google-Smtp-Source: ADUXVKJgPh7sdFtmo4SGP2heyHJbLWdhXlqT6DOZJUaebB1Fohsrq/Q2pjuQuUj2yb9E3Q//V2uYfg==
X-Received: by 2002:a17:902:8341:: with SMTP id z1-v6mr25597376pln.40.1529526036891;
        Wed, 20 Jun 2018 13:20:36 -0700 (PDT)
Received: from localhost ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id l62-v6sm4223235pga.21.2018.06.20.13.20.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 13:20:36 -0700 (PDT)
Date:   Wed, 20 Jun 2018 13:20:35 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zilstra <peterz@infradead.org>,
        Joel Fernandes <joelaf@google.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Fenguang Wu <fengguang.wu@intel.com>,
        Baohong Liu <baohong.liu@intel.com>,
        Vedang Patel <vedang.patel@intel.com>, kernel-team@android.com
Subject: Re: [PATCH] softirq: reorder trace_softirqs_on to prevent lockdep
 splat
Message-ID: <20180620202035.GA122295@joelaf.mtv.corp.google.com>
References: <20180427041100.133772-1-joelaf@google.com>
 <20180620160513.0453247e@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180620160513.0453247e@gandalf.local.home>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 04:05:13PM -0400, Steven Rostedt wrote:
> 
> Peter, can you ack this.
> 
> On Thu, 26 Apr 2018 21:11:00 -0700
> Joel Fernandes <joelaf@google.com> wrote:
> 
> > I'm able to reproduce a lockdep splat when CONFIG_PROVE_LOCKING=y and
> > CONFIG_PREEMPTIRQ_EVENTS=y.
> > 
> > $ echo 1 > /d/tracing/events/preemptirq/preempt_enable/enable
> > ---
> 
> BTW, the "---" here causes git to ignore everything underneath it :-/

Oh ok, I actually already fixed the '---' issue in the change log since then:

Here's a recent posting of the patch: https://patchwork.kernel.org/patch/10453483/
(patch is the same, only the commit log is fixed to remove '---').

thanks,

- Joel
 
