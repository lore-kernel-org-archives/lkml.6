Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1DAC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 19:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F92220840
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 19:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731349AbfAPTf4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 14:35:56 -0500
Received: from mga17.intel.com ([192.55.52.151]:45473 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730757AbfAPTfy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 14:35:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jan 2019 11:35:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,487,1539673200"; 
   d="scan'208";a="126578277"
Received: from tkevorki-mobl4.amr.corp.intel.com (HELO [10.254.178.90]) ([10.254.178.90])
  by orsmga002.jf.intel.com with ESMTP; 16 Jan 2019 11:35:51 -0800
Subject: Re: [PATCH 6/8] ASoC: intel: skylake: change snprintf to scnprintf
 for possible overflow
To:     Kees Cook <keescook@chromium.org>, Willy Tarreau <w@1wt.eu>
Cc:     Silvio Cesare <silvio.cesare@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Will Deacon <will.deacon@arm.com>, Greg KH <greg@kroah.com>
References: <20190112152844.26550-1-w@1wt.eu>
 <20190112152844.26550-6-w@1wt.eu>
 <CAGXu5j+LvQsLSO+TtVr5hrUTYHA0Hqrc=pxPMv++erySJ8pV7g@mail.gmail.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <ce0fca46-ff5e-beb3-5318-3a7c1e6da0e8@linux.intel.com>
Date:   Wed, 16 Jan 2019 13:35:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAGXu5j+LvQsLSO+TtVr5hrUTYHA0Hqrc=pxPMv++erySJ8pV7g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> diff --git a/sound/soc/intel/skylake/skl-debug.c b/sound/soc/intel/skylake/skl-debug.c
>> index 5d7ac2ee7a3c..bb28db734fb7 100644
>> --- a/sound/soc/intel/skylake/skl-debug.c
>> +++ b/sound/soc/intel/skylake/skl-debug.c
>> @@ -43,7 +43,7 @@ static ssize_t skl_print_pins(struct skl_module_pin *m_pin, char *buf,
>>          ssize_t ret = 0;
>>
>>          for (i = 0; i < max_pin; i++)
>> -               ret += snprintf(buf + size, MOD_BUF - size,
>> +               ret += scnprintf(buf + size, MOD_BUF - size,
>>                                  "%s %d\n\tModule %d\n\tInstance %d\n\t"
>>                                  "In-used %s\n\tType %s\n"
>>                                  "\tState %d\n\tIndex %d\n",
>>
> While working on a Coccinelle script to find more cases of this, I
> noticed that this code is buggy: it keeps overwriting the same
> position in the buf string: "buf + size" and don't take "ret" into
> account at all. This needs to be:
>
> ret += scnprintf(buf + size + ret, MOD_BUF - size - ret,

Thanks for the sighting. Indeed this looks like a bug, all other calls 
to snprintf use "ret" to modify the destination/length.

The only explanation I have for it not being noticed earlier is that 
it's possibly not used - a 5mn test on 2 machines show the loop is 
actually not run (max_pin == 0).

It'll take me a bit of time to figure out what exactly this routine is 
supposed to do, maybe we should do the cross-tree change first?

-Pierre

