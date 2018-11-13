Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB686C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 11:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E6692245E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 11:06:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="KO4quevh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E6692245E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=natalenko.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732411AbeKMVDm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 16:03:42 -0500
Received: from vulcan.natalenko.name ([104.207.131.136]:49370 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbeKMVDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 16:03:42 -0500
Received: from mail.natalenko.name (vulcan.natalenko.name [IPv6:fe80::5400:ff:fe0c:dfa0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id B057446A454;
        Tue, 13 Nov 2018 12:06:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1542107163;
        h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references;
        bh=iBHL/qhWdCuZIXtT1w0sPoTmlSHAkAQGXv4okyewsdM=;
        b=KO4quevhNJW6iUeDcgcHgVraDXjghtd6gCUBsdNg5tIGbAAQWqt2+W843vj5dOP8soGVbx
        YrWd4J4/BUI8KTbSp7+3JGHrhT9TnTWWKr6EO60kaJd/fb5n1iOKkl4RCSkmHKLIhvFwYE
        1Yh1XO3OxTcjJ+kC4wxKJ50WS7+SGRM=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 13 Nov 2018 12:06:03 +0100
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     timofey.titovets@synesis.ru
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, nefelim4ag@gmail.com, willy@infradead.org
Subject: Re: [PATCH V3] KSM: allow dedup all tasks memory
In-Reply-To:  <<20181112231344.7161-1-timofey.titovets@synesis.ru>>
Message-ID: <b4c41073d763dc5798562233de8eaa6d@natalenko.name>
X-Sender: oleksandr@natalenko.name
User-Agent: Roundcube Webmail/1.3.8
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=arc-20170712; t=1542107163;
        h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references;
        bh=iBHL/qhWdCuZIXtT1w0sPoTmlSHAkAQGXv4okyewsdM=;
        b=PzxCQJmOqQIhxkAZ2JrIQxtV/YfioBFMsRvG5SPVsaHlnCAPO4aMGUTyKlyD8CvmU/zQ/o
        ODqbSo5hN2TBqUz5XfbZ+faCUScQ4027Gd+fgoed8Vge0cUU4n0Tdeb+X5yShHPF9CueZ0
        PSbEMDs9Gilopy3RkTUEnWbOa8NAGVw=
ARC-Seal: i=1; s=arc-20170712; d=natalenko.name; t=1542107163; a=rsa-sha256;
        cv=none;
        b=rORGO7lzrCjOQhVFrjFoZ/ke7TXFS3WnyK0M0/PELJuJDVIdLeFbCW6b5z1V9Ah+rGCHjK4Q+tdOXO4OpEuwMc+TnaytC9ED4U19AkXh2myFTgh6PHZEkqwqlcrgPJo06S7fWJ82Q08knSY+HkW4R09uBxWH4df7x5D8zJJ4ehE=
ARC-Authentication-Results: i=1;
        vulcan.natalenko.name;
        auth=pass smtp.auth=oleksandr@natalenko.name smtp.mailfrom=oleksandr@natalenko.name
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

> ksm by default working only on memory that added by
> madvise().
> 
> And only way get that work on other applications:
>   * Use LD_PRELOAD and libraries
>   * Patch kernel
> 
> Lets use kernel task list and add logic to import VMAs from tasks.
> 
> That behaviour controlled by new attributes:
>   * mode:
>     I try mimic hugepages attribute, so mode have two states:
>       * madvise      - old default behaviour
>       * always [new] - allow ksm to get tasks vma and
>                        try working on that.
>   * seeker_sleep_millisecs:
>     Add pauses between imports tasks VMA
> 
> For rate limiting proporses and tasklist locking time,
> ksm seeker thread only import VMAs from one task per loop.
> 
> Some numbers from different not madvised workloads.
> Formulas:
>   Percentage ratio = (pages_sharing - pages_shared)/pages_unshared
>   Memory saved = (pages_sharing - pages_shared)*4/1024 MiB
>   Memory used = free -h
> 
>   * Name: My working laptop
>     Description: Many different chrome/electron apps + KDE
>     Ratio: 5%
>     Saved: ~100  MiB
>     Used:  ~2000 MiB
> 
>   * Name: K8s test VM
>     Description: Some small random running docker images
>     Ratio: 40%
>     Saved: ~160 MiB
>     Used:  ~920 MiB
> 
>   * Name: Ceph test VM
>     Description: Ceph Mon/OSD, some containers
>     Ratio: 20%
>     Saved: ~60 MiB
>     Used:  ~600 MiB
> 
>   * Name: BareMetal K8s backend server
>     Description: Different server apps in containers C, Java, GO & etc
>     Ratio: 72%
>     Saved: ~5800 MiB
>     Used:  ~35.7 GiB
> 
>   * Name: BareMetal K8s processing server
>     Description: Many instance of one CPU intensive application
>     Ratio: 55%
>     Saved: ~2600 MiB
>     Used:  ~28.0 GiB
> 
>   * Name: BareMetal Ceph node
>     Description: Only OSD storage daemons running
>     Raio: 2%
>     Saved: ~190 MiB
>     Used:  ~11.7 GiB

Out of curiosity, have you compared these results with UKSM [1]?

Thanks.

-- 
   Oleksandr Natalenko (post-factum)

[1] https://github.com/dolohow/uksm
