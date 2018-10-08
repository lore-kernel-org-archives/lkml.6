Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 891CBC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 19:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E3822089D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 19:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Om2w/GC0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E3822089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbeJIC6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:58:37 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44817 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbeJIC6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:58:37 -0400
Received: by mail-pl1-f194.google.com with SMTP id p25-v6so10518491pli.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 12:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SekXNzZJNKc0ROGOK7ZgH8k7aw+tWIkoUFjpC2nUNaU=;
        b=Om2w/GC02mVh/bMN7anZ4AmpR0eHd9TG0C6Y0acnT5tQWGRDZvOxfp5YsJRdPXiml3
         AMxY4BONeDnImCq/CH/zQxhK0ttIxnKWyA1NSyvPVfwzC6NiRIdm5BZ07oY4rWtFOHYj
         CWy+ACY4nlHHYOqkEc6yajbQ2yruMPJVUsfKifyCoSwK45sJKxtyWmaRVuq+akspfcEg
         CgPNe8l09w/AbnaimlfV+JC7y3lyjEOycgWJmIk/oqIdcHf5hPydejT7dhrdzJ0FC5D+
         FatVZj/ldXRJFVtkrQss5uMVDmvPYvb6IGEngdj2H2Fi0bmMg97F6YjS8OnRs24wGFe1
         Jd+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SekXNzZJNKc0ROGOK7ZgH8k7aw+tWIkoUFjpC2nUNaU=;
        b=A6QmuXoG9Mc7edDuAIFWa1mPSAvoiuNUB9xp7bMzZMGBtpneetc5wG/+s5Dxb/ShJ8
         ugeYmx8zgGvBr8/2TAMxssj2BL6gIgszeBcCMGbud8r7XhgjR31RmYHKlFJFbXZ4/UQH
         ZVOVSsYAZH0T/rNlPZnXp69/LZI7zFqNaVMoWbd+E4giOAvpbyhU0+xf9Yl7VB52bGVD
         SsRuDbiflT8v0zGXAmeR3edhWx87779uHmVnhMcipeTvHjiN8GA2lzgj5yW97raDZ7bw
         MqUi9cKbTM8dtzP8qK9KtggEKHTNySyN9Zf9eDhhP1V0qODhUaIAc99zakjzXIau5+mw
         Ehqw==
X-Gm-Message-State: ABuFfogmRrE4y9CgT8CY/7H4Tjnm1tpIaLSoMGt02TuvfoIYQh/J+F/E
        ONZ3OiUtXkc3sSDBM9wPRMQFrA==
X-Google-Smtp-Source: ACcGV63nDWgu9+g7KdRi7yV94IpPDL7KItLmuClEiQ0gkPc8LCLT0NFAh1H+vqSQoLd7SbvkYDbkgw==
X-Received: by 2002:a17:902:3a2:: with SMTP id d31-v6mr25430706pld.287.1539027914700;
        Mon, 08 Oct 2018 12:45:14 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id c2-v6sm12841828pfn.95.2018.10.08.12.45.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Oct 2018 12:45:13 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1g9bSr-0007tt-8s; Mon, 08 Oct 2018 13:45:13 -0600
Date:   Mon, 8 Oct 2018 13:45:13 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+1ed9dfaa984c88cf0ef8@syzkaller.appspotmail.com>,
        dledford@redhat.com, Leon Romanovsky <leon@kernel.org>,
        swise@opengridcomputing.com, markb@mellanox.com,
        linux-rdma@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>, guro@fb.com,
        Kees Cook <keescook@chromium.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        marcos.souza.org@gmail.com, Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Will Drewry <wad@chromium.org>
Subject: Re: WARNING in __put_task_struct (2)
Message-ID: <20181008194513.GC27639@ziepe.ca>
References: <000000000000b3d5610577b9e12c@google.com>
 <CACT4Y+bfqk8Fczw4dJHhVzM63YhYNSovEE-KygZ1XmgUQVGCWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+bfqk8Fczw4dJHhVzM63YhYNSovEE-KygZ1XmgUQVGCWQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 06:15:22PM +0200, Dmitry Vyukov wrote:
> On Mon, Oct 8, 2018 at 6:12 PM, syzbot
> <syzbot+1ed9dfaa984c88cf0ef8@syzkaller.appspotmail.com> wrote:
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    ae16eea39a86 Add linux-next specific files for 20181008
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=12e7c6a1400000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=42525ce985d1a955
> > dashboard link: https://syzkaller.appspot.com/bug?extid=1ed9dfaa984c88cf0ef8
> > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> >
> > Unfortunately, I don't have any reproducer for this crash yet.
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+1ed9dfaa984c88cf0ef8@syzkaller.appspotmail.com
> 
> 
> This was triggered by the following program, all is rdma-related, so
> +rdma maintainers.
> 
> 10:27:26 executing program 5:
> r0 = openat$rdma_cm(0xffffffffffffff9c,
> &(0x7f0000000380)='/dev/infiniband/rdma_cm\x00', 0x2, 0x0)
> write$RDMA_USER_CM_CMD_CREATE_ID(r0, &(0x7f0000000080)={0x0, 0x18,
> 0xfa00, {0x0, &(0x7f0000000040)={<r1=>0xffffffffffffffff}, 0x13f}},
> 0x12d)
> write$RDMA_USER_CM_CMD_RESOLVE_IP(r0, &(0x7f0000000200)={0x3, 0x40,
> 0xfa00, {{0xa, 0x4e21}, {0xa, 0x0, 0x0, @mcast1}, r1}}, 0x48)
> write$RDMA_USER_CM_CMD_CREATE_ID(r0, &(0x7f0000000340)={0x0, 0x18,
> 0xfa00, {0x0, &(0x7f0000000300)={<r2=>0xffffffffffffffff}, 0x13f}},
> 0x20)
> write$RDMA_USER_CM_CMD_SET_OPTION(r0, &(0x7f00000002c0)={0xe, 0x18,
> 0xfa00, @id_afonly={&(0x7f0000000000)=0x1, r1, 0x0, 0x2, 0x4}}, 0x20)
> write$RDMA_USER_CM_CMD_RESOLVE_IP(r0, &(0x7f0000000100)={0x3, 0x40,
> 0xfa00, {{0x2, 0x4e21}, {0xa, 0x0, 0x0, @local}, r2}}, 0x1ff)
> write$RDMA_USER_CM_CMD_DESTROY_ID(r0, &(0x7f0000000180)={0x1, 0x10,
> 0xfa00, {&(0x7f00000000c0), r2}}, 0x18)

This might be fixed in Linux-next now by this commit:

Author: Leon Romanovsky <leonro@mellanox.com>
Date:   Tue Oct 2 11:48:03 2018 +0300

    RDMA/restrack: Release task struct which was hold by CM_ID object
   

Jason
