Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1EE2ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 20:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93F9C206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 20:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nsyJe1az"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93F9C206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbeKIGFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 01:05:55 -0500
Received: from mail-yw1-f51.google.com ([209.85.161.51]:34838 "EHLO
        mail-yw1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725723AbeKIGFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 01:05:54 -0500
Received: by mail-yw1-f51.google.com with SMTP id w135-v6so8540387ywd.2;
        Thu, 08 Nov 2018 12:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oFvXt1P0vn6sjABmGNaUrUlafHub2RfoXmi03uK+8m4=;
        b=nsyJe1azy7g8xkNeQnKWBS/6x1Y+xiykM9A/ifEMUFKl9tg2Rr1io4dMm+mCuY4Z3E
         f4U+AQtISuiAUwf63xbkTYq1W+nJgx7yQ56IZ5S8u0BuL0dUVjwQkqEVCtDzak/Vh5Xh
         Wt3MV56PQGBfy9gLi8DiyR1IGQSRBvhLPQrBOqZ+DFlpjhxdEKrxa1rwzGqLsOjM5azF
         rx0HO5XijYzqXJThN6qo0RKo2YEL/BeJ0bLzfxxox8PexvifGqK/NvPIM3xkeZGTiqDM
         0xm1NRao+0QCPIL+iK7Mk3F47APbv2ymemdu0AXUnYP+4dZeRehIyYyPdC/31LHO8S56
         DTzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=oFvXt1P0vn6sjABmGNaUrUlafHub2RfoXmi03uK+8m4=;
        b=ppzmQZxCkTLA/Roe8sp4N3CakFohlr0rxHbhG6JatczjpvD8bnZ/yC4mDHZIFAV4i2
         DYccYCDf95le0RoMFvNyee+Au5K4uX2YHJ0OKrdk7RS2BDRc7pLMrbD4fkppBJkwBzar
         7lsfu4sCjvdR3Jkv5Xh4rOx2QALa36JDG4ff5L8NbV5iiUvD0HUBuE/EAfMKPvUiJi3p
         WrACTybGdQmmnHhaJo4cD80hlL9N8+8sGJZGJgcmVNiTcqOrcmaLIY96FGnhAyxLNFVZ
         XOgVf6GAMnNEw/zApgLOX5vglPvtLjoxwFZdWy5N7qboaSfqVkHdyYjGDh1qlPojnkOO
         +z8g==
X-Gm-Message-State: AGRZ1gI8KX305oof768zSV6+WGB6yYHqbdWLqLGwofpZ31tLSaV8nrO6
        w0GeiYFAbD/+NjLX6ahov+4=
X-Google-Smtp-Source: AJdET5dMsqxK9bVF8Mtwgo1HosnIx3zI1dBj9gwbXPAJiXZFEMX7P6iFXm0HhkTIcJFhDW5m2HKnMA==
X-Received: by 2002:a81:ad58:: with SMTP id l24-v6mr5711350ywk.64.1541708927442;
        Thu, 08 Nov 2018 12:28:47 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::4:7f75])
        by smtp.gmail.com with ESMTPSA id o66-v6sm2259342ywo.39.2018.11.08.12.28.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 12:28:46 -0800 (PST)
Date:   Thu, 8 Nov 2018 12:28:44 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kernel-team@fb.com, pjt@google.com, luto@amacapital.net,
        Mike Galbraith <efault@gmx.de>, torvalds@linux-foundation.org,
        Roman Gushchin <guro@fb.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Tom Hromatka <tom.hromatka@oracle.com>
Subject: Re: [PATCH v15 00/12] Enable cpuset controller in default hierarchy
Message-ID: <20181108202844.GD2509588@devbig004.ftw2.facebook.com>
References: <1541689726-20088-1-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541689726-20088-1-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied to cgroup/for-4.21.

Thanks a lot, Waiman!

-- 
tejun
