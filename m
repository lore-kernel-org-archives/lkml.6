Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 469FCC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AB3D2082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hpQh75id"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AB3D2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729811AbeKCEKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:10:01 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40622 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbeKCEJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:09:58 -0400
Received: by mail-wm1-f68.google.com with SMTP id b203-v6so2729959wme.5
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 12:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mqvQJf3EAaYgaEzR8sELeEV4YOnISCnou+fxH1bhvJI=;
        b=hpQh75idg9kZ3XNdSkFsr+tj0unorytu0BXxc/XAujlr0yKnI/6vebnRTM6WKBilvL
         vy8gTMBvQSX2MwVZYD9QXszUl8pP7tDUkIg4Yrq6QjF6WL6y+yVC7J9fMaBCeTOB+7dE
         VZ0CT+LEU2CLXg+ommEgW7ONzQ6IJPTi5XlaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mqvQJf3EAaYgaEzR8sELeEV4YOnISCnou+fxH1bhvJI=;
        b=aFo/kqp782gPfzPRZ8ku9X+albBph0lCmXNvljZ1NUCg4srqwtMN0YjritynL7nIWL
         Ig1RnwYISmnIAqYZpqY+2ai9a2GvJF9hHC5IDyCj/hJpprD1Klw6Sz0MOxl9zkv4q+rJ
         lgqContkVzDonamTHlRVEFXAyAZXhCHPE7VxsDbBgFG2DZ2uXHCY7J4MTALsSRCobRM+
         viVNbjBzPGpL3swwhI4pn2DGA6SuwgJ21AltaxUQ+nxjMf1daHeV3mNhPCar03vQLc4e
         26N0eAGaNxIDoR9CKv+zutDV5i3dlqnMJembOJJJoO91RnCfsSKTmLjrFV7eJmKL6/TE
         i32w==
X-Gm-Message-State: AGRZ1gLbN4oDttBKqVk+Ekg2Bd5vni8gfgwy4HoQt5//s2qisJEVG9M/
        KDUxqbVGHbYxhxn+lbOmhxUMTjxmDT7si97F+vLtBA==
X-Google-Smtp-Source: AJdET5eMNGvxBo++b+GdEgBVEr0ImEPbda2kpXbJiwZ5JlVLTXfdrsETmFK8tr9y2EOrS6Gdf89a2HfCtgR2NkjNshs=
X-Received: by 2002:a1c:603:: with SMTP id 3-v6mr163246wmg.64.1541185297362;
 Fri, 02 Nov 2018 12:01:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:4054:0:0:0:0:0 with HTTP; Fri, 2 Nov 2018 12:01:36 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.10.1811011454430.23412@lmark-linux.qualcomm.com>
References: <alpine.DEB.2.02.1802282111320.22860@lmark-linux.qualcomm.com>
 <b1479541-13bd-85ea-f9c7-25264c91f9b9@redhat.com> <alpine.DEB.2.02.1803081635170.20592@lmark-linux.qualcomm.com>
 <alpine.DEB.2.10.1811011454430.23412@lmark-linux.qualcomm.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Fri, 2 Nov 2018 12:01:36 -0700
Message-ID: <CALAqxLXzVna9BG8OJhTtTjcSiy4VbJ27nBOv4fKXoMnzc4xBgw@mail.gmail.com>
Subject: Re: [RFC PATCH v2] android: ion: How to properly clean caches for
 uncached allocations
To:     Liam Mark <lmark@codeaurora.org>
Cc:     Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>, devel@driverdev.osuosl.org,
        Martijn Coenen <maco@android.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Todd Kjos <tkjos@android.com>,
        Arve Hjonnevag <arve@android.com>,
        linaro-mm-sig@lists.linaro.org,
        Beata Michalska <Beata.Michalska@arm.com>,
        Matt Szczesiak <matt.szczesiak@arm.com>,
        Anders Pedersen <Anders.Pedersen@arm.com>,
        John Reitan <John.Reitan@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 1, 2018 at 3:15 PM, Liam Mark <lmark@codeaurora.org> wrote:
