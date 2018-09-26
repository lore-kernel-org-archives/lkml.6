Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4818AC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E87392152E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:29:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E87392152E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbeIZWnF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 18:43:05 -0400
Received: from g4t3426.houston.hpe.com ([15.241.140.75]:41590 "EHLO
        g4t3426.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727285AbeIZWnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 18:43:05 -0400
X-Greylist: delayed 162181 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 Sep 2018 18:43:05 EDT
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net [16.208.49.245])
        by g4t3426.houston.hpe.com (Postfix) with ESMTP id 40B8760;
        Wed, 26 Sep 2018 16:29:21 +0000 (UTC)
Received: from anatevka.americas.hpqcorp.net (anatevka.americas.hpqcorp.net [10.34.81.6])
        by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id A969946;
        Wed, 26 Sep 2018 16:29:20 +0000 (UTC)
Date:   Wed, 26 Sep 2018 10:29:20 -0600
From:   Jerry Hoemann <jerry.hoemann@hpe.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     erosca@de.adit-jv.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [V2 PATCH] selftests: watchdog: Add gettimeout and get|set
 pretimeout
Message-ID: <20180926162920.GB3948@anatevka.americas.hpqcorp.net>
Reply-To: Jerry.Hoemann@hpe.com
References: <1537817767-78918-1-git-send-email-jerry.hoemann@hpe.com>
 <1537817767-78918-2-git-send-email-jerry.hoemann@hpe.com>
 <16941ebb-85ca-ad4c-de7b-c26f193ca611@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16941ebb-85ca-ad4c-de7b-c26f193ca611@kernel.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 02:51:15PM -0600, Shuah Khan wrote:
> Hi Jerry,
> 
> On 09/24/2018 01:36 PM, Jerry Hoemann wrote:
> >  	{"disable",             no_argument, NULL, 'd'},
> > @@ -27,6 +27,9 @@
> >  	{"help",                no_argument, NULL, 'h'},
> >  	{"pingrate",      required_argument, NULL, 'p'},
> >  	{"timeout",       required_argument, NULL, 't'},
> > +	{"gettimeout",          no_argument, NULL, 'T'},
> > +	{"pretimeout",    required_argument, NULL, 'n'},
> > +	{"getpretimeout",       no_argument, NULL, 'N'},
> >  	{NULL,                  no_argument, NULL, 0x0}
> >  };
> >  
> > @@ -71,9 +74,13 @@ static void usage(char *progname)
> >  	printf(" -h, --help          Print the help message\n");
> >  	printf(" -p, --pingrate=P    Set ping rate to P seconds (default %d)\n", DEFAULT_PING_RATE);
> >  	printf(" -t, --timeout=T     Set timeout to T seconds\n");
> > +	printf(" -T, --gettimeout    Get the timeout\n");
> > +	printf(" -n, --pretimeout=T  Set the pretimeout to T seconds\n");
> > +	printf(" -N, --getpretimeout Get the pretimeout\n");
> >  	printf("\n");
> >  	printf("Parameters are parsed left-to-right in real-time.\n");
> >  	printf("Example: %s -d -t 10 -p 5 -e\n", progname);
> > +	printf("Example: %s -t 12 -T -n 7 -N\n", progname);
> 
> Would this work the way you want it though, since -N now is oneshot?
> Should this be just "printf("Example: %s -t 12 -T -n 7\n", progname); ??


Example shows how to set/query the timers to make sure value set was what
was intended.

Note: "oneshot" is a bit of a misnomer as it causes clean exit before
going into the keep alive loop, but one can still specify multiple
options.


> 
> The rest looks good to me.
> 
> >  }
> >  
> >  int main(int argc, char *argv[])
> > @@ -135,6 +142,30 @@ int main(int argc, char *argv[])
> >  			else
> >  				printf("WDIOC_SETTIMEOUT errno '%s'\n", strerror(errno));
> >  			break;
> > +		case 'T':
> > +			oneshot = 1;
> > +			ret = ioctl(fd, WDIOC_GETTIMEOUT, &flags);
> > +			if (!ret)
> > +				printf("WDIOC_GETTIMEOUT returns %u seconds.\n", flags);
> > +			else
> > +				printf("WDIOC_GETTIMEOUT errno '%s'\n", strerror(errno));
> > +			break;
> > +		case 'n':
> > +			flags = strtoul(optarg, NULL, 0);
> > +			ret = ioctl(fd, WDIOC_SETPRETIMEOUT, &flags);
> > +			if (!ret)
> > +				printf("Watchdog pretimeout set to %u seconds.\n", flags);
> > +			else
> > +				printf("WDIOC_SETPRETIMEOUT errno '%s'\n", strerror(errno));
> > +			break;
> > +		case 'N':
> > +			oneshot = 1;
> > +			ret = ioctl(fd, WDIOC_GETPRETIMEOUT, &flags);
> > +			if (!ret)
> > +				printf("WDIOC_GETPRETIMEOUT returns %u seconds.\n", flags);
> > +			else
> > +				printf("WDIOC_GETPRETIMEOUT errno '%s'\n", strerror(errno));
> > +			break;
> >  		default:
> >  			usage(argv[0]);
> >  			goto end;
> > 
> 
> thanks,
> -- Shuah

-- 

-----------------------------------------------------------------------------
Jerry Hoemann                  Software Engineer   Hewlett Packard Enterprise
-----------------------------------------------------------------------------
