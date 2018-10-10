Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 969E7C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 22:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CBDB20659
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 22:45:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CBDB20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbeJKGJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 02:09:59 -0400
Received: from mga12.intel.com ([192.55.52.136]:65369 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725968AbeJKGJ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 02:09:59 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Oct 2018 15:45:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,366,1534834800"; 
   d="scan'208";a="98124946"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga001.fm.intel.com with ESMTP; 10 Oct 2018 15:45:44 -0700
Date:   Wed, 10 Oct 2018 16:42:42 -0600
From:   Keith Busch <keith.busch@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 4/6] tools/gup_benchmark: Allow user specified file
Message-ID: <20181010224242.GC11034@localhost.localdomain>
References: <20181010195605.10689-1-keith.busch@intel.com>
 <20181010195605.10689-4-keith.busch@intel.com>
 <20181010153101.4f5dcf6dcc01e71934eeb1ba@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181010153101.4f5dcf6dcc01e71934eeb1ba@linux-foundation.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 03:31:01PM -0700, Andrew Morton wrote:
> On Wed, 10 Oct 2018 13:56:03 -0600 Keith Busch <keith.busch@intel.com> wrote:
> > +	filed = open(file, O_RDWR|O_CREAT);
> > +	if (filed < 0)
> > +		perror("open"), exit(filed);
> 
> Ick.  Like this, please:

Yeah, I agree. I just copied the style this file had been using in other
error cases, but I still find it less readable than your recommendation. 
 
> --- a/tools/testing/selftests/vm/gup_benchmark.c~tools-gup_benchmark-allow-user-specified-file-fix
> +++ a/tools/testing/selftests/vm/gup_benchmark.c
> @@ -71,8 +71,10 @@ int main(int argc, char **argv)
>  	}
>  
>  	filed = open(file, O_RDWR|O_CREAT);
> -	if (filed < 0)
> -		perror("open"), exit(filed);
> +	if (filed < 0) {
> +		perror("open");
> +		exit(filed);
> +	}
>  
>  	gup.nr_pages_per_call = nr_pages;
>  	gup.flags = write;
> 
