Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4339ECE561
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 01:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55EC9214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 01:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AmG3x926"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55EC9214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730674AbeISGr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 02:47:58 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:32792 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbeISGr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 02:47:58 -0400
Received: by mail-pg1-f193.google.com with SMTP id s7-v6so1887392pgc.0;
        Tue, 18 Sep 2018 18:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MY2ErMXoKLvYfJ84LalNzf9X36+vwjSwsdrSUJekjlk=;
        b=AmG3x926rDYq73s42JKBQprwSfCcO7ie219Zpqbaq8mwY7lklD0SC6Dmsuli+vR8DV
         teboeDHnfHOAbBJAy+A+ocOGArkdFdDAVOB6rM9kwsnZvlrpqIL6U/wuNVMq66cQrWeP
         7daYtLoC63N1y7/skZzBmBMMC3acvugzvhDmOfcUE3o2yKeMjNg84Z9AzvRUeTCmQkvO
         v7YpPfo/mPHFdfbx8zgDG6F9pYVbVRR32hWx4C95wNpQmFXKrllude04muaolFRslSNd
         7g/P9IYzcs8KMF+x5ZBLnkn5q6BGPZHbVkcY6QVL4iQ5MFGwb47IQfmE1A8TU2eERoju
         wRow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MY2ErMXoKLvYfJ84LalNzf9X36+vwjSwsdrSUJekjlk=;
        b=VmbA0vxB57SLP4J9OlD6HFia44q0hat7GzpaxJd9YVnE7S4TMeNOmCOhJeVVDcM+eZ
         tMTjMynJUk2w6NdNnYu6IZMhsmNlPYXQo4Fscoc2CZxA6HpPAQC1Xe74tu5/RCQzUQEQ
         2sdr5JEyNdXOBbY0lgssKGSu4cx34dpcgqQNvL10H/6Lr5Rb23ladjIpN/dgZUQA2AJE
         beOwztllKD2YeyZUCcq58/nCPXdDKEyU4U8bZoA4Daj5jqejjk3wwFCJMdxpMScn14ov
         25tRkC3a7c4sU3sJkiW0NNI4KMC/u1+alfrD7EAWH8Hvd39fnYoSuaI/eq+zn0KMwIXM
         oWTQ==
X-Gm-Message-State: APzg51Asi03taHKTFy/fO9wgVaS/q+8juxYgjCU4fF5CxdOKvF1jEuDg
        N0e73kbWigY7MOWM10RBEkg=
X-Google-Smtp-Source: ANB0VdZgq/vlqjUk4pAzNIBloL+2rZCEkV0lSe8fprkhOThp9pntyxhNXaZzw8rJ2jAX9GZr4nldxw==
X-Received: by 2002:a63:170b:: with SMTP id x11-v6mr29254480pgl.364.1537319562318;
        Tue, 18 Sep 2018 18:12:42 -0700 (PDT)
Received: from localhost ([175.223.11.230])
        by smtp.gmail.com with ESMTPSA id e73-v6sm36723789pfb.153.2018.09.18.18.12.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Sep 2018 18:12:40 -0700 (PDT)
Date:   Wed, 19 Sep 2018 10:12:36 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        David Howells <dhowells@redhat.com>, viro@zeniv.linux.org.uk,
        torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 14/33] vfs: Implement a filesystem superblock
 creation/configuration context [ver #11]
Message-ID: <20180919011236.GA407@jagdpanzerIV>
References: <20180911220743.GA13208@roeck-us.net>
 <20180911174641.GA15149@roeck-us.net>
 <153313703562.13253.5766498657900728120.stgit@warthog.procyon.org.uk>
 <153313714181.13253.304098108512966976.stgit@warthog.procyon.org.uk>
 <27113.1536702746@warthog.procyon.org.uk>
 <32382.1536707855@warthog.procyon.org.uk>
 <20180911235403.GA10107@roeck-us.net>
 <20180918090722.GA463@jagdpanzerIV>
 <80eb1ec0-7b61-debe-9e93-0176d3e2c76a@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80eb1ec0-7b61-debe-9e93-0176d3e2c76a@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (09/18/18 07:06), Guenter Roeck wrote:
> > So the check either better be
> > 
> > 	if (fc->ops && fc->ops->reconfigure)
> > 
> 
> Since there are multiple instances of fs_context where fc->ops isn't set,
> this check would be needed wherever fc->ops is dereferenced.

Right. If fc is always guaranteed to be properly zeroed-out. This is
true for kzalloc-ed fc's, but not necessarily so in any other case.

	-ss
