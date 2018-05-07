Return-Path: <laforge@gnumonks.org>
X-Google-Smtp-Source: AB8JxZqv1Q90Mpd2HtWjh2OyQ1reUuXOoZWy+m0kNy5KC6yzW1DnyLDvJ0qaIWg0bMdRrD+qRKbX
ARC-Seal: i=1; a=rsa-sha256; t=1525707013; cv=none;
        d=google.com; s=arc-20160816;
        b=LEoR2g7EDvw1CwQi7EPeUmG9QMlxdWPQPXgsByRR51kfkKKfEycPxzdjT3UDyP5AwL
         2KFVhzKAxZ++Kfeu/KrJIAia6q85TeEZ2+raq/K4cD4fwd18/pjndu+QvPOy2VAMo789
         pc2wEq2lx/hb7jKHZHGwhDNmWtynln/U5tJIjONin0J5bGberOetSZSuX8h8U+IooqX0
         onwu0YUJ9S21IHTb8TWmA5zmBfa8QnQjAHI6COfJdbDYb1EcQnAGZHRwif1ULKAo3Uyz
         oqcEs8yJCjy5pRlT6tfPrKQ7G6wgdsUwQp8OR/ZF6iQcqKAOxMo2CrYKbLgzw5SFgt2w
         TgSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=SrJsQ8cvq+cpu0uokBWGh31+I7hZ6ouTaxZJnGMqnHQ=;
        b=ONym/U2xkVljLpgTI4FJ6V4ehuJsjcMg+C8ACez+3BvxZkhkn6CRJwCHCXplWEQZVN
         jwQYTYa8t/PngvrMEftKQi5jjYFZ2izVUc3OiY6stzv2HmcyCDI0fA4efqkbokja5N1H
         jmklPa7mKhxcmC9zPQ6YVWxNtfJU2KjDF8g221aaJW0p3ozQnbHAMCZtXsr+XaiqVyQp
         hUtPB2nOeBGV9+yrMr2HC0bkHxdzJhn0u+LSgtd3KxeJQzLcho99xZcBysiXJdnrp8xr
         h35xrYsXVQWPRI97LMlpgIsOIJbNlAvz+sbwwY3XJL3Y+Ha97NsD5oodnMXakfovanE1
         gRcg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of laforge@gnumonks.org designates 213.95.27.120 as permitted sender) smtp.mailfrom=laforge@gnumonks.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of laforge@gnumonks.org designates 213.95.27.120 as permitted sender) smtp.mailfrom=laforge@gnumonks.org
Date: Mon, 7 May 2018 17:24:35 +0200
From: Harald Welte <laforge@gnumonks.org>
To: Alexei Starovoitov <ast@kernel.org>
Cc: davem@davemloft.net, daniel@iogearbox.net,
	torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
	luto@amacapital.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 net-next 2/4] net: add skeleton of bpfilter kernel
 module
Message-ID: <20180507152435.GE19042@nataraja>
References: <20180503043604.1604587-1-ast@kernel.org>
 <20180503043604.1604587-3-ast@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180503043604.1604587-3-ast@kernel.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599416225694736469?=
X-GMAIL-MSGID: =?utf-8?q?1599819757523979967?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Alexei + netdev list,

On Wed, May 02, 2018 at 09:36:02PM -0700, Alexei Starovoitov wrote:
> Later bpfilter_process_sockopt() will be called from bpfilter hooks
> in get/setsockopt() to pass iptable commands into umh via bpfilter.ko

This is a part I'm quite heavily opposed to - at least at this point.
Unless bpfilter offered something that is semantically compatible to
what netfilter/iptables is currently implementing, I don't think
bpfilter should be [allowed to] overriding the iptables
{get,set}sockopt() calls.

I appreciate that people are working on a different architecture packet
filter than what we used to.   I also understand that there is a need
for backwards compatibility.  I still think it's wrong to offer that
compatibility on the {set,get}sockopt level, rather than on the
"iptables command line utility replacement" level.  But nevermind, you
guys have a different opinion on that, on which we can agree to
disagree.

However, no matter what you do, the most important part from the user
point of view is to make sure you don't break semantics.

netfilter/iptables semantics have an intricate notion abut when which
chain of which table is executed, in which order, at what particular
point of the packet traversal during the network stack.  The packet
filtering rulesets that people have created over more than 18 years
are based on those semantics.  If you offer the same interface, but not
that very same semantics, the packet filtering policies can an will
break - and they will break so in a hidden way.  To the user, it appears
as if the ruleset is loaded with the assumed semantics, but in reality
it isn't.

Unless you can replicate those semantics 1:1, I think it is not only
wrong to override the iptables sockopt interface, but it's outright
dangerous.

Having less matches/targets implemented than original iptables is
something that I believe is acceptable (and inevitable, at least in the
beginning).  If somebody tries to load a related ruleset with bpfilter
active, it will fail gracefully and the user can chose to not use that
match/target in his ruleset, or to not use bpfilter.

But if the ruleset loads but behaves different than before (because e.g.
it's executed from a completely different place in the stack), that's
IMHO an absolute no-go that must be avoided at all cost.  If that's the
case, you are actively breaking network security, rather than creating
it.

So I think there's only two ways to go:

a) replicate the exact semantics/order of the filter/mangle/raw/...
   tables and their chains, both among themselves as well as in terms of
   ordering with other parts of the network stack, or

b) not use the existing tables/chains with their pre-defined semantics
   but rather start new 'tables' which can then have different semantics
   as defined at the time of their implementation.

My apologies if I misunderstood something about bpfilter.  Feel free to
correct me where I'm wrong.  Thanks.

Regards,
	Harald
-- 
- Harald Welte <laforge@gnumonks.org>           http://laforge.gnumonks.org/
============================================================================
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)
