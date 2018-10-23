Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB5BC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 05:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 728EF20665
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 05:23:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Bdk7vog9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 728EF20665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbeJWNpK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 09:45:10 -0400
Received: from mail-ed1-f48.google.com ([209.85.208.48]:40557 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726764AbeJWNpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 09:45:10 -0400
Received: by mail-ed1-f48.google.com with SMTP id r1-v6so333086edd.7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 22:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=HaOFvpsM+siwY9Zk8c5ZlR4qx4ZjutIWsh3LgHYRnCg=;
        b=Bdk7vog9U/+ylzd/INHGwqNSZCHSUWWDdFnBqMMmiq0fmmSH+FOrpef3ECO6BX7QDz
         YWfZnkD8DR8/oLn3WtxNyEAKdhLVoQAxV1ORIRi9ACf44gjqMbQfZOkpzzP9MI4mdlrT
         5F72zihiryq/LPuf3sKQKpLmgGrmyYbkr/OrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=HaOFvpsM+siwY9Zk8c5ZlR4qx4ZjutIWsh3LgHYRnCg=;
        b=Vybm3AnLISt03P6P0Bra5WL1CnH9PP8oMFlBUGlQ7/t4fXo14JncdBWENNJichn/q3
         0cSUqa8/2n3CEVZcKrOKj9IcfAEYB4HI+53N6VkYCeLluWk2pgDGYBpRzfBK32U7e6CY
         ZWma4nP3O/6c+VhkEEbiobPRCv0QV2IeiAu7my1ZNp/E0yYKwQGWs5STKAOVppfTdxgS
         M0Yz3HYzSbFVflJM0WIT1TuQqdOiADXREoCIU8Q8yCQtyqHWq6cjjIgIBQaAMZedqQ3o
         3hF1G0U2FOaNYbiHAGZwZ0fsrwjIfgvR8FKbeSyhyk/MxqLm6wEBDZxRgvB8NUVZjEg3
         RThg==
X-Gm-Message-State: ABuFfohnOXEkhPfxM93hEaue1LJ+qARZiAm+nBNPGBBajXjX9lb+2zti
        ElFrcINGP+Koaa741TWx4JTP0Q==
X-Google-Smtp-Source: ACcGV61zo/CYVhCWUpO79rta3fomcZfUXJ6V8388S4L84crN/c10Ok0lWjeN+w/ny3/fAo8nTHodFA==
X-Received: by 2002:a17:906:1551:: with SMTP id c17-v6mr850329ejd.32.1540272203582;
        Mon, 22 Oct 2018 22:23:23 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id d10-v6sm104617ejr.3.2018.10.22.22.23.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Oct 2018 22:23:22 -0700 (PDT)
Date:   Tue, 23 Oct 2018 07:23:20 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Aaron Ma <aaron.ma@canonical.com>
Cc:     Dave Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, airlied@redhat.com,
        sean@poorly.run, seanpaul@chromium.org
Subject: Re: [PATCH 2/2] vgaarb: Keep adding VGA device in queue
Message-ID: <20181023052320.GJ324@phenom.ffwll.local>
Mail-Followup-To: Aaron Ma <aaron.ma@canonical.com>,
        Dave Airlie <airlied@linux.ie>,
        Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, airlied@redhat.com,
        sean@poorly.run, seanpaul@chromium.org
References: <1535739600-8842-1-git-send-email-aaron.ma@canonical.com>
 <1535739600-8842-2-git-send-email-aaron.ma@canonical.com>
 <CADnq5_P=_Kxg8y48NRQZjKzPi-yaAwKRQhpQ6qEav2rZijHucw@mail.gmail.com>
 <e4797ed7-920b-5d19-c1f4-212d53cf98cb@canonical.com>
 <b58c0d18-b56e-3dc7-a896-5adfbf5f7e36@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b58c0d18-b56e-3dc7-a896-5adfbf5f7e36@canonical.com>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 20, 2018 at 02:56:36PM +0800, Aaron Ma wrote:
> Hi David:
> 
> get_maintainer.pl still got your old e-mail.
> 
> Add airlied@redhat.com.
> 
> Loop Sean too.
> 
> Please review and apply these 2 patches.

Both pushed to drm-misc-next.
-Daniel

> 
> Thanks,
> Aaron
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
