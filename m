Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934421AbeBLP4S (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 10:56:18 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:46159 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933935AbeBLP4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 10:56:02 -0500
X-Google-Smtp-Source: AH8x227qvVbDJvgJM2NpnfLn8Z1ft51YXt8efpVVegW+7Ymz1zl45QcBjVsca88pXD7RRDcZDA7PSQ==
Date: Mon, 12 Feb 2018 07:55:58 -0800
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Yonghong Song <yhs@fb.com>, Mathieu Malaterre <malat@debian.org>,
        Alexei Starovoitov <ast@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [kmemleak] unreferenced object 0xcd9c1a80 (size 192):
Message-ID: <20180212155556.5glgl6qorvuwvubs@ast-mbp.dhcp.thefacebook.com>
References: <CA+7wUsyxpHnq_POujjwEVXhJjE5GRLN9GypV+63g1OFmfq=_ZA@mail.gmail.com>
 <CAADnVQJnobUCg4ZEkHUgAAMXiw5w1K1DLqo09005mPPgOuLD+g@mail.gmail.com>
 <CA+7wUswo-XwiMEcSTnB3HQE6qo2YUJxeSNije3KtFoy6CqzQoQ@mail.gmail.com>
 <3fa5958d-c14e-56bd-de49-84fc43db4b32@fb.com>
 <609d04c4-f947-ede5-3c4f-28eaf0b14745@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <609d04c4-f947-ede5-3c4f-28eaf0b14745@iogearbox.net>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2018 at 09:28:33AM +0100, Daniel Borkmann wrote:
> On 02/12/2018 06:47 AM, Yonghong Song wrote:
> > On 2/11/18 11:18 AM, Mathieu Malaterre wrote:
> >> On Sun, Feb 11, 2018 at 5:54 PM, Alexei Starovoitov
> >> <alexei.starovoitov@gmail.com> wrote:
> >>> On Sun, Feb 11, 2018 at 7:24 AM, Mathieu Malaterre <malat@debian.org> wrote:
> >>>> Alexei,
> >>>>
> >>>> Could you please comment on why I am seeing those memleaks being
> >>>> reported on my ppc32 system ? Should they be marked as false positive
> >>>> ?
> >>>>
> >>>> System is Mac Mini G4, git/master (4.15.0+), ppc.
> >>>>
> >>>> Thanks for your time
> >>>>
> >>>> $ dmesg
> >>>> ...
> >>>> [ 1281.504173] kmemleak: 36 new suspected memory leaks (see
> >>>> /sys/kernel/debug/kmemleak)
> >>>>
> >>>> Where:
> >>>>
> >>>> # cat /sys/kernel/debug/kmemleak
> >>>> unreferenced object 0xdee25000 (size 192):
> >>>>    comm "systemd", pid 1, jiffies 4294894348 (age 1438.580s)
> >>>>    hex dump (first 32 bytes):
> >>>>      c0 56 2f 88 00 00 00 00 00 00 00 0b 00 00 00 0c  .V/.............
> >>>>      00 00 00 08 00 00 00 01 00 00 00 01 00 00 00 01  ................
> >>>>    backtrace:
> >>>>      [<6c69baf5>] trie_alloc+0xb0/0x150
> >>>>      [<fa093284>] SyS_bpf+0x288/0x1458
> >>>>      [<82182f53>] ret_from_syscall+0x0/0x38
> >>>> unreferenced object 0xdee25900 (size 192):
> >>>>    comm "systemd", pid 1, jiffies 4294894540 (age 1437.812s)
> >>>>    hex dump (first 32 bytes):
> >>>>      c0 56 2f 88 00 00 00 00 00 00 00 0b 00 00 00 08  .V/.............
> >>>>      00 00 00 08 00 00 00 01 00 00 00 01 00 00 00 01  ................
> >>>>    backtrace:
> >>>>      [<6c69baf5>] trie_alloc+0xb0/0x150
> >>>>      [<fa093284>] SyS_bpf+0x288/0x1458
> >>>>      [<82182f53>] ret_from_syscall+0x0/0x38
> >>>
> >>> hmm. looks real. Is there a reproducer?
> >>> Yonghong, lpm map not cleaning after itself?
> >>
> >> Not really. I simply boot up my machine and wait for the first kmemleak scan.
> > 
> > I am not able to reproduce the issue. Tried with latest net-next on FC26 with kmemleak on. I only got this one after bootup,
> > 'cat /sys/kernel/debug/kmemleak' or
> > 'echo scan > /sys/kernel/debug/kmemleak
> >  cat /sys/kernel/debug/kmemleak':
> > 
> > unreferenced object 0xffff99701a7386e0 (size 32):
> >   comm "mount", pid 1856, jiffies 4294669263 (age 98.440s)
> >   hex dump (first 32 bytes):
> >     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >   backtrace:
> >     [<000000004668ec00>] security_sb_parse_opts_str+0x36/0x50
> >     [<00000000a9807d2b>] parse_security_options+0x3d/0x60
> >     [<00000000cc1e1d58>] btrfs_mount_root+0x139/0x720
> >     [<00000000bdc4f1a3>] mount_fs+0x30/0x150
> >     [<00000000f189f1bd>] vfs_kern_mount.part.26+0x54/0x100
> >     [<0000000093ae5db7>] btrfs_mount+0x184/0x914
> >     [<00000000bdc4f1a3>] mount_fs+0x30/0x150
> >     [<00000000f189f1bd>] vfs_kern_mount.part.26+0x54/0x100
> >     [<000000003b67b9fc>] do_mount+0x5b9/0xc70
> >     [<00000000de4073a0>] SyS_mount+0x80/0xd0
> >     [<00000000fc5a968a>] do_syscall_64+0x5d/0x110
> >     [<000000003d61f5fc>] entry_SYSCALL_64_after_hwframe+0x21/0x86
> >     [<00000000458a6ffa>] 0xffffffffffffffff
> > 
> > Not sure whether the above is a true issue or not.
> > 
> > However, by inspecting the code, I do find the trie_free in lpm_trie.c
> > may have missed freeing the trie memory.
> > 
> > The change likes below should work:
> > -bash-4.2$ git diff
> > diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
> > index 7b469d1..cecb259 100644
> > --- a/kernel/bpf/lpm_trie.c
> > +++ b/kernel/bpf/lpm_trie.c
> > @@ -589,6 +589,7 @@ static void trie_free(struct bpf_map *map)
> > 
> >  unlock:
> >         raw_spin_unlock(&trie->lock);
> > +       kfree(trie);

also looks like trie_free() is missing
synchronize_rcu() + rcu_barrier()
it doesn't wait for parallel lookup/update/delete to complete
before freeing the elements.
