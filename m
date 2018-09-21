Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0916C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 08:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7667021523
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 08:58:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7667021523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389502AbeIUOqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 10:46:40 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:11426 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732768AbeIUOqk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 10:46:40 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 42GnZW41R9z9ttFY;
        Fri, 21 Sep 2018 10:58:43 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id IZYLZrgJLfwN; Fri, 21 Sep 2018 10:58:43 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 42GnZW3Tjgz9ttBl;
        Fri, 21 Sep 2018 10:58:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0400A8B89C;
        Fri, 21 Sep 2018 10:58:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id LqcumXFeW_5d; Fri, 21 Sep 2018 10:58:44 +0200 (CEST)
Received: from PO15451 (unknown [172.25.231.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A41488B89D;
        Fri, 21 Sep 2018 10:58:44 +0200 (CEST)
Subject: Re: [REVIEW][PATCH 7/9] signal/poewrpc: Specialize _exception_pkey
 for handling pkey exceptions
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
References: <878t3yitze.fsf@xmission.com>
 <20180918175850.4437-7-ebiederm@xmission.com>
 <20180921185429.4cda432e@canb.auug.org.au>
From:   Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <b140e12e-e1fa-1878-16d0-531ffc821e6f@c-s.fr>
Date:   Fri, 21 Sep 2018 10:58:44 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180921185429.4cda432e@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 21/09/2018 à 10:54, Stephen Rothwell a écrit :
> Hi Eric,
> 
> On Tue, 18 Sep 2018 19:58:48 +0200 "Eric W. Biederman" <ebiederm@xmission.com> wrote:
>>
>> Now that _exception no longer calls _exception_pkey it is no longer
>> necessary to handle any signal with any si_code.  All pkey exceptions
>> are SIGSEGV with paired with SEGV_PKUERR.  So just handle
>> that case and remove the now unnecessary parameters from _exception_pkey.
>>
>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> 
> Looks fine to me (small query below).
> 
> Reviewed-by: Stephen Rothwell <sfr@canb.auug.org.au>

In the patch title, s/poewrpc/powerpc

> 
>>   	clear_siginfo(&info);
>> -	info.si_signo = signr;
>> -	info.si_code = code;
>> +	info.si_signo = SIGSEGV;
>> +	info.si_code = SEGV_PKUERR;
>>   	info.si_addr = (void __user *) addr;
>>   	info.si_pkey = key;
>>   
>> -	force_sig_info(signr, &info, current);
>> +	force_sig_info(info.si_signo, &info, current);
>                         ^^^^^^^^^^^^^
> Why not just SIGSEGV?
> 
