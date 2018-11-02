Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B68C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 13:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DAB7204FD
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 13:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bJU1wme2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DAB7204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbeKBWyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 18:54:11 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54008 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbeKBWyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 18:54:11 -0400
Received: by mail-wm1-f67.google.com with SMTP id v24-v6so2052935wmh.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 06:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w/aI533E4xRuKv3yXO3QjhJ7qb8aI1RZuL1gJEaOK8I=;
        b=bJU1wme2jllQDNuZhNA+RkdvkOfnwwEhJD6Y/jYYjie2hyi8hwoDN6EP3OdUhkyVwk
         TR2/ra52IB3VVXGjNJ9FHkVnIX0i2yP6Sr0l55Bc1d3Pcu5/6C7P6diwh7VLcfHR+qig
         AIwrQGXMEBvWAQ4vgMlcygAko1xv6Dcs9OIcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w/aI533E4xRuKv3yXO3QjhJ7qb8aI1RZuL1gJEaOK8I=;
        b=RY/b5rqSoYohwT4ggr/l5PV7w0S7MSHXCUkcd9wRwK6qaYy7VQkRH/uViBAoB0CTPd
         v0FzYPM1Rc4Cupy921KVo3iIu2iCFu+EJqTTCEe7KMT1nfKlBGAb14nvGtl1nJ0j7Bga
         ufqKTDE1ufS/grIeF6uvcHGcExPTKNkvq3dff+hM4EXferdpcLZcqCC0agxN+HjKnGpX
         nJ6xbG0YKfmRc/7nM/dDeeGt4aJrPYjEvnRRNUUdhyXQdoOhGbB+D4C8nBuZh6WICrU0
         kt+yqNS2n5Z8f37DBsI8tQSWoRqT0bkcKV5ZoEIsKTgLNMHFxOEKWujvYN2FVieQHX++
         kI/g==
X-Gm-Message-State: AGRZ1gLc2Bg6joz8Y8FVKBr/AosvH4P7KatqYRw2Wvi5oZfUSQInSKxD
        5YoYKEthH8wDJ1Aza4+QdMKajg==
X-Google-Smtp-Source: AJdET5elbAgbW/PUx8R7DyQ6dcpjAuBIVGbpU1qmCAXAzWzCC1zDCmBTGk3yeC4Pm9Pb9ib4WZGyBg==
X-Received: by 2002:a1c:c4f:: with SMTP id 76-v6mr51138wmm.6.1541166416662;
        Fri, 02 Nov 2018 06:46:56 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([209.250.228.18])
        by smtp.gmail.com with ESMTPSA id s195-v6sm2831701wmd.39.2018.11.02.06.46.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 06:46:55 -0700 (PDT)
Date:   Fri, 2 Nov 2018 21:46:49 +0800
From:   leo.yan@linaro.org
To:     Al Grant <Al.Grant@arm.com>
Cc:     "acme@redhat.com" <acme@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Coresight ML <coresight@lists.linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Question: perf dso support for /proc/kallsyms
Message-ID: <20181102134649.GB3983@leoy-ThinkPad-X240s>
References: <20181102025516.GA25374@leoy-ThinkPad-X240s>
 <AM6PR08MB3686A4DD9B75B551885C790386CF0@AM6PR08MB3686.eurprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR08MB3686A4DD9B75B551885C790386CF0@AM6PR08MB3686.eurprd08.prod.outlook.com>
User-Agent: Mutt/1.10+31 (9cdd884) (2018-06-19)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Al,

On Fri, Nov 02, 2018 at 12:08:04PM +0000, Al Grant wrote:
> > Now I still don't understand how the dso/map support "/proc/kallsyms" and
> > have no idea to fix this issue, though I spent some time to look into it.
> 
> The way this is supported is that at record time, pseudo mmap records
> are created for the kernel. But depending on permissions these might
> not get created. This isn't just an ETM issue, it can happen on Intel too.

Agree, I also think this is not a specific issue only for Arm platform,
this should be one common issue for how to parse kernel symbols with
kallsyms file.

> What do you see in "perf report -D", do you see a PERF_RECORD_MMAP
> record for "[kernel.kallsyms]_text" and possibly some others for loadable
> kernel modules in /lib/modules?

Yes, I can see PERF_RECORD_MMAP for "[kernel.kallsyms]_text".

0x350 [0x50]: event: 1
.
. ... raw event: size 80 bytes
.  0000:  01 00 00 00 01 00 50 00 ff ff ff ff 00 00 00 00  ......P.........
.  0010:  00 00 08 08 00 00 ff ff ff ff f7 f7 ff ff 00 00  ................
.  0020:  00 00 08 08 00 00 ff ff 5b 6b 65 72 6e 65 6c 2e  ........[kernel.
.  0030:  6b 61 6c 6c 73 79 6d 73 5d 5f 74 65 78 74 00 00  kallsyms]_text..
.  0040:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................

0x350 [0x50]: PERF_RECORD_MMAP -1/0: [0xffff000008080000(0xfffff7f7ffff) @ 0xffff000008080000]: x [kernel.kallsyms]_text

Below is the infor for checking buildid:

root@debian:~/coresight_test# perf buildid-list
0242d9154c78df1d8fe1d0512c36a236d0861a18 [kernel.kallsyms]
b8c89e8ba41a2ea486c66a50c29c60d38c34a759 /root/coresight_test/main
26b12a9d1a54ed2b0478cb0203435b76aabab3fb /usr/lib/aarch64-linux-gnu/ld-2.27.so
8fca7ed524c9469b065af83bc8a529fe72858f53 [vdso]
25829a59e21012cfde7850b30a310cd3a58f531c /root/coresight_test/libcstest.so
70512527439ef76c8802a7a2a546bde6a5a6e967 /usr/lib/aarch64-linux-gnu/libc-2.27.so
root@debian:~/coresight_test# ls ~/.debug/\[kernel.kallsyms\]/0242d9154c78df1d8fe1d0512c36a236d0861a18/
kallsyms

> Does it all work if you run perf record as sudo? Or if you do
> 
>    sudo sysctl kernel.kptr_restrict=0
> 
> before you run perf record?

Yes, tested this on Juno board with Debian rootFS and logined in
with 'root' user.  I suspected the pointer permission issue so
checked with below command:

root@debian:~/coresight_test# cat /proc/sys/kernel/kptr_restrict 
0

Thanks,
Leo Yan
