Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20284C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 23:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C18C12054F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 23:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNNggnb5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C18C12054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbeIADSt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 23:18:49 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36150 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727175AbeIADSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 23:18:49 -0400
Received: by mail-pf1-f195.google.com with SMTP id b11-v6so6163050pfo.3;
        Fri, 31 Aug 2018 16:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rfQ7fOszyBR4X33vZU2tgI2PHUvxIMFVG3y/OfXq9MQ=;
        b=FNNggnb5yomOQ0mqu9hb0yDwun8qu2kojMi+naMHGeksWzHBrFOMPNmSC6cXiXLbP9
         uKo0FUNisfOWa1qeH1xmuaT06fZdHgeWtlt2LwMr0P/mRlDFRFb0y6DuUYeJmOgPa0Bt
         UhSkwUU+5xEsrDFz+yAyASKEtXVgj4R5o1OK9h+yc/Ph7PpbT5E0SfknkmSCFQkZpcHB
         3vLllZtIntYjPI8NpaF3cqxkcaJWbXUGOFo5lbIVvahMvfDoHmFbiiNzNm7acRcKHIHE
         6FU5g+7xkea1cCD9YpahXhnjHaG1DOUE2vE0lJSI0lfKZ3t0hckMpIolrA3RZwhTk5pz
         DcTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=rfQ7fOszyBR4X33vZU2tgI2PHUvxIMFVG3y/OfXq9MQ=;
        b=Qg3NkRsRAdTmpGnYEQqLJq53LUStCFBA5Rj4uYupuVgd77U4bbP2fxXcOXbsHaUp2Y
         mP1oc2//Iwyc5STNF6WK8XaPCh7uZGFHfL4d+ylS2BlwOxLVsPoQYMJlEG+QzS/CsMvw
         bGybb/IM5ICGgCl8EyFhI8lNolQNz+xi5P/tgcRHdI7tg+ZQ6/HTOp8PWr2kh9FQxCFP
         Z3ooO+Fb4bB1VmTISO0cxnMye2HAG8BY4w7O0aaeGY0YPTBKfau8PIXIu4JNsxkS2F9M
         Vl3/0ymqrmBDIPPOxWlARmeMuEf0nI0z5kUSVRJZyEahN9FaAXB5TAXlN1siFDrxgukE
         vALw==
X-Gm-Message-State: APzg51BnLb5tCt/CDJuhmS6E18198SGbS7uobSyTIL6Dzo5L56GHcgJv
        LvanQLvNaAV0fZWslekVwWM=
X-Google-Smtp-Source: ANB0Vdbi+TvwiFskOvVAU8Yn1GkPTUyvi7iTaTgKfWnnwZO5m2E0M0Agwjt+fadH46q/meDNfAv8Mg==
X-Received: by 2002:a62:d2c4:: with SMTP id c187-v6mr18155099pfg.8.1535756946414;
        Fri, 31 Aug 2018 16:09:06 -0700 (PDT)
Received: from localhost ([2620:10d:c090:180::1:a245])
        by smtp.gmail.com with ESMTPSA id m27-v6sm10299615pff.152.2018.08.31.16.09.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 16:09:05 -0700 (PDT)
Date:   Fri, 31 Aug 2018 16:09:02 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Dennis Zhou <dennisszhou@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/15] blkcg: update blkg_lookup_create to do locking
Message-ID: <20180831230902.GC1488037@devbig004.ftw2.facebook.com>
References: <20180831015356.69796-1-dennisszhou@gmail.com>
 <20180831015356.69796-6-dennisszhou@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180831015356.69796-6-dennisszhou@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 09:53:46PM -0400, Dennis Zhou wrote:
> From: "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
> 
> To know when to create a blkg, the general pattern is to do a
> blkg_lookup and if that fails, lock and then do a lookup again and if
> that fails finally create. It doesn't make much sense for everyone who
> wants to do creation to write this themselves.
> 
> This changes blkg_lookup_create to do locking and implement this
> pattern. The old blkg_lookup_create is renamed to __blkg_lookup_create.
> If a call site wants to do its own error handling or already owns the
> queue lock, they can use __blkg_lookup_create.
> 
> Signed-off-by: Dennis Zhou <dennisszhou@gmail.com>

It looks a bit weird w/o actual users, might be worthwhile to mention
that future patches will add users.

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
