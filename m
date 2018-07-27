Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD9E4C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 19:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D42220873
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 19:17:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D42220873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389236AbeG0Ukd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 16:40:33 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:44871 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388654AbeG0Ukc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 16:40:32 -0400
Received: by mail-yw0-f196.google.com with SMTP id k18-v6so2244923ywm.11
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 12:17:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=BGifKOFdhnxf0WtynUGXhkL903yoBPpjJHGbctZxmJo=;
        b=N/T7nM7+OtuqJvCBHk4sl55dmYE6ZF+0LBBtmypimpx40MTSIfD5kiYHDD/xt3KDhW
         57qwxBsjdVp5DvAdnMYFNrSb54CGQTDoyypK2aGBJmR+7dl+3MxZJS8lzAgn7rJrJi2T
         pV4djl2SG0+T7/SNFtiFgqku5MzO5jUzlaMMC1xVrUFXMu7+mcTkmIJAXZlQxjwkYYaM
         Im5uJLFYMf7YD4lod4enU6CsPinFQleib70VBS15ce7emFmtXbVahqkZpbNGSLhr1g88
         gv4iJIo37DvSaCYd0bX/hvp1OBSO4PRQfU1LmUIh9cqSpI4un/uh1RzQuDiKpF9E8QRM
         tSfA==
X-Gm-Message-State: AOUpUlGin1eiKQdy3wiIUAYJ5ZR8mfp0/QfOT0dF6KJReM+adh9b9/as
        hnG5qm7a7TPQTJDZBDsDBCYtCw==
X-Google-Smtp-Source: AAOMgpfIGrefZPtd24e29YhChdQ8L0OFw8UFv0e9uLTPWlN0vQPLjMHRPwnpqf5rHidN5Kisfov2uA==
X-Received: by 2002:a81:594:: with SMTP id 142-v6mr3999259ywf.494.1532719036633;
        Fri, 27 Jul 2018 12:17:16 -0700 (PDT)
Received: from laptop.jcline.org (108-197-13-110.lightspeed.rlghnc.sbcglobal.net. [108.197.13.110])
        by smtp.gmail.com with ESMTPSA id z190-v6sm1863242ywz.89.2018.07.27.12.17.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 12:17:16 -0700 (PDT)
Subject: Re: [PATCH 1/3] ext4: super: Fix spectre gadget in ext4_quota_on
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20180727162357.30801-1-jcline@redhat.com>
 <20180727162357.30801-2-jcline@redhat.com>
 <20180727174654.bnooz26puuo7456w@treble>
From:   Jeremy Cline <jcline@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jcline@redhat.com; keydata=
 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
 X/87hZ4pdW/aOXUAgQ==
Message-ID: <d4607577-c5e7-687f-43d6-9a7c9ed76479@redhat.com>
Date:   Fri, 27 Jul 2018 15:17:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180727174654.bnooz26puuo7456w@treble>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/27/2018 01:46 PM, Josh Poimboeuf wrote:
> On Fri, Jul 27, 2018 at 04:23:55PM +0000, Jeremy Cline wrote:
>> 'type' is a user-controlled value used to index into 's_qf_names', which
>> can be used in a Spectre v1 attack. Clamp 'type' to the size of the
>> array to avoid a speculative out-of-bounds read.
>>
>> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Jeremy Cline <jcline@redhat.com>
>> ---
>>  fs/ext4/super.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
>> index 6480e763080f..c04a09b51742 100644
>> --- a/fs/ext4/super.c
>> +++ b/fs/ext4/super.c
>> @@ -40,6 +40,7 @@
>>  #include <linux/crc16.h>
>>  #include <linux/dax.h>
>>  #include <linux/cleancache.h>
>> +#include <linux/nospec.h>
>>  #include <linux/uaccess.h>
>>  #include <linux/iversion.h>
>>  
>> @@ -5559,6 +5560,7 @@ static int ext4_quota_on(struct super_block *sb, int type, int format_id,
>>  	if (path->dentry->d_sb != sb)
>>  		return -EXDEV;
>>  	/* Journaling quota? */
>> +	type = array_index_nospec(type, EXT4_MAXQUOTAS);
>>  	if (EXT4_SB(sb)->s_qf_names[type]) {
>>  		/* Quotafile not in fs root? */
>>  		if (path->dentry->d_parent != sb->s_root)
> 
> Generally we try to put the array_index_nospec() close to the bounds
> check for which it's trying to prevent speculation past.
> 
> In this case, I'd expect the EXT4_MAXQUOTAS bounds check to be in
> do_quotactl(), but it seems to be missing:
> 
> 	if (type >= (XQM_COMMAND(cmd) ? XQM_MAXQUOTAS : MAXQUOTAS))
> 		return -EINVAL;
> 
> Also it looks like XQM_MAXQUOTAS, MAXQUOTAS, and EXT4_MAXQUOTAS all have
> the same value (3).  Maybe they can be consolidated to just use
> MAXQUOTAS everywhere?  Then the nospec would be simple:
> 
> 	if (type >= MAXQUOTAS)
> 		return -EINVAL;
> 	type = array_index_nospec(type, MAXQUOTAS);
> 
> Otherwise I think we may need to disperse the array_index_nospec calls
> deeper in the callchain.
> 

Makes sense, that would be much nicer. I looked into the history a bit,
EXT4_MAXQUOTAS was adjusted from 2 to 3 in v4.5 so a backport of this to
v4.4 or earlier would require a bit of adjustment, but XQM_MAXQUOTAS
looks to have been 3 for a very long time.

I'll see about consolidating them and adjusting this patch.

Thanks,
Jeremy
