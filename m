Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751344AbeDELCW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 07:02:22 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:29606 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751178AbeDELCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 07:02:21 -0400
Subject: Re: KASAN: global-out-of-bounds Write in string
To: dhowells@redhat.com, reiserfs-devel@vger.kernel.org
References: <000000000000b696800568f4a6c6@google.com>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: syzbot <syzbot+b890b3335a4d8c608963@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Message-ID: <f1254802-d801-41d6-72ca-33f011e63253@I-love.SAKURA.ne.jp>
Date: Thu, 5 Apr 2018 20:02:06 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <000000000000b696800568f4a6c6@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/04/04 2:01, syzbot wrote:
> BUG: KASAN: global-out-of-bounds in string+0x1cb/0x200 lib/vsprintf.c:598
> Write of size 1 at addr ffffffff89e166a0 by task syz-executor0/4522
> 
> CPU: 1 PID: 4522 Comm: syz-executor0 Not tainted 4.16.0+ #12
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:17 [inline]
>  dump_stack+0x1a7/0x27d lib/dump_stack.c:53
>  print_address_description+0x178/0x250 mm/kasan/report.c:256
>  kasan_report_error mm/kasan/report.c:354 [inline]
>  kasan_report+0x23c/0x360 mm/kasan/report.c:412
>  __asan_report_store1_noabort+0x17/0x20 mm/kasan/report.c:435
>  string+0x1cb/0x200 lib/vsprintf.c:598
>  vsnprintf+0x863/0x1900 lib/vsprintf.c:2282
>  vsprintf+0x2a/0x40 lib/vsprintf.c:2462
>  prepare_error_buf+0x1d2/0x1820 fs/reiserfs/prints.c:240
>  __reiserfs_warning+0xc8/0x1a0 fs/reiserfs/prints.c:267
>  reiserfs_getopt fs/reiserfs/super.c:1044 [inline]
>  reiserfs_parse_options+0x11e5/0x24e0 fs/reiserfs/super.c:1194
>  reiserfs_fill_super+0x520/0x33a0 fs/reiserfs/super.c:1946

> The buggy address belongs to the variable:
>  error_buf+0x400/0x420

I guess this is a buffer overflow bug due to

  static char error_buf[1024];
  char *p = error_buf;
  vsprintf(p, fmt1, args);

at prepare_error_buf(). Need to check available bytes.

> 
> Memory state around the buggy address:
>  ffffffff89e16580: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  ffffffff89e16600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> ffffffff89e16680: 00 00 00 00 fa fa fa fa 04 fa fa fa fa fa fa fa
>                                ^
>  ffffffff89e16700: 00 fa fa fa fa fa fa fa 00 fa fa fa fa fa fa fa
>  ffffffff89e16780: 00 fa fa fa fa fa fa fa 00 fa fa fa fa fa fa fa
> ==================================================================
