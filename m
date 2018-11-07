Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE6EFC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 12:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71D8620827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 12:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nkwAn+hr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71D8620827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbeKGWX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 17:23:28 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:44412 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbeKGWX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 17:23:28 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wA7CmZjl167292;
        Wed, 7 Nov 2018 12:53:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=1xIIUn1G7zJZ0cC+cT8PkosDZNtNIeMygkeaDrYdXFQ=;
 b=nkwAn+hrfpKR20TJsvl5iAzd/max+FbKpgCK/O7fJLNLTXVsaguEtIw3iPpgw0Y8oSgS
 2SIQ0B27VNXENxWyNq4nCVw96m5FZq6Yow8HIFiiJprX2FB8UgYX0N2cbaox0Fk2cBTE
 GnzKoObjntzAAB7rJtAp4VNWEuu4QWewNscaxdunhNBe4K9/k8XXlXTbMASuUuD270bo
 59n8Jp+ijL5Ve37F7MVzkvNlYQqcYR5SlgyTK26vQwKAVl25hqfiljY7oHR93BAPfyUq
 ErUM6EwLMSK0F8mt4Umv5FOzSfUk+8bAjUoAZApm8nQRxenmeqlyjD4hxN6ZrKbi9zFI uw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2nh4aqu5fx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Nov 2018 12:53:03 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wA7Cqw72015770
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 7 Nov 2018 12:52:58 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wA7CqvPi023703;
        Wed, 7 Nov 2018 12:52:57 GMT
Received: from lirans-mbp.ravello.local (/213.57.127.2)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 07 Nov 2018 04:52:57 -0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Subject: Re: KMSAN: kernel-infoleak in kvm_vcpu_write_guest_page
From:   Liran Alon <liran.alon@oracle.com>
In-Reply-To: <CAG_fn=Wmc+YU8BMcY_RXxAvVTpAMez5QUFyQSH3UsRg4Y-ZwMQ@mail.gmail.com>
Date:   Wed, 7 Nov 2018 14:52:52 +0200
Cc:     syzbot+ded1696f6b50b615b630@syzkaller.appspotmail.com,
        kvm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        pbonzini@redhat.com, rkrcmar@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <47BA8A88-1446-4289-B14E-4032E8D99C7A@oracle.com>
References: <0000000000005de8da057a092ba2@google.com>
 <CAG_fn=Wmc+YU8BMcY_RXxAvVTpAMez5QUFyQSH3UsRg4Y-ZwMQ@mail.gmail.com>
To:     Alexander Potapenko <glider@google.com>
X-Mailer: Apple Mail (2.3445.4.7)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9069 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811070117
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 7 Nov 2018, at 14:10, Alexander Potapenko <glider@google.com> =
wrote:
>=20
> On Wed, Nov 7, 2018 at 2:38 AM syzbot
> <syzbot+ded1696f6b50b615b630@syzkaller.appspotmail.com> wrote:
>>=20
>> Hello,
>>=20
>> syzbot found the following crash on:
>>=20
>> HEAD commit:    88b95ef4c780 kmsan: use MSan assembly instrumentation
>> git tree:       =
https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__github.com_google_k=
msan.git_master&d=3DDwIFaQ&c=3DRoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE=
&r=3DJk6Q8nNzkQ6LJ6g42qARkg6ryIDGQr-yKXPNGZbpTx0&m=3DNpjK8vgD4UmRGNWTNe6YF=
A-AJTZp9VlD0oMFvKFV25I&s=3DA5G9_UvV5TpBoJitbGWS2VXmfVMXFUgggq64QM-6nqc&e=3D=

