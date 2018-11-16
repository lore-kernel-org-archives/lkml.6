Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D77FFC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 23:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FC2D2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 23:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kf6woFpW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FC2D2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730479AbeKQJOd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 04:14:33 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:38446 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727161AbeKQJOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 04:14:33 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAGMsO3L034372;
        Fri, 16 Nov 2018 22:59:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=PKuJsx3pd9bzZjxtP0beQW6NluNjtX+doLij+sdRFw8=;
 b=kf6woFpWs8L1jpqfqDypXTjF5zbsc3YmkoxEKhixZSJfT/obmEQ8kb/SRltxYasMgRR+
 hAut6d2PdIzXaoz99rWbvrJpBxctVVnPETb8t4NWfIziuRffqbUa5ig8p8QcwCIeCZb7
 H3JevWD7A4wmJVKfvFr8KNnlIcNDjIVQeinF7VLFRQ+nGaBQIb/lUlZQEDw91utVTXu/
 w9cpvxCvsVIsbQ9xMr1hB/wlH06C8AemGmeig2WzpzZtcOw18f70IW5XWlDx2urN5FcU
 2x7SuWRsx/x74qZbknWLoBT56M2o4NwaVVnIOqxUB90o/YAY0i3eWwQCuR/KJrsUrAKZ ag== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2nr7cshkj9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Nov 2018 22:59:45 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wAGMxiXK019052
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Nov 2018 22:59:44 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wAGMxiZx030063;
        Fri, 16 Nov 2018 22:59:44 GMT
Received: from [10.0.0.41] (/79.176.109.236)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 16 Nov 2018 14:59:43 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Subject: Re: KMSAN: kernel-infoleak in kvm_arch_vcpu_ioctl
From:   Liran Alon <liran.alon@oracle.com>
In-Reply-To: <000000000000535c70057acf6a48@google.com>
Date:   Sat, 17 Nov 2018 00:59:39 +0200
Cc:     bp@alien8.de, hpa@zytor.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        pbonzini@redhat.com, rkrcmar@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <8BD8E2E5-5F9A-4FD5-9EA1-9EF09073DD56@oracle.com>
References: <000000000000535c70057acf6a48@google.com>
To:     syzbot <syzbot+cfbc368e283d381f8cef@syzkaller.appspotmail.com>
X-Mailer: Apple Mail (2.3445.4.7)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9079 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811160203
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 17 Nov 2018, at 0:09, syzbot =
<syzbot+cfbc368e283d381f8cef@syzkaller.appspotmail.com> wrote:
>=20
> Hello,
>=20
> syzbot found the following crash on:
>=20
> HEAD commit:    006aa39cddee kmsan: don't instrument fixup_bad_iret()
> git tree:       =
https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__github.com_google_k=
msan.git_master&d=3DDwIBaQ&c=3DRoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE=
&r=3DJk6Q8nNzkQ6LJ6g42qARkg6ryIDGQr-yKXPNGZbpTx0&m=3D6-j0bZwOIu2D7UVtppvdF=
zCPoDvVU1l3ExqVO_Po11o&s=3DqBVZxFprJcGeWFBppSXwwkTrx3u7E8vv78UxFb1N2yM&e=3D=

