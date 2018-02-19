Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752705AbeBSMNj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 07:13:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:57908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752579AbeBSMNi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 07:13:38 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 777D921104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Mon, 19 Feb 2018 09:13:35 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com
Subject: Re: [PATCH] perf s390: Fix reading cpuid model information
Message-ID: <20180219121335.GB14978@kernel.org>
References: <20180219102444.96900-1-tmricht@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180219102444.96900-1-tmricht@linux.vnet.ibm.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Feb 19, 2018 at 11:24:44AM +0100, Thomas Richter escreveu:
> Commit feb3d2d955c8 (perf record: Provide detailed information
> on s390 CPU") fixed a  build error on Ubuntu. However the
> fix uses the wrong size to print the model information.

Thanks for the review and quick fix, I'm sorry for letting that slip :-\

sizeof(type) is smaller tha sizeof(model), so at least this would just
limit the formatted model variable to be at most sizeof(type) in lenght.

Anyway, applying the fix :-)

- Arnaldo
 
> Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
> ---
>  tools/perf/arch/s390/util/header.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/arch/s390/util/header.c b/tools/perf/arch/s390/util/header.c
> index 231294b80dc4..a4c30f1c70be 100644
> --- a/tools/perf/arch/s390/util/header.c
> +++ b/tools/perf/arch/s390/util/header.c
> @@ -81,7 +81,7 @@ int get_cpuid(char *buffer, size_t sz)
>  			line2 = line + strlen(SYSINFO_MODEL);
>  
>  			while ((cp = strtok_r(line2, "\n ", &line2))) {
> -				mdsize += scnprintf(model + mdsize, sizeof(type) - mdsize,
> +				mdsize += scnprintf(model + mdsize, sizeof(model) - mdsize,
>  						    "%s%s", model[0] ? "," : "", cp);
>  			}
>  			break;
> -- 
> 2.14.3
