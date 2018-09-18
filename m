Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE4B3C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 12:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B8B92086E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 12:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FkqICS9i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B8B92086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729573AbeIRSWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 14:22:52 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:35572 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbeIRSWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 14:22:51 -0400
Received: by mail-yb1-f196.google.com with SMTP id o63-v6so743255yba.2;
        Tue, 18 Sep 2018 05:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sHgSJeeOMenDm6xzNoGJlsQeGafPsgRMMcbY9Iz2RtA=;
        b=FkqICS9ieZdE85/1WKFK5DCj6IW3xalQxM6QqXJK2zzwn1tFSWP9vUqcn3Nkh4xPnE
         aoe1DVnYBpOHmRCTeSB444lS12VDXaNRhWWYwrKZFbWgY1r+WwQFt+kPKlt0D6TGNuOm
         Sb0C8z5R4QuIQmgXcSsNUmJhogCuW8nWoNTJOm3TaiZb2B9NE8Rlx1rM8fQmrPCM+n5C
         QmdGJW0S4s6pnvh79N/c2JN9rNoynwLx8XgacwcQd4wP0Sk8beSrMAKdF5YB9avpDCDP
         VHJR2WXKOQ6fredU2JDNMbIh2Vp328XaERIJastyGs3n8SU7fnT3bk2vbB+aQEwuMzTf
         5doA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=sHgSJeeOMenDm6xzNoGJlsQeGafPsgRMMcbY9Iz2RtA=;
        b=NFz6Kf00yOgdJsRVKJChazTbRUzbafKMDfohheub8Wwas6rUn2VpezYagX+VfQ4YZf
         dVlNdUzt9f2mwiocw5gxqPQu7G3yGs5sXc0F+8mUSYPeeDkr2cIMuqVs1+DCPphyHRzy
         psbVwcr6rdIP+h4XDMUgz94q3vRwmh7IDxfzvlstgywZRC8lb9eUEo562+vEd4c/hKMr
         ecBFUdPW+u48jRlm0vdFkO28IlV7egyNADwFrsyS00cP6nyXZQ40LksBV0a6t+fKynyW
         Orf8fkdo0V3d0+lVBJhBwMmoSZ9rgk3nAFP9u7cYzwW7PdtUFBfxxQ+m9963Vw2Dixiv
         ltYw==
X-Gm-Message-State: APzg51C5iCPBu8hPuO2WDXM8Jij1vvV465ieVln5LpmPL9os21/GxfCk
        m2VFLm33EW7O2e49YTt58PE=
X-Google-Smtp-Source: ANB0VdbrxB9BVTuPEyOQ1Su/kru2cMTgP9rkEEzpzu9p7QmS+hM1BxRTLAqKumTiLNpDnDT14fAgUw==
X-Received: by 2002:a25:5942:: with SMTP id n63-v6mr12794146ybb.116.1537275024584;
        Tue, 18 Sep 2018 05:50:24 -0700 (PDT)
Received: from localhost ([2620:10d:c091:180::1:6613])
        by smtp.gmail.com with ESMTPSA id o128-v6sm816689ywe.110.2018.09.18.05.50.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Sep 2018 05:50:23 -0700 (PDT)
Date:   Tue, 18 Sep 2018 05:50:21 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 2/4] lib/percpu-refcount: introduce percpu_ref_resurge()
Message-ID: <20180918125021.GB902964@devbig004.ftw2.facebook.com>
References: <20180918101946.13329-1-ming.lei@redhat.com>
 <20180918101946.13329-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180918101946.13329-3-ming.lei@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 06:19:44PM +0800, Ming Lei wrote:
> Now percpu_ref_reinit() can only be done on one percpu refcounter when it
> drops zero. And the limit shouldn't be so strict, and it is quite
> straightforward that we can do it when the refcount doesn't drop zero
> because it is at atomic mode.
> 
> This patch introduces percpu_ref_resurge() in which the above limit is
> relaxed, so we may avoid extra change[1] for NVMe timeout's requirement.

For now,

Nacked-by: Tejun Heo <tj@kernel.org>

Please see the original discussion thread.

Thanks.

-- 
tejun
