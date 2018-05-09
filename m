Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965617AbeEIQm5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 12:42:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:51688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965588AbeEIQm4 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 12:42:56 -0400
Date: Wed, 9 May 2018 13:42:51 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jin Yao <yao.jin@linux.intel.com>
Cc: jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH] perf annotate: Display multiple events for --stdio
Message-ID: <20180509164251.GH13491@kernel.org>
References: <1525881435-4092-1-git-send-email-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525881435-4092-1-git-send-email-yao.jin@linux.intel.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, May 09, 2018 at 11:57:15PM +0800, Jin Yao escreveu:
> When we perform following command lines:
> 
> perf record -e "{cycles,branches}" ./div
> perf annotate main --stdio
> 
> Only shows one event "cycles" and the displaying format is not correct.
> 
>  Percent         |      Source code & Disassembly of div for cycles (44550 samples)
> -----------------------------------------------------------------------------------

Please indent command output (two spaces before all lines) to avoid
scripts breaking due to mistaking lines starting with --- as the end of
the patch.

Applying.

- Arnaldo

>                  :
>                  :
>                  :
>                  :            Disassembly of section .text:
>                  :
>                  :            00000000004004b0 <main>:
>                  :            main():
>                  :
>                  :                    return i;
>                  :            }
>                  :
>                  :            int main(void)
>                  :            {
>     0.00 :   4004b0:       push   %rbx
>                  :                    int i;
>                  :                    int flag;
>                  :                    volatile double x = 1212121212, y = 121212;
>                  :
>                  :                    s_randseed = time(0);
>     0.00 :   4004b1:       xor    %edi,%edi
>                  :                    srand(s_randseed);
>     0.00 :   4004b3:       mov    $0x77359400,%ebx
>                  :
>                  :                    return i;
>                  :            }
>                  :
> 
> The issue is the value of nr_percent is hardcoded to 1.
> This patch fixes it.
> 
> With this patch, the output is:
> 
>  Percent         |      Source code & Disassembly of div for cycles (44550 samples)
> -----------------------------------------------------------------------------------
>                  :
>                  :
>                  :
>                  :            Disassembly of section .text:
>                  :
>                  :            00000000004004b0 <main>:
>                  :            main():
>                  :
>                  :                    return i;
>                  :            }
>                  :
>                  :            int main(void)
>                  :            {
>     0.00    0.00 :   4004b0:       push   %rbx
>                  :                    int i;
>                  :                    int flag;
>                  :                    volatile double x = 1212121212, y = 121212;
>                  :
>                  :                    s_randseed = time(0);
>     0.00    0.00 :   4004b1:       xor    %edi,%edi
>                  :                    srand(s_randseed);
>     0.00    0.00 :   4004b3:       mov    $0x77359400,%ebx
>                  :
>                  :                    return i;
>                  :            }
> 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>  tools/perf/util/annotate.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 536ee14..5d74a30 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -1263,6 +1263,9 @@ annotation_line__print(struct annotation_line *al, struct symbol *sym, u64 start
>  				max_percent = sample->percent;
>  		}
>  
> +		if (al->samples_nr > nr_percent)
> +			nr_percent = al->samples_nr;
> +
>  		if (max_percent < min_pcnt)
>  			return -1;
>  
> -- 
> 2.7.4
