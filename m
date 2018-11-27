Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B753FC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 818C52086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:31:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 818C52086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730253AbeK0U23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 15:28:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:63904 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728512AbeK0U22 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 15:28:28 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3C6DD3002060;
        Tue, 27 Nov 2018 09:31:11 +0000 (UTC)
Received: from krava (ovpn-204-23.brq.redhat.com [10.40.204.23])
        by smtp.corp.redhat.com (Postfix) with SMTP id 11E4C381B2;
        Tue, 27 Nov 2018 09:31:05 +0000 (UTC)
Date:   Tue, 27 Nov 2018 10:31:05 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kim Phillips <kim.phillips@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        rmk+kernel@armlinux.org.uk, l.stach@pengutronix.de
Subject: Re: [PATCH v2 1/2] perf tools: Make find_vdso_map() more modular
Message-ID: <20181127093105.GC8908@krava>
References: <20181025175508.6967-1-f.fainelli@gmail.com>
 <20181025175508.6967-2-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181025175508.6967-2-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Tue, 27 Nov 2018 09:31:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 10:55:07AM -0700, Florian Fainelli wrote:
> In preparation for checking that the vectors page on the ARM
> architecture, refactor the find_vdso_map() function to accept finding an
> arbitrary string and create a dedicated helper function for that under
> util/find-map.c and update find_vdso_map() to use it.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  tools/perf/util/find-map.c      | 31 +++++++++++++++++++++++++++++++
>  tools/perf/util/find-vdso-map.c | 30 +++---------------------------
>  2 files changed, 34 insertions(+), 27 deletions(-)
>  create mode 100644 tools/perf/util/find-map.c
> 
> diff --git a/tools/perf/util/find-map.c b/tools/perf/util/find-map.c
> new file mode 100644
> index 000000000000..19a3431a7b2a
> --- /dev/null
> +++ b/tools/perf/util/find-map.c
> @@ -0,0 +1,31 @@
> +// SPDX-License-Identifier: GPL-2.0
> +static int find_map(void **start, void **end, const char *name)
> +{
> +	FILE *maps;
> +	char line[128];
> +	int found = 0;
> +
> +	maps = fopen("/proc/self/maps", "r");
> +	if (!maps) {
> +		fprintf(stderr, "vdso: cannot open maps\n");
> +		return -1;
> +	}
> +
> +	while (!found && fgets(line, sizeof(line), maps)) {
> +		int m = -1;
> +
> +		/* We care only about private r-x mappings. */
> +		if (2 != sscanf(line, "%p-%p r-xp %*x %*x:%*x %*u %n",
> +				start, end, &m))
> +			continue;
> +		if (m < 0)
> +			continue;
> +
> +		if (!strncmp(&line[m], name, strlen(name)))
> +			found = 1;
> +	}
> +
> +	fclose(maps);
> +	return !found;
> +}

please keep just one object for both.. looks to me like
it coud go to util.c.. or just find-map.c if there's
a reason to have this separated

thanks,
jirka
