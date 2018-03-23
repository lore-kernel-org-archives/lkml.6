Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752857AbeCWMTs (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 08:19:48 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:40552 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752605AbeCWMTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 08:19:43 -0400
X-Google-Smtp-Source: AG47ELt/IR3xKqGBvUJQWsgVWxmrKHkQ136JYWE/Nose7iUbj/pmuRxWnjDTaWVo2rp7ORTzRPLT+g==
Subject: Re: [PATCH 2/2] trace-cmd: Change the way of getting python ldflags.
To: Steven Rostedt <rostedt@goodmis.org>
Cc: johannes.berg@intel.com, johannes@sipsolutions.net,
        linux-kernel@vger.kernel.org, zsun@redhat.com
References: <20180204032014.6962-1-sztsian@gmail.com>
 <20180204032014.6962-3-sztsian@gmail.com>
 <20180322191331.48b3d9dd@gandalf.local.home>
From: Zamir SUN <sztsian@gmail.com>
Message-ID: <5a40a30f-c461-2734-edec-d9f3491559e7@gmail.com>
Date: Fri, 23 Mar 2018 20:19:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180322191331.48b3d9dd@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/23/2018 07:13 AM, Steven Rostedt wrote:
> On Sun,  4 Feb 2018 11:20:14 +0800
> sztsian@gmail.com wrote:
> 
>> From: Zamir SUN <sztsian@gmail.com>
>>
>> Prior than this patch, Makefile detects python ldflags using a hardcoded
>> python command. It will cause problems if we are building against
>> python3 in the future when ldflags for python2 and python3 are
>> different. With this patch, python ldflags are detected by
>> corresponding python{,3}-config which will detect the right config for
>> python plugins.
>>
>> Signed-off-by: Zamir SUN (Red Hat) <sztsian@gmail.com>
>> ---
>>  Makefile | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Makefile b/Makefile
>> index 7c0d1a6..f41e399 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -636,7 +636,7 @@ report_noswig: force
>>  
>>  PYTHON_INCLUDES = `pkg-config --cflags $(PYTHON_VERS)`
>>  PYTHON_LDFLAGS = `pkg-config --libs $(PYTHON_VERS)` \
>> -		$(shell python2 -c "import distutils.sysconfig; print distutils.sysconfig.get_config_var('LINKFORSHARED')")
>> +		$(shell $(PYTHON_VERS)-config --ldflags)
>>  PYGTK_CFLAGS = `pkg-config --cflags pygtk-2.0`
>>  
>>  ctracecmd.so: $(TCMD_LIB_OBJS) ctracecmd.i
> 
> BTW, I did have this applied, but when testing it caused warnings. I
> had to apply this patch to fix it:
> 
> -- Steve

Thanks for the info!

I am always using Fedora and Python is always preloaded so I did not
think of this scenario.

> 
> From d5579b729114135da20bcee6896a0683ff54f33a Mon Sep 17 00:00:00 2001
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> Date: Thu, 22 Mar 2018 18:38:22 -0400
> Subject: [PATCH] trace-cmd build: Do not execute python scripts if there is no
>  python
> 
> I was triggering the following build messages when not having swig installed:
> 
> make: -config: Command not found
> 
>     NO_PYTHON forced: swig not installed, not compiling python plugins
> 
> make: -config: Command not found
>   UPDATE                 trace_python_dir
> make: -config: Command not found
> 
> This is due to the executing of $(PYTHON_VERS)-config, which would just turn
> into "-config". Do not assign the PYTHON_* variables if NO_PYTHON is
> defined.
> 
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  Makefile | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Makefile b/Makefile
> index 2c82301..26fd42b 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -373,10 +373,16 @@ report_nopythondev: force
>  	$(Q)echo "    python-dev is not installed, not compiling python plugins"
>  	$(Q)echo
>  
> +ifndef NO_PYTHON
>  PYTHON_INCLUDES = `pkg-config --cflags $(PYTHON_VERS)`
>  PYTHON_LDFLAGS = `pkg-config --libs $(PYTHON_VERS)` \
>  		$(shell $(PYTHON_VERS)-config --ldflags)
>  PYGTK_CFLAGS = `pkg-config --cflags pygtk-2.0`
> +else
> +PYTHON_INCLUDES =
> +PYTHON_LDFLAGS =
> +PYGTK_CFLAGS =
> +endif
>  
>  export PYTHON_INCLUDES
>  export PYTHON_LDFLAGS
> 

-- 
Zamir SUN
Fedora user
GPG : 1D86 6D4A 49CE 4BBD 72CF FCF5 D856 6E11 F2A0 525E
