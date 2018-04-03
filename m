Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932106AbeDCLwC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 07:52:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:49578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755435AbeDCLwB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 07:52:01 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1A822133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Tue, 3 Apr 2018 07:51:58 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: Zhaoyang Huang <huangzhaoyang@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-patch-test@lists.linaro.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Joel Fernandes <joelaf@google.com>, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v1] kernel/trace:check the val against the available mem
Message-ID: <20180403075158.0c0a2795@gandalf.local.home>
In-Reply-To: <20180403110612.GM5501@dhcp22.suse.cz>
References: <1522320104-6573-1-git-send-email-zhaoyang.huang@spreadtrum.com>
        <20180330102038.2378925b@gandalf.local.home>
        <20180403110612.GM5501@dhcp22.suse.cz>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Apr 2018 13:06:12 +0200
Michal Hocko <mhocko@kernel.org> wrote:

> > I wonder if I should have the ring buffer allocate groups of pages, to
> > avoid this. Or try to allocate with NORETRY, one page at a time, and
> > when that fails, allocate groups of pages with RETRY_MAYFAIL, and that
> > may keep it from causing an OOM?  
> 
> I wonder why it really matters. The interface is root only and we expect
> some sanity from an admin, right? So allocating such a large ring buffer
> that it sends the system to the OOM is a sign that the admin should be
> more careful. Balancing on the OOM edge is always a risk and the result
> will highly depend on the workload running in parallel.

This came up because there's scripts or programs that set the size of
the ring buffer. The complaint was that the application would just set
the size to something bigger than what was available and cause an OOM
killing other applications. The final solution is to simply check the
available memory before allocating the ring buffer:

	/* Check if the available memory is there first */
	i = si_mem_available();
	if (i < nr_pages)
		return -ENOMEM;

And it works well.

-- Steve
