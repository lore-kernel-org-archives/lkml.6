Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753082AbeCMUxg (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 16:53:36 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:53047 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752871AbeCMUxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 16:53:35 -0400
Subject: Re: perf-core build fails on powerpc
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
References: <20180313191742.GA29120@us.ibm.com>
 <152d2ba4-fe57-beab-87d5-554a0fede9ae@huawei.com>
 <20180313201003.GB29120@us.ibm.com>
CC: Arnaldo Carvalho de Melo <acme@kernel.org>,
        <linux-kernel@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
        "Jiri Olsa" <jolsa@redhat.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <543acf58-520d-e3e2-211e-17068d713a4f@huawei.com>
Date: Tue, 13 Mar 2018 20:53:27 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20180313201003.GB29120@us.ibm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.91.115]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/03/2018 20:10, Sukadev Bhattiprolu wrote:

+

> John Garry [john.garry@huawei.com] wrote:
>> On 13/03/2018 19:17, Sukadev Bhattiprolu wrote:
>>>
>>>
>>> Building perf on Powerpc seems broken when using Arnaldo's perf/core branch
>>> with HEAD as:
>>>
>>>     1b442ed ("perf test: Fix exit code for record+probe_libc_inet_pton.sh")
>>>
>>> It maybe related to this commit:
>>>
>>> 	commit d596299
>>> 	Author: John Garry <john.garry@huawei.com>
>>> 	Date:   Thu Mar 8 18:58:29 2018 +0800
>>>
>>> 	    perf vendor events: Add support for pmu events vendor subdirectory
>>>
>>> Reverting this hunk from tools/perf/pmu-events/jevents.c, seems to fix the
>>> problem for me.
>>>
>
> Hi John,
>
> I have an xfs file system which seems to have d_type == DT_UNKNOWN for all
> entries in 'tools/perf/pmu-events/arch/power8'! readdir(3) says ->d_type
> may not be supported by all file systems.
>
> Not relying on ->d_type seems to fix it:
>

Hi Sukadev,

Thanks for debugging this. Jiri Olsa (cc'ed) warned me on this, so I did 
add the check for d_type == DT_UNKNOWN.

But, if all files have d_type == DT_UNKNOWN, you're code would from 
visual observation look to be same as mine (apart from check for '.' or 
'..' filename, which I would say is already covered by stat() and 
S_ISDIR()). Or is d_type value just unreliable?

Much appreciated,
John

> @@ -873,26 +879,26 @@ static int is_leaf_dir(const char *fpath)
>                 return 0;
>
>         while ((dir = readdir(d)) != NULL) {
> -               if (dir->d_type == DT_DIR && dir->d_name[0] != '.') {
> -                       res = 0;
> -                       break;
> -               } else if (dir->d_type == DT_UNKNOWN) {
> -                       char path[PATH_MAX];
> -                       struct stat st;
> +               char path[PATH_MAX];
> +               struct stat st;
>
> -                       sprintf(path, "%s/%s", fpath, dir->d_name);
> -                       if (stat(path, &st))
> -                               break;
> +               if (strcmp(dir->d_name, ".") == 0 ||
> +                               strcmp(dir->d_name, "..") == 0)
> +                       continue;
>
> -                       if (S_ISDIR(st.st_mode)) {
> -                               res = 0;
> -                               break;
> -                       }
> +               sprintf(path, "%s/%s", fpath, dir->d_name);
> +               if (stat(path, &st))
> +                       break;
> +
> +               if (S_ISDIR(st.st_mode)) {
> +                       res = 0;
> +                       break;
>
>
>
