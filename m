Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752916AbeCQA4d (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 20:56:33 -0400
Received: from mail-ot0-f174.google.com ([74.125.82.174]:34105 "EHLO
        mail-ot0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751887AbeCQA4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 20:56:32 -0400
X-Google-Smtp-Source: AG47ELvtS9yx2tOUTrDjXoZBDdbjCIzcvwP5Y+t9B4180ukGxyu5GecUPHlkwflQYhsmV1nEkCuhTw==
Subject: Re: New -Werror=restrict error with incremental gcc
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <34478c69-e238-90db-bf1e-9622a060c778@redhat.com>
 <20180315143012.GA2221@redhat.com>
 <53714ddf-1b2d-295b-e364-3330f1d9c48c@redhat.com>
 <20180316031154.juk2uncs7baffctp@treble>
From: Laura Abbott <labbott@redhat.com>
Message-ID: <b5d9ea0f-3a3e-ec87-df76-10be4bd72b90@redhat.com>
Date: Fri, 16 Mar 2018 17:56:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180316031154.juk2uncs7baffctp@treble>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/15/2018 08:11 PM, Josh Poimboeuf wrote:
> On Thu, Mar 15, 2018 at 08:06:26AM -0700, Laura Abbott wrote:
>> This only showed up with the very latest rawhide snapshot, .17 worked and
>> .18 started failing. I had to download .18 manually to test locally
>> https://koji.fedoraproject.org/koji/packageinfo?packageID=40
> 
> I also see the error with the latest gcc master branch.  The code is
> harmless, but maybe the warning is useful in other places, so here's one
> way to fix it.
> 

Works for me, you can add

Tested-by: Laura Abbott <labbott@redhat.com>

> ----
> 
> From: Josh Poimboeuf <jpoimboe@redhat.com>
> Subject: [PATCH] objtool, perf: Fix GCC 8 -Wrestrict error
> 
> Starting with recent GCC 8 builds, objtool and perf fail to build with
> the following error:
> 
>    ../str_error_r.c: In function ‘str_error_r’:
>    ../str_error_r.c:25:3: error: passing argument 1 to restrict-qualified parameter aliases with argument 5 [-Werror=restrict]
>       snprintf(buf, buflen, "INTERNAL ERROR: strerror_r(%d, %p, %zd)=%d", errnum, buf, buflen, err);
> 
> The code seems harmless, but there's probably no benefit in printing the
> 'buf' pointer in this situation anyway, so just remove it to make GCC
> happy.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> ---
>   tools/lib/str_error_r.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/lib/str_error_r.c b/tools/lib/str_error_r.c
> index d6d65537b0d9..6aad8308a0ac 100644
> --- a/tools/lib/str_error_r.c
> +++ b/tools/lib/str_error_r.c
> @@ -22,6 +22,6 @@ char *str_error_r(int errnum, char *buf, size_t buflen)
>   {
>   	int err = strerror_r(errnum, buf, buflen);
>   	if (err)
> -		snprintf(buf, buflen, "INTERNAL ERROR: strerror_r(%d, %p, %zd)=%d", errnum, buf, buflen, err);
> +		snprintf(buf, buflen, "INTERNAL ERROR: strerror_r(%d, [buf], %zd)=%d", errnum, buflen, err);
>   	return buf;
>   }
> 
