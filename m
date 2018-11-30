Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B47A9C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ED132082F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3CYwRj5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ED132082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbeLAG2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 01:28:41 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45753 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbeLAG2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 01:28:40 -0500
Received: by mail-qt1-f195.google.com with SMTP id e5so7105629qtr.12;
        Fri, 30 Nov 2018 11:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ilz0/qUmimrUNlOctd7nFeSe4AqHwSXOQZtfxLhHaRo=;
        b=K3CYwRj5lnidmb/Y0cjckcmJP8BOp88WLKNvydVci0XIi2Ng2pa9GH7iWLGBj8C5Ms
         Yy/a/NoFQqEft0pv63McyOryQjZMg4DmpLwkjkHVDVEBcBqPJ764E/PaNydli4WEIBg9
         OkZXtofN8wpxucNADuRrCUD5Lk+99l/EZvALPCSEccxSbacJA85G+qMIY1bngYnzr8AK
         nXiPwgiSUyhRiVN/xelL3bQTXuGKt+J663XSRr4R7k2W2Tu/N1DkYCrQHmfj4d1KOFi9
         2nMyZ+FplfWqZhTWgIx7qRwe5S/PDzQ2Uy8vekZGzMIsCeGN1xoCEmlZTr8/iU6+br/H
         86Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ilz0/qUmimrUNlOctd7nFeSe4AqHwSXOQZtfxLhHaRo=;
        b=Sxl1dYuFI5fgSpzwkEv+qJzpq2QlC+GOSzlYfL82Ls95JDYXQ8Moo/FAzWmZsNhIDl
         QIsihR5tVD+qCEywVHJvJ38dTMslrAnmlsca3dK7SXe4jpJ+wTWRT3OSHrgeFLirxWsf
         7Bl1bzgT3/JssRFeu2ZsDNguOJwcRFUAWsh+Kuk5uvhsl/74li359RFLEe8mS7eu1gsj
         0IPk5/oCY7mgSIcCFuSIiandiFklbRm914/M4NMKx+A4Oik0gbSJECtOlW7Y/qwcQ+Yg
         mhZxsi5m0Ya5KtA0zShmvW6HZgZak/k6HMJkv01FPjOqFCRrSwWM3/rR0m9ol/Rw25nm
         V0NA==
X-Gm-Message-State: AA+aEWb0e3FWWC7+trf8C7BjNLPvkVPa3EK+Hxb5bjAKGJ9mShiTfEKL
        PE0sVW0imhilwEK3b2AB5XU=
X-Google-Smtp-Source: AFSGD/XsK+ulmlZZWPrpS5+2le0B2jhS/yLSSoCgnywfAu0v4z/WJs1g3qA4iF5UeIcN09r3Y+jAHw==
X-Received: by 2002:a0c:8ae3:: with SMTP id 32mr6705273qvw.27.1543605502738;
        Fri, 30 Nov 2018 11:18:22 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::5:51cf])
        by smtp.gmail.com with ESMTPSA id 21sm5461311qkr.89.2018.11.30.11.18.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 11:18:21 -0800 (PST)
Date:   Fri, 30 Nov 2018 11:18:19 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     linux-mm@kvack.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, aarcange@redhat.com,
        aaron.lu@intel.com, akpm@linux-foundation.org,
        alex.williamson@redhat.com, bsd@redhat.com,
        darrick.wong@oracle.com, dave.hansen@linux.intel.com,
        jgg@mellanox.com, jwadams@google.com, jiangshanlai@gmail.com,
        mhocko@kernel.org, mike.kravetz@oracle.com,
        Pavel.Tatashin@microsoft.com, prasad.singamsetty@oracle.com,
        rdunlap@infradead.org, steven.sistare@oracle.com,
        tim.c.chen@intel.com, vbabka@suse.cz
Subject: Re: [RFC PATCH v4 00/13] ktask: multithread CPU-intensive kernel work
Message-ID: <20181130191819.GJ2509588@devbig004.ftw2.facebook.com>
References: <20181105165558.11698-1-daniel.m.jordan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105165558.11698-1-daniel.m.jordan@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Nov 05, 2018 at 11:55:45AM -0500, Daniel Jordan wrote:
> Michal, you mentioned that ktask should be sensitive to CPU utilization[1].
> ktask threads now run at the lowest priority on the system to avoid disturbing
> busy CPUs (more details in patches 4 and 5).  Does this address your concern?
> The plan to address your other comments is explained below.

Have you tested what kind of impact this has on bandwidth of a system
in addition to latency?  The thing is while this would make a better
use of a system which has idle capacity, it does so by doing more
total work.  It'd be really interesting to see how this affects
bandwidth of a system too.

Thanks.

-- 
tejun
