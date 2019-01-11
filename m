Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E65FC43444
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 04:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D184720870
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 04:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="WfcH6xVk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729595AbfAKExC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 23:53:02 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36414 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbfAKExC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 23:53:02 -0500
Received: by mail-qt1-f195.google.com with SMTP id t13so17084991qtn.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 20:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cF5lEhJO6uVDc9Kz2wuXL4EEkXm4N4swd99XwX/kuYA=;
        b=WfcH6xVkCR2w2IcLbvoEwCOtRleS09Drj8/xhIgT4WT7oVvoB1x02tsDHiXyQwweOa
         AjYBYGCXx+/LY4u4/0YYq3QAA7hzMfxzmMDkYxOZgm8YihQutKirbsAq0ek8ZYhposKM
         eURx2dA5UuZS1Z4klIGUaQe4+96Yiu5QPUFFUO9gbtZHHFrFdMikxxY9BNrHC8H2++hJ
         ezQwu3cEFjQL9DZbP3eOg2VA6ZO9bqAa6/LTkQ1ngab86d9l05jyWb0frPVzQg/3uW4Y
         /eRxgC/eP2r4JGRrRqgueSn/rFRPSNOtPKCyGIeAjbboMH/k098F4DuIPJZvzbQclnW3
         3juw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cF5lEhJO6uVDc9Kz2wuXL4EEkXm4N4swd99XwX/kuYA=;
        b=jgwLiIeQIsJgUvWa7bctIRJrxWbGPLjMoujjfMsGje+k0TKpDe9pl1jSahvnINdeE9
         9tLUNvm1psq9xceNHRrtgg3JteRhu+A82QSoER7PIyRKNLv8Fi6cfdyyd38iQ7Tim+38
         94EO6LZzXUaJqXJKPzia46A/3AzHdk0PW4rUmNClUdXpx7NPpXuXMiwGddHZT8CL8TPL
         otq5ucyMmJ1q2Ftl82rnjYg1T/V1Hh6i0veppdTLUaLHC02icu60WJzePMXhhgc2DWlA
         jNcVw3E+8QUAzDDu/Rh71SOgVmJrjxXv1QLEiIfbywyIUABGBiMV2YMEK+H83gOiqYoa
         zOEw==
X-Gm-Message-State: AJcUukeFA5x1xEYS/2Vi5t8uah+NszjgpkLF7S/D8gjXesFA2m4DBAOL
        GZbR46HQo6ML0/ZRONPKcwZtjw==
X-Google-Smtp-Source: ALg8bN7YPcFEyuDPJy2xy4xhl2qybsRr5oFrxQh795DnmwkjOC9WntbsUSkX+eM/jlmIaKoQfHWEWw==
X-Received: by 2002:a0c:afa1:: with SMTP id s30mr12747954qvc.53.1547182380855;
        Thu, 10 Jan 2019 20:53:00 -0800 (PST)
Received: from ovpn-120-55.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id o22sm14079227qkk.93.2019.01.10.20.52.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 20:53:00 -0800 (PST)
Subject: Re: PROBLEM: syzkaller found / pool corruption-overwrite / page in
 user-area or NULL
To:     Esme <esploit@protonmail.ch>
Cc:     James Bottomley <jejb@linux.ibm.com>,
        "dgilbert@interlog.com" <dgilbert@interlog.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <t78EEfgpy3uIwPUvqvmuQEYEWKG9avWzjUD3EyR93Qaf_tfx1gqt4XplrqMgdxR1U9SsrVdA7G9XeUZacgUin0n6lBzoxJHVJ9Ko0yzzrxI=@protonmail.ch>
 <1547150339.2814.9.camel@linux.ibm.com> <1547153074.6911.8.camel@lca.pw>
 <4u36JfbOrbu9CXLDErzQKvorP0gc2CzyGe60rBmZsGAGIw6RacZnIfoSsAF0I0TCnVx0OvcqCZFN6ntbgicJ66cWew9cOXRgcuWxSPdL3ko=@protonmail.ch>
 <1547154231.6911.10.camel@lca.pw>
 <hFmbfypBKySVyM6ITf55xUsPWifgqJy6MZ-kFJcYna61S-u2hoClrqr87QTF4F2LhW-K42T2lcCbvsEyGAL0dJTq5CndQBiMT6JnlW4xmdc=@protonmail.ch>
 <1547159604.6911.12.camel@lca.pw>
 <olV6qm38nrHhMMH3bq9cY3h60MaHsW5U9n6xn3_PVP1UkFNJBNbVuS-8P_FdCazGJX6GZX_Qqe2Nj8_hbLJsgto76Xo-gLQ8We-hsc_vRKk=@protonmail.ch>
 <7416c812-f452-9c23-9d0c-37eac0174231@lca.pw>
 <fkYi1Hgt2t5U6zQt5Kz4ej-TFyVsn2Qp2OLrMbmt2418U1rn20DPZGqgCN-rmCZgFgGKXhl3-IGciCJ-G9fV_lkBuy_Vb7QFouBhwBE--Eo=@protonmail.ch>
From:   Qian Cai <cai@lca.pw>
Message-ID: <3b3184e0-d913-6519-0f9d-2f01ef795650@lca.pw>
Date:   Thu, 10 Jan 2019 23:52:58 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <fkYi1Hgt2t5U6zQt5Kz4ej-TFyVsn2Qp2OLrMbmt2418U1rn20DPZGqgCN-rmCZgFgGKXhl3-IGciCJ-G9fV_lkBuy_Vb7QFouBhwBE--Eo=@protonmail.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/10/19 10:15 PM, Esme wrote:
>>> [ 75.793150] RIP: 0010:rb_insert_color+0x189/0x1480
>>
>> What's in that line? Try,
>>
>> $ ./scripts/faddr2line vmlinux rb_insert_color+0x189/0x1480
> 
> rb_insert_color+0x189/0x1480:
> __rb_insert at /home/files/git/linux/lib/rbtree.c:131
> (inlined by) rb_insert_color at /home/files/git/linux/lib/rbtree.c:452
> 

gparent = rb_red_parent(parent);

tmp = gparent->rb_right; <-- GFP triggered here.

It suggests gparent is NULL. Looks like it misses a check there because parent
is the top node.

>>
>> What's steps to reproduce this?
> 
> The steps is the kernel config provided (proc.config) and I double checked the attached C code from the qemu image (attached here).  If the kernel does not immediately crash, a ^C will cause the fault to be noticed.  The report from earlier is the report from the same code, my assumption was that the possible pool/redzone corruption is making it a bit tricky to pin down.
> 
> If you would like alternative kernel settings please let me know, I can do that, also, my current test-bench has about 256 core's on x64, 64 of them are bare metal and 32 are arm64.  Any possible preferred configuration tweaks I'm all ears, I'll be including some of these steps you suggested to me in any/additional upcoming threads (Thank you for that so far and future suggestions).
> 
> Also, there is some occasionally varying stacks depending on the corruption, so this stack just now (another execution of test3.c);

I am unable to reproduce any of those here. What's is the output of
/proc/cmdline in your guest when this happens?