>> console output: =
https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__syzkaller.appspot.c=
om_x_log.txt-3Fx-3D12505e33400000&d=3DDwIFaQ&c=3DRoP1YumCXCgaWHvlZYR8PZh8B=
v7qIrMUB65eapI_JnE&r=3DJk6Q8nNzkQ6LJ6g42qARkg6ryIDGQr-yKXPNGZbpTx0&m=3DNpj=
K8vgD4UmRGNWTNe6YFA-AJTZp9VlD0oMFvKFV25I&s=3DZGVw04dRMjYdKZf4amN1yl3IheljZ=
Zq6V9h3mO9U-vM&e=3D
>> kernel config:  =
https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__syzkaller.appspot.c=
om_x_.config-3Fx-3D8df5fc509a1b351b&d=3DDwIFaQ&c=3DRoP1YumCXCgaWHvlZYR8PZh=
8Bv7qIrMUB65eapI_JnE&r=3DJk6Q8nNzkQ6LJ6g42qARkg6ryIDGQr-yKXPNGZbpTx0&m=3DN=
pjK8vgD4UmRGNWTNe6YFA-AJTZp9VlD0oMFvKFV25I&s=3DOUIhmSMzBSMhswtebZqyLnc6SkA=
agVPBGr0EmCLL2Fg&e=3D
>> dashboard link: =
https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__syzkaller.appspot.c=
om_bug-3Fextid-3Dded1696f6b50b615b630&d=3DDwIFaQ&c=3DRoP1YumCXCgaWHvlZYR8P=
Zh8Bv7qIrMUB65eapI_JnE&r=3DJk6Q8nNzkQ6LJ6g42qARkg6ryIDGQr-yKXPNGZbpTx0&m=3D=
NpjK8vgD4UmRGNWTNe6YFA-AJTZp9VlD0oMFvKFV25I&s=3DjeCou6OWbHHIf190FBGsLr1wGs=
DvBWlpKnfNMmqGIqI&e=3D
>> compiler:       clang version 8.0.0 (trunk 343298)
>> syz repro:      =
https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__syzkaller.appspot.c=
om_x_repro.syz-3Fx-3D15ce62f5400000&d=3DDwIFaQ&c=3DRoP1YumCXCgaWHvlZYR8PZh=
8Bv7qIrMUB65eapI_JnE&r=3DJk6Q8nNzkQ6LJ6g42qARkg6ryIDGQr-yKXPNGZbpTx0&m=3DN=
pjK8vgD4UmRGNWTNe6YFA-AJTZp9VlD0oMFvKFV25I&s=3DPVi1m-uNP3XRO4XbDZJicGiqXdV=
mOPFDxCP20jmXuAs&e=3D
>> C reproducer:   =
https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__syzkaller.appspot.c=
om_x_repro.c-3Fx-3D174efca3400000&d=3DDwIFaQ&c=3DRoP1YumCXCgaWHvlZYR8PZh8B=
v7qIrMUB65eapI_JnE&r=3DJk6Q8nNzkQ6LJ6g42qARkg6ryIDGQr-yKXPNGZbpTx0&m=3DNpj=
K8vgD4UmRGNWTNe6YFA-AJTZp9VlD0oMFvKFV25I&s=3DXzvJtd3__2LEBvhAi4F6RTLbxV9mE=
LkY07bMDSDLRMc&e=3D
>>=20
>> IMPORTANT: if you fix the bug, please add the following tag to the =
commit:
>> Reported-by: syzbot+ded1696f6b50b615b630@syzkaller.appspotmail.com
>>=20
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> BUG: KMSAN: kernel-infoleak in __copy_to_user =
include/linux/uaccess.h:121
>> [inline]
>> BUG: KMSAN: kernel-infoleak in __kvm_write_guest_page
>> arch/x86/kvm/../../../virt/kvm/kvm_main.c:1849 [inline]
>> BUG: KMSAN: kernel-infoleak in kvm_vcpu_write_guest_page+0x39a/0x510
>> arch/x86/kvm/../../../virt/kvm/kvm_main.c:1870
>> CPU: 0 PID: 7918 Comm: syz-executor542 Not tainted 4.19.0+ #77
>> Hardware name: Google Google Compute Engine/Google Compute Engine, =
BIOS
>> Google 01/01/2011
>> Call Trace:
>>  __dump_stack lib/dump_stack.c:77 [inline]
>>  dump_stack+0x32d/0x480 lib/dump_stack.c:113
>>  kmsan_report+0x1a2/0x2e0 mm/kmsan/kmsan.c:911
>>  kmsan_internal_check_memory+0x34c/0x430 mm/kmsan/kmsan.c:991
>>  kmsan_copy_to_user+0x85/0xe0 mm/kmsan/kmsan_hooks.c:552
>>  __copy_to_user include/linux/uaccess.h:121 [inline]
>>  __kvm_write_guest_page =
arch/x86/kvm/../../../virt/kvm/kvm_main.c:1849
>> [inline]
>>  kvm_vcpu_write_guest_page+0x39a/0x510
>> arch/x86/kvm/../../../virt/kvm/kvm_main.c:1870
>>  nested_release_vmcs12 arch/x86/kvm/vmx.c:8441 [inline]
>>  handle_vmptrld+0x2384/0x26b0 arch/x86/kvm/vmx.c:8907
>>  vmx_handle_exit+0x1e81/0xbac0 arch/x86/kvm/vmx.c:10128
>>  vcpu_enter_guest arch/x86/kvm/x86.c:7667 [inline]
>>  vcpu_run arch/x86/kvm/x86.c:7730 [inline]
>>  kvm_arch_vcpu_ioctl_run+0xac32/0x11d80 arch/x86/kvm/x86.c:7930
>>  kvm_vcpu_ioctl+0xfb1/0x1f90 =
arch/x86/kvm/../../../virt/kvm/kvm_main.c:2590
>>  do_vfs_ioctl+0xf77/0x2d30 fs/ioctl.c:46
>>  ksys_ioctl fs/ioctl.c:702 [inline]
>>  __do_sys_ioctl fs/ioctl.c:709 [inline]
>>  __se_sys_ioctl+0x1da/0x270 fs/ioctl.c:707
>>  __x64_sys_ioctl+0x4a/0x70 fs/ioctl.c:707
>>  do_syscall_64+0xcf/0x110 arch/x86/entry/common.c:291
>>  entry_SYSCALL_64_after_hwframe+0x63/0xe7
>> RIP: 0033:0x44b6e9
>> Code: e8 dc e6 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 =
89 f7
>> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 =
f0 ff
>> ff 0f 83 2b ff fb ff c3 66 2e 0f 1f 84 00 00 00 00
>> RSP: 002b:00007f096b292ce8 EFLAGS: 00000206 ORIG_RAX: =
0000000000000010
>> RAX: ffffffffffffffda RBX: 00000000006e3c48 RCX: 000000000044b6e9
>> RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 0000000000000005
>> RBP: 00000000006e3c40 R08: 0000000000000000 R09: 0000000000000000
>> R10: 0000000000000000 R11: 0000000000000206 R12: 00000000006e3c4c
>> R13: 00007ffd978aeb2f R14: 00007f096b2939c0 R15: 00000000006e3d4c
>>=20
>> Uninit was created at:
>>  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:252 [inline]
>>  kmsan_internal_poison_shadow+0xc8/0x1e0 mm/kmsan/kmsan.c:177
>>  kmsan_kmalloc+0x98/0x110 mm/kmsan/kmsan_hooks.c:104
>>  __kmalloc+0x14c/0x4d0 mm/slub.c:3789
>>  kmalloc include/linux/slab.h:518 [inline]
>>  enter_vmx_operation+0x980/0x1a90 arch/x86/kvm/vmx.c:8278
>>  vmx_set_nested_state+0xc3a/0x1530 arch/x86/kvm/vmx.c:14045
>>  kvm_arch_vcpu_ioctl+0x4fc9/0x73a0 arch/x86/kvm/x86.c:4057
>>  kvm_vcpu_ioctl+0xca3/0x1f90 =
arch/x86/kvm/../../../virt/kvm/kvm_main.c:2742
>>  do_vfs_ioctl+0xf77/0x2d30 fs/ioctl.c:46
>>  ksys_ioctl fs/ioctl.c:702 [inline]
>>  __do_sys_ioctl fs/ioctl.c:709 [inline]
>>  __se_sys_ioctl+0x1da/0x270 fs/ioctl.c:707
>>  __x64_sys_ioctl+0x4a/0x70 fs/ioctl.c:707
>>  do_syscall_64+0xcf/0x110 arch/x86/entry/common.c:291
>>  entry_SYSCALL_64_after_hwframe+0x63/0xe7
>>=20
>> Bytes 1000-4095 of 4096 are uninitialized
>> Memory access of size 4096 starts at ffff8801b5157000
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> This appears to be a real bug in KVM.
> Please see a simplified reproducer attached.

