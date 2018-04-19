Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752801AbeDSEru (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 00:47:50 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:45575 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750937AbeDSErs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 00:47:48 -0400
X-Google-Smtp-Source: AIpwx4/53Dcf4FyBED2PEhzRhsibc4hu3BvtGFtNf4IELmaO9dNuOU2CFchBRaq3zBqNpIBJvAvrIQ==
Date: Wed, 18 Apr 2018 21:47:45 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Leo Yan <leo.yan@linaro.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 4/5] samples/bpf: Refine printing symbol for
 sampleip
Message-ID: <20180419044743.srjhqegvir5exub5@ast-mbp>
References: <1524101646-6544-1-git-send-email-leo.yan@linaro.org>
 <1524101646-6544-5-git-send-email-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524101646-6544-5-git-send-email-leo.yan@linaro.org>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 09:34:05AM +0800, Leo Yan wrote:
> The code defines macro 'PAGE_OFFSET' and uses it to decide if the
> address is in kernel space or not.  But different architecture has
> different 'PAGE_OFFSET' so this program cannot be used for all
> platforms.
> 
> This commit changes to check returned pointer from ksym_search() to
> judge if the address falls into kernel space or not, and removes
> macro 'PAGE_OFFSET' as it isn't used anymore.  As result, this program
> has no architecture dependency.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  samples/bpf/sampleip_user.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/samples/bpf/sampleip_user.c b/samples/bpf/sampleip_user.c
> index 4ed690b..0eea1b3 100644
> --- a/samples/bpf/sampleip_user.c
> +++ b/samples/bpf/sampleip_user.c
> @@ -26,7 +26,6 @@
>  #define DEFAULT_FREQ	99
>  #define DEFAULT_SECS	5
>  #define MAX_IPS		8192
> -#define PAGE_OFFSET	0xffff880000000000
>  
>  static int nr_cpus;
>  
> @@ -107,14 +106,13 @@ static void print_ip_map(int fd)
>  	/* sort and print */
>  	qsort(counts, max, sizeof(struct ipcount), count_cmp);
>  	for (i = 0; i < max; i++) {
> -		if (counts[i].ip > PAGE_OFFSET) {
> -			sym = ksym_search(counts[i].ip);

yes. it is x64 specific, since it's a sample code,
but simply removing it is not a fix.
It makes this sampleip code behaving incorrectly.
To do such 'cleanup of ksym' please refactor it in the true generic way,
so these ksym* helpers can work on all archs and put this new
functionality into selftests.
If you can convert these examples into proper self-checking tests
that run out of selftests that would be awesome.
Thanks!
