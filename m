Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932438AbeCSHSY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 03:18:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33376 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932134AbeCSHSX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 03:18:23 -0400
Date: Mon, 19 Mar 2018 08:18:21 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] tools: Fix str_error_r() Werror=restrict build
Message-ID: <20180319071821.GA9988@krava>
References: <20180319055504.757-1-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180319055504.757-1-sergey.senozhatsky@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 19, 2018 at 02:55:04PM +0900, Sergey Senozhatsky wrote:
> Commit c8b5f2c96d1bf6c ("tools: Introduce str_error_r()") added
> an str_error_r() wrapper which makes gcc8 unhappy due to
> restrict-qualified parameter aliasing violation:
> 
> ../lib/str_error_r.c: In function ‘str_error_r’:
> ../lib/str_error_r.c:25:3: error: passing argument 1 to restrict-qualified parameter aliases with argument 5 [-Werror=restrict]
>    snprintf(buf, buflen, "INTERNAL ERROR: strerror_r(%d, %p, %zd)=%d", errnum, buf, buflen, err);
>    ^~~~~~~~
> cc1: all warnings being treated as errors
> 
> Workaround that aliasing error by creating an additional stack
> variable which holds the buf pointer value we passed to strerror_r().
> 
> Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

Josh posted another way to fix it:
https://marc.info/?l=linux-kernel&m=152116992412107&w=2

your patch keeps the same output, I dont mind either way ;-)

jirka


> ---
>  tools/lib/str_error_r.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/lib/str_error_r.c b/tools/lib/str_error_r.c
> index d6d65537b0d9..11c3425f272b 100644
> --- a/tools/lib/str_error_r.c
> +++ b/tools/lib/str_error_r.c
> @@ -21,7 +21,12 @@
>  char *str_error_r(int errnum, char *buf, size_t buflen)
>  {
>  	int err = strerror_r(errnum, buf, buflen);
> -	if (err)
> -		snprintf(buf, buflen, "INTERNAL ERROR: strerror_r(%d, %p, %zd)=%d", errnum, buf, buflen, err);
> +	if (err) {
> +		char *err_buf = buf;
> +
> +		snprintf(err_buf, buflen,
> +			 "INTERNAL ERROR: strerror_r(%d, %p, %zd)=%d",
> +			 errnum, buf, buflen, err);
> +	}
>  	return buf;
>  }
> -- 
> 2.16.2
> 
