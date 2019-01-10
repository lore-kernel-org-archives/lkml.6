Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE04C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4749920665
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="TAC164qN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730607AbfAJUoh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 15:44:37 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:47064 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729533AbfAJUog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 15:44:36 -0500
Received: by mail-qt1-f194.google.com with SMTP id y20so15269984qtm.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 12:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=LiawR9Y4EId2HmnEiWWnQVQHGhE1inrk85t73A47gpM=;
        b=TAC164qNxX6pCF470izPjspwoGJ8My6MxL3m/OGJcygmVV/w3PXD33j8Lz3o9N7c3Y
         YivpqTsPh3x/uNt83i5CdFVZBFhNVGCpqlQS91hDS/2owIoEoijbgTg1Ssw/xEb3+0l6
         GvPMle0s+pQvvgO1rnE473g9TNjJ3o5QkDkVTNcMlavW1BPuqEqwPtGRKl2v7Y3QZdVS
         rUOWSb7XhPNWGSVs+E7DQp4BRGD3KfXZZMpZPfgNkufVQbWd1UZKvkDKAiZbHmyE5e99
         C2xyoMSUIK1zFbaX0bYCbsA0WPhJXkyOpOlenpoXoxgeBpEfknRHe60avw65pSwQaFZd
         CHLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LiawR9Y4EId2HmnEiWWnQVQHGhE1inrk85t73A47gpM=;
        b=AQosrGuSA/cuBTKme1m0hrlqJtOjkeHB32TeIwM18P9KJIxPWjqmhmuphLHljgZ3HI
         Lt6Mr3ldDk+5ejjFpx3SQKMQ5NUXz6h8HcSUzjvyypxBVXuY2NycUKgTKnx4TM+SlDAn
         BhkLaKLzactwPAHOWRzJqS8WvN+iH72Dg3ehHo44x9x+nXuxRAEoT9qz4qwten534ijC
         Uj00sA+vRMqOb2uP4iGSyTEwnbrmstz2wQeRfQifmC0F5j2mRMyuw7Cas7Xa0ZMI5BKk
         LTeI31FAg8XxR7R4Iokciv4C7wkFyGaMeKtAVAioL9sv5LcLQzJnR+kpJVobbkFk9/eP
         5P/Q==
X-Gm-Message-State: AJcUukfofvBx7HcJC9TN63iHwbTJOoB6DAgUBcDgIIyBpovmKK/U2D4K
        dqDOEisRJ4raaHaUleOZYshckA==
X-Google-Smtp-Source: ALg8bN4qv1tInlK0ItvrOiYSkskO+hotyjP0WRNtOALskW1LMjNt/TePuBtZNe7vwbmBHG1CfmrB2w==
X-Received: by 2002:a37:8c04:: with SMTP id o4mr10270933qkd.165.1547153075405;
        Thu, 10 Jan 2019 12:44:35 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id y14sm47282899qky.83.2019.01.10.12.44.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 12:44:35 -0800 (PST)
Message-ID: <1547153074.6911.8.camel@lca.pw>
Subject: Re: PROBLEM: syzkaller found / pool corruption-overwrite / page in
 user-area or NULL
From:   Qian Cai <cai@lca.pw>
To:     James Bottomley <jejb@linux.ibm.com>, Esme <esploit@protonmail.ch>,
        "dgilbert@interlog.com" <dgilbert@interlog.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org
Date:   Thu, 10 Jan 2019 15:44:34 -0500
In-Reply-To: <1547150339.2814.9.camel@linux.ibm.com>
References: <t78EEfgpy3uIwPUvqvmuQEYEWKG9avWzjUD3EyR93Qaf_tfx1gqt4XplrqMgdxR1U9SsrVdA7G9XeUZacgUin0n6lBzoxJHVJ9Ko0yzzrxI=@protonmail.ch>
         <1547150339.2814.9.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-01-10 at 11:58 -0800, James Bottomley wrote:
> On Thu, 2019-01-10 at 19:12 +0000, Esme wrote:
> > Sorry for the resend some mail servers rejected the mime type.
> > 
> > Hi, I've been getting more into Kernel stuff lately and forged ahead
> > with some syzkaller bug finding.  I played with reducing it further
> > as you can see from the attached c code but am moving on and hope to
> > get better about this process moving forward as I'm still building
> > out my test systems/debugging tools.
> > 
> > Attached is the report and C repro that still triggers on a fresh git
> > pull as of a few minutes ago, if you need anything else please let me
> > know.
> > Esme
> > 
> > Linux syzkaller 5.0.0-rc1+ #5 SMP Tue Jan 8 20:39:33 EST 2019 x86_64
> > GNU/Linux
> 
> I'm not sure I'm reading this right, but it seems that a simple
> allocation inside block/scsi_ioctl.h
> 
> 	buffer = kzalloc(bytes, q->bounce_gfp | GFP_USER| __GFP_NOWARN);
> 
> (where bytes is < 4k) caused a slub padding check failure on free. 
> From the internal details, the freeing entity seems to be KASAN as part
> of its quarantine reduction (albeit triggered by this kzalloc).  I'm
> not remotely familiar with what KASAN is doing, but it seems the memory
> corruption problem is somewhere within the KASAN tracking?
> 
> I added linux-mm in case they can confirm this diagnosis or give me a
> pointer to what might be wrong in scsi.
> 

Well, need your .config and /proc/cmdline then.
