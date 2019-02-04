Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3911DC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 036622073D
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729637AbfBDUrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 15:47:17 -0500
Received: from gofer.mess.org ([88.97.38.141]:53053 "EHLO gofer.mess.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725947AbfBDUrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 15:47:17 -0500
Received: by gofer.mess.org (Postfix, from userid 1000)
        id DB7DA60219; Mon,  4 Feb 2019 20:47:14 +0000 (GMT)
Date:   Mon, 4 Feb 2019 20:47:14 +0000
From:   Sean Young <sean@mess.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: ir: fix =?utf-8?Q?w?=
 =?utf-8?B?YXJuaW5nOiDigJglc+KAmQ==?= directive output may be truncated
Message-ID: <20190204204714.pcfoacny7rypgfww@gofer.mess.org>
References: <20190131194312.19060-1-shuah@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190131194312.19060-1-shuah@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 12:43:12PM -0700, Shuah Khan wrote:
> Fix the following warning by sizing the buffer to max. of sysfs
> path max. size + d_name max. size.
> 
> gcc -Wall -O2 -I../../../include/uapi ir_loopback.c  -o ../tools/testing/selftests/ir/ir_loopback
> ir_loopback.c: In function ‘lirc_open’:
> ir_loopback.c:71:37: warning: ‘%s’ directive output may be truncated writing up to 255 bytes into a region of size 95 [-Wformat-truncation=]
>     snprintf(buf, sizeof(buf), "/dev/%s", dent->d_name);
>                                      ^~
> In file included from /usr/include/stdio.h:862:0,
>                  from ir_loopback.c:14:
> /usr/include/x86_64-linux-gnu/bits/stdio2.h:64:10: note: ‘__builtin___snprintf_chk’ output between 6 and 261 bytes into a destination of size 100
>    return __builtin___snprintf_chk (__s, __n, __USE_FORTIFY_LEVEL - 1,
>           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>         __bos (__s), __fmt, __va_arg_pack ());
>         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Signed-off-by: Shuah Khan <shuah@kernel.org>

Thank you for catching and fixing these. For all three patches:

Acked-by: Sean Young <sean@mess.org>

> ---
>  tools/testing/selftests/ir/ir_loopback.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/ir/ir_loopback.c b/tools/testing/selftests/ir/ir_loopback.c
> index 858c19caf224..8cdf1b89ac9c 100644
> --- a/tools/testing/selftests/ir/ir_loopback.c
> +++ b/tools/testing/selftests/ir/ir_loopback.c
> @@ -27,6 +27,8 @@
>  
>  #define TEST_SCANCODES	10
>  #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
> +#define SYSFS_PATH_MAX 256
> +#define DNAME_PATH_MAX 256
>  
>  static const struct {
>  	enum rc_proto proto;
> @@ -56,7 +58,7 @@ static const struct {
>  int lirc_open(const char *rc)
>  {
>  	struct dirent *dent;
> -	char buf[100];
> +	char buf[SYSFS_PATH_MAX + DNAME_PATH_MAX];
>  	DIR *d;
>  	int fd;
>  
> -- 
> 2.17.1
