Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752034AbeECGHt (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 02:07:49 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:46942 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751623AbeECGHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 02:07:46 -0400
X-Google-Smtp-Source: AB8JxZqAK0u/FAkBIU8fG0zp0tPSS1Jy9x3K09QkQEQgOgspGW7eo6tEMGs2tulR4uFhqLBTTHPLEG6n1WoMWngJPBk=
MIME-Version: 1.0
In-Reply-To: <1356afb7-80cf-d9d9-c282-e4e819807376@I-love.SAKURA.ne.jp>
References: <000000000000d2fe62056b3ccca5@google.com> <1356afb7-80cf-d9d9-c282-e4e819807376@I-love.SAKURA.ne.jp>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 3 May 2018 08:07:24 +0200
Message-ID: <CACT4Y+aJoMQMthMW8UXQ0eVSuwxk3HqFSuSgMtZTFHAuD5bP5A@mail.gmail.com>
Subject: Re: INFO: rcu detected stall in __schedule
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: syzbot <syzbot+f16b3e3512a1e3c1d1f6@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-ppp@vger.kernel.org,
        netdev <netdev@vger.kernel.org>, paulus@samba.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4367xcF006690

On Thu, May 3, 2018 at 7:45 AM, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> I'm not sure whether this is a PPP bug.
>
> As of uptime = 484, RCU says that it stalled for 125 seconds.
>
> ----------
> [  484.407032] INFO: rcu_sched self-detected stall on CPU
> [  484.412488]  0-...!: (125000 ticks this GP) idle=f3e/1/4611686018427387906 softirq=112858/112858 fqs=0
> [  484.422300]   (t=125000 jiffies g=61626 c=61625 q=1534)
> [  484.427663] rcu_sched kthread starved for 125000 jiffies! g61626 c61625 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x402 ->cpu=0
> ----------
>
> 484 - 125 = 359, which was about to start SND related fuzzing in that log.
>
> ----------
> 2033/05/18 03:36:31 executing program 1:
> r0 = socket(0x40000a, 0x5, 0x7)
> setsockopt$inet_int(r0, 0x0, 0x18, &(0x7f0000000000)=0x200, 0x4)
> bind$inet6(r0, &(0x7f00000000c0)={0xa, 0x0, 0x0, @loopback={0x0, 0x1}}, 0x1c)
> perf_event_open(&(0x7f0000000040)={0x2, 0x70, 0x3e5}, 0x0, 0xffffffffffffffff, 0xffffffffffffffff, 0x0)
> timer_create(0x0, &(0x7f00000001c0)={0x0, 0x15, 0x0, @thr={&(0x7f0000000440), &(0x7f0000000540)}}, &(0x7f0000000200))
> timer_getoverrun(0x0)
> perf_event_open(&(0x7f000025c000)={0x2, 0x78, 0x3e3}, 0x0, 0x0, 0xffffffffffffffff, 0x0)
> r1 = syz_open_dev$sndctrl(&(0x7f0000000200)='/dev/snd/controlC#\x00', 0x2, 0x0)
> perf_event_open(&(0x7f0000001000)={0x0, 0x70, 0x0, 0x0, 0x0, 0x0, 0x0, 0x8ce, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x7, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0xfffffffffffffff8, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, @perf_bp={&(0x7f0000005000), 0x2}, 0x1000000000c}, 0x0, 0x0, 0xffffffffffffffff, 0x0)
> ioctl$SNDRV_CTL_IOCTL_SUBSCRIBE_EVENTS(r1, 0xc0045516, &(0x7f00000000c0)=0x1)
> r2 = syz_open_dev$sndpcmp(&(0x7f0000000100)='/dev/snd/pcmC#D#p\x00', 0x1, 0x4000)
> ioctl$SNDRV_SEQ_IOCTL_GET_QUEUE_CLIENT(r2, 0xc04c5349, &(0x7f0000000240)={0x200, 0xfffffffffffffcdc, 0x1})
> syz_open_dev$tun(&(0x7f00000003c0)='/dev/net/tun\x00', 0x0, 0x20402)
> ioctl$SNDRV_CTL_IOCTL_PVERSION(r1, 0xc1105517, &(0x7f0000001000)=""/250)
> ioctl$SNDRV_CTL_IOCTL_SUBSCRIBE_EVENTS(r1, 0xc0045516, &(0x7f0000000000))
>
> 2033/05/18 03:36:31 executing program 4:
> syz_emit_ethernet(0x3e, &(0x7f00000000c0)={@broadcast=[0xff, 0xff, 0xff, 0xff, 0xff, 0xff], @empty=[0x0, 0x0, 0xb00000000000000], [], {@ipv4={0x800, {{0x5, 0x4, 0x0, 0x0, 0x30, 0x0, 0x0, 0x0, 0x1, 0x0, @remote={0xac, 0x14, 0x14, 0xbb}, @dev={0xac, 0x14, 0x14}}, @icmp=@parameter_prob={0x5, 0x4, 0x0, 0x0, 0x0, 0x0, {0x5, 0x4, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, @local={0xac, 0x223, 0x14, 0xaa}, @dev={0xac, 0x14, 0x14}}}}}}}, &(0x7f0000000000)={0x0, 0x2, [0x0, 0x2e6]})
>
> 2033/05/18 03:36:31 executing program 1:
> r0 = socket$pppoe(0x18, 0x1, 0x0)
> connect$pppoe(r0, &(0x7f00000000c0)={0x18, 0x0, {0x1, @broadcast=[0xff, 0xff, 0xff, 0xff, 0xff, 0xff], 'ip6_vti0\x00'}}, 0x1e)
> r1 = socket(0x3, 0xb, 0x80000001)
> setsockopt$inet_sctp6_SCTP_ADAPTATION_LAYER(r1, 0x84, 0x7, &(0x7f0000000100)={0x2}, 0x4)
> ioctl$sock_inet_SIOCGIFADDR(r0, 0x8915, &(0x7f0000000040)={'veth1_to_bridge\x00', {0x2, 0x4e21}})
> r2 = syz_open_dev$admmidi(&(0x7f0000000000)='/dev/admmidi#\x00', 0x6, 0x8000)
> setsockopt$SO_VM_SOCKETS_BUFFER_MAX_SIZE(r2, 0x28, 0x2, &(0x7f0000000080)=0xffffffffffffff00, 0x8)
>
> [  359.306427] snd_virmidi snd_virmidi.0: control 112:0:0:� :0 is already present
> ----------


It's the next one that caused the hang (the number in "Comm:
syz-executor1" matches with the number in "executing program 1"):

[  359.306427] snd_virmidi snd_virmidi.0: control 112:0:0:� :0 is
already present
2033/05/18 03:36:31 executing program 1:
r0 = openat$ptmx(0xffffffffffffff9c,
&(0x7f0000000140)='/dev/ptmx\x00', 0x0, 0x0)
ioctl$TCSETS(r0, 0x40045431, &(0x7f00005befdc))
r1 = syz_open_pts(r0, 0x20201)
fcntl$setstatus(r1, 0x4, 0x2800)
ioctl$TCXONC(r1, 0x540a, 0x0)
perf_event_open(&(0x7f000025c000)={0x2, 0x70, 0x3e5, 0x0, 0x0, 0x0,
0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, @perf_bp={&(0x7f000031f000)}}, 0x0,
0x0, 0xffffffffffffffff, 0x0)
write(r1, &(0x7f0000fd6000)='z', 0x1)
r2 = openat$ipvs(0xffffffffffffff9c,
&(0x7f0000000000)='/proc/sys/net/ipv4/vs/sync_ports\x00', 0x2, 0x0)
ioctl$ifreq_SIOCGIFINDEX_team(0xffffffffffffff9c, 0x8933,
&(0x7f00000012c0)={'team0\x00', <r3=>0x0})
bind$packet(r2, &(0x7f0000001300)={0x11, 0x1f, r3, 0x1, 0x0, 0x6,
@random="31e8917e98e6"}, 0x14)
ioctl$TIOCSETD(r1, 0x5423, &(0x7f00000000c0)=0x3)
ioctl$TCFLSH(r0, 0x540b, 0x0)
close(r0)
