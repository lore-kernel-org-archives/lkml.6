Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 1B51DC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 12:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A46E208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 12:09:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hW/xrCUv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A46E208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933593AbeFLMJ3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 08:09:29 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:38456 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933076AbeFLMJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 08:09:27 -0400
Received: by mail-pf0-f195.google.com with SMTP id b74-v6so12008399pfl.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 05:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dx7Tdy0qTBbbDuKCNkXcVBMmiBF12kZGFHSg6QoVn3w=;
        b=hW/xrCUvksYJ/7SGsRq2aJ497pjR3BRJwaMR7RKdbWwSqoG2ct8SADvPfjaj/7YDw8
         odQ5Qn1LIjga/0fp7zXIvslNeVOoP8ASvx7Ff/JsMoeAkzQ4pCTtoFoucXY2/HrBnY4R
         GHm833l0G8chuj4oPfGENosqUQPhe+hZ1NPeU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dx7Tdy0qTBbbDuKCNkXcVBMmiBF12kZGFHSg6QoVn3w=;
        b=X/7uZdQqQwmpWyunxlsaSwWTbewj5+SDYN+q8uQdgLg9g2kIuAk6Mfi5uzcRmptzBN
         jdj/m1xXj10RmgRGo8HHvlycc0f+DBFybVpX6sq+me7YOqMI5w5cJPqxnKp0hOgkV3IT
         QyuWjgjUHgZRoONZLhS+erUQgre+neOhPZnHriW3LU+Yr+y+38oDKEcLVgngnp71DaPy
         MIMMEjLOHL6b7SRGpp0FVOEGDwNwfXeROiGFheDEP0C+MYY4voQxpu1LoEUQ1ZDmGLVN
         oKo30MIlK3hoFl6XBApk9caa1DWTZeHZSpQrvaX9TyKazAaTzXkCHZRTgeiFmJ3mTBG4
         dpWA==
X-Gm-Message-State: APt69E0pX5OSa5ParJ+v3Ia5TGXYB8ZE76o3+XMgbFJL0SaUvOb7jbib
        5P7JCejINyG98j5bdn7WZS9J0kaqps9XDKQOUCcFIA==
X-Google-Smtp-Source: ADUXVKKEhAr3g8lea9b/VwuTLQi8UfG5HnRXDsPv5r8a31B/NbKvN6IQf+l6HmpWVYSRPpzPulOMUKjyx0IxV+D8fAA=
X-Received: by 2002:a62:4395:: with SMTP id l21-v6mr120803pfi.196.1528805365601;
 Tue, 12 Jun 2018 05:09:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:178d:0:0:0:0 with HTTP; Tue, 12 Jun 2018 05:09:25
 -0700 (PDT)
In-Reply-To: <20180612083435.7f7k4exergraaa2u@gauss3.secunet.de>
References: <CA+G9fYuuiYES7ucAhgf8P-YXJPaYY2pi6kRKf6eBrfHvXJbQiw@mail.gmail.com>
 <20180612083435.7f7k4exergraaa2u@gauss3.secunet.de>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Tue, 12 Jun 2018 14:09:25 +0200