> Based on the suggestions from Laura I created a first draft for a change
> which will attempt to ensure that uncached mappings are only applied to
> ION memory who's cache lines have been cleaned.
> It does this by providing cached mappings (for uncached ION allocations)
> until the ION buffer is dma mapped and successfully cleaned, then it drops
> the userspace mappings and when pages are accessed they are faulted back
> in and uncached mappings are created.
>
> This change has the following potential disadvantages:
> - It assumes that userpace clients won't attempt to access the buffer
> while it is being mapped as we are removing the userpspace mappings at
> this point (though it is okay for them to have it mapped)
> - It assumes that kernel clients won't hold a kernel mapping to the buffer
> (ie dma_buf_kmap) while it is being dma-mapped. What should we do if there
> is a kernel mapping at the time of dma mapping, fail the mapping, warn?
> - There may be a performance penalty as a result of having to fault in the
> pages after removing the userspace mappings.
>
> It passes basic testing involving reading writing and reading from
> uncached system heap allocations before and after dma mapping.
>
> Please let me know if this is heading in the right direction and if there
> are any concerns.
>
> Signed-off-by: Liam Mark <lmark@codeaurora.org>


Thanks for sending this out! I gave this a whirl on my HiKey960. Seems
to work ok, but I'm not sure if the board's usage benefits much from
your changes.

First, ignore how crazy overall these frame values are right off, we
have some cpuidle/cpufreq issues w/ 4.14 that we're still sorting out.

Without your patch:
default-jankview_list_view,jankbench,1,mean,0,iter_10,List View
Fling,48.1333678017,
default-jankview_list_view,jankbench,2,mean,0,iter_10,List View
Fling,55.8407417387,
default-jankview_list_view,jankbench,3,mean,0,iter_10,List View
Fling,43.88160374,
default-jankview_list_view,jankbench,4,mean,0,iter_10,List View
Fling,42.2606222784,
default-jankview_list_view,jankbench,5,mean,0,iter_10,List View
Fling,44.1791721797,
default-jankview_list_view,jankbench,6,mean,0,iter_10,List View
Fling,39.7692731775,
default-jankview_list_view,jankbench,7,mean,0,iter_10,List View
Fling,48.5462154074,
default-jankview_list_view,jankbench,8,mean,0,iter_10,List View
Fling,40.1321166548,
default-jankview_list_view,jankbench,9,mean,0,iter_10,List View
Fling,48.0163174397,
default-jankview_list_view,jankbench,10,mean,0,iter_10,List View
Fling,51.1971686844,


With your patch:
default-jankview_list_view,jankbench,1,mean,0,iter_10,List View
Fling,43.3983274772,
default-jankview_list_view,jankbench,2,mean,0,iter_10,List View
Fling,45.8456678409,
default-jankview_list_view,jankbench,3,mean,0,iter_10,List View
Fling,42.9609507211,
default-jankview_list_view,jankbench,4,mean,0,iter_10,List View
Fling,48.602186248,
default-jankview_list_view,jankbench,5,mean,0,iter_10,List View
Fling,47.9257658765,
default-jankview_list_view,jankbench,6,mean,0,iter_10,List View
Fling,47.7405384035,
default-jankview_list_view,jankbench,7,mean,0,iter_10,List View
Fling,52.0017667611,
default-jankview_list_view,jankbench,8,mean,0,iter_10,List View
Fling,43.7480812349,
default-jankview_list_view,jankbench,9,mean,0,iter_10,List View
Fling,44.8138758796,
default-jankview_list_view,jankbench,10,mean,0,iter_10,List View
Fling,46.4941804068,


Just for reference, compared to my earlier patch:
default-jankview_list_view,jankbench,1,mean,0,iter_10,List View
Fling,33.8638094852,
default-jankview_list_view,jankbench,2,mean,0,iter_10,List View
Fling,34.0859500474,
default-jankview_list_view,jankbench,3,mean,0,iter_10,List View
Fling,35.6278973379,
default-jankview_list_view,jankbench,4,mean,0,iter_10,List View
Fling,31.4999822195,
default-jankview_list_view,jankbench,5,mean,0,iter_10,List View
Fling,40.0634874771,
default-jankview_list_view,jankbench,6,mean,0,iter_10,List View
Fling,28.0633472181,
default-jankview_list_view,jankbench,7,mean,0,iter_10,List View
Fling,36.0400585616,
default-jankview_list_view,jankbench,8,mean,0,iter_10,List View
Fling,38.1871234374,
default-jankview_list_view,jankbench,9,mean,0,iter_10,List View
Fling,37.4103602014,
default-jankview_list_view,jankbench,10,mean,0,iter_10,List View
Fling,40.7147881231,


Though I'll spend some more time looking at it closer.

thanks
-john
