Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB873C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 07:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63BAE2157C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 07:44:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63BAE2157C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbeHXLSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 07:18:09 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37051 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727252AbeHXLSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 07:18:09 -0400
Received: by mail-wr1-f66.google.com with SMTP id u12-v6so5380649wrr.4;
        Fri, 24 Aug 2018 00:44:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:cc:references:to:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ikoF4rXltZewMvg+4nrcsDH542tblZzcuDK23C1EyYE=;
        b=WMw9eezgDdVk+IEEdthujZSyXyLx8bZlyyZzD6+QjWZq4v5TucJspYY8CftjxjE73X
         0GEBN3gyxRqrlsQQ2epgNcpIMrTMszPtpHGHsMGID4u6JMY6DTkmC2pjXTYUdI8mYB4n
         Yqi57jD3f1A9/8H2pFJGhhG4YhkfYAMXnKhrtC3TCfIcsHwVZorGYl6FEapVGMm/jsWA
         vl6WM5luUuvwtbzhEEVjeESbwaOy9qkBZii7uvgFOss7abgQb73uyQ5uJeTkhYfDEjMn
         aOwclKzRCa89t6yO1Xvob4e2HlwiA9ZhxW3/kh6AFZX1d2jAr/XT1KXwNhpxGyVRHjf3
         CyIQ==
X-Gm-Message-State: APzg51CHYuE99lrDf8Tj/lLY2W/N6zW91bavtKJxsqK4cg0I0VXC5HXL
        /Ku61iVtcVQ+CPcezgVvpktJ4zT1
X-Google-Smtp-Source: ANB0VdYo1Jq3ccWjdJC5g1OLkOtIQTdZ131q1xwwEE0jokSOJxHZd1CWoU1byA28+k5j2FasB8Z5Sw==
X-Received: by 2002:adf:fa4d:: with SMTP id y13-v6mr430720wrr.155.1535096682201;
        Fri, 24 Aug 2018 00:44:42 -0700 (PDT)
Received: from ?IPv6:2a01:4240:2e27:ad85:aaaa::70f? ([2a01:4240:2e27:ad85:aaaa::70f])
        by smtp.gmail.com with ESMTPSA id c3-v6sm8322002wrm.56.2018.08.24.00.44.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Aug 2018 00:44:41 -0700 (PDT)
Subject: Re: [PATCH v1] mm: relax deferred struct page requirements
From:   Jiri Slaby <jslaby@suse.cz>
Cc:     mhocko@kernel.org, Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        benh@kernel.crashing.org, paulus@samba.org,
        Andrew Morton <akpm@linux-foundation.org>,
        kirill.shutemov@linux.intel.com,
        Reza Arbab <arbab@linux.vnet.ibm.com>, schwidefsky@de.ibm.com,
        Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>, tglx@linutronix.de,
        linuxppc-dev@lists.ozlabs.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-s390@vger.kernel.org, mgorman@techsingularity.net
References: <20171117014601.31606-1-pasha.tatashin@oracle.com>
 <20171121072416.v77vu4osm2s4o5sq@dhcp22.suse.cz>
 <b16029f0-ada0-df25-071b-cd5dba0ab756@suse.cz>
 <CAGM2rea=_VJJ26tohWQWgfwcFVkp0gb6j1edH1kVLjtxfugf5Q@mail.gmail.com>
 <CAGM2reYcwyOcKrO=WhB3Cf0FNL3ZearC=KvxmTNUU6rkWviQOg@mail.gmail.com>
 <83d035f1-40b4-bed8-6113-f4c5a0c4d22f@suse.cz>
To:     pavel.tatashin@microsoft.com
Openpgp: preference=signencrypt
Autocrypt: addr=jslaby@suse.cz; prefer-encrypt=mutual; keydata=
 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
Message-ID: <c4d46b63-5237-d002-faf5-4e0749d825d7@suse.cz>
Date:   Fri, 24 Aug 2018 09:44:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <83d035f1-40b4-bed8-6113-f4c5a0c4d22f@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pasha.tatashin@oracle.com -> pavel.tatashin@microsoft.com

due to
 550 5.1.1 Unknown recipient address.


On 08/24/2018, 09:32 AM, Jiri Slaby wrote:
> On 06/19/2018, 09:56 PM, Pavel Tatashin wrote:
>> On Tue, Jun 19, 2018 at 9:50 AM Pavel Tatashin
>> <pasha.tatashin@oracle.com> wrote:
>>>
>>> On Sat, Jun 16, 2018 at 4:04 AM Jiri Slaby <jslaby@suse.cz> wrote:
>>>>
>>>> On 11/21/2017, 08:24 AM, Michal Hocko wrote:
>>>>> On Thu 16-11-17 20:46:01, Pavel Tatashin wrote:
>>>>>> There is no need to have ARCH_SUPPORTS_DEFERRED_STRUCT_PAGE_INIT,
>>>>>> as all the page initialization code is in common code.
>>>>>>
>>>>>> Also, there is no need to depend on MEMORY_HOTPLUG, as initialization code
>>>>>> does not really use hotplug memory functionality. So, we can remove this
>>>>>> requirement as well.
>>>>>>
>>>>>> This patch allows to use deferred struct page initialization on all
>>>>>> platforms with memblock allocator.
>>>>>>
>>>>>> Tested on x86, arm64, and sparc. Also, verified that code compiles on
>>>>>> PPC with CONFIG_MEMORY_HOTPLUG disabled.
>>>>>
>>>>> There is slight risk that we will encounter corner cases on some
>>>>> architectures with weird memory layout/topology
>>>>
>>>> Which x86_32-pae seems to be. Many bad page state errors are emitted
>>>> during boot when this patch is applied:
>>>
>>> Hi Jiri,
>>>
>>> Thank you for reporting this bug.
>>>
>>> Because 32-bit systems are limited in the maximum amount of physical
>>> memory, they don't need deferred struct pages. So, we can add depends
>>> on 64BIT to DEFERRED_STRUCT_PAGE_INIT in mm/Kconfig.
>>>
>>> However, before we do this, I want to try reproducing this problem and
>>> root cause it, as it might expose a general problem that is not 32-bit
>>> specific.
>>
>> Hi Jiri,
>>
>> Could you please attach your config and full qemu arguments that you
>> used to reproduce this bug.
> 
> Hi,
> 
> I seem I never replied. Attaching .config and the qemu cmdline:
> $ qemu-kvm -m 2000 -hda /dev/null -kernel bzImage
> 
> "-m 2000" is important to reproduce.
> 
> If I disable CONFIG_DEFERRED_STRUCT_PAGE_INIT (which the patch allowed
> to enable), the error goes away, of course.
> 
> thanks,
> 


-- 
js
suse labs
