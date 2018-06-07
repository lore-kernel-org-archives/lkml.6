Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id gJV4IRS0GVtqbAAAmS7hNA
	; Thu, 07 Jun 2018 22:40:18 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A10266089E; Thu,  7 Jun 2018 22:40:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 390F360290;
	Thu,  7 Jun 2018 22:40:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 390F360290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752350AbeFGWkP (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 18:40:15 -0400
Received: from www62.your-server.de ([213.133.104.62]:46632 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752156AbeFGWkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 18:40:13 -0400
Received: from [178.197.248.12] (helo=linux.home)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-SHA:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1fR3Zi-0002Do-No; Fri, 08 Jun 2018 00:40:10 +0200
Subject: Re: [PATCH] bpf: attach type BPF_LIRC_MODE2 should not depend on
 CONFIG_BPF_CGROUP
To: Y Song <ys114321@gmail.com>, Sean Young <sean@mess.org>
Cc: Matthias Reichl <hias@horus.com>, linux-media@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Devin Heitmueller <dheitmueller@kernellabs.com>,
        Quentin Monnet <quentin.monnet@netronome.com>
References: <cover.1527419762.git.sean@mess.org>
 <9f2c54d4956f962f44fcda739a824397ddea132c.1527419762.git.sean@mess.org>
 <20180604174730.sctfoklq7klswebp@camel2.lan>
 <20180605101629.yffyp64o7adg6hu5@gofer.mess.org>
 <04cc36e7-4597-dc57-4ad7-71afcc17244a@iogearbox.net>
 <20180606210939.q3vviyc4b2h6gu3c@gofer.mess.org>
 <CAH3MdRXE8=dE25Sj3TPDzVh7ytnvCkUDvCDzZkEZe0N84dy-Zw@mail.gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <34406f72-722d-9c23-327f-b7c5d7a3090c@iogearbox.net>
Date: Fri, 8 Jun 2018 00:40:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAH3MdRXE8=dE25Sj3TPDzVh7ytnvCkUDvCDzZkEZe0N84dy-Zw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.99.3/24642/Thu Jun  7 22:39:10 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07/2018 08:14 PM, Y Song wrote:
> On Wed, Jun 6, 2018 at 2:09 PM, Sean Young <sean@mess.org> wrote:
>> Compile bpf_prog_{attach,detach,query} even if CONFIG_BPF_CGROUP is not
>> set.
> 
> It should be CONFIG_CGROUP_BPF here. The same for subject line.
> Today, if CONFIG_CGROUP_BPF is not defined. Users will get an -EINVAL
> if they try to attach/detach/query.
> 
> I am not sure what is the motivation behind this change. Could you explain more?

Motivation was that lirc2 progs are not related to cgroups at all and there
are users that have compiled it out, yet it uses BPF_PROG_ATTACH/DETACH for
managing them. This definitely needs to be more clearly explained in the
changelog, agree.

>> Signed-off-by: Sean Young <sean@mess.org>
>> ---
>>  include/linux/bpf-cgroup.h |  31 +++++++++++
>>  kernel/bpf/cgroup.c        | 110 +++++++++++++++++++++++++++++++++++++
>>  kernel/bpf/syscall.c       | 105 ++---------------------------------
>>  3 files changed, 145 insertions(+), 101 deletions(-)
>>[...]
