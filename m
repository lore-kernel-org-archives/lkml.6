Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0DA8C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 13:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64A46214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 13:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tUTl1ghM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64A46214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730255AbeKVAIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 19:08:39 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33224 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727100AbeKVAIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 19:08:39 -0500
Received: by mail-pl1-f194.google.com with SMTP id z23so5599571plo.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 05:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=N53r5quA7Risz66wOdqYRld2kPWf4xgxHHUwFWN87so=;
        b=tUTl1ghM2cPduhFIvyK3uXoB7Aboyb2l1hy6lQMMctpXexzSiaRdogwqgweHX1BdP8
         kL6Tc7fsmOwj1Ktkaz9RQ2IY69gV2hh0L0COuL+evbhVWyCo3kEWOEPdq2BZfQ2JsHy7
         1TeV6kq/BGhYf7MV8QinuJ06KKkx6gK1ds8mAgcjkURg7Mg85nu63cLdYr+s3qhQ3jyV
         r1yOOtH1hbsZJMWLAE1TrUKsYs5JofiQamtmo3xsqAo3e/OJl0Cbkbm4JEzPqDkKunZM
         BB914c4gnF07UJfSTjJhrXmqz12DoL+3V3VXwsspTNtGPn055omVRb5RF0osjdzXZUP5
         CDlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=N53r5quA7Risz66wOdqYRld2kPWf4xgxHHUwFWN87so=;
        b=guakbs+ni3RBWySh8cQPBvVa4ppeVtd2YHhgRkj1L5kvIx2M7LRfOEUj56GbQxlAqO
         iK2asuXhCWsommgD7Ga6i23UcZr7FRsAj9DU2pXpun5MjWBOoUNtIhkmtvfPTxPHbm9I
         pWcZQnhwUZn3/tSTI8OW1whrJ/DqZV3Zh1PJVQjmDiDWrBb680KDrk1CVS+b0sTVxY4M
         Iu9taaZxEizT9UCvWoVHFtaKoyjlgSJaErZ0CR/vsSD4o5gAxUjevIwiozExlfsiVUNA
         gTYSodZdc+i5F5sr+5/K8/ETHS6odVOYNdfgQIoVrA7ln03okKodz3fOGB0jua0GZb4Z
         LyDw==
X-Gm-Message-State: AGRZ1gLyGKKTW3CrmFI3kQmsrDHkt79/meiTwBGz0IUQakv1jb2aJSbT
        V1Xpy3fLTXLCFg/nzXJ2l6A=
X-Google-Smtp-Source: AJdET5fsao6cLpjXnXXX5s1NtKZhLW6Yb+kYZS0pl8ZthPbpfuke2kFfGMU5qhHVJ6avYRNiorvANg==
X-Received: by 2002:a62:3046:: with SMTP id w67-v6mr6813837pfw.177.1542807253679;
        Wed, 21 Nov 2018 05:34:13 -0800 (PST)
Received: from google.com ([122.38.223.241])
        by smtp.gmail.com with ESMTPSA id t12sm43845469pfi.45.2018.11.21.05.34.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 05:34:12 -0800 (PST)
Date:   Wed, 21 Nov 2018 05:34:08 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/6] zram: support idle page writeback
Message-ID: <20181121133408.GA103278@google.com>
References: <20181116072035.155108-1-minchan@kernel.org>
 <20181116072035.155108-5-minchan@kernel.org>
 <20181121045551.GC599@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181121045551.GC599@jagdpanzerIV>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 01:55:51PM +0900, Sergey Senozhatsky wrote:
> On (11/16/18 16:20), Minchan Kim wrote:
> > +		zram_set_flag(zram, index, ZRAM_UNDER_WB);
> > +		zram_slot_unlock(zram, index);
> > +		if (zram_bvec_read(zram, &bvec, index, 0, NULL)) {
> > +			zram_slot_lock(zram, index);
> > +			zram_clear_flag(zram, index, ZRAM_UNDER_WB);
> > +			zram_slot_unlock(zram, index);
> > +			continue;
> > +		}
> > +
> > +		bio_init(&bio, &bio_vec, 1);
> > +		bio_set_dev(&bio, zram->bdev);
> > +		bio.bi_iter.bi_sector = blk_idx * (PAGE_SIZE >> 9);
> > +		bio.bi_opf = REQ_OP_WRITE | REQ_SYNC;
> > +
> > +		bio_add_page(&bio, bvec.bv_page, bvec.bv_len,
> > +				bvec.bv_offset);
> > +		/*
> > +		 * XXX: A single page IO would be inefficient for write
> > +		 * but it would be not bad as starter.
> > +		 */
> > +		ret = submit_bio_wait(&bio);
> > +		if (ret) {
> > +			zram_slot_lock(zram, index);
> > +			zram_clear_flag(zram, index, ZRAM_UNDER_WB);
> > +			zram_slot_unlock(zram, index);
> > +			continue;
> > +		}
> 
> Just a thought,
> 
> I wonder if it will make sense (and if it will be possible) to writeback
> idle _compressed_ objects. Right now we decompress, say, a perfectly
> fine 400-byte compressed object to a PAGE_SIZE-d object and then push
> it to the WB device. In this particular case it has a x10 bigger IO
> pressure on flash. If we can write/read compressed object then we
> will write and read 400-bytes, instead of PAGE_SIZE.

Although it has pros/cons, that's the my final goal although it would
add much complicated stuffs. Sometime, we should have the feature.
However, I want to go simple one first which is very valuable, too.
