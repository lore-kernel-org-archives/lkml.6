Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D1FC43334
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 18:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2B722151C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 18:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="gQ5pcsHZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2B722151C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbeHXW0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 18:26:40 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:41624 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbeHXW0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 18:26:39 -0400
Received: by mail-io0-f194.google.com with SMTP id q4-v6so7933413iob.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 11:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7falQ6vJZgobqKYv+GpbnoF18oJtcIry5jMkzy8aWT0=;
        b=gQ5pcsHZ6Zoy77qt7qsu4VPz+77OHYtqYq69MPjKFy1gy6ViPJyT9algzqsR2bYeYV
         YqzFPc/b6NmfDgXz/Fy4ZU7tQSKsl8VLwgCh2ScEQds3kkTZvz8a+pgHAHCf0e9S5rTk
         yaJ7MxhTr7b9LIwvo3v8nPsgUxUpzGFfGogY4f8XP7YoxUaERfzT8Xz2i/glwArITz+J
         D9L5J1a7yAhwh5r0iPEu8bo8HRG4Kh45B2Jh5IAl5th6s0ymHBUKs+jDQvPyzRXzQCVb
         6y2ghWPTN0Ir3md1t4hSXiVrP6mGANE8KFWv9xMp/ZQMLzT9dWCRACE61XDHsOBspnFl
         ErrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7falQ6vJZgobqKYv+GpbnoF18oJtcIry5jMkzy8aWT0=;
        b=Csov3LUQ59kEb1La/t3uIJELJXZ240eq8MbPlFehuwSbXeVZnTF3tq4g3Vf9MfC4yP
         FU/B4hD2oZqL8N94+P8sKI6URpLEvFmcpiHOA3cQSSol7GdVejKu/2ZiziqeY9toX9j6
         0oJTZCnmIKzT4GiAOTCSsECVd6uKmT1FuhvUUI1E/1KZlBs6WiOAttKu/zQ2aGHwzfsF
         yU7/Zb0XdaEfwuR8aifxkXAOKdWY0BcZfFSNsa+Bkar3G9GgozqS6q8X1FJ6cDN8PaM/
         05v4vr/hV/dlzlZIv5ZbrQaYrNJKnGTaHl5Nx62SxvyDJSPzX+E+hBLxl+87ji/57uE1
         lLVg==
X-Gm-Message-State: APzg51AZ74h2IrQXPmzjarTfk09FyaJ86gB+loc7hrZMNj7MFsSN2qsi
        xWyCJXmmUPxUFj5PUKyQPxoLuA==
X-Google-Smtp-Source: ANB0VdZkRbGL3PFLQkb5xjWyYnu8xYAHvHWeDZNaKwJueVnn2ZVRd3htS15rBrNEREkongVyPRBy6g==
X-Received: by 2002:a6b:9108:: with SMTP id t8-v6mr2269177iod.260.1535136648194;
        Fri, 24 Aug 2018 11:50:48 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id n1-v6sm2615008ioh.31.2018.08.24.11.50.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Aug 2018 11:50:46 -0700 (PDT)
Subject: Re: [PATCH] blk-wbt: get back the missed wakeup from __wbt_done
To:     Anchal Agarwal <anchalag@amzn.com>
Cc:     fllinden@amazon.com, Jianchao Wang <jianchao.w.wang@oracle.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        anchalag@amazon.com
References: <1535029718-17259-1-git-send-email-jianchao.w.wang@oracle.com>
 <bd84ff08-b75a-0a2f-6b37-07a104452bff@kernel.dk>
 <da9458c632cb4c4695660664bf7c3fb3@EX13D13UWB002.ant.amazon.com>
 <20180823210144.GB5624@kaos-source-ops-60001.pdx1.amazon.com>
 <3eaa20ce-0599-c405-d979-87d91ea331d2@kernel.dk>
 <20180824181223.GA9049@kaos-source-ops-60001.pdx1.amazon.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <677c8648-63fd-601c-b906-40a8502f9782@kernel.dk>
Date:   Fri, 24 Aug 2018 12:50:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180824181223.GA9049@kaos-source-ops-60001.pdx1.amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/18 12:12 PM, Anchal Agarwal wrote:
> That's totally fair. As compared to before the patch it was way too high
> and my test case wasn't even running due to the thunderign herd issues and
> queue re-ordering. Anyways as I also mentioned before 10 times 
> contention is not too bad since its not really affecting much the number of
> files read in my applciation. Also, you are right waking up N tasks seems 
> plausible. 

OK, I'm going to take that as a positive response. I'm going to propose
the last patch as the final addition in this round, since it does fix a
gap in the previous. And I do think that we need to wake as many tasks
as can make progress, otherwise we're deliberately running the device at
a lower load than we should.

> My application is somewhat similar to database workload. It does uses fsync 
> internally also. So what it does is it creates files of random sizes with 
> random contents. It stores the hash of those files in memory. During the 
> test it reads those files back from storage and checks their hashes. 

How many tasks are running for your test?

-- 
Jens Axboe

