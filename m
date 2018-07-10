Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972B9C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 22:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C60C2098B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 22:58:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C60C2098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732298AbeGJW7p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 18:59:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43856 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732264AbeGJW7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 18:59:45 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8A31481663EE;
        Tue, 10 Jul 2018 22:58:27 +0000 (UTC)
Received: from krava (ovpn-204-33.brq.redhat.com [10.40.204.33])
        by smtp.corp.redhat.com (Postfix) with SMTP id C3D2B1C4C3;
        Tue, 10 Jul 2018 22:58:25 +0000 (UTC)
Date:   Wed, 11 Jul 2018 00:58:24 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     William Cohen <wcohen@redhat.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org
Subject: Re: [PATCH] Check jvmti_agent snprintf return value to avoid build
 failures with GCC-8.1.1
Message-ID: <20180710225824.GA11928@krava>
References: <20180710182716.21801-1-wcohen@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710182716.21801-1-wcohen@redhat.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Tue, 10 Jul 2018 22:58:27 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Tue, 10 Jul 2018 22:58:27 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 02:27:16PM -0400, William Cohen wrote:
> Newer versions of GCC perform static analysis to determine whether
> string truncation is possible with functions such as snprintf and
> provide a warning if truncation could occur.  The make for
> jvmti_agent.c uses the compiler option that treats any compiler
> warnings as compiler errors.  For GCC-8.1.1 in Fedora 28 this causes
> the build to fail.  The return value of the snprint is now checked to
> ensure snprintf produced a NULL-terminated string.  If the string for
> the path is invalid, the code does attempt to use the string.

hi,
I posted fix for this recently:
  https://lore.kernel.org/lkml/20180702134202.17745-1-jolsa@kernel.org/

it also covers the perf_regs.c, which was failing with gcc8 for me

should be pulled in soon

thanks,
jirka

> 
> Signed-off-by: William Cohen <wcohen@redhat.com>
> ---
>  tools/perf/jvmti/jvmti_agent.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/jvmti/jvmti_agent.c b/tools/perf/jvmti/jvmti_agent.c
> index 0c6d1002b524..30f14eafe4b3 100644
> --- a/tools/perf/jvmti/jvmti_agent.c
> +++ b/tools/perf/jvmti/jvmti_agent.c
> @@ -227,7 +227,7 @@ void *jvmti_open(void)
>  {
>  	char dump_path[PATH_MAX];
>  	struct jitheader header;
> -	int fd;
> +	int retlen, fd;
>  	FILE *fp;
>  
>  	init_arch_timestamp();
> @@ -249,7 +249,10 @@ void *jvmti_open(void)
>  	/*
>  	 * jitdump file name
>  	 */
> -	snprintf(dump_path, PATH_MAX, "%s/jit-%i.dump", jit_path, getpid());
> +	retlen = snprintf(dump_path, PATH_MAX, "%s/jit-%i.dump",
> +			  jit_path, getpid());
> +	if (retlen <= 0 || ((int) sizeof(dump_path)) <= retlen)
> +		return NULL;
>  
>  	fd = open(dump_path, O_CREAT|O_TRUNC|O_RDWR, 0666);
>  	if (fd == -1)
> -- 
> 2.17.1
> 