> console output: =
https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__syzkaller.appspot.c=
om_x_log.txt-3Fx-3D101dcb0b400000&d=3DDwIBaQ&c=3DRoP1YumCXCgaWHvlZYR8PZh8B=
v7qIrMUB65eapI_JnE&r=3DJk6Q8nNzkQ6LJ6g42qARkg6ryIDGQr-yKXPNGZbpTx0&m=3D6-j=
0bZwOIu2D7UVtppvdFzCPoDvVU1l3ExqVO_Po11o&s=3Dm7FuREmXFg2ZHCkPmLKPCIrMU2Pw0=
zlAPdkpQXTtmHs&e=3D
> kernel config:  =
https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__syzkaller.appspot.c=
om_x_.config-3Fx-3Df388ea1732f3c473&d=3DDwIBaQ&c=3DRoP1YumCXCgaWHvlZYR8PZh=
8Bv7qIrMUB65eapI_JnE&r=3DJk6Q8nNzkQ6LJ6g42qARkg6ryIDGQr-yKXPNGZbpTx0&m=3D6=
-j0bZwOIu2D7UVtppvdFzCPoDvVU1l3ExqVO_Po11o&s=3DvvmEqhqn8-cl-D88zy6BsN9exSD=
vIKxVRopXWs0hIYE&e=3D
> dashboard link: =
https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__syzkaller.appspot.c=
om_bug-3Fextid-3Dcfbc368e283d381f8cef&d=3DDwIBaQ&c=3DRoP1YumCXCgaWHvlZYR8P=
Zh8Bv7qIrMUB65eapI_JnE&r=3DJk6Q8nNzkQ6LJ6g42qARkg6ryIDGQr-yKXPNGZbpTx0&m=3D=
6-j0bZwOIu2D7UVtppvdFzCPoDvVU1l3ExqVO_Po11o&s=3DHTwepMOiTfeo-sYvcbfkdwY3-D=
ouLgzz3XT6a26qLhM&e=3D
> compiler:       clang version 8.0.0 (trunk 343298)
> syz repro:      =
https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__syzkaller.appspot.c=
om_x_repro.syz-3Fx-3D10c56fbd400000&d=3DDwIBaQ&c=3DRoP1YumCXCgaWHvlZYR8PZh=
8Bv7qIrMUB65eapI_JnE&r=3DJk6Q8nNzkQ6LJ6g42qARkg6ryIDGQr-yKXPNGZbpTx0&m=3D6=
-j0bZwOIu2D7UVtppvdFzCPoDvVU1l3ExqVO_Po11o&s=3DN7ZWdZk1M360lcHmoXIX8utlbcj=
YLe7MPu_Gxe3sLBU&e=3D
> C reproducer:   =
https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__syzkaller.appspot.c=
om_x_repro.c-3Fx-3D153c8a47400000&d=3DDwIBaQ&c=3DRoP1YumCXCgaWHvlZYR8PZh8B=
v7qIrMUB65eapI_JnE&r=3DJk6Q8nNzkQ6LJ6g42qARkg6ryIDGQr-yKXPNGZbpTx0&m=3D6-j=
0bZwOIu2D7UVtppvdFzCPoDvVU1l3ExqVO_Po11o&s=3DY_PwncNZIx_yxjGLefhRu5GpOYmjC=
qOloLFHGxsH7eQ&e=3D
>=20
> IMPORTANT: if you fix the bug, please add the following tag to the =
commit:
> Reported-by: syzbot+cfbc368e283d381f8cef@syzkaller.appspotmail.com
>=20
> IPVS: ftp: loaded support on port[0] =3D 21
> L1TF CPU bug present and SMT on, data leak possible. See CVE-2018-3646 =
and =
https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__www.kernel.org_doc_=
html_latest_admin-2Dguide_l1tf.html&d=3DDwIBaQ&c=3DRoP1YumCXCgaWHvlZYR8PZh=
8Bv7qIrMUB65eapI_JnE&r=3DJk6Q8nNzkQ6LJ6g42qARkg6ryIDGQr-yKXPNGZbpTx0&m=3D6=
-j0bZwOIu2D7UVtppvdFzCPoDvVU1l3ExqVO_Po11o&s=3DW59LMRxHTTYAxlGlzLxWOuioL5Z=
6ousHYqJPO5KJuDI&e=3D for details.
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KMSAN: kernel-infoleak in _copy_to_user+0x19a/0x230 =
lib/usercopy.c:31
> CPU: 0 PID: 6697 Comm: syz-executor853 Not tainted 4.20.0-rc2+ #85
> Hardware name: Google Google Compute Engine/Google Compute Engine, =
BIOS Google 01/01/2011
> Call Trace:
> __dump_stack lib/dump_stack.c:77 [inline]
> dump_stack+0x32d/0x480 lib/dump_stack.c:113
> kmsan_report+0x19f/0x300 mm/kmsan/kmsan.c:911
> kmsan_internal_check_memory+0x35b/0x3b0 mm/kmsan/kmsan.c:993
> kmsan_copy_to_user+0x7c/0xe0 mm/kmsan/kmsan_hooks.c:552
> _copy_to_user+0x19a/0x230 lib/usercopy.c:31
> copy_to_user include/linux/uaccess.h:183 [inline]
> kvm_vcpu_ioctl_enable_cap arch/x86/kvm/x86.c:3834 [inline]
> kvm_arch_vcpu_ioctl+0x5dee/0x7680 arch/x86/kvm/x86.c:4132
> kvm_vcpu_ioctl+0xca3/0x1f90 =
arch/x86/kvm/../../../virt/kvm/kvm_main.c:2748
> do_vfs_ioctl+0xfbc/0x2f70 fs/ioctl.c:46
> ksys_ioctl fs/ioctl.c:713 [inline]
> __do_sys_ioctl fs/ioctl.c:720 [inline]
> __se_sys_ioctl+0x1da/0x270 fs/ioctl.c:718
> __x64_sys_ioctl+0x4a/0x70 fs/ioctl.c:718
> do_syscall_64+0xcf/0x110 arch/x86/entry/common.c:291
> entry_SYSCALL_64_after_hwframe+0x63/0xe7
> RIP: 0033:0x4471b9
> Code: e8 fc b9 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 =
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d =
01 f0 ff ff 0f 83 3b 07 fc ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007f1e22946da8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00000000006f0038 RCX: 00000000004471b9
> RDX: 0000000020000000 RSI: 000000004068aea3 RDI: 0000000000000005
> RBP: 00000000006f0030 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006f003c
> R13: 6d766b2f7665642f R14: 00007f1e229479c0 R15: 00000000000003e8
>=20
> Local variable description: ----__pu_val@kvm_arch_vcpu_ioctl
> Variable was created at:
> kvm_arch_vcpu_ioctl+0x29d/0x7680 arch/x86/kvm/x86.c:3848
> kvm_vcpu_ioctl+0xca3/0x1f90 =
arch/x86/kvm/../../../virt/kvm/kvm_main.c:2748
>=20
> Bytes 0-1 of 2 are uninitialized
> Memory access of size 2 starts at ffff8881967ffbb0
> Data copied to user address 0000000000706000
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20

The info-leak bug is very simple, What happens is the following:
1) kvm_vcpu_ioctl_enable_cap() is called to enable =
KVM_CAP_HYPERV_ENLIGHTENED_VMCS which calls nested_enable_evmcs().
2) nested_enable_evmcs() sets enlightened_vmcs_enabled =3D true and =
fills up vmcs_version.
3) kvm_vcpu_ioctl_enable_cap() is called again to enable =
KVM_CAP_HYPERV_ENLIGHTENED_VMCS which calls nested_enable_evmcs().
4) This time nested_enable_evmcs() just returns 0 as =
enlightened_vmcs_enabled is already true. Without filling vmcs_version!
5) kvm_vcpu_ioctl_enable_cap() continues as usual and returns =
uninitialised vmcs_version to userspace which leads to kernel info-leak.

I will create a patch to fix this by changing nested_enable_evmcs() to =
always fill up vmcs_version field.

-Liran


