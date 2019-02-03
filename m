Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7D2C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 08:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A34A20855
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 08:51:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbfBCIvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 03:51:07 -0500
Received: from mga01.intel.com ([192.55.52.88]:59924 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727362AbfBCIvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 03:51:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Feb 2019 00:51:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,555,1539673200"; 
   d="scan'208";a="114902348"
Received: from cvg-ubt08.iil.intel.com (HELO [143.185.152.136]) ([143.185.152.136])
  by orsmga008.jf.intel.com with ESMTP; 03 Feb 2019 00:50:59 -0800
Subject: Re: [PATCH] kbuild: gitignore output directory
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190130111447.26032-1-vladimir.kondratiev@linux.intel.com>
 <CAK7LNAS8g3g3OTtqTN8begMxzbSS82Wn0CqY8u6vuELEZaLo3g@mail.gmail.com>
From:   Vladimir Kondratiev <vladimir.kondratiev@linux.intel.com>
Message-ID: <10f0f786-6d91-7eba-c057-96c6c00544e8@linux.intel.com>
Date:   Sun, 3 Feb 2019 10:50:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAK7LNAS8g3g3OTtqTN8begMxzbSS82Wn0CqY8u6vuELEZaLo3g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Agree; sending v2

On 2/1/19 6:18 AM, Masahiro Yamada wrote:
> On Wed, Jan 30, 2019 at 8:15 PM Vladimir Kondratiev
> <vladimir.kondratiev@linux.intel.com> wrote:
>>
>> When compiling into output directory using O=, many files
>> created under KBUILD_OUTPUT that git considers
>> as new ones; git clients, ex. "git gui" lists it, and it clutters
>> file list making it difficult to see what was really changed
>>
>> Generate .gitignore in output directory that ignores all
>> its content
>>
>> Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@linux.intel.com>
>> ---
>>   Makefile | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/Makefile b/Makefile
>> index 141653226f3c..ee66ea28869b 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -483,10 +483,13 @@ PHONY += outputmakefile
>>   # outputmakefile generates a Makefile in the output directory, if using a
>>   # separate output directory. This allows convenient use of make in the
>>   # output directory.
>> +# At the same time when output Makefile generated, generate .gitignore to
>> +# ignore whole output directory
>>   outputmakefile:
>>   ifneq ($(KBUILD_SRC),)
>>          $(Q)ln -fsn $(srctree) source
>>          $(Q)$(CONFIG_SHELL) $(srctree)/scripts/mkmakefile $(srctree)
>> +       echo "# this is build directory, ignore it\n*" > .gitignore
>>   endif
>>
>>   ifneq ($(shell $(CC) --version 2>&1 | head -n 1 | grep clang),)
>> --
>> 2.19.1
>>
> 
> 
> The idea looks OK to me.
> The implementation must be improved.
> 
> 
> You need to add $(Q) to suppress the annoying command echo.
> 
> Also, this patch does not work for all distributions because
> echo "\n"
> is not portable.
> 
> 
> 
> GNU Make runs recipes in /bin/sh (unless SHELL variable is changed),
> but the implementation of /bin/sh depends on distributions.
> 
> 
> This patch works on Ubuntu etc.
> because /bin/sh is a symbolic link to dash.
> 
> 
> But, in some distributions,
> /bin/sh is a symbolic link to bash.
> 
> 
> 
> Docker is useful for quick tests of
> various distributions. :)
> 
> See the result of  echo "hello\nworld"
> 
> 
> [Ubuntu]
> 
> foo@8ad1275125c5:~$ cat /etc/lsb-release
> DISTRIB_ID=Ubuntu
> DISTRIB_RELEASE=18.10
> DISTRIB_CODENAME=cosmic
> DISTRIB_DESCRIPTION="Ubuntu 18.10"
> foo@8ad1275125c5:~$ ls -l /bin/sh
> lrwxrwxrwx 1 root root 4 Nov 14 23:00 /bin/sh -> dash
> foo@8ad1275125c5:~$ /bin/sh
> $ type echo
> echo is a shell builtin
> $ echo "hello\nworld"
> hello
> world
> 
> 
> 
> 
> [CentOS]
> 
> 
> [foo@c3fbaa4b6f72 ~]$ cat /etc/redhat-release
> CentOS Linux release 7.6.1810 (Core)
> [foo@c3fbaa4b6f72 ~]$ ls -l /bin/sh
> lrwxrwxrwx 1 root root 4 Dec  5 01:36 /bin/sh -> bash
> [foo@c3fbaa4b6f72 ~]$ /bin/sh
> sh-4.2$ type echo
> echo is a shell builtin
> sh-4.2$ echo "hello\nworld"
> hello\nworld
> 
> 
> 
> 
> 
> On example for workaround might be:
> 
> diff --git a/Makefile b/Makefile
> index ee66ea2..010c1c6 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -489,7 +489,7 @@ outputmakefile:
>   ifneq ($(KBUILD_SRC),)
>          $(Q)ln -fsn $(srctree) source
>          $(Q)$(CONFIG_SHELL) $(srctree)/scripts/mkmakefile $(srctree)
> -       echo "# this is build directory, ignore it\n*" > .gitignore
> +       $(Q){ echo "# this is build directory, ignore it"; echo "*"; }
>> .gitignore
>   endif
> 
>   ifneq ($(shell $(CC) --version 2>&1 | head -n 1 | grep clang),)
> 
> 
> 
> 
> 
> 