Message-ID: <CADYN=9LztFGUOb-RaEByN-G-E1MpnEv_HtZtObhyZUWWt0nffg@mail.gmail.com>
Subject: Re: mainline: x86_64: kernel panic: RIP: 0010:__xfrm_policy_check+0xcb/0x690
To:     Steffen Klassert <steffen.klassert@secunet.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Networking <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        herbert@gondor.apana.org.au,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 June 2018 at 10:34, Steffen Klassert <steffen.klassert@secunet.com> w=
rote:
> On Mon, Jun 11, 2018 at 10:11:46PM +0530, Naresh Kamboju wrote:
>> Kernel panic on x86_64 machine running mainline 4.17.0 kernel while test=
ing
>> selftests bpf test_tunnel.sh test caused this kernel panic.
>> I have noticed this kernel panic start happening from
>> 4.17.0-rc7-next-20180529 and still happening on 4.17.0-next-20180608.
>>
>> [  213.638287] BUG: unable to handle kernel NULL pointer dereference
>> at 0000000000000008
>> ++[ ip xfrm poli  213.674036] PGD 0 P4D 0
>> [  213.674118] audit: type=3D1327 audit(1528917683.623:7):
>> proctitle=3D6970007866726D00706F6C69637900616464007372630031302E312E312E=
3130302F3332006473740031302E312E312E3230302F33320064697200696E00746D706C007=
37263003137322E31362E312E31303000647374003137322E31362E312E3230300070726F74=
6F006573700072657169640031006D6F64650074756E6E
>> [  213.677950] Oops: 0000 [#1] SMP PTI
>> cy[ add src 10.1.  213.677952] CPU: 2 PID: 0 Comm: swapper/2 Tainted:
>> G        W         4.17.0-next-20180608 #1
>> [  213.677953] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
>> 2.0b 07/27/2017
>> [  213.726998] RIP: 0010:__xfrm_policy_check+0xcb/0x690
>> [  213.731962] Code: 80 3d 0a d8 f1 00 00 0f 84 c1 02 00 00 4c 8b 25
>> 2b af f4 00 e8 66 a6 6a ff 85 c0 74 0d 80 3d eb d7 f1 00 00 0f 84 d5
>> 02 00 00 <49> 8b 44 24 08 48 85 c0 74 0c 48 8d b5 78 ff ff ff 4c 89 ff
>> ff d0
>
> This looks like a bug that I've seen already. If it is what I think,
> then commit 2c205dd3981f ("netfilter: add struct nf_nat_hook and use
> it") introduced this bug.
>
> There was already a fix for this on the netdev list, but
> I don't know the current status of that patch:
>
> https://patchwork.ozlabs.org/patch/921387/

Hi, I applied the patch and ran bpf/test_tunnel.sh and I I couldn't
see any crash.
However, the script never returned (I had to Ctrl+c to get back), any ideas=
 ?
See log from the test below.

Cheers,
Anders

Testing IPSec tunnel...
[  269.060050] IPv6: ADDRCONF(NETDEV_UP): veth0: link is not ready
[  269.090000] IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
          <idle>-0     [000] ..s3   190.987095: 0: key 2 remote ip 0xac1001=
64
            ping-3043  [000] ..s3   190.988715: 0: key 2 remote ip 0xac1001=
64
     ksoftirqd/0-9     [000] ..s2   190.988986: 0: key 2 remote ip 0xac1001=
64
 systemd-resolve-2664  [003] ..s3   191.083771: 0: ERROR line:77 ret:-22
 systemd-resolve-2664  [003] ..s3   191.333763: 0: ERROR line:77 ret:-22
     kworker/0:1-33    [000] ..s4   191.419445: 0: key 2 remote ip 0xac1001=
64
            ping-3043  [000] ..s3   191.989437: 0: key 2 remote ip 0xac1001=
64
     kworker/0:1-33    [000] ..s4   192.443460: 0: key 2 remote ip 0xac1001=
64
     kworker/0:1-33    [000] ..s4   192.443508: 0: key 2 remote ip 0xac1001=
64
          <idle>-0     [000] ..s3   192.446318: 0: key 2 remote ip 0xac1001=
64
 systemd-resolve-2664  [000] ..s3   192.768767: 0: ERROR line:77 ret:-22
            ping-3043  [000] ..s3   192.989902: 0: key 2 remote ip 0xac1001=
64
            ping-3044  [000] ..s3   193.025776: 0: key 2 remote ip 0xac1001=
64
 systemd-resolve-2664  [000] ..s3   193.083650: 0: ERROR line:77 ret:-22
 systemd-resolve-2664  [000] ..s3   193.333865: 0: ERROR line:77 ret:-22
            ping-3044  [000] ..s3   194.026240: 0: key 2 remote ip 0xac1001=
64
            ping-3044  [000] ..s3   195.026707: 0: key 2 remote ip 0xac1001=
64
     ksoftirqd/2-21    [002] ..s2   198.075583: 0: key 2 remote ip6
::11000000 label bcdef
     ksoftirqd/2-21    [002] ..s2   198.075597: 0: key 2 remot[
269.270883] audit: type=3D1415 audit(1532018021.150:6): op=3DSAD-add
auid=3D0 ses=3D2 subj=3Dkerne
l src=3D172.16.1.100 dst=3D172.16.1.200 spi=3D1(0x1) res=3D1
[  269.284308] audit: type=3D1300 audit(1532018021.150:6): arch=3Dc000003e
syscall=3D46 success=3Dyes exit=3D424 a0=3D4 a1=3D7ffff18d1ba0 a2=3D0 a3=3D=
5e9
items=3D0 ppid=3D2924
 pid=3D4333 auid=3D0 uid=3D0 gid=3D0 euid=3D0 suid=3D0 fsuid=3D0 egid=3D0 s=
gid=3D0
fsgid=3D0 tty=3Dpts0 ses=3D2 comm=3D\"ip\" exe=3D\"/sbin/ip.iproute2\"
subj=3Dkernel key=3D(null)
[  269.310249] audit: type=3D1327 audit(1532018021.150:6):
proctitle=3D6970007866726D0073746174650061646400737263003137322E31362E312E3=
1303000647374003137322E
31362E312E3230300070726F746F0065737000737069003078310072657169640031006D6F6=
4650074756E6E656C00617574682D7472756E6300686D616328736861312900307831313131=
313
13131313131313131
e ip6 ::11000000 label bcdef
            ping-3164  [003] ..s3   198.113160: 0: key 2 remote ip6
::11000000 label bcdef
            ping-3164  [003] ..s3   199.113661: 0: key 2 remote ip6
::11000000 label bcdef
          <idle>-0     [000] ..s3   199.931430: 0: key 2 remote ip6
::11000000 label bcdef
            ping-3164  [003] ..s3   200.114432: 0: key 2 remote ip6
::11000000 label bcdef
            ping-3[  269.374987] audit: type=3D1415
audit(1532018021.373:7): op=3DSPD-add auid=3D0 ses=3D2 subj=3Dkernel res=3D=
1
src=3D10.1.1.100 dst=3D10.1.1.200
165  [002] ..s3 [  269.386787] audit: type=3D1300
audit(1532018021.373:7): arch=3Dc000003e syscall=3D46 success=3Dyes exit=3D=
252
a0=3D4 a1=3D7ffe1e400ff0 a2=3D0 a3=3D5e9 i
tems=3D0 ppid=3D2924 pid=3D4354 auid=3D0 uid=3D0 gid=3D0 euid=3D0 suid=3D0 =
fsuid=3D0
egid=3D0 sgid=3D0 fsgid=3D0 tty=3Dpts0 ses=3D2 comm=3D\"ip\"
exe=3D\"/sbin/ip.iproute2\" subj=3Dkernel
 key=3D(null)
[  269.414124] audit: type=3D1327 audit(1532018021.373:7):
proctitle=3D6970007866726D00706F6C69637900616464007372630031302E312E312E313=
0302F333200647374003130
2E312E312E3230302F333200646972006F757400746D706C00737263003137322E31362E312=
E31303000647374003137322E31362E312E3230300070726F746F0065737000726571696400=
310
06D6F64650074756E
  200.133573: 0: key 2 remote ip6 ::11000000 label bcdef
            ping-3165  [002] ..s3   201.134091: 0: key 2 remote ip6
::11000000 label bcdef
            ping-3165  [002] ..s3   202.134600: 0: key 2 remote ip6
::11000000 label bcdef
           ping6-3167  [000] ..s3   202.172808: 0: key 2 remote ip6
::11000000 label bcdef
  [  269.471306] audit: type=3D1415 audit(1532018021.470:8): op=3DSAD-add
auid=3D0 ses=3D2 subj=3Dkernel src=3D172.16.1.200 dst=3D172.16.1.100 spi=3D=
2(0x2)
res=3D1
[  269.484439] audit: type=3D1300 audit(1532018021.470:8): arch=3Dc000003e
syscall=3D46 success=3Dyes exit=3D424 a0=3D4 a1=3D7ffc79931450 a2=3D0 a3=3D=
5e9
items=3D0 ppid=3D2924
 pid=3D4355 auid=3D0 uid=3D0 gid=3D0 euid=3D0 suid=3D0 fsuid=3D0 egid=3D0 s=
gid=3D0
fsgid=3D0 tty=3Dpts0 ses=3D2 comm=3D\"ip\" exe=3D\"/sbin/ip.iproute2\"
subj=3Dkernel key=3D(null)
[  269.510375] audit: type=3D1327 audit(1532018021.470:8):
proctitle=3D6970007866726D0073746174650061646400737263003137322E31362E312E3=
2303000647374003137322E
31362E312E3130300070726F746F0065737000737069003078320072657169640032006D6F6=
4650074756E6E656C00617574682D7472756E6300686D616328736861312900307831313131=
313
13131313131313131
         ping6-3167  [000] ..s3   203.173251: 0: key 2 remote ip6
::11000000 label bcdef
           ping6-3167  [000] ..s3   204.173741: 0: key 2 remote ip6
::11000000 label bcdef
 systemd-resolve-2664  [001] ..s3   205.333801: 0: ERROR line:119 ret:-22
 systemd-resolve-2664  [001] ..s3   205.583819: 0: ERROR line:119 ret:-22
 systemd-resolve-2664  [001] ..s3   205.833437: 0: E[  269.572155]
audit: type=3D1415 audit(1532018021.571:9): op=3DSPD-add auid=3D0 ses=3D2
subj=3Dkernel res=3D1 sr
c=3D10.1.1.200 dst=3D10.1.1.100
RROR line:119 ret:-22
 systemd-resolve-2664  [001] ..s3   206.583819: 0: ERROR line:119 ret:-22
 systemd-resolve-2664  [003] ..s3   206.782769: 0: ERROR line:119 ret:-22
     kworker/3:2-1537  [003] ..s4   207.035785: 0: key 2 remote ip6
::11000000 label bcdef
     kworker/3:2-1537  [003] ..s4   207.035796: 0: key 2 remote ip6
::11000000 label bcdef
     kworker/3:2-1537  [003] ..s4   207.035890: 0: key 2 remote ip6
::11000000 label bcdef
     kworker/3:2-1537  [003] ..s4   207.035926: 0: key 2 remote ip6
::11000000 label bcdef
 systemd-resolve-2664  [000] ..s3   207.083608: 0: ERROR line:119 ret:-22
     ksoftirqd/3-26    [003] ..s2   207.739454: 0: key 2 remote ip6
::11000000 label bcdef
            ping-3298  [000] ..s3   208.263120: 0: key 2 remote ip6
::11000000 label bcdef
            ping-3298  [000] ..s3   208.263224: 0: key 2 remote ip6
::11000000 label bcdef
            ping-3298  [000] ..s3   209.263703: 0: key 2 remote ip6
::11000000 label bcdef
            ping-3298  [000] ..s3   210.264203: 0: key 2 remote ip6
::11000000 label bcdef
            ping-3299  [002] ..s3   210.279710: 0: key 2 remote ip6
::11000000 label bcdef
          <idle>-0     [003] ..s3   210.875420: 0: key 2 remote ip6
::11000000 label bcdef
            ping-3299  [002] ..s3   211.280241: 0: key 2 remote ip6
::11000000 label bcdef
     ksoftirqd/3-26    [003] ..s2   212.219559: 0: key 2 remote ip6
::11000000 label bcdef
            ping-3299  [002] ..s3   212.280741: 0: key 2 remote ip6
::11000000 label bcdef
           ping6-3300  [002] ..s3   212.315807: 0: key 2 remote ip6
::11000000 label bcdef
           ping6-3300  [002] ..s3   213.316255: 0: key 2 remote ip6
::11000000 label bcdef
          <idle>-0     [000] ..s3   213.755462: 0: key 2 remote ip6
::11000000 label bcdef
           ping6-3300  [002] ..s3   214.316506: 0: key 2 remote ip6
::11000000 label bcdef
           ping6-3300  [002] ..s3   215.316951: 0: key 2 remote ip6
::11000000 label bcdef
           ping6-3300  [002] ..s3   216.317320: 0: key 2 remote ip6
::11000000 label bcdef
           ping6-3300  [002] ..s3   217.317765: 0: key 2 remote ip6
::11000000 label bcdef
     ksoftirqd/3-26    [003] ..s2   217.339464: 0: key 2 remote ip6
::11000000 label bcdef
           ping6-3300  [002] ..s3   218.318227: 0: key 2 remote ip6
::11000000 label bcdef
     ksoftirqd/3-26    [003] ..s2   218.875455: 0: key 2 remote ip6
::11000000 label bcdef
           ping6-3300  [002] ..s3   219.318671: 0: key 2 remote ip6
::11000000 label bcdef
           ping6-3300  [002] ..s3   220.319141: 0: key 2 remote ip6
::11000000 label bcdef
           ping6-3300  [002] ..s3   221.319585: 0: key 2 remote ip6
::11000000 label bcdef
            ping-3419  [002] ..s3   223.036234: 0: key 2 remote ip
0xac100164 erspan version 2
            ping-3419  [002] ..s3   223.036236: 0:      direction 1
hwid 3 timestamp 31402699
            ping-3419  [002] ..s3   223.036256: 0: key 2 remote ip
0xac100164 erspan version 2
            ping-3419  [002] ..s3   223.036256: 0:      direction 1
hwid 3 timestamp 31402699
          <idle>-0     [000] ..s3   223.067438: 0: key 2 remote ip
0xac100164 erspan version 2
          <idle>-0     [000] ..s3   223.067443: 0:      direction 1
hwid 3 timestamp 31403010
 systemd-resolve-2664  [000] ..s3   223.083837: 0: ERROR line:183 ret:-22
     kworker/0:1-33    [000] ..s4   223.283447: 0: key 2 remote ip
0xac100164 erspan version 2
     kworker/0:1-33    [000] ..s4   223.283452: 0:      direction 1
hwid 3 timestamp 31405171
 systemd-resolve-2664  [000] ..s3   223.333807: 0: ERROR line:183 ret:-22
 systemd-resolve-2664  [000] ..s3   223.583816: 0: ERROR line:183 ret:-22
            ping-3419  [002] ..s3   224.036713: 0: key 2 remote ip
0xac100164 erspan version 2
            ping-3419  [002] ..s3   224.036718: 0:      direction 1
hwid 3 timestamp 31412704
     kworker/0:1-33    [000] ..s4   224.315459: 0: key 2 remote ip
0xac100164 erspan version 2
     kworker/0:1-33    [000] ..s4   224.315464: 0:      direction 1
hwid 3 timestamp 31415491
     kworker/0:1-33    [000] ..s4   224.315514: 0: key 2 remote ip
0xac100164 erspan version 2
     kworker/0:1-33    [000] ..s4   224.315516: 0:      direction 1
hwid 3 timestamp 31415492
          <idle>-0     [000] ..s3   224.675428: 0: key 2 remote ip
0xac100164 erspan version 2
          <idle>-0     [000] ..s3   224.675433: 0:      direction 1
hwid 3 timestamp 31419090
            ping-3419  [002] ..s3   225.036920: 0: key 2 remote ip
0xac100164 erspan version 2
            ping-3419  [002] ..s3   225.036925: 0:      direction 1
hwid 3 timestamp 31422706
            ping-3420  [003] ..s3   225.064293: 0: key 2 remote ip
0xac100164 erspan version 2
            ping-3420  [003] ..s3   225.064298: 0:      direction 1
hwid 3 timestamp 31422979
 systemd-resolve-2664  [000] ..s3   225.083664: 0: ERROR line:183 ret:-22
 systemd-resolve-2664  [000] ..s3   225.333742: 0: ERROR line:183 ret:-22
 systemd-resolve-2664  [000] ..s3   225.583778: 0: ERROR line:183 ret:-22
            ping-3420  [003] ..s3   226.064761: 0: key 2 remote ip
0xac100164 erspan version 2
            ping-3420  [003] ..s3   226.064765: 0:      direction 1
hwid 3 timestamp 31432984
            ping-3420  [003] ..s3   227.065237: 0: key 2 remote ip
0xac100164 erspan version 2
            ping-3420  [003] ..s3   227.065242: 0:      direction 1
hwid 3 timestamp 31442989
 systemd-resolve-2664  [003] ..s3   228.186369: 0: ERROR line:269 ret:-22
 systemd-resolve-2664  [003] ..s3   228.333716: 0: ERROR line:269 ret:-22
 systemd-resolve-2664  [003] ..s3   228.583747: 0: ERROR line:269 ret:-22
 systemd-resolve-2664  [001] ..s3   229.833537: 0: ERROR line:269 ret:-22
     kworker/0:1-33    [000] ..s4   229.947659: 0: ip6erspan get key 2
remote ip6 ::0 erspan version 2
     kworker/0:1-33    [000] ..s4   229.947664: 0:      direction 1
hwid 7 timestamp 31471811
     kworker/0:1-33    [000] ..s4   229.947708: 0: ip6erspan get key 2
remote ip6 ::0 erspan version 2
     kworker/0:1-33    [000] ..s4   229.947711: 0:      direction 1
hwid 7 timestamp 31471814
 systemd-resolve-2664  [001] ..s3   230.083782: 0: ERROR line:269 ret:-22
 systemd-resolve-2664  [001] ..s3   230.333523: 0: ERROR line:269 ret:-22
          <idle>-0     [000] ..s3   230.779419: 0: ip6erspan get key 2
remote ip6 ::0 erspan version 2
          <idle>-0     [000] ..s3   230.779424: 0:      direction 1
hwid 7 timestamp 31480130
            ping-3540  [003] ..s3   231.091633: 0: ip6erspan get key 2
remote ip6 ::0 erspan version 2
            ping-3540  [003] ..s3   231.091638: 0:      direction 1
hwid 7 timestamp 31483253
            ping-3540  [003] ..s3   231.091737: 0: ip6erspan get key 2
remote ip6 ::0 erspan version 2
            ping-3540  [003] ..s3   231.091739: 0:      direction 1
hwid 7 timestamp 31483254
            ping-3540  [003] ..s3   232.092227: 0: ip6erspan get key 2
remote ip6 ::0 erspan version 2
            ping-3540  [003] ..s3   232.092232: 0:      direction 1
hwid 7 timestamp 31493259
            ping-3540  [003] ..s3   233.092737: 0: ip6erspan get key 2
remote ip6 ::0 erspan version 2
            ping-3540  [003] ..s3   233.092742: 0:      direction 1
hwid 7 timestamp 31503264
            ping-3655  [000] ..s3   233.957186: 0: key 2 remote ip
0xac100164 vxlan gbp 0x800ff
 systemd-resolve-2664  [001] ..s3   234.065463: 0: ERROR line:339 ret:-22
          <idle>-0     [000] ..s3   234.171427: 0: key 2 remote ip
0xac100164 vxlan gbp 0x94
     kworker/0:1-33    [000] ..s4   234.235502: 0: ERROR line:345 ret:-2
 systemd-resolve-2664  [001] ..s3   234.333813: 0: ERROR line:339 ret:-22
 systemd-resolve-2664  [001] ..s3   234.583761: 0: ERROR line:339 ret:-22
            ping-3655  [000] ..s3   234.957640: 0: key 2 remote ip
0xac100164 vxlan gbp 0x800ff
     kworker/0:1-33    [000] ..s4   235.259475: 0: key 2 remote ip
0xac100164 vxlan gbp 0x94
     kworker/0:1-33    [000] ..s4   235.259528: 0: ERROR line:345 ret:-2
 systemd-resolve-2664  [001] ..s3   235.752142: 0: ERROR line:339 ret:-22
            ping-3655  [000] ..s3   235.958144: 0: key 2 remote ip
0xac100164 vxlan gbp 0x800ff
          <idle>-0     [000] ..s3   235.963159: 0: key 2 remote ip
0xac100164 vxlan gbp 0x94
            ping-3663  [002] ..s3   235.990422: 0: key 2 remote ip
0xac100164 vxlan gbp 0x800ff
 systemd-resolve-2664  [001] ..s3   236.083782: 0: ERROR line:339 ret:-22
 systemd-resolve-2664  [001] ..s3   236.333591: 0: ERROR line:339 ret:-22
            ping-3663  [002] ..s3   236.990900: 0: key 2 remote ip
0xac100164 vxlan gbp 0x800ff
            ping-3663  [002] ..s3   237.991370: 0: key 2 remote ip
0xac100164 vxlan gbp 0x800ff
 systemd-resolve-2664  [002] ..s3   239.083778: 0: ERROR line:387 ret:-22
 systemd-resolve-2664  [002] ..s3   239.333765: 0: ERROR line:387 ret:-22
 systemd-resolve-2664  [002] ..s3   239.583765: 0: ERROR line:387 ret:-22
 systemd-resolve-2664  [001] ..s3   240.194218: 0: ERROR line:387 ret:-22
 systemd-resolve-2664  [001] ..s3   240.333718: 0: ERROR line:387 ret:-22
 systemd-resolve-2664  [001] ..s3   240.583708: 0: ERROR line:387 ret:-22
          <idle>-0     [002] ..s3   240.955492: 0: key 22 remote ip6
::11000000 label 0
          <idle>-0     [002] ..s3   240.955505: 0: key 22 remote ip6
::11000000 label 0
          <idle>-0     [002] ..s3   240.955512: 0: key 22 remote ip6
::11000000 label 0
          <idle>-0     [002] ..s3   240.955518: 0: key 22 remote ip6
::11000000 label 0
          <idle>-0     [002] ..s3   240.955524: 0: key 22 remote ip6
::11000000 label 0
          <idle>-0     [002] ..s3   241.211432: 0: key 22 remote ip6
::11000000 label 0
     ksoftirqd/1-16    [001] ..s2   242.012579: 0: key 22 remote ip6
::11000000 label 0
     ksoftirqd/1-16    [001] ..s2   242.026381: 0: key 22 remote ip6
::11000000 label 0
     ksoftirqd/3-26    [003] ..s2   243.028099: 0: key 22 remote ip6
::11000000 label 0
     ksoftirqd/3-26    [003] ..s2   244.040809: 0: key 22 remote ip6
::11000000 label 0
            ping-3774  [001] ..s3   244.062314: 0: key 22 remote ip6
::11000000 label 0
          <idle>-0     [002] ..s3   244.219413: 0: key 22 remote ip6
::11000000 label 0
            ping-3774  [001] ..s3   245.075208: 0: key 22 remote ip6
::11000000 label 0
            ping-3774  [001] ..s3   246.088218: 0: key 22 remote ip6
::11000000 label 0
            ping-3887  [002] ..s3   246.831153: 0: key 2 remote ip
0xac100164 geneve class 0x0
            ping-3887  [002] ..s3   246.831226: 0: key 2 remote ip
0xac100164 geneve class 0x0
 systemd-resolve-2664  [003] ..s3   246.963398: 0: ERROR line:445 ret:-22
 systemd-resolve-2664  [003] ..s3   247.083859: 0: ERROR line:445 ret:-22
 systemd-resolve-2664  [003] ..s3   247.333815: 0: ERROR line:445 ret:-22
     kworker/1:2-1480  [001] ..s4   247.355451: 0: key 2 remote ip
0xac100164 geneve class 0x0
          <idle>-0     [001] ..s3   247.419431: 0: key 2 remote ip
0xac100164 geneve class 0x0
            ping-3887  [002] ..s3   247.831692: 0: key 2 remote ip
0xac100164 geneve class 0x0
     kworker/1:2-1480  [001] ..s4   248.379561: 0: key 2 remote ip
0xac100164 geneve class 0x0
     kworker/1:2-1480  [001] ..s4   248.379605: 0: key 2 remote ip
0xac100164 geneve class 0x0
 systemd-resolve-2664  [001] ..s3   248.440767: 0: ERROR line:445 ret:-22
          <idle>-0     [001] ..s3   248.459429: 0: key 2 remote ip
0xac100164 geneve class 0x0
 systemd-resolve-2664  [001] ..s3   248.583784: 0: ERROR line:445 ret:-22
            ping-3887  [002] ..s3   248.832187: 0: key 2 remote ip
0xac100164 geneve class 0x0
 systemd-resolve-2664  [001] ..s3   248.833517: 0: ERROR line:445 ret:-22
            ping-3888  [000] ..s3   248.874871: 0: key 2 remote ip
0xac100164 geneve class 0x0
            ping-3888  [000] ..s3   249.875339: 0: key 2 remote ip
0xac100164 geneve class 0x0
            ping-3888  [000] ..s3   250.875805: 0: key 2 remote ip
0xac100164 geneve class 0x0
 systemd-resolve-2664  [003] ..s3   252.032344: 0: ERROR line:509 ret:-22
 systemd-resolve-2664  [003] ..s3   252.333767: 0: ERROR line:509 ret:-22
 systemd-resolve-2664  [003] ..s3   252.583766: 0: ERROR line:509 ret:-22
     kworker/0:1-33    [000] ..s4   253.627615: 0: key 22 remote ip
0x0 geneve class 0x0
     kworker/0:1-33    [000] ..s4   253.627634: 0: key 22 remote ip
0x0 geneve class 0x0
     kworker/0:1-33    [000] ..s4   253.627766: 0: key 22 remote ip
0x0 geneve class 0x0
     kworker/0:1-33    [000] ..s4   253.627797: 0: key 22 remote ip
0x0 geneve class 0x0
     kworker/0:1-33    [000] ..s4   253.627833: 0: key 22 remote ip
0x0 geneve class 0x0
            ping-3997  [001] ..s3   253.915594: 0: key 22 remote ip
0x0 geneve class 0x0
            ping-3998  [002] ..s3   253.946604: 0: key 22 remote ip
0x0 geneve class 0x0
 systemd-resolve-2664  [002] ..s3   253.956160: 0: ERROR line:509 ret:-22
 systemd-resolve-2664  [002] ..s3   254.083777: 0: ERROR line:509 ret:-22
          <idle>-0     [000] ..s3   254.331437: 0: key 22 remote ip
0x0 geneve class 0x0
 systemd-resolve-2664  [002] ..s3   254.333628: 0: ERROR line:509 ret:-22
            ping-3998  [002] ..s3   254.947116: 0: key 22 remote ip
0x0 geneve class 0x0
            ping-3998  [001] ..s3   255.947392: 0: key 22 remote ip
0x0 geneve class 0x0
            ping-4118  [002] ..s3   256.654930: 0: remote ip 0xac100164
            ping-4118  [002] ..s3   257.655393: 0: remote ip 0xac100164
            ping-4118  [002] ..s3   258.655851: 0: remote ip 0xac100164
            ping-4119  [000] ..s3   258.695970: 0: remote ip 0xac100164
            ping-4119  [000] ..s3   259.696426: 0: remote ip 0xac100164
            ping-4119  [000] ..s3   260.696886: 0: remote ip 0xac100164
            ping-4231  [002] ..s3   264.713834: 0: remote ip6 0::11
            ping-4231  [002] ..s3   265.714327: 0: remote ip6 0::11
          <idle>-0     [002] ..s3   265.979423: 0: remote ip6 0::11
            ping-4231  [002] ..s3   266.714822: 0: remote ip6 0::11
            ping-4239  [001] ..s3   266.748758: 0: remote ip6 0::11
            ping-4239  [001] ..s3   267.749244: 0: remote ip6 0::11
            ping-4239  [001] ..s3   268.749737: 0: remote ip6 0::11
            ping-4367  [003] ..s3   270.047776: 0: reqid 1 spi 0x1
remote ip 0xac100164
     ksoftirqd/3-26    [003] ..s2   271.048427: 0: reqid 1 spi 0x1
remote ip 0xac100164
PING 10.1.1.200 (10.1.1.200): 56 data bytes
--- 10.1.1.200 ping statistics ---
3 packets transmitted, 3 packets received, 0% packet loss
round-trip min/avg/max =3D 0.263/0.370/0.579 ms
            ping-4367  [003] ..s3   272.048870: 0: reqid 1 spi 0x1
remote ip 0xac100164
            ping-4367  [003] ..s3   270.047776: 0: reqid 1 spi 0x1
remote ip 0xac100164
     ksoftirqd/3-26    [003] ..s2   271.048427: 0: reqid 1 spi 0x1
remote ip 0xac100164
            ping-4367  [003] ..s3   272.048870: 0: reqid 1 spi 0x1
remote ip 0xac100164
            ping-4367  [003] ..s3   270.047776: 0: reqid 1 spi 0x1
remote ip 0xac100164
     ksoftirqd/3-26    [003] ..s2   271.048427: 0: reqid 1 spi 0x1
remote ip 0xac100164
            ping-4367  [003] ..s3   272.048870: 0: reqid 1 spi 0x1
remote ip 0xac100164
          <idle>-0     [000] ..s3   190.987095: 0: key 2 remote ip 0xac1001=
64
            ping-3043  [000] ..s3   190.988715: 0: key 2 remote ip 0xac1001=
64
     ksoftirqd/0-9     [000] ..s2   190.988986: 0: key 2 remote ip 0xac1001=
64
     kworker/0:1-33    [000] ..s4   191.419445: 0: key 2 remote ip 0xac1001=
64
            ping-3043  [000] ..s3   191.989437: 0: key 2 remote ip 0xac1001=
64
     kworker/0:1-33    [000] ..s4   192.443460: 0: key 2 remote ip 0xac1001=
64
     kworker/0:1-33    [000] ..s4   192.443508: 0: key 2 remote ip 0xac1001=
64
          <idle>-0     [000] ..s3   192.446318: 0: key 2 remote ip 0xac1001=
64
            ping-3043  [000] ..s3   192.989902: 0: key 2 remote ip 0xac1001=
64
            ping-3044  [000] ..s3   193.025776: 0: key 2 remote ip 0xac1001=
64
            ping-3044  [000] ..s3   194.026240: 0: key 2 remote ip 0xac1001=
64
            ping-3044  [000] ..s3   195.026707: 0: key 2 remote ip 0xac1001=
64
            ping-3419  [002] ..s3   223.036234: 0: key 2 remote ip
0xac100164 erspan version 2
            ping-3419  [002] ..s3   223.036256: 0: key 2 remote ip
0xac100164 erspan version 2
          <idle>-0     [000] ..s3   223.067438: 0: key 2 remote ip
0xac100164 erspan version 2
     kworker/0:1-33    [000] ..s4   223.283447: 0: key 2 remote ip
0xac100164 erspan version 2
            ping-3419  [002] ..s3   224.036713: 0: key 2 remote ip
0xac100164 erspan version 2
     kworker/0:1-33    [000] ..s4   224.315459: 0: key 2 remote ip
0xac100164 erspan version 2
     kworker/0:1-33    [000] ..s4   224.315514: 0: key 2 remote ip
0xac100164 erspan version 2
          <idle>-0     [000] ..s3   224.675428: 0: key 2 remote ip
0xac100164 erspan version 2
            ping-3419  [002] ..s3   225.036920: 0: key 2 remote ip
0xac100164 erspan version 2
            ping-3420  [003] ..s3   225.064293: 0: key 2 remote ip
0xac100164 erspan version 2
            ping-3420  [003] ..s3   226.064761: 0: key 2 remote ip
0xac100164 erspan version 2
            ping-3420  [003] ..s3   227.065237: 0: key 2 remote ip
0xac100164 erspan version 2
            ping-3655  [000] ..s3   233.957186: 0: key 2 remote ip
0xac100164 vxlan gbp 0x800ff
          <idle>-0     [000] ..s3   234.171427: 0: key 2 remote ip
0xac100164 vxlan gbp 0x94
            ping-3655  [000] ..s3   234.957640: 0: key 2 remote ip
0xac100164 vxlan gbp 0x800ff
     kworker/0:1-33    [000] ..s4   235.259475: 0: key 2 remote ip
0xac100164 vxlan gbp 0x94
            ping-3655  [000] ..s3   235.958144: 0: key 2 remote ip
0xac100164 vxlan gbp 0x800ff
          <idle>-0     [000] ..s3   235.963159: 0: key 2 remote ip
0xac100164 vxlan gbp 0x94
            ping-3663  [002] ..s3   235.990422: 0: key 2 remote ip
0xac100164 vxlan gbp 0x800ff
            ping-3663  [002] ..s3   236.990900: 0: key 2 remote ip
0xac100164 vxlan gbp 0x800ff
            ping-3663  [002] ..s3   237.991370: 0: key 2 remote ip
0xac100164 vxlan gbp 0x800ff
            ping-3887  [002] ..s3   246.831153: 0: key 2 remote ip
0xac100164 geneve class 0x0
            ping-3887  [002] ..s3   246.831226: 0: key 2 remote ip
0xac100164 geneve class 0x0
     kworker/1:2-1480  [001] ..s4   247.355451: 0: key 2 remote ip
0xac100164 geneve class 0x0
          <idle>-0     [001] ..s3   247.419431: 0: key 2 remote ip
0xac100164 geneve class 0x0
            ping-3887  [002] ..s3   247.831692: 0: key 2 remote ip
0xac100164 geneve class 0x0
     kworker/1:2-1480  [001] ..s4   248.379561: 0: key 2 remote ip
0xac100164 geneve class 0x0
     kworker/1:2-1480  [001] ..s4   248.379605: 0: key 2 remote ip
0xac100164 geneve class 0x0
          <idle>-0     [001] ..s3   248.459429: 0: key 2 remote ip
0xac100164 geneve class 0x0
            ping-3887  [002] ..s3   248.832187: 0: key 2 remote ip
0xac100164 geneve class 0x0
            ping-3888  [000] ..s3   248.874871: 0: key 2 remote ip
0xac100164 geneve class 0x0
            ping-3888  [000] ..s3   249.875339: 0: key 2 remote ip
0xac100164 geneve class 0x0
            ping-3888  [000] ..s3   250.875805: 0: key 2 remote ip
0xac100164 geneve class 0x0
            ping-4118  [002] ..s3   256.654930: 0: remote ip 0xac100164
            ping-4118  [002] ..s3   257.655393: 0: remote ip 0xac100164
            ping-4118  [002] ..s3   258.655851: 0: remote ip 0xac100164
            ping-4119  [000] ..s3   258.695970: 0: remote ip 0xac100164
            ping-4119  [000] ..s3   259.696426: 0: remote ip 0xac100164
            ping-4119  [000] ..s3   260.696886: 0: remote ip 0xac100164
            ping-4367  [003] ..s3   270.047776: 0: reqid 1 spi 0x1
remote ip 0xac100164
     ksoftirqd/3-26    [003] ..s2   271.048427: 0: reqid 1 spi 0x1
remote ip 0xac100164
            ping-4367  [003] ..s3   272.048870: 0: reqid 1 spi 0x1
remote ip 0xac100164
[0;92mPASS: xfrm tunnel[0m
