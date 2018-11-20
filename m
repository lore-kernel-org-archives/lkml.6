Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D12C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 21:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E19820C01
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 21:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="A5tJwOzu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E19820C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726001AbeKUIOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 03:14:21 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41695 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbeKUIOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 03:14:20 -0500
Received: by mail-pl1-f196.google.com with SMTP id u6so2198998plm.8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 13:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7N3lnIJSJE8Ns6WkS2XHSWiiA2n/k1iHekFH+BYK0xI=;
        b=A5tJwOzuovROBbKL1aW3PKVgMNtc6hy/S4MuIhSevWtS7igk7EX37Xs73lU3yZG3c8
         QhMviHTXlkV95G3JnLJoHHH+AfcNoe9Im654xRVHXGPUVD58MgmtlD8lEzVO7okkF4S3
         Ic6u5Roxm5qs0al/0C+Q5LenDPnk40cWsvLpQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7N3lnIJSJE8Ns6WkS2XHSWiiA2n/k1iHekFH+BYK0xI=;
        b=OUdRpFHbwIDFtSu5039YzPeQ/TLhjcjQf9PXbW0yN7Jgy3uxnDP5WWP0pMUWN7/2sS
         Be2kABmvoxvlSFrkACht9XUrS5CMZCmzruuOy7Bs3XOIq04IYoEaCvtfFVRn23c9bCvf
         5Dx5AcBL50jbQYc6b6isGoZlkzmEXHUCwRQ6L7gQCyMBShBmQo/eYm1y4lhJqky8LHAB
         AIEB53LryFsoQLOQmafYfNcL0C6jbosi0qpfj9y/6JTEMY3MnpsJcVJReJx9L9JbFlhm
         cI/r0fhvgtZWGQupwm/xa3lGpd9BSMpX7R9CGyizpiirMS19MnE6aQ6tJ8kllTKYSAUA
         rTgA==
X-Gm-Message-State: AA+aEWaDu0j2bw1fCib0z+CjjlgvfGe6M26X+cHqkFEvscTYs+iP4N3Z
        tmzNVBUu1DC0NeT9os9cbJA0baMa0Z8=
X-Google-Smtp-Source: AFSGD/WdNqYcnJSwnfS3bweyvPgYhg/BcJtsI7csapiMKWa1kk1MfO6EtPAM9v5kay5drh1HYyrMJg==
X-Received: by 2002:a63:ac46:: with SMTP id z6mr3493551pgn.162.1542750185472;
        Tue, 20 Nov 2018 13:43:05 -0800 (PST)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id j64-v6sm19349250pfc.43.2018.11.20.13.43.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Nov 2018 13:43:04 -0800 (PST)
Date:   Tue, 20 Nov 2018 13:43:03 -0800
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH 2/8] pstore: Do not use crash buffer for decompression
Message-ID: <20181120214303.GA183827@google.com>
References: <20181101235200.28584-1-keescook@chromium.org>
 <20181101235200.28584-3-keescook@chromium.org>
 <20181102182454.GB14942@google.com>
 <CAGXu5jKdO8icx63YDkqDsYP4_pNxRe5zUiVUg2+0mhbHj10zTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jKdO8icx63YDkqDsYP4_pNxRe5zUiVUg2+0mhbHj10zTg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 01:56:09AM -0600, Kees Cook wrote:
> On Fri, Nov 2, 2018 at 1:24 PM, Joel Fernandes <joel@joelfernandes.org> wrote:
> > On Thu, Nov 01, 2018 at 04:51:54PM -0700, Kees Cook wrote:
> >>  static void decompress_record(struct pstore_record *record)
> >>  {
> >> +     int ret;
> >>       int unzipped_len;
> >
> > nit: We could get rid of the unzipped_len variable now I think.
> 
> I didn't follow this -- it gets used quite a bit. I don't see a clean
> way to remove it?

You are right. Sorry I missed that crpyto_comp_decompress actually uses it.

thanks,

 - Joel
