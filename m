Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EBF5C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 434D820821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=scylladb-com.20150623.gappssmtp.com header.i=@scylladb-com.20150623.gappssmtp.com header.b="qEAh0Uqu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 434D820821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=scylladb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbeLJMtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 07:49:49 -0500
Received: from mail-wr1-f44.google.com ([209.85.221.44]:39528 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727222AbeLJMts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 07:49:48 -0500
Received: by mail-wr1-f44.google.com with SMTP id t27so10331033wra.6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 04:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=scylladb-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=XDs2DQJUSGnilMzSJhJPYQmLpzFHzLtXNZYFGFLkZqg=;
        b=qEAh0UquYOQkdyJ2qMZFbT+4y18KYs3RL+yeYabrw4kzst/Dh2yjS5Nsi2n7hBf0U6
         dKrjIJkRZrZ8yOgQVIyYEYB5z5YJOsNV/IILOailfhdfzi4D7MGKoYxk6nhtp63Nyxc6
         JT3ZB7Fu5Fs8NUCqLmhS1dqcuX0luYwMuDHUKhWRmhv+GmAF4wmp753cjPqWq6cD8pdo
         7haaGJaikI4ZyNDOnwP6K7bXKIE0WHDpBQyfHSAtjS7Zg/I4T8blVRL9IvZ6UN0KN54r
         1YR+HHJtaYtsq+xq71bxA5iyJapokv9U7OZmWNpbkSlP0Cv7hu3C2YoIppkqI07Ks/xq
         895g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=XDs2DQJUSGnilMzSJhJPYQmLpzFHzLtXNZYFGFLkZqg=;
        b=b6q6widu+NhWMDgYbhY05CKUBO7b2/eilsMt1KPuqlai/8Pb0j9Vuw08LGDEQJFeIK
         1ZMh+fYVVIjjbz8TCvUz5bVKR23ngz3EWZ/cZqhZi4tK3hkXUeirnnTmRS7/TAWb8+qj
         B5wRVedq6jabvQtGTNdOWgXTgMx5WHLJl1OeLDJpUXIkJB4bHZHWQGHeohXbIgIVAB8y
         IlPp4dQD+zUTl2/Qglo/I+hpUnVjW8QdlncPUT9nILJUowJYqSPEcPQRl+uYPtEnJMbt
         78jsqWnFiZ0z4SoVKdfFvDZs1tSlbITQrPWKnReOxkrmMYrzEYzYygDPGxjy/PI6fzBN
         RaLg==
X-Gm-Message-State: AA+aEWZJt02cmZ43uPpKDw8i2YNe36inYIWPQRHEfWiIpZQNHe3930+w
        GVrvgMBsMkfafQ44Vef26X4RBg==
X-Google-Smtp-Source: AFSGD/WRKoTUetBsCkWnwzEMHgHfkFqpGC4xj6jdbGyfjWmNArykKSBk9433oOqDH5tDxjGO3ebiVA==
X-Received: by 2002:a5d:6710:: with SMTP id o16mr9965080wru.152.1544446186829;
        Mon, 10 Dec 2018 04:49:46 -0800 (PST)
Received: from avi.cloudius-systems.com (system.cloudius-systems.com. [199.203.229.89])
        by smtp.gmail.com with ESMTPSA id 62sm10257091wra.30.2018.12.10.04.49.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 04:49:45 -0800 (PST)
Subject: Re: Spurious EIO on AIO+DIO+RWF_NOWAIT
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, linux-aio@kvack.org
References: <9bab0f40-5748-f147-efeb-5aac4fd44533@scylladb.com>
 <20181210124823.iw4mxmdqpsdfeap4@merlin>
From:   Avi Kivity <avi@scylladb.com>
Organization: ScyllaDB
Message-ID: <53c17661-4914-5266-2034-9fc447e59383@scylladb.com>
Date:   Mon, 10 Dec 2018 14:49:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181210124823.iw4mxmdqpsdfeap4@merlin>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/12/2018 14.48, Goldwyn Rodrigues wrote:
> On 13:19 09/12, Avi Kivity wrote:
>> I have an application that receives spurious EIO when running with
>> RWF_NOWAIT enabled. Removing RWF_NOWAIT causes those EIOs to disappear. The
>> application uses AIO+DIO, and errors were seen on both xfs and ext4.
>>
>>
>> I suspect the following code:
>>
>>
>> /*
>>   * Process one completed BIO.  No locks are held.
>>   */
>> static blk_status_t dio_bio_complete(struct dio *dio, struct bio *bio)
>> {
>>          struct bio_vec *bvec;
>>          unsigned i;
>>          blk_status_t err = bio->bi_status;
>>
>>          if (err) {
>>                  if (err == BLK_STS_AGAIN && (bio->bi_opf & REQ_NOWAIT))
>>                          dio->io_error = -EAGAIN;
>>                  else
>>                          dio->io_error = -EIO;
>>          }
>>
>> Could it be that REQ_NOWAIT was dropped from bio->bi_opf? or that
>> bio->bi_status got changed along the way?
>>
> I don't think REQ_NOWAIT is dropped. I am assuming bio->bi_status error
> is set differently. Is the blk queue being stopped?


Not that I know of.


> Is it possible to
> instrument the kernel in your testcase?
>

I'm happy to apply patches, or run systemtap (or similar) scripts.


