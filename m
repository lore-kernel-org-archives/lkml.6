Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A218EC43612
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ED0F2070B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHjwHpO9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729548AbfAHQ2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 11:28:12 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34739 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729218AbfAHQ2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 11:28:11 -0500
Received: by mail-ed1-f68.google.com with SMTP id b3so4845673ede.1;
        Tue, 08 Jan 2019 08:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qWRbL3N32mSE6w4dNJPwmsnCu5CZYMQLMJ8ea9T1CAI=;
        b=YHjwHpO9rP7gC2YmJ7aHZkgAx4paxCZ9zZC2UwhIjiCnF6f44nTKb92BTf8TNRACtM
         xwuH8GFJ0+fRUCe/ZrjrLm/CpYATKR4TZainCrc2vhb9WIM+uCJLuPqYFQhLqM1b4E7s
         cMlNhB0g6eGkzOFiVnPQYbBs4f5XCp3mRW2FQ4QpzT7YfoW6uzDA//2OIu18lJmhISCf
         2h7R9t/zKZgn6L2GGT4NEE1mA/IuEwSt9EGG53gQhxSWq+hNFT59+pgiLpxPO7+wxDa7
         6bS+FolkjNF++OQbZFbQ7gcxSCWrQ9L52+RWPZWNPu0TXQoRdLL7VD1taFQckYUKlmTa
         3LwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=qWRbL3N32mSE6w4dNJPwmsnCu5CZYMQLMJ8ea9T1CAI=;
        b=qTevw6x7uEmiyTFnVtmTJt1DzwRJTLONQTFD9LclALHJku3OhQisYd80iabtC18+5B
         dZ6Vnu93ByNS8gQGK1dXbnI7lw9o3gayLOQLvOuxVPbU4446ywoKAxkiaslvRjbz2mZ4
         FEqH66550zEPFBAJoEkq3PqoAfHTzFPyBwQrbmSYj6owf4+sJwb3RRv899V/Q8goNG93
         HW/8r1SuDe8umQehgDbm/Kh72/olncCHUYKUClhvbTVchwrbCTaJJSz7zanYx1hp3EVo
         l1dFCQfnN/EjRHdG4buqDUMkfGWp89AFG36FkrwnzELuvVoSIx2JQcUuYK0Q3dM6xgCM
         0v6g==
X-Gm-Message-State: AJcUukdJZ0ogEI+0QsrZW6yjKsQ2xsll+AVvsDaSIrOn4/J6KPmovRDX
        u8zp47rVzQ1SaIbLxdzqhUk=
X-Google-Smtp-Source: ALg8bN4M3CFB+tuwUvspBFC6pUvXIDMR2da43xyuNJGcYeL5MULHl0I/l9Epz4HGoZr1mdZ6nHy17A==
X-Received: by 2002:a17:906:cd2:: with SMTP id l18-v6mr2390658ejh.97.1546964888289;
        Tue, 08 Jan 2019 08:28:08 -0800 (PST)
Received: from [192.168.0.61] (xd520f268.cust.hiper.dk. [213.32.242.104])
        by smtp.gmail.com with ESMTPSA id j8sm120853ede.55.2019.01.08.08.28.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 08:28:07 -0800 (PST)
Subject: Re: [PATCH] KVM: validate userspace input in
 kvm_clear_dirty_log_protect()
To:     Paolo Bonzini <pbonzini@redhat.com>, rkrcmar@redhat.com,
        kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, syzkaller@googlegroups.com
References: <20190102172937.28741-1-tomasbortoli@gmail.com>
 <99de332c-d4e3-0628-8ad1-982032e67690@redhat.com>
From:   Tomas Bortoli <tomasbortoli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=tomasbortoli@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <8418f6c8-0fc8-e22c-c39a-bfcaee7471e2@gmail.com>
Date:   Tue, 8 Jan 2019 17:28:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <99de332c-d4e3-0628-8ad1-982032e67690@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paolo,

On 1/7/19 11:42 PM, Paolo Bonzini wrote:
> On 02/01/19 18:29, Tomas Bortoli wrote:
>>  	n = kvm_dirty_bitmap_bytes(memslot);
>> +
>> +	if (n << 3 < log->num_pages || log->first_page > log->num_pages)
>> +		return -EINVAL;
>> +
> 
> This should be
> 
> 	if (log->first_page > memslot->npages ||
> 	    log->num_pages > memslot->npages - log->first_page)
> 		return -EINVAL;
> 
> i.e. the comparison should check the last page in the range, not the
> number of pages.  In addition, using "n" is unnecessary since we do have
> the memslot.  I'll do the changes myself if you prefer, but an ack would
> be nice.
> 
> 


Yeah, I agree. Thanks for the reply and sure you can do the changes, np :)

Tomas
