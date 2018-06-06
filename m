Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dla0pdhw"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0F07B606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932138AbeFFSVb (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 14:21:31 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:35659 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752263AbeFFSV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 14:21:29 -0400
X-Google-Smtp-Source: ADUXVKLDXgp43ZKRKJ+Ndj1xaD3nyGJKtT/3w11AKQDFbZWRphZVVlt+xoTff8uAt59zlu+Zcwu+BlEXosJN3qfpi2E=
MIME-Version: 1.0
In-Reply-To: <CAB+yDaahHYeWE1kS=4GEAC3GKyrAenaSat9Wi_iKQbt1yTp_zg@mail.gmail.com>
References: <CAB+yDabFuBpT5UU1Hy0s4kY5UKJzA84=6fNieNcdTjjZNq5SHQ@mail.gmail.com>
 <CAM_iQpUaK1xaZAKmPY0JnyAmebBJQ5GPJsiG8HgvXLrxNqphZg@mail.gmail.com> <CAB+yDaahHYeWE1kS=4GEAC3GKyrAenaSat9Wi_iKQbt1yTp_zg@mail.gmail.com>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Wed, 6 Jun 2018 11:21:07 -0700
Message-ID: <CAM_iQpX=BomgJQaPTjUrZP+H44v9zwJSMMS1gf3+gmTyqzYdxQ@mail.gmail.com>
Subject: Re: general protection fault in sockfs_setattr
To: shankarapailoor <shankarapailoor@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc: David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 5, 2018 at 7:19 PM, shankarapailoor
<shankarapailoor@gmail.com> wrote:
> Hi Cong,
>
> I added that check and it seems to stop the crash. Like you said, I
> don't see where the reference count for the file is increased. The
> inode lock also seems to be held during this call.

I know inode lock is held for ->setattr(), but not for ->release(), this
is why I suspect sock_close() could still race with sockfs_setattr()
after my patch.

I am not sure if it is crazy to just hold fd refcnt for fchmodat() too..
