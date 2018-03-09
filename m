Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932511AbeCIT0d (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 14:26:33 -0500
Received: from omr-a012e.mx.aol.com ([204.29.186.61]:44592 "EHLO
        omr-a012e.mx.aol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751249AbeCIT0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 14:26:31 -0500
Subject: Re: [PATCH] perf annotate: Don't prepend symfs path to
 build_id_filename
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180211191937.9703-1-jpmv27@aim.com>
 <20180309190715.GB25111@kernel.org>
From: Martin Vuille <jpmv27@aim.com>
Message-ID: <9dfd677b-14b9-caec-d12e-b0043f541ec4@aim.com>
Date: Fri, 9 Mar 2018 14:26:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180309190715.GB25111@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
x-aol-global-disposition: G
x-aol-sid: 3039ac1adecd5aa2dfe63d5a
X-AOL-IP: 99.246.128.134
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dso__build_id_filename calls build_id_cache__linkname

build_id_cache__linkname uses buildid_dir

symbol__config_symfs includes the symfs directory in buildid_dir

So it's not necessary to prepend it again.


Should've included those notes in the original submission.

Will do better next time.

MV


On 03/09/18 14:07, Arnaldo Carvalho de Melo wrote:
> Em Sun, Feb 11, 2018 at 02:19:37PM -0500, Martin Vuille escreveu:
>> build_id_filename already contains symfs path if applicable, so
>> don't prepend it a second time.
> Where is the analysis that shows that that is the case? I looked here at
> the implementation for dso__build_id_filename() and couldn't find where
> was it that the symfs would be appended, can you clarify?
>
> - Arnaldo
>   
>> Signed-off-by: Martin Vuille <jpmv27@aim.com>
>> ---
>>   tools/perf/util/annotate.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
>> index 28b233c3dcbe..425b7f0760ec 100644
>> --- a/tools/perf/util/annotate.c
>> +++ b/tools/perf/util/annotate.c
>> @@ -1381,7 +1381,7 @@ static int dso__disassemble_filename(struct dso *dso, char *filename, size_t fil
>>   
>>   	build_id_filename = dso__build_id_filename(dso, NULL, 0, false);
>>   	if (build_id_filename) {
>> -		__symbol__join_symfs(filename, filename_size, build_id_filename);
>> +		scnprintf(filename, filename_size, "%s", build_id_filename);
>>   		free(build_id_filename);
>>   	} else {
>>   		if (dso->has_build_id)
>> -- 
>> 2.13.6
