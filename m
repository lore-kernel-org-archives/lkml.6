Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0645BC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 00:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8EF3208A4
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 00:14:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8EF3208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732131AbeGaBv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 21:51:26 -0400
Received: from www62.your-server.de ([213.133.104.62]:50144 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731941AbeGaBvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 21:51:25 -0400
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1fkIIT-000782-1Z; Tue, 31 Jul 2018 02:13:53 +0200
Received: from [62.203.87.61] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1fkIIS-000Nzh-T9; Tue, 31 Jul 2018 02:13:52 +0200
Subject: Re: [PATCH v3] perf build: Build error in libbpf with
 EXTRA_CFLAGS="-Wp,-D_FORTIFY_SOURCE=2 -O2"
To:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        Thomas Richter <tmricht@linux.ibm.com>
Cc:     ast@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com
References: <20180730085323.75738-1-tmricht@linux.ibm.com>
 <20180730123509.0ffa4737@cakuba.netronome.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <ac172898-1d27-9ab5-5ff1-4f33c79e5191@iogearbox.net>
Date:   Tue, 31 Jul 2018 02:13:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180730123509.0ffa4737@cakuba.netronome.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.0/24797/Mon Jul 30 18:42:33 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/30/2018 09:35 PM, Jakub Kicinski wrote:
> On Mon, 30 Jul 2018 10:53:23 +0200, Thomas Richter wrote:
>> commit 531b014e7a2f ("tools: bpf: make use of reallocarray")
>> causes a compiler error when building the perf tool in the linux-next
>> tree.  Compile file tools/lib/bpf/libbpf.c on a FEDORA 28
>> installation with gcc compiler
>> version: gcc (GCC) 8.0.1 20180324 (Red Hat 8.0.1-0.20)
>> shows this error message:
>>
>> [root@p23lp27] # make V=1 EXTRA_CFLAGS="-Wp,-D_FORTIFY_SOURCE=2 -O2"
>> [...]
>> make -f /home6/tmricht/linux-next/tools/build/Makefile.build
>> 	dir=./util/scripting-engines obj=libperf
>> libbpf.c: In function ‘bpf_object__elf_collect’:
>> libbpf.c:811:15: error: ignoring return value of ‘strerror_r’,
>> 		declared with attribute warn_unused_result [-Werror=unused-result]
>>      strerror_r(-err, errmsg, sizeof(errmsg));
>>                ^
>> cc1: all warnings being treated as errors
>> mv: cannot stat './.libbpf.o.tmp': No such file or directory
>> /home6/tmricht/linux-next/tools/build/Makefile.build:96: recipe for target 'libbpf.o' failed
>>
>> Replace all occurrences of strerror() by calls to strerror_r().
>> To keep the compiler quiet also use the return value from strerror_r()
>> otherwise a 'variable set but not use' warning which is treated as error
>> terminates the compile.
>>
>> Cc: Alexei Starovoitov <ast@kernel.org>
>> Cc: Daniel Borkmann <daniel@iogearbox.net>
>> Cc: Jakub Kicinski <jakub.kicinski@netronome.com>
>> Suggested-by: Jakub Kicinski <jakub.kicinski@netronome.com>
>> Suggested-by: Daniel Borkmann <daniel@iogearbox.net>
>> Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
>> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>

Applied to bpf-next, thanks Thomas!
