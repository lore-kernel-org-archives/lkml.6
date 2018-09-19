Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99DB3C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 18:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45B3321521
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 18:31:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZ59Vvny"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45B3321521
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733117AbeITAKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 20:10:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:52600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727804AbeITAKQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 20:10:16 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6171C2150E;
        Wed, 19 Sep 2018 18:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537381865;
        bh=9Z7OU8IH2N1n/1Tj502z0FM/MVZSjzRzEZxx7GrfNpk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QZ59Vvnyb6ybhdtpIdx4y/MWiZ7wXg4OCK5ko3vIbxdHwMJpky2H++GogioXecXbZ
         6NpBf2b5Obc2Kj5Wq5jh4d8+oquxdcSXE5w14B1kwaOlT5RNgRcCmJgxFPt5JyJDPj
         ldoClKBt1z245ZCbkj6TscvXNxoj0HVD0Fz9Y6DU=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 28809140260; Wed, 19 Sep 2018 15:31:03 -0300 (-03)
Date:   Wed, 19 Sep 2018 15:31:03 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     jolsa@kernel.org, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org, kim.phillips@arm.com,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v5 9/9] perf, tools, script: Support total cycles count
Message-ID: <20180919183103.GI31812@kernel.org>
References: <20180918123214.26728-1-andi@firstfloor.org>
 <20180918123214.26728-10-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180918123214.26728-10-andi@firstfloor.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Sep 18, 2018 at 05:32:14AM -0700, Andi Kleen escreveu:
> From: Andi Kleen <ak@linux.intel.com>
> 
> For perf script brstackinsn also print a running cycles count.
> This makes it easier to calculate cycle deltas for code sections
> measured with LBRs.
> 
> % perf record -b -a sleep 1
> % perf script -F +brstackinsn
> ...
>         _dl_sysdep_start+330:
>         00007eff9f20583a        insn: 75 c4                     # PRED 24 cycles [24]
>         00007eff9f205800        insn: 48 83 e8 03
>         00007eff9f205804        insn: 48 83 f8 1e
>         00007eff9f205808        insn: 77 26
>         00007eff9f20580a        insn: 48 63 04 81
>         00007eff9f20580e        insn: 48 01 c8
>         00007eff9f205811        insn: ff e0                     # MISPRED 31 cycles [7] 0.71 IPC
>         00007eff9f2059c0        insn: 44 8b 62 08
>         00007eff9f2059c4        insn: e9 67 fe ff ff            # PRED 55 cycles [24] 0.04 IPC
>         00007eff9f205830        insn: 48 83 c2 10
>         00007eff9f205834        insn: 48 8b 02
>         00007eff9f205837        insn: 48 85 c0
>         00007eff9f20583a        insn: 75 c4                     # PRED 68 cycles [13] 0.23 IPC
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> ---
>  tools/perf/builtin-script.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 3b73c3226141..84895c861b84 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -913,7 +913,7 @@ static int grab_bb(u8 *buffer, u64 start, u64 end,
>  
>  static int ip__fprintf_jump(uint64_t ip, struct branch_entry *en,
>  			    struct perf_insn *x, u8 *inbuf, int len,
> -			    int insn, FILE *fp)
> +			    int insn, FILE *fp, int *total_cycles)
>  {
>  	int printed = fprintf(fp, "\t%016" PRIx64 "\t%-30s\t#%s%s%s%s", ip,
>  			      dump_insn(x, ip, inbuf, len, NULL),
> @@ -922,7 +922,8 @@ static int ip__fprintf_jump(uint64_t ip, struct branch_entry *en,
>  			      en->flags.in_tx ? " INTX" : "",
>  			      en->flags.abort ? " ABORT" : "");
>  	if (en->flags.cycles) {
> -		printed += fprintf(fp, " %d cycles", en->flags.cycles);
> +		*total_cycles += en->flags.cycles;
> +		printed += fprintf(fp, " %d cycles [%d]", *total_cycles, en->flags.cycles);
>  		if (insn)
>  			printed += fprintf(fp, " %.2f IPC", (float)insn / en->flags.cycles);
>  	}
> @@ -979,6 +980,7 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
>  	u8 buffer[MAXBB];
>  	unsigned off;
>  	struct symbol *lastsym = NULL;
> +	int total_cycles = 0;
>  
>  	if (!(br && br->nr))
>  		return 0;
> @@ -999,7 +1001,7 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
>  		printed += ip__fprintf_sym(br->entries[nr - 1].from, thread,
>  					   x.cpumode, x.cpu, &lastsym, attr, fp);
>  		printed += ip__fprintf_jump(br->entries[nr - 1].from, &br->entries[nr - 1],
> -					    &x, buffer, len, 0, fp);
> +					    &x, buffer, len, 0, fp, &total_cycles);
>  	}
>  
>  	/* Print all blocks */
> @@ -1027,7 +1029,9 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
>  
>  			printed += ip__fprintf_sym(ip, thread, x.cpumode, x.cpu, &lastsym, attr, fp);
>  			if (ip == end) {
> -				printed += ip__fprintf_jump(ip, &br->entries[i], &x, buffer + off, len - off, insn, fp);
> +				printed += ip__fprintf_jump(ip, &br->entries[i],
> +						&x, buffer + off, len - off,
> +						insn, fp, &total_cycles);

Please don't reflow these things like that, just align the next line
with the new thing, parses quicker when reviewing.

- Arnaldo



>  				break;
>  			} else {
>  				printed += fprintf(fp, "\t%016" PRIx64 "\t%s\n", ip,
> -- 
> 2.17.1
