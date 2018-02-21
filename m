Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937713AbeBUOdn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 09:33:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:38964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934437AbeBUOdl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 09:33:41 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 601B02178F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Wed, 21 Feb 2018 11:33:37 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: Andi Kleen <andi@firstfloor.org>, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 2/2] perf, tools, stat: Reset ids counter when retrying
 events
Message-ID: <20180221143337.GC24416@kernel.org>
References: <20171006020029.13339-1-andi@firstfloor.org>
 <20171006020029.13339-2-andi@firstfloor.org>
 <20180221143117.GB2565@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180221143117.GB2565@krava>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Feb 21, 2018 at 03:31:17PM +0100, Jiri Olsa escreveu:
> On Thu, Oct 05, 2017 at 07:00:29PM -0700, Andi Kleen wrote:
> > From: Andi Kleen <ak@linux.intel.com>
> 
> ouch, sry for overlooking this
> 
> > 
> > perf stat can retry opening events. After opening an file descriptor
> > it adds the ids to the ecsel. Each event keeps a running
> > count of ids. When we decide to close an evsel and retry
> > with a different configuration this count needs to be reset,
> > otherwise it can overflow the buffer.
> 
> how can this happen? we call store_counter_ids at the
> end of the loop, when the evsel is all done and can't
> be reconfigured

Yeah, I couldn't figure out the exact sequence, but I think that we need
to reset those hash tables when doing a perf_evlist__close(), no? I.e.
when we open we may get new ids, so need to rehash?

- Arnaldo
