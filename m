Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755294AbeDWNWw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 09:22:52 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40878 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755273AbeDWNWt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 09:22:49 -0400
Date: Mon, 23 Apr 2018 14:22:43 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: Smatch check for Spectre stuff
Message-ID: <20180423132242.iwpltjacdk3xyktf@lakrids.cambridge.arm.com>
References: <20180419051510.GA21898@mwanda>
 <20180420124750.fgwrsyhuqd26mj34@lakrids.cambridge.arm.com>
 <20180423125307.fpqn5shjq3rpsyx3@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180423125307.fpqn5shjq3rpsyx3@mwanda>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 03:53:07PM +0300, Dan Carpenter wrote:
> On Fri, Apr 20, 2018 at 01:47:51PM +0100, Mark Rutland wrote:
> > > What the test does is it looks at array accesses where the user controls
> > > the offset.  It asks "is this a read?" and have we used the
> > > array_index_nospec() macro?  If the answers are yes, and no respectively
> > > then print a warning.
> > > 
> > > http://repo.or.cz/smatch.git/blob/HEAD:/check_spectre.c
> > 
> > I just built this and threw it at v4.17-rc1, but I'm having problems
> > with the build_kernel_data.sh step.
> > 
> > I get an error:
> > 
> > DBD::SQLite::db do failed: unrecognized token: "'end + strlen("
> > " at ../smatch/smatch_scripts/../smatch_data/db/fill_db_sql.pl line 32, <WARNS> line 294127.
> > 
> > ... in my smatch_warns.txt I see that I have the lines:
> > 
> > net/netfilter/nf_conntrack_sip.c:1524 sip_help_tcp() SQL: insert or ignore into constraints (str) values('end + strlen("^M
> > ^M
> > ")');
> > 
> > ... and the corresponding line in that file is:
> > 
> > for (; end + strlen("\r\n\r\n") <= dptr + datalen; end++) {
> > 
> > ... so I guess there's some dodgy escaping somewhere?
> > 
> > I only see a small number of potential spectre issues reported:
> 
> Yeah...  Sorry.  I will fix that.  It doesn't affect anything unless
> someone starts to add SQL injection strings to the kernel but it's not
> the right thing.

Good to know! As long as that's not affecting the results, I'll ignore
that for now.

As an aside, it looks like smatch_data/db/constraints_required.schema is
missing a trailing semicolon, as the other schema files have. On one of
my machines, the distro's sqlite doesn't seem happy without it.

[...]

> The thing is say we get user data in one function then pass it to the
> next and the next down the call tree...  Smatch is only building one
> layer of the call tree when you build the DB.  So you have to rebuild a
> bunch of time (like 3 or maybe 5) each time you rebuild the DB.
> 
> Normally, I rebuild the DB every day so it just accretes.

Ah, I see.

I'll run that in a loop to build my local db.

Thanks for the help!

Thanks,
Mark
