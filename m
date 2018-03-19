Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932453AbeCSHpD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 03:45:03 -0400
Received: from mail-pl0-f54.google.com ([209.85.160.54]:39620 "EHLO
        mail-pl0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751668AbeCSHpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 03:45:02 -0400
X-Google-Smtp-Source: AG47ELvLzeEGM1G33XslYzkynWvJyU3twm7zqIjIH2W1cpYsKSc5DM42uXYt/y4Nd+usW1ql2LMX3g==
Date: Mon, 19 Mar 2018 16:44:56 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Jiri Olsa <jolsa@redhat.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] tools: Fix str_error_r() Werror=restrict build
Message-ID: <20180319074456.GA3315@jagdpanzerIV>
References: <20180319055504.757-1-sergey.senozhatsky@gmail.com>
 <20180319071821.GA9988@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180319071821.GA9988@krava>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (03/19/18 08:18), Jiri Olsa wrote:
> On Mon, Mar 19, 2018 at 02:55:04PM +0900, Sergey Senozhatsky wrote:
> > Commit c8b5f2c96d1bf6c ("tools: Introduce str_error_r()") added
> > an str_error_r() wrapper which makes gcc8 unhappy due to
> > restrict-qualified parameter aliasing violation:
> > 
> > ../lib/str_error_r.c: In function ‘str_error_r’:
> > ../lib/str_error_r.c:25:3: error: passing argument 1 to restrict-qualified parameter aliases with argument 5 [-Werror=restrict]
> >    snprintf(buf, buflen, "INTERNAL ERROR: strerror_r(%d, %p, %zd)=%d", errnum, buf, buflen, err);
> >    ^~~~~~~~
> > cc1: all warnings being treated as errors
> > 
> > Workaround that aliasing error by creating an additional stack
> > variable which holds the buf pointer value we passed to strerror_r().
> > 
> > Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> 
> Josh posted another way to fix it:
> https://marc.info/?l=linux-kernel&m=152116992412107&w=2

Oh, thanks for the pointers.

> your patch keeps the same output, I dont mind either way ;-)

Thanks. No strong opinion, either way is OK :) Can't tell for sure if
snprintf(... "%p", buf) is significantly better than snprintf(... "[buf]"),
but Arnaldo wanted to have the first version.

	-ss
