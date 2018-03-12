Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751392AbeCLMmu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 08:42:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39784 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751053AbeCLMmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 08:42:49 -0400
Date: Mon, 12 Mar 2018 13:42:46 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH 3/3] tracing: Rewrite filter logic to be simpler and
 faster
Message-ID: <20180312124246.GC23111@krava>
References: <20180310023442.791997138@goodmis.org>
 <20180310023907.798690563@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180310023907.798690563@goodmis.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 09, 2018 at 09:34:45PM -0500, Steven Rostedt wrote:

SNIP

>  
> -/* If not of not match is equal to not of not, then it is a match */
> +/*
> + * Without going into a formal proof, this explains the method that is used in
> + * parsing the logical expressions.
> + *
> + * For example, if we have: "a && !(!b || (c && g)) || d || e && !f"
> + * The first pass will convert it into the following program:
> + *
> + * n1: r=a;       l1: if (!r) goto l4;
> + * n2: r=b;       l2: if (!r) goto l4;

got stuck in here.. should that be 'goto l5' ?

jirka

> + * n3: r=c; r=!r; l3: if (r) goto l4;
> + * n4: r=g; r=!r; l4: if (r) goto l5;
> + * n5: r=d;       l5: if (r) goto T
> + * n6: r=e;       l6: if (!r) goto l7;
> + * n7: r=f; r=!r; l7: if (!r) goto F
> + * T: return TRUE
> + * F: return FALSE

jirka
