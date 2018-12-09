Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6BC5C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 11:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61A8420661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 11:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=scylladb-com.20150623.gappssmtp.com header.i=@scylladb-com.20150623.gappssmtp.com header.b="qtqb8b7m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61A8420661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=scylladb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbeLILT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 06:19:56 -0500
Received: from mail-wr1-f51.google.com ([209.85.221.51]:44415 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbeLILTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 06:19:55 -0500
Received: by mail-wr1-f51.google.com with SMTP id z5so7684154wrt.11
        for <linux-kernel@vger.kernel.org>; Sun, 09 Dec 2018 03:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=scylladb-com.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:organization:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=Dh460xW9kcZcktjxXXqaeV2sn3YJaRvsFIigu3g9zu4=;
        b=qtqb8b7mJLu0Uuun2iacY8epunXL6jSDxEzWhENPJ2xfipjnuusxLCDprDdlUmoPHj
         HgFRacjbp+T9picVAIbb08n5hc3d2xLfEOcSt/3384l1ZJBQDzYg23AJauGslUJblq5M
         gpfhxdg7ZZAyL5iGHd+orbtaG8GsqX5NkGdrUEf8b4PG3LsO/9ZejPMr3YVzLHTTRsxC
         4HSKNB+M/j7afyDn7ybDZFiNx1p8wiiNoDVRCz3qj7wR6EaUMP3o47yAUVMutvZM8nFh
         hbgZmo8UcIoavwuBw0xeUeSUwVI9YBwi9O1WP4OWv3qz2dUu3sPWudXM/2JqfqGb0rOU
         ju5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:organization:message-id:date
         :user-agent:mime-version:content-transfer-encoding:content-language;
        bh=Dh460xW9kcZcktjxXXqaeV2sn3YJaRvsFIigu3g9zu4=;
        b=kE6+TePYhcVOttupAxw6b8DuLX2yN537l/jmzwuGD3eC64mS7CsCnH7hyHjW6SjNo9
         t0SLf9+asMGx50KbAneQ/BfCYFyxCEsJTZA4fwbYuYxu/QU4Bcl18AxbopOQmqW5Bm+3
         9lh3u/vSyT90rZpCIwaQ68qAJaZaJTgGuXo1A6VOI71+sLFiUTZ29Ojdyw3+m08VuxVC
         HWYj6oNMGi41jTRTLItm1TofooPO6FHVF9TkDn+5iFau2vwJ68JBn87SuMGsjO+vZcWe
         Fd+gDgMzKJig5D7523uDK4LYxwm1wS33TaXNEd+Xv9wXNbr2WpNyZYJIU8/MaOfAPbBK
         BoOw==
X-Gm-Message-State: AA+aEWbsieUvWh9E4gBirAJOZW69QvRup2eR7/j3ZXwLX9jHIc+RTZqf
        mJXtfDmXQXCxLSWExKtKhwqz+NFofL8=
X-Google-Smtp-Source: AFSGD/XFFv4t+Au69QyIEmgRZ+QltRbIgJ8SXWCRFauWvgq81GWuP84wVN8Zt5EtRTMGxaHZj4MJ9g==
X-Received: by 2002:adf:fc89:: with SMTP id g9mr6521311wrr.96.1544354393801;
        Sun, 09 Dec 2018 03:19:53 -0800 (PST)
Received: from avi.cloudius-systems.com (system.cloudius-systems.com. [199.203.229.89])
        by smtp.gmail.com with ESMTPSA id j202sm23596138wmf.15.2018.12.09.03.19.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 03:19:52 -0800 (PST)
To:     linux-kernel <linux-kernel@vger.kernel.org>, linux-aio@kvack.org,
        Goldwyn Rodrigues <rgoldwyn@suse.de>
From:   Avi Kivity <avi@scylladb.com>
Subject: Spurious EIO on AIO+DIO+RWF_NOWAIT
Organization: ScyllaDB
Message-ID: <9bab0f40-5748-f147-efeb-5aac4fd44533@scylladb.com>
Date:   Sun, 9 Dec 2018 13:19:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have an application that receives spurious EIO when running with 
RWF_NOWAIT enabled. Removing RWF_NOWAIT causes those EIOs to disappear. 
The application uses AIO+DIO, and errors were seen on both xfs and ext4.


I suspect the following code:


/*
  * Process one completed BIO.  No locks are held.
  */
static blk_status_t dio_bio_complete(struct dio *dio, struct bio *bio)
{
         struct bio_vec *bvec;
         unsigned i;
         blk_status_t err = bio->bi_status;

         if (err) {
                 if (err == BLK_STS_AGAIN && (bio->bi_opf & REQ_NOWAIT))
                         dio->io_error = -EAGAIN;
                 else
                         dio->io_error = -EIO;
         }

Could it be that REQ_NOWAIT was dropped from bio->bi_opf? or that 
bio->bi_status got changed along the way?


Reducing the test case may be a lot of work, but I can package a binary 
using docker if a reproducer is needed. Seen on 4.18.19 and 4.19.something.

