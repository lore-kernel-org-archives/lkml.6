Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752111AbeFDKty (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 06:49:54 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:49662 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751418AbeFDKtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 06:49:53 -0400
Subject: Re: [PATCH 1/2] n_tty: Fix stall at n_tty_receive_char_special().
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc: linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
References: <1527295994-3440-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <ce8d7e0f-d7c0-4eb2-5ed5-f38bdb5a975f@I-love.SAKURA.ne.jp>
Date: Mon, 4 Jun 2018 19:49:40 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1527295994-3440-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg, Jiri, will you pick up these patches?

On 2018/05/26 1:12, Greg KH wrote:
> On Thu, May 17, 2018 at 07:11:01AM -0700, syzbot wrote:
>> Hello,
>>
>> syzbot has tested the proposed patch and the reproducer did not trigger
>> crash:
> 
> Great!  Is the patch going to be submitted "properly" so that I can
> queue it up?  :)
> 
> thanks,
> 
> greg k-h
> 

On 2018/05/26 9:53, Tetsuo Handa wrote:
> syzbot is reporting stalls at n_tty_receive_char_special() [1]. This is
> because comparison is not working as expected since ldata->read_head can
> change at any moment. Mitigate this by explicitly masking with buffer size
> when checking condition for "while" loops.
> 
> [1] https://syzkaller.appspot.com/bug?id=3d7481a346958d9469bebbeb0537d5f056bdd6e8
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Reported-by: syzbot <syzbot+18df353d7540aa6b5467@syzkaller.appspotmail.com>
> Fixes: bc5a5e3f45d04784 ("n_tty: Don't wrap input buffer indices at buffer size")
> Cc: Peter Hurley <peter@hurleysoftware.com>
> ---
>  drivers/tty/n_tty.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 

On 2018/05/26 9:53, Tetsuo Handa wrote:
> syzbot is reporting stalls at __process_echoes() [1]. This is because
> since ldata->echo_commit < ldata->echo_tail becomes true for some reason,
> the discard loop is serving as almost infinite loop. This patch tries to
> avoid falling into ldata->echo_commit < ldata->echo_tail situation by
> making access to echo_* variables more carefully.
> 
> Since reset_buffer_flags() is called without output_lock held, it should
> not touch echo_* variables. And omit a call to reset_buffer_flags() from
> n_tty_open() by using vzalloc().
> 
> Since add_echo_byte() is called without output_lock held, it needs memory
> barrier between storing into echo_buf[] and incrementing echo_head counter.
> echo_buf() needs corresponding memory barrier before reading echo_buf[].
> Lack of handling the possibility of not-yet-stored multi-byte operation
> might be the reason of falling into ldata->echo_commit < ldata->echo_tail
> situation, for if I do WARN_ON(ldata->echo_commit == tail + 1) prior to
> echo_buf(ldata, tail + 1), the WARN_ON() fires.
> 
> Also, explicitly masking with buffer for the former "while" loop, and
> use ldata->echo_commit > tail for the latter "while" loop.
> 
> [1] https://syzkaller.appspot.com/bug?id=17f23b094cd80df750e5b0f8982c521ee6bcbf40
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Reported-by: syzbot <syzbot+108696293d7a21ab688f@syzkaller.appspotmail.com>
> Cc: Peter Hurley <peter@hurleysoftware.com>
> ---
>  drivers/tty/n_tty.c | 42 ++++++++++++++++++++++++------------------
>  1 file changed, 24 insertions(+), 18 deletions(-)
