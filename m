Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WocHgy+3"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 167CB60555
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932213AbeFFShC (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 14:37:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:35930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932138AbeFFShA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 14:37:00 -0400
Date: Wed, 6 Jun 2018 15:36:57 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andi Kleen <andi@firstfloor.org>,
        Kan Liang <kan.liang@intel.com>
Subject: Re: [PATCH v2 2/3] perf script python: Add more PMU fields
Message-ID: <20180606183657.GI24381@kernel.org>
References: <1527843663-32288-1-git-send-email-yao.jin@linux.intel.com>
 <1527843663-32288-3-git-send-email-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527843663-32288-3-git-send-email-yao.jin@linux.intel.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jun 01, 2018 at 05:01:02PM +0800, Jin Yao escreveu:

<SNIP>

> +static int get_symoff(struct symbol *sym, struct addr_location *al,
> +		      bool print_off, char *bf, int size)
> +{
> +	unsigned long offset;
> +
> +	if (!sym || !sym->name)
> +		return scnprintf(bf, size, "%s", "[unknown]");

  52    54.22 ubuntu:17.04                  : FAIL gcc (Ubuntu 6.3.0-12ubuntu2) 6.3.0 20170406

  CC       /tmp/build/perf/util/scripting-engines/trace-event-python.o
util/scripting-engines/trace-event-python.c:534:20: error: address of array 'sym->name' will always evaluate to 'true' [-Werror,-Wpointer-bool-conversion]
        if (!sym || !sym->name)
                    ~~~~~~^~~~
1 error generated.
mv: cannot stat '/tmp/build/perf/util/scripting-engines/.trace-event-python.o.tmp': No such file or directory
/git/linux/tools/build/Makefile.build:96: recipe for target '/tmp/build/perf/util/scripting-engines/trace-event-python.o' failed
make[5]: *** [/tmp/build/perf/util/scripting-engines/trace-event-python.o] Error 1

Because:

struct symbol {
        struct rb_node  rb_node;
        u64             start;
        u64             end;
        u16             namelen;
<SNIP>
        char            name[0];
};

It sym->name is not a pointer, in symbol's constructor we have:

struct symbol *symbol__new(u64 start, u64 len, u8 binding, u8 type, const char *name)
{       
        size_t namelen = strlen(name) + 1;
        struct symbol *sym = calloc(1, (symbol_conf.priv_size +
                                        sizeof(*sym) + namelen));
        if (sym == NULL)
                return NULL;
<SNIP>
        sym->namelen = namelen - 1;
        memcpy(sym->name, name, namelen);

        return sym;
}

So it is at least 1 char long, the test above should be:

	if (!sym || !sym->name[0])
		return scnprintf(bf, size, "%s", "[unknown]");

I'm fixing this up here.

- Arnaldo
