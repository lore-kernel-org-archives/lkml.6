Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F29A9C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F8622083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="hnPvr9Yo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F8622083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729051AbeJAP6D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 11:58:03 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41021 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbeJAP6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 11:58:03 -0400
Received: by mail-io1-f68.google.com with SMTP id q4-v6so8794147iob.8
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 02:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=n2p8wQOgcP2KvSgIeJQm/JLB8sSWRJq/RoVcxj9wvF0=;
        b=hnPvr9YoQARi1rjfDN8/1vI329hD8Q5dYRZualEduV8QY3gEA/SXhbavPfmbly6j+N
         ABW/9/jTeDPdfBZwaJKICPZStT5lvifacWg6s8fE5fC7dN0L25bUNbqPGxIMWnM4IJd3
         y2HpQnzqL5S6buWdHobQ5DqzL0keZISLNeUYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=n2p8wQOgcP2KvSgIeJQm/JLB8sSWRJq/RoVcxj9wvF0=;
        b=swF/L0zcCOWZ9AiGK1lSLTksygT6QUdbP+bCG4tvBcPNT7lYTeqitT5/0ZYAFv1dTP
         tsyDb2T8YJHTybC49zE5Px+l+80L8rCXg0VwVzY9MGuGG7JHtMHXByqLVqQShHzE7ESm
         0DMGwVlelk4x92Ivlu4fzd1kVQYNS67zioS2GKDjeMxuVVxS9SqqkXwPpiwW2q7cSEI2
         1U3JNA86fmA7gZMPBiFv5IdXJVG7ro3Y/lPTcU48UsVKJrYltdQbHeMvf07VY87BY7jv
         WOM2/8+AIBWlpX1jIfQ2xNHNnIYMvxqu1UeP1zZLuktIKAmdLLKPIIXK31HhAcdAWtLg
         t39g==
X-Gm-Message-State: ABuFfoibuLyRpPJP6V2DursKHTYYxUBTPXIV3/CrJTBHp6OeDHmzSGNL
        7md2pRu5wsYB05So/g6mJrbtUs9qD2SKQV590V6Vgw==
X-Google-Smtp-Source: ACcGV60Iz4gx3qGm3srZGavltcTY6M84I2H7AQMpMlHQS9XEvHFqXhbtgEhN9Vhdxa2KdIbpYXlpoVm/oxUpOwDnDok=
X-Received: by 2002:a5e:8b06:: with SMTP id g6-v6mr3452102iok.144.1538385674171;
 Mon, 01 Oct 2018 02:21:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:bf41:0:0:0:0:0 with HTTP; Mon, 1 Oct 2018 02:21:13 -0700 (PDT)
X-Originating-IP: [212.96.48.140]
In-Reply-To: <20180821123631.5673-1-ndevos@redhat.com>
References: <20180821101233.GD2650@ndevos-x270> <20180821123631.5673-1-ndevos@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 1 Oct 2018 11:21:13 +0200
Message-ID: <CAJfpeguVqZgCVcPZzW55snZsfeM5PpBKqREaOXOM8KAFgR8Bgw@mail.gmail.com>
Subject: Re: [PATCH v4] fuse: add support for copy_file_range()
To:     Niels de Vos <ndevos@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marcin Sulikowski <marcin.k.sulikowski@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 2:36 PM, Niels de Vos <ndevos@redhat.com> wrote:
> There are several FUSE filesystems that can implement server-side copy
> or other efficient copy/duplication/clone methods. The copy_file_range()
> syscall is the standard interface that users have access to while not
> depending on external libraries that bypass FUSE.
>
> Signed-off-by: Niels de Vos <ndevos@redhat.com>

Applied and pushed to

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git#for-next

Thanks,
Miklos
