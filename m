Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0111ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 16:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82C5621528
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 16:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y5FBr9V5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82C5621528
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbeJRAQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 20:16:28 -0400
Received: from mail-qk1-f181.google.com ([209.85.222.181]:35151 "EHLO
        mail-qk1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727191AbeJRAQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 20:16:28 -0400
Received: by mail-qk1-f181.google.com with SMTP id v68-v6so16846252qka.2;
        Wed, 17 Oct 2018 09:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tASjEjfws3/XHl7yNeAIkgDk0U2NJ7AFE81cCChSL6E=;
        b=Y5FBr9V5kqJXG6zjHU7WZnmah4mhzBAjmOjq4fBTz40SQLAArQNoX8ddthirR5Szw+
         K/9RHEEx7wjVKNIovY3EyMwGiMn4t5r7aog9pAUShzYCVJljSIPHmYbhf/a7+3oU/r8i
         3HcYH/H2DLOBUy8uNcPqJXDgRWRc9CgOQq4b6JMV9K2CEiyJ4vzmU8lV0J6YvLCKlxom
         ZV3pOqbUe81cYw7K8rLEV4SDcNCs82mGhNCrrGZqAfUJW6XzO1gT9dT/oXyfRyT2aFDY
         6aPaSED7mtXLMfbEiPl+Nknsdp9WxxcKiVV6/p8LyKroJzdasbOWjViybDoT2kwfdVBz
         RkjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=tASjEjfws3/XHl7yNeAIkgDk0U2NJ7AFE81cCChSL6E=;
        b=Hkutw5eXHxF3qk0IrkIl5+DOwc2pbxTm3zi3KplWllHxXKKM1nUv3Hf0rusT+iuYKV
         giAuTe0fVnUWeQk5uAVCwX15b8f60OGRGO90OscJzagyN8R5r+j5ouwksUNlaaD8sUi3
         OtopD2u9SwHWT+K4TL0SMZ0KfQ0y4bU8mrAiQixqVdV6xMOQKEU2TUyNccqbrT3YeSAs
         7iAl5eK9mMWJ3D3YOM9bvl1XKKlrmvy1jpklVE25/VBr27l88StowxWTd3muVcnzYzCN
         NZTPkds8PpnIsk7mgbLys/mdtE+O0yzP9dwR2ctg5TUhuafHRd0Qv6RF1xQEznnZvSuu
         6/KA==
X-Gm-Message-State: ABuFfojbqK4+iy/hNq4V2w8WhdlLO2DqWpc3DVk7qYrT9R72fS3NyBGN
        Fyx1jCpuge/mgD5WlYLGy2w=
X-Google-Smtp-Source: ACcGV63osFbXALgE4HTjIU4SVKFXaLkkRgG8xlvNzsgy4EDdz6Qe5A6/w25hcVVOZbLMira16cO8Pw==
X-Received: by 2002:a37:2442:: with SMTP id w63-v6mr23537464qkg.31.1539793201076;
        Wed, 17 Oct 2018 09:20:01 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::5:5411])
        by smtp.gmail.com with ESMTPSA id s131-v6sm9230294qke.57.2018.10.17.09.20.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 09:20:00 -0700 (PDT)
Date:   Wed, 17 Oct 2018 09:19:58 -0700
From:   Tejun Heo <tj@kernel.org>
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Cgroup v2 thread mode oddity: "domain invalid" cgroup with
 threaded controller enabled
Message-ID: <20181017161958.GT270328@devbig004.ftw2.facebook.com>
References: <a4912516-8c6b-d8d3-b714-5c03bcfc5e91@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4912516-8c6b-d8d3-b714-5c03bcfc5e91@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Michael.

Sorry about the delay.

On Thu, Oct 04, 2018 at 09:40:57PM +0200, Michael Kerrisk (man-pages) wrote:
> This seems odd. x/y is now of "domain invalid" type with a controller
> enabled! This feels like a violation of the rules, since we can't
> in other circumstances do anything with a "domain invalid" cgroup
> except convert it to "threaded". In particular, we can't create
> child cgroups under a "domain invalid" cgroup, or add member processes
> to the cgroup, or *enable controllers in the cgroup*. In fact, when
> doing the 
> 
>     # echo threaded > x/z/cgroup.type
> 
> I had expected a write(2) error because the state of x/y should
> (I thought) not be permitted.

So, both the interim (before turning x/z into threaded) and final
(after) are completely fine - the cgroups are empty and whether
threaded controllers like pids are enabled or not don't really change
things that much.

Maybe it is a bit inconsistent to then deny enabling threaded
controllers on invalid domain cgroups.  We can lift that restriction
but I personally can't see why that'd be clearly better.

Thanks.

-- 
tejun
