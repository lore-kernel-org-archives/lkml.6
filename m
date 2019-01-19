Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 835A0C61CE4
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 13:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A1AA2086D
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 13:11:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbfASNLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 08:11:02 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:32720 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727965AbfASNLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 08:11:02 -0500
Received: from fsav405.sakura.ne.jp (fsav405.sakura.ne.jp [133.242.250.104])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x0JDAL5T041254;
        Sat, 19 Jan 2019 22:10:21 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav405.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav405.sakura.ne.jp);
 Sat, 19 Jan 2019 22:10:21 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav405.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x0JDALgh041249
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Sat, 19 Jan 2019 22:10:21 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: INFO: rcu detected stall in ndisc_alloc_skb
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+ea7d9cb314b4ab49a18a@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Linux-MM <linux-mm@kvack.org>,
        Shakeel Butt <shakeelb@google.com>,
        syzkaller <syzkaller@googlegroups.com>
References: <ea2bc542-38b2-8218-9eb7-4c4a05da36ea@i-love.sakura.ne.jp>
 <CACT4Y+Yy-bF07F7F8DoFY8=4LtLURRn1WsZzNZ9LN+N=vn7Tpw@mail.gmail.com>
 <201901180520.x0I5KYTi096127@www262.sakura.ne.jp>
 <CACT4Y+acvQXPLHFSbNYAEma6Rqx6QCp_kqjsbAF8M9og4KA3CA@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <d90cc533-607e-fe40-9b02-a6cac7b7b534@i-love.sakura.ne.jp>
Date:   Sat, 19 Jan 2019 22:10:22 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+acvQXPLHFSbNYAEma6Rqx6QCp_kqjsbAF8M9og4KA3CA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/01/19 21:16, Dmitry Vyukov wrote:
>> The question for me is, whether sysbot can detect hash collision with different
>> syz-program lines before writing the hash value to /dev/kmsg, and retry by modifying
>> syz-program lines in order to get a new hash value until collision is avoided.
>> If it is difficult, simpler choice like current Unix time and PID could be used
>> instead...
> 
> Hummm, say, if you run syz-manager locally and report a bug, where
> will the webserver and database that allows to download all satellite
> info work? How long you need to keep this info and provide the web
> service? You will also need to pay and maintain the server for... how
> long? I don't see how this can work and how we can ask people to do
> this. This frankly looks like overly complex solution to a problem
> were simpler solutions will work. Keeping all info in a self-contained
> file looks like the only option to make it work reliably.
> It's also not possible to attribute kernel output to individual programs.

The first messages I want to look at is kernel output. Then, I look at
syz-program lines as needed. But current "a self-contained file" is
hard to find kernel output. Even if we keep both kernel output and
syz-program lines in a single file, we can improve readability by
splitting into kernel output section and syz-program section.

  # Kernel output section start
  [$(uptime)][$(caller_info)] executing program #0123456789abcdef0123456789abcdef
  [$(uptime)][$(caller_info)] $(kernel_messages_caused_by_0123456789abcdef0123456789abcdef_are_here)
  [$(uptime)][$(caller_info)] executing program #456789abcdef0123456789abcdef0123
  [$(uptime)][$(caller_info)] $(kernel_messages_caused_by_456789abcdef0123456789abcdef0123_and_0123456789abcdef0123456789abcdef_are_here)
  [$(uptime)][$(caller_info)] executing program #89abcdef0123456789abcdef01234567
  [$(uptime)][$(caller_info)] $(kernel_messages_caused_by_89abcdef0123456789abcdef01234567_456789abcdef0123456789abcdef0123_and_0123456789abcdef0123456789abcdef_are_here)
  [$(uptime)][$(caller_info)] BUG: unable to handle kernel paging request at $(address)
  [$(uptime)][$(caller_info)] CPU: $(cpu) PID: $(pid) Comm: syz#89abcdef0123 Not tainted $(version) #$(build)
  [$(uptime)][$(caller_info)] $(backtrace_of_caller_info_is_here)
  [$(uptime)][$(caller_info)] Kernel panic - not syncing: Fatal exception
  # Kernel output section end
  # syzbot code section start
  Program for #0123456789abcdef0123456789abcdef
  $(program_lines_for_0123456789abcdef0123456789abcdef_is_here)
  Program for #456789abcdef0123456789abcdef0123
  $(program_lines_for_456789abcdef0123456789abcdef0123_is_here)
  Program for #89abcdef0123456789abcdef01234567
  $(program_lines_for_89abcdef0123456789abcdef01234567_is_here)
  # syzbot code section end