If I understand the above trace correctly:
1) When guest enters VMX operation, cached_vmcs12 is allocated in =
enter_vmx_operation() by kmalloc()
2) When guest will execute VMPTRLD, handle_vmptrld() will first release =
current vmcs12 by nested_release_vmcs12()
    and only then copy newly loaded vmcs12 to cached_vmcs12 by memcpy().
3) The bug theoretically is that nested_release_vmcs12() copies entire =
cached_vmcs12 to guest memory which is
     not initialised in case this is the very first VMPTRLD executed by =
guest.
     But this case should not happen because nested_release_vmcs12() =
starts by checking if current_vmptr is equal to -1
     and vmx_create_vcpu() set current_vmptr to -1ull.
    =20
However, one case where (3) could happen is by vmx_set_nested_state().
In case kvm_state->vmx.vmcs_pa is valid, set_current_vmptr() is called =
which sets current_vmptr.
However, it is possible that copy_from_user() which copies into =
cached_vmcs12 will fail.
Thus, leaving us with current_vmptr !=3D -1 but with uninitialised =
cached_vmcs12.
Therefore, next VMPTRLD will indeed leak into guest the uninitialised =
content of cached_vmcs12.

What I described seems to be a bug to me (correct me if I=E2=80=99m =
wrong) but it doesn=E2=80=99t seem to be the
same issue described here as we can see that attached reproducer don=E2=80=
=99t use KVM_SET_NESTED_STATE ioctl.

-Liran

