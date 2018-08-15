Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A3EDC04AB9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 16:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 306142150C
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 16:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QCrlVX8I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 306142150C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729976AbeHOTmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 15:42:49 -0400
Received: from mail-pl0-f53.google.com ([209.85.160.53]:40992 "EHLO
        mail-pl0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729347AbeHOTms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 15:42:48 -0400
Received: by mail-pl0-f53.google.com with SMTP id w19-v6so694470ply.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 09:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DVffCJTjZVBZ/Ri7N7jhnoxsecvTmwMEKsAHPr9otZ4=;
        b=QCrlVX8Ijej8mld1vk20w7qCnmhgmzEd2PRzf8QRQHMuwaIoZFO6L96HNyOD9Dq7o+
         s2u3vF6g2/FKZHi2Z0dO9N5r5/bPnbBlQ8fd1uoANIZNy8z65LqDZo4IQRZZ32gtth4t
         Vc1wliwHI1+Eedr8+5BPilK0SD5d84hriZi+sA2BkPwLbRcs55pEboMQRWdBjtgKCZti
         rWbMK1z1KRb/8kX/KsDEXL0fD3PSdd8hGfwKij0zsDIi32fWsbXtznFf0gVfY8DQmgap
         zeGefx8f+4EUrgQV449F7p2hn7fMeoTi4AgPpy1gRtCw5cWoyiKc/YJ6lLmZeZl96B7H
         XiPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=DVffCJTjZVBZ/Ri7N7jhnoxsecvTmwMEKsAHPr9otZ4=;
        b=sSFq33T3vWz7A1NtbHEM5Fonr2GN74Ezc8JHmDS18wTlqAAFRQP6r4Gxt4DmJ3SESK
         H9XjTMh4f2XmY/qQvc3glfje/JLbpEk2jEnZ0ldWmT/uu/npbdfUwp5NSaoZzuz4O0YU
         q46Nh04oH62Y/QD6+xrdZsJWawFeqA4WDAMGl8wkH6WCbfjBlzbMkAdvBF4DMR3bB/Y1
         BmrGVGu5XllR577eYm/czrL7CbueX7s3oNGmUnsFjCvQjHS3/XaQV/ZkXUf0HxAEd9az
         TMZEeDLKdvhr4LYr/T24qAiAuJNOkPcHGVIh4DKsP57qNVxTirSiU5P2z5n1dhsWiUxt
         7vOA==
X-Gm-Message-State: AOUpUlFpMEMXjI95p0kU7KrgSYzDF7LJLpu+axsd4XuQdpYN/sAMX6Hw
        DsXubw/g/yl1wmo0+AFChcY=
X-Google-Smtp-Source: AA+uWPx0OVplKAPN67BmyH12KaikeOh0l7x6pHH6JKWzMh2Q6t921+U+cc0R07AZEcO8GON9VrSIVg==
X-Received: by 2002:a17:902:4381:: with SMTP id j1-v6mr25236748pld.104.1534351793275;
        Wed, 15 Aug 2018 09:49:53 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id f90-v6sm39631890pfh.168.2018.08.15.09.49.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Aug 2018 09:49:52 -0700 (PDT)
Date:   Wed, 15 Aug 2018 09:49:51 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Tony Luck <tony.luck@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Mike Galbraith <efault@gmx.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Build failures with gcc 4.5 and older
Message-ID: <20180815164951.GA30932@roeck-us.net>
References: <20180814170904.GA12768@roeck-us.net>
 <CA+55aFy0SFGaNmzCcpwMCeY_f3ZTG54NmV3SosbK6=QdE20=5A@mail.gmail.com>
 <20180814173623.GA5117@roeck-us.net>
 <CA+8MBbJ=09jAHNZTFrwMFFGbUSWEMYCDxKTMvM2XE+daVa599g@mail.gmail.com>
 <CA+8MBbLrxj5e6cifAt9h0mR7n8x+8KEtu7Mq-gUSOrpCmkZXsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+8MBbLrxj5e6cifAt9h0mR7n8x+8KEtu7Mq-gUSOrpCmkZXsg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 09:09:17AM -0700, Tony Luck wrote:
> On Tue, Aug 14, 2018 at 1:19 PM Tony Luck <tony.luck@gmail.com> wrote:
> > My ia64 test box only has 4.3.4.  I seem to remember some pain points
> > with newer versions of gcc on ia64. I need to poke around and find one
> > new enough to get past this problem, but that still works for kernel building.
> 
> I had problems trying to build an up to date (or even a slightly old)
> gcc starting from 4.3.4.
> 

Ah yes, one of those little details: Older versions of gcc don't
build anymore with recent versions of gcc.

> I did manage to build 4.6.4.
> 
> 4.6.4 built git HEAD* that failed yesterday using 4.3.4. It boots OK.
> 
FWIW, I use gcc 8.1.0 (from kernel.org) for my ia64 test builds.
Of course, I have no idea if those builds actually create bootable images.

Guenter
