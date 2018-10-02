Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A88A2C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 11:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A3932082A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 11:03:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A3932082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbeJBRqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 13:46:30 -0400
Received: from mga06.intel.com ([134.134.136.31]:14447 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727428AbeJBRqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 13:46:30 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Oct 2018 04:03:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,331,1534834800"; 
   d="scan'208";a="75489777"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 02 Oct 2018 04:03:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id E7F581F5; Tue,  2 Oct 2018 14:03:38 +0300 (EEST)
Date:   Tue, 2 Oct 2018 14:03:38 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Keith Busch <keith.busch@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCHv3 4/6] tools/gup_benchmark: Allow user specified file
Message-ID: <20181002110338.fw7d4jv5e5a6yd4v@black.fi.intel.com>
References: <20180921223956.3485-1-keith.busch@intel.com>
 <20180921223956.3485-5-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180921223956.3485-5-keith.busch@intel.com>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 10:39:54PM +0000, Keith Busch wrote:
> The gup benchmark by default maps anonymous memory. This patch allows a
> user to specify a file to map, providing a means to test various
> file backings, like device and filesystem DAX.
> 
> Cc: Kirill Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
>  tools/testing/selftests/vm/gup_benchmark.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/vm/gup_benchmark.c b/tools/testing/selftests/vm/gup_benchmark.c
> index b2082df8beb4..f2c99e2436f8 100644
> --- a/tools/testing/selftests/vm/gup_benchmark.c
> +++ b/tools/testing/selftests/vm/gup_benchmark.c
> @@ -33,9 +33,12 @@ int main(int argc, char **argv)
>  	unsigned long size = 128 * MB;
>  	int i, fd, opt, nr_pages = 1, thp = -1, repeats = 1, write = 0;
>  	int cmd = GUP_FAST_BENCHMARK;
> +	int file_map = -1;
> +	int flags = MAP_ANONYMOUS | MAP_PRIVATE;
> +	char *file = NULL;
>  	char *p;
>  
> -	while ((opt = getopt(argc, argv, "m:r:n:tTLU")) != -1) {
> +	while ((opt = getopt(argc, argv, "m:r:n:f:tTLU")) != -1) {
>  		switch (opt) {
>  		case 'm':
>  			size = atoi(optarg) * MB;
> @@ -61,11 +64,22 @@ int main(int argc, char **argv)
>  		case 'w':
>  			write = 1;
>  			break;
> +		case 'f':
> +			file = optarg;
> +			flags &= ~(MAP_PRIVATE | MAP_ANONYMOUS);
> +			flags |= MAP_SHARED;

Why do we want to assume shared mapping if a file is passed? Private-file
mapping is also valid target for the benchmark.

Maybe a separate option for shared? It would keep options more independent.

BTW, we can make a default file /dev/zero and don't have MAP_ANONYMOUS in
the flags: private mapping of /dev/zero would produce anonymous mapping.
No need in masking out MAP_ANONYMOUS on -f and no branch on 'if (file)'
below.

> +			break;
>  		default:
>  			return -1;
>  		}
>  	}
>  
> +	if (file) {
> +		file_map = open(file, O_RDWR|O_CREAT);
> +		if (file_map < 0)
> +			perror("open"), exit(file_map);
> +	}
> +
>  	gup.nr_pages_per_call = nr_pages;
>  	gup.flags = write;
>  
> @@ -73,8 +87,7 @@ int main(int argc, char **argv)
>  	if (fd == -1)
>  		perror("open"), exit(1);
>  
> -	p = mmap(NULL, size, PROT_READ | PROT_WRITE,
> -			MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
> +	p = mmap(NULL, size, PROT_READ | PROT_WRITE, flags, file_map, 0);
>  	if (p == MAP_FAILED)
>  		perror("mmap"), exit(1);
>  	gup.addr = (unsigned long)p;
> -- 
> 2.14.4
> 

-- 
 Kirill A. Shutemov
