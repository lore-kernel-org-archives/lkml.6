Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 322E1C67863
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 01:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0335C20C0E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 01:27:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0335C20C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbeJSJbm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 05:31:42 -0400
Received: from mga12.intel.com ([192.55.52.136]:63668 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726245AbeJSJbl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 05:31:41 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Oct 2018 18:27:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,397,1534834800"; 
   d="scan'208";a="82646210"
Received: from ssarabia-mobl7.amr.corp.intel.com ([10.7.189.87])
  by orsmga008.jf.intel.com with ESMTP; 18 Oct 2018 18:27:54 -0700
Date:   Thu, 18 Oct 2018 18:27:52 -0700
From:   Solio Sarabia <solio.sarabia@intel.com>
To:     Len Brown <lenb@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        shiny.sebastian@intel.com
Subject: Re: turbostat-17.06.23 floating point exception
Message-ID: <20181019012751.GA11600@ssarabia-MOBL7.amr.corp.intel.com>
References: <20181012182630.GA13352@ssarabia-MOBL7.amr.corp.intel.com>
 <20181012222743.GA14100@ssarabia-MOBL7.amr.corp.intel.com>
 <CAJvTdKmQUomRnZnPD3O0-Wq0Tp+9PKewBEqQnn4OUg=0Fpzh5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJvTdKmQUomRnZnPD3O0-Wq0Tp+9PKewBEqQnn4OUg=0Fpzh5w@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 07:03:41PM -0400, Len Brown wrote:
> > Why would the cpu topology report 0 cpus?  I added a debug entry to
> > cpu_usage_stat and /proc/stat showed it as an extra column.  Then
> > fscanf parsing in for_all_cpus() failed, causing the SIGFPE.
> >
> > This is not an issue. Thanks.
> 
> Yes, it is true that turbostat doesn't check for systems with 0 cpus.
> I'm curious how you provoked the kernel to claim that.  If it is
> something others might do, we can have check for it and gracefully
> exit.

source/tools/power/x86/turbostat/turbostat.c
int for_all_proc_cpus(int (func)(int))
{
    retval = fscanf(fp, "cpu %*d %*d %*d %*d %*d %*d %*d %*d %*d %*d\n");
    ^
    This fails due to an extra debug entry in /proc/stat
    (total of 11 columns).  I was measuring time in a hot
    function and decided to add this time in an extra
    cpu_usage_stat. This was an experiment though.

Thanks,
-S.
