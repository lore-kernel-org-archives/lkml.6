Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6708C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 15:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9205B251AE
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 15:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HsLl5+iR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9205B251AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752639AbeGBP5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 11:57:47 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:40430 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752228AbeGBP5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 11:57:46 -0400
Received: by mail-yb0-f194.google.com with SMTP id y11-v6so1767784ybm.7
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 08:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nlk2Nk/jwN5ijD0j7V5N/kiPXTQfYOFZN3IW4VVZvMg=;
        b=HsLl5+iRZeqxdPV12RWSeujlIDJWU9frkqqFtZwSMxBtwZEfly/4ThKMH2+sPnFDHe
         E76/ep2ovVA9Qaqi5xAeXsSkCFRSOgqhTfLQ+io8mffzOHTLzuB5dpiDvgnLwCzjk63t
         upjvzc95/f1cm7zHcUpQs9MMpIC6oxNaijz/+Kesu/O0uWKIzfkH36cCYiGGtkL8sfOe
         TOe7JiRDBRIhAoVotrljCPFy1h/IyAMz6TvA+MmqX2NgIKmQswYmBA/wQ3v4bxn6QhU6
         wrrU3ulzvDSLtirtqdsz5+rRF69Cbc86szJdCLVI80KAIPwniaOtzUClmY9Kf7J8Hp3s
         2fbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=nlk2Nk/jwN5ijD0j7V5N/kiPXTQfYOFZN3IW4VVZvMg=;
        b=BHqtcq7KtjY6wYs98YY6mPD/L/u0P47MWNkmvmZ/hYiAulzlWck6BGuhn44JAu2Oz8
         8hkrsbwld/bgnw4q4cFY+UEg7Xb9b5E0B4WaAnrImqpExhKsGDWWss/mOBwYnq3yU89n
         pwjjtrONCjd9T9J5J6TGt5AxEpMii3RU3uj/YwJP4K/lpUOm8klG/Xslf5CLUAkRqCMa
         o3piBrncA3AI1INlG4J4DDo3ZOtKnOGvRq+hXg+RtskwDRVnstebfAPI3yX16X666nLZ
         bWQhHPfPrpz2bBXnm8UpC5zo90MouK696dZP4cKTqPuFROtXTm7rqusHrdpUbIdg4U49
         Q1gQ==
X-Gm-Message-State: APt69E2jqJZIpe0BjtjIThtqMaX4eCaISm9zatdVuxxwZ8dCO1TpBRwn
        FJUCktIWEVnbbRtGxuahWDD59eUr
X-Google-Smtp-Source: AAOMgpcwz+j6OIIX5ZDKbHVrGrfEcJcCSOepqICJ6kjHn1hhiBR/GQuDg/v6MYCAHVtfZAjDyBtj0g==
X-Received: by 2002:a25:6b0d:: with SMTP id g13-v6mr11606123ybc.75.1530547065322;
        Mon, 02 Jul 2018 08:57:45 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::2b6f])
        by smtp.gmail.com with ESMTPSA id g84-v6sm3411946ywg.98.2018.07.02.08.57.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 08:57:44 -0700 (PDT)
Date:   Mon, 2 Jul 2018 08:57:43 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Greg Thelen <gthelen@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] writeback: update stale account_page_redirty() comment
Message-ID: <20180702155743.GE533219@devbig577.frc2.facebook.com>
References: <20180625171526.173483-1-gthelen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180625171526.173483-1-gthelen@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 10:15:26AM -0700, Greg Thelen wrote:
> commit 93f78d882865 ("writeback: move backing_dev_info->bdi_stat[] into
> bdi_writeback") replaced BDI_DIRTIED with WB_DIRTIED in
> account_page_redirty().  Update comment to track that change.
>   BDI_DIRTIED => WB_DIRTIED
>   BDI_WRITTEN => WB_WRITTEN
> 
> Signed-off-by: Greg Thelen <gthelen@google.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
