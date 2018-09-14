Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12CC6ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB04D206B5
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IbajFF3V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB04D206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbeINS4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 14:56:31 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44995 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbeINS4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 14:56:31 -0400
Received: by mail-lf1-f67.google.com with SMTP id g24-v6so2669784lfb.11
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 06:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WMztn85Lu3nqcB+t6sKjA0nAJj3QLnFa3HncxQff40s=;
        b=IbajFF3ViXjr/bbfmJrSO8AFuITiUglENAxpM8Yl33HJPYLg0czLnQqM+wyWbtAV8v
         aYQI3cOUPDulfovSJ0VShzCjUyKBEvGs7Ye5bl5XB3HJj3ZcnI3rFtoalOHDTIGwPIOu
         DutCxYXXyoLORwqs/3Df6xDbiwVjRpemUYz7Dp163i7e4WhGj9F51JrE1HsW/BB7BqP9
         z1pUcUadJGXGEsKjPSjzpFldCJutRaskWufgt0tD2geqrE1600ES226LUqxXrGhcE1vJ
         cGJYLfTcZCZULQ7vbCY2jfzV/D0t0LdAXGFTvyMUwp63J1QActw6AI+KEjKG6yVc7vfz
         /l6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=WMztn85Lu3nqcB+t6sKjA0nAJj3QLnFa3HncxQff40s=;
        b=b4k8oXQ24oQXH3NaODT9Rth9NvQ74C/ZLrVgMgGjX3CvvHIMezDB88xcYa1nuClN1Q
         bsLfV0ESh6SPXbPIITmG0r3jqhg82r6OrDiGIbe2me02Q30yB8IGmIME3kPA8WCTA9IZ
         bCxMEhyj3Fl5Rn2Zhu+Q8DRx6ieBwZceY3rnGbok0xdntFo3nGtY/GzedO52d73jgVO8
         OZTDmSpmR2NnhGhqMicqMd+oc/LmCG90DPdF54HDUJEcN5O/Ked9ip/dkldu+1N+wgh7
         nZlJmmtrpHcGz7VRkXg80hYPu5tj0AzoAXd039PbrdM2MKCRmy+itNFWdAfle7fFYgtP
         haig==
X-Gm-Message-State: APzg51DUj8agVq701pdgOcXfQR8baVMOm5zrVWH7Mx+vH6vuHzZ0oWTy
        TeFmBDhyj6Si2FgJws8jg1+wjFA8
X-Google-Smtp-Source: ANB0VdbDWKDNZwCU3KnwB8riKgQ9V6K60GrLgOmRZzjzI0M4jVH8D+6t4mnHoGuRI6bTBPeuwYis1Q==
X-Received: by 2002:a19:d206:: with SMTP id j6-v6mr8811504lfg.31.1536932515597;
        Fri, 14 Sep 2018 06:41:55 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id f129-v6sm1294663lff.37.2018.09.14.06.41.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 06:41:55 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1g0oM9-0002gc-Bm; Fri, 14 Sep 2018 15:41:57 +0200
Date:   Fri, 14 Sep 2018 15:41:57 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 19/50] ark3116: switch to ->get_serial()
Message-ID: <20180914134157.GG1362@localhost>
References: <20180913023119.GQ19965@ZenIV.linux.org.uk>
 <20180913024049.24567-1-viro@ZenIV.linux.org.uk>
 <20180913024049.24567-19-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913024049.24567-19-viro@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 03:40:18AM +0100, Al Viro wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Reviewed-by: Johan Hovold <johan@kernel.org>
