Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED88C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 400C12077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="LSjhddB4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 400C12077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbeIGVSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 17:18:25 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:33195 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbeIGVSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 17:18:25 -0400
Received: by mail-it0-f67.google.com with SMTP id j198-v6so29702ita.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 09:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tMrhodfY+7z76WiIQ2ossLOOz3NDzGek3dPmrbKHC8M=;
        b=LSjhddB4Cog+p4jMX6MvsgZjMUnMrKVPC0cHcRenLI/0UXO13mfc7ofF6nba/CtD7u
         jwMusVPMyiygWWQPs5HbWuY9vUxrDqxSjMNOwlSKYArX4uzZECGtmTTm6aPPhUGl1aX0
         9ovCkTCVvS7Fri+vfeOajeDvCO784vKUxv3j85jNce4UPZcufZ84Zfn7vW5FK0tbWclY
         EEaq1OV36MXpxc4QrrwnFERJjR2hxjLREW+3QpuU72wfEde/pN1aBl5jF0AAJl+9e8/D
         TpayGw+WeBKRjw5mrFjOuNx02k94AdOzRE5sQ7OPuAe0cY/U6lkvjb5PAPTaeww78y1j
         G7Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tMrhodfY+7z76WiIQ2ossLOOz3NDzGek3dPmrbKHC8M=;
        b=fQtQi7665ikCytsMBOpZ2HZuGb+5QX/pprtS8QhQ/K6cH+oxjzBDyJvnbmq5OA0YIJ
         uQqhAzIo8uqP5PrsbSd14tc4IjwdbtWNwVonLGt+nO00nfN/RUHMI11gKVbb6XEc6ivL
         XCbUBjwnwiJInXgWj+2MzwAmGVv0OQLle0BAup/zRWSwMvPZxuyY/IO2oR58e6RZnvMi
         czfprBHfaGYmYYyCKAy3vxvpZCUEMzZ3E0JjW4jZRf18+cQXYHMk8xRMi28iE1c8+7VL
         wn5weCPbLC6B65t2yBqnO5cc8dLgnvyV8fND94iuMbkCq3xK6hhTtS8tKrJT53G/sj++
         sxyQ==
X-Gm-Message-State: APzg51ATaKTvHaQsb2KVTteb3KNGRLEvkZf0YZGhLm0hpAgxZToYONVQ
        8VHXdqn+s5ia1qizl8nSaMIrSA==
X-Google-Smtp-Source: ANB0VdYQvAbmLcEUMvXVnJdDkK1Bv+p6JPh/Dcruwrx/ZuH8guFU9E6Z8wPTn8AKDKRXb7q0R7dCtw==
X-Received: by 2002:a02:5c8f:: with SMTP id w15-v6mr7317524jad.109.1536338201992;
        Fri, 07 Sep 2018 09:36:41 -0700 (PDT)
Received: from [192.168.1.212] (107.191.0.22.static.utbb.net. [107.191.0.22])
        by smtp.gmail.com with ESMTPSA id 84-v6sm3632810ita.35.2018.09.07.09.36.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 09:36:40 -0700 (PDT)
Subject: Re: [PATCH v3] ata: Disable AHCI ALPM feature for Ampere Computing
 eMAG SATA
To:     Suman Tripathi <stripathi@amperecomputing.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "joe@perches.com" <joe@perches.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     Open Source Submission <patches@amperecomputing.com>,
        Rameshwar Sahu <Rameshwar.Sahu@amperecomputing.com>
References: <1536257111-27948-1-git-send-email-stripathi@amperecomputing.com>
 <d3682fff-473f-021a-c805-466030b7644e@redhat.com>
 <MWHPR01MB2336EE4B6E4923C9ED851F20B3010@MWHPR01MB2336.prod.exchangelabs.com>
 <cd3e5c60-1619-9842-6198-e36fdbaa4b4b@kernel.dk>
 <MWHPR01MB2336534C2B5343D4235063E3B3000@MWHPR01MB2336.prod.exchangelabs.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <044a4fee-9d6d-371c-dc9d-a81e9512c3ba@kernel.dk>
Date:   Fri, 7 Sep 2018 10:36:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <MWHPR01MB2336534C2B5343D4235063E3B3000@MWHPR01MB2336.prod.exchangelabs.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/18 10:35 AM, Suman Tripathi wrote:
>> I can apply it manually while you work out the kinks in your email
>> setup. It might even be your company MTA mangling it, I've seen all
>> sorts of crazy like that.
>
> Thanks for the support. We are working with IT to fix this issue.

Good luck! If all else fails, there's always gmail...

In any case, queued up:

http://git.kernel.dk/cgit/linux-block/commit/?h=for-4.20/libata&id=20bdc376b427cb420836f39ee8f281ea85dbaeef

-- 
Jens Axboe

