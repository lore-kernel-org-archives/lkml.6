Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 8A071C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 07:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4067D208AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 07:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XWPjWc7i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4067D208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934709AbeFMHyn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 03:54:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:48028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754472AbeFMHyg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 03:54:36 -0400
Received: from localhost (unknown [37.169.25.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DA37208AF;
        Wed, 13 Jun 2018 07:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528876476;
        bh=CD76DzcJmC48fDQlYq2aHQQ83LWuYBs9Nw4JTShz4B4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XWPjWc7ipM5oKZsy3fMh5HJxV59kVn6Q3s5Kj+jyxWuJXrrKPsUH3yqlTqHjMJZEH
         QfOLAWSUiFp0eEYfabaEqN2ZuLO6T9gofLV0b1+fHff99ULbygFXMPeJK7ubPdj5b/
         dgaoe2WZBBIoIVKzIsuj3sRDLS+VcOTN2Z4udDa4=
Date:   Wed, 13 Jun 2018 09:54:11 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Thomas Hellstrom <thellstrom@vmware.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        linux-doc@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH 1/2] locking: Implement an algorithm choice for
 Wound-Wait mutexes
Message-ID: <20180613075411.GA17681@kroah.com>
References: <20180613074745.14750-1-thellstrom@vmware.com>
 <20180613074745.14750-2-thellstrom@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180613074745.14750-2-thellstrom@vmware.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 09:47:44AM +0200, Thomas Hellstrom wrote:
>  -----
>  
> +The algorithm (Wait-Die vs Wound-Wait) is chosen using the _is_wait_die
> +argument to DEFINE_WW_CLASS(). As a rough rule of thumb, use Wound-Wait iff you
> +typically expect the number of simultaneous competing transactions to be small,
> +and the rollback cost can be substantial.
> +
>  Three different ways to acquire locks within the same w/w class. Common
>  definitions for methods #1 and #2:
>  
> -static DEFINE_WW_CLASS(ww_class);
> +static DEFINE_WW_CLASS(ww_class, false);

Minor nit on the api here.  Having a "flag" is a royal pain.  You have
to go and look up exactly what that "true/false" means every time you
run across it in code to figure out what it means.  Don't do that if at
all possible.

Make a new api:
	DEFINE_WW_CLASS_DIE(ww_class);
instead that then wraps that boolean internally to switch between the
different types.  That way the api is "self-documenting" and we all know
what is going on without having to dig through a header file.

thanks,

greg k-h
