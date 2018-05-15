Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752430AbeEOVnm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 17:43:42 -0400
Received: from mail-wr0-f169.google.com ([209.85.128.169]:40214 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752383AbeEOVnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 17:43:41 -0400
X-Google-Smtp-Source: AB8JxZptKNEo6kFFscACuZ5Dndgeoe/1ZNK1I6q7Il38EfmSUxfD+4bYwcLrH5hhXmcWgh6K5WbIJg==
Date: Wed, 16 May 2018 00:43:37 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: "Anvin, H Peter" <h.peter.anvin@intel.com>
Cc: "Ye, Xiaolong" <xiaolong.ye@intel.com>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>, Denys Vlasenko <dvlasenk@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        "tipbuild@zytor.com" <tipbuild@zytor.com>, "lkp@01.org" <lkp@01.org>
Subject: Re: [lkp-robot] [x86/asm]  51bad67ffb: int3:#[##]
Message-ID: <20180515214337.GA18021@avx2>
References: <20180515080033.GA7714@yexl-desktop>
 <20180515210757.GA12225@avx2>
 <C40DC70F50313144AB3AF8625D4F407F90689B42@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <C40DC70F50313144AB3AF8625D4F407F90689B42@ORSMSX101.amr.corp.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 09:25:53PM +0000, Anvin, H Peter wrote:
> Why is that a problem?
> Code: 00 00 00 eb e6 cc cc cc cc cc cc cc cc cc cc cc cc cc fa 8d b6 00 00 00 00 e8 5d e8 8f ff 8b 44 24 34 83 e0 03 83 f8 03 72 28 cc &lt;cc&gt; cc cc cc cc cc cc fa 8d b6 00 00 00 00 e8 3d e8 8f ff 89 e0
> 
> EIP: ret_from_intr+0xd/0x14 SS:ESP: 0068:8603bfb4
> 
> INT3 slipped through M586 =&gt; X86_ALIGNMENT_16 :-\

I could make the patch x86_64 only, but!

It crashed into the middle of the padding.

796ef8fc <ret_from_intr>:
796ef8fc:       8b 44 24 34             mov    eax,DWORD PTR [esp+0x34]
796ef900:       83 e0 03                and    eax,0x3
796ef903:       83 f8 03                cmp    eax,0x3
796ef906:       72 28                   jb     796ef930 <resume_kernel>
796ef908:       cc                      int3
796ef909:       cc       <========>     int3
796ef90a:       cc                      int3
796ef90b:       cc                      int3
796ef90c:       cc                      int3
796ef90d:       cc                      int3
796ef90e:       cc                      int3
796ef90f:       cc                      int3
