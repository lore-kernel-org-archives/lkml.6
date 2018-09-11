Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D5BC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 13:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6975020880
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 13:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VkqyTVsL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6975020880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbeIKSsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 14:48:05 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:38585 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbeIKSsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 14:48:04 -0400
Received: by mail-yw1-f68.google.com with SMTP id n21-v6so9219562ywh.5;
        Tue, 11 Sep 2018 06:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=n+RgB6svcO4h1dI5nJr0LiCHnWFHoVGx2wIvkfeP5T0=;
        b=VkqyTVsLu4w+7A3y5i/AbEqldui/kozADb7qL3n5CX0eThMnC5+948ChZS6GMte/U5
         ++6VxVHDNY1cR18dcYITMtRomhfYywen97mF1tGQeUYCg4iNLCgZEKfTYOJiNiiEsV99
         5hnO99zqzWC1wOzB0MMKiX4ojwyFuivmvmRUzPw14k8qAX4jMPD1aA1t1Np8iIebp4oI
         VO0sBn5ip7CnTraj6bO41+6550v00W+qcsGtzbW/7wPkFmXWssL/zc+QWtj+Dn7FzDDx
         4mMxes0l4GYtT4GIVlabF93NZXHE8wAjS2gjXiGjoeEQtZ+vQ6IcFQFi8PVAcW8cqJp1
         EwiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=n+RgB6svcO4h1dI5nJr0LiCHnWFHoVGx2wIvkfeP5T0=;
        b=SnI03qHoM851pWbp2ebcpqFZ4llrjM0ghbEq14+zbp5IEa/zYnCL5AT8IHI8JhPCAg
         pqB99XajAcEe8GVTMP8TPkXf0xfkThfIojXC5eVDbbybt8Z0iWnlOtVZ+a/GXc3EdzFK
         aPEbX84ivsI4VIXlakxKy1sn1iuYkgm3TdgMPy4idT4NwOorNY/9ehTWeBfuz/6t3bbB
         P1ov7enVNBkxw3bmNT0dJgGEbKa+8ORkDdKL+9sJOaIFovJ7BPyaoT5bqD9DQS8uIgv1
         FzgsrQiyBcAhE4NVYuKulS+xFiiiBETpyP2S67kmiCtlXVM8OoX3uN1dZfakArOEEXcy
         FH1A==
X-Gm-Message-State: APzg51BaAEPeK+QIqpe96bLUnXF+SzA+EZnnSJ2xqvqs4Btu2KvWgSws
        b1lj6hzNGU/00jU0xC240Ok=
X-Google-Smtp-Source: ANB0VdZDMuB18E1FPkPkNNdTTuXKdvjWAzUUokoAXy66tZoJ4FS+Tr4ewwgdr01hvoR85AZ0871VMA==
X-Received: by 2002:a81:2a0a:: with SMTP id q10-v6mr12746841ywq.159.1536673718698;
        Tue, 11 Sep 2018 06:48:38 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::1:6304])
        by smtp.gmail.com with ESMTPSA id o193-v6sm7977941ywd.84.2018.09.11.06.48.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 06:48:37 -0700 (PDT)
Date:   Tue, 11 Sep 2018 06:48:36 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] percpu-refcount: relax limit on percpu_ref_reinit()
Message-ID: <20180911134836.GG1100574@devbig004.ftw2.facebook.com>
References: <20180909125824.9150-1-ming.lei@redhat.com>
 <20180910164920.GE1100574@devbig004.ftw2.facebook.com>
 <20180911000049.GB30977@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180911000049.GB30977@ming.t460p>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Ming.

On Tue, Sep 11, 2018 at 08:00:50AM +0800, Ming Lei wrote:
> > > @@ -357,10 +349,11 @@ EXPORT_SYMBOL_GPL(percpu_ref_kill_and_confirm);
> > >  void percpu_ref_reinit(struct percpu_ref *ref)
> > >  {
> > >  	unsigned long flags;
> > > +	unsigned long __percpu *percpu_count;
> > >  
> > >  	spin_lock_irqsave(&percpu_ref_switch_lock, flags);
> > >  
> > > -	WARN_ON_ONCE(!percpu_ref_is_zero(ref));
> > > +	WARN_ON_ONCE(__ref_is_percpu(ref, &percpu_count));
> > 
> > Can you elaborate this part?  This doesn't seem required for the
> > described change.  Why is it part of the patch?
> 
> The motivation of this patch is to avoid the above warning and allow
> the ref to switch back to percpu mode without dropping to zero.
> 
> That is why the check has to be changed to the above way.

So, this part seems wrong.  The function is called percpu_ref_reinit()
- the refcnt is expected to be in its initial state with just the base
ref once this function returns.  If you're removing the restriction on
when this can be called, you should also make sure that the function
actually enforces the target state.  Also, this is a separate logical
change, please put it in a separate patch.

Thanks.

-- 
tejun
