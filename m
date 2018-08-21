Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B403C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 16:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 486112177F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 16:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BY4spPul"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 486112177F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbeHUTVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 15:21:24 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:36138 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727650AbeHUTVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 15:21:24 -0400
Received: by mail-yw1-f67.google.com with SMTP id w202-v6so2203679yww.3;
        Tue, 21 Aug 2018 09:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=P4/VzEQA4DDqzq9gejGOYdmW+pT3MXxoLZ3rK2bSw/c=;
        b=BY4spPulfmCbg1mA9q2uxKWDQZM9S8fEsx8JUUFDDrz0yrnM3qDq5YG2CXDdHC9FN6
         HRrc8gXLWmdzJ94/eooTXZFciCVT55WCP4izE458+RCVDpp+vPN6nQTeQ6mHjl3Ufhfr
         5xdbXtGSK0yQiA00qRxtf7eACw+JEZ/b/evJIIhNgZnJMlRxooyEZY8o/FNKmNplF3W0
         WWm5QgN7WW4199MKKi/kR6ZhS8d3VPSLlvXPR/hn33xxuH0hZbIoYpxZhjBpSvvHrbiH
         JYOZv0bxQVvqlmE/mz+ipS2TEdrTUGrlmHpGvq9wDthLcRoJjv6IgLcK7mBEhT9d9Udb
         nf9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=P4/VzEQA4DDqzq9gejGOYdmW+pT3MXxoLZ3rK2bSw/c=;
        b=rSkSws5R8FwAmuL/C/hnN+Bf9hkTJiLzqmF5btCJzngmfyr5Ic7dCmpLIT9jGisyUx
         MrD9kQNEPZffIEROhw+7CECV0q1ZEaLUy8Ouw1UYjq2MsvbUcEe8dk4aLAJTwkF32tR5
         AWSRNFEwBneeyJA6J7pi0Q4D8STfaVIM4PRoNyTQw24xt5IoBsMMah68tksj0JQvkS2G
         cg8DJmPbC4QjZf0DtZnwtmCuCDigbadEsg14/MF3NPpRrKsfpJyxjNKR5U3k+JGV5FbS
         LPxkFoQKKjbxiYP65fmV7HGUUefBJaCjdpbdim5jLHgTwlX3MzG6kYmIdIW/NRZDMsMz
         OfPA==
X-Gm-Message-State: AOUpUlGI6iN77Q8OJhO06TUrx84WmHv4xhS63lEfnX0cGShAnAnZyG1q
        N4RVVirnm7nGnu/K8epPzLw=
X-Google-Smtp-Source: AA+uWPx8CG2BJXtHw2NM3/BnyqA/247/gznx+OkyvHAidnqeyKvxNMUX2LHws8DLNy3RSeF2MMEPWg==
X-Received: by 2002:a81:148f:: with SMTP id 137-v6mr27514692ywu.97.1534867241373;
        Tue, 21 Aug 2018 09:00:41 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::1:9c5d])
        by smtp.gmail.com with ESMTPSA id k9-v6sm6059512ywh.33.2018.08.21.09.00.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 09:00:40 -0700 (PDT)
Date:   Tue, 21 Aug 2018 09:00:39 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 0/2] workqueue lockdep limitations/bugs
Message-ID: <20180821160039.GO3978217@devbig004.ftw2.facebook.com>
References: <20180821120317.4115-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180821120317.4115-1-johannes@sipsolutions.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Johannes.

On Tue, Aug 21, 2018 at 02:03:15PM +0200, Johannes Berg wrote:
> 3)
> The third problem is more complicated, but it means that we likely miss a
> lot of potential locking problems with ordered workqueues, and I think we
> should really try to fix this somehow.
> 
> Let's say we again have an ordered workqueue, and the following:
> 
> work1_function
> {
> 	mutex_lock(&mutex);
> }

Regular mutexes complain when the locker isn't the unlocker already.
Do we really care about this case?

Thanks.

-- 
tejun
