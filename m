Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 540CAC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 14:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 100F82075B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 14:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IR38gx+M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 100F82075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbeH0RuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 13:50:07 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:39762 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726931AbeH0RuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 13:50:06 -0400
Received: by mail-yb0-f196.google.com with SMTP id c4-v6so6043042ybl.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 07:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=nS07EKH2fdEkO8tfFTup3lj+xv8HQY+ewCQDbWLLvo0=;
        b=IR38gx+My+XvMh8afgCJH7ojxde3bGQOlJAgHUPrCS37jRxC5bD5CDtea79ayEmTkA
         k9ksoouipVC/RnkpsWbdSbBGa6jfNIsyy6iaLX2uR9MYLLWTBPtj67FcGAfXWa35e1la
         uCSUIltmyOoJNGAiBIndR3/CwL8eWPG8IRBYxIkSYorZmv4xCygJKWqKYn4nlz7qaZrC
         XrTIml6NNuVwmVdcjkaKdftJL8mw/UGXviCisx7kD1wBlxl9xf6Uaz5ZNJvkdZrd3Sa+
         2ANAtUQxtA05uRc1f7iMqg2vpToyZsMgRXgLC5FM4L44WAqYH/Fu0UQ2oanvv//HVV2Q
         MekA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=nS07EKH2fdEkO8tfFTup3lj+xv8HQY+ewCQDbWLLvo0=;
        b=bhSJ6zN55E2A93mQNfHUqfiHkfOHWDp4uSbDg52YbCFlCnn1xzC338NevfOAMm3oj6
         VWvH3ZLdXv3G4aWsP5hiJ9X8+kV+l2aAjUhrW2GHfysVBxiS+MRHP+wQiT6ZAdevWoMY
         fBVR+RjqNthF1MInxdU2nCDLBz4NAAat5mkJrSY9FQGckMtd5psi6hjnHc5uxcoA69lu
         eXUjc0LzKJkPLXyRT3A77F7EYyyF3fu1TEcLIzJCWLZ5izaYd24Qv9EIgrrAagkpYrrn
         R6ik3Sth7WS8dH2HpdsH7FtNRBK4x62i89sgigGqSH3qox0ED7Sv2FzulIHzTpGl9OeT
         eHAQ==
X-Gm-Message-State: APzg51BProsPgZS55OsofHF3LtbR1wYky5WLPybSSOw/k79h9VrqqAJb
        gnMNPZYnnC3h0PMQIWXCrZo=
X-Google-Smtp-Source: ANB0VdY4LWK0V1E1fh8EJnDVwNOec9TTG8wiKzbndXaqCAiVrldtkC73mAllkjWtg6ztQimJxS10ag==
X-Received: by 2002:a25:586:: with SMTP id 128-v6mr6849944ybf.282.1535378600029;
        Mon, 27 Aug 2018 07:03:20 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::3:e4dd])
        by smtp.gmail.com with ESMTPSA id 63-v6sm6308858ywd.8.2018.08.27.07.03.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 07:03:19 -0700 (PDT)
Date:   Mon, 27 Aug 2018 07:03:17 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Bernd Edlinger <bernd.edlinger@hotmail.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv3] Fix range checks in kernfs_get_target_path
Message-ID: <20180827140317.GD3978217@devbig004.ftw2.facebook.com>
References: <AM5PR0701MB2657711C49D0229DBED3A24EE4460@AM5PR0701MB2657.eurprd07.prod.outlook.com>
 <AM5PR0701MB265723084A8E48954B914CF4E4340@AM5PR0701MB2657.eurprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM5PR0701MB265723084A8E48954B914CF4E4340@AM5PR0701MB2657.eurprd07.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 26, 2018 at 10:55:24AM +0000, Bernd Edlinger wrote:
> Ping...
> Sorry, I had actually completely forgotten about this one.
> 
> On 07/07/18 19:52, Bernd Edlinger wrote:
> > The terminating NUL byte is only there because the buffer is
> > allocated with kzalloc(PAGE_SIZE, GFP_KERNEL), but since the
> > range-check is off-by-one, and PAGE_SIZE==PATH_MAX, the
> > returned string may not be zero-terminated if it is exactly
> > PATH_MAX characters long.  Furthermore also the initial loop
> > may theoretically exceed PATH_MAX and cause a fault.
> > 
> > Signed-off-by: Bernd Edlinger <bernd.edlinger@hotmail.de>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
