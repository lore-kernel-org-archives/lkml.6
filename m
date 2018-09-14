Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 165EDECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 10:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F61120853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 10:37:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F61120853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbeINPvY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 11:51:24 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:52186 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbeINPvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 11:51:24 -0400
Received: from fsav102.sakura.ne.jp (fsav102.sakura.ne.jp [27.133.134.229])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w8EAbTmB084396;
        Fri, 14 Sep 2018 19:37:29 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav102.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav102.sakura.ne.jp);
 Fri, 14 Sep 2018 19:37:29 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav102.sakura.ne.jp)
Received: from [192.168.1.8] (softbank060157066051.bbtec.net [60.157.66.51])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w8EAbOko084349
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Fri, 14 Sep 2018 19:37:29 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] printk: inject caller information into the body of
 message
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        kbuild test robot <fengguang.wu@intel.com>,
        syzkaller <syzkaller@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
References: <CACT4Y+bcp4fSBBq3F86T-C4+n-YkeXUGMqpvkJ6vj6mK-TU2EA@mail.gmail.com>
 <20180620110759.GD444@jagdpanzerIV>
 <CACT4Y+aER3O2x2ApM=MVFoFXhp_T_rUeyG9CBx031qyH0voSRg@mail.gmail.com>
 <20180620130628.GA1000@tigerII.localdomain>
 <CAG_fn=XuZo5yrZzVizP26iV6eFfJtAHUs4NsDFXFyvnaJkdSQw@mail.gmail.com>
 <20180912065307.GA606@jagdpanzerIV>
 <20180912120548.4280f04a@vmware.local.home>
 <20180913071204.GA604@jagdpanzerIV>
 <20180913122625.6ieyexpcmlc5z2it@pathway.suse.cz>
 <20180913142802.GB517@tigerII.localdomain>
 <20180914065728.GA515@jagdpanzerIV>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <49d22738-17ad-410a-be0a-d27d76ba9f37@i-love.sakura.ne.jp>
Date:   Fri, 14 Sep 2018 19:37:21 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180914065728.GA515@jagdpanzerIV>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/09/14 15:57, Sergey Senozhatsky wrote:
> On (09/13/18 23:28), Sergey Senozhatsky wrote:
>> Not that I see any problems with pr_line_flush(). But can drop it, sure.
>> pr_line() is a replacement for pr_cont() and as such it's not for multi-line
>> buffering.
> 
> OK, attached.
> Let me know if anything needs to improved (including broken English).
> Will we keep in the printk tree or shall I send a formal patch to Andrew?



> @@ -20,6 +20,9 @@
>   * Annotation for a "continued" line of log printout (only done after a
>   * line that had no enclosing \n). Only to be used by core/arch code
>   * during early bootup (a continued line is not SMP-safe otherwise).
> + *
> + * Please consider pr_line()/vpr_line() functions for SMP-safe continued
> + * line printing.

I think the advantage is not limited to SMP-safeness. Reducing the frequency of
calling printk() will reduce overhead. Also, latency for netconsole will be
reduced by sending a whole line in one printk().



> +/**
> + * DEFINE_PR_LINE - define a new pr_line variable
> + * @lev:	printk() log level
> + * @name:	variable name
> + *
> + * Defines a new pr_line varialbe, which would use an implicit

s/varialbe/variable/ .

> + * stack buffer of size __PR_LINE_BUF_SZ.
> + */
> +#define DEFINE_PR_LINE(lev, name)				\
> +	char		__line_##name[__PR_LINE_BUF_SZ];	\
> +	struct pr_line	name = {				\
> +		.sb	= __SEQ_BUF_INITIALIZER(__line_##name,	\
> +					__PR_LINE_BUF_SZ),	\
> +		.level	= lev,					\
> +	}

Want a note that

  static DEFINE_PR_LINE(lev, name);

won't make "name" variable "static" ?



> +/**
> + * DEFINE_PR_LINE_BUF - define a new pr_line variable
> + * @lev:	printk() log level
> + * @name:	variable name
> + * @buf:	external buffer
> + * @sz:	external buffer size
> + *
> + * Defines a new pr_line variable, which would use an external
> + * buffer for printk line.
> + */
> +#define DEFINE_PR_LINE_BUF(lev, name, buf, sz)			\
> +	struct pr_line	name = {				\
> +		.sb	= __SEQ_BUF_INITIALIZER(buf, (sz)),	\
> +		.level	= lev,					\
> +	}
> +

I would use this one for the OOM killer. 80 bytes is too short.

  static char oom_print_buf[1024];
  DEFINE_PR_LINE_BUF(level, oom_print_buf);



> @@ -131,4 +187,8 @@ extern int
>  seq_buf_bprintf(struct seq_buf *s, const char *fmt, const u32 *binary);
>  #endif
>  
> +extern __printf(2, 0)
> +int vpr_line(struct pr_line *pl, const char *fmt, va_list args);
> +extern __printf(2, 3)
> +int pr_line(struct pr_line *pl, const char *fmt, ...);

Do we want to mark "asmlinkage" like printk() ?

> @@ -324,3 +324,60 @@ int seq_buf_to_user(struct seq_buf *s, char __user *ubuf, int cnt)
>  	s->readpos += cnt;
>  	return cnt;
>  }
> +
> +/**
> + * vpr_line - Append data to the printk() line buffer
> + * @pl: the pr_line descriptor

s/descriptor/structure/ ?

> + * @fmt: printf format string
> + * @args: va_list of arguments from a printf() type function
> + *
> + * Writes a vnprintf() format into the printk() pr_line buffer.

s/vnprintf/vprintf/ ?

