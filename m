Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F05AEC64EB0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 21:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B32842085B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 21:42:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B32842085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbeJJFA7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 01:00:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42394 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725837AbeJJFA7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 01:00:59 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EF81D3DD47;
        Tue,  9 Oct 2018 21:42:02 +0000 (UTC)
Received: from krava (ovpn-204-35.brq.redhat.com [10.40.204.35])
        by smtp.corp.redhat.com (Postfix) with SMTP id 893577E67D;
        Tue,  9 Oct 2018 21:41:59 +0000 (UTC)
Date:   Tue, 9 Oct 2018 23:41:58 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Anthony LaTorre <tlatorre9@gmail.com>
Cc:     peterz@infradead.org, mingo@redhat.com, jolsa@kernel.org,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: perf report segfault
Message-ID: <20181009214158.GB31206@krava>
References: <CAO49afLqUGuBi_R7BKyojqnkHrMGqXquy-FdVFscOu6Ez0cVFw@mail.gmail.com>
 <20181009164743.GA22886@krava>
 <CAO49af+zxxVh9HGfjKxS=vQcD5po7-oLU87Zp0F21M-C64nWUA@mail.gmail.com>
 <CAO49afJVHsywYdosSqceQiMzFdaYivm4kiNnC_+WKq15jsA7Dg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO49afJVHsywYdosSqceQiMzFdaYivm4kiNnC_+WKq15jsA7Dg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Tue, 09 Oct 2018 21:42:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2018 at 03:18:12PM -0500, Anthony LaTorre wrote:
> Ok, I can reliably reproduce it by profiling the following program:
> 
> #include <math.h>
> 
> int main(int argc, char **argv)
> {
>     int i;
>     double sum;
> 
>     while (1) {
>         sum += exp(++i);
>     }
> 
>     return 0;
> }
> 
> compiled with:
> 
> $ cc -o test test.c -lm
> 
> with the following command:
> 
> $ perf record -F 99 -p 20016 --call-graph dwarf sleep 10

still nothing.. any chance you could try on latest perf sources?

	$ git clone git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git
	$ cd linux
	$ git checkout -b perf/core origin/perf/core
	$ cd tools/perf
	$ make
	$ ./perf ...

you might need some packages mentioned in (search for 'yum install'):
  https://perf.wiki.kernel.org/index.php/Jolsa_Howto_Install_Sources

it's little outdated, but the packages lists will do

thanks,
jirka
