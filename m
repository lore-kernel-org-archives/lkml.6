Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754177AbeBGOBx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 09:01:53 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:54881 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753767AbeBGOBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 09:01:52 -0500
X-Google-Smtp-Source: AH8x224OQX4ZtKRezwKLvSWxZBlr+NZC/2YorxoNcREi3CJkL36zcTUWhB9wNYX0t2L4+rj4HFxqpg==
Subject: Re: [PATCH 1/2] trace-cmd: Fix the detection for swig
To: Steven Rostedt <rostedt@goodmis.org>,
        Vladislav Valtchev <vladislav.valtchev@gmail.com>
Cc: johannes.berg@intel.com, johannes@sipsolutions.net,
        linux-kernel@vger.kernel.org, zsun@redhat.com
References: <20180204032014.6962-1-sztsian@gmail.com>
 <20180204032014.6962-2-sztsian@gmail.com>
 <20180206181807.2d35393e@gandalf.local.home>
From: Zamir SUN <sztsian@gmail.com>
Message-ID: <df980185-aa29-f65b-d5b0-f42d85a66a51@gmail.com>
Date: Wed, 7 Feb 2018 22:01:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180206181807.2d35393e@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/07/2018 07:18 AM, Steven Rostedt wrote:
> On Sun,  4 Feb 2018 11:20:13 +0800
> sztsian@gmail.com wrote:
> 
>> From: Zamir SUN <sztsian@gmail.com>
>>
>> The current detection for swig will cause output to be
>> /usr/bin/swig
>> y
>> So this will never be equal to y. With this patch, the swig path is
>> removed from output, so the detection can work as expected.
>>
>> Fixes 3bf187a43b7e6302592552ecbc294e5820249687
> 
> Hi Zamir,
> 
> Actually, a fix was already sent to me:
> 
>  http://lkml.kernel.org/r/20171220180748.17273-18-vladislav.valtchev@gmail.com
> 
> I'm working on add that one.
> 

Thanks for the heads-up! I did not see that before.

While just a note for this, in Fedora 27:

$ if command -v swig; then echo 1; else echo 0; fi
/usr/bin/swig
1

Actually this test has the same problem as of `which swig` - When swig
exists, the var SWIG_DEFINED will not be 1 (as shown above).

I see Vladislav is already on this thread. I hope this can be fixed
before merging the patch set.


> Thanks!
> 
> -- Steve
> 
>  
>>
>> Signed-off-by: Zamir SUN (Red Hat) <sztsian@gmail.com>
>> ---
>>  Makefile | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Makefile b/Makefile
>> index a5d2c38..7c0d1a6 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -105,7 +105,7 @@ PYTHON_GUI	:= ctracecmd.so ctracecmdgui.so
>>  PYTHON_VERS ?= python
>>  
>>  # Can build python?
>> -ifeq ($(shell sh -c "pkg-config --cflags $(PYTHON_VERS) > /dev/null 2>&1 && which swig && echo y"), y)
>> +ifeq ($(shell sh -c "pkg-config --cflags $(PYTHON_VERS) > /dev/null 2>&1 && which swig > /dev/null && echo y"), y)
>>  	PYTHON_PLUGINS := plugin_python.so
>>  	BUILD_PYTHON := $(PYTHON) $(PYTHON_PLUGINS)
>>  	PYTHON_SO_INSTALL := ctracecmd.install
> 

-- 
Zamir SUN
Fedora user
GPG : 1D86 6D4A 49CE 4BBD 72CF FCF5 D856 6E11 F2A0 525E
