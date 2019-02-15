Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4FCEC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87D3B222A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550250111;
	bh=k9llutIWSBV06Qw9Jm95V7UNG4hmzfZg+m140BwK4v4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UfN+wR4XOnDWiEydS9GE76BunBUWqKITFr/8hR6fBlqyfrPZEXEBvVdZ9edRsdCJ1
	 p0Jf4zptiFEbDHOWdkysuQSOZFCzYNLnKZd2YuSlJMePVbLZHjIP07I+WfFCH0Clm0
	 uQbTk7Gj6KO5okMsnvaRRdq0HVyqYBDfCSwAmhgk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388973AbfBORBu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 12:01:50 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43012 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbfBORBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 12:01:49 -0500
Received: by mail-pg1-f196.google.com with SMTP id v28so5060215pgk.10;
        Fri, 15 Feb 2019 09:01:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FQVDnXX8akd0rqu7cCn6I1ckz5e6fu33GxPRr72g7lE=;
        b=SwHI+2K5iS0LeLjC4ez9BXexG7QXa7e9Z3iuQOkC1dma729tNaDuVqJH/8UZQiVff2
         H0QuWmpcyTa/1Ja8DC+1aqKmvHE7+XdYPk4FLVQVRKUbT4/lnBSuYQea9bbpJiGoV0C3
         cEGc12pdB+QERiIRp891KWM++c0gTWmI8bq2V7jXaG1uE1RGQuJlGBrUO+APp9QVqxDk
         9dYhIGeUeVEV3cjVy/M4X/2bvEreNpdQ+SM22+YyGnXLnbmvr3JTYrulo/+ypGd/s3uq
         mDtPYTTlf1+lk21lY4TLDXhmRvyD4DBmNWfis45xaQR3Mf0ekGzkbGWrHvIvjJnJ5dqo
         zsPQ==
X-Gm-Message-State: AHQUAuZtbN5NSKw1sCkFHZE+VO5XDAW9rDtcejpUjuddjC6IX9IPRxFz
        neZpnQYb+fHZReVMrLw+gRylG6DbNGI=
X-Google-Smtp-Source: AHgI3IZXHEl2ayrFRrGCrEgy1fYs1kbh0DDF9GuO056xQI8rmgPRkXnzdhpmqu/KOyzIzhanRmdqpg==
X-Received: by 2002:a63:8743:: with SMTP id i64mr6285562pge.69.1550250108388;
        Fri, 15 Feb 2019 09:01:48 -0800 (PST)
Received: from garbanzo.do-not-panic.com (c-73-71-40-85.hsd1.ca.comcast.net. [73.71.40.85])
        by smtp.gmail.com with ESMTPSA id s2sm13891493pfa.167.2019.02.15.09.01.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Feb 2019 09:01:46 -0800 (PST)
Received: by garbanzo.do-not-panic.com (sSMTP sendmail emulation); Fri, 15 Feb 2019 09:01:44 -0800
Date:   Fri, 15 Feb 2019 09:01:44 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jessica Yu <jeyu@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        "Bruno E . O . Meneguele" <bmeneg@redhat.com>
Subject: Re: [PATCH v3] x86/ima: require signed kernel modules
Message-ID: <20190215170144.GH11489@garbanzo.do-not-panic.com>
References: <1550249418-7986-1-git-send-email-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550249418-7986-1-git-send-email-zohar@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 11:50:18AM -0500, Mimi Zohar wrote:
> Have the IMA architecture specific policy require signed kernel modules
> on systems with secure boot mode enabled; and coordinate the different
> signature verification methods, so only one signature is required.
> 
> Requiring appended kernel module signatures may be configured, enabled
> on the boot command line, or with this patch enabled in secure boot
> mode.  This patch defines set_module_sig_enforced().
> 
> To coordinate between appended kernel module signatures and IMA
> signatures, only define an IMA MODULE_CHECK policy rule if
> CONFIG_MODULE_SIG is not enabled.  A custom IMA policy may still define
> and require an IMA signature.
> 
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
