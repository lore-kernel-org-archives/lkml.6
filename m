Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FFBD16256E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18206204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h8m2Crm3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18206204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730553AbeG3TJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 15:09:50 -0400
Received: from mail-yw0-f181.google.com ([209.85.161.181]:46589 "EHLO
        mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbeG3TJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 15:09:50 -0400
Received: by mail-yw0-f181.google.com with SMTP id e23-v6so4663743ywe.13;
        Mon, 30 Jul 2018 10:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CCE6KX//meQ8bQy5j1CjC8o51k5KPe9sjvMsF7iKKS4=;
        b=h8m2Crm3BCgibFP9p4DvycFrP/b59sXahia1hhaaLuLeB0nqwdygrO/upFcyYdDEQQ
         4QxLd4hqWXwjA7Zxwy8YQuQ3XRkTpk8WK3HqD+ohZie2oTO6SOqPcd1EL2ZbhEHfLFNe
         2ntY/l04y3b1P1/2dz/tiII/Z5z3R3pDlITs0xj579nd17vyICCubuk/BMjCPZbDEv/b
         XZ/IW8X5iEEpxs0c7x9+Bi1q6homEhOwyMstltSyMeWQb18HTU+jfrftOitkkBBr5i8J
         4og9YO13Y5gmbHwR+Hw5nT9ZdS6Cdo09bdoi11ycpw231wIsRFeSfftsmY9YchVvA0OJ
         tRsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=CCE6KX//meQ8bQy5j1CjC8o51k5KPe9sjvMsF7iKKS4=;
        b=reHPP8eVDXDQsaVoG0b4gEr5Z2iAKp8rT4GxivfqfQ87uBp9EnkuaQCTUT6Yx1MYqH
         pw/BCio5NmwfxhnIK0fO34pDmBPEaCaSO4QOaYL5lVEyFd26fsOZ09dFq4DHj1Fglrng
         LxB1fm8DFss/tzJ1vvjMZ8EyY/NIM/mCrbQTsZsANvTQTYBg+upgI5Qhv8W25LCJeL/8
         S3/omMIePe8Uhv/7SnG0olfM0srCO4PGC65H8+drWTtQ7c2h6z4vKIygYJUhi2yKUywr
         9KBZdJEFvTU3LE/UqxsWX5dgF131hfBmbFLdGDylHQXYXVbHu64UpEad7/pZa92h5VGW
         CCXA==
X-Gm-Message-State: AOUpUlFeTeU/HI556XSEbMh+9HHePN9/LNhMRuF1iYO5cYqz8tITgQkj
        t6ph1w+O7Hqy3vc0QZl9848=
X-Google-Smtp-Source: AAOMgperuPTXcLj3s39Vv3AmUdKxQIpztv94z6XMiyOiiR0jUL7Bf9T1eW+OA8kHLY0ejhBWoQSrOw==
X-Received: by 2002:a81:a48b:: with SMTP id b133-v6mr8711262ywh.377.1532972028203;
        Mon, 30 Jul 2018 10:33:48 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::2:4bfe])
        by smtp.gmail.com with ESMTPSA id x7-v6sm5777116ywd.43.2018.07.30.10.33.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 10:33:47 -0700 (PDT)
Date:   Mon, 30 Jul 2018 10:33:45 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        rjw@rjwysocki.net, alan.cox@intel.com, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] ata: libahci: devslp fixes
Message-ID: <20180730173345.GI1206094@devbig004.ftw2.facebook.com>
References: <20180702190154.6864-1-srinivas.pandruvada@linux.intel.com>
 <9712316ab62bef25953c523bce02e260a9ea40fe.camel@linux.intel.com>
 <20180730152256.GF1206094@devbig004.ftw2.facebook.com>
 <bf4b860c-6f82-4a3f-8b81-5f5c93f4389e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf4b860c-6f82-4a3f-8b81-5f5c93f4389e@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 05:26:45PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 30-07-18 17:22, Tejun Heo wrote:
> >On Mon, Jul 30, 2018 at 08:15:47AM -0700, Srinivas Pandruvada wrote:
> >>Hi Tejan,
> >>
> >>On Mon, 2018-07-02 at 12:01 -0700, Srinivas Pandruvada wrote:
> >>>Some minor fixes to be able to correctly set devslp register
> >>>to optimize power.
> >>>
> >>>Srinivas Pandruvada (2):
> >>>   ata: libahci: Correct setting of DEVSLP register
> >>>   ata: libahci: Allow reconfigure of DEVSLP register
> >>>
> >>Are you applying this series?
> >
> >I was waiting for Hans's reviews.  Hans, what do you think?
> 
> Ah I missed that this was another series. With the caveat that
> I do not really know that much about devslp, both patches
> seem sensible to me, so both are:
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Applied 1-2 to libata/for-4.19.

Thanks.

-- 
tejun
