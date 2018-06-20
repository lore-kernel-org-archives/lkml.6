Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D63C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 04:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D2E320871
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 04:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="o+SkpKlR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D2E320871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753885AbeFTEcb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 00:32:31 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:46099 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751346AbeFTEc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 00:32:28 -0400
Received: by mail-pl0-f67.google.com with SMTP id 30-v6so1017867pld.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 21:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=7ObTd2PHAo9tmaCkOZDLvlW+5wpzi+FdtvBXUap201Y=;
        b=o+SkpKlRkv9VCJDr/G79+oWs9hRwKYrUU+c4THyPMAKXY7VJOMMZQabufDhaGuLxSt
         OhXbQkWyg76Vpxkv1jrulogCNMdLiMrlP11p3R7GFaQc0yssSSrcEWqNt2vOtSMBOnpV
         IOJBT8HBzHwTbfl2Mr5mbjYIGK1qvZ3jUwQvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=7ObTd2PHAo9tmaCkOZDLvlW+5wpzi+FdtvBXUap201Y=;
        b=N23Y4XNMRc2jap7bwHCQx/a7WgNxjCMSQJId3S+6m8fNwW+E7GGvR07wYhUkALJJ4O
         DfQuUhlsllLAaT8cmIfn413CY/EMzw2tZjtPOYDJlxVIvA3rSimAwAW529gpxwwgcEyb
         DfsO+AmcAS5IOuH3n9XsXmuMDkQeN4CSu+LFuDU9n7+ItzxFsT1wENlgMW/z4vqEgBNt
         nxrMXF8gyDh3s4f4U5NJ1NtzoqWGN5/UajCyh/3mJvOLBzEIlqx1hAes94wO2wNxDYOz
         0Sh1oCKFZjvjiU5NmOJCSGMoCgdrKcfg55QSEB66NsxAQS0S3FW8iFlLvCVKAWky/ZNp
         9MMA==
X-Gm-Message-State: APt69E0WC5ORMzjPutrusCF5stVCd4IZwrnBkMhS67+DZhStTFGCoAw9
        9nxLhq0Oe/LPLMmKMhtDbJZhXA==
X-Google-Smtp-Source: ADUXVKJ1K7VrKBTvTIVLDgLR1D2ugJaxZPHgTF/GlYYj1RjVO860lMmdXFUChppc4DgyJP3bODlA/Q==
X-Received: by 2002:a17:902:583:: with SMTP id f3-v6mr17799405plf.115.1529469148161;
        Tue, 19 Jun 2018 21:32:28 -0700 (PDT)
Received: from localhost ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id m7-v6sm1226510pgr.5.2018.06.19.21.32.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 21:32:27 -0700 (PDT)
Date:   Tue, 19 Jun 2018 21:32:27 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Alistair Strachan <astrachan@google.com>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>, devel@driverdev.osuosl.org,
        kernel-team@android.com
Subject: Re: [PATCH 1/2] staging: android: ashmem: Remove use of unlikely()
Message-ID: <20180620043227.GB10888@joelaf.mtv.corp.google.com>
References: <20180620005735.219840-1-astrachan@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180620005735.219840-1-astrachan@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 05:57:34PM -0700, Alistair Strachan wrote:
> There is no speed difference, and it makes the code harder to read.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Arve Hjønnevåg <arve@android.com>
> Cc: Todd Kjos <tkjos@android.com>
> Cc: Martijn Coenen <maco@android.com>
> Cc: devel@driverdev.osuosl.org
> Cc: linux-kernel@vger.kernel.org
> Cc: kernel-team@android.com
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Alistair Strachan <astrachan@google.com>

Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

- Joel

