Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033715AbeBOTsq (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 14:48:46 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42222 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033540AbeBOTsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 14:48:41 -0500
Date: Thu, 15 Feb 2018 20:48:28 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Jerry Hoemann <jerry.hoemann@hpe.com>
Cc: Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Tim Chen <tim.c.chen@linux.intel.com>, Dave Hansen <dave@sr71.net>,
        hpa@zytor.com, tglx@linutronix.de, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, dwmw@amazon.co.uk,
        linux-tip-commits@vger.kernel.org,
        Arjan van de Ven <arjan@infradead.org>, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: hpwdt: Remove spinlock acquire and BIOS calls
 from NMI context
Message-ID: <20180215194828.GX25201@hirez.programming.kicks-ass.net>
References: <20180212102211.cdrrqqd4hdw7xu5y@gmail.com>
 <a85c28b8-1255-3264-bb4a-89e85e3c6009@sr71.net>
 <20180212165835.GO25181@hirez.programming.kicks-ass.net>
 <20180213075540.3lkikkpgjoe6ocjk@gmail.com>
 <5c3ba123-abbe-f153-7b75-a89d31d25c72@linux.intel.com>
 <20180214093159.mdzfupne547bi5qx@gmail.com>
 <20180214094404.GA18349@pd.tnic>
 <20180214181342.GA27600@anatevka.americas.hpqcorp.net>
 <20180214231704.xv2iwqsfvljoybul@gmail.com>
 <20180215174444.GA25970@anatevka.americas.hpqcorp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180215174444.GA25970@anatevka.americas.hpqcorp.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2018 at 10:44:44AM -0700, Jerry Hoemann wrote:
> Is your desire to remove of the firmware callback/spinlock in hpwdt_pretimeout
> related to David Woodhouse patch set:

That's the work that made us find this code, but no, even without that,
code like that is entirely dodgy. NMI code needs to be very careful and
firmware just isn't something I trust to get things right. Worse, its
not something we can fix.

And using spnilock from NMI context is just wrong, if anything it needs
be raw_spnilock but even then, yuck.
