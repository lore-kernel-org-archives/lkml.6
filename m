Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B4F0C282CB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A2B32075C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="QNUv0voN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbfBHOoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 09:44:04 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46129 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbfBHOoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 09:44:01 -0500
Received: by mail-wr1-f68.google.com with SMTP id l9so3779127wrt.13
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 06:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=4uVlBtI7NKjDVE6kZQ74NJ6Y2rCmDKy7MnLjSm7tpU0=;
        b=QNUv0voNIpGej9H6vZxz0QPZwVKEi9KFGU70B4jE8K92HIm4+9JrGRfJB774mC/oKi
         F+uGLuPPhwKSGywWi4d6v2+kR0FCivt5GAp1kH4ubbKe7ZUzxayuKzim4LXcKMj6FyH7
         9PppYuItWTMpbD7z46F1KZ8plc/Hq6n6L4IDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4uVlBtI7NKjDVE6kZQ74NJ6Y2rCmDKy7MnLjSm7tpU0=;
        b=CaV7T4Z+tmFhxPLSHSzOThBmFw8939bzHDH/+joheX6kOvFms00AHoFz20WpNmU5AF
         AHotkVcu7XukRYdi/h3+fQTDLVR92QVMROqPy1wB939GBuQrUgeNAvyV7EEgwaGBr/db
         lbjZMBhNnGXgVR4PeUOE+gq3icFHapoPGbbZ/f3IO6SQjHs0LY8mOhgQ32XQFOFPXbfR
         SVE2zxTmLmMqp/uAuaoXPjvg4w7tbovB9dDzpYGm51oLLDu1WO+DI+G3NFNeoUjPkAHc
         N1ucX4Kcp9mOEZpTBQEwF+05ykBJZmbjjIbMl1KLoYxo1EDh+xm870jhfaz/z8YOz4rr
         4YQA==
X-Gm-Message-State: AHQUAuawwLYlQ1xLcnXQcvTHuOGA0Qsny2engSGJmFA3pN0ao2k+DFUz
        juXmBs+5zpeTGDGWymsMK/xwSAqkre9Vxw==
X-Google-Smtp-Source: AHgI3Ib/jMMnHU+LNI6FM3YtdpgGs8z94TZfFtPQ3h2yQV+NNyW4Ek5inu/3QIsE67G1u1hJ+CQ2PQ==
X-Received: by 2002:adf:ff49:: with SMTP id u9mr17317030wrs.279.1549637039208;
        Fri, 08 Feb 2019 06:43:59 -0800 (PST)
Received: from [192.168.51.243] ([93.152.141.58])
        by smtp.gmail.com with ESMTPSA id z17sm2461007wrv.2.2019.02.08.06.43.57
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 06:43:58 -0800 (PST)
Subject: Re: [PATCH net-next] ipmr: ip6mr: Create new sockopt to clear mfc
 cache or vifs
To:     nicolas.dichtel@6wind.com,
        Callum Sinclair <callum.sinclair@alliedtelesis.co.nz>,
        davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190208041103.31299-1-callum.sinclair@alliedtelesis.co.nz>
 <20190208041103.31299-2-callum.sinclair@alliedtelesis.co.nz>
 <be9e655b-6911-c644-de63-9aabcd131763@6wind.com>
From:   Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <5597e8bc-c23e-1f59-0442-260a7b4ca83d@cumulusnetworks.com>
Date:   Fri, 8 Feb 2019 16:43:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <be9e655b-6911-c644-de63-9aabcd131763@6wind.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/2019 16:18, Nicolas Dichtel wrote:
> Le 08/02/2019 à 05:11, Callum Sinclair a écrit :
>> Currently the only way to clear the mfc cache was to delete the entries
> mfc stands for 'multicast forwarding cache', so 'mfc cache' is a bit strange.
> 
>> one by one using the MRT_DEL_MFC socket option or to destroy and
>> recreate the socket.
> Note that if entries were added with MRT_ADD_MFC_PROXY, they will survive to the
> socket destruction. This is not the case with your new cmd. Is it intended?

I think you're referring to MFC_STATIC entries (sk != mroute_sk). It
doesn't matter how you add an entry - they all get cleaned up if added
through the mroute socket.

> Maybe a third option (something like MRT_FLUSH_MFC_PROXY) would be useful to
> avoid confusion?
> 
>>
>> Create a new socket option which will clear the multicast forwarding
>> cache on the socket without destroying the socket. The new socket option
>> MRT_FLUSH_ENTRIES will clear all multicast entries on the sockets table
>> and the MRT_FLUSH_VIFS will delete all multicast vifs on the socket
>> table.
>>
>> Signed-off-by: Callum Sinclair <callum.sinclair@alliedtelesis.co.nz>
>> ---
>>  include/uapi/linux/mroute.h  |  7 +++-
>>  include/uapi/linux/mroute6.h |  7 +++-
>>  net/ipv4/ipmr.c              | 69 ++++++++++++++++++++-------------
>>  net/ipv6/ip6mr.c             | 74 ++++++++++++++++++++++--------------
>>  4 files changed, 100 insertions(+), 57 deletions(-)
>>
>> diff --git a/include/uapi/linux/mroute.h b/include/uapi/linux/mroute.h
>> index 5d37a9ccce63..673495ca3495 100644
>> --- a/include/uapi/linux/mroute.h
>> +++ b/include/uapi/linux/mroute.h
>> @@ -28,12 +28,17 @@
>>  #define MRT_TABLE	(MRT_BASE+9)	/* Specify mroute table ID		*/
>>  #define MRT_ADD_MFC_PROXY	(MRT_BASE+10)	/* Add a (*,*|G) mfc entry	*/
>>  #define MRT_DEL_MFC_PROXY	(MRT_BASE+11)	/* Del a (*,*|G) mfc entry	*/
>> -#define MRT_MAX		(MRT_BASE+11)
>> +#define MRT_FLUSH	(MRT_BASE+12)	/* Flush all multicast entries and vifs	*/
> nit: "Flush all mfc entries and/or vifs" ?
> 
>> +#define MRT_MAX		(MRT_BASE+12)
>>  
>>  #define SIOCGETVIFCNT	SIOCPROTOPRIVATE	/* IP protocol privates */
>>  #define SIOCGETSGCNT	(SIOCPROTOPRIVATE+1)
>>  #define SIOCGETRPF	(SIOCPROTOPRIVATE+2)
>>  
>> +/* MRT_FLUSH optional flags */
>> +#define MRT_FLUSH_ENTRIES	1	/* For flushing all multicast entries */
> Maybe MRT_FLUSH_MFC is more consistent with the previous naming (MRT_ADD_MFC, etc.)
> 
> 
> Regards,
> Nicolas
> 

