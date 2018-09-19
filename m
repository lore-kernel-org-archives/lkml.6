Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 398A5ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 18:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB90C208A3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 18:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XKYyLPWR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB90C208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733303AbeITA1s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 20:27:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:55664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727676AbeITA1r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 20:27:47 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A126C208A3;
        Wed, 19 Sep 2018 18:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537382913;
        bh=+80uM7LJ2HNpumCXidrReroiDP9WddIM/1HttTOReWY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XKYyLPWRxvR65/sQeTEq0r6k/3AsKo5z9CpbPih0ZMMkKGGhYLa7FO1hGhxkhgVjj
         aUOwoFbnqT8dV0hZ9bq2OtEB1G23Q6bWusQ2fN3Nfbk5IyOGrduqkFZ1RRAtSopPnm
         vJXvvrAW8dA8Eeg0vzya9xFORk4GS3EGOqGNXINw=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id CCDC1140260; Wed, 19 Sep 2018 15:48:31 -0300 (-03)
Date:   Wed, 19 Sep 2018 15:48:31 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] perf script: Enhance sample flags for trace begin /
 end
Message-ID: <20180919184831.GK31812@kernel.org>
References: <20180919112338.20347-1-adrian.hunter@intel.com>
 <20180919112338.20347-2-adrian.hunter@intel.com>
 <20180919184556.GJ31812@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180919184556.GJ31812@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Sep 19, 2018 at 03:45:56PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Sep 19, 2018 at 02:23:33PM +0300, Adrian Hunter escreveu:
> > Allow for different combinations of sample flags with "trace begin" or
> > "trace end".
> 
> Please describe how you would use this with some command and its output.

This is another case where we have to apply these patches to then, at
the last patch see the result of it, isn't it possible to help people
not deep into intel-pt to figure, patch by patch, how these patches help
in achieving what you want at the last patch?

- Arnaldo
 
> - Arnaldo
>  
> > Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> > ---
> >  tools/perf/builtin-script.c | 36 +++++++++++++++++++++++++++---------
> >  1 file changed, 27 insertions(+), 9 deletions(-)
> > 
> > diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> > index 6176bae177c2..4982380ba96d 100644
> > --- a/tools/perf/builtin-script.c
> > +++ b/tools/perf/builtin-script.c
> > @@ -1255,6 +1255,18 @@ static struct {
> >  	{0, NULL}
> >  };
> >  
> > +static const char *sample_flags_to_name(u32 flags)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; sample_flags[i].name ; i++) {
> > +		if (sample_flags[i].flags == flags)
> > +			return sample_flags[i].name;
> > +	}
> > +
> > +	return NULL;
> > +}
> > +
> >  static int perf_sample__fprintf_flags(u32 flags, FILE *fp)
> >  {
> >  	const char *chars = PERF_IP_FLAG_CHARS;
> > @@ -1264,11 +1276,20 @@ static int perf_sample__fprintf_flags(u32 flags, FILE *fp)
> >  	char str[33];
> >  	int i, pos = 0;
> >  
> > -	for (i = 0; sample_flags[i].name ; i++) {
> > -		if (sample_flags[i].flags == (flags & ~PERF_IP_FLAG_IN_TX)) {
> > -			name = sample_flags[i].name;
> > -			break;
> > -		}
> > +	name = sample_flags_to_name(flags & ~PERF_IP_FLAG_IN_TX);
> > +	if (name)
> > +		return fprintf(fp, "  %-15s%4s ", name, in_tx ? "(x)" : "");
> > +
> > +	if (flags & PERF_IP_FLAG_TRACE_BEGIN) {
> > +		name = sample_flags_to_name(flags & ~(PERF_IP_FLAG_IN_TX | PERF_IP_FLAG_TRACE_BEGIN));
> > +		if (name)
> > +			return fprintf(fp, "  tr strt %-7s%4s ", name, in_tx ? "(x)" : "");
> > +	}
> > +
> > +	if (flags & PERF_IP_FLAG_TRACE_END) {
> > +		name = sample_flags_to_name(flags & ~(PERF_IP_FLAG_IN_TX | PERF_IP_FLAG_TRACE_END));
> > +		if (name)
> > +			return fprintf(fp, "  tr end  %-7s%4s ", name, in_tx ? "(x)" : "");
> >  	}
> >  
> >  	for (i = 0; i < n; i++, flags >>= 1) {
> > @@ -1281,10 +1302,7 @@ static int perf_sample__fprintf_flags(u32 flags, FILE *fp)
> >  	}
> >  	str[pos] = 0;
> >  
> > -	if (name)
> > -		return fprintf(fp, "  %-7s%4s ", name, in_tx ? "(x)" : "");
> > -
> > -	return fprintf(fp, "  %-11s ", str);
> > +	return fprintf(fp, "  %-19s ", str);
> >  }
> >  
> >  struct printer_data {
> > -- 
> > 2.17.1
