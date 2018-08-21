Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 361A1C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 16:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E795520685
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 16:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYCJamep"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E795520685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbeHUTaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 15:30:02 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:43527 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbeHUTaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 15:30:02 -0400
Received: by mail-yb0-f193.google.com with SMTP id k5-v6so3118001ybo.10;
        Tue, 21 Aug 2018 09:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gI/qP9Vpnqz/vHqt9Lw9NT8dYlKXOkn3YNDTTsR5BNk=;
        b=SYCJamep34LLMkYLJwx5TFGOMvutkLKgb6hOxtJ8PjkBTZl/OKvzihJ11MdoYHWnb4
         plVpZcOYjwH/8WEVAn0XbsR9QrmhxNV6zmA6xsKbspUgKprGrj5eh+A2ceQaDWjIL4ei
         Hi2KqfpQSlu4s2tLlawbrIaz0keZ5LiISc4zE7MAZaFWcTWw4Udn/dDpLT+xrAFZKtCf
         aj7byUNI9tj3Tt0QD0WO22Pw0p3bpG3DvcsY8Z5udEG8qyrmwaze3oyhQUE3xSHLmHIZ
         1IpRoNqdiYuzNxTz/JG7hkgXCbNfsVBPzEzx7IsJY/ZqJ/OtkpiliSdRUuG5XZn3LcEw
         cFsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=gI/qP9Vpnqz/vHqt9Lw9NT8dYlKXOkn3YNDTTsR5BNk=;
        b=j+2AD9ARyZ7C9lnDbQTb0zGkZTfa2C5di+mcHVsOTsqyPkVqTFn3Ex3u+5tKWnM7hX
         1gkbajjVNyNCUy4X8hbydpW125Njbe5knsgy3hnMGRYQkyTkGJzOfV0eDhjnfpiOB17i
         5vP187pYaAmOgzk0eGmL1kG2EPVxrZvKydTxCh1TcQJ1KKdNsxEa84fEZquZ4AFLSBBB
         88Eq26uirWzHLkFP0jz4J3E4rK0dkrXeW/JiuZs6aBgdgIdR3XeNNEPuP3eFtYsVzVQk
         ToB2taaXG7pN4oI5d/30cpvnrFsk4NRzk2rTvjfH3s/CdvB2zwttuDBOhCkjCTqt+ad6
         xp6A==
X-Gm-Message-State: AOUpUlE9PDqFGyESe7Pz65aPIx5Hwce8YcsWxJXYEXzf5uQMJ2/ws4rY
        KBbiCByjh9oLUr63fyibYY4=
X-Google-Smtp-Source: AA+uWPyAGSXN0GUkvVUhAwFpaJLNwqHmbb+cfTNjQu88EGfKTcp5QStsWU+D2Rwq32JW4u0zkDzjpA==
X-Received: by 2002:a25:a28b:: with SMTP id c11-v6mr9616371ybi.478.1534867757129;
        Tue, 21 Aug 2018 09:09:17 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::1:9c5d])
        by smtp.gmail.com with ESMTPSA id n187-v6sm9559934ywn.76.2018.08.21.09.09.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 09:09:16 -0700 (PDT)
Date:   Tue, 21 Aug 2018 09:09:14 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH 2/2] workqueue: create lockdep dependency in flush_work()
Message-ID: <20180821160914.GQ3978217@devbig004.ftw2.facebook.com>
References: <20180821120317.4115-1-johannes@sipsolutions.net>
 <20180821120317.4115-3-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180821120317.4115-3-johannes@sipsolutions.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 02:03:17PM +0200, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> In flush_work(), we need to create a lockdep dependency so that
> the following scenario is appropriately tagged as a problem:
> 
>   work_function()
>   {
>     mutex_lock(&mutex);
>     ...
>   }
> 
>   other_function()
>   {
>     mutex_lock(&mutex);
>     flush_work(&work); // or cancel_work_sync(&work);
>   }
> 
> This is a problem since the work might be running and be blocked
> on trying to acquire the mutex.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

This makes sense to me.  Did you notice any extra lockdep warnings
with this?

Thanks.

-- 
tejun
