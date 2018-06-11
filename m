Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 80D41C5CFF0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37911208B9
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WP/xxIbU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37911208B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933401AbeFKRnX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 13:43:23 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:35108 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932409AbeFKRnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 13:43:21 -0400
Received: by mail-it0-f67.google.com with SMTP id a3-v6so12011910itd.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 10:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P83Bmz+I3dA6j+126fEbMec0gGUTZgb/XDKFeFQ9khk=;
        b=WP/xxIbUn63GP3ak6QbX3o2DeQlXjT/SwX7G14lVsjWWLiCQUoCFNEaonjIXqhQ+ky
         e8lU1YO+oTwnXx0zp940PFCdw/C9nI3fO9ZW96wu4VJjW2SuZKNlrRDIa/edsPxOedcM
         I9hfPsIDIG6FI8ghmUb1c6GG3faOIAP/0G0v0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P83Bmz+I3dA6j+126fEbMec0gGUTZgb/XDKFeFQ9khk=;
        b=YpWr7m4qbW2kj5qSlKr9sODFUJhQW0+tx3MHZAhhBohLXkyH3I4micfTc4qKcARL6P
         vpPuqHkcYaF/vt4SxztUe5yWCi8o1Dzdyt9m9A5h02A6H00WF7PkXr4UjUMaPem0X7Di
         TTjjF/x0DnzUmSt+7YgF4zGcNVpbhkemmnk4cDhsIP51GtltkwER6bHCi8mW034nnMNy
         PBlugLvSV39KsYRc+bSzmPr2QnXE1UNwPx5sWlzffM9h3m7jSNin/W/WLez0YJR3z/5q
         Ac87eSegMK+roilYyCFTZ5fP18usR47ygeLWuRJGGDqai2+ASyQLqKjuGTBnWQoT71aG
         q1iw==
X-Gm-Message-State: APt69E2aTPrryyx/PYQZIX6nG4BNqdYntIPSa4yNPrdE8hxfqToAeVPh
        +f/ZCMkCLwG8M7HM4GGqopBGoqZ5/JbO6pMR23w=
X-Google-Smtp-Source: ADUXVKKESP76UwdjVcJT1PgGCxXYarqwuZjncIxaMTDXNxx8+i0EpZ20TV0DS21/fKQ3rpEDhqkScSimO73OgBnEw1o=
X-Received: by 2002:a24:5b81:: with SMTP id g123-v6mr135218itb.1.1528739001155;
 Mon, 11 Jun 2018 10:43:21 -0700 (PDT)
MIME-Version: 1.0
References: <20180611165212.GA6783@jaegeuk-macbookpro.roam.corp.google.com>
 <CA+55aFznP4aEy7DkVfeQ_e6eXgLnswVnSJS3C51UHD_k8qYZCA@mail.gmail.com> <20180611174010.GC6783@jaegeuk-macbookpro.roam.corp.google.com>
In-Reply-To: <20180611174010.GC6783@jaegeuk-macbookpro.roam.corp.google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 11 Jun 2018 10:43:10 -0700
Message-ID: <CA+55aFxWh55LDOjZo03hwG645rdc+fFe6CM-B+C8Nbi7+p_+AA@mail.gmail.com>
Subject: Re: [GIT PULL] f2fs update for 4.18-rc1
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Matthew Wilcox <mawilcox@microsoft.com>,
        "Linux F2FS DEV, Mailing List" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 10:40 AM Jaegeuk Kim <jaegeuk@kernel.org> wrote:
>
> Heh, I forgot to link the latest results. The MM fix was merged by:

Ahh. Different fix. I did check that that original patch you mentioned
wasn't merged, and didn't react to the other patches.

Thanks,

                 Linus
