Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932494AbeDWUIz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 16:08:55 -0400
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:40864 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932306AbeDWUIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 16:08:51 -0400
Date: Mon, 23 Apr 2018 22:08:44 +0200
From: Florian Westphal <fw@strlen.de>
To: Ahmed Abdelsalam <amsalam20@gmail.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, fw@strlen.de,
        davem@davemloft.net, dav.lebrun@gmail.com,
        linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, netdev@vger.kernel.org
Subject: Re: [nf-next] netfilter: extend SRH match to support matching
 previous, next and last SID
Message-ID: <20180423200844.bq3ksj262brrifnj@breakpoint.cc>
References: <1524480503-1883-1-git-send-email-amsalam20@gmail.com>
 <1524480503-1883-2-git-send-email-amsalam20@gmail.com>
 <20180423173047.gsf2xjlmpichyvte@salvia>
 <20180423220148.03800031d0cb8e8a7a83dc31@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180423220148.03800031d0cb8e8a7a83dc31@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ahmed Abdelsalam <amsalam20@gmail.com> wrote:
> > > @@ -50,6 +62,12 @@ struct ip6t_srh {
> > >  	__u8                    segs_left;
> > >  	__u8                    last_entry;
> > >  	__u16                   tag;
> > > +	struct in6_addr		psid_addr;
> > > +	struct in6_addr		nsid_addr;
> > > +	struct in6_addr		lsid_addr;
> > > +	struct in6_addr		psid_msk;
> > > +	struct in6_addr		nsid_msk;
> > > +	struct in6_addr		lsid_msk;
> > 
> > This is changing something exposed through UAPI, so you will need a
> > new revision for this.
> 
> Could you please advice what should be done in this case? 

You need to add
struct ip6t_srh_v1 {
	/* copy of struct ip6t_srh here */

	/* new fields go here */
};


Look at xt_conntrack.c, conntrack_mt_reg[] for an example of
multi-revision match.

You can probably re-origanise code to avoid too much duplication.
See 5a786232eb69a1f870ddc0cfd69d5bdef241a2ea in nf.git for an example,
it makes v0 into a v1 struct at runtime and re-uses new v1 code
for old v0.
