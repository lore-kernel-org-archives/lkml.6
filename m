Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D917C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 04:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 159362145D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 04:10:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 159362145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbeIYKQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 06:16:19 -0400
Received: from mail-pg1-f170.google.com ([209.85.215.170]:35903 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727045AbeIYKQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 06:16:19 -0400
Received: by mail-pg1-f170.google.com with SMTP id d1-v6so10489638pgo.3;
        Mon, 24 Sep 2018 21:10:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CBGlSRrX+tA40jmTyBQDOftMDMzSClEQD9uteDl9b5Y=;
        b=F2QEDEW0nR5OpKk1oWUE65gnRYOkmwmNQSj37KpsbrCRE1A9Pm14M4C0+LsVuPU2bO
         slg62lH6mxHP6BMCKaoDeRCH+8R0oA/+6Li3IWgGJgds4igln7PQIOOyEBjQf8MJbXIx
         xUxNnzHeRU9HezV9VJj1ITc7CEJCg16M1C1AHV9DCuuhNT/FbFoGnoJ6vvESRI5GBDDu
         uaAp7AbU8123vZvre6H14mZ9xC40snbDN6qxH8/c8sPtgUpS2HscNU5decapyjU9bE4n
         CEC/f4W6ZKK6VYQPMIO40nbtC5/alv4cdsGMV7Ja23l1/AtRziDXpWhsfk5qXDlM5ZGu
         0jOw==
X-Gm-Message-State: ABuFfohnfmUTnIFk3BoIQ8ToIKBQHN5EOEXjZsICrkdk661+ljvABMeJ
        7sAfJIMEvWV/K+90zvLfF7E=
X-Google-Smtp-Source: ACcGV62ueP2XpJ2SNQv9iGheAM+OWj9mk7pFJRhoa6aPiW9Nod6V2UD/MRhwOWddG54baF3WUqRk9g==
X-Received: by 2002:a17:902:5ac9:: with SMTP id g9-v6mr1582815plm.311.1537848646312;
        Mon, 24 Sep 2018 21:10:46 -0700 (PDT)
Received: from asus.site ([2601:647:4601:42b4:3842:3e31:3bb6:cf62])
        by smtp.googlemail.com with ESMTPSA id w22-v6sm1036607pgm.1.2018.09.24.21.10.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 21:10:44 -0700 (PDT)
Subject: Re: block: DMA alignment of IO buffer allocated from slab
To:     Matthew Wilcox <willy@infradead.org>,
        Ming Lei <ming.lei@redhat.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Ming Lei <tom.leiming@gmail.com>,
        linux-block <linux-block@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "open list:XFS FILESYSTEM" <linux-xfs@vger.kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Lameter <cl@linux.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <38c03920-0fd0-0a39-2a6e-70cd8cb4ef34@virtuozzo.com>
 <20a20568-5089-541d-3cee-546e549a0bc8@acm.org>
 <12eee877-affa-c822-c9d5-fda3aa0a50da@virtuozzo.com>
 <1537801706.195115.7.camel@acm.org>
 <c844c598-be1d-bef4-fb99-09cf99571fd7@virtuozzo.com>
 <1537804720.195115.9.camel@acm.org>
 <10c706fd-2252-f11b-312e-ae0d97d9a538@virtuozzo.com>
 <1537805984.195115.14.camel@acm.org>
 <20180924185753.GA32269@bombadil.infradead.org>
 <20180925001615.GA14386@ming.t460p>
 <20180925032826.GA4110@bombadil.infradead.org>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <4a19ac2f-82c1-db55-9b93-4005ace5e2fe@acm.org>
Date:   Mon, 24 Sep 2018 21:10:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180925032826.GA4110@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/24/18 8:28 PM, Matthew Wilcox wrote:
> [ ... ] Because if we have to
> round all allocations below 64 bytes up to 64 bytes, [ ... ]
Have you noticed that in another e-mail in this thread it has been 
explained why it is not necessary on x86 to align buffers allocated by 
kmalloc() on a 64-byte boundary even if these buffers are used for DMA?

Bart.
